Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506DF6A50BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 02:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjB1Ba6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 20:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjB1Baw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:30:52 -0500
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9B955B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 17:30:49 -0800 (PST)
Received: by mail-il1-f206.google.com with SMTP id r13-20020a92c5ad000000b00316ecbf63c9so4963262ilt.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 17:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XVOtsS20j6TwpAszdBH5R8uzB/1WiLe+mL7s7CZq0g=;
        b=H87yO79SaFjxum6X4NT21yMTuUjbmfsVWpFWAKTw/ZRi9iQdxUJFrC0cPIqcAaomFX
         bvEHfg0y53/uXd3myqkTOPXMru7a/VHHEhx8PyUWDlMeZREu57yGxboYzcvUv7MgPncV
         fO7QH7u9chEj46hojhs0iB6xgNLKcPsxFNvi0KkN9/5xrekU0TgkmSADYLKOiCaioAfk
         Aa3U+vnqFSv+6eEECpkHRCCEfEfAiKkHMzz47qEI8zM1LBVmCGMumw5gVbjsHDrD9o9l
         ljgVpEU6FGB5JANu4ruRABF2iVRxd0FgdVY8GCJlwrHX3gcKjUGxrHXr19KhRoUprA6g
         HwbQ==
X-Gm-Message-State: AO0yUKVAMVV+9nyA4RXD7O1qyFTgpe0PO4aBw1dicjW37AkqiMCySN/b
        zvzPNErNPOazjJ7whig2pM2EezUf3iRx8zNES6dKRMmcDyN6
X-Google-Smtp-Source: AK7set/SI3qAz2hTZ4NMc/vpWcLm3kTR8JDTmYu6a9NIUCowB469HoiMmoiJZA9vAeA/9H/XqpPpB0T12B4E95z79S6ZpjNyWNH/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2185:b0:3c2:c1c9:8bca with SMTP id
 s5-20020a056638218500b003c2c1c98bcamr7525487jaj.2.1677547848624; Mon, 27 Feb
 2023 17:30:48 -0800 (PST)
Date:   Mon, 27 Feb 2023 17:30:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c7eb105f5b88b70@google.com>
Subject: [syzbot] [xfs?] INFO: task hung in xfs_buf_item_unpin
From:   syzbot <syzbot+3f083e9e08b726fcfba2@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d2980d8d8265 Merge tag 'mm-nonmm-stable-2023-02-20-15-29' ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1762367f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=471a946f0dd5764c
dashboard link: https://syzkaller.appspot.com/bug?extid=3f083e9e08b726fcfba2
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a077d8c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d91c74c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/159d030340e5/disk-d2980d8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d5b1b25dc46/vmlinux-d2980d8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef120fb23cd8/bzImage-d2980d8d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/80ffe04ac396/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f083e9e08b726fcfba2@syzkaller.appspotmail.com

INFO: task kworker/0:1H:52 blocked for more than 143 seconds.
      Not tainted 6.2.0-syzkaller-09238-gd2980d8d8265 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1H    state:D stack:25824 pid:52    ppid:2      flags:0x00004000
