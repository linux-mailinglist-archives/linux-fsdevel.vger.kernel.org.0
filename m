Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A3E262CC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgIIKEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 06:04:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42216 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIIKEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599645844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xgpe6AT0UH4aDp5ykLA0ugjbjmAIMFTMCg4Q4aJi8W4=;
        b=Vd3ovocJr3KP/y3PxSMBQiH9PK5hxQtJLCMWj1mkgeKw14Gh7xeXwju3MCReU1GwN9oErO
        jv9qIYcflzIk5sTGYTQ90rz8VG9Kh9FwLrvoym6L6Z/yX6WKqn2jdNX2XHAqNkpjDGJyJF
        uqq9C5XrFlZ2gD2bF/ItQmSAIw/HQ6g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-ds6skS2zN0O80nEFYzwcjQ-1; Wed, 09 Sep 2020 06:04:00 -0400
X-MC-Unique: ds6skS2zN0O80nEFYzwcjQ-1
Received: by mail-wm1-f72.google.com with SMTP id 23so645112wmk.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 03:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xgpe6AT0UH4aDp5ykLA0ugjbjmAIMFTMCg4Q4aJi8W4=;
        b=QOOsAfd4RwIVRtTP3rTiwtp0By+cU881nE1N/6/rOHkA/WQMB0thGagycIRUnRu2x4
         J+ZtdnCw4vxKF9dE7VydiqN9rSaxiLW/ZKMcotNJ31MjvT+2QX+eZJIsbOxSMiVpDaEZ
         h9v4kB7gsZmhvr0Lc3Cp9EHT1je1+fCF1N9Iq6SyFRhbYHwTYFWpZ7BIG1glyhBV0NyD
         LsEoDY6dWuPktvNRQEGJcAiBKjd8/7M+s0peSjyjoB4SYIGzR0rD1WE0v2n+HWZIu0Mp
         WJxiX1eyQViMmm4FFQaJ+tYqnfWCrDCkuhbrIBBYpUzyGf2nQcMLBQrcdWTOR67ab4S4
         fC0g==
X-Gm-Message-State: AOAM531jqaWF5uz/K6oZBcX4zUVsOfVT50Qz1xlI9lv6KLSwmpgbJm28
        GiaT4+Pqi1PCjwu0QJizjdvSn6aGabN3XpfATUo9298La4joJmPcropFmRWqkSGoRrb7X1iVXV9
        BgCNPItjOyldOEPiI3njzse159Q==
X-Received: by 2002:a5d:4d82:: with SMTP id b2mr3055064wru.232.1599645838889;
        Wed, 09 Sep 2020 03:03:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxzpk4/SFORo74kpPgFd3e7iurHZ1Y5Kodi+AuWqmcAZhebg/lKbKSiR2B2/p/oi5E2UOPzg==
X-Received: by 2002:a5d:4d82:: with SMTP id b2mr3055044wru.232.1599645838666;
        Wed, 09 Sep 2020 03:03:58 -0700 (PDT)
Received: from steredhat (host-79-53-225-185.retail.telecomitalia.it. [79.53.225.185])
        by smtp.gmail.com with ESMTPSA id y1sm3133255wma.36.2020.09.09.03.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 03:03:58 -0700 (PDT)
Date:   Wed, 9 Sep 2020 12:03:55 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     syzbot <syzbot+3c23789ea938faaef049@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: INFO: task hung in io_sq_thread_stop
Message-ID: <20200909100355.ibz4jc5ctnwbmy5v@steredhat>
References: <00000000000030a45905aedd879d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000030a45905aedd879d@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 09, 2020 at 01:49:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dff9f829 Add linux-next specific files for 20200908
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=112f880d900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3c23789ea938faaef049
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c082a5900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1474f5f9900000
> 
> Bisection is inconclusive: the first bad commit could be any of:
> 
> d730b1a2 io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
> 7ec3d1dd io_uring: allow disabling rings during the creation

I'm not sure it is related, but while rebasing I forgot to update the
right label in the error path.

Since the check of ring state is after the increase of ctx refcount, we
need to decrease it jumping to 'out' label instead of 'out_fput':
diff --git a/fs/io_uring.c b/fs/io_uring.c
index d00eb6bf6ce9..f35da516095a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -8649,7 +8649,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
                goto out_fput;

        if (ctx->flags & IORING_SETUP_R_DISABLED)
-               goto out_fput;
+               goto out;

        /*
         * For SQ polling, the thread will do all submissions and completions.

I'll send a patch ASAP and check if it solves this issue.

Thanks,
Stefano

