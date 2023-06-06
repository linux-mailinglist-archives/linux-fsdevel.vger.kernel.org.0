Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686C672506D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbjFFW7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbjFFW7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:59:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08191725
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:59:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30d181952a2so4654716f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686092369; x=1688684369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzrxvHE7NOsDG+KS0tlYsM4OII1tBEP7fRMkD9ta1LM=;
        b=dPBbqXFS82u/OyXTZWp6fXeJmGza5q6dVa5qz3VIcZuY3ttrTYxwiWgluNlWkTlMHS
         nr1NagSevnp3gcPfL+kiCiB3WIarpN0pgeCvHxSkBKjcjt+hu5N1Ft+/6M9I8wrHDoyn
         9ycgq/Rw7NnFSNhYqDYV0c86KZdoApl9s6kWkF+s0hGgLYcofhqvB8kmW/BZ+LKMR//A
         gwuJ0w+LXlMxibiExmvI39ydW+5R96o5Dj5hVb4IzQeS/zsCQmqqjO7QkeXRJL2RSe4t
         6PrHCQqgVj8mU9U37sOH8TIm5TIb7ksdihwA/BJR/rIS7FZXiO40utLCY94h1/n/iUKk
         stqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686092369; x=1688684369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzrxvHE7NOsDG+KS0tlYsM4OII1tBEP7fRMkD9ta1LM=;
        b=ik9EfwtWeocJvwDT359rH1ehrWKvuQDkEj5BEZfN36AXqOzr+mqvtu9GA3elBTKpq7
         Dje2ofB6faQrvnm1JjfRXEOGL9nHviXdnQhwT6ksiW6EOtxIye26wFamh2fQHZmHs0VS
         lRcY/0OrpEEHgutF5hsNoGfLqYnxFqjW4NtB7lth+LSQ1IfxBEgIR45+gEL7Nn4wsY8T
         zDCCY1bCUUzKYXBU0A4+pGpPUXsfQ758gKqPv38Kr6T8huKFCN7EeazY9dcX/jaJOblo
         VbwtGHmkxqR78Mk5D8A3DQkRitNM5wTEfe6enHP1MVsSfH03lrmyg3eeoqWaJRjLYiYL
         rqyA==
X-Gm-Message-State: AC+VfDxJu2z66PexcAZr9wrJ5hfsLoJCeu7Lra9qQYiXN5FM9OVqrWci
        X1P1IvMklY+fMOEYK9VOqLnz0w==
X-Google-Smtp-Source: ACHHUZ5dEmrYamI1Roz1b/XXwx7e2SyRLgLDxBk8a4qqwZElHaxX8CqOd+UmcQ9YIORhk7TJQYcx6A==
X-Received: by 2002:adf:ff8e:0:b0:30e:412a:841b with SMTP id j14-20020adfff8e000000b0030e412a841bmr2765794wrr.37.1686092369334;
        Tue, 06 Jun 2023 15:59:29 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d470e000000b002fed865c55esm13607049wrq.56.2023.06.06.15.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:59:28 -0700 (PDT)
Date:   Tue, 6 Jun 2023 23:59:27 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/31] cdrom: track if a cdrom_device_info was opened for
 data
Message-ID: <ZH+6T/ibWkjSrWdt@equinox>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-6-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:24AM +0200, Christoph Hellwig wrote:
> Set a flag when a cdrom_device_info is opened for writing, instead of
> trying to figure out this at release time.  This will allow to eventually
> remove the mode argument to the ->release block_device_operation as
> nothing but the CDROM drivers uses that argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/cdrom/cdrom.c | 12 +++++-------
>  include/linux/cdrom.h |  1 +
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 08abf1ffede002..adebac1bd210d9 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -1172,6 +1172,7 @@ int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode)
>  			ret = 0;
>  			cdi->media_written = 0;
>  		}
> +		cdi->opened_for_data = true;
>  	}
>  
>  	if (ret)
> @@ -1252,7 +1253,6 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
>  void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
>  {
>  	const struct cdrom_device_ops *cdo = cdi->ops;
> -	int opened_for_data;
>  
>  	cd_dbg(CD_CLOSE, "entering cdrom_release\n");
>  
> @@ -1270,14 +1270,12 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
>  		}
>  	}
>  
> -	opened_for_data = !(cdi->options & CDO_USE_FFLAGS) ||
> -		!(mode & FMODE_NDELAY);
> -
>  	cdo->release(cdi);
> -	if (cdi->use_count == 0) {      /* last process that closes dev*/
> -		if (opened_for_data &&
> -		    cdi->options & CDO_AUTO_EJECT && CDROM_CAN(CDC_OPEN_TRAY))
> +
> +	if (cdi->use_count == 0 && cdi->opened_for_data) {
> +		if (cdi->options & CDO_AUTO_EJECT && CDROM_CAN(CDC_OPEN_TRAY))
>  			cdo->tray_move(cdi, 1);
> +		cdi->opened_for_data = false;
>  	}
>  }
>  EXPORT_SYMBOL(cdrom_release);
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index 0a5db0b0c958a1..385e94732b2cf1 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -64,6 +64,7 @@ struct cdrom_device_info {
>  	int (*exit)(struct cdrom_device_info *);
>  	int mrw_mode_page;
>  	__s64 last_media_change_ms;
> +	bool opened_for_data;
>  };
>  
>  struct cdrom_device_ops {
> -- 
> 2.39.2
> 

Looks good, thanks.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
