Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741897A366F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjIQPgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbjIQPgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:36:09 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DCECF2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 08:35:05 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3aa17bcf2bcso6329643b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 08:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964905; x=1695569705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84c4oOdJQqUkB+deINDKnoAGkhiQe7ZYJavUeVFWzJk=;
        b=W7Vozl4kN6d1TS6kpNvFCObogsmjUE+cDCXOrgbZQDZwR/q3ly6DUs+xiMX+Ir+Oho
         31RqA1DAa+XjIOlAsz42hJJ/iDIM3ztPpoxyaGam1eQ35PseG/mSqlNXeuHF8CRtdFC3
         w8sH81wbg6vpeuT0x80u6mDqxQmZ+zuPIbGLSQBJohqVlCBXumrUeepoa2rBkEnhJW/4
         4VarIf24DkfMQciK1GRxZgS4BWGTcTOgJVScTgV3GuHe37VrpJphEXFslM31+fZMn1/S
         8lo0kMbn22J2p73/oDBdgIsJzinZQ+OEdnMqoPfBGHB/Yyu2+vu4z4ZdiudPRtkbCeXo
         4v6g==
X-Gm-Message-State: AOJu0YwaLC334mrQXtk1fJS6vTY/3YD3SMd1BRLEl9ixxWyE+DVIRgDG
        JmbXYQIQu+d2wWr3AD9et+qxXom4PDUIGl+nHzBu3xKsfAya
X-Google-Smtp-Source: AGHT+IFcyZCdWvDJhmwEMD4YJ7jT6YW+l6H8QZo17ZV7HnUQvfeDinRE4dc8K84pZ8MyCa5BsFzF+PLCq7OvFxr7l2YN8a4/XzHJ
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a1f:b0:3ac:ab4f:ef3 with SMTP id
 bk31-20020a0568081a1f00b003acab4f0ef3mr3067526oib.6.1694964905079; Sun, 17
 Sep 2023 08:35:05 -0700 (PDT)
Date:   Sun, 17 Sep 2023 08:35:05 -0700
In-Reply-To: <000000000000e534bb0604959011@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012f99f06058fc5fa@google.com>
Subject: Re: [syzbot] [block] INFO: task hung in clean_bdev_aliases
From:   syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>
To:     david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nogikh@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f0b0d403eabb Merge tag 'kbuild-fixes-v6.6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bbe63c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=999148c170811772
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa947e7f09e136925b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16148d74680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e10762680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9067aea1d6b6/disk-f0b0d403.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b837ae6375f/vmlinux-f0b0d403.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b1678667256/bzImage-f0b0d403.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com

INFO: task syz-executor119:9037 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller-00240-gf0b0d403eabb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor119 state:D stack:25872 pid:9037  ppid:5100   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 io_schedule+0xbe/0x130 kernel/sched/core.c:9026
 folio_wait_bit_common+0x3d2/0x9b0 mm/filemap.c:1301
 folio_lock include/linux/pagemap.h:1042 [inline]
 clean_bdev_aliases+0x56b/0x610 fs/buffer.c:1725
 clean_bdev_bh_alias include/linux/buffer_head.h:219 [inline]
 __block_write_begin_int+0x8d6/0x1470 fs/buffer.c:2115
 iomap_write_begin+0x5be/0x17b0 fs/iomap/buffered-io.c:772
 iomap_write_iter fs/iomap/buffered-io.c:907 [inline]
 iomap_file_buffered_write+0x3d6/0x9a0 fs/iomap/buffered-io.c:968
 blkdev_buffered_write block/fops.c:634 [inline]
 blkdev_write_iter+0x4f5/0xc90 block/fops.c:684
 call_write_iter include/linux/fs.h:1985 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
 iter_file_splice_write+0x698/0xbf0 fs/splice.c:736
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
RIP: 0033:0x7f92485ce3b9
RSP: 002b:00007f9248583158 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f924864e3e8 RCX: 00007f92485ce3b9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007f924864e3e0 R08: 00007f92485836c0 R09: 0000000000000000
R10: 0100000000000042 R11: 0000000000000246 R12: 00007f924864e3ec
R13: 0000000000000016 R14: 00007ffd0b251ce0 R15: 00007ffd0b251dc8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/28:
 #0: ffffffff8cba7860 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6607
2 locks held by getty/4793:
 #0: ffff888027bb90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900020682f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc5/0x1480 drivers/tty/n_tty.c:2206
3 locks held by syz-executor119/5099:
3 locks held by syz-executor119/5105:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.6.0-rc1-syzkaller-00240-gf0b0d403eabb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfac/0x1230 kernel/hung_task.c:379
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5097 Comm: syz-executor119 Not tainted 6.6.0-rc1-syzkaller-00240-gf0b0d403eabb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:217 [inline]
RIP: 0010:unwind_next_frame+0x25f/0x2390 arch/x86/kernel/unwind_orc.c:494
Code: 83 f4 19 00 00 e8 61 83 4c 00 45 89 ee 48 b8 00 00 00 00 00 fc ff df 4a 8d 3c b5 44 d7 00 90 48 89 fa 48 c1 ea 03 0f b6 14 02 <48> 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 db 83 a1 00
RSP: 0018:ffffc9000030f510 EFLAGS: 00000a03
RAX: dffffc0000000000 RBX: ffffc9000030f590 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff813a49af RDI: ffffffff90043a8c
RBP: 0000000000000001 R08: 0000000000000004 R09: 000000000000d8d2
R10: 0000000000098000 R11: dffffc0000000000 R12: ffffffff81d8d288
R13: 000000000000d8d2 R14: 000000000000d8d2 R15: ffffc9000030f5c5
FS:  0000555556536480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556540808 CR3: 000000007a917000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0xfa/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 save_stack+0x160/0x1f0 mm/page_owner.c:128
 __set_page_owner+0x1f/0x60 mm/page_owner.c:192
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 __get_free_pages+0xc/0x40 mm/page_alloc.c:4477
 _pgd_alloc arch/x86/mm/pgtable.c:420 [inline]
 pgd_alloc+0x28/0x260 arch/x86/mm/pgtable.c:436
 mm_alloc_pgd kernel/fork.c:795 [inline]
 mm_init+0x679/0xf60 kernel/fork.c:1298
 dup_mm kernel/fork.c:1683 [inline]
 copy_mm kernel/fork.c:1735 [inline]
 copy_process+0x6bf8/0x7400 kernel/fork.c:2501
 kernel_clone+0xfd/0x930 kernel/fork.c:2909
 __do_sys_clone+0xba/0x100 kernel/fork.c:3052
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f92485cc1a3
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffd0b251da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f92485cc1a3
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffd0b251c44
R10: 0000555556536750 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 000000000012b3f1 R15: 00007ffd0b251f20
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
