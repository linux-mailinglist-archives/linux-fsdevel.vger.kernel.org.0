Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE275BB89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 02:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGUA3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 20:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGUA3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:29:11 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D024230D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 17:28:49 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3a1e58db5caso3197194b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 17:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899305; x=1690504105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0hfr7+iJW4omNzYXqDwP5L4lISBxD5DhSyIprgoQuE=;
        b=fi1mAv+KDkEa3aOKqkIyOFR+U9RRIm0t4Cw184cZYDBcyW1LFyDfJQsUPDLry8bJcz
         HG/EnDMnAOB2BiRcb+yQ8rdLCd+edgThUycDhw3f4LWAxs9YPsyJ7sy4zD3UV7ElA/VJ
         Tq6jVmaQ3mOpOWtISmCSorOy7xG1l34BdfWq4SI7uQVtpiQFK4CfaIln7scR2db5twet
         RyjcXbocUc/wm5WfsulGEAGVBrd1ZJP7ycpM8eLismsaXTNxYuvOEJFO+VJFktzrqJk9
         54yrIFtk/oVUn5vY0uTe/nE7PCev7JcOCo+sFjS5x7aOZqA1t9gzVo1rxdb+IWt981x8
         cP9Q==
X-Gm-Message-State: ABy/qLb0bsIbTCwLrGLwNyKevtVnBHhUEvWzzcCM4kXj7jkEdupo86Or
        pUqxAEz7E/G4gpn8iTsSSf8Ykx4E5SFrjmH58NqUpZesxxtv
X-Google-Smtp-Source: APBJJlEK9stmKCSk6TDWumk8pe+eYwcyGWKCCV1Uu+obFNON80/nKLA/AHhU2iV8qxpCH04KU8c5NrUuiV1d39eLwlgZH6XGz67Y
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1528:b0:3a3:89dc:8d5f with SMTP id
 u40-20020a056808152800b003a389dc8d5fmr1144968oiw.1.1689899305168; Thu, 20 Jul
 2023 17:28:25 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:28:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca751d0600f457c3@google.com>
Subject: [syzbot] [ntfs3?] INFO: task hung in ni_readpage_cmpr
From:   syzbot <syzbot+9877b6999a2554291c7d@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c2878be5732 Add linux-next specific files for 20230714
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13820f32a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3baff2936ac3cefa
dashboard link: https://syzkaller.appspot.com/bug?extid=9877b6999a2554291c7d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119010f4a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170ad732a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfdfa043f096/disk-7c2878be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf7a97f69e2a/vmlinux-7c2878be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8366b63af2c6/bzImage-7c2878be.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d3f8a02941e7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9877b6999a2554291c7d@syzkaller.appspotmail.com

INFO: task syz-executor122:5344 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc1-next-20230714-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor122 state:D stack:26032 pid:5344  ppid:5028   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5380 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6709
 schedule+0xe7/0x1b0 kernel/sched/core.c:6785
 io_schedule+0xbe/0x130 kernel/sched/core.c:9027
 folio_wait_bit_common+0x3d0/0x9a0 mm/filemap.c:1304
 __folio_lock mm/filemap.c:1632 [inline]
 folio_lock include/linux/pagemap.h:974 [inline]
 folio_lock include/linux/pagemap.h:970 [inline]
 __filemap_get_folio+0x788/0x990 mm/filemap.c:1900
 pagecache_get_page+0x2c/0x270 mm/folio-compat.c:99
 find_or_create_page include/linux/pagemap.h:655 [inline]
 ni_readpage_cmpr+0x24e/0xc80 fs/ntfs3/frecord.c:2135
 ntfs_read_folio+0x107/0x1e0 fs/ntfs3/inode.c:718
 filemap_read_folio+0xe5/0x2b0 mm/filemap.c:2390
 filemap_create_folio mm/filemap.c:2518 [inline]
 filemap_get_pages+0xdd7/0x1820 mm/filemap.c:2571
 filemap_splice_read+0x3d0/0x9f0 mm/filemap.c:2927
 ntfs_file_splice_read+0x10d/0x190 fs/ntfs3/file.c:773
 vfs_splice_read fs/splice.c:993 [inline]
 vfs_splice_read+0x2c8/0x3b0 fs/splice.c:962
 splice_direct_to_actor+0x2a5/0xa30 fs/splice.c:1069
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd9aca10e09
RSP: 002b:00007fd9ac9c5168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fd9acab1708 RCX: 00007fd9aca10e09
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007fd9acab1700 R08: 00007fd9ac9c56c0 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 00007fd9acab170c
R13: 0000000000000006 R14: 00007ffdd97961a0 R15: 00007ffdd9796288
 </TASK>
