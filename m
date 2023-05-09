Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18B46FC54C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 13:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjEILp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjEILp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 07:45:56 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268235BBD
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 04:45:39 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-331514f5626so38605775ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 May 2023 04:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683632738; x=1686224738;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsV+Ehp2LFEKgTK/TdzkA6cLPGWuwVF/okEYxjGPFc0=;
        b=V5xzF5HML/dp8iVVrDfchEndpoYVkaV4cPT5xndcI8NEWoPHgLXoqo0qkXGjhFhC2D
         MqhnG3kUsNS7pFIUUPJ0yckID8i17No1xl7xqMui75+6a6vfGEl3XpYMcogd+O+XP1I3
         dGfPc5vp63gjWabso1tBfr6FI3nFosNOLSI/0XPZ2ddT06L774njGRcyS+5aZAwB0doK
         m/sE8NQ1JXmdD5pOA3sFAfR6My1JbknqHWMAjDS6zfChHPdn5jsa1ulC4FMmSWh09ugm
         ylp2V/ZWKOadvpTslmc1OCAW1WoSFRiSs1XBsZei0HRtJupRslMiIe4pwbYeMUKtMJBz
         nFWw==
X-Gm-Message-State: AC+VfDxpbgbb4pThTyVm2INAgmbQRWQHFQ8wdT2xf3h2XCqap86EglMm
        B9LkUGf+tsl+Bep75Vu9QVp/5cYCI+78i/PUCxrtGfDCxWn0
X-Google-Smtp-Source: ACHHUZ5gbZ8CX98GibNZriIvANArpZ0LsBVgwvzKAFOlZVEdQdoAw3dF1zKkphNtN7qXvvk3qF+EhzOxbnp/+DrF+gtU7Ex3gHPv
MIME-Version: 1.0
X-Received: by 2002:a02:6344:0:b0:414:39cf:e6b6 with SMTP id
 j65-20020a026344000000b0041439cfe6b6mr1195535jac.0.1683632738284; Tue, 09 May
 2023 04:45:38 -0700 (PDT)
Date:   Tue, 09 May 2023 04:45:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c3e6b05fb414be2@google.com>
Subject: [syzbot] [ext4?] BUG: sleeping function called from invalid context
 in alloc_buffer_head
From:   syzbot <syzbot+3c6cac1550288f8e7060@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    52025ebbb518 Add linux-next specific files for 20230508
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c27582280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1f55a88ec660cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=3c6cac1550288f8e7060
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/912ed8ef786f/disk-52025ebb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d53b6c9decdc/vmlinux-52025ebb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0d8a6edd999/bzImage-52025ebb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c6cac1550288f8e7060@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 4439, name: syslogd
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by syslogd/4439:
 #0: ffff888085665e00 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:785 [inline]
 #0: ffff888085665e00 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: lookup_slow fs/namei.c:1706 [inline]
 #0: ffff888085665e00 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: walk_component+0x332/0x5a0 fs/namei.c:1998
 #1: ffffffff8c799800 (rcu_read_lock){....}-{1:2}, at: lru_gen_refault mm/workingset.c:293 [inline]
 #1: ffffffff8c799800 (rcu_read_lock){....}-{1:2}, at: workingset_refault+0x175/0x11e0 mm/workingset.c:528
CPU: 1 PID: 4439 Comm: syslogd Not tainted 6.4.0-rc1-next-20230508-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10153
 might_alloc include/linux/sched/mm.h:306 [inline]
 slab_pre_alloc_hook mm/slab.h:670 [inline]
 slab_alloc_node mm/slub.c:3433 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x357/0x3b0 mm/slub.c:3475
 kmem_cache_zalloc include/linux/slab.h:670 [inline]
 alloc_buffer_head+0x24/0x150 fs/buffer.c:3044
 folio_alloc_buffers+0x2f2/0x810 fs/buffer.c:941
 alloc_page_buffers fs/buffer.c:976 [inline]
 grow_dev_page fs/buffer.c:1084 [inline]
 grow_buffers fs/buffer.c:1130 [inline]
 __getblk_slow+0x612/0x1230 fs/buffer.c:1157
 __getblk_gfp+0x72/0x80 fs/buffer.c:1452
 sb_getblk include/linux/buffer_head.h:369 [inline]
 ext4_getblk+0x211/0x850 fs/ext4/inode.c:845
 ext4_bread_batch+0x82/0x500 fs/ext4/inode.c:912
 __ext4_find_entry+0x451/0x1050 fs/ext4/namei.c:1650
 ext4_lookup_entry fs/ext4/namei.c:1751 [inline]
 ext4_lookup fs/ext4/namei.c:1819 [inline]
 ext4_lookup+0x500/0x700 fs/ext4/namei.c:1810
 __lookup_slow+0x24c/0x460 fs/namei.c:1690
 lookup_slow fs/namei.c:1707 [inline]
 walk_component+0x33f/0x5a0 fs/namei.c:1998
 link_path_walk.part.0+0x74e/0xd60 fs/namei.c:2325
 link_path_walk fs/namei.c:2250 [inline]
 path_openat+0x25c/0x2750 fs/namei.c:3787
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f97344a89a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffc296981d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055d433717910 RCX: 00007f97344a89a4
RDX: 0000000000000d41 RSI: 00007f9734647443 RDI: 00000000ffffff9c
RBP: 00007f9734647443 R08: 0000000000000001 R09: 0000000000000000
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000d41
R13: 000000006459d39e R14: 0000000000000005 R15: 000055d433717a60
 </TASK>
