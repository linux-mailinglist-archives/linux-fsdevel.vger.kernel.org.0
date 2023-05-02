Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3ED6F3EBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 10:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjEBIEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 04:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjEBIEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 04:04:53 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA7E449E
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 01:04:50 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-330990e0a50so18415835ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 01:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683014690; x=1685606690;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yoxfnkho8Fj3jXP1dtzf+iJcTb58wAVghC70kIn4VLM=;
        b=Ob1vi3ASIvsDxqBji3Qp/RdQTpY/Yxujs+s4f7Ln7bZRINRyWGJBdJvnCSSu7i0oO8
         WbZDpjDvyI1cdEliCJd0Hxs+ArwRanQp1caabV9KtHPMZiHjJ1cat3M+s7VP3yUcjhAU
         SpDDYjWvU0S70pPWV9UHSh2oPUZiFeXnzMSj04uWVbh4gyRZcI3x8XnyYBNPsM9UxB2M
         TqvyvLVgd4dewi5kDhkZDNp5bTmEkSz6ubtEqN+54T190dWCNcrqGSTTy1PyKqc439V2
         40ICy3gj5QS9iZy1OwCU3aY8BHzUuK6oBgeHFgS8cnY9IXQ/2TpXBuiCh84OiqKKQgUw
         E5ww==
X-Gm-Message-State: AC+VfDy6LQG5Yhxcq7f1Xlx4nRMNuVSFq9vRef2okZXGIBn76qYhCfvU
        d05Qu3Ca6Fb+MJayzHqVIYG4vOTPDdYD9QHK56J5YCmvdGbC
X-Google-Smtp-Source: ACHHUZ4D6tE7pvC69QATNBqPWOSdmH+FQkY21OmoP6dFmL7QKVQcjSNvnc8RhLgca9GBs2lAJF0sumIA8K4QEDppuTdsUM23RKDC
MIME-Version: 1.0
X-Received: by 2002:a92:d7c2:0:b0:32e:dd5a:d16d with SMTP id
 g2-20020a92d7c2000000b0032edd5ad16dmr8440275ilq.5.1683014690053; Tue, 02 May
 2023 01:04:50 -0700 (PDT)
Date:   Tue, 02 May 2023 01:04:50 -0700
In-Reply-To: <000000000000b146b505f22720c9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0a68805fab164e5@google.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in queue_log_writer
From:   syzbot <syzbot+d7c9b7185ced98364b13@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bvanassche@acm.org, jack@suse.cz,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    c8c655c34e33 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12c9db44280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d56ffc213bf6bf4a
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c9b7185ced98364b13
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118645f8280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bce9d8280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b41434707a6f/disk-c8c655c3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3051545315a4/vmlinux-c8c655c3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/924dba1778d0/bzImage-c8c655c3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c6297f191793/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7c9b7185ced98364b13@syzkaller.appspotmail.com