INFO: task syz-executor122:5345 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc1-next-20230714-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor122 state:D stack:26448 pid:5345  ppid:5028   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5380 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6709
 schedule+0xe7/0x1b0 kernel/sched/core.c:6785
 io_schedule+0xbe/0x130 kernel/sched/core.c:9027
 folio_wait_bit_common+0x3d0/0x9a0 mm/filemap.c:1304
 __folio_lock mm/filemap.c:1632 [inline]
 folio_lock include/linux/pagemap.h:974 [inline]
 folio_lock include/linux/pagemap.h:970 [inline]
 __filemap_get_folio+0x788/0x990 mm/filemap.c:1900
 pagecache_get_page+0x2c/0x270 mm/folio-compat.c:99
 find_or_create_page include/linux/pagemap.h:655 [inline]
 ntfs_get_frame_pages+0x132/0x640 fs/ntfs3/file.c:793
 ntfs_compress_write fs/ntfs3/file.c:943 [inline]
 ntfs_file_write_iter+0xfdc/0x1c10 fs/ntfs3/file.c:1080
 call_write_iter include/linux/fs.h:1916 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
 iter_file_splice_write+0x698/0xbf0 fs/splice.c:738
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1142
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd9aca10e09
RSP: 002b:00007fd9a47a4168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fd9acab1718 RCX: 00007fd9aca10e09
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007fd9acab1710 R08: 00007fd9a47a46c0 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 00007fd9acab171c
R13: 000000000000006e R14: 00007ffdd97961a0 R15: 00007ffdd9796288
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c9a5cb0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2c/0xef0 kernel/rcu/tasks.h:571
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c9a5970 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x2c/0xef0 kernel/rcu/tasks.h:571
1 lock held by khungtaskd/28:
 #0: ffffffff8c9a68c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6615
5 locks held by kworker/u4:4/57:
2 locks held by getty/4784:
 #0: ffff88814ac0c098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015b72f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfcb/0x1480 drivers/tty/n_tty.c:2187
3 locks held by syz-executor122/5344:
 #0: ffff88807da84410 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 #0: ffff88807da84410 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 #0: ffff88807da84410 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 #1: ffff888072bebd88 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:826 [inline]
 #1: ffff888072bebd88 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_create_folio mm/filemap.c:2510 [inline]
 #1: ffff888072bebd88 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_get_pages+0xd14/0x1820 mm/filemap.c:2571
 #2: ffff888072beb900 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 #2: ffff888072beb900 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_read_folio+0xfc/0x1e0 fs/ntfs3/inode.c:717
2 locks held by syz-executor122/5345:
 #0: ffff88807da84410 (sb_writers#10){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 #0: ffff88807da84410 (sb_writers#10){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 #0: ffff88807da84410 (sb_writers#10){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 #1: ffff888072bebbd0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
 #1: ffff888072bebbd0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: ntfs_file_write_iter+0x296/0x1c10 fs/ntfs3/file.c:1063

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.5.0-rc1-next-20230714-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2ac/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf29/0x11b0 kernel/hung_task.c:379
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 57 Comm: kworker/u4:4 Not tainted 6.5.0-rc1-next-20230714-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:602 [inline]
RIP: 0010:__mutex_lock+0x14f/0x1340 kernel/locking/mutex.c:747
Code: 29 49 8d 7e 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 00 0d 00 00 4d 3b 76 60 0f 85 67 07 00 00 <bf> 01 00 00 00 e8 27 ae 23 f7 49 8d 46 68 31 d2 4d 89 e1 48 89 85
RSP: 0018:ffffc90001587aa0 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 1ffffffff1954708 RSI: ffffffff8a6c7cc0 RDI: ffffffff8caa3840
RBP: ffffc90001587bf0 R08: ffffffff81b25fbb R09: 0000000000000001
R10: ffffc90001587c08 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff8caa37e0 R15: ffffffff9216b4c0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056410262d680 CR3: 000000000c776000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 jump_label_lock kernel/jump_label.c:27 [inline]
 static_key_disable_cpuslocked+0x10b/0x1b0 kernel/jump_label.c:233
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:836 [inline]
 toggle_allocation_gate+0x13f/0x250 mm/kfence/core.c:823
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
