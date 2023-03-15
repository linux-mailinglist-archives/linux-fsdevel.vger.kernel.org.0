Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3126BA595
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 04:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCOD2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 23:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCOD2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:28:48 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA2F360AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 20:28:46 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id c13-20020a0566022d0d00b0074cc4ed52d9so8880723iow.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 20:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678850925;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECiNvzD1JpR7QBf80Hg4p0SOYIhDi+NfZjusM0FTKDI=;
        b=JtjT626rWcIc+xGoHj36bOBIM5ab7Hz8KiT3HdGKLcYUaC9dEXemH0g7RRLRfkkik+
         r2rHzajtBaFTZPDSAkriilbWFrj7Tn9ve2FgOZSeA1BWEnK5bEsv0OCjShlsfYq/sXzO
         sl9bgWUcUtkLRlviB2afDz5JesGjxn503ND4wP7lbvS8DLWgDFSIFVdts3XNWFCDgRbb
         C+Gbduec88P9pc6B31AhrQH+FIR8FTCQhXXzb13+QRzJ6BU9G2idVSgrq/Qt/q3JhU2v
         5n5fvrf0hpvO8HP6Pfzxr6W5CqiS2Wgn9LieXoHUGyWnkMgZUp4ZrlOw7lvvifgXuCqw
         q+AA==
X-Gm-Message-State: AO0yUKXtjFKJht5zewl/P+7wActhX4eVylKtpjphjp+KDOZjh54VtNG2
        Xc1ofBipxy7a0N3PHpdjScOE1KxAWkVKzWiLr4ON13COihjZ
X-Google-Smtp-Source: AK7set+QmApVj0ICRJmOpskgyjylBoDGFcOWYzfe50PuOSsHKphgoEA75fYPHti5kCKoRdUDG8do5n/H4A6Ru2azbgec5n2yzOlz
MIME-Version: 1.0
X-Received: by 2002:a02:85e9:0:b0:3fc:e1f5:961a with SMTP id
 d96-20020a0285e9000000b003fce1f5961amr6051201jai.2.1678850925443; Tue, 14 Mar
 2023 20:28:45 -0700 (PDT)
Date:   Tue, 14 Mar 2023 20:28:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ac4cc05f6e7f12b@google.com>
Subject: [syzbot] [f2fs?] INFO: task hung in f2fs_balance_fs
From:   syzbot <syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0988a0ea7919 Merge tag 'for-v6.3-part2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1666fbb0c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3d3396c296c/disk-0988a0ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16cef168e621/vmlinux-0988a0ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4324b131ded6/bzImage-0988a0ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com

INFO: task kworker/u4:11:5360 blocked for more than 143 seconds.
      Not tainted 6.2.0-syzkaller-13467-g0988a0ea7919 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:11   state:D stack:25896 pid:5360  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:5)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0xcce/0x5b20 kernel/sched/core.c:6622
 schedule+0xde/0x1a0 kernel/sched/core.c:6698
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6757
 rwsem_down_write_slowpath+0x3e2/0x1220 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d2/0x200 kernel/locking/rwsem.c:1574
 f2fs_down_write fs/f2fs/f2fs.h:2207 [inline]
 f2fs_balance_fs+0x54e/0x6c0 fs/f2fs/segment.c:427
 f2fs_write_inode+0x582/0xe00 fs/f2fs/inode.c:760
 write_inode fs/fs-writeback.c:1453 [inline]
 __writeback_single_inode+0xd38/0x14d0 fs/fs-writeback.c:1665
 writeback_sb_inodes+0x54d/0xfa0 fs/fs-writeback.c:1891
 __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1962
 wb_writeback+0x8d6/0xdd0 fs/fs-writeback.c:2067
 wb_check_old_data_flush fs/fs-writeback.c:2167 [inline]
 wb_do_writeback fs/fs-writeback.c:2220 [inline]
 wb_workfn+0x88a/0x1340 fs/fs-writeback.c:2248
 process_one_work+0x9bf/0x1820 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8c794e30 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:510
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8c794b30 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:510
1 lock held by khungtaskd/28:
 #0: ffffffff8c795980 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6495
2 locks held by getty/4752:
 #0: ffff88814a459098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015a02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2177
