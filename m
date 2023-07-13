Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724E4752871
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjGMQf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 12:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjGMQfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:35:23 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77ED3585
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 09:34:54 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3a41b765478so3152680b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 09:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266026; x=1691858026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3ho6xXohiGptiysxkdNs0zr5VXNkhbGRNFfWgt++Yc=;
        b=J+ruxy2KTMYA8ej8RWsgdJtGVBqRkrtCD071Rl9FQ9n0lJ7rpfTun+HywLlavSGG5n
         NsT7QnRahQK7k1ylC6A3Qke8VVcINUEwjCvznKBT9FhEazRTRl+I8aBnQ4r1+qWIYCSL
         0aszJSHCYYHYTQgwCExLE9WjbnOfKfrhSp2Gke3eKjYBF2x3OOtpu7hRVgO4eB2BvBZj
         +AooD063B3dFNI1EnQLAE9oc8EbM2jtrdw7G8F5NiH5WTVL+p2aQt2faNWkhcWovrRXH
         bL2M6nNSm9dQ0VBqb/eb9qR3AT1GbtCoKpkV6O1sq6Zvtoubg7QzzhxDqu6+y7b5E3/3
         dgEA==
X-Gm-Message-State: ABy/qLYxdEUfVNy50+q1S3dP8s1b8TyaCN/N1PwF6GvK5Gu73VCpWdCC
        sR5gm631dIroOEX+h+k0W06SJKJXsWnvgzjILz6k+wzIF/He
X-Google-Smtp-Source: APBJJlGOyLraT05agNLqXzPVWF56vPakWCVDUWfF0JUTV93KsFJRMN3gxu8G06wGOuoXxNkoeHrPnANRG+gvOvasmzO7JbjRUx5f
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1290:b0:3a4:1484:b3db with SMTP id
 a16-20020a056808129000b003a41484b3dbmr258967oiw.5.1689266026722; Thu, 13 Jul
 2023 09:33:46 -0700 (PDT)
Date:   Thu, 13 Jul 2023 09:33:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000743ce2060060e5ce@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in find_inode_fast (2)
From:   syzbot <syzbot+adfd362e7719c02b3015@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1c7873e33645 mm: lock newly mapped VMA with corrected orde..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d2771ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15873d91ff37a949
dashboard link: https://syzkaller.appspot.com/bug?extid=adfd362e7719c02b3015
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136b54c4a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179ec9d8a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/266e35c3f21e/disk-1c7873e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9cf36dfe8b31/vmlinux-1c7873e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a274cf2ce4d3/bzImage-1c7873e3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3d70fcee5ad3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adfd362e7719c02b3015@syzkaller.appspotmail.com

INFO: task syz-executor173:7462 blocked for more than 143 seconds.
      Not tainted 6.4.0-syzkaller-12454-g1c7873e33645 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor173 state:D stack:25544 pid:7462  ppid:5046   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 __wait_on_freeing_inode fs/inode.c:2240 [inline]
 find_inode_fast+0x319/0x450 fs/inode.c:950
 iget_locked+0xcb/0x830 fs/inode.c:1317
 __ext4_iget+0x261/0x3f30 fs/ext4/inode.c:4670
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1542 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1577 [inline]
 ext4_xattr_set_entry+0x219f/0x3e80 fs/ext4/xattr.c:1719
 ext4_xattr_block_set+0xb12/0x3630 fs/ext4/xattr.c:2025
 ext4_xattr_set_handle+0xcd4/0x15c0 fs/ext4/xattr.c:2442
 ext4_xattr_set+0x241/0x3d0 fs/ext4/xattr.c:2544
 __vfs_setxattr+0x460/0x4a0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x12e/0x5e0 fs/xattr.c:235
 vfs_setxattr+0x221/0x420 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x25d/0x2f0 fs/xattr.c:653
 path_setxattr+0x1c0/0x2a0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9b8cd80509
RSP: 002b:00007f9b841472f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f9b8ce0c550 RCX: 00007f9b8cd80509
RDX: 00000000200005c0 RSI: 0000000020000180 RDI: 00000000200000c0
RBP: 0030656c69662f2e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000002000 R11: 0000000000000246 R12: 00007f9b8cdd2360
R13: 66763d746d66716a R14: 2f30656c69662f2e R15: 00007f9b8ce0c558
 </TASK>
