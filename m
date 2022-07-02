Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D15642AB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 22:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiGBUFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 16:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiGBUFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 16:05:23 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0694B7DA
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Jul 2022 13:05:19 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id q75-20020a6b8e4e000000b0067275f1e6c4so3178481iod.14
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Jul 2022 13:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gO6LbqIvzCFXHkwMBJfpF/Srm/ST8uGKOnV8FFemMrs=;
        b=YO32QdhYlOiJyNotI4aNW70MIsjI3Nk8OhxkYkCPKmKPZo1EsTorVy/4wPYfgOzVAd
         xWhwH0iHBb6YpmUS9VBaG2mANsDQqOMNhvmLyXTKyQYbNdYbJqCkQz40K91hTI7dE/66
         akRkcuhtOtROMRZrLeAQ1d+pOLR4goEsZP/e+2HXVSEBx9tlDnr73KFvYwQLQudmw8+C
         gtigB4oIHBMswZ5X2VZZOnpzsRJ2agIfYQrD0QrMhvG4uZybW2JJRIRq3rkhGYdueEmy
         Nk6Wd0sPWsHw5UoQ8RscwZN56l1gpxMPn/8h4/rykJJudUgvzspt2AZyJ0eJQ+qh8a2C
         dRFw==
X-Gm-Message-State: AJIora8jzk58zAzSM6NDOc6VxAUGi6slYxkeJsUR1P3aud5DNr4Xoz2T
        nS3ktJPPPYmFNdrojq4IZmROl6XvU9qMBuYSAUc9D/Lh5znp
X-Google-Smtp-Source: AGRyM1viubGLUgClqmQhKBU8USWmgLZbHdH2dfZXoxH2snq5aNgUA+ry7HKRVQP70oy3W8SW85orJdWFuKOwIP9FbPPzx2TaQIM4
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:2da:e6a5:af0b with SMTP id
 g13-20020a056e021a2d00b002dae6a5af0bmr6077053ile.12.1656792319199; Sat, 02
 Jul 2022 13:05:19 -0700 (PDT)
Date:   Sat, 02 Jul 2022 13:05:19 -0700
In-Reply-To: <00000000000056a4cf05d766be6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a713f705e2d805e0@google.com>
Subject: Re: [syzbot] INFO: task hung in do_read_cache_folio
From:   syzbot <syzbot+be946efe33b2d9664348@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    089866061428 Merge tag 'libnvdimm-fixes-5.19-rc5' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13b60400080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=be946efe33b2d9664348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116c61f4080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13805fd4080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be946efe33b2d9664348@syzkaller.appspotmail.com

INFO: task udevd:3614 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:26160 pid: 3614 ppid:  2974 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 io_schedule+0xba/0x130 kernel/sched/core.c:8645
 folio_wait_bit_common+0x4f2/0xa90 mm/filemap.c:1324
 folio_wait_bit mm/filemap.c:1473 [inline]
 folio_wait_locked include/linux/pagemap.h:1028 [inline]
 folio_wait_locked include/linux/pagemap.h:1025 [inline]
 do_read_cache_folio+0x4ff/0x760 mm/filemap.c:3530
 do_read_cache_page mm/filemap.c:3602 [inline]
 read_cache_page+0x59/0x2a0 mm/filemap.c:3611
 read_mapping_page include/linux/pagemap.h:759 [inline]
 read_part_sector+0xf6/0x920 block/partitions/core.c:715
 adfspart_check_ICS+0x9a/0x690 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:147 [inline]
 blk_add_partitions block/partitions/core.c:600 [inline]
 bdev_disk_changed block/partitions/core.c:686 [inline]
 bdev_disk_changed+0x629/0xf60 block/partitions/core.c:653
 blkdev_get_whole+0x18a/0x2d0 block/bdev.c:686
 blkdev_get_by_dev.part.0+0x5ec/0xb90 block/bdev.c:823
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:857
 blkdev_open+0x13c/0x2c0 block/fops.c:481
 do_dentry_open+0x4a1/0x11f0 fs/open.c:848
 do_open fs/namei.c:3520 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3653
 do_filp_open+0x1aa/0x400 fs/namei.c:3680
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f2cc1991697
RSP: 002b:00007fff60a9cbc0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000056135a372c20 RCX: 00007f2cc1991697
RDX: 00000000000a0800 RSI: 000056135a36ab20 RDI: 00000000ffffff9c
RBP: 000056135a36ab20 R08: 0000000000000001 R09: 00007fff60ba0080
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 000056135a368130 R14: 0000000000000001 R15: 000056135a347910
 </TASK>
