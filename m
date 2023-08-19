Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA30D7817B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 08:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbjHSGe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Aug 2023 02:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbjHSGeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:34:01 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8147E64
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 23:33:58 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-689fb672dcdso2355698b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 23:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692426838; x=1693031638;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uclmu811vF/JPxRmxwu4iS3eo4Vz30Lv+AK/h2KhjXY=;
        b=ec4AcURTg75WgNr+++gFw0yuyK9TMxHoGkHXkCwK5ekYx7cD9UZ/FSX1dGvoVfcehq
         vP/4thFWEwjfVPzZCoBPdITNF6/aAFgeJXqvysXRaicCdXlOE9zaJWaSNjeenLq+Z6e8
         lVwRemzWZXRet/fLKErTrL/wj49h1kzUJu5uwJY0ZPZzMhRDS59MEF9/6VLdgfh1Ew0J
         eDHO5otVPU40XJaY7Iby9TJRx7xj9NAehzFXTvpwl4UC8eflbjCv3Su7Iu+0fDIMBx9p
         u/SYnPBCOUxWPPBy8xeeh1ebjeCSCfls+7lw6xddzvKVIhIjkgFaV5eG0P4NArt+v/Y/
         12vw==
X-Gm-Message-State: AOJu0Yxf3EgdiHdmmXnwJI9icCbQYoLcmvnNPZ5uynxCWnxyIxnGN3pu
        zJr1IH36Od58LDVMMxTKVVR7yJI1BZuQxDVYqIrokZ+U/cc+
X-Google-Smtp-Source: AGHT+IG7ITHBidyEa1meq42boqxqzApPqD4e7XlbmPKC8OLJ9jJHjdUCdEqx7XpOprycKIhd/AIkCjdFPRMYyrgaaA2syJtnGe3C
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d8f:b0:688:47b1:a89f with SMTP id
 fb15-20020a056a002d8f00b0068847b1a89fmr785697pfb.3.1692426838427; Fri, 18 Aug
 2023 23:33:58 -0700 (PDT)
Date:   Fri, 18 Aug 2023 23:33:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083513f060340d472@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in path_mount (2)
From:   syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2ccdd1b13c59 Linux 6.5-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16990d53a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
dashboard link: https://syzkaller.appspot.com/bug?extid=fb337a5ea8454f5f1e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba5d53a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14265373a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ecb74567efdf/disk-2ccdd1b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/347764e4bb8e/vmlinux-2ccdd1b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84f1d2de7e10/bzImage-2ccdd1b1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/21e9fff65e06/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com

INFO: task syz-executor415:5343 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor415 state:D stack:25032 pid:5343  ppid:5095   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 rwsem_down_write_slowpath+0xedd/0x13a0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1aa/0x200 kernel/locking/rwsem.c:1306
 do_remount fs/namespace.c:2879 [inline]
 path_mount+0xbdd/0xfa0 fs/namespace.c:3654
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f917fa53c0a
RSP: 002b:00007ffd6ff7f3a8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f917fa53c0a
RDX: 0000000020000180 RSI: 0000000020000100 RDI: 0000000000000000
RBP: 00007ffd6ff7f440 R08: 00007ffd6ff7f440 R09: 0000000000000000
R10: 0000000001a404ac R11: 0000000000000286 R12: 0000000020000100
R13: 0000000020000180 R14: 0000000000000000 R15: 0000000020003600
 </TASK>
INFO: task syz-executor415:5344 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor415 state:D stack:25032 pid:5344  ppid:5089   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 jfs_flush_journal+0x733/0xec0 fs/jfs/jfs_logmgr.c:1564
 jfs_sync_fs+0x80/0xa0 fs/jfs/super.c:684
 dquot_quota_sync+0xdb/0x490 fs/quota/dquot.c:704
 iterate_supers+0x12b/0x1e0 fs/super.c:744
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f917fa525d9
RSP: 002b:00007ffd6ff7f588 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f917fa525d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
RBP: 0000000000000000 R08: 0000000000005d70 R09: 00007ffd6ff7f5b8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd6ff7f5b8
R13: 000000000000001f R14: 00007ffd6ff7f5f0 R15: 431bde82d7b634db
 </TASK>
INFO: task syz-executor415:5345 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor415 state:D stack:25032 pid:5345  ppid:5087   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 iterate_supers+0xb0/0x1e0 fs/super.c:742
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f917fa525d9
RSP: 002b:00007ffd6ff7f588 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f917fa525d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
RBP: 0000000000000000 R08: 0000000000005d70 R09: 00007ffd6ff7f5b8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd6ff7f5b8
R13: 000000000000001d R14: 00007ffd6ff7f5f0 R15: 431bde82d7b634db
 </TASK>