BUG: sleeping function called from invalid context at include/linux/buffer_head.h:408
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 4439, name: syslogd
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by syslogd/4439:
 #0: ffff888085665e00 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:785 [inline]
 #0: ffff888085665e00 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: lookup_slow fs/namei.c:1706 [inline]
 #0: ffff888085665e00 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: walk_component+0x332/0x5a0 fs/namei.c:1998
 #1: ffffffff8c799800 (rcu_read_lock){....}-{1:2}, at: lru_gen_refault mm/workingset.c:293 [inline]
 #1: ffffffff8c799800 (rcu_read_lock){....}-{1:2}, at: workingset_refault+0x175/0x11e0 mm/workingset.c:528
CPU: 1 PID: 4439 Comm: syslogd Tainted: G        W          6.4.0-rc1-next-20230508-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10153
 lock_buffer include/linux/buffer_head.h:408 [inline]
 ext4_read_bh_lock+0x28/0xc0 fs/ext4/super.c:208
 ext4_bread_batch+0x2cc/0x500 fs/ext4/inode.c:923
 __ext4_find_entry+0x451/0x1050 fs/ext4/namei.c:1650
 ext4_lookup_entry fs/ext4/namei.c:1751 [inline]
 ext4_lookup fs/ext4/namei.c:1819 [inline]
 ext4_lookup+0x500/0x700 fs/ext4/namei.c:1810
 __lookup_slow+0x24c/0x460 fs/namei.c:1690
 lookup_slow fs/namei.c:1707 [inline]
 walk_component+0x33f/0x5a0 fs/namei.c:1998
 link_path_walk.part.0+0x74e/0xd60 fs/namei.c:2325
 link_path_walk fs/namei.c:2250 [inline]
 path_openat+0x25c/0x2750 fs/namei.c:3787
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f97344a89a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffc296981d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055d433717910 RCX: 00007f97344a89a4
RDX: 0000000000000d41 RSI: 00007f9734647443 RDI: 00000000ffffff9c
RBP: 00007f9734647443 R08: 0000000000000001 R09: 0000000000000000
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000d41
R13: 000000006459d39e R14: 0000000000000005 R15: 000055d433717a60
 </TASK>
------------[ cut here ]------------
Voluntary context switch within RCU read-side critical section!
WARNING: CPU: 0 PID: 4439 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0xbb9/0x1800 kernel/rcu/tree_plugin.h:318
Modules linked in:
CPU: 0 PID: 4439 Comm: syslogd Tainted: G        W          6.4.0-rc1-next-20230508-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:rcu_note_context_switch+0xbb9/0x1800 kernel/rcu/tree_plugin.h:318
Code: 9d d0 67 00 4c 8b 4c 24 30 8b 4c 24 28 48 8b 54 24 20 e9 8f 03 00 00 48 c7 c7 e0 2f 4e 8a c6 05 19 97 f5 0c 01 e8 67 bb dc ff <0f> 0b e9 4c f5 ff ff 81 e5 ff ff ff 7f 0f 84 d7 f6 ff ff 65 48 8b
RSP: 0018:ffffc9000312f210 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff8880b983d4c0 RCX: 0000000000000000
RDX: ffff88806a4b1dc0 RSI: ffffffff814bf407 RDI: 0000000000000001
RBP: ffff88806a4b1dc0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000000186c8 R12: 0000000000000000
R13: ffff88806a4b1dc0 R14: ffffffff8e7abcf0 R15: ffff8880b983c5c0
FS:  00007f9734354380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feeab7831b8 CR3: 000000002780a000 CR4: 00000000003506f0
DR0: 00000000ffff070c DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __schedule+0x276/0x5790 kernel/sched/core.c:6569
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 io_schedule+0xbe/0x130 kernel/sched/core.c:8979
 bit_wait_io+0x16/0xe0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x64/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xd9/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 __wait_on_buffer+0x63/0x70 fs/buffer.c:123
 wait_on_buffer include/linux/buffer_head.h:398 [inline]
 __ext4_find_entry+0x590/0x1050 fs/ext4/namei.c:1660
 ext4_lookup_entry fs/ext4/namei.c:1751 [inline]
 ext4_lookup fs/ext4/namei.c:1819 [inline]
 ext4_lookup+0x500/0x700 fs/ext4/namei.c:1810
 __lookup_slow+0x24c/0x460 fs/namei.c:1690
 lookup_slow fs/namei.c:1707 [inline]
 walk_component+0x33f/0x5a0 fs/namei.c:1998
 link_path_walk.part.0+0x74e/0xd60 fs/namei.c:2325
 link_path_walk fs/namei.c:2250 [inline]
 path_openat+0x25c/0x2750 fs/namei.c:3787
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f97344a89a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffc296981d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055d433717910 RCX: 00007f97344a89a4
RDX: 0000000000000d41 RSI: 00007f9734647443 RDI: 00000000ffffff9c
RBP: 00007f9734647443 R08: 0000000000000001 R09: 0000000000000000
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000d41
R13: 000000006459d39e R14: 0000000000000005 R15: 000055d433717a60
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
