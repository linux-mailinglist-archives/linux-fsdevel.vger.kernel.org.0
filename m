Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1C3CC0B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jul 2021 04:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbhGQCbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 22:31:18 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:36632 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbhGQCbR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 22:31:17 -0400
Received: by mail-il1-f199.google.com with SMTP id j13-20020a056e02218db02902141528bc7cso2416245ila.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 19:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cRbh8Tinf77HQCnZXcCsyZQGB7EXM3IOmE6qpom6jko=;
        b=Z2uPeliv/G/mUOYX2qK2WxqyOf8oTbBJDa4Z/YuE8qWkkHUzAmk3jFH6s1nwG3sD9M
         CloZ5dZSdSXRVhuUe5uXVPFyzH9mp/fPKhLkchBVQSymAviNEav+vIwwyC5Zm4DdCQ+o
         zjfEYAl+owkzR45ML5F3/kLO4EH6gmFa8ZeDlQgA5jyXxMtarxg/8jYe/AdoZCrUIMGO
         O9r5R+RVHjDdqsNCgQLYqtFNRrHywloKYa1EDUFxcZdoBBXEk+/Kxs9wpEHq7fo9vxnw
         H/j7MS1S7deoLGRouVAuQqOn2ZLz+LOXD15JBq0ARBbfOdFnfMFNhxoDjwjOs3980dJC
         RKhg==
X-Gm-Message-State: AOAM531VxzL2NWnFBEEkd/qstS3aJjnDduNXslmNEZlAs7yY4HSi4FRu
        kzYYNUWFnc4f87CSqdSK6WQpOHq52e0jEIo6ivdu1sYy+hck
X-Google-Smtp-Source: ABdhPJzOamzTb7oQuNdpVA8renRACbieBVe1TEE1BbdIUI6mcROJK17QTaCNYE7+/qavBzJOpBvCXfnuQxAadIz22xgtsLZmniFi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ea9:: with SMTP id u9mr8524153ilj.174.1626488900759;
 Fri, 16 Jul 2021 19:28:20 -0700 (PDT)
Date:   Fri, 16 Jul 2021 19:28:20 -0700
In-Reply-To: <000000000000295a6a05b65efe35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029363505c748757d@google.com>
Subject: Re: [syzbot] INFO: task hung in fuse_simple_request
From:   syzbot <syzbot+46fe899420456e014d6b@syzkaller.appspotmail.com>
To:     areeba.ahmed@futuregulfpak.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    d936eb238744 Revert "Makefile: Enable -Wimplicit-fallthrou..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1492834a300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e52880ded966e4
dashboard link: https://syzkaller.appspot.com/bug?extid=46fe899420456e014d6b
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165fc902300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1130705c300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46fe899420456e014d6b@syzkaller.appspotmail.com

