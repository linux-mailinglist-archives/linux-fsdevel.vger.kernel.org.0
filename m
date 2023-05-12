Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B9470011E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 09:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbjELHL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 03:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbjELHK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 03:10:57 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2FF11563
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 00:08:44 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-331514f5626so64500805ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 00:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875324; x=1686467324;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fw+iTBd++BdghLB5KrjvmaOtGJ8PeVVwlEXkInTdymA=;
        b=b/tjyd4X9JCat44sHJMpXeo8T5x32p8KtJBBoZFsiB+l+WbCsH2iypeQqOzpZ7HC6D
         M3j2R5+wvYA8dVcmBQU06m6jSaB042k1c5stTT0NZq1dGCY+t4g/c5wVbA56Z6vuJ7bl
         3+ocvR+XW0e82YLB/GhyvcB/2TsY3ZTi8qW9sOMkzVjUiSEGKFF5ZDRN16Ck9XMsrYKS
         U2oO4nAShsM4YLIXG/IwbEBkW9dX2ye/acpLySMPiU0udvSDd4g0LFsL8mPtRtoMqNVl
         4+A4jWj+nkIc+2/E7ChFLgsu+0vAtKnhdldzOwlkEVgHglIoALpZ9OhfmhGoa+hjMEtw
         N3qw==
X-Gm-Message-State: AC+VfDw+K0EmFOkyxo187EcD5QPlvRdevkiCcJ0lmtZixHhp8QwWPouC
        vWeeIXoxTWZ3lDo5OFLRork6WicmV+VYwuG6+PzgTv8HA+DO
X-Google-Smtp-Source: ACHHUZ55p5GBzJaVAo9gbuEtNkBLab4DOOECD+iWkGVtwzCPd95QfeAb6eXgBfZDE7IiZYtvScB+xyndTuyFNk5RDRbqqxpiUBW1
MIME-Version: 1.0
X-Received: by 2002:a02:234b:0:b0:418:733f:513c with SMTP id
 u72-20020a02234b000000b00418733f513cmr825328jau.2.1683875323826; Fri, 12 May
 2023 00:08:43 -0700 (PDT)
Date:   Fri, 12 May 2023 00:08:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085d81d05fb79c667@google.com>
Subject: [syzbot] [fs?] [mm?] BUG: sleeping function called from invalid
 context in mempool_alloc
From:   syzbot <syzbot+5a5f3b3df8fc04673151@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    578215f3e21c Add linux-next specific files for 20230510
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17fa43b6280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb5a64fc61c29c5f
dashboard link: https://syzkaller.appspot.com/bug?extid=5a5f3b3df8fc04673151
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/61ae2512b5cb/disk-578215f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e16190a5b183/vmlinux-578215f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04000a0b9ddf/bzImage-578215f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a5f3b3df8fc04673151@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 21075, name: udevd
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by udevd/21075:
 #0: ffff88801a8829b0 (mapping.invalidate_lock#2){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:830 [inline]
 #0: ffff88801a8829b0 (mapping.invalidate_lock#2){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x153/0x5e0 mm/readahead.c:226
 #1: ffffffff8c7991c0 (rcu_read_lock){....}-{1:2}, at: lru_gen_refault mm/workingset.c:293 [inline]
 #1: ffffffff8c7991c0 (rcu_read_lock){....}-{1:2}, at: workingset_refault+0x175/0x11e0 mm/workingset.c:528
