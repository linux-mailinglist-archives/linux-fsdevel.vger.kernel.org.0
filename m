Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4037B7636
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 03:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbjJDBU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 21:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbjJDBUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:20:55 -0400
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D57B0
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 18:20:50 -0700 (PDT)
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-57b7aefb23aso1822631eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 18:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696382450; x=1696987250;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Z7Wm/Qlb7bXo3BfpGcBcHWS4b/ykjWkuu5nwBzEuuM=;
        b=TIxxDIIWzs/l5DxClh8D2WBk1XsvkhIf/FGhAOLChTr+qrzvox3OKQaHJEM2xBo5RB
         WrovR3HztkOEjD1eYk2756AIsoioLS2m5b3Cf8WtzxdEuCJevu9220JWswoEAQYhnKnC
         7vp1BKrE6y8F9dZV9GWgNr74VTNPY5m4kH+W8rWCB9+cJ9X7rRr2DA69+6kAA0XisVy4
         L/Fg402ZofzQeC/m20wZBM7hX59OdFe1O0Th5q44JZs1gLrw+W9EBGIzYHGBJK0cr5XG
         REYVubj0lmjrN7+w2JEKpIqGced27X0bx0AYCaxJU1a6vq/KPuPItkLk8k0wwQgpOMRl
         AMow==
X-Gm-Message-State: AOJu0Yx9FthKBuDll7uqKP5w66Isf5IP+wAVA1btyzVUu9B3vkZWEzib
        YMP0EDhD1sleo9iP1tRIFaq+fb8h0BIyYcsVKJvsmYg0bGAE
X-Google-Smtp-Source: AGHT+IFZD4kFhP+psborcucj6J2PKY0Sc5plWg0iUXqapgr1ygQLWshGIb266vhqMV1uKFBY5p7S6TpV5aBvakGzUJzweRAvCnQo
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e502:b0:1e1:15ca:2aa1 with SMTP id
 y2-20020a056870e50200b001e115ca2aa1mr457003oag.11.1696382449661; Tue, 03 Oct
 2023 18:20:49 -0700 (PDT)
Date:   Tue, 03 Oct 2023 18:20:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050bbd30606d9d1eb@google.com>
Subject: [syzbot] [btrfs?] INFO: task hung in btrfs_page_mkwrite
From:   syzbot <syzbot+bdcacd75b712b0147ca7@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e81a2dabc3f3 Merge tag 'kbuild-fixes-v6.6-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16751e92680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=bdcacd75b712b0147ca7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b9e2f8a9b7db/disk-e81a2dab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4bc70c999ec/vmlinux-e81a2dab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/541a5ce45216/bzImage-e81a2dab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdcacd75b712b0147ca7@syzkaller.appspotmail.com

INFO: task syz-executor.0:18661 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc3-syzkaller-00252-ge81a2dabc3f3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:24808 pid:18661 ppid:18152  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x196c/0x4af0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 io_schedule+0x8c/0x100 kernel/sched/core.c:9026
 folio_wait_bit_common+0x881/0x12a0 mm/filemap.c:1301
 btrfs_page_mkwrite+0x4a4/0xd10 fs/btrfs/inode.c:8133
 do_page_mkwrite+0x197/0x470 mm/memory.c:2931
 wp_page_shared mm/memory.c:3291 [inline]
 do_wp_page+0xf87/0x4190 mm/memory.c:3376
 handle_pte_fault mm/memory.c:4994 [inline]
 __handle_mm_fault mm/memory.c:5119 [inline]
 handle_mm_fault+0x1b45/0x62b0 mm/memory.c:5284
 do_user_addr_fault arch/x86/mm/fault.c:1413 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x2ac/0x860 arch/x86/mm/fault.c:1561
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f95b6c5db98
RSP: 002b:00007ffd69f5d688 EFLAGS: 00010202
RAX: 0000000020000000 RBX: 00007ffd69f5d798 RCX: 00617363762f7665
RDX: 000000000000000a RSI: 7363762f7665642f RDI: 0000000020000000
RBP: 0000000000000032 R08: 00007f95b6c00000 R09: 00007ffd69fbd0b0
R10: 00007ffd69fbd080 R11: 0000000000069702 R12: 00007f95b6825730
R13: fffffffffffffffe R14: 00007f95b6800000 R15: 00007f95b6825738
 </TASK>
