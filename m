Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42233C66ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 01:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGLX2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 19:28:18 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:35475 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhGLX2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:28:17 -0400
Received: by mail-ej1-f41.google.com with SMTP id gn32so37901460ejc.2;
        Mon, 12 Jul 2021 16:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=H563yEm0J6K2K6xru5IzDuO+9clWz/y4OULndG63lZQ=;
        b=n3MNN9LgrB6upN2PCZ08rT18zBbSrAtu0LV3s6pRBSkNAPPS1ykZlZ+G6NlhUwc2g5
         JxHEhHYCI/HUk9iMHjtPIW8NogqQ2ZY0gonBF7kEhRWZTZWmrbfjZTRRR9lPJ1TShZ+2
         aH1L2vCk7OF+k5SWgfFs9oGtCvmLgzYPTscqY1hWyl4vgsqAa+MOkeDCpOBzXwIEdqA6
         14/qEyyhqzKB1iBgqHKBv7bJ06W9bh5elcx5Vt+KsViRdlKgsqeL/Vm/3mGngHp+sccU
         hUreb142lSZOuKgT+6asjUtD4H3ajVJUeyDDlYgwi16Ljc8dU95NC62sH474MoigEbeW
         dgYg==
X-Gm-Message-State: AOAM5318u2xfy53AY/hqBrB9SA20cYmWyGZmPjTJNSZ2xHbRvfAsjWk4
        lzLvby3wXVJr/LZZZDaw/r0=
X-Google-Smtp-Source: ABdhPJzOxmMx2OGBYBjWUtpT596k9B7h1Eu/IV82RZK7jMwhWkMSvM5AZYmuqHZnWd0REitXiUH1RQ==
X-Received: by 2002:a17:906:2dc4:: with SMTP id h4mr1727419eji.528.1626132327523;
        Mon, 12 Jul 2021 16:25:27 -0700 (PDT)
Received: from localhost (host-95-250-115-52.retail.telecomitalia.it. [95.250.115.52])
        by smtp.gmail.com with ESMTPSA id p23sm8910919edw.94.2021.07.12.16.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:25:26 -0700 (PDT)
Date:   Tue, 13 Jul 2021 01:25:22 +0200
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lennart Poettering" <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier =?UTF-8?B?R29uesOhbGV6?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v4 3/5] block: add ioctl to read the disk sequence
 number
Message-ID: <20210713012522.70abe32e@linux.microsoft.com>
In-Reply-To: <TU4PR8401MB10558BB52D2F37CFC96FB8B8AB159@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210711175415.80173-1-mcroce@linux.microsoft.com>
        <20210711175415.80173-4-mcroce@linux.microsoft.com>
        <TU4PR8401MB10558BB52D2F37CFC96FB8B8AB159@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
Organization: Microsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Jul 2021 19:22:43 +0000
"Elliott, Robert (Servers)" <elliott@hpe.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Matteo Croce <mcroce@linux.microsoft.com>
> > Sent: Sunday, July 11, 2021 12:54 PM
> ...
> > Subject: [PATCH v4 3/5] block: add ioctl to read the disk sequence
> > number
> > 
> > From: Matteo Croce <mcroce@microsoft.com>
> > 
> > Add a new BLKGETDISKSEQ ioctl which retrieves the disk sequence
> > number from the genhd structure.
> ...
> 
> 
> Given:
>     static int put_u64(u64 __user *argp, u64 val)
>     {
>         return put_user(val, argp);
>     }
> 
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index 24beec9ca9c9..0c3a4a53fa11 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -469,6 +469,8 @@ static int blkdev_common_ioctl(struct
> > block_device *bdev, fmode_t mode,
> >  				BLKDEV_DISCARD_SECURE);
> ...
> 
> > +	case BLKGETDISKSEQ:
> > +		return put_u64(argp, bdev->bd_disk->diskseq);
> 
> How does that work on a system in which int is 32 bits?
> 
> 

Hi,

what's the difference with this?

	case BLKGETSIZE64:
		return put_u64(argp, i_size_read(bdev->bd_inode));

The returned int is an error code, not the diskseq value itself, e.g.

	case BLKFRAGET:
		if (!argp)
			return -EINVAL;

Regards,
-- 
per aspera ad upstream