INFO: task syz-executor173:7468 blocked for more than 143 seconds.
      Not tainted 6.4.0-syzkaller-12454-g1c7873e33645 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor173 state:D stack:25768 pid:7468  ppid:5046   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 mb_cache_entry_wait_unused+0x166/0x250 fs/mbcache.c:148
 ext4_evict_ea_inode+0x14a/0x2f0 fs/ext4/xattr.c:480
 ext4_evict_inode+0x184/0xf20 fs/ext4/inode.c:180
 evict+0x2a4/0x620 fs/inode.c:665
 ext4_xattr_set_entry+0x13d4/0x3e80 fs/ext4/xattr.c:1856
 ext4_xattr_block_set+0x69c/0x3630 fs/ext4/xattr.c:1956
 ext4_xattr_set_handle+0xcd4/0x15c0 fs/ext4/xattr.c:2442
 ext4_xattr_set+0x241/0x3d0 fs/ext4/xattr.c:2544
 __vfs_setxattr+0x460/0x4a0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x12e/0x5e0 fs/xattr.c:235
 vfs_setxattr+0x221/0x420 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x25d/0x2f0 fs/xattr.c:653
 path_setxattr+0x1c0/0x2a0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9b8cd80509
RSP: 002b:00007f9b841262f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f9b8ce0c560 RCX: 00007f9b8cd80509
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 00000000200001c0
RBP: 0030656c69662f2e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9b8cdd2360
R13: 66763d746d66716a R14: 2f30656c69662f2e R15: 00007f9b8ce0c568
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8d328af0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8d328eb0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8d328920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
3 locks held by kworker/1:2/2094:
 #0: ffff888012870d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x7e3/0x12c0 kernel/workqueue.c:2569
 #1: ffffc9000786fd20 ((work_completion)(&pwq->unbound_release_work)){+.+.}-{0:0}, at: process_one_work+0x82b/0x12c0 kernel/workqueue.c:2571
 #2: ffffffff8d32dfb8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:325 [inline]
 #2: ffffffff8d32dfb8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x46c/0x890 kernel/rcu/tree_exp.h:992
3 locks held by kworker/0:3/4759:
 #0: ffff888012870d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x7e3/0x12c0 kernel/workqueue.c:2569
 #1: ffffc9000379fd20 ((work_completion)(&pwq->unbound_release_work)){+.+.}-{0:0}, at: process_one_work+0x82b/0x12c0 kernel/workqueue.c:2571
 #2: ffffffff8d32dfb8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:293 [inline]
 #2: ffffffff8d32dfb8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3a3/0x890 kernel/rcu/tree_exp.h:992
2 locks held by getty/4772:
 #0: ffff88802d3c2098
 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015b02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2187
1 lock held by udevd/5050:
2 locks held by kworker/0:2/5052:
 #0: ffff888012870d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x7e3/0x12c0 kernel/workqueue.c:2569
 #1: ffffc90003c0fd20 ((work_completion)(&pwq->unbound_release_work)){+.+.}-{0:0}, at: process_one_work+0x82b/0x12c0 kernel/workqueue.c:2571
2 locks held by kworker/1:3/5060:
 #0: ffff888012870d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x7e3/0x12c0 kernel/workqueue.c:2569
 #1: ffffc90003c9fd20 ((work_completion)(&pwq->unbound_release_work)){+.+.}-{0:0}, at: process_one_work+0x82b/0x12c0 kernel/workqueue.c:2571
1 lock held by udevd/5105:
2 locks held by kworker/0:4/5115:
 #0: ffff888012872538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x7e3/0x12c0 kernel/workqueue.c:2569
 #1: ffffc90003e6fd20 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x82b/0x12c0 kernel/workqueue.c:2571
3 locks held by syz-executor173/7462:
 #0: ffff8880220f2410 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:403
 #1: ffff8880783cf200 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
 #1: ffff8880783cf200 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: vfs_setxattr+0x1e1/0x420 fs/xattr.c:321
 #2: ffff8880783ceec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff8880783ceec8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x274/0x15c0 fs/ext4/xattr.c:2357
3 locks held by syz-executor173/7468:
 #0: ffff8880220f2410 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:403
 #1: ffff88806aed8400 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
 #1: ffff88806aed8400 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: vfs_setxattr+0x1e1/0x420 fs/xattr.c:321
 #2: ffff88806aed80c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff88806aed80c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x274/0x15c0 fs/ext4/xattr.c:2357

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.4.0-syzkaller-12454-g1c7873e33645 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x187/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xec2/0xf00 kernel/hung_task.c:379
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 1 skipped: idling at __intel_idle_hlt drivers/idle/intel_idle.c:205 [inline]
NMI backtrace for cpu 1 skipped: idling at intel_idle_hlt+0x15/0x20 drivers/idle/intel_idle.c:224


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
