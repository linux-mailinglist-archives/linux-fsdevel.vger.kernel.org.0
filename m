Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34985FB4A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 17:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKMQId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 11:08:33 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40320 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfKMQId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:08:33 -0500
Received: by mail-il1-f195.google.com with SMTP id d83so2263055ilk.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tINJyD9ZJqGUt5nhIHMTf94A9voyZOjcobv6ep2N/gs=;
        b=AEeDQ/816exn8z/BuE7ICwR3vGqrExw7UD2JblL+xKAehiwVm9Smfcw1BCfdTT7eAf
         SrmYPPR7eGhteJg7Aa9Xph2D1OrWoTtFZYUxe3HkCutuw5JNbKd3UcG/WrOF+uGKDVvN
         spjjzRQc0ZEgCUlWXQiqCIX6fMnnWjAtM1UpDFCmjpXY/w8WDJV99Vu4r7XK2PiDUsLq
         3j4SVpOtiBr7HWw9/ZvyFabXWiDw1Lp6EOZYJtMp8P5hKwti90kiSrXzEHfivB8Ech//
         9y2n1ND95Y7qyKIRmbPzinVSkvz5S4YYdJ1/O0JsXVnOSTQm5FZ94EvBaY5fANocVVhf
         /Bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tINJyD9ZJqGUt5nhIHMTf94A9voyZOjcobv6ep2N/gs=;
        b=DTxllfQaI/jbIHuzQBPkv8n9zc/TYJNisFo/A6I/P2h+xMZt7B1edxnTM7l3L9TFTX
         qfHQqVoQIgc2P4MsKeav6YzrPTOtzBRVbtwzZaC9X1goueHe1plREkd++bE+xlBEHj/R
         uMHAkclcbxteMvzlnChiglaTj3LEWG1FgDZGwBvqzLOJVBgBMd4wgqUmSwEXT1iC1FiK
         IaQFJkri0y6zeopZOIEMqaPjFip3CEWScGHazmTftlK/tGSxdIVFLu7hUkCW6F77jjWd
         lttImmUBqVDWvNJ3sGqt1KkNyD2xzC+Jh2DvJepgJmd77wRCdHA5fiYFwWNA7yNaYwEO
         8dJw==
X-Gm-Message-State: APjAAAW5bmApXKyomp20/dwdR2oP/b+ZFB+zEiwBhv24T99skE38JJTi
        Gy0zQrAVgsYTIzpKEWH7WXwKwi/EXQg=
X-Google-Smtp-Source: APXvYqxKS0cv20/0h4BRXpygSpky7XSNR80ysphE4pwHuVmtFWtVc2j/imDRVXzHlyblnA1mbGvV4Q==
X-Received: by 2002:a92:5fc2:: with SMTP id i63mr4409919ill.218.1573661311628;
        Wed, 13 Nov 2019 08:08:31 -0800 (PST)
Received: from [192.168.1.163] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t68sm327142ilb.66.2019.11.13.08.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:08:30 -0800 (PST)
Subject: Re: general protection fault in io_commit_cqring
To:     syzbot <syzbot+21147d79607d724bd6f3@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000af7e9805973c6356@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff3df506-7b2c-3af7-a6e5-2264ac12b1da@kernel.dk>
Date:   Wed, 13 Nov 2019 09:08:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000af7e9805973c6356@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/13/19 8:55 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    4e8f108c Add linux-next specific files for 20191113
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=121ad2d2e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ace1bcdd76242fd2
> dashboard link: https://syzkaller.appspot.com/bug?extid=21147d79607d724bd6f3
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1649e706e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11397f72e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+21147d79607d724bd6f3@syzkaller.appspotmail.com
> 
> RSP: 002b:00007ffd6e8aa078 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441229
> RDX: 0000000000000002 RSI: 0000000020000140 RDI: 0000000000000d0d
> RBP: 00007ffd6e8aa090 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8903 Comm: syz-executor410 Not tainted 5.4.0-rc7-next-20191113
> #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> RIP: 0010:__io_commit_cqring fs/io_uring.c:496 [inline]
> RIP: 0010:io_commit_cqring+0x1e1/0xdb0 fs/io_uring.c:592
> Code: 03 0f 8e df 09 00 00 48 8b 45 d0 4c 8d a3 c0 00 00 00 4c 89 e2 48 c1
> ea 03 44 8b b8 c0 01 00 00 48 b8 00 00 00 00 00 fc ff df <0f> b6 14 02 4c
> 89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 61
> RSP: 0018:ffff88808f51fc08 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff815abe4a
> RDX: 0000000000000018 RSI: ffffffff81d168d5 RDI: ffff8880a9166100
> RBP: ffff88808f51fc70 R08: 0000000000000004 R09: ffffed1011ea3f7d
> R10: ffffed1011ea3f7c R11: 0000000000000003 R12: 00000000000000c0
> R13: ffff8880a91661c0 R14: 1ffff1101522cc10 R15: 0000000000000000
> FS:  0000000001e7a880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000140 CR3: 000000009a74c000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>    io_cqring_overflow_flush+0x6b9/0xa90 fs/io_uring.c:673
>    io_ring_ctx_wait_and_kill+0x24f/0x7c0 fs/io_uring.c:4260
>    io_uring_create fs/io_uring.c:4600 [inline]
>    io_uring_setup+0x1256/0x1cc0 fs/io_uring.c:4626
>    __do_sys_io_uring_setup fs/io_uring.c:4639 [inline]
>    __se_sys_io_uring_setup fs/io_uring.c:4636 [inline]
>    __x64_sys_io_uring_setup+0x54/0x80 fs/io_uring.c:4636
>    do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x441229
> Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd6e8aa078 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441229
> RDX: 0000000000000002 RSI: 0000000020000140 RDI: 0000000000000d0d
> RBP: 00007ffd6e8aa090 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace b0f5b127a57f623f ]---
> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> RIP: 0010:__io_commit_cqring fs/io_uring.c:496 [inline]
> RIP: 0010:io_commit_cqring+0x1e1/0xdb0 fs/io_uring.c:592
> Code: 03 0f 8e df 09 00 00 48 8b 45 d0 4c 8d a3 c0 00 00 00 4c 89 e2 48 c1
> ea 03 44 8b b8 c0 01 00 00 48 b8 00 00 00 00 00 fc ff df <0f> b6 14 02 4c
> 89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 61
> RSP: 0018:ffff88808f51fc08 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff815abe4a
> RDX: 0000000000000018 RSI: ffffffff81d168d5 RDI: ffff8880a9166100
> RBP: ffff88808f51fc70 R08: 0000000000000004 R09: ffffed1011ea3f7d
> R10: ffffed1011ea3f7c R11: 0000000000000003 R12: 00000000000000c0
> R13: ffff8880a91661c0 R14: 1ffff1101522cc10 R15: 0000000000000000
> FS:  0000000001e7a880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000140 CR3: 000000009a74c000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

We fail allocating the rings due to the fail slab/page_alloc stuff,
which means ctx->rings isn't setup. When then tear down the ctx, we'll
blow up trying to stuff an entry in the CQ ring.

The below should fix it, I'll add it to the mix.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 11b3e1e23720..3e8a503bcca6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4280,7 +4314,8 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 		io_wq_cancel_all(ctx->io_wq);
 
 	io_iopoll_reap_events(ctx);
-	io_cqring_overflow_flush(ctx, true);
+	if (ctx->rings)
+		io_cqring_overflow_flush(ctx, true);
 	wait_for_completion(&ctx->completions[0]);
 	io_ring_ctx_free(ctx);
 }

-- 
Jens Axboe

