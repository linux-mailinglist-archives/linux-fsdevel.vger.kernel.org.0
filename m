Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AD359BF94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 14:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiHVMid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 08:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiHVMib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:38:31 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950F3D129
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 05:38:29 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id v14-20020a6b5b0e000000b0067bc967a6c0so5445616ioh.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 05:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=+sIWXKfGPOr+3Y1EVqGs1nIPuFiMNJjkKxIRQNXQ0Ec=;
        b=Pm3U2JboP61s3AM0giUzqVQ9+42WbELLMBcFoyKhxaFvnVQG6MWU4rYe6t91x6/YkX
         07XX4WCV4ohUCIrARW9IHGQQ/dBQX0NLgyEcDz0eX4wPaXOefZ2x97jvSVIrE5aDGtfo
         5uBDRhnt3WAsJEYZLDu8DAJaGrzzDD1IPK9UdYteEMHHxx70PbuQaN8muOma7cRgf4xD
         1s9FehXbCWD8qIR+DPjvMS51uM9VO8ag7kt/OMEYaultQ2SSqgEpE2MCYR8n5eGgWNEW
         xBDK6M284wJta529ihXW1FO/3eoiGSXTDTAOHF+0MiLQFBZdvudG0smhuBHzpUCMKdsb
         k5pw==
X-Gm-Message-State: ACgBeo10Vm7pytHYHycrh+kVJQh1FDOBdcowBiXSiaDla9Q6h0Kui1hh
        7T/pOo5G+hFrbZZJxi2CEMMxnSTfrBUvSnm3do3IQxXcDtPS
X-Google-Smtp-Source: AA6agR7NrAQytX/3cLmItJNnNE09oSFpZY/9as3isw3EMwF6tCt1vDoxn7ZL2S7VAsBYmUGH+XIXgQZWynHKewzZ2kr78U9f3if2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1394:b0:349:cfc4:1b18 with SMTP id
 w20-20020a056638139400b00349cfc41b18mr3288986jad.163.1661171908956; Mon, 22
 Aug 2022 05:38:28 -0700 (PDT)
Date:   Mon, 22 Aug 2022 05:38:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b569b05e6d3b91b@google.com>
Subject: [syzbot] INFO: task hung in walk_component (5)
From:   syzbot <syzbot+8fba0e0286621ce71edd@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    274a2eebf80c Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=110b183d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=8fba0e0286621ce71edd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13db992d080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1301c1f3080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fba0e0286621ce71edd@syzkaller.appspotmail.com

INFO: task syslogd:2954 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc1-syzkaller-00025-g274a2eebf80c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syslogd         state:D stack:25896 pid: 2954 ppid:     1 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 rwsem_down_read_slowpath+0x59f/0xb10 kernel/locking/rwsem.c:1087
 __down_read_common kernel/locking/rwsem.c:1252 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0xe2/0x450 kernel/locking/rwsem.c:1501
 inode_lock_shared include/linux/fs.h:766 [inline]
 lookup_slow fs/namei.c:1701 [inline]
 walk_component+0x332/0x5a0 fs/namei.c:1993
 link_path_walk.part.0+0x74e/0xe20 fs/namei.c:2320
 link_path_walk fs/namei.c:2245 [inline]
 path_openat+0x262/0x28f0 fs/namei.c:3687
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f600686b697
RSP: 002b:00007ffc893ed6a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055f27b512910 RCX: 00007f600686b697
RDX: 0000000000000d41 RSI: 00007f60069f999a RDI: 00000000ffffff9c
RBP: 00007f60069f999a R08: 00007f60068fb040 R09: 00007f60068fb0c0
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000d41
R13: 000055f27b512a50 R14: 0000000000000003 R15: 000055f27b512a60
 </TASK>