INFO: task syz-executor415:5346 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor415 state:D stack:25032 pid:5346  ppid:5084   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 iterate_supers+0xb0/0x1e0 fs/super.c:742
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f917fa525d9
RSP: 002b:00007ffd6ff7f588 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f917fa525d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
RBP: 0000000000000000 R08: 0000000000005d70 R09: 00007ffd6ff7f5b8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd6ff7f5b8
R13: 000000000000001d R14: 00007ffd6ff7f5f0 R15: 431bde82d7b634db
 </TASK>
INFO: task syz-executor415:5347 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor415 state:D stack:25032 pid:5347  ppid:5086   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 iterate_supers+0xb0/0x1e0 fs/super.c:742
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f917fa525d9
RSP: 002b:00007ffd6ff7f588 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f917fa525d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
RBP: 0000000000000000 R08: 0000000000005d70 R09: 00007ffd6ff7f5b8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd6ff7f5b8
R13: 000000000000001e R14: 00007ffd6ff7f5f0 R15: 431bde82d7b634db
 </TASK>
INFO: task syz-executor415:5348 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor415 state:D stack:25384 pid:5348  ppid:5088   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 iterate_supers+0xb0/0x1e0 fs/super.c:742
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f917fa525d9
RSP: 002b:00007ffd6ff7f588 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f917fa525d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
RBP: 0000000000000000 R08: 0000000000005d70 R09: 00007ffd6ff7f5b8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd6ff7f5b8
R13: 000000000000001e R14: 00007ffd6ff7f5f0 R15: 431bde82d7b634db
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8d3295b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8d329970 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8d3293e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/4779:
 #0: ffff8880291c2098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015b02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2187
2 locks held by kworker/u4:5/5177:
 #0: ffff8880b983bf98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:558
 #1: ffff8880b98287c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3a7/0x770 kernel/sched/psi.c:987
1 lock held by syz-executor415/5343:
 #0: ffff88807aef40e0 (&type->s_umount_key#65){++++}-{3:3}, at: do_remount fs/namespace.c:2879 [inline]
 #0: ffff88807aef40e0 (&type->s_umount_key#65){++++}-{3:3}, at: path_mount+0xbdd/0xfa0 fs/namespace.c:3654
1 lock held by syz-executor415/5344:
 #0: ffff88807aef40e0 (&type->s_umount_key#65){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor415/5345:
 #0: ffff88807aef40e0 (&type->s_umount_key#65){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor415/5346:
 #0: ffff88807aef40e0 (&type->s_umount_key#65){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor415/5347:
 #0: ffff88807aef40e0 (&type->s_umount_key#65){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
1 lock held by syz-executor415/5348:
 #0: ffff88807aef40e0 (&type->s_umount_key#65){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
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
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 6.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: bat_events batadv_mcast_mla_update
RIP: 0010:__orc_find arch/x86/kernel/unwind_orc.c:102 [inline]
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
RIP: 0010:unwind_next_frame+0x495/0x2390 arch/x86/kernel/unwind_orc.c:494
Code: 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 27 48 63 03 48 01 d8 48 8d 4b 04 4c 39 f8 4c 0f 46 e9 <48> 8d 43 fc 48 0f 47 e8 4c 0f 46 e3 49 39 ed 76 a8 e9 aa fd ff ff
RSP: 0018:ffffc90000b27510 EFLAGS: 00000293
RAX: ffffffff81e45b18 RBX: ffffffff8eaf4d20 RCX: ffffffff8eaf4d24
RDX: ffffffff8f205ef4 RSI: 00000000000a0001 RDI: ffffffff813c8bc0
RBP: ffffffff8eaf4d28 R08: 0000000000000011 R09: ffffc90000b276d0
R10: ffffc90000b27630 R11: fffff52000164ec8 R12: ffffffff8eaf4d18
R13: ffffffff8eaf4d24 R14: ffffffff8eaf4d0c R15: ffffffff81e45b5e
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a25c82a600 CR3: 000000000d130000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x111/0x140 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x117/0x1c0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook mm/slub.c:1818 [inline]
 slab_free mm/slub.c:3801 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3814
 batadv_mcast_mla_list_free net/batman-adv/multicast.c:638 [inline]
 __batadv_mcast_mla_update net/batman-adv/multicast.c:893 [inline]
 batadv_mcast_mla_update+0x380a/0x3bb0 net/batman-adv/multicast.c:915
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2600
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2751
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
