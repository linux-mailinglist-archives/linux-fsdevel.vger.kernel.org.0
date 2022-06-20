Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA36F5513C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbiFTJK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbiFTJKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:10:25 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F03B1CD;
        Mon, 20 Jun 2022 02:10:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z14so9793702pgh.0;
        Mon, 20 Jun 2022 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Odwyf8Ywf4dJzCccpp8HbtO6LKGtTKRVZ3ILeyTfGgc=;
        b=RkMtCUn7uWDFvdFTjSe5PC36+wbop3nPpcbspqHRQsNwtWV+KiloZ6GnhFzH2LiqaW
         MIMzkB3YTPoZkFXBOuyqtgBbZxd22VniHLcrFs1HhvJOo/tvNpr+65kNTxzO5NrksWCR
         dx1HiE+8TLlxgKRs2ke/aIXNiqx5jENBhYghZXpwDhAe3nEpM9inGxY/xAwu3Xk1bkjD
         Jxzlw4s+SUcMmsMMOR/RQcPASpm1XINoz8rNccQZ0KuvvWUMkkliWqiufVvnr3Wku0Z+
         mE8whmj+kUQBMdzOuZZtZlcStz8iyaUKqKGwf2uiUuJPDZWjO4rPClNZnTW2iRtz1aCC
         ptMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Odwyf8Ywf4dJzCccpp8HbtO6LKGtTKRVZ3ILeyTfGgc=;
        b=a8kmaSRhbt/S21lQ0s7RcNTr3m6YEVhlBFMgUPdcJ7Z6RQrJyE5I92971w2WQRefsL
         6K2zlg+YQGGhC8CoTrQGiSxatFRi+8tExCoMbi87GmVKa/oU9sSFYRyYcEYL9Um0jfqj
         qjyJWS/Oh93fkGbmTzOMhfcn78pRjfrp7V2cx9Pg87qj3VIq/yPWoE6XnupsWcv5zFNg
         B93H19O2/GaXTlMRIqF6S+GLLVjckJylFY9KbMW5oaeYIhemknjwJ99eZhIx8EUiSnz9
         BAS8MQ1CleHqll3sUXYG7nOCNIEka/VFFSZ+soJ+brBS8mhSwwy+oEpzWo2OUPYkNtPX
         nMkg==
X-Gm-Message-State: AJIora9NsN5teoIWNhhYVHuxXVQQbKammR6GMH0OcZNbvjZcSBSy9z21
        /b04Dw66p/C2eRjIjPjfVeL4+YS3FzU=
X-Google-Smtp-Source: AGRyM1vXxLDvOtzVxNBUOQMr7Klb29X+5+1nONVhDv+hJuoGAbXNC2eJLMg/y3lj2jgTc5XZFCal4Q==
X-Received: by 2002:a63:cd52:0:b0:3fe:30ec:825d with SMTP id a18-20020a63cd52000000b003fe30ec825dmr20949777pgj.82.1655716223870;
        Mon, 20 Jun 2022 02:10:23 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id c10-20020aa7952a000000b0050dc762819esm3351990pfp.120.2022.06.20.02.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:10:23 -0700 (PDT)
Date:   Mon, 20 Jun 2022 14:40:19 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCHv2 2/4] fs/ntfs: Drop useless return value of submit_bh
 from ntfs_submit_bh_for_read
Message-ID: <20220620091019.vrpnwdj7deirsncp@riteshh-domain>
References: <cover.1655715329.git.ritesh.list@gmail.com>
 <f53e945837f78c042bee5337352e2fa216d71a5a.1655715329.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53e945837f78c042bee5337352e2fa216d71a5a.1655715329.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+ linux-ntfs-dev@lists.sourceforge.net
(sorry about not cc'ing this in the first place)

On 22/06/20 02:34PM, Ritesh Harjani wrote:
> submit_bh always returns 0. This patch drops the useless return value of
> submit_bh from ntfs_submit_bh_for_read(). Once all of submit_bh callers are
> cleaned up, we can make it's return type as void.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
> ---
>  fs/ntfs/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index a8abe2296514..2389bfa654a2 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -532,12 +532,12 @@ static inline int __ntfs_grab_cache_pages(struct address_space *mapping,
>  	goto out;
>  }
>
> -static inline int ntfs_submit_bh_for_read(struct buffer_head *bh)
> +static inline void ntfs_submit_bh_for_read(struct buffer_head *bh)
>  {
>  	lock_buffer(bh);
>  	get_bh(bh);
>  	bh->b_end_io = end_buffer_read_sync;
> -	return submit_bh(REQ_OP_READ, 0, bh);
> +	submit_bh(REQ_OP_READ, 0, bh);
>  }
>
>  /**
> --
> 2.35.3
>