INFO: task udevd:2972 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc1-syzkaller-00025-g274a2eebf80c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27096 pid: 2972 ppid:     1 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 rwsem_down_read_slowpath+0x59f/0xb10 kernel/locking/rwsem.c:1087
 __down_read_common kernel/locking/rwsem.c:1252 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0xe2/0x450 kernel/locking/rwsem.c:1501
 inode_lock_shared include/linux/fs.h:766 [inline]
 lookup_slow fs/namei.c:1701 [inline]
 walk_component+0x332/0x5a0 fs/namei.c:1993
 link_path_walk.part.0+0x74e/0xe20 fs/namei.c:2320
 link_path_walk fs/namei.c:2244 [inline]
 path_lookupat+0xb7/0x840 fs/namei.c:2473
 filename_lookup+0x1ce/0x590 fs/namei.c:2503
 vfs_statx+0x148/0x390 fs/stat.c:228
 vfs_fstatat+0x8c/0xb0 fs/stat.c:255
 __do_sys_newfstatat+0x91/0x110 fs/stat.c:425
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f93c7f7a1da
RSP: 002b:00007fffc0378198 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 0000555918b966a0 RCX: 00007f93c7f7a1da
RDX: 00007fffc03781a8 RSI: 0000555918b847ed RDI: 00000000ffffff9c
RBP: 0000555918e507b8 R08: 0000000002a8adc5 R09: 00007fffc03c7080
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: 00007fffc03781a8
 </TASK>
INFO: task syz-executor412:3612 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc1-syzkaller-00025-g274a2eebf80c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor412 state:D stack:26448 pid: 3612 ppid:  3609 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 rwsem_down_read_slowpath+0x59f/0xb10 kernel/locking/rwsem.c:1087
 __down_read_common kernel/locking/rwsem.c:1252 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0xe2/0x450 kernel/locking/rwsem.c:1501
 inode_lock_shared include/linux/fs.h:766 [inline]
 lookup_slow fs/namei.c:1701 [inline]
 walk_component+0x332/0x5a0 fs/namei.c:1993
 link_path_walk.part.0+0x74e/0xe20 fs/namei.c:2320
 link_path_walk fs/namei.c:2245 [inline]
 path_openat+0x262/0x28f0 fs/namei.c:3687
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f29b1af0238
RSP: 002b:00007ffea611c300 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f29b1af0238
RDX: 0000000000090800 RSI: 00007f29b1b46060 RDI: 00000000ffffff9c
RBP: 0000000000000e1d R08: 0000000000090800 R09: 00007f29b1b46060
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffea611c394
R13: 00007ffea611c3f0 R14: 0000000000000000 R15: 431bde82d7b634db
 </TASK>
INFO: task syz-executor412:3614 blocked for more than 144 seconds.
      Not tainted 6.0.0-rc1-syzkaller-00025-g274a2eebf80c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor412 state:D stack:26960 pid: 3614 ppid:  3612 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 request_wait_answer+0x46d/0x850 fs/fuse/dev.c:407
 __fuse_request_send fs/fuse/dev.c:426 [inline]
 fuse_simple_request+0x71d/0xe50 fs/fuse/dev.c:511
 fuse_lookup_name+0x280/0x630 fs/fuse/dir.c:392
 fuse_lookup.part.0+0xdf/0x390 fs/fuse/dir.c:433
 fuse_lookup+0x70/0x90 fs/fuse/dir.c:429
 __lookup_slow+0x24c/0x460 fs/namei.c:1685
 lookup_slow fs/namei.c:1702 [inline]
 walk_component+0x33f/0x5a0 fs/namei.c:1993
 link_path_walk.part.0+0x74e/0xe20 fs/namei.c:2320
 link_path_walk fs/namei.c:2245 [inline]
 path_openat+0x262/0x28f0 fs/namei.c:3687
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f29b1af05b9
RSP: 002b:00007f29b1aa12f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f29b1b7b4c0 RCX: 00007f29b1af05b9
RDX: 0000000000000042 RSI: 0000000020002080 RDI: ffffffffffffff9c
RBP: 00007f29b1b48084 R08: 0000000000000065 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000065
R13: 00007f29b1b480a8 R14: 31f4000000000002 R15: 00007f29b1b7b4c8
 </TASK>
