Return-Path: <linux-fsdevel+bounces-2771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF6C7E8F7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 11:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39493280D22
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0975D8832;
	Sun, 12 Nov 2023 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389838BEC
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 10:32:28 +0000 (UTC)
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9F83A85
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 02:32:21 -0800 (PST)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1cc41aed6a5so34130065ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 02:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699785141; x=1700389941;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TwpkfrO+VD8PYoSYFDsos42TPwFSVzoVHttg8Y3bBTg=;
        b=d4bZ/gIOKk/LSMDyADjWP+a5vSOHyyftutRJTREnwvK3W+8QXhBEEggiGf4HrrLtrP
         79n4rzqqUD+1/ySN5b5zxEfKXvBgiIeRJEdxK2Q4Thed83e/TzcxxaH1CJvuOfsrFECj
         h25ECYZimDWMg+LniIvrg17kHR+9fUbB5bZCTdApJprArf9V/lgdoHvEGqOBxOKUO4ok
         xb/mi28QSqW4JZr+B5DLHDumtv10d6FJuqRhAohVKTavJmI4yRZbF6B5K2ME16tkjloy
         nlMQklGlNl+0i0jVeUDq7EP9I1EM2rpBcKZbsTfYEg1VOQYjKzjeD7ZzBvXsMeD4UfXa
         rGQw==
X-Gm-Message-State: AOJu0Ywt9IUZQFF9BjnwQiU3iIZuZtKGeqk1ACV6CjEUT6gZtDsIHEbv
	GtyaJV0dN/nfAWnrdRy78zi8444iMPrxFXSWjA+bYmXspY3F
X-Google-Smtp-Source: AGHT+IGOqxAxTrSA+gL0fIf4FEJv2usahEeBJ/s2g42qr+AeWsqNvvreBdXEx1kjOsRC3HVpKoofFvB98K7nZsSiSOKnN9AbVNDc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:496:b0:1cc:4136:2b4b with SMTP id
 jj22-20020a170903049600b001cc41362b4bmr1153978plb.4.1699785141053; Sun, 12
 Nov 2023 02:32:21 -0800 (PST)
Date: Sun, 12 Nov 2023 02:32:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086ee720609f21144@google.com>
Subject: [syzbot] [usb?] [kernfs?] INFO: task hung in kernfs_remove_by_name_ns (2)
From: syzbot <syzbot+6d5664213a6db9a5a72c@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d2f51b3516da Merge tag 'rtc-6.7' of git://git.kernel.org/p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10e2e3cf680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2021722a434c0122
dashboard link: https://syzkaller.appspot.com/bug?extid=6d5664213a6db9a5a72c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154bc7b0e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13febd7b680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44b35e47f449/disk-d2f51b35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3024be63176/vmlinux-d2f51b35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/795a9fa6dcf3/bzImage-d2f51b35.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d5664213a6db9a5a72c@syzkaller.appspotmail.com

INFO: task kworker/0:2:1113 blocked for more than 143 seconds.
      Not tainted 6.6.0-syzkaller-14651-gd2f51b3516da #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D
 stack:24880 pid:1113  tgid:1113  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xc71/0x3050 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 rwsem_down_write_slowpath+0x53d/0x12a0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d3/0x200 kernel/locking/rwsem.c:1580
 kernfs_remove_by_name_ns+0x87/0x120 fs/kernfs/dir.c:1668
 device_remove_sys_dev_entry drivers/base/core.c:3464 [inline]
 device_del+0x84e/0xa50 drivers/base/core.c:3794
 device_unregister+0x1d/0xc0 drivers/base/core.c:3855
 device_destroy+0x9a/0xd0 drivers/base/core.c:4414
 usb_deregister_dev+0x70/0x1e0 drivers/usb/core/file.c:184
 imon_disconnect+0x57f/0x660 drivers/media/rc/imon.c:2527
 usb_unbind_interface+0x1dd/0x8d0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3814
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
 usb_disconnect+0x2e1/0x910 drivers/usb/core/hub.c:2260
 hub_port_connect drivers/usb/core/hub.c:5303 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5603 [inline]
 port_event drivers/usb/core/hub.c:5763 [inline]
 hub_event+0x1be0/0x4f40 drivers/usb/core/hub.c:5845
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: task udevd:2397 blocked for more than 144 seconds.
      Not tainted 6.6.0-syzkaller-14651-gd2f51b3516da #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:26672 pid:2397  tgid:2397  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xc71/0x3050 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 rwsem_down_read_slowpath+0x61e/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xf0/0x470 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
 d_revalidate fs/namei.c:862 [inline]
 d_revalidate fs/namei.c:859 [inline]
 lookup_fast+0x232/0x520 fs/namei.c:1655
 walk_component+0x5b/0x5a0 fs/namei.c:1998
 link_path_walk.part.0.constprop.0+0x71f/0xce0 fs/namei.c:2329
 link_path_walk fs/namei.c:2254 [inline]
 path_openat+0x240/0x2c40 fs/namei.c:3775
 do_filp_open+0x1de/0x430 fs/namei.c:3809
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f5eaee1b9a4
RSP: 002b:00007ffec94fca10 EFLAGS: 00000246
 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f5eaee1b9a4
