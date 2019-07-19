Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F396E582
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 14:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfGSMQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 08:16:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43312 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfGSMQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:16:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so14385851pgv.10;
        Fri, 19 Jul 2019 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SHwYzemAsEE82NpCdBU5RqTt+luo2yO/hVVAHT4mTvM=;
        b=NB27W61IXYBRFpWRWwir38hR97It852sX5FgBKi6ehkOtpjFZY4OQIm+5iRPlzLrVQ
         xoNR8S3Qk97PZ2VzMCx3ag2YrOrG2NhCTd1AK93Sea9Tb6JmLepI0Kdy8UHiHlT5yL8B
         ook5Jw9tfcRfmGKlNZ3rhSFL57je9r+tM0Bk7RQfIwMxvgn9rpdl2Ab70f6SEQqB1VVb
         aioBGx+k6X1woCNzyx5wPfVGdH+7QxuaVyT9bqDbjlb7bw89MPmdtltBPkn3dwxEM8X9
         qosyZqUPc4E8FPZQnAeQjLm3Cx/NRSJwHaV+UymohfrAAvOc7BPKB9Rrr6IPpZHH8RJC
         DoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHwYzemAsEE82NpCdBU5RqTt+luo2yO/hVVAHT4mTvM=;
        b=tRcK3oyJI5vQabGe9+mIkf5O9Q7M8LzLc5eIZS+meomtk42RyoE6ajhQiPUnmSNQ1L
         brbPaNF1T1ocSZ0qoq9ILlPBPGZrN5/Rfoy3NN6OEN43dQrAX7n9rOx9OlnjDeOwZ5fM
         Iy/5p+xTDiTaK7cdtLjBjRVVk2XveWZhe8CeHgFm+YnUPalo7fMnD/2SBGcLgEASMGuz
         kgxD+xjywtd9RuzWRJ1Co6FmObe58ObIqQ2/+7Jpn5yQFlBSwlYsKoow/NqQgtKC8u5w
         KSNZUiDsx4FmPHBM19HBZCp68WJ2+djG+E04XgRi4v9BH5iJJFUUrElbi8oP4b2946vk
         sVhQ==
X-Gm-Message-State: APjAAAUCi8Yj89kS8ivjCgXmFr6upxgRj3BJhM830yOn136WMbHu6FVX
        RHj/8Voqr/3yW58lmqzQr0M=
X-Google-Smtp-Source: APXvYqwaH4xeLbZbZzlkIMs4+EP01Ofo+WYQf61geVy875AvNz9lckn7UAoc4pr03RebUx6kiWBgEw==
X-Received: by 2002:a63:de4f:: with SMTP id y15mr55787508pgi.239.1563538579224;
        Fri, 19 Jul 2019 05:16:19 -0700 (PDT)
Received: from fyin-linux ([103.121.208.202])
        by smtp.gmail.com with ESMTPSA id 137sm39763622pfz.112.2019.07.19.05.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 05:16:18 -0700 (PDT)
From:   YinFengwei <nh26223.lmm@gmail.com>
X-Google-Original-From: YinFengwei <fyin@fyin-linux>
Date:   Fri, 19 Jul 2019 20:16:02 +0800
To:     syzbot <syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Subject: Re: general protection fault in kstrtouint (2)
Message-ID: <20190719121602.GA21526@fyin-linux>
References: <0000000000003a2aeb058df39a3c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003a2aeb058df39a3c@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Jul 18, 2019 at 05:18:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e40115c0 Add linux-next specific files for 20190717
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d51b70600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> dashboard link: https://syzkaller.appspot.com/bug?extid=398343b7c1b1b989228d
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164e7434600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1399554c600000
> 
> The bug was bisected to:
> 
> commit 71cbb7570a9a0b830125163c20125a8b5e65ac45
> Author: David Howells <dhowells@redhat.com>
> Date:   Mon Mar 25 16:38:31 2019 +0000
> 
>     vfs: Move the subtype parameter into fuse
After this patch, if mount option is something like fd,XXXX (no "=" in XXXX),
the default parameter which has NULL param->string is passed to
vfs_parse_fs_param. And this NULL param->string is passed to kstrtouint and
trigger null pointer access finally.


Regards
Yin, Fengwei

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14323078600000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=16323078600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12323078600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com
> Fixes: 71cbb7570a9a ("vfs: Move the subtype parameter into fuse")
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 9017 Comm: syz-executor410 Not tainted 5.2.0-next-20190717 #40
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:kstrtoull lib/kstrtox.c:123 [inline]
> RIP: 0010:kstrtouint+0x85/0x1a0 lib/kstrtox.c:222
> Code: 04 00 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 6c 35
> 35 fe 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 4c 89
> e2 83 e2 07 38 d0 7f 08 84 c0 0f 85 db 00 00 00
> RSP: 0018:ffff8880997a79e0 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff8880997a7b38 RCX: ffffffff81c482dc
> RDX: 0000000000000000 RSI: ffffffff833d4f84 RDI: 0000000000000000
> RBP: ffff8880997a7a70 R08: ffff8880a17ce100 R09: ffffed1015d06c84
> R10: ffffed1015d06c83 R11: ffff8880ae83641b R12: 0000000000000000
> R13: 1ffff110132f4f3d R14: ffff8880997a7a48 R15: 0000000000000000
> FS:  0000555556585880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000455340 CR3: 0000000095a49000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  fs_parse+0xde1/0x1080 fs/fs_parser.c:209
>  fuse_parse_param+0xac/0x750 fs/fuse/inode.c:491
>  vfs_parse_fs_param+0x2ca/0x540 fs/fs_context.c:145
>  vfs_parse_fs_string+0x105/0x170 fs/fs_context.c:188
>  generic_parse_monolithic+0x181/0x200 fs/fs_context.c:228
>  parse_monolithic_mount_data+0x69/0x90 fs/fs_context.c:708
>  do_new_mount fs/namespace.c:2779 [inline]
>  do_mount+0x1369/0x1c30 fs/namespace.c:3103
>  ksys_mount+0xdb/0x150 fs/namespace.c:3312
>  __do_sys_mount fs/namespace.c:3326 [inline]
>  __se_sys_mount fs/namespace.c:3323 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3323
>  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440299
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff19b997e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fff19b997f0 RCX: 0000000000440299
> RDX: 0000000020000080 RSI: 00000000200000c0 RDI: 0000000000000000
> RBP: 00000000006cb018 R08: 00000000200002c0 R09: 65732f636f72702f
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b80
> R13: 0000000000401c10 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 8c219e63b0160ea4 ]---
> RIP: 0010:kstrtoull lib/kstrtox.c:123 [inline]
> RIP: 0010:kstrtouint+0x85/0x1a0 lib/kstrtox.c:222
> Code: 04 00 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 6c 35
> 35 fe 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 4c 89
> e2 83 e2 07 38 d0 7f 08 84 c0 0f 85 db 00 00 00
> RSP: 0018:ffff8880997a79e0 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff8880997a7b38 RCX: ffffffff81c482dc
> RDX: 0000000000000000 RSI: ffffffff833d4f84 RDI: 0000000000000000
> RBP: ffff8880997a7a70 R08: ffff8880a17ce100 R09: ffffed1015d06c84
> R10: ffffed1015d06c83 R11: ffff8880ae83641b R12: 0000000000000000
> R13: 1ffff110132f4f3d R14: ffff8880997a7a48 R15: 0000000000000000
> FS:  0000555556585880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000455340 CR3: 0000000095a49000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