INFO: task syz-executor412:3616 blocked for more than 144 seconds.
      Not tainted 6.0.0-rc1-syzkaller-00025-g274a2eebf80c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor412 state:D stack:28392 pid: 3616 ppid:  3612 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 rwsem_down_write_slowpath+0x59c/0x11e0 kernel/locking/rwsem.c:1182
 __down_write_common kernel/locking/rwsem.c:1297 [inline]
 __down_write_common kernel/locking/rwsem.c:1294 [inline]
 __down_write kernel/locking/rwsem.c:1306 [inline]
 down_write_nested+0x139/0x150 kernel/locking/rwsem.c:1663
 inode_lock_nested include/linux/fs.h:791 [inline]
 fuse_reverse_inval_entry+0x51/0x540 fs/fuse/dir.c:1167
 fuse_notify_delete fs/fuse/dev.c:1548 [inline]
 fuse_notify fs/fuse/dev.c:1797 [inline]
 fuse_dev_do_write+0x1aab/0x2c00 fs/fuse/dev.c:1872
 fuse_dev_write+0x150/0x1e0 fs/fuse/dev.c:1956
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f29b1af05b9
RSP: 002b:00007f29b1a802f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f29b1b7b4d0 RCX: 00007f29b1af05b9
RDX: 000000000000002c RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007f29b1b48084 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007f29b1b480a8 R14: 31f4000000000002 R15: 00007f29b1b7b4d8
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8bf88770 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8bf88470 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8bf892c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6492
2 locks held by kworker/u4:4/57:
 #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc90001587da8 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
1 lock held by syslogd/2954:
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: lookup_slow fs/namei.c:1701 [inline]
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x332/0x5a0 fs/namei.c:1993
1 lock held by udevd/2972:
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: lookup_slow fs/namei.c:1701 [inline]
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x332/0x5a0 fs/namei.c:1993
2 locks held by getty/3286:
 #0: ffff88814adb2098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002d162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef0/0x13e0 drivers/tty/n_tty.c:2177
1 lock held by syz-executor412/3612:
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: lookup_slow fs/namei.c:1701 [inline]
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x332/0x5a0 fs/namei.c:1993
2 locks held by syz-executor412/3614:
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: lookup_slow fs/namei.c:1701 [inline]
 #0: ffff88806f868150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x332/0x5a0 fs/namei.c:1993
 #1: ffff88806f8685b8 (&fi->mutex){+.+.}-{3:3}, at: fuse_lock_inode+0xce/0x100 fs/fuse/inode.c:468
2 locks held by syz-executor412/3616:
 #0: ffff88814ab26b38 (&fc->killsb){.+.+}-{3:3}, at: fuse_notify_delete fs/fuse/dev.c:1547 [inline]
 #0: ffff88814ab26b38 (&fc->killsb){.+.+}-{3:3}, at: fuse_notify fs/fuse/dev.c:1797 [inline]
 #0: ffff88814ab26b38 (&fc->killsb){.+.+}-{3:3}, at: fuse_dev_do_write+0x2567/0x2c00 fs/fuse/dev.c:1872
 #1: ffff88806f868150 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #1: ffff88806f868150 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: fuse_reverse_inval_entry+0x51/0x540 fs/fuse/dir.c:1167

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.0.0-rc1-syzkaller-00025-g274a2eebf80c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.0.0-rc1-syzkaller-00025-g274a2eebf80c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__sanitizer_cov_trace_cmp8+0x4/0x20 kernel/kcov.c:276
Code: 00 00 00 00 00 90 48 8b 0c 24 89 f2 89 fe bf 04 00 00 00 e9 1e ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 0c 24 <48> 89 f2 48 89 fe bf 06 00 00 00 e9 fc fe ff ff 66 66 2e 0f 1f 84
RSP: 0018:ffffc90000177da0 EFLAGS: 00000046
RAX: 00000042efb73b7f RBX: ffff8880b9b2ae60 RCX: ffffffff816ff959
RDX: 1ffff110173655cf RSI: 00000042efb73b7f RDI: 00000042efb73b7f
RBP: 0000000000000001 R08: 0000000000000007 R09: 7fffffffffffffff
R10: 00000042efb73b7f R11: 0000000000000000 R12: 00000042efb73b7f
R13: 00000042efb73b7f R14: 0000000000000001 R15: 00000042efb73b7f
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe71c5af990 CR3: 000000000bc8e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 tick_nohz_stop_tick kernel/time/tick-sched.c:896 [inline]
 __tick_nohz_idle_stop_tick kernel/time/tick-sched.c:1108 [inline]
 tick_nohz_idle_stop_tick+0x699/0xbf0 kernel/time/tick-sched.c:1129
 cpuidle_idle_call kernel/sched/idle.c:232 [inline]
 do_idle+0x37b/0x590 kernel/sched/idle.c:303
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
 start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:262
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
