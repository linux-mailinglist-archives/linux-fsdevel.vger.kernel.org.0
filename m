Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDC6CF8EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 03:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjC3B4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 21:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC3B4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:56:45 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD169F
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 18:56:43 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id b12-20020a6bb20c000000b007585c93862aso10736551iof.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 18:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680141403; x=1682733403;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5N0H4ymCjh9wzGxcMajFTZh5WCGao2MuZfKfdGwves8=;
        b=jRVbLPUeWZbR4bh6Qu5AgRry2cumZ/hrKwN1D16d6xCKQNW65YTX3Wivbyn0G3mmqR
         EdyUAseMheHC32/gnzKJRASudc4S7BvQMXwxShFz2/8QMZPUwq/Ojvk2Lfc8Skr3WtaY
         24gQvR0f+WaFTfa39dIWcxVQUoffWnQLd8V17GQtdAEqpGNVfzeOtY/R8IQBTFPnHe7p
         XYm5fk7FthoZ5KK3gYHfJR76rnPPhx8jQuMme8mEIOPOhvymGH/JgzKIFLgXMjVt+pOU
         2q0pksQ27O75HTm5YSq0sNOFEqyCHlys/4F/SHgkScdJm7pdrem3DTAgLVKnorQ/arwh
         kaUQ==
X-Gm-Message-State: AO0yUKVJllWfcXOznNgh9T2LvL9eGeRCyypHuCwj2igSVCEXHYI0OYvi
        clckA0Z74YUsGlG65OaVSLfFj8sT7GMic+dyfggEhbwKzxWN
X-Google-Smtp-Source: AK7set/IOtUwwx5RdJZpxvyS1jwBWAD6QZdcvMELk0H+2xYQdP1j1gsp5BPOJXJjHMgwc6CgR/7IRIQjA7PNEtLNsElT4rUHuOlN
MIME-Version: 1.0
X-Received: by 2002:a5e:8908:0:b0:745:4154:b571 with SMTP id
 k8-20020a5e8908000000b007454154b571mr7950941ioj.3.1680141403215; Wed, 29 Mar
 2023 18:56:43 -0700 (PDT)
Date:   Wed, 29 Mar 2023 18:56:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082de1c05f81467ed@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in deactivate_super (2)
From:   syzbot <syzbot+aa7397130ec6a8c2e2d9@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4bdec23f971b Merge tag 'hwmon-for-v6.3-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c90be5c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=aa7397130ec6a8c2e2d9
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a5040aa82cfc/disk-4bdec23f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e72022149541/vmlinux-4bdec23f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea0702be72a9/bzImage-4bdec23f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa7397130ec6a8c2e2d9@syzkaller.appspotmail.com

INFO: task syz-executor.2:5116 blocked for more than 143 seconds.
      Not tainted 6.3.0-rc3-syzkaller-00322-g4bdec23f971b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:20992 pid:5116  ppid:1      flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x173b/0x4630 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6757
 rwsem_down_write_slowpath+0xedd/0x13a0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1aa/0x200 kernel/locking/rwsem.c:1306
 deactivate_super+0xad/0xf0 fs/super.c:361
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f226468d567
RSP: 002b:00007ffc2a9420b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f226468d567
RDX: 00007ffc2a94218b RSI: 000000000000000a RDI: 00007ffc2a942180
RBP: 00007ffc2a942180 R08: 00000000ffffffff R09: 00007ffc2a941f50
R10: 0000555555bcc8b3 R11: 0000000000000246 R12: 00007f22646e6b74
R13: 00007ffc2a943240 R14: 0000555555bcc810 R15: 00007ffc2a943280
 </TASK>
INFO: task syz-executor.3:17448 blocked for more than 143 seconds.
      Not tainted 6.3.0-rc3-syzkaller-00322-g4bdec23f971b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:24872 pid:17448 ppid:5104   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x173b/0x4630 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 jfs_flush_journal+0x733/0xec0 fs/jfs/jfs_logmgr.c:1564
 jfs_sync_fs+0x80/0xa0 fs/jfs/super.c:684
 iterate_supers+0x12b/0x1e0 fs/super.c:745
 ksys_sync+0xdb/0x1c0 fs/sync.c:104
 __do_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f00b0c8c0f9
RSP: 002b:00007f00af7fe168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f00b0dabf80 RCX: 00007f00b0c8c0f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f00b0ce7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff50002ebf R14: 00007f00af7fe300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.4:17450 blocked for more than 144 seconds.
      Not tainted 6.3.0-rc3-syzkaller-00322-g4bdec23f971b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:24728 pid:17450 ppid:5110   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x173b/0x4630 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6757
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common+0x61/0x2c0 kernel/locking/rwsem.c:1250
 iterate_supers+0xb0/0x1e0 fs/super.c:743
 ksys_sync+0xbd/0x1c0 fs/sync.c:102
 __do_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f030608c0f9
RSP: 002b:00007f0306d49168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f03061abf80 RCX: 00007f030608c0f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f03060e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd20fdb81f R14: 00007f0306d49300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8cf255f0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:510
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8cf25df0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:510
1 lock held by khungtaskd/28:
 #0: ffffffff8cf25420 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/4750:
 #0: ffff888028196098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015c02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ab/0x1db0 drivers/tty/n_tty.c:2177
1 lock held by syz-executor.2/5116:
 #0: ffff88803e8e60e0 (&type->s_umount_key#79){++++}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:361
1 lock held by syz-executor.3/17448:
 #0: ffff88803e8e60e0 (&type->s_umount_key#79){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:743
1 lock held by syz-executor.4/17450:
 #0: ffff88803e8e60e0 (&type->s_umount_key#79){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:743
1 lock held by syz-executor.4/17517:
 #0: ffff88803e8e60e0 (&type->s_umount_key#79){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:743

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.3.0-rc3-syzkaller-00322-g4bdec23f971b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x187/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xec2/0xf00 kernel/hung_task.c:379
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 9 Comm: kworker/u4:0 Not tainted 6.3.0-rc3-syzkaller-00322-g4bdec23f971b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: bat_events batadv_nc_worker
RIP: 0010:debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
RIP: 0010:do_raw_spin_lock+0x83/0x3a0 kernel/locking/spinlock_debug.c:114
Code: 40 48 c1 ee 03 48 b8 f1 f1 f1 f1 04 f3 f3 f3 48 89 f1 48 89 74 24 38 48 89 04 16 48 8d 5f 04 48 89 d8 48 c1 e8 03 0f b6 04 10 <84> c0 0f 85 1c 02 00 00 8b 03 3d ad 4e ad de 0f 85 5c 01 00 00 49
RSP: 0018:ffffc900000e7a80 EFLAGS: 00000a07
RAX: 0000000000000000 RBX: ffff88803a8f5f84 RCX: 1ffff9200001cf58
RDX: dffffc0000000000 RSI: 1ffff9200001cf58 RDI: ffff88803a8f5f80
RBP: ffffc900000e7b50 R08: dffffc0000000000 R09: fffffbfff205be54
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88803a8f5f80
R13: dffffc0000000000 R14: ffff8880205d6d00 R15: ffff8880205d6d10
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561274c7f150 CR3: 000000000cd30000 CR4: 00000000003506f0
DR0: 00000000ffff070c DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 spin_lock_bh include/linux/spinlock.h:355 [inline]
 batadv_nc_purge_paths+0xe8/0x3a0 net/batman-adv/network-coding.c:442
 batadv_nc_worker+0x30f/0x5c0 net/batman-adv/network-coding.c:722
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
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
