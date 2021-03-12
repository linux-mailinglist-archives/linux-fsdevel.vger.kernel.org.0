Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38923388CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 10:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhCLJhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 04:37:16 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:56034 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhCLJhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:37:16 -0500
Received: by mail-io1-f70.google.com with SMTP id e15so17392841ioe.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Mar 2021 01:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jI6hPEpOrFpxNYxzowdZBYaEnxiKnthlNj0BPnVx+Rc=;
        b=mdRKqyNTpgO21Tw+YBV0+M61zt1i0PM9hfAaDRZZha7zoV/mugaUiFPl20XDCedS0l
         6GVwM5ab4uDEv5piIY4LgCiO7Fh31PwuswBAaLXtXzxdmgQR0FK4Zk3zh3c/J+VtVPID
         1Y4rmmlVBBVtJgARQlfZS4rE2wtYhnFWCXwIXECrv7+nrBANpRMuGpefxmd6O+zpbDGP
         Kf+MXCy46aF0r1Fc0azRZOoac/LwtLT3d98fhLXYokNzhFTZgE+Jxl4tHD/+6GbW7dEZ
         vmtQd7Sfl4NIlVF4AN1DHevMQQT+qTRe3JoDsB6SawP7AeNAkUxTh3LojT4KGw9iSM7G
         aNhQ==
X-Gm-Message-State: AOAM5322KpctSLwfWk6Bec2fLVjKDyumg2J9H0Tmoznf6ShwI22BoTdJ
        jT5tF5YtZ/xcnt/pKV9EAYb6D2Lqa7VLrLKFH2HuvE2j5cBV
X-Google-Smtp-Source: ABdhPJy0oPWkuIWnmFsm1vLpqq6kBstsFctb7V8LlLAuIYcSIUQieOkIgHKPoXLaS72l1OVAWKvg1FJaZ1axXM3G/5VCjGUEm+aD
MIME-Version: 1.0
X-Received: by 2002:a6b:ee0b:: with SMTP id i11mr3803924ioh.157.1615541835880;
 Fri, 12 Mar 2021 01:37:15 -0800 (PST)
Date:   Fri, 12 Mar 2021 01:37:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f5e4805bd53a5c5@google.com>
Subject: [syzbot] INFO: task hung in walk_component (2)
From:   syzbot <syzbot+c6aadfbde93979999512@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3bb48a85 Merge branch 'parisc-5.12-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c626dad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c6adb4986f2f2
dashboard link: https://syzkaller.appspot.com/bug?extid=c6aadfbde93979999512

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6aadfbde93979999512@syzkaller.appspotmail.com

INFO: task syz-executor.5:18532 blocked for more than 143 seconds.
      Not tainted 5.12.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:28936 pid:18532 ppid:  8417 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4324 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5075
 schedule+0xcf/0x270 kernel/sched/core.c:5154
 rwsem_down_read_slowpath+0x4ca/0x980 kernel/locking/rwsem.c:992
 __down_read_common kernel/locking/rwsem.c:1213 [inline]
 __down_read kernel/locking/rwsem.c:1222 [inline]
 down_read+0xe4/0x440 kernel/locking/rwsem.c:1355
 inode_lock_shared include/linux/fs.h:785 [inline]
 lookup_slow fs/namei.c:1642 [inline]
 walk_component+0x409/0x6a0 fs/namei.c:1939
 lookup_last fs/namei.c:2396 [inline]
 path_lookupat+0x1ba/0x830 fs/namei.c:2420
 filename_lookup+0x19f/0x560 fs/namei.c:2453
 user_path_at include/linux/namei.h:60 [inline]
 do_fchownat+0xe1/0x1e0 fs/open.c:707
 __do_sys_chown fs/open.c:733 [inline]
 __se_sys_chown fs/open.c:731 [inline]
 __x64_sys_chown+0x77/0xb0 fs/open.c:731
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x465f69
RSP: 002b:00007eff79ca3188 EFLAGS: 00000246 ORIG_RAX: 000000000000005c
RAX: ffffffffffffffda RBX: 000000000056c008 RCX: 0000000000465f69
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00000000004bfa67 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c008
R13: 00007ffed82579ef R14: 00007eff79ca3300 R15: 0000000000022000
INFO: task syz-executor.5:18559 blocked for more than 143 seconds.
      Not tainted 5.12.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:27680 pid:18559 ppid:  8417 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4324 [inline]
 __schedule+0x90c/0x21a0 kernel/sched/core.c:5075
 schedule+0xcf/0x270 kernel/sched/core.c:5154
 rwsem_down_write_slowpath+0x7e5/0x1200 kernel/locking/rwsem.c:1106
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1407
 inode_lock include/linux/fs.h:775 [inline]
 lock_mount+0x8a/0x2e0 fs/namespace.c:2216
 do_new_mount_fc fs/namespace.c:2846 [inline]
 do_new_mount fs/namespace.c:2905 [inline]
 path_mount+0x14d6/0x1f90 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount fs/namespace.c:3431 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x465f69