INFO: task syz-executor.0:18703 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc3-syzkaller-00252-ge81a2dabc3f3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:23688 pid:18703 ppid:18152  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x196c/0x4af0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 wait_on_state fs/btrfs/extent-io-tree.c:719 [inline]
 wait_extent_bit+0x50c/0x670 fs/btrfs/extent-io-tree.c:763
 lock_extent+0x1c0/0x270 fs/btrfs/extent-io-tree.c:1755
 btrfs_page_mkwrite+0x5bd/0xd10 fs/btrfs/inode.c:8143
 do_page_mkwrite+0x197/0x470 mm/memory.c:2931
 wp_page_shared mm/memory.c:3291 [inline]
 do_wp_page+0xf87/0x4190 mm/memory.c:3376
 handle_pte_fault mm/memory.c:4994 [inline]
 __handle_mm_fault mm/memory.c:5119 [inline]
 handle_mm_fault+0x1b45/0x62b0 mm/memory.c:5284
 do_user_addr_fault arch/x86/mm/fault.c:1413 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x2ac/0x860 arch/x86/mm/fault.c:1561
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:58
Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
RSP: 0018:ffffc9000da57550 EFLAGS: 00050206
RAX: 0000000000000000 RBX: 0000000020000298 RCX: 0000000000000038
RDX: 0000000000000000 RSI: ffffc9000da57600 RDI: 0000000020000260
RBP: ffffc9000da576b0 R08: ffffc9000da57637 R09: 1ffff92001b4aec6
R10: dffffc0000000000 R11: fffff52001b4aec7 R12: 0000000000000038
R13: ffffc9000da57600 R14: 0000000020000260 R15: ffffc9000da57600
 copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
 _copy_to_user+0x86/0xa0 lib/usercopy.c:41
 copy_to_user include/linux/uaccess.h:191 [inline]
 fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
 emit_last_fiemap_cache fs/btrfs/extent_io.c:2506 [inline]
 extent_fiemap+0x1b9c/0x1fe0 fs/btrfs/extent_io.c:3033
 btrfs_fiemap+0x178/0x1e0 fs/btrfs/inode.c:7815
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x19ea/0x2b40 fs/ioctl.c:811
 __do_sys_ioctl fs/ioctl.c:869 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f95b6c7cae9
RSP: 002b:00007f95ae3dd0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f95b6d9c050 RCX: 00007f95b6c7cae9
RDX: 0000000020000240 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00007f95b6cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f95b6d9c050 R15: 00007ffd69f5d5a8
 </TASK>
INFO: task syz-executor.0:18705 blocked for more than 144 seconds.
      Not tainted 6.6.0-rc3-syzkaller-00252-ge81a2dabc3f3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:26472 pid:18705 ppid:18152  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x196c/0x4af0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_write_slowpath+0xee6/0x13a0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1aa/0x200 kernel/locking/rwsem.c:1306
 inode_lock include/linux/fs.h:802 [inline]
 btrfs_inode_lock+0x4d/0xd0 fs/btrfs/inode.c:377
 btrfs_buffered_write+0x230/0x1380 fs/btrfs/file.c:1200
 btrfs_do_write_iter+0x2bb/0x1190 fs/btrfs/file.c:1683
 do_iter_write+0x84f/0xde0 fs/read_write.c:860
 iter_file_splice_write+0x86d/0x1010 fs/splice.c:736
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0xea/0x1c0 fs/splice.c:1142
 splice_direct_to_actor+0x376/0x9e0 fs/splice.c:1088
 do_splice_direct+0x2ac/0x3f0 fs/splice.c:1194
 do_sendfile+0x623/0x1070 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f95b6c7cae9
RSP: 002b:00007f95ae3bc0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f95b6d9c120 RCX: 00007f95b6c7cae9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007f95b6cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f95b6d9c120 R15: 00007ffd69f5d5a8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8d32c420 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
 #0: ffffffff8d32c420 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:749 [inline]
 #0: ffffffff8d32c420 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6613