INFO: task syz-executor325:3615 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor325 state:D stack:27272 pid: 3615 ppid:  3613 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0xa00/0x4b50 kernel/sched/core.c:6458
 schedule+0xd2/0x1f0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
 blkdev_put+0xbc/0x770 block/bdev.c:912
 blkdev_close+0x64/0x80 block/fops.c:495
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xaff/0x2a00 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x2542/0x2600 kernel/signal.c:2857
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f38c3b625e9
RSP: 002b:00007ffe69332538 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: fffffffffffffe00 RBX: 0000000000000003 RCX: 00007f38c3b625e9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000ffff R11: 0000000000000246 R12: 00007ffe693325b0
R13: 00007ffe693325a0 R14: 00007ffe69332590 R15: 000000000000000c
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bd86660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
2 locks held by getty/3288:
 #0: ffff888025b35098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
1 lock held by udevd/3614:
 #0: ffff8881472ee118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb90 block/bdev.c:814
1 lock held by syz-executor325/3615:
 #0: ffff8881472ee118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xbc/0x770 block/bdev.c:912

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:369
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:check_preemption_disabled+0x3e/0x170 lib/smp_processor_id.c:56
Code: 44 8b 25 c5 b6 8a 76 65 8b 1d 2e 0c 8b 76 81 e3 ff ff ff 7f 31 ff 89 de 0f 1f 44 00 00 85 db 74 11 0f 1f 44 00 00 44 89 e0 5b <5d> 41 5c 41 5d 41 5e c3 0f 1f 44 00 00 9c 5b 81 e3 00 02 00 00 31
RSP: 0018:ffffc90000107850 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000020f16 RCX: ffffffff815e59a8
RDX: 0000000000000001 RSI: 0000000000000003 RDI: 0000000000000000
RBP: ffffffff8a285700 R08: 0000000000000000 R09: ffffffff8dbb9157
R10: fffffbfff1b7722a R11: 0000000000000001 R12: 0000000000000001
R13: ffffffff8a2856c0 R14: ffff8880119c1138 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f2dd4a4680 CR3: 000000000ba8e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 rcu_lockdep_current_cpu_online kernel/rcu/tree.c:1185 [inline]
 rcu_lockdep_current_cpu_online+0x2d/0x140 kernel/rcu/tree.c:1177
 rcu_read_lock_held_common kernel/rcu/update.c:112 [inline]
 rcu_read_lock_held_common kernel/rcu/update.c:102 [inline]
 rcu_read_lock_sched_held+0x25/0x70 kernel/rcu/update.c:123
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0x480/0x570 kernel/locking/lockdep.c:5636
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 __get_locked_pte+0x154/0x270 mm/memory.c:1830
 get_locked_pte include/linux/mm.h:2132 [inline]
 __text_poke+0x1b3/0x8e0 arch/x86/kernel/alternative.c:1052
 text_poke arch/x86/kernel/alternative.c:1137 [inline]
 text_poke_bp_batch+0x44a/0x6c0 arch/x86/kernel/alternative.c:1483
 text_poke_flush arch/x86/kernel/alternative.c:1589 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:1586 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1596
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:830
 static_key_enable_cpuslocked+0x1b1/0x260 kernel/jump_label.c:177
 static_key_enable+0x16/0x20 kernel/jump_label.c:190
 toggle_allocation_gate mm/kfence/core.c:811 [inline]
 toggle_allocation_gate+0x100/0x390 mm/kfence/core.c:803
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
----------------
Code disassembly (best guess):
   0:	44 8b 25 c5 b6 8a 76 	mov    0x768ab6c5(%rip),%r12d        # 0x768ab6cc
   7:	65 8b 1d 2e 0c 8b 76 	mov    %gs:0x768b0c2e(%rip),%ebx        # 0x768b0c3c
   e:	81 e3 ff ff ff 7f    	and    $0x7fffffff,%ebx
  14:	31 ff                	xor    %edi,%edi
  16:	89 de                	mov    %ebx,%esi
  18:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1d:	85 db                	test   %ebx,%ebx
  1f:	74 11                	je     0x32
  21:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  26:	44 89 e0             	mov    %r12d,%eax
  29:	5b                   	pop    %rbx
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	41 5c                	pop    %r12
  2d:	41 5d                	pop    %r13
  2f:	41 5e                	pop    %r14
  31:	c3                   	retq
  32:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  37:	9c                   	pushfq
  38:	5b                   	pop    %rbx
  39:	81 e3 00 02 00 00    	and    $0x200,%ebx
  3f:	31                   	.byte 0x31