CPU: 1 PID: 21075 Comm: udevd Not tainted 6.4.0-rc1-next-20230510-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10148
 might_alloc include/linux/sched/mm.h:306 [inline]
 mempool_alloc+0x1c4/0x360 mm/mempool.c:388
 bio_alloc_bioset+0x41e/0x900 block/bio.c:543
 bio_alloc include/linux/bio.h:427 [inline]
 do_mpage_readpage+0xe8c/0x1960 fs/mpage.c:298
 mpage_readahead+0x344/0x580 fs/mpage.c:382
 read_pages+0x1a2/0xd40 mm/readahead.c:161
 page_cache_ra_unbounded+0x477/0x5e0 mm/readahead.c:270
 do_page_cache_ra mm/readahead.c:300 [inline]
 force_page_cache_ra+0x333/0x470 mm/readahead.c:331
 page_cache_sync_ra+0x105/0x200 mm/readahead.c:705
 page_cache_sync_readahead include/linux/pagemap.h:1211 [inline]
 filemap_get_pages+0x28d/0x1620 mm/filemap.c:2598
 filemap_read+0x35e/0xc70 mm/filemap.c:2693
 blkdev_read_iter+0x3eb/0x760 block/fops.c:609
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4b1/0x8a0 fs/read_write.c:470
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1805316b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffccfcc4668 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1805316b6a
RDX: 0000000000000400 RSI: 000055ca7c932ca8 RDI: 0000000000000009
RBP: 0000000000000400 R08: 000055ca7c932c80 R09: 0000000000000008
R10: 0000000000000051 R11: 0000000000000246 R12: 000055ca7c932c80
R13: 000055ca7c932c98 R14: 000055ca7c92c118 R15: 000055ca7c92c0c0
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.4.0-rc1-next-20230510-syzkaller #0 Tainted: G        W         
-----------------------------
udevd/21075 is trying to lock:
ffff88801a8829b0
 (mapping.invalidate_lock#2){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:830 [inline]
 (mapping.invalidate_lock#2){.+.+}-{3:3}, at: filemap_update_page mm/filemap.c:2474 [inline]
 (mapping.invalidate_lock#2){.+.+}-{3:3}, at: filemap_get_pages+0x743/0x1620 mm/filemap.c:2622
other info that might help us debug this:
context-{4:4}
1 lock held by udevd/21075:
 #0: ffffffff8c7991c0 (rcu_read_lock){....}-{1:2}, at: lru_gen_refault mm/workingset.c:293 [inline]
 #0: ffffffff8c7991c0 (rcu_read_lock){....}-{1:2}, at: workingset_refault+0x175/0x11e0 mm/workingset.c:528
stack backtrace:
CPU: 1 PID: 21075 Comm: udevd Tainted: G        W          6.4.0-rc1-next-20230510-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4729 [inline]
 check_wait_context kernel/locking/lockdep.c:4799 [inline]
 __lock_acquire+0x15d5/0x5f30 kernel/locking/lockdep.c:5038
 lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5705
 down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
 filemap_invalidate_lock_shared include/linux/fs.h:830 [inline]
 filemap_update_page mm/filemap.c:2474 [inline]
 filemap_get_pages+0x743/0x1620 mm/filemap.c:2622
 filemap_read+0x35e/0xc70 mm/filemap.c:2693
 blkdev_read_iter+0x3eb/0x760 block/fops.c:609
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4b1/0x8a0 fs/read_write.c:470
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1805316b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffccfcc4668 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1805316b6a
RDX: 0000000000000400 RSI: 000055ca7c932ca8 RDI: 0000000000000009
RBP: 0000000000000400 R08: 000055ca7c932c80 R09: 0000000000000008
R10: 0000000000000051 R11: 0000000000000246 R12: 000055ca7c932c80
R13: 000055ca7c932c98 R14: 000055ca7c92c118 R15: 000055ca7c92c0c0
 </TASK>
BUG: sleeping function called from invalid context at lib/iov_iter.c:535
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 21075, name: udevd
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 0 PID: 21075 Comm: udevd Tainted: G        W          6.4.0-rc1-next-20230510-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10148
 __might_fault+0x79/0x190 mm/memory.c:5732
 _copy_to_iter+0x328/0x1360 lib/iov_iter.c:535
 copy_page_to_iter lib/iov_iter.c:742 [inline]
 copy_page_to_iter+0x125/0x1e0 lib/iov_iter.c:727
 copy_folio_to_iter include/linux/uio.h:197 [inline]
 filemap_read+0x682/0xc70 mm/filemap.c:2745
 blkdev_read_iter+0x3eb/0x760 block/fops.c:609
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4b1/0x8a0 fs/read_write.c:470
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1805316b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffccfcc4668 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1805316b6a
RDX: 0000000000000400 RSI: 000055ca7c932ca8 RDI: 0000000000000009
RBP: 0000000000000400 R08: 000055ca7c932c80 R09: 0000000000000008
R10: 0000000000000051 R11: 0000000000000246 R12: 000055ca7c932c80
R13: 000055ca7c932c98 R14: 000055ca7c92c118 R15: 000055ca7c92c0c0
 </TASK>
------------[ cut here ]------------
Voluntary context switch within RCU read-side critical section!
WARNING: CPU: 0 PID: 21075 at kernel/rcu/tree_plugin.h:320 rcu_note_context_switch+0xbb9/0x1800 kernel/rcu/tree_plugin.h:320
Modules linked in:
CPU: 0 PID: 21075 Comm: udevd Tainted: G        W          6.4.0-rc1-next-20230510-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:rcu_note_context_switch+0xbb9/0x1800 kernel/rcu/tree_plugin.h:320
Code: fd 04 68 00 4c 8b 4c 24 30 8b 4c 24 28 48 8b 54 24 20 e9 8f 03 00 00 48 c7 c7 c0 2a 4e 8a c6 05 93 44 f6 0c 01 e8 17 b5 dc ff <0f> 0b e9 4c f5 ff ff 81 e5 ff ff ff 7f 0f 84 d7 f6 ff ff 65 48 8b
RSP: 0018:ffffc900094f7938 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff8880b983d4c0 RCX: 0000000000000000
RDX: ffff88802211bb80 RSI: ffffffff814bc477 RDI: 0000000000000001
RBP: ffff88802211bb80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 216e6f6974636573 R12: 0000000000000000
R13: ffff88802211bb80 R14: ffffffff8e7b4130 R15: ffff8880b983c5c0
FS:  00007f18056c2c80(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00024b000 CR3: 00000000ace41000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __schedule+0x276/0x5790 kernel/sched/core.c:6569
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 schedule_hrtimeout_range_clock+0x45d/0x4b0 kernel/time/hrtimer.c:2298
 ep_poll fs/eventpoll.c:1925 [inline]
 do_epoll_wait+0x1210/0x1900 fs/eventpoll.c:2322
 __do_sys_epoll_wait fs/eventpoll.c:2334 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2329 [inline]
 __x64_sys_epoll_wait+0x15c/0x280 fs/eventpoll.c:2329
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1805323457
Code: 73 01 c3 48 8b 0d d1 d9 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 e8 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 76 48 8b 15 a2 d9 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffccfcc9bf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1805323457
RDX: 0000000000000004 RSI: 00007ffccfcc9c38 RDI: 0000000000000004
RBP: 000055ca7c92cd00 R08: 0000000000000007 R09: 9f790a821dee0ced
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055ca7c915af0
R13: 00007ffccfcc9c38 R14: 0000000000000008 R15: 000055ca7c90b910
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