RSP: 002b:00007eff79c61188 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000056c158 RCX: 0000000000465f69
RDX: 0000000020002100 RSI: 00000000200042c0 RDI: 0000000000000000
RBP: 00000000004bfa67 R08: 0000000020002140 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c158
R13: 00007ffed82579ef R14: 00007eff79c61300 R15: 0000000000022000

Showing all locks held in the system:
1 lock held by khungtaskd/1664:
 #0: ffffffff8bf74220 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6327
1 lock held by in:imklog/8104:
 #0: ffff888013fb0d70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:961
3 locks held by syz-executor.5/18521:
1 lock held by syz-executor.5/18532:
 #0: ffff888081bc1590 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:785 [inline]
 #0: ffff888081bc1590 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: lookup_slow fs/namei.c:1642 [inline]
 #0: ffff888081bc1590 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: walk_component+0x409/0x6a0 fs/namei.c:1939
1 lock held by syz-executor.5/18559:
 #0: ffff888081bc1590 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #0: ffff888081bc1590 (&type->i_mutex_dir_key#9){++++}-{3:3}, at: lock_mount+0x8a/0x2e0 fs/namespace.c:2216

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1664 Comm: khungtaskd Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd48/0xfb0 kernel/hung_task.c:294
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 18521 Comm: syz-executor.5 Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:hlock_class kernel/locking/lockdep.c:198 [inline]
RIP: 0010:mark_lock+0xf7/0x17b0 kernel/locking/lockdep.c:4456
Code: 66 81 e2 ff 1f 44 0f b7 f2 be 08 00 00 00 4c 89 f0 48 c1 f8 06 48 8d 3c c5 60 e8 a9 8f e8 e1 c0 5e 00 4c 0f a3 35 09 02 51 0e <0f> 83 03 01 00 00 4b 8d 04 76 48 c1 e0 06 48 05 80 ec a9 8f 48 8d
RSP: 0018:ffffc9000223f648 EFLAGS: 00000047
RAX: 0000000000000001 RBX: 1ffff92000447ed0 RCX: ffffffff8158e64f
RDX: fffffbfff1f53d17 RSI: 0000000000000008 RDI: ffffffff8fa9e8b0
RBP: 0000000000000004 R08: 0000000000000000 R09: ffffffff8fa9e8b7
R10: fffffbfff1f53d16 R11: 0000000000000000 R12: 0000000000000002
R13: ffff88807d2add48 R14: 00000000000002ab R15: ffff88807d2add68
FS:  00007eff79cc4700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbfa45991b0 CR3: 00000000840f7000 CR4: 0000000000350ef0
Call Trace:
 mark_usage kernel/locking/lockdep.c:4387 [inline]
 __lock_acquire+0x837/0x54c0 kernel/locking/lockdep.c:4854
 lock_acquire kernel/locking/lockdep.c:5510 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 ilookup5_nowait fs/inode.c:1334 [inline]
 ilookup5 fs/inode.c:1364 [inline]
 iget5_locked+0xac/0x2e0 fs/inode.c:1145
 fuse_iget+0x271/0x610 fs/fuse/inode.c:342
 fuse_lookup_name+0x447/0x630 fs/fuse/dir.c:439
 fuse_lookup.part.0+0xdf/0x390 fs/fuse/dir.c:469
 fuse_lookup+0x70/0x90 fs/fuse/dir.c:465
 __lookup_hash+0x117/0x180 fs/namei.c:1527
 do_unlinkat+0x295/0x690 fs/namei.c:4080
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x465f69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007eff79cc4188 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465f69
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020002000
RBP: 00000000004bfa67 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffed82579ef R14: 00007eff79cc4300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