RDX: 0000000000080000 RSI: 00007ffec94fcb48 RDI: 00000000ffffff9c
RBP: 00007ffec94fcb48 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055f152075b42 R14: 0000000000000001 R15: 0000000000000000
 </TASK>
INFO: task udevd:2519 blocked for more than 145 seconds.
      Not tainted 6.6.0-syzkaller-14651-gd2f51b3516da #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:27936 pid:2519  tgid:2519  ppid:2397   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xc71/0x3050 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 rwsem_down_read_slowpath+0x61e/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xf0/0x470 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
 d_revalidate fs/namei.c:862 [inline]
 d_revalidate fs/namei.c:859 [inline]
 lookup_fast+0x232/0x520 fs/namei.c:1655
 walk_component+0x5b/0x5a0 fs/namei.c:1998
 link_path_walk.part.0.constprop.0+0x71f/0xce0 fs/namei.c:2329
 link_path_walk fs/namei.c:2254 [inline]
 path_openat+0x240/0x2c40 fs/namei.c:3775
 do_filp_open+0x1de/0x430 fs/namei.c:3809
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f5eaee1b9a4
RSP: 002b:00007ffec94fc860 EFLAGS: 00000246
 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f5eaee1b9a4
RDX: 0000000000080000 RSI: 00007ffec94fc998 RDI: 00000000ffffff9c
RBP: 00007ffec94fc998 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055f152075b42 R14: 0000000000000001 R15: 000055f153a28910
 </TASK>
INFO: task udevd:2526 blocked for more than 146 seconds.
      Not tainted 6.6.0-syzkaller-14651-gd2f51b3516da #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:27376 pid:2526  tgid:2526  ppid:2397   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xc71/0x3050 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 rwsem_down_read_slowpath+0x61e/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xf0/0x470 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
 d_revalidate fs/namei.c:862 [inline]
 d_revalidate fs/namei.c:859 [inline]
 lookup_fast+0x232/0x520 fs/namei.c:1655
 walk_component+0x5b/0x5a0 fs/namei.c:1998
 link_path_walk.part.0.constprop.0+0x71f/0xce0 fs/namei.c:2329
 link_path_walk fs/namei.c:2253 [inline]
 path_lookupat+0x93/0x770 fs/namei.c:2482
 filename_lookup+0x1e7/0x5b0 fs/namei.c:2512
 user_path_at_empty+0x42/0x60 fs/namei.c:2911
 do_readlinkat+0xdd/0x310 fs/stat.c:490
 __do_sys_readlink fs/stat.c:523 [inline]
 __se_sys_readlink fs/stat.c:520 [inline]
 __x64_sys_readlink+0x78/0xb0 fs/stat.c:520
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f5eaee1cd47
RSP: 002b:00007ffec94fba88 EFLAGS: 00000202
 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 000055f153a3efd0 RCX: 00007f5eaee1cd47
RDX: 0000000000000400 RSI: 00007ffec94fbe98 RDI: 00007ffec94fba98
RBP: 00007ffec94fc2d8 R08: 000055f15207c1fd R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000202 R12: 0000000000000200
R13: 00007ffec94fbe98 R14: 00007ffec94fba98 R15: 000055f152076a04
 </TASK>