2 locks held by getty/4789:
 #0: ffff88814add90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2206
3 locks held by syz-executor.5/5079:
 #0: ffff88814be82410 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:403
 #1: ffff888078b8d400 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:837 [inline]
 #1: ffff888078b8d400 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0x26a/0x950 fs/namei.c:4383
 #2: ffff888043a1c000 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #2: ffff888043a1c000 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: vfs_unlink+0xe4/0x5f0 fs/namei.c:4321
3 locks held by syz-executor.0/18661:
 #0: ffff88807dba3aa0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:165 [inline]
 #0: ffff88807dba3aa0 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:5311 [inline]
 #0: ffff88807dba3aa0 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x32/0x2d0 mm/memory.c:5371
 #1: ffff888035ad2508 (sb_pagefaults#4){.+.+}-{0:0}, at: do_page_mkwrite+0x197/0x470 mm/memory.c:2931
 #2: ffff888076f02008 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_page_mkwrite+0x49c/0xd10 fs/btrfs/inode.c:8132
4 locks held by syz-executor.0/18703:
 #0: ffff888076f02180 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076f02180 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: btrfs_inode_lock+0x60/0xd0 fs/btrfs/inode.c:369
 #1: ffff88807dba3aa0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:165 [inline]
 #1: ffff88807dba3aa0 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:5311 [inline]
 #1: ffff88807dba3aa0 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x32/0x2d0 mm/memory.c:5371
 #2: ffff888035ad2508 (sb_pagefaults#4){.+.+}-{0:0}, at: do_page_mkwrite+0x197/0x470 mm/memory.c:2931
 #3: ffff888076f02008 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_page_mkwrite+0x49c/0xd10 fs/btrfs/inode.c:8132
2 locks held by syz-executor.0/18705:
 #0: ffff888035ad2410 (sb_writers#16){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888076f02180 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #1: ffff888076f02180 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: btrfs_inode_lock+0x4d/0xd0 fs/btrfs/inode.c:377
2 locks held by syz-executor.0/18746:
 #0: ffff88814be82410 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:403
 #1: ffff888076cc0e00 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:837 [inline]
 #1: ffff888076cc0e00 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0x26a/0x950 fs/namei.c:4383

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.6.0-rc3-syzkaller-00252-ge81a2dabc3f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfa9/0xff0 kernel/hung_task.c:379
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4567 Comm: kworker/u4:21 Not tainted 6.6.0-rc3-syzkaller-00252-ge81a2dabc3f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: bat_events batadv_nc_worker
RIP: 0010:lockdep_hardirqs_on_prepare+0x1e0/0x7a0
Code: 4c 89 7c 24 18 48 8b 44 24 10 4c 8b b0 b8 0a 00 00 48 8d b8 a0 0a 00 00 48 89 f8 48 c1 e8 03 80 3c 10 00 74 05 e8 b0 d1 7b 00 <48> 8b 5c 24 10 4c 89 b3 a0 0a 00 00 48 c7 c7 80 b1 0a 8b e8 28 d0
RSP: 0018:ffffc90003aef980 EFLAGS: 00000046
RAX: 1ffff110080988c4 RBX: 1ffff9200075df38 RCX: ffffffff91ef3303
RDX: dffffc0000000000 RSI: ffffffff8b599c80 RDI: ffff8880404c4620
RBP: ffffc90003aefa28 R08: ffffffff8e9a7e2f R09: 1ffffffff1d34fc5
R10: dffffc0000000000 R11: fffffbfff1d34fc6 R12: dffffc0000000000
R13: 1ffff9200075df50 R14: 08cd28cef2c003d5 R15: 1ffff9200075df34
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 000000007e679000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 trace_hardirqs_on+0x28/0x40 kernel/trace/trace_preemptirq.c:61
 __local_bh_enable_ip+0x168/0x1f0 kernel/softirq.c:386
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_nc_purge_paths+0x309/0x3a0 net/batman-adv/network-coding.c:471
 batadv_nc_worker+0x365/0x610 net/batman-adv/network-coding.c:722
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
