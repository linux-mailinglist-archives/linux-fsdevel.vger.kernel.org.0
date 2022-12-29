Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B1A658B39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 10:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiL2JvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 04:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiL2Jsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:48:47 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF311800
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 01:48:42 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id y11-20020a056e02178b00b0030c048d64a7so5862128ilu.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 01:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kss6eUWD10xVzIRQeTaHUknlyYlXGExlDgq+oitxmk=;
        b=s+YA4zE1h7cVd5hCNhp4Pw5p/qx6k2SlYo9Kqkpz+EV8g/zxWOxrZ45v6rosNhH/kP
         uYwaitWD8g5gHxEj+lgLY+IoCW3LUuywA4kF26gc5nDfubXfWh8qc1B+ht2qVzETIKwk
         92HofDvZxmedUXyP9RD/9I4tw/fvstzDb+lhnlHxO0/52XCeBz1LIHLDDHpg/3vd39FJ
         KiICFcBybDj3Y3sF5w6S2dQmuFyrybNtiIv0rgcIzdjnJntEqGSLxOk7UZ0ooHZ1qamS
         AJ0ZVSOWUFkkWEHcvcDZQTxuK1xmUWW4yYDnLJZUB2ZjomePSq5D7cKHhxD37/BNJaV/
         nwuA==
X-Gm-Message-State: AFqh2kp/R5+Lt1VyPGshWQhumg6dBZTCY8B2WcApBKE6PPG4T7T/omKT
        43gCq2HFKAXczcwEzE0fogkUrmm+MhOnOlzmpK3dSJWm2/6l
X-Google-Smtp-Source: AMrXdXtm7AuMMZxjuzD2GMsqpKgSqGEtYNknoo3K13jQNq4cjZEFO210z28WDVs/OsJXWeDfI1I8pBe/2PGOWRMKPbhJtLIn91Q8
MIME-Version: 1.0
X-Received: by 2002:a5d:8410:0:b0:6df:3382:b63a with SMTP id
 i16-20020a5d8410000000b006df3382b63amr1948630ion.182.1672307322219; Thu, 29
 Dec 2022 01:48:42 -0800 (PST)
Date:   Thu, 29 Dec 2022 01:48:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5738d05f0f46309@google.com>
Subject: [syzbot] INFO: task hung in __unmap_and_move (4)
From:   syzbot <syzbot+b7ad168b779385f8cd58@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13835328480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4db06888b17328d6
dashboard link: https://syzkaller.appspot.com/bug?extid=b7ad168b779385f8cd58
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143d0688480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154e3cac480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b3fb0c07607/disk-72a85e2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7bf666312bb7/vmlinux-72a85e2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc83f4eef48d/bzImage-72a85e2b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7ad168b779385f8cd58@syzkaller.appspotmail.com

INFO: task kcompactd1:32 blocked for more than 143 seconds.
      Not tainted 6.1.0-syzkaller-14594-g72a85e2b0a1e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kcompactd1      state:D stack:26360 pid:32    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 io_schedule+0x83/0x100 kernel/sched/core.c:8811
 folio_wait_bit_common+0x8ca/0x1390 mm/filemap.c:1297
 folio_lock include/linux/pagemap.h:938 [inline]
 __unmap_and_move+0x835/0x12a0 mm/migrate.c:1040
 unmap_and_move+0x28f/0xd80 mm/migrate.c:1194
 migrate_pages+0x50f/0x14d0 mm/migrate.c:1477
 compact_zone+0x2893/0x37a0 mm/compaction.c:2413
 proactive_compact_node mm/compaction.c:2665 [inline]
 kcompactd+0x1b46/0x2750 mm/compaction.c:2975
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d523910 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d524110 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8d523740 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
1 lock held by kswapd0/81:
3 locks held by kswapd1/84:
1 lock held by klogd/4412:
3 locks held by dhcpcd/4635:
2 locks held by getty/4744:
 #0: ffff88802d6f3098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6e8/0x1e50 drivers/tty/n_tty.c:2177
2 locks held by syz-executor387/5109:
2 locks held by kworker/u4:0/5111:
 #0: ffff888012879138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
 #1: ffffc90003f4fd00 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