INFO: task syz-executor874:8578 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor874 state:D stack:26768 pid: 8578 ppid:  8450 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 request_wait_answer fs/fuse/dev.c:411 [inline]
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x1125/0x19f0 fs/fuse/dev.c:515
 fuse_do_getattr+0x396/0x1210 fs/fuse/dir.c:1009
 vfs_getattr fs/stat.c:142 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat fs/stat.c:394 [inline]
 __se_sys_newfstatat+0xb4/0x780 fs/stat.c:388
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446039
RSP: 002b:00007fbb526242f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446039
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 000000000049b16c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 00000000004cb4e8
INFO: task syz-executor874:8582 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor874 state:D stack:25368 pid: 8582 ppid:  8451 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 request_wait_answer fs/fuse/dev.c:411 [inline]
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x1125/0x19f0 fs/fuse/dev.c:515
 fuse_do_getattr+0x396/0x1210 fs/fuse/dir.c:1009
 vfs_getattr fs/stat.c:142 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat fs/stat.c:394 [inline]
 __se_sys_newfstatat+0xb4/0x780 fs/stat.c:388
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446039
RSP: 002b:00007fbb526242f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446039
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 000000000049b16c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 00000000004cb4e8
INFO: task syz-executor874:8597 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor874 state:D stack:24784 pid: 8597 ppid:  8448 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 request_wait_answer fs/fuse/dev.c:411 [inline]
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x1125/0x19f0 fs/fuse/dev.c:515
 fuse_do_getattr+0x396/0x1210 fs/fuse/dir.c:1009
 vfs_getattr fs/stat.c:142 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat fs/stat.c:394 [inline]
 __se_sys_newfstatat+0xb4/0x780 fs/stat.c:388
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446039
RSP: 002b:00007fbb526242f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446039
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 000000000049b16c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 00000000004cb4e8
INFO: task syz-executor874:8601 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor874 state:D stack:24784 pid: 8601 ppid:  8452 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 request_wait_answer fs/fuse/dev.c:411 [inline]
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x1125/0x19f0 fs/fuse/dev.c:515
 fuse_do_getattr+0x396/0x1210 fs/fuse/dir.c:1009
 vfs_getattr fs/stat.c:142 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat fs/stat.c:394 [inline]
 __se_sys_newfstatat+0xb4/0x780 fs/stat.c:388
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446039
RSP: 002b:00007fbb526242f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446039
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 000000000049b16c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 00000000004cb4e8
INFO: task syz-executor874:8617 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor874 state:D stack:26768 pid: 8617 ppid:  8451 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 request_wait_answer fs/fuse/dev.c:411 [inline]
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x1125/0x19f0 fs/fuse/dev.c:515
 fuse_do_getattr+0x396/0x1210 fs/fuse/dir.c:1009
 vfs_getattr fs/stat.c:142 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat fs/stat.c:394 [inline]
 __se_sys_newfstatat+0xb4/0x780 fs/stat.c:388
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446039
RSP: 002b:00007fbb526242f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446039
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 000000000049b16c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 00000000004cb4e8
INFO: task syz-executor874:8626 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor874 state:D stack:24784 pid: 8626 ppid:  8450 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 request_wait_answer fs/fuse/dev.c:411 [inline]
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x1125/0x19f0 fs/fuse/dev.c:515
 fuse_do_getattr+0x396/0x1210 fs/fuse/dir.c:1009
 vfs_getattr fs/stat.c:142 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat fs/stat.c:394 [inline]
 __se_sys_newfstatat+0xb4/0x780 fs/stat.c:388
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446039
RSP: 002b:00007fbb526242f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446039
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 000000000049b16c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 00000000004cb4e8
INFO: task syz-executor874:8630 blocked for more than 145 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor874 state:D stack:24784 pid: 8630 ppid:  8452 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 request_wait_answer fs/fuse/dev.c:411 [inline]
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x1125/0x19f0 fs/fuse/dev.c:515
 fuse_do_getattr+0x396/0x1210 fs/fuse/dir.c:1009
 vfs_getattr fs/stat.c:142 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat fs/stat.c:394 [inline]
 __se_sys_newfstatat+0xb4/0x780 fs/stat.c:388
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446039
RSP: 002b:00007fbb526242f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446039
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 000000000049b16c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 00000000004cb4e8
INFO: task syz-executor874:8634 blocked for more than 145 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor874 state:D stack:26640 pid: 8634 ppid:  8448 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 request_wait_answer fs/fuse/dev.c:411 [inline]
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x1125/0x19f0 fs/fuse/dev.c:515
 fuse_do_getattr+0x396/0x1210 fs/fuse/dir.c:1009
 vfs_getattr fs/stat.c:142 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat fs/stat.c:394 [inline]
 __se_sys_newfstatat+0xb4/0x780 fs/stat.c:388
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446039
RSP: 002b:00007fbb526242f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446039
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 000000000049b16c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 00000000004cb4e8
INFO: task syz-executor874:8657 blocked for more than 145 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor874 state:D stack:26768 pid: 8657 ppid:  8450 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 request_wait_answer fs/fuse/dev.c:411 [inline]
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x1125/0x19f0 fs/fuse/dev.c:515
 fuse_do_getattr+0x396/0x1210 fs/fuse/dir.c:1009
 vfs_getattr fs/stat.c:142 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat fs/stat.c:394 [inline]
 __se_sys_newfstatat+0xb4/0x780 fs/stat.c:388
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446039
RSP: 002b:00007fbb526242f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446039
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 000000000049b16c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 00000000004cb4e8
INFO: task syz-executor874:8665 blocked for more than 145 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor874 state:D stack:26768 pid: 8665 ppid:  8452 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xc07/0x11f0 kernel/sched/core.c:5940
 schedule+0x14b/0x210 kernel/sched/core.c:6019
 request_wait_answer fs/fuse/dev.c:411 [inline]
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x1125/0x19f0 fs/fuse/dev.c:515
 fuse_do_getattr+0x396/0x1210 fs/fuse/dir.c:1009
 vfs_getattr fs/stat.c:142 [inline]
 vfs_statx+0x1ba/0x3d0 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 __do_sys_newfstatat fs/stat.c:394 [inline]
 __se_sys_newfstatat+0xb4/0x780 fs/stat.c:388
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446039
RSP: 002b:00007fbb526242f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446039
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 000000000049b16c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 64695f70756f7267 R14: 65646f6d746f6f72 R15: 00000000004cb4e8

