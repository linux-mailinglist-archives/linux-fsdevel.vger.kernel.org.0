Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A158C497
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 10:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbiHHIF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiHHIF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:05:26 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF0DFD2
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Aug 2022 01:05:24 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id v20-20020a5ec114000000b00682428f8d31so4171551iol.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Aug 2022 01:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=69bF94kPkjc0IOjtUYL2V0JW8BcL5DR5+9aWdS/xhQs=;
        b=4cc2pzx9dWcb6bkZHJ6qGqD10qnMe33vlJfPir2a4uC5TScbBIQik0N2SNz4NOiN4b
         jq5MGOFrg8ah2vMyvu2RwqeYr5B8aRGs8zGOyXRjyMKoyP0eeYjPo8yJ0aF9x51C5XLA
         sVHMB+dqPaRK2t2VHdn9VRsp8HdJW4wlGfBQFNvoAjpJRdM8ydjqfKbFSvLsKeJVxfHE
         OGhotY2TXPCaVWdKO3dpZSwpW/3dbj8swTGMfCzV2MG5PGuoUNzbwsOYq/XiwBJKIL9E
         PKkToBdI4bmKnQxxyhUFIuuds/5g6pfAs9YFCPWGZZuzo5RWNWepVIhlJTg2A1i4MgKr
         Q2zA==
X-Gm-Message-State: ACgBeo3xOb4+ut2MInBc0XvVDyKK+ayRPMAqDphd2cif/IXjDec82TUe
        COENQHSyO50QLFNH87J6XDnVJx72IIqzCIzxBpbOsXARXCOE
X-Google-Smtp-Source: AA6agR41NWV6ulCxYVESTIqYelUFP6puG0R6KtCDDCXJ9Ibn+TlQApruE+QcELsZljW5arYx1to3hmnDNvZs5pmLTk0qnXH+snp9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b28:b0:2df:970e:ae3f with SMTP id
 e8-20020a056e020b2800b002df970eae3fmr5768023ilu.300.1659945924099; Mon, 08
 Aug 2022 01:05:24 -0700 (PDT)
Date:   Mon, 08 Aug 2022 01:05:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002709ae05e5b6474c@google.com>
Subject: [syzbot] INFO: task hung in __filemap_get_folio
From:   syzbot <syzbot+0e9dc403e57033a74b1d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ebfe8e080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=0e9dc403e57033a74b1d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e9dc403e57033a74b1d@syzkaller.appspotmail.com

INFO: task syz-executor.1:19798 blocked for more than 147 seconds.
      Not tainted 5.19.0-next-20220808-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:26208 pid:19798 ppid:3629   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 io_schedule+0xba/0x130 kernel/sched/core.c:8714
 folio_wait_bit_common+0x3dd/0xa90 mm/filemap.c:1298
 __folio_lock mm/filemap.c:1664 [inline]
 folio_lock include/linux/pagemap.h:939 [inline]
 folio_lock include/linux/pagemap.h:935 [inline]
 __filemap_get_folio+0xc6d/0xed0 mm/filemap.c:1936
 truncate_inode_pages_range+0x37c/0x1510 mm/truncate.c:378
 ntfs_evict_inode+0x16/0xa0 fs/ntfs3/inode.c:1741
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f50d0c8a7aa
RSP: 002b:00007f50d1d0bf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f50d0c8a7aa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f50d1d0bfe0
RBP: 00007f50d1d0c020 R08: 00007f50d1d0c020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f50d1d0bfe0 R15: 000000002007aa80
 </TASK>

Showing all threads with locks held in the system:
task:rcu_tasks_kthre state:I stack:29000 pid:12    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 rcu_tasks_one_gp+0x3e5/0xc70 kernel/rcu/tasks.h:514
 rcu_tasks_kthread+0x73/0xa0 kernel/rcu/tasks.h:552
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8bf889b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
task:rcu_tasks_trace state:I stack:29120 pid:13    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 rcu_tasks_one_gp+0x3e5/0xc70 kernel/rcu/tasks.h:514
 rcu_tasks_kthread+0x73/0xa0 kernel/rcu/tasks.h:552
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8bf886b0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
task:getty           state:S stack:23392 pid:3288  ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 wait_woken+0x18b/0x1f0 kernel/sched/wait.c:459
 n_tty_read+0x1051/0x13e0 drivers/tty/n_tty.c:2243
 iterate_tty_read drivers/tty/tty_io.c:858 [inline]
 tty_read+0x33a/0x5d0 drivers/tty/tty_io.c:933
 call_read_iter include/linux/fs.h:2186 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x67d/0x930 fs/read_write.c:470
 ksys_read+0x127/0x250 fs/read_write.c:607
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efd62c0e8fe
RSP: 002b:00007fff0e6822e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055bbf57e9910 RCX: 00007efd62c0e8fe
RDX: 0000000000000001 RSI: 00007fff0e682300 RDI: 0000000000000000
RBP: 000055bbf57e9970 R08: 0000000000000007 R09: 000055bbf57eacd0
R10: 0000000000000063 R11: 0000000000000246 R12: 000055bbf57e99ac
R13: 00007fff0e682300 R14: 0000000000000000 R15: 000055bbf57e99ac
 </TASK>
2 locks held by getty/3288:
 #0: ffff88814a08b098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d232f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef0/0x13e0 drivers/tty/n_tty.c:2177