4 locks held by kworker/u4:11/5360:
 #0: ffff888144ade138 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888144ade138 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888144ade138 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888144ade138 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:639 [inline]
 #0: ffff888144ade138 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:666 [inline]
 #0: ffff888144ade138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x86d/0x1820 kernel/workqueue.c:2361
 #1: ffffc900053dfda8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1820 kernel/workqueue.c:2365
 #2: ffff8880205a80e0 (&type->s_umount_key#76){++++}-{3:3}, at: trylock_super+0x21/0x110 fs/super.c:414
 #3: ffff8880813012a8 (&sbi->gc_lock){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2207 [inline]
 #3: ffff8880813012a8 (&sbi->gc_lock){+.+.}-{3:3}, at: f2fs_balance_fs+0x54e/0x6c0 fs/f2fs/segment.c:427
2 locks held by syz-executor.5/13735:
1 lock held by syz-executor.4/13932:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.2.0-syzkaller-13467-g0988a0ea7919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x316/0x3e0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x33f/0x460 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe94/0x11e0 kernel/hung_task.c:379
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 13735 Comm: syz-executor.5 Not tainted 6.2.0-syzkaller-13467-g0988a0ea7919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:__might_sleep+0x21/0x160 kernel/sched/core.c:9975
Code: 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 41 54 41 89 f4 55 48 89 fd 53 65 48 8b 1c 25 80 b8 03 00 <48> 8d 7b 18 48 83 ec 10 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74
RSP: 0018:ffffc9001571e308 EFLAGS: 00000286
RAX: dffffc0000000000 RBX: ffff88803edcba80 RCX: 0000000000000000
RDX: ffff88803edcba80 RSI: 00000000000005ef RDI: ffffffff8a4c5ec0
RBP: ffffffff8a4c5ec0 R08: 0000000000000004 R09: 0000000000000200
R10: 0000000000000001 R11: 0000000000094001 R12: 00000000000005ef
R13: 0000000000000001 R14: dffffc0000000000 R15: 000000000000000b
FS:  00007f3f5dda8700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556b08888 CR3: 0000000079d24000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 down_read+0x19/0x50 kernel/locking/rwsem.c:1519
 check_valid_map fs/f2fs/gc.c:958 [inline]
 gc_data_segment fs/f2fs/gc.c:1510 [inline]
 do_garbage_collect+0x1b42/0x3e30 fs/f2fs/gc.c:1739
 f2fs_gc+0x890/0x20e0 fs/f2fs/gc.c:1837
 f2fs_balance_fs+0x55b/0x6c0 fs/f2fs/segment.c:428
 f2fs_write_single_data_page+0x13f5/0x1930 fs/f2fs/data.c:2897
 f2fs_write_cache_pages+0xce9/0x1ef0 fs/f2fs/data.c:3144
 __f2fs_write_data_pages fs/f2fs/data.c:3295 [inline]
 f2fs_write_data_pages+0x4c7/0x1270 fs/f2fs/data.c:3322
 do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
 filemap_fdatawrite_wbc mm/filemap.c:390 [inline]
 filemap_fdatawrite_wbc+0x147/0x1b0 mm/filemap.c:380
 __filemap_fdatawrite_range+0xb8/0xf0 mm/filemap.c:423
 file_write_and_wait_range+0xce/0x140 mm/filemap.c:781
 f2fs_do_sync_file+0x3a4/0x2a60 fs/f2fs/file.c:273
 f2fs_sync_file+0x13a/0x190 fs/f2fs/file.c:391
 vfs_fsync_range+0x13e/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2452 [inline]
 f2fs_file_write_iter+0x15d6/0x29a0 fs/f2fs/file.c:4727
 __kernel_write_iter+0x262/0x7a0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:885 [inline]
 dump_user_range+0x234/0x700 fs/coredump.c:912
 elf_core_dump+0x277e/0x36e0 fs/binfmt_elf.c:2142
 do_coredump+0x2d28/0x3cc0 fs/coredump.c:762
 get_signal+0x1bff/0x25b0 kernel/signal.c:2845
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:309
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0033:0x7f3f5d08c101
Code: c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:00000000200002f0 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f3f5d1abf80 RCX: 00007f3f5d08c0f9
RDX: 0000000020000000 RSI: 00000000200002f0 RDI: 0000000000000000
RBP: 00007f3f5d0e7ae9 R08: 0000000020000300 R09: 0000000020000300
R10: 0000000020000180 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff58642dbf R14: 00007f3f5dda8300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