Showing all locks held in the system:
1 lock held by ksoftirqd/0/13:
 #0: ffff8880b9c514d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x1b/0x30 kernel/sched/core.c:460
1 lock held by khungtaskd/1644:
 #0: ffffffff8c7177c0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30 arch/x86/pci/mmconfig_64.c:151
1 lock held by in:imklog/8138:
 #0: ffff888019edb270 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x2f0 fs/file.c:974
no locks held by syz-executor874/16040.

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1644 Comm: khungtaskd Not tainted 5.14.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1d3/0x29f lib/dump_stack.c:105
 nmi_cpu_backtrace+0x16c/0x190 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x191/0x2f0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xd06/0xd50 kernel/hung_task.c:295
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 8453 Comm: syz-executor874 Not tainted 5.14.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:put_pid+0x0/0x130 kernel/pid.c:106
Code: 1f 84 00 00 00 00 00 0f 1f 00 be af 00 00 00 48 c7 c7 40 99 5c 8c e8 ff d4 74 00 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc <55> 41 57 41 56 41 54 53 49 89 ff e8 c0 a3 2b 00 4d 85 ff 0f 84 aa
RSP: 0018:ffffc9000198fc78 EFLAGS: 00000286
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000198fd90 R08: ffffffff81869020 R09: ffffed1002bf8685
R10: ffffed1002bf8685 R11: 0000000000000000 R12: 0000000000000000
R13: 1ffff92000331f94 R14: 1ffff92000331f9b R15: 0000000000000000
FS:  00000000020ba300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbb52603718 CR3: 00000000366ee000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kernel_wait4+0x27f/0x380 kernel/exit.c:1678
 __do_sys_wait4 kernel/exit.c:1705 [inline]
 __se_sys_wait4 kernel/exit.c:1701 [inline]
 __x64_sys_wait4+0x117/0x1c0 kernel/exit.c:1701
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x444826
Code: 0f 1f 40 00 31 c9 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 14 48 89 74 24
RSP: 002b:00007fff50fbe958 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00007fff50fbea10 RCX: 0000000000444826
RDX: 0000000040000001 RSI: 00007fff50fbe98c RDI: 00000000ffffffff
RBP: 00007fff50fbe98c R08: 00007fff50fec080 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 0000000000001eee R14: 00007fff50fbe9e0 R15: 00007fff50fbe9d0

