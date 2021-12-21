Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678BF47C96A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 23:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhLUWzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 17:55:31 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51107 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhLUWza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:55:30 -0500
Received: by mail-il1-f198.google.com with SMTP id 9-20020a056e0216c900b002acc1b44b91so270815ilx.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 14:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zHsXdqIvFrVgQVLAPvj5VEidrGCT2oN5pERfTO+cHbQ=;
        b=z/BO+x0S7l/CAjGLIdzQ247uX5tO/6YZtYzi30tJR0nCHuvwZnopbrDQ6mUTfYajmf
         D08RJQ+E+SJsgkopezCtXEeWR4Xqnnymr9s+6OgWQIBmu3tTJD99dsURzA7Be8GbvuVk
         1zITQ7jAXaaDXT8iBtTrQQ92HbttXVJA2zZjSiiG91Mf6R9VtXMA44llNbcQHQ6EpqQ6
         IhFRhvA3Q0Luz9KjZ/vm/6F07Tz5nMHBUIeNIy98Xb0dpV5xClyuyT9ur4R/OybB8cBf
         Ug7XmXxtpK9dnpOMAm2Az0eNF6kHaGtNZyqsysyHJMgraKkh0aeP+HmXFfhxyjAmiu3m
         lqOg==
X-Gm-Message-State: AOAM531COmVDwFjqXmeQQ8jMv5H8QbQFfe025N2Re0W+gSNIa2l/skXu
        oYGvUOFS4iV3H0yQqtkK7v6De17CSrFXFarWOLWGHhmy070q
X-Google-Smtp-Source: ABdhPJw1GhwZ+yUIBD2QIK0PP73uhyT9bUJDcxws4olfOFVoxzIfd66n06ONjYfE9RYpvZuJ1evN2lERCH8EJChU9K+WlHSAgxPW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ce:: with SMTP id 14mr178084ilq.252.1640127330296;
 Tue, 21 Dec 2021 14:55:30 -0800 (PST)
Date:   Tue, 21 Dec 2021 14:55:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8a6f705d3afe604@google.com>
Subject: [syzbot] INFO: task hung in filename_create (4)
From:   syzbot <syzbot+72c5cf124089bc318016@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6441998e2e37 Merge tag 'audit-pr-20211216' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b88443b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa556098924b78f0
dashboard link: https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160d179db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17741243b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72c5cf124089bc318016@syzkaller.appspotmail.com

INFO: task syz-executor149:3707 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor149 state:D stack:23928 pid: 3707 ppid:  3685 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x634/0x1110 kernel/locking/rwsem.c:1151 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 __down_write_common kernel/locking/rwsem.c:1268 [inline] kernel/locking/rwsem.c:1634
 __down_write_common kernel/locking/rwsem.c:1265 [inline] kernel/locking/rwsem.c:1634
 __down_write kernel/locking/rwsem.c:1277 [inline] kernel/locking/rwsem.c:1634
 down_write_nested+0x139/0x150 kernel/locking/rwsem.c:1634 kernel/locking/rwsem.c:1634
 inode_lock_nested include/linux/fs.h:818 [inline]
 inode_lock_nested include/linux/fs.h:818 [inline] fs/namei.c:3654
 filename_create+0x158/0x480 fs/namei.c:3654 fs/namei.c:3654
 do_mkdirat+0x94/0x300 fs/namei.c:3898 fs/namei.c:3898
 __do_sys_mkdir fs/namei.c:3929 [inline]
 __se_sys_mkdir fs/namei.c:3927 [inline]
 __do_sys_mkdir fs/namei.c:3929 [inline] fs/namei.c:3927
 __se_sys_mkdir fs/namei.c:3927 [inline] fs/namei.c:3927
 __x64_sys_mkdir+0xf2/0x140 fs/namei.c:3927 fs/namei.c:3927
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8e02ef3b47
RSP: 002b:00007f8e03098ca8 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8e02ef3b47
RDX: 00007f8e03098cf3 RSI: 00000000000001ff RDI: 00007f8e03098ce0
RBP: 00007f8e03098ee0 R08: 0000000000000000 R09: 00007f8e03098b40
R10: 00007f8e030989f7 R11: 0000000000000202 R12: 0000000000000001
R13: 00007f8e03098ce0 R14: 00007f8e03098d20 R15: 00007f8e03098ef0
 </TASK>