INFO: task kworker/u4:5:2412 blocked for more than 143 seconds.
      Not tainted 6.3.0-syzkaller-12378-gc8c655c34e33 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:5    state:D stack:23832 pid:2412  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:5)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 queue_log_writer+0x293/0x2f0 fs/reiserfs/journal.c:2980
 do_journal_begin_r+0x988/0x10e0 fs/reiserfs/journal.c:3101
 journal_begin+0x166/0x400 fs/reiserfs/journal.c:3253
 reiserfs_write_inode+0x1f4/0x2d0 fs/reiserfs/inode.c:1777
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0x9f2/0xdb0 fs/fs-writeback.c:1668
 writeback_sb_inodes+0x54d/0xe70 fs/fs-writeback.c:1894
 wb_writeback+0x294/0xa50 fs/fs-writeback.c:2068
 wb_do_writeback fs/fs-writeback.c:2211 [inline]
 wb_workfn+0x2a5/0xfc0 fs/fs-writeback.c:2251
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task syz-executor302:5808 blocked for more than 144 seconds.
      Not tainted 6.3.0-syzkaller-12378-gc8c655c34e33 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor302 state:D stack:24728 pid:5808  ppid:5003   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 bit_wait+0x16/0xe0 kernel/sched/wait_bit.c:199
 __wait_on_bit+0x64/0x180 kernel/sched/wait_bit.c:49
 __inode_wait_for_writeback+0x153/0x1f0 fs/fs-writeback.c:1477
 inode_wait_for_writeback+0x26/0x40 fs/fs-writeback.c:1489
 evict+0x2b7/0x6b0 fs/inode.c:662
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x50a/0x740 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 d_delete fs/dcache.c:2565 [inline]
 d_delete+0x16f/0x1c0 fs/dcache.c:2554
 xattr_unlink+0x139/0x190 fs/reiserfs/xattr.c:97
 lookup_and_delete_xattr fs/reiserfs/xattr.c:495 [inline]
 reiserfs_xattr_set_handle+0x7bd/0xb00 fs/reiserfs/xattr.c:530
 reiserfs_xattr_set+0x454/0x5b0 fs/reiserfs/xattr.c:634
 trusted_set+0xa7/0xd0 fs/reiserfs/xattr_trusted.c:31
 __vfs_removexattr+0x155/0x1c0 fs/xattr.c:519
 __vfs_removexattr_locked+0x1b0/0x440 fs/xattr.c:554
 vfs_removexattr+0xcf/0x260 fs/xattr.c:576
 ovl_do_removexattr fs/overlayfs/overlayfs.h:273 [inline]
 ovl_removexattr fs/overlayfs/overlayfs.h:281 [inline]
 ovl_make_workdir fs/overlayfs/super.c:1353 [inline]
 ovl_get_workdir fs/overlayfs/super.c:1436 [inline]
 ovl_fill_super+0x6ec5/0x7270 fs/overlayfs/super.c:1992
 mount_nodev+0x64/0x120 fs/super.c:1426
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6a58a51f39
RSP: 002b:00007f6a589f5208 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6a58ad0768 RCX: 00007f6a58a51f39
RDX: 0000000020000080 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 00007f6a58ad0760 R08: 0000000020000480 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6a58ad076c
R13: 00007ffc3484baef R14: 00007f6a589f5300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor302:5819 blocked for more than 144 seconds.
      Not tainted 6.3.0-syzkaller-12378-gc8c655c34e33 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor302 state:D stack:28496 pid:5819  ppid:5003   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 wb_wait_for_completion+0x182/0x240 fs/fs-writeback.c:192
 sync_inodes_sb+0x1aa/0xa60 fs/fs-writeback.c:2730
 sync_filesystem.part.0+0xe6/0x1d0 fs/sync.c:64
 sync_filesystem+0x8f/0xc0 fs/sync.c:43
 reiserfs_remount+0x129/0x1650 fs/reiserfs/super.c:1445
 legacy_reconfigure+0x119/0x180 fs/fs_context.c:633
 reconfigure_super+0x40c/0xa30 fs/super.c:956
 do_remount fs/namespace.c:2701 [inline]
 path_mount+0x1846/0x1e40 fs/namespace.c:3361
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6a58a533fa
RSP: 002b:00007f6a509d4028 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6a509d46b8 RCX: 00007f6a58a533fa
RDX: 00000000200001c0 RSI: 0000000020000100 RDI: 0000000000000000
RBP: 00000000ffffffff R08: 00007f6a509d40c0 R09: 0000000000000000
R10: 0000000001a484bc R11: 0000000000000286 R12: 00000000200001c0
R13: 0000000020000100 R14: 0000000000000000 R15: 00000000200004c0
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c798630 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c798330 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by khungtaskd/28:
 #0: ffffffff8c799240 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6545
2 locks held by kworker/u4:4/58:
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1324 [inline]
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:643 [inline]
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:670 [inline]
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x883/0x15e0 kernel/workqueue.c:2376
 #1: ffffc90001577db0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x15e0 kernel/workqueue.c:2380
2 locks held by kworker/0:2/894:
 #0: ffff888012472538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012472538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888012472538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1324 [inline]
 #0: ffff888012472538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:643 [inline]
 #0: ffff888012472538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:670 [inline]
 #0: ffff888012472538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x883/0x15e0 kernel/workqueue.c:2376
 #1: ffffc90004cdfdb0 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x15e0 kernel/workqueue.c:2380
2 locks held by kworker/u4:5/2412:
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1324 [inline]
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:643 [inline]
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:670 [inline]
 #0: ffff888141a53938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x883/0x15e0 kernel/workqueue.c:2376
 #1: ffffc9000a3a7db0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x15e0 kernel/workqueue.c:2380
2 locks held by getty/4753:
 #0: ffff888027e54098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2176
1 lock held by syz-executor302/4997:
 #0: ffff88802b0620e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xa9/0xd0 fs/super.c:361
2 locks held by syz-executor302/4998:
 #0: ffff88806f9ce0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xa9/0xd0 fs/super.c:361
 #1: ffffffff8c7a46b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:325 [inline]
 #1: ffffffff8c7a46b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3e8/0x770 kernel/rcu/tree_exp.h:992
2 locks held by syz-executor302/5000:
 #0: ffff8880193da0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xa9/0xd0 fs/super.c:361
 #1: ffffffff8c7a46b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:293 [inline]
 #1: ffffffff8c7a46b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x64a/0x770 kernel/rcu/tree_exp.h:992