INFO: task udevd:2536 blocked for more than 146 seconds.
      Not tainted 6.6.0-syzkaller-14651-gd2f51b3516da #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:28144 pid:2536  tgid:2536  ppid:2397   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xc71/0x3050 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 rwsem_down_read_slowpath+0x61e/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0xf0/0x470 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
 d_revalidate fs/namei.c:862 [inline]
 d_revalidate fs/namei.c:859 [inline]
 lookup_fast+0x232/0x520 fs/namei.c:1655
 walk_component+0x5b/0x5a0 fs/namei.c:1998
 link_path_walk.part.0.constprop.0+0x71f/0xce0 fs/namei.c:2329
 link_path_walk fs/namei.c:2254 [inline]
 path_openat+0x240/0x2c40 fs/namei.c:3775
 do_filp_open+0x1de/0x430 fs/namei.c:3809
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f5eaee1b9a4
RSP: 002b:00007ffec94f8420 EFLAGS: 00000246
 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f5eaee1b9a4
RDX: 0000000000080000 RSI: 00007ffec94f8558 RDI: 00000000ffffff9c
RBP: 00007ffec94f8558 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055f152075b42 R14: 0000000000000001 R15: 000055f152091160
 </TASK>

Showing all locks held in the system:
10 locks held by kworker/0:0/8:
6 locks held by kworker/0:1/9:
1 lock held by khungtaskd/29:
 #0: 
