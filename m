Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE3C66BFDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjAPNe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 08:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjAPNev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:34:51 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC4E1E280
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 05:34:49 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so21192160iln.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 05:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwcvzN728L5QliwZguaeEyBwZyJYHIOyyKuKBFA/DjE=;
        b=4EPDdWp4J8ir9GxRcC3iBRCtNbWMTbGZAzBJ5kNTpaZEVDvK8+ePLUhvSA5v2yuxbH
         kgszooSGNh4v6ePiSiRWv+/h4GKXlCtmZUe/Zc7uhQWR5FqKERa6t9sF/Y19m/Ooehxm
         JMntlOaW0n5CXO1f0F3N/n+HOgfX3aWCcAlenG5c164DpxLBxJwtBSbi7fQwVBQGDp8o
         aJXin+CKe61nuTJrkSQ2wiuM1RzUShua+y/Fm9kLH95kBmakAbLYvhF2UihD09dH5n1l
         H3aOmVB0Tz2cOFzhwu1Q5lRd0RjrQy2YVZCavxstKB+a/oEXJqMFoUqGylaY6SEC0UUp
         7QZw==
X-Gm-Message-State: AFqh2krlLbE6U8kL2HWN1D/O5QabcSmuqAsekXJ8EfxMDstZvzOvbcnL
        hGLf0FdkGzpcCIExfIOms9pfmEg7zgdlqAExzs2wQPgj0BTa
X-Google-Smtp-Source: AMrXdXuTs9xL4I4fgvm+J5Hch1JYGzpKEl1xoRMmLVa6gUT06lIz+kcnadDf+5Yane9SJ9CKZJWCTqEIIHYYY9/i1nkthnRSENCA
MIME-Version: 1.0
X-Received: by 2002:a92:cda9:0:b0:30e:e796:23b7 with SMTP id
 g9-20020a92cda9000000b0030ee79623b7mr1151386ild.23.1673876088721; Mon, 16 Jan
 2023 05:34:48 -0800 (PST)
Date:   Mon, 16 Jan 2023 05:34:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa9b7405f261a574@google.com>
Subject: [syzbot] [hfs?] INFO: task hung in hfs_mdb_commit
From:   syzbot <syzbot+4fec87c399346da35903@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, kch@nvidia.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e8f60cd7db24 Merge tag 'perf-tools-fixes-for-v6.2-2-2023-0..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13182686480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ebc110f9741920ed
dashboard link: https://syzkaller.appspot.com/bug?extid=4fec87c399346da35903
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ef7fba480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c68186480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfa9ef2acc71/disk-e8f60cd7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/718a64154ab8/vmlinux-e8f60cd7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/616a25151c23/bzImage-e8f60cd7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/099f2b1a07ee/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4fec87c399346da35903@syzkaller.appspotmail.com

INFO: task kworker/1:3:4767 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc3-syzkaller-00030-ge8f60cd7db24 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:22656 pid:4767  ppid:2      flags:0x00004000
Workqueue: events_long flush_mdb
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 io_schedule+0x83/0x100 kernel/sched/core.c:8811
 bit_wait_io+0xe/0xc0 kernel/sched/wait_bit.c:209
 __wait_on_bit_lock+0xbb/0x1a0 kernel/sched/wait_bit.c:90
 out_of_line_wait_on_bit_lock+0x1c3/0x240 kernel/sched/wait_bit.c:117
 lock_buffer include/linux/buffer_head.h:397 [inline]
 hfs_mdb_commit+0xacd/0xf80 fs/hfs/mdb.c:325
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d326f50 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d327750 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8d326d80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by kworker/0:2/898:
 #0: ffff888012872538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc90004e87d00 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
2 locks held by getty/4745:
 #0: ffff88802839c098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015802f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x53b/0x1650 drivers/tty/n_tty.c:2177
2 locks held by kworker/1:3/4767:
 #0: ffff888012871538 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc900038efd00 ((work_completion)(&(&sbi->mdb_work)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
2 locks held by syz-executor208/15791:
 #0: ffff88807c1a0928 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #0: ffff88807c1a0928 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: lock_mount+0x5f/0x2d0 fs/namespace.c:2397
 #1: ffffffff8d32c3f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:292 [inline]
 #1: ffffffff8d32c3f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x384/0x860 kernel/rcu/tree_exp.h:946

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.2.0-rc3-syzkaller-00030-ge8f60cd7db24 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x46f/0x4f0 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1ba/0x420 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcd5/0xd20 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 75 Comm: kworker/u4:4 Not tainted 6.2.0-rc3-syzkaller-00030-ge8f60cd7db24 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events_unbound flush_memcg_stats_dwork
RIP: 0010:trace_lock_acquire+0x66/0x260 include/trace/events/lock.h:24
Code: 0d 0f 86 a4 00 00 00 89 ed 48 89 e8 48 c1 e8 06 48 8d 3c c5 a8 67 96 8e be 08 00 00 00 e8 62 79 76 00 48 0f a3 2d 72 5a 2b 0d <73> 3d 65 ff 05 09 8b 98 7e 48 c7 c0 80 d2 82 8e 48 c1 e8 03 80 3c
RSP: 0018:ffffc90001597778 EFLAGS: 00000057
RAX: 0000000000000001 RBX: dffffc0000000000 RCX: ffffffff816b0d2e
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8e9667a8
RBP: 0000000000000000 R08: dffffc0000000000 R09: fffffbfff1d2ccf6
R10: fffffbfff1d2ccf6 R11: 1ffffffff1d2ccf5 R12: dffffc0000000000
R13: 1ffff920002b2efc R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4bb7e5cc00 CR3: 000000000d08e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0xa4/0x3c0 kernel/locking/lockdep.c:5639
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
 debug_object_activate+0x96/0x6e0 lib/debugobjects.c:665
 debug_timer_activate kernel/time/timer.c:782 [inline]
 __mod_timer+0x837/0xcf0 kernel/time/timer.c:1119
 queue_delayed_work_on+0x125/0x210 kernel/workqueue.c:1701
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
