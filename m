Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886285E81F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 20:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiIWSpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiIWSps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:45:48 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827C11D63E
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 11:45:46 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id f4-20020a056e020b4400b002f6681cca5bso821938ilu.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 11:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=S6GsOm9HuRhd194ifmvaTSpco08TuiUCD9hUWo1fCEM=;
        b=lydbB//dPztoZtAn0X6MsmcBe0bQgAU+WKcgz1kE47ZPeFXsPfQQg23Z+/TpIXrnph
         DVNPjOUMKa76LTGmB72Iltl333WFA+fOEbUB8BCOJ6ef+m2dn6DvXlPYrMJY/aPkvJKd
         Y3WjuBBU78XqBY+jT5YusCtcjEO10VipzmviFCvwpOHLjzMj6IOZwvPwdVnslUnd/WRP
         wNa8cFYbVxpIM2e1RICYhfvDw09i3aXTfidLjhcQNWFn5hP6niwe+ty9y/VKNWJRpt/x
         i/xYyneEljXEjDphqBybvfbLP8kHCZGX+fG/CFi8HTOn8mO/g1ptEbrQcz3xH4i6md9G
         YT4w==
X-Gm-Message-State: ACrzQf1rEXCaNEAVyxTTq4suEp8Hu5eeXCVLxK68EJO68gxP5bSdjRFZ
        6pH/dIVbqi1nLAL9EN1VEM9T3mGaLfUXRgfrD7Ow8/THhHsf
X-Google-Smtp-Source: AMsMyM5PrBFRi2/Rcakqrc4KLjURKmzPao27MSgHPEQhOyQSFpA3He1GvO13/lH+OThpinjYWZqmthlBSwjaO81w8qaSzh8js5M9
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2113:b0:35a:cafe:59be with SMTP id
 n19-20020a056638211300b0035acafe59bemr5579801jaj.234.1663958746156; Fri, 23
 Sep 2022 11:45:46 -0700 (PDT)
Date:   Fri, 23 Sep 2022 11:45:46 -0700
In-Reply-To: <0000000000002709ae05e5b6474c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc539605e95c95be@google.com>
Subject: Re: [syzbot] INFO: task hung in __filemap_get_folio
From:   syzbot <syzbot+0e9dc403e57033a74b1d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    bf682942cd26 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12096640880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7db7ad17eb14cb7
dashboard link: https://syzkaller.appspot.com/bug?extid=0e9dc403e57033a74b1d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116e80ff080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bfbbcf080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e9dc403e57033a74b1d@syzkaller.appspotmail.com

INFO: task udevd:3638 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc6-syzkaller-00210-gbf682942cd26 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:26248 pid: 3638 ppid:  2972 flags:0x00004006
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
 kill_bdev block/bdev.c:75 [inline]
 blkdev_flush_mapping+0x140/0x2f0 block/bdev.c:661
 blkdev_put_whole+0xd1/0xf0 block/bdev.c:692
 blkdev_put+0x226/0x770 block/bdev.c:952
 blkdev_close+0x64/0x80 block/fops.c:499
 __fput+0x277/0x9d0 fs/file_table.c:320
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xad5/0x29b0 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x238c/0x2610 kernel/signal.c:2857
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fea11178697
RSP: 002b:00007ffc3c7fb710 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: 0000000000000008 RBX: 000055b3e78469c0 RCX: 00007fea11178697
RDX: 00000000000a0800 RSI: 000055b3e7818920 RDI: 00000000ffffff9c
RBP: 000055b3e7818920 R08: 0000000000000001 R09: 00007ffc3c816080
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 000055b3e7819a80 R14: 00007ffc3c7fb7bc R15: 000055b3e780b2c0
 </TASK>
INFO: task syz-executor127:3645 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc6-syzkaller-00210-gbf682942cd26 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor127 state:D stack:28376 pid: 3645 ppid:  3635 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6629
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa44/0x1350 kernel/locking/mutex.c:747
 blkdev_get_by_dev.part.0+0x9b/0xb90 block/bdev.c:812
 blkdev_get_by_dev+0x6b/0x80 block/bdev.c:855
 blkdev_open+0x13c/0x2c0 block/fops.c:485
 do_dentry_open+0x4a4/0x13a0 fs/open.c:880
 do_open fs/namei.c:3557 [inline]
 path_openat+0x1c92/0x28f0 fs/namei.c:3691
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1340
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff1e173a4d7
RSP: 002b:00007ffdf8c863c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff1e173a4d7
RDX: 0000000000000000 RSI: 00007ffdf8c86440 RDI: 00000000ffffff9c
RBP: 00007ffdf8c86440 R08: 000000000000ffff R09: 00007ffdf8c862d0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8bf85db0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8bf85ab0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8bf86900 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6492
1 lock held by klogd/2961:
 #0: ffff8880b9a3a018 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:544
2 locks held by getty/3287:
 #0: ffff88801caa6098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90001c482f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef0/0x13e0 drivers/tty/n_tty.c:2177
1 lock held by udevd/3638:
 #0: ffff88801e6644c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xbc/0x770 block/bdev.c:910
1 lock held by syz-executor127/3645:
 #0: ffff88801e6644c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb90 block/bdev.c:812

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.0.0-rc6-syzkaller-00210-gbf682942cd26 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x46/0x14f lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x206/0x250 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc18/0xf50 kernel/hung_task.c:369
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 6.0.0-rc6-syzkaller-00210-gbf682942cd26 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4741 [inline]
RIP: 0010:__lock_acquire+0x574/0x56d0 kernel/locking/lockdep.c:5003
Code: 00 00 45 89 fe 41 83 ee 01 0f 88 7c 13 00 00 49 b9 00 00 00 00 00 fc ff df 49 63 c6 48 8d 04 80 49 8d ac c5 99 0a 00 00 eb 12 <41> 83 ee 01 48 83 ed 28 41 83 fe ff 0f 84 15 0b 00 00 48 8d 5d df
RSP: 0018:ffffc90000d2f738 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff8880174d0af8 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffff908e8dd9
RBP: ffff8880174d0b19 R08: 0000000000000000 R09: dffffc0000000000
R10: fffffbfff211c32a R11: 0000000000000000 R12: ffff8880174d0bc0
R13: ffff8880174d0080 R14: 0000000000000000 R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056317ad90680 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 __get_locked_pte+0x154/0x270 mm/memory.c:1838
 get_locked_pte include/linux/mm.h:2089 [inline]
 __text_poke+0x1b3/0x8e0 arch/x86/kernel/alternative.c:1123
 text_poke arch/x86/kernel/alternative.c:1208 [inline]
 text_poke_bp_batch+0x147/0x6c0 arch/x86/kernel/alternative.c:1487
 text_poke_flush arch/x86/kernel/alternative.c:1660 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:1657 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1667
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:801
 static_key_disable_cpuslocked+0x152/0x1b0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 toggle_allocation_gate mm/kfence/core.c:825 [inline]
 toggle_allocation_gate+0x183/0x390 mm/kfence/core.c:803
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.080 msecs

