Return-Path: <linux-fsdevel+bounces-883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BCF7D228C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 12:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F79A281620
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63C96AAE;
	Sun, 22 Oct 2023 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4E3D64
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 10:22:50 +0000 (UTC)
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE7BE6
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 03:22:48 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1e1a878ef40so3933901fac.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 03:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697970167; x=1698574967;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jz58LyOQLBpUu38euw5ZNzHbshkNxHgL8g+dkjSvKo=;
        b=eQd+zakQLA1sZV0Gh3bBH36SH57emxXO+b8iZswwl/p1RUDsbWDl5DB0In5Xqjkvd+
         AjZw+U4AxbI+uW2CjR4IFlaJ7dbtE1hlzxPV8pO1MOcR4/CTkYl/0+UsFcjuH/Sc+ANI
         iphe6SbdzN2vM9hYiJNskH8Td3szxPaQxQJ6prFBoISJuXScqvPS533MJ+kc069k1ih1
         j3cZxZHnL4S+/+eKH19D31ErRwBsHLWWlqXkyr1ptMMRnxTM4TLh0XBHrqZZNez8nXpP
         w0NxLELHIevJ9Kv+TiauSl4IO4zuV2CgGrti2XAJQHz6IyhFAgh5Jdye7zz0E7AVJ9IE
         USvw==
X-Gm-Message-State: AOJu0Yz1Zq9bLOu4PAAlaPR1PoRmoy65pBAqz+SpVfjTTkyhR1wRaVcN
	gwTce6B105e7OdMQ+ZZdoJn8nYAeOiBkmAXJPcNLlEhp5xsC
X-Google-Smtp-Source: AGHT+IFTGYQX/gCOP7RG6cZ98gOzYtyy2nyM7p40Il0R8mRFa352gDxQXX2vFQYlXCiySsIUZ8WDdlOdW99z4uMJRUntkcxT0iL+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:3329:b0:1e9:a13c:ffba with SMTP id
 nf41-20020a056871332900b001e9a13cffbamr3139050oac.9.1697970167706; Sun, 22
 Oct 2023 03:22:47 -0700 (PDT)
Date: Sun, 22 Oct 2023 03:22:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af7bd706084b7cb2@google.com>
Subject: [syzbot] [exfat?] INFO: task hung in fat_write_inode
From: syzbot <syzbot+6f75830acb2e4cdc8e50@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10ed8d75680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=6f75830acb2e4cdc8e50
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148fed9d680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1019f523680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2375f16ed327/disk-2dac7569.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c80aee6e2e6c/vmlinux-2dac7569.xz
kernel image: https://storage.googleapis.com/syzbot-assets/664dc23b738d/bzImage-2dac7569.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7a81659a2d58/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f75830acb2e4cdc8e50@syzkaller.appspotmail.com

INFO: task kworker/u4:11:2872 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc6-next-20231018-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:11   state:D stack:23520 pid:2872  tgid:2872  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xee4/0x5a10 kernel/sched/core.c:6680
 __schedule_loop kernel/sched/core.c:6757 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6772
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6829
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x969/0x1340 kernel/locking/mutex.c:747
 fat_write_inode fs/fat/inode.c:918 [inline]
 fat_write_inode+0xfc/0x180 fs/fat/inode.c:911
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0xa84/0xe60 fs/fs-writeback.c:1673
 writeback_sb_inodes+0x5a2/0x1090 fs/fs-writeback.c:1899
 __writeback_inodes_wb+0xff/0x2d0 fs/fs-writeback.c:1970
 wb_writeback+0x7fe/0xaa0 fs/fs-writeback.c:2077
 wb_check_background_flush fs/fs-writeback.c:2147 [inline]
 wb_do_writeback fs/fs-writeback.c:2235 [inline]
 wb_workfn+0x86a/0xfd0 fs/fs-writeback.c:2262
 process_one_work+0x8a2/0x15e0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8cbacbe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cbacbe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cbacbe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
