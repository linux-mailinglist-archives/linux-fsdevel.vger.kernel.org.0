Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC82B2B48
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 05:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgKNEOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 23:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgKNEOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 23:14:24 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB5C0613D1;
        Fri, 13 Nov 2020 20:14:24 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id ei22so1362022pjb.2;
        Fri, 13 Nov 2020 20:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ak9Z1l1TkvbOtgFsetzln0895eIsRmakXDzE68q2O4=;
        b=qxoShV6P9GSVZKXXErWxnxEx2cEz6arVlGs7zrrZ2Gxe2TkGFsOhLT2udIbII7qoJj
         i5BSC5dcAEXRRJYixjEtPf4JZlcKArfS9ZCeHWh01DkRvBm7VBx8nNadObT3uhhViOeg
         6N2C8HGuQCcJTgAclljn3BNcnyFt/Xs5PGiqciWsNIbbS3hRl/+CwyspO7c4y/C0sS0D
         5OsjdcGHA5szKiKVogwXOVXEYpGWDbReqIM02Dsjrvd3h1r/oYXFkM3aPhGF1TA+wX1l
         rmKQkwJS7mvwr4g3B+7NJLfd0IuL/IeJrHEsMZCxKRRom2N2/7+BaT1/wpfOPaD6mfE1
         iRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ak9Z1l1TkvbOtgFsetzln0895eIsRmakXDzE68q2O4=;
        b=pjJxSHTLcZI4bgCtkOuWRepXwYoOR6fhDOA7XiJCrQzCS7ZNQ/l+XmMToCxBaezNrE
         hy2tY9k2ayomkzLeYN7XgenYXTyIPTNXWN3y/YMCovd/vfSjzfLZj4hQ9sVFjUUi9EBj
         TjCOGSQ6J6cue10HJeKTkLX4SLAfH4GpS5csjPMPL5OwBNOICOJvbqJBDCJ6etDcOZcE
         uDxJd4ACY2dAEXImiUdg0SWwQgg+oZw9cU0PG8DL4B1kA/E9utn6+YQRDBcLWCPMm8F5
         vtA4m+qD2OVOG5ufFZ7v4bhqP6kVaXxynlkI1vpk9uO+PwhUoXieh62z1CV+QgIJXF5i
         NG7A==
X-Gm-Message-State: AOAM531XBF+M1cIAsYy/fafrucWcsMPMXq8BEYEcf1RLdHTCrQfkDOCd
        ePP4AkglPI822VzuEw9acGw=
X-Google-Smtp-Source: ABdhPJzwBB4tFFx6AGCxXqRrOmu3+f/2qA1w5+xfI4yjoV9CgDg3nWU3RG5sqFI6TjGX7q4bT1IHMQ==
X-Received: by 2002:a17:90a:3ec6:: with SMTP id k64mr5858112pjc.113.1605327263659;
        Fri, 13 Nov 2020 20:14:23 -0800 (PST)
Received: from Ryzen-9-3900X.localdomain (ip68-98-75-144.ph.ph.cox.net. [68.98.75.144])
        by smtp.gmail.com with ESMTPSA id g7sm171326pjl.4.2020.11.13.20.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 20:14:22 -0800 (PST)
Date:   Fri, 13 Nov 2020 21:14:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201114041420.GA231@Ryzen-9-3900X.localdomain>
References: <20201110213253.GV3576660@ZenIV.linux.org.uk>
 <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
 <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk>
 <20201111222116.GA919131@ZenIV.linux.org.uk>
 <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk>
 <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114035453.GM3576660@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 14, 2020 at 03:54:53AM +0000, Al Viro wrote:
> On Fri, Nov 13, 2020 at 08:01:24PM -0700, Nathan Chancellor wrote:
> > Sure thing, it does trigger.
> > 
> > [    0.235058] ------------[ cut here ]------------
> > [    0.235062] WARNING: CPU: 15 PID: 237 at fs/seq_file.c:176 seq_read_iter+0x3b3/0x3f0
> > [    0.235064] CPU: 15 PID: 237 Comm: localhost Not tainted 5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #15
> > [    0.235065] RIP: 0010:seq_read_iter+0x3b3/0x3f0
> > [    0.235066] Code: ba 01 00 00 00 e8 6d d2 fc ff 4c 89 e7 48 89 ee 48 8b 54 24 10 e8 ad 8b 45 00 49 01 c5 48 29 43 18 48 89 43 10 e9 61 fe ff ff <0f> 0b e9 6f fc ff ff 0f 0b 45 31 ed e9 0d fd ff ff 48 c7 43 18 00
> > [    0.235067] RSP: 0018:ffff9c774063bd08 EFLAGS: 00010246
> > [    0.235068] RAX: ffff91a77ac01f00 RBX: ffff91a50133c348 RCX: 0000000000000001
> > [    0.235069] RDX: ffff9c774063bdb8 RSI: ffff9c774063bd60 RDI: ffff9c774063bd88
> > [    0.235069] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff91a50058b768
> > [    0.235070] R10: ffff91a7f79f0000 R11: ffffffffbc2c2030 R12: ffff9c774063bd88
> > [    0.235070] R13: ffff9c774063bd60 R14: ffff9c774063be48 R15: ffff91a77af58900
> > [    0.235072] FS:  000000000029c800(0000) GS:ffff91a7f7bc0000(0000) knlGS:0000000000000000
> > [    0.235073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.235073] CR2: 00007ab6c1fabad0 CR3: 000000037a004000 CR4: 0000000000350ea0
> > [    0.235074] Call Trace:
> > [    0.235077]  seq_read+0x127/0x150
> > [    0.235078]  proc_reg_read+0x42/0xa0
> > [    0.235080]  do_iter_read+0x14c/0x1e0
> > [    0.235081]  do_readv+0x18d/0x240
> > [    0.235083]  do_syscall_64+0x33/0x70
> > [    0.235085]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> *blink*
> 
> 	Lovely...  For one thing, it did *not* go through
> proc_reg_read_iter().  For another, it has hit proc_reg_read() with
> zero length, which must've been an iovec with zero ->iov_len in
> readv(2) arguments.  I wonder if we should use that kind of
> pathology (readv() with zero-length segment in the middle of
> iovec array) for regression tests...
> 
> 	OK...  First of all, since that kind of crap can happen,
> let's do this (incremental to be folded); then (and that's
> a separate patch) we ought to switch the proc_ops with ->proc_read
> equal to seq_read to ->proc_read_iter = seq_read_iter, so that
> those guys would not mess with seq_read() wrapper at all.
> 
> 	Finally, is there any point having do_loop_readv_writev()
> call any methods for zero-length segments?
> 
> 	In any case, the following should be folded into
> "fix return values of seq_read_iter()"; could you check if that
> fixes the problem you are seeing?
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 07b33c1f34a9..e66d6b8bae23 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -211,9 +211,9 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		m->count -= n;
>  		m->from += n;
>  		copied += n;
> -		if (!iov_iter_count(iter) || m->count)
> -			goto Done;
>  	}
> +	if (m->count || !iov_iter_count(iter))
> +		goto Done;
>  	/* we need at least one record in buffer */
>  	m->from = 0;
>  	p = m->op->start(m, &m->index);

Unfortunately that patch does not solve my issue. Is there any other
debugging I should add?

Cheers,
Nathan