ffffffff87ead2e0
 (
rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
6 locks held by kworker/0:2/1113:
 #0: 
ffff88810967ed38
 ((wq_completion)usb_hub_wq){+.+.}-{0:0}
, at: process_one_work+0x787/0x15c0 kernel/workqueue.c:2605
 #1: 
ffffc9000278fd80
 (
(work_completion)(&hub->events)
){+.+.}-{0:0}
, at: process_one_work+0x7e9/0x15c0 kernel/workqueue.c:2606
 #2: 
ffff888105fc4190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5791
 #3: 
ffff888117723190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: usb_disconnect+0x10a/0x910 drivers/usb/core/hub.c:2251
 #4: 
ffff88810feec160
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:992 [inline]
, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: 
ffff88810165d948
 (
&root->kernfs_rwsem
){++++}-{3:3}
, at: kernfs_remove_by_name_ns+0x87/0x120 fs/kernfs/dir.c:1668
1 lock held by udevd/2397:
 #0: 
ffff88810165d948
 (&root->kernfs_rwsem
){++++}-{3:3}
, at: kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
2 locks held by getty/2455:
 #0: 
ffff888112eea0a0
 (
&tty->ldisc_sem
){++++}-{0:0}
, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: 
ffffc900000432f0
 (
&ldata->atomic_read_lock
){+.+.}-{3:3}
, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
4 locks held by udevd/2495:
 #0: ffff888107be20a0
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xda/0x1280 fs/seq_file.c:182
 #1: 
ffff888112091488
 (
&of->mutex
){+.+.}-{3:3}
, at: kernfs_seq_start+0x4b/0x460 fs/kernfs/file.c:154
 #2: 
ffff88810bbb4660
 (
kn->active#24
){.+.+}-{0:0}
, at: kernfs_seq_start+0x6f/0x460 fs/kernfs/file.c:155
 #3: ffff888117723190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:997 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
5 locks held by kworker/0:3/2510:
3 locks held by kworker/0:4/2512:
4 locks held by udevd/2513:
 #0: 
ffff88810bf0db08
 (&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xda/0x1280 fs/seq_file.c:182
 #1: 
ffff88811b1fb888
 (
&of->mutex
){+.+.}-{3:3}
, at: kernfs_seq_start+0x4b/0x460 fs/kernfs/file.c:154
 #2: 
ffff88810c3ce578
 (
kn->active#24
){.+.+}-{0:0}
, at: kernfs_seq_start+0x6f/0x460 fs/kernfs/file.c:155
 #3: 
ffff888117727190
 (
&dev->mutex){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:997 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
4 locks held by udevd/2515:
 #0: ffff8881022c4418
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xda/0x1280 fs/seq_file.c:182
 #1: 
ffff888107ee1888
 (
&of->mutex
){+.+.}-{3:3}
, at: kernfs_seq_start+0x4b/0x460 fs/kernfs/file.c:154
 #2: 
ffff8881097e4cb8
 (
kn->active#24
){.+.+}-{0:0}
, at: kernfs_seq_start+0x6f/0x460 fs/kernfs/file.c:155
 #3: 
ffff888117724190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:997 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
3 locks held by kworker/0:6/2516:
4 locks held by udevd/2517:
 #0: ffff888102287e80
 (
&p->lock
){+.+.}-{3:3}
, at: seq_read_iter+0xda/0x1280 fs/seq_file.c:182
 #1: 
ffff88811b1e2c88
 (&of->mutex
){+.+.}-{3:3}
, at: kernfs_seq_start+0x4b/0x460 fs/kernfs/file.c:154
 #2: 
ffff88810c796da0
 (
kn->active
#24
){.+.+}-{0:0}
, at: kernfs_seq_start+0x6f/0x460 fs/kernfs/file.c:155
 #3: 
ffff888117725190
 (
&dev->mutex
){....}-{3:3}
, at: device_lock_interruptible include/linux/device.h:997 [inline]
, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
1 lock held by udevd/2519:
 #0: 
ffff88810165d948
 (&root->kernfs_rwsem
){++++}-{3:3}
, at: kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
1 lock held by udevd/2526:
 #0: 
ffff88810165d948
 (
&root->kernfs_rwsem
){++++}-{3:3}
, at: kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138
1 lock held by udevd/2536:
 #0: 
ffff88810165d948
 (
&root->kernfs_rwsem
){++++}-{3:3}
, at: kernfs_dop_revalidate+0xf0/0x5a0 fs/kernfs/dir.c:1138

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.6.0-syzkaller-14651-gd2f51b3516da #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x26c/0x2d0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
NMI backtrace for cpu 0
CPU: 0 PID: 2514 Comm: kworker/0:5 Not tainted 6.6.0-syzkaller-14651-gd2f51b3516da #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: events_power_efficient gc_worker
RIP: 0010:__sanitizer_cov_trace_switch+0x5a/0x90 kernel/kcov.c:342
Code: 4c 8b 75 00 31 db 4d 85 f6 74 1e 48 8b 74 dd 10 4c 89 e2 4c 89 ef 48 83 c3 01 48 8b 4c 24 28 e8 2c fe ff ff 49 39 de 75 e2 5b <5d> 41 5c 41 5d 41 5e c3 48 83 f8 40 41 bd 07 00 00 00 74 c2 5b 5d
RSP: 0018:ffffc90000007068 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffffffff8688a001 RCX: ffffffff86470150
RDX: ffff88810a3c5700 RSI: 0000000000000007 RDI: 0000000000000001
RBP: ffffffff87502f40 R08: 0000000000000001 R09: 0000000000000007
R10: 0000000000000009 R11: 000000000021a748 R12: 0000000000000009
R13: 0000000000000001 R14: 0000000000000008 R15: 0000000000000009
FS:  0000000000000000(0000) GS:ffff8881f6600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5eaee2835c CR3: 0000000007c9c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 vsnprintf+0x160/0x1870 lib/vsprintf.c:2775
 sprintf+0xcd/0x100 lib/vsprintf.c:3023
 print_time kernel/printk/printk.c:1324 [inline]
 info_print_prefix+0x258/0x350 kernel/printk/printk.c:1350
 record_print_text+0x143/0x410 kernel/printk/printk.c:1399
 printk_get_next_message+0x2ce/0x7c0 kernel/printk/printk.c:2828
 console_emit_next_record kernel/printk/printk.c:2868 [inline]
 console_flush_all+0x3b0/0xd50 kernel/printk/printk.c:2967
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3036
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2303
 dev_vprintk_emit drivers/base/core.c:4850 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4861
 __dev_printk+0xf5/0x270 drivers/base/core.c:4873
 _dev_warn+0xe5/0x120 drivers/base/core.c:4917
 usb_rx_callback_intf0+0x11c/0x1a0 drivers/media/rc/imon.c:1771
 __usb_hcd_giveback_urb+0x359/0x5c0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x389/0x430 drivers/usb/core/hcd.c:1733
 dummy_timer+0x1415/0x35f0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x193/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x20a/0x94b kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xa7/0x110 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x8e/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:lock_acquire+0x1ef/0x510 kernel/locking/lockdep.c:5721
Code: c1 05 3d ec d3 7e 83 f8 01 0f 85 b0 02 00 00 9c 58 f6 c4 02 0f 85 9b 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc9000157fb00 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff920002aff62 RCX: 0000000000000001
RDX: 1ffff11021478c2e RSI: ffffffff8687d280 RDI: ffffffff86a687c0
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff16e2144
R10: ffffffff8b710a27 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff87ead2e0 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 rcu_read_lock include/linux/rcupdate.h:747 [inline]
 gc_worker+0x24d/0x17e0 net/netfilter/nf_conntrack_core.c:1488
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 3.030 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