1 lock held by syz-executor302/5001:
 #0: ffff88807704c0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xa9/0xd0 fs/super.c:361
4 locks held by syz-executor302/5808:
 #0: ffff88807a3400e0 (&type->s_umount_key#41/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
 #1: ffff888076d4e460 (sb_writers#10){.+.+}-{0:0}, at: ovl_make_workdir fs/overlayfs/super.c:1282 [inline]
 #1: ffff888076d4e460 (sb_writers#10){.+.+}-{0:0}, at: ovl_get_workdir fs/overlayfs/super.c:1436 [inline]
 #1: ffff888076d4e460 (sb_writers#10){.+.+}-{0:0}, at: ovl_fill_super+0x1c5e/0x7270 fs/overlayfs/super.c:1992
 #2: ffff888073b1ece0 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff888073b1ece0 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: vfs_removexattr+0xbb/0x260 fs/xattr.c:575
 #3: ffff888073adbe80 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #3: ffff888073adbe80 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: lookup_and_delete_xattr fs/reiserfs/xattr.c:487 [inline]
 #3: ffff888073adbe80 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: reiserfs_xattr_set_handle+0x72c/0xb00 fs/reiserfs/xattr.c:530
2 locks held by syz-executor302/5819:
 #0: ffff888076d4e0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: do_remount fs/namespace.c:2698 [inline]
 #0: ffff888076d4e0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: path_mount+0x1401/0x1e40 fs/namespace.c:3361
 #1: ffff88801ee6c7d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 #1: ffff88801ee6c7d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x190/0xa60 fs/fs-writeback.c:2728
4 locks held by syz-executor302/6995:
 #0: ffff88807dc2c0e0 (&type->s_umount_key#41/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
 #1: ffff88807c150460 (sb_writers#10){.+.+}-{0:0}, at: ovl_make_workdir fs/overlayfs/super.c:1282 [inline]
 #1: ffff88807c150460 (sb_writers#10){.+.+}-{0:0}, at: ovl_get_workdir fs/overlayfs/super.c:1436 [inline]
 #1: ffff88807c150460 (sb_writers#10){.+.+}-{0:0}, at: ovl_fill_super+0x1c5e/0x7270 fs/overlayfs/super.c:1992
 #2: ffff8880739cc520 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff8880739cc520 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: vfs_removexattr+0xbb/0x260 fs/xattr.c:575
 #3: ffff88807390d260 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #3: ffff88807390d260 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: lookup_and_delete_xattr fs/reiserfs/xattr.c:487 [inline]
 #3: ffff88807390d260 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: reiserfs_xattr_set_handle+0x72c/0xb00 fs/reiserfs/xattr.c:530
2 locks held by syz-executor302/7005:
 #0: ffff88807c1500e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: do_remount fs/namespace.c:2698 [inline]
 #0: ffff88807c1500e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: path_mount+0x1401/0x1e40 fs/namespace.c:3361
 #1: ffff8881417e27d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 #1: ffff8881417e27d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x190/0xa60 fs/fs-writeback.c:2728

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.3.0-syzkaller-12378-gc8c655c34e33 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2a4/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe16/0x1090 kernel/hung_task.c:379
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 894 Comm: kworker/0:2 Not tainted 6.3.0-syzkaller-12378-gc8c655c34e33 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: rcu_gp process_srcu
RIP: 0010:do_raw_spin_lock+0x1ac/0x2b0 kernel/locking/spinlock_debug.c:118
Code: 03 65 4c 8b 24 25 c0 bb 03 00 80 3c 02 00 0f 85 e3 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 65 10 48 c7 04 03 00 00 00 00 <48> 8b 44 24 60 65 48 2b 04 25 28 00 00 00 0f 85 c6 00 00 00 48 83
RSP: 0018:ffffc90004cdfa80 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 1ffff9200099bf51 RCX: ffffffff81666574
RDX: 1ffffffff23f75a2 RSI: 0000000000000004 RDI: ffffc90004cdfaa8
RBP: ffffffff91fbad00 R08: 0000000000000001 R09: 0000000000000003
R10: fffff5200099bf55 R11: 0000000000000000 R12: ffff88801f738000
R13: ffffffff91fbad10 R14: 0000000000000000 R15: 1ffff9200099bf6a
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6a509d4718 CR3: 000000000c571000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x45/0x60 kernel/locking/spinlock.c:162
 debug_object_activate+0x134/0x3f0 lib/debugobjects.c:690
 debug_work_activate kernel/workqueue.c:517 [inline]
 __queue_work+0x614/0x1120 kernel/workqueue.c:1525
 __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1674
 queue_delayed_work_on+0x109/0x120 kernel/workqueue.c:1710
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