INFO: task syz-executor149:3711 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor149 state:D stack:23928 pid: 3711 ppid:  3681 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x634/0x1110 kernel/locking/rwsem.c:1151 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 __down_write_common kernel/locking/rwsem.c:1268 [inline] kernel/locking/rwsem.c:1634
 __down_write_common kernel/locking/rwsem.c:1265 [inline] kernel/locking/rwsem.c:1634
 __down_write kernel/locking/rwsem.c:1277 [inline] kernel/locking/rwsem.c:1634
 down_write_nested+0x139/0x150 kernel/locking/rwsem.c:1634 kernel/locking/rwsem.c:1634
 inode_lock_nested include/linux/fs.h:818 [inline]
 inode_lock_nested include/linux/fs.h:818 [inline] fs/namei.c:3654
 filename_create+0x158/0x480 fs/namei.c:3654 fs/namei.c:3654
 do_mkdirat+0x94/0x300 fs/namei.c:3898 fs/namei.c:3898
 __do_sys_mkdir fs/namei.c:3929 [inline]
 __se_sys_mkdir fs/namei.c:3927 [inline]
 __do_sys_mkdir fs/namei.c:3929 [inline] fs/namei.c:3927
 __se_sys_mkdir fs/namei.c:3927 [inline] fs/namei.c:3927
 __x64_sys_mkdir+0xf2/0x140 fs/namei.c:3927 fs/namei.c:3927
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8e02ef3b47
RSP: 002b:00007f8e03098ca8 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8e02ef3b47
RDX: 00007f8e03098cf3 RSI: 00000000000001ff RDI: 00007f8e03098ce0
RBP: 00007f8e03098ee0 R08: 0000000000000000 R09: 00007f8e03098b40
R10: 00007f8e030989f7 R11: 0000000000000202 R12: 0000000000000001
R13: 00007f8e03098ce0 R14: 00007f8e03098d20 R15: 00007f8e03098ef0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8bb83de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458 kernel/locking/lockdep.c:6458
2 locks held by kworker/u4:4/995:
 #0: ffff8880b9c39a98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:478 kernel/sched/core.c:478
 #1: ffff8880b9c279c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3a6/0x490 kernel/sched/psi.c:880 kernel/sched/psi.c:880
2 locks held by kworker/1:3/3266:
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline] kernel/workqueue.c:2269
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline] kernel/workqueue.c:2269
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline] kernel/workqueue.c:2269
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline] kernel/workqueue.c:2269
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline] kernel/workqueue.c:2269
 #0: ffff888010c66538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269 kernel/workqueue.c:2269
 #1: ffffc90001a6fdb0 ((work_completion)(&rew.rew_work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273 kernel/workqueue.c:2273
2 locks held by getty/3279:
 #0: ffff8880231c5098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252 drivers/tty/tty_ldisc.c:252
 #1: ffffc90002b962e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2113 drivers/tty/n_tty.c:2113
1 lock held by syz-executor149/3706:
 #0: ffffffff8bb8d168 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:322 [inline]
 #0: ffffffff8bb8d168 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:322 [inline] kernel/rcu/tree_exp.h:836
 #0: ffffffff8bb8d168 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x2d5/0x620 kernel/rcu/tree_exp.h:836 kernel/rcu/tree_exp.h:836
2 locks held by syz-executor149/3707:
 #0: ffff88801f07a460 (sb_writers#11){.+.+}-{0:0}, at: filename_create+0xf3/0x480 fs/namei.c:3649 fs/namei.c:3649
 #1: ffff88807533e9d0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff88807533e9d0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:818 [inline] fs/namei.c:3654
 #1: ffff88807533e9d0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: filename_create+0x158/0x480 fs/namei.c:3654 fs/namei.c:3654
1 lock held by syz-executor149/3708:
 #0: ffffffff8bb8d168 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:322 [inline]
 #0: ffffffff8bb8d168 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:322 [inline] kernel/rcu/tree_exp.h:836
 #0: ffffffff8bb8d168 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x2d5/0x620 kernel/rcu/tree_exp.h:836 kernel/rcu/tree_exp.h:836
2 locks held by syz-executor149/3709:
 #0: ffff88801f07a460 (sb_writers#11){.+.+}-{0:0}, at: filename_create+0xf3/0x480 fs/namei.c:3649 fs/namei.c:3649
 #1: ffff88807533e9d0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff88807533e9d0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:818 [inline] fs/namei.c:3654
 #1: ffff88807533e9d0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: filename_create+0x158/0x480 fs/namei.c:3654 fs/namei.c:3654
