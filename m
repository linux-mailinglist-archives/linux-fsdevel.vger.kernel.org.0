Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C010402E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbfKTP6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:58:11 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:40549 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbfKTP6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:58:11 -0500
Received: by mail-io1-f72.google.com with SMTP id 125so18798904iou.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 07:58:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=D0siQ5VXLYgnLbarDRDx2gxGicWQej9v5iWxcK9yLGk=;
        b=K9wQgxY6csq1eN4b0ijBvMLkke8fip1BSp9d9mAmRYMombyQ2RRztz/d4+0RJWCqfr
         ZzYYwJoxO0I7umBZd1rwPHNESRbVfIVRuWKp9fWm+sU8E3IkKa9GkvkdDxLwwFRMpv35
         9W037UKvcH9wjZCdUBlz3AdcuuhTu2J0AJ4HtKp/ddbrxghRKDBfy5oVpF/Bbjyklf0P
         jO1dSQfhCOc/aP9k7WcV/XTWSV1zCCsKYzmxXfjP7X9vPSMhCCNQkh0wawZXncC+UKhP
         A2BgZ8FETKSJ/G93TxiWPZxXXmeTGRWfhZHtMFWfeSxluieY2HnaqOR1gJzxH+2FS893
         TNSQ==
X-Gm-Message-State: APjAAAUMCBiMvGCzigB+KD+WI0O8rcLvyiWEpgq69QmTCvbmzQOms+oZ
        QEi6OSIffS0DnxY8dpMs6iNk8kF85FWylEAhvAS4LN+C3/qS
X-Google-Smtp-Source: APXvYqx8TtWXlYIgsSif3jENuikx/9gZNwqg/6rX/P2UATgf96UTqCSv9ftqDJznlfzIUvUtrKRLnRUPeqsmE8ZjYTnKykjxr9qu
MIME-Version: 1.0
X-Received: by 2002:a92:831d:: with SMTP id f29mr4379730ild.263.1574265488544;
 Wed, 20 Nov 2019 07:58:08 -0800 (PST)
Date:   Wed, 20 Nov 2019 07:58:08 -0800
In-Reply-To: <00000000000072cb6c0597635d04@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a1f180597c93ffe@google.com>
Subject: Re: INFO: trying to register non-static key in io_cqring_ev_posted
From:   syzbot <syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    5d1131b4 Add linux-next specific files for 20191119
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=140b0412e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b60c562d89e5a8df
dashboard link: https://syzkaller.appspot.com/bug?extid=0d818c0d39399188f393
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b29d2e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b3956ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com

RSP: 002b:00007ffddd565408 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004412a9
RDX: 0000000000000001 RSI: 0000000020000340 RDI: 00000000000002a6
RBP: 0000000000011c3e R08: 0000000000000001 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004021f0
R13: 0000000000402280 R14: 0000000000000000 R15: 0000000000000000
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 1 PID: 8725 Comm: syz-executor376 Not tainted  
5.4.0-rc8-next-20191119-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  assign_lock_key kernel/locking/lockdep.c:881 [inline]
  register_lock_class+0x179e/0x1850 kernel/locking/lockdep.c:1190
  __lock_acquire+0xf4/0x4a00 kernel/locking/lockdep.c:3837
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
  __wake_up_common_lock+0xc8/0x150 kernel/sched/wait.c:122
  __wake_up+0xe/0x10 kernel/sched/wait.c:142
  io_cqring_ev_posted+0xaa/0x120 fs/io_uring.c:655
  io_cqring_overflow_flush+0x6d4/0xa90 fs/io_uring.c:702
  io_ring_ctx_wait_and_kill+0x20a/0x770 fs/io_uring.c:4382
  io_uring_create fs/io_uring.c:4719 [inline]
  io_uring_setup+0x123d/0x1ca0 fs/io_uring.c:4745
  __do_sys_io_uring_setup fs/io_uring.c:4758 [inline]
  __se_sys_io_uring_setup fs/io_uring.c:4755 [inline]
  __x64_sys_io_uring_setup+0x54/0x80 fs/io_uring.c:4755
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4412a9
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffddd565408 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004412a9
RDX: 0000000000000001 RSI: 0000000020000340 RDI: 00000000000002a6
RBP: 0000000000011c3e R08: 0000000000000001 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004021f0
R13: 0000000000402280 R14: 0000000000000000 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8725 Comm: syz-executor376 Not tainted  
5.4.0-rc8-next-20191119-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__wake_up_common+0xdf/0x610 kernel/sched/wait.c:86
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 64 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 0d 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff888089c87b00 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff8880880c1120 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 1ffffffff13913ee RDI: 0000000000000000
RBP: ffff888089c87b58 R08: ffffffffffffffe8 R09: ffff888089c87ba8
R10: ffffed1011390f59 R11: 0000000000000003 R12: 0000000000000001
R13: 0000000000000286 R14: 0000000000000000 R15: 0000000000000003
FS:  00000000025cb880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000340 CR3: 000000009a26b000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __wake_up_common_lock+0xea/0x150 kernel/sched/wait.c:123
  __wake_up+0xe/0x10 kernel/sched/wait.c:142
  io_cqring_ev_posted+0xaa/0x120 fs/io_uring.c:655
  io_cqring_overflow_flush+0x6d4/0xa90 fs/io_uring.c:702
  io_ring_ctx_wait_and_kill+0x20a/0x770 fs/io_uring.c:4382
  io_uring_create fs/io_uring.c:4719 [inline]
  io_uring_setup+0x123d/0x1ca0 fs/io_uring.c:4745
  __do_sys_io_uring_setup fs/io_uring.c:4758 [inline]
  __se_sys_io_uring_setup fs/io_uring.c:4755 [inline]
  __x64_sys_io_uring_setup+0x54/0x80 fs/io_uring.c:4755
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4412a9
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffddd565408 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004412a9
RDX: 0000000000000001 RSI: 0000000020000340 RDI: 00000000000002a6
RBP: 0000000000011c3e R08: 0000000000000001 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004021f0
R13: 0000000000402280 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 8d482760e7208707 ]---
RIP: 0010:__wake_up_common+0xdf/0x610 kernel/sched/wait.c:86
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 64 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 0d 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff888089c87b00 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff8880880c1120 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 1ffffffff13913ee RDI: 0000000000000000
RBP: ffff888089c87b58 R08: ffffffffffffffe8 R09: ffff888089c87ba8
R10: ffffed1011390f59 R11: 0000000000000003 R12: 0000000000000001
R13: 0000000000000286 R14: 0000000000000000 R15: 0000000000000003
FS:  00000000025cb880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000340 CR3: 000000009a26b000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