4 locks held by kworker/u4:11/2872:
 #0: ffff888142249d38 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x78a/0x15e0 kernel/workqueue.c:2605
 #1: ffffc9000aeffd80 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x7f4/0x15e0 kernel/workqueue.c:2606
 #2: ffff888018e6c0e0 (&type->s_umount_key#45){++++}-{3:3}, at: super_trylock_shared+0x1e/0xf0 fs/super.c:610
 #3: ffff88807b4281d0 (&sbi->s_lock){+.+.}-{3:3}, at: fat_write_inode fs/fat/inode.c:918 [inline]
 #3: ffff88807b4281d0 (&sbi->s_lock){+.+.}-{3:3}, at: fat_write_inode+0xfc/0x180 fs/fat/inode.c:911
2 locks held by getty/4814:
 #0: ffff88814b6680a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
4 locks held by syz-executor175/5063:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.6.0-rc6-next-20231018-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5063 Comm: syz-executor175 Not tainted 6.6.0-rc6-next-20231018-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4788 [inline]
RIP: 0010:__lock_acquire+0x5b2/0x5dc0 kernel/locking/lockdep.c:5086
Code: b8 0a 00 00 41 89 ef 41 83 ef 01 0f 88 79 1f 00 00 49 b8 00 00 00 00 00 fc ff df 49 63 c7 48 8d 04 80 4c 8d a4 c7 e1 0a 00 00 <eb> 12 41 83 ef 01 49 83 ec 28 41 83 ff ff 0f 84 0c 0b 00 00 4d 8d
RSP: 0018:ffffc90003a6f3e0 EFLAGS: 00000002
RAX: 000000000000000a RBX: 0000000000000018 RCX: 0000000000000000
RDX: 1ffff1100f6868c7 RSI: 0000000000000001 RDI: ffff88807b433b80
RBP: 0000000000000003 R08: dffffc0000000000 R09: fffffbfff2344fc8
R10: ffffffff91a27e47 R11: 1ffffffff1976fb9 R12: ffff88807b4346b1
R13: ffff88807b4346b8 R14: ffffffff8cbacbe0 R15: 0000000000000002
FS:  00005555556c7380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f81ca48600 CR3: 0000000077b86000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b2/0x530 kernel/locking/lockdep.c:5718
 rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 rcu_read_lock include/linux/rcupdate.h:747 [inline]
 filemap_get_entry+0xdb/0x460 mm/filemap.c:1803
 __filemap_get_folio+0x56/0xa90 mm/filemap.c:1851
 __find_get_block_slow fs/buffer.c:203 [inline]
 __find_get_block fs/buffer.c:1406 [inline]
 __find_get_block+0x170/0xc30 fs/buffer.c:1400
 __getblk_slow+0x10c/0x6b0 fs/buffer.c:1134
 bdev_getblk+0xad/0xc0 fs/buffer.c:1434
 __getblk include/linux/buffer_head.h:358 [inline]
 sb_getblk include/linux/buffer_head.h:364 [inline]
 fat_mirror_bhs+0x244/0x5d0 fs/fat/fatent.c:388
 fat_alloc_clusters+0xcb2/0xf70 fs/fat/fatent.c:543
 fat_alloc_new_dir+0x107/0xc90 fs/fat/dir.c:1144
 vfat_mkdir+0x151/0x350 fs/fat/namei_vfat.c:859
 vfs_mkdir+0x577/0x820 fs/namei.c:4105
 do_mkdirat+0x2fd/0x3a0 fs/namei.c:4128
 __do_sys_mkdirat fs/namei.c:4143 [inline]
 __se_sys_mkdirat fs/namei.c:4141 [inline]
 __x64_sys_mkdirat+0x115/0x170 fs/namei.c:4141
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f1b0ce56b59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc6cb671e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f1b0ce56b59
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 00000000ffffff9c
RBP: 00007f1b0ceca5f0 R08: 000000000000024e R09: 00005555556c84c0
R10: 00007ffc6cb670b0 R11: 0000000000000246 R12: 00007ffc6cb67210
R13: 00007ffc6cb67438 R14: 431bde82d7b634db R15: 00007f1b0ce9f03b
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.510 msecs


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