2 locks held by dhcpcd/5117:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.1.0-syzkaller-14594-g72a85e2b0a1e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x4e3/0x560 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x19b/0x3e0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcd5/0xd20 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4635 Comm: dhcpcd Not tainted 6.1.0-syzkaller-14594-g72a85e2b0a1e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x84/0x2e0 mm/kasan/generic.c:189
Code: da 4d 89 d6 4d 29 ce 49 83 fe 10 7f 30 4d 85 f6 0f 84 8e 01 00 00 4c 89 cb 4c 29 d3 66 2e 0f 1f 84 00 00 00 00 00 41 80 39 00 <0f> 85 e7 01 00 00 49 ff c1 48 ff c3 75 ee e9 67 01 00 00 44 89 cd
RSP: 0000:ffffc9000359e788 EFLAGS: 00000046
RAX: 0000000000000001 RBX: ffffffffffffffff RCX: ffffffff816cc01b
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8eb01da8
RBP: 000000000001ffff R08: dffffc0000000000 R09: fffffbfff1d603b5
R10: fffffbfff1d603b6 R11: 1ffffffff1d603b5 R12: dffffc0000000000
R13: ffffffff81c45785 R14: 0000000000000001 R15: 1ffff920006b3d08
FS:  00007f8f1abe3740(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f505f46d8b7 CR3: 000000001f195000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 cpumask_test_cpu include/linux/cpumask.h:444 [inline]
 cpu_online include/linux/cpumask.h:1030 [inline]
 trace_lock_release+0x5b/0x220 include/trace/events/lock.h:69
 lock_release+0x81/0x870 kernel/locking/lockdep.c:5679
 rcu_read_unlock include/linux/rcupdate.h:797 [inline]
 folio_evictable+0x1df/0x2d0 mm/internal.h:140
 move_folios_to_lru+0x324/0x25c0 mm/vmscan.c:2413
 shrink_inactive_list+0x60b/0xca0 mm/vmscan.c:2529
 shrink_list mm/vmscan.c:2767 [inline]
 shrink_lruvec+0x449/0xc50 mm/vmscan.c:5951
 shrink_node_memcgs+0x35c/0x780 mm/vmscan.c:6138
 shrink_node+0x299/0x1050 mm/vmscan.c:6169
 shrink_zones+0x4fb/0xc40 mm/vmscan.c:6407
 do_try_to_free_pages+0x215/0xcd0 mm/vmscan.c:6469
 try_to_free_pages+0x3e8/0xc60 mm/vmscan.c:6704
 __perform_reclaim mm/page_alloc.c:4750 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4772 [inline]
 __alloc_pages_slowpath+0xd5c/0x2120 mm/page_alloc.c:5178
 __alloc_pages+0x3d4/0x560 mm/page_alloc.c:5562
 folio_alloc+0x1a/0x50 mm/mempolicy.c:2296
 filemap_alloc_folio+0xca/0x2c0 mm/filemap.c:972
 page_cache_ra_unbounded+0x212/0x820 mm/readahead.c:248
 do_sync_mmap_readahead+0x786/0x950 mm/filemap.c:3062
 filemap_fault+0x38d/0x1060 mm/filemap.c:3154
 __do_fault+0x136/0x4f0 mm/memory.c:4163
 do_read_fault mm/memory.c:4514 [inline]
 do_fault mm/memory.c:4643 [inline]
 handle_pte_fault mm/memory.c:4931 [inline]
 __handle_mm_fault mm/memory.c:5073 [inline]
 handle_mm_fault+0x2076/0x26c0 mm/memory.c:5219
 do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x120 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x56359ff3a260
Code: Unable to access opcode bytes at 0x56359ff3a236.
RSP: 002b:00007fff59b49a78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000007d0 RCX: 000000000cdc2932
RDX: 0000000000000510 RSI: 0000000000000001 RDI: 00000000000007d0
RBP: 0000000000000510 R08: 000000001dc81186 R09: 0000000000000010
R10: 00007fff59b6c0b8 R11: 0000000000020822 R12: 00005635a0cbafd0
R13: 000056359ff50ee1 R14: 00005635a0da0a90 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