task:kworker/0:17    state:D stack:24880 pid:12659 ppid:2      flags:0x00004000
Workqueue: events key_garbage_collector
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 synchronize_rcu_expedited+0x39a/0x670 kernel/rcu/tree_exp.h:955
 synchronize_rcu+0x2c3/0x370 kernel/rcu/tree.c:3519
 key_garbage_collector+0x3bd/0x910 security/keys/gc.c:292
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
3 locks held by kworker/0:17/12659:
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011864d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000309fda8 (key_gc_work){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffffffff8bf941b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:292 [inline]
 #2: ffffffff8bf941b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x562/0x670 kernel/rcu/tree_exp.h:940
task:kworker/u4:2    state:R  running task     stack:27208 pid:16592 ppid:2      flags:0x00004000
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 pty_write_room drivers/tty/pty.c:133 [inline]
 pty_write_room+0xb3/0xe0 drivers/tty/pty.c:129
 </TASK>
no locks held by kworker/u4:2/16592.
task:kworker/0:9     state:D stack:25896 pid:19133 ppid:2      flags:0x00004000
Workqueue: rcu_gp wait_rcu_exp_gp
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1935
 synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:571 [inline]
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:622 [inline]
 rcu_exp_wait_wake+0x28f/0xf80 kernel/rcu/tree_exp.h:688
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
2 locks held by kworker/0:9/19133:
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011866538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90014d07da8 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
task:syz-executor.1  state:D stack:26208 pid:19798 ppid:3629   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 io_schedule+0xba/0x130 kernel/sched/core.c:8714
 folio_wait_bit_common+0x3dd/0xa90 mm/filemap.c:1298
 __folio_lock mm/filemap.c:1664 [inline]
 folio_lock include/linux/pagemap.h:939 [inline]
 folio_lock include/linux/pagemap.h:935 [inline]
 __filemap_get_folio+0xc6d/0xed0 mm/filemap.c:1936
 truncate_inode_pages_range+0x37c/0x1510 mm/truncate.c:378
 ntfs_evict_inode+0x16/0xa0 fs/ntfs3/inode.c:1741
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f50d0c8a7aa
RSP: 002b:00007f50d1d0bf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f50d0c8a7aa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f50d1d0bfe0
RBP: 00007f50d1d0c020 R08: 00007f50d1d0c020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f50d1d0bfe0 R15: 000000002007aa80
 </TASK>
1 lock held by syz-executor.1/19798:
 #0: ffff8880520700e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
task:syz-executor.4  state:D stack:29248 pid:21701 ppid:3630   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6629
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa44/0x1350 kernel/locking/mutex.c:747
 exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 synchronize_rcu_expedited+0x24a/0x670 kernel/rcu/tree_exp.h:940
 synchronize_rcu+0x2c3/0x370 kernel/rcu/tree.c:3519
 __sched_core_enable kernel/sched/core.c:387 [inline]
 sched_core_get+0x87/0xa0 kernel/sched/core.c:406
 sched_core_alloc_cookie kernel/sched/core_sched.c:18 [inline]
 sched_core_share_pid+0x3d7/0x9a0 kernel/sched/core_sched.c:185
 __do_sys_prctl+0x7de/0x1380 kernel/sys.c:2620
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0781a89279
RSP: 002b:00007f0782c50168 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
RAX: ffffffffffffffda RBX: 00007f0781b9bf80 RCX: 00007f0781a89279
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000000003e
RBP: 00007f0781ae3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcf62129ef R14: 00007f0782c50300 R15: 0000000000022000
 </TASK>
2 locks held by syz-executor.4/21701:
 #0: ffffffff8be5e2c8 (sched_core_mutex){+.+.}-{3:3}, at: sched_core_get+0x37/0xa0 kernel/sched/core.c:404
 #1: ffffffff8bf941b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #1: ffffffff8bf941b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x24a/0x670 kernel/rcu/tree_exp.h:940

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 5.19.0-next-20220808-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x46/0x14f lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x206/0x250 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:227 [inline]
 watchdog+0xcf7/0xfd0 kernel/hung_task.c:384
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 18028 Comm: kworker/0:1 Not tainted 5.19.0-next-20220808-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: events bpf_prog_free_deferred
RIP: 0010:stack_access_ok+0xe3/0x1d0 arch/x86/kernel/unwind_orc.c:347
Code: 03 80 3c 02 00 0f 85 e1 00 00 00 48 8b 73 28 48 89 da 48 89 ef e8 6d af f5 ff 85 c0 74 0f 31 c0 48 83 c4 08 5b 5d 41 5c 41 5d <41> 5e c3 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0018:ffffc9000b827858 EFLAGS: 00000282
RAX: ffffc9000b828001 RBX: 0000000000000001 RCX: 0000000000000001
RDX: ffffc9000b827c01 RSI: ffffc9000b827ce8 RDI: ffffc9000b8278e8
RBP: ffffc9000b827920 R08: ffffffff8e6497f8 R09: ffffc9000b82790c
R10: fffff52001704f26 R11: ffffc9000b827d10 R12: ffffc9000b82790d
R13: ffffc9000b8278d8 R14: ffffc9000b827ce8 R15: ffffffff8e6497fc
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c004477000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 deref_stack_reg arch/x86/kernel/unwind_orc.c:352 [inline]
 unwind_next_frame+0x12b4/0x1cc0 arch/x86/kernel/unwind_orc.c:600
 arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:122
 save_stack+0x151/0x1e0 mm/page_owner.c:127
 __reset_page_owner+0x59/0x170 mm/page_owner.c:148
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 __vunmap+0x85d/0xd30 mm/vmalloc.c:2696
 __vfree+0x3c/0xd0 mm/vmalloc.c:2744
 vfree+0x5a/0x90 mm/vmalloc.c:2775
 bpf_prog_free_deferred+0x614/0x7f0 kernel/bpf/core.c:2562
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