2 locks held by syz-executor149/3711:
 #0: ffff88801f07a460 (sb_writers#11){.+.+}-{0:0}, at: filename_create+0xf3/0x480 fs/namei.c:3649 fs/namei.c:3649
 #1: ffff88807533e9d0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff88807533e9d0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:818 [inline] fs/namei.c:3654
 #1: ffff88807533e9d0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: filename_create+0x158/0x480 fs/namei.c:3654 fs/namei.c:3654

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 26 Comm: khungtaskd Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 __dump_stack lib/dump_stack.c:88 [inline] lib/dump_stack.c:106
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline] kernel/hung_task.c:295
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline] kernel/hung_task.c:295
 watchdog+0xc1d/0xf50 kernel/hung_task.c:295 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 8 Comm: kworker/u4:0 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:validate_chain kernel/locking/lockdep.c:3808 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:3808 [inline] kernel/locking/lockdep.c:5027
RIP: 0010:__lock_acquire+0xcaa/0x54a0 kernel/locking/lockdep.c:5027 kernel/locking/lockdep.c:5027
Code: ff df 0f b6 04 02 49 89 cf 84 c0 74 08 3c 03 0f 8e 2b 34 00 00 41 8b 44 24 20 25 00 80 04 00 3d 00 00 04 00 0f 84 5e 09 00 00 <48> c7 c2 8c 6a 91 8d 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 0f
RSP: 0018:ffffc90000cd7a60 EFLAGS: 00000087
RAX: 0000000000000000 RBX: 00000000a623e6fc RCX: eeae28e815dd6c6b
RDX: 1ffff110021cec3a RSI: 000000004cd55dcb RDI: ffffffff8ff76c60
RBP: 0000000000000004 R08: 0000000000000000 R09: ffffffff8ff74a07
R10: fffffbfff1fee940 R11: 0000000000000000 R12: ffff888010e761b0
R13: ffff888010e75700 R14: 0000000000000000 R15: eeae28e815dd6c6b
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555840848 CR3: 000000000b88e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire kernel/locking/lockdep.c:5637 [inline] kernel/locking/lockdep.c:5602
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602 kernel/locking/lockdep.c:5602
 rcu_lock_acquire include/linux/rcupdate.h:268 [inline]
 rcu_read_lock include/linux/rcupdate.h:688 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline]
 rcu_lock_acquire include/linux/rcupdate.h:268 [inline] net/batman-adv/network-coding.c:723
 rcu_read_lock include/linux/rcupdate.h:688 [inline] net/batman-adv/network-coding.c:723
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline] net/batman-adv/network-coding.c:723
 batadv_nc_worker+0x12d/0xfa0 net/batman-adv/network-coding.c:723 net/batman-adv/network-coding.c:723
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295 arch/x86/entry/entry_64.S:295
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	df 0f                	fisttps (%rdi)
   2:	b6 04                	mov    $0x4,%dh
   4:	02 49 89             	add    -0x77(%rcx),%cl
   7:	cf                   	iret
   8:	84 c0                	test   %al,%al
   a:	74 08                	je     0x14
   c:	3c 03                	cmp    $0x3,%al
   e:	0f 8e 2b 34 00 00    	jle    0x343f
  14:	41 8b 44 24 20       	mov    0x20(%r12),%eax
  19:	25 00 80 04 00       	and    $0x48000,%eax
  1e:	3d 00 00 04 00       	cmp    $0x40000,%eax
  23:	0f 84 5e 09 00 00    	je     0x987
* 29:	48 c7 c2 8c 6a 91 8d 	mov    $0xffffffff8d916a8c,%rdx <-- trapping instruction
  30:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  37:	fc ff df
  3a:	48 c1 ea 03          	shr    $0x3,%rdx
  3e:	0f                   	.byte 0xf
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	df 0f                	fisttps (%rdi)
   2:	b6 04                	mov    $0x4,%dh
   4:	02 49 89             	add    -0x77(%rcx),%cl
   7:	cf                   	iret
   8:	84 c0                	test   %al,%al
   a:	74 08                	je     0x14
   c:	3c 03                	cmp    $0x3,%al
   e:	0f 8e 2b 34 00 00    	jle    0x343f
  14:	41 8b 44 24 20       	mov    0x20(%r12),%eax
  19:	25 00 80 04 00       	and    $0x48000,%eax
  1e:	3d 00 00 04 00       	cmp    $0x40000,%eax
  23:	0f 84 5e 09 00 00    	je     0x987
* 29:	48 c7 c2 8c 6a 91 8d 	mov    $0xffffffff8d916a8c,%rdx <-- trapping instruction
  30:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  37:	fc ff df
  3a:	48 c1 ea 03          	shr    $0x3,%rdx
  3e:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