Workqueue: xfs-log/loop0 xlog_ioend_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x17d8/0x4990 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2143
 ___down_common+0x33e/0x5e0 kernel/locking/semaphore.c:225
 __down_common+0xcd/0x470 kernel/locking/semaphore.c:246
 down+0x84/0xc0 kernel/locking/semaphore.c:63
 xfs_buf_lock+0x1fa/0x780 fs/xfs/xfs_buf.c:1120
 xfs_buf_item_unpin+0x29b/0x9b0 fs/xfs/xfs_buf_item.c:547
 xfs_trans_committed_bulk+0x346/0x830 fs/xfs/xfs_trans.c:806
 xlog_cil_committed+0x26d/0xfb0 fs/xfs/xfs_log_cil.c:795
 xlog_cil_process_committed+0x159/0x1a0 fs/xfs/xfs_log_cil.c:823
 xlog_state_shutdown_callbacks+0x2ba/0x3b0 fs/xfs/xfs_log.c:538
 xlog_force_shutdown+0x32c/0x390 fs/xfs/xfs_log.c:3837
 xlog_ioend_work+0xad/0x100 fs/xfs/xfs_log.c:1429
 process_one_work+0x915/0x13a0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task syz-executor359:5073 blocked for more than 143 seconds.
      Not tainted 6.2.0-syzkaller-09238-gd2980d8d8265 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor359 state:D stack:23624 pid:5073  ppid:5072   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x17d8/0x4990 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 xlog_wait+0x16e/0x1e0 fs/xfs/xfs_log_priv.h:617
 xlog_wait_on_iclog+0x3a5/0x650 fs/xfs/xfs_log.c:926
 xfs_log_force_seq+0x1da/0x450 fs/xfs/xfs_log.c:3409
 __xfs_trans_commit+0xbcd/0x1130 fs/xfs/xfs_trans.c:1014
 xfs_sync_sb_buf+0x14f/0x1e0 fs/xfs/libxfs/xfs_sb.c:1110
 xfs_ioc_setlabel fs/xfs/xfs_ioctl.c:1801 [inline]
 xfs_file_ioctl+0x1448/0x1850 fs/xfs/xfs_ioctl.c:1899
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fac26e0ff49
RSP: 002b:00007fffe47996f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fffe4799810 RCX: 00007fac26e0ff49
RDX: 0000000020000000 RSI: 0000000041009432 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000140 R09: 0000000000000140
R10: 0000000000000140 R11: 0000000000000246 R12: 00007fffe4799730
R13: 00007fffe4799810 R14: 431bde82d7b634db R15: 00007fffe4799710
 </TASK>

Showing all locks held in the system:
1 lock held by kworker/u4:1/11:
 #0: ffff8880b993be98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:539
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8cf27b70 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:510
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8cf28370 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:510
1 lock held by khungtaskd/28:
 #0: ffffffff8cf279a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by kworker/0:1H/52:
 #0: ffff888027b13138 ((wq_completion)xfs-log/loop0){+.+.}-{0:0}, at: process_one_work+0x77f/0x13a0
 #1: ffffc90000bd7d20 ((work_completion)(&iclog->ic_end_io_work)){+.+.}-{0:0}, at: process_one_work+0x7c6/0x13a0 kernel/workqueue.c:2365
2 locks held by getty/4748:
 #0: ffff88814a02d098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ab/0x1db0 drivers/tty/n_tty.c:2177
1 lock held by syz-executor359/5073:
 #0: ffff888028a02460 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write_file+0x5e/0x1f0 fs/namespace.c:438

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.2.0-syzkaller-09238-gd2980d8d8265 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x4e5/0x560 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x1b4/0x410 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0x1024/0x1070 kernel/hung_task.c:379
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted 6.2.0-syzkaller-09238-gd2980d8d8265 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:mark_lock+0x0/0x340 kernel/locking/lockdep.c:4596
Code: 80 e1 07 80 c1 03 38 c1 0f 8c 73 ff ff ff 4c 89 ff e8 94 06 77 00 e9 66 ff ff ff e8 fa d4 47 09 66 2e 0f 1f 84 00 00 00 00 00 <55> 41 57 41 56 41 55 41 54 53 48 83 ec 10 49 89 f7 48 89 3c 24 49
RSP: 0018:ffffc90000107778 EFLAGS: 00000006
RAX: 0000000000040033 RBX: ffff88801664c580 RCX: ffffffff816c215a
RDX: 0000000000000006 RSI: ffff88801664c580 RDI: ffff88801664ba80
RBP: ffffc90000107828 R08: dffffc0000000000 R09: fffffbfff205b439
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88801664c5a0
R13: 0000000000000005 R14: ffff88801664c4b0 R15: 1ffff11002cc9896
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b384dcb070 CR3: 000000000cd30000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mark_held_locks kernel/locking/lockdep.c:4237 [inline]
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:4263 [inline]
 lockdep_hardirqs_on_prepare+0x3a4/0x7a0 kernel/locking/lockdep.c:4322
 trace_hardirqs_on+0x28/0x40 kernel/trace/trace_preemptirq.c:61
 __text_poke+0x7f8/0xa00 arch/x86/kernel/alternative.c:1644
 text_poke arch/x86/kernel/alternative.c:1669 [inline]
 text_poke_bp_batch+0x485/0x950 arch/x86/kernel/alternative.c:1992
 text_poke_flush arch/x86/kernel/alternative.c:2161 [inline]
 text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:2168
 arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146
 static_key_disable_cpuslocked+0xce/0x1b0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate+0x1b8/0x250 mm/kfence/core.c:804
 process_one_work+0x915/0x13a0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
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
