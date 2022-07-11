Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F79F56D733
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiGKH61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 03:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiGKH6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:58:25 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED3D1CB33
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 00:58:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f18-20020a5d8592000000b0067289239d1dso2325119ioj.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 00:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=f6DBwuSFbGf8WakF4lKOf0fjXviQhhf99PXCYpk3mfQ=;
        b=17hufeu4X8WfHCm6hQUSv35X0NT5EuaPfEGXiA1JvUgrC5cdCL2gaGa/e3IACf3suJ
         BUwiM8iQjdRXAziig3fb3dPzZv3t+PbdUBevGavI1YstCMuAjhHBFNzIUNfSpkaibY78
         cHOa1a8vpNsEVkzbjAsIQpoUoMCb3riR8OvJurQfFuEjc0tkPtWtjUF69com/v8sUhO/
         TFt8jeQslvs1UZLKNAk2FKOUBfqFVHKHp9ajyycJRwsUlwEbeNfgrgCL5sfif0K2Djo6
         Qny7jMP8ti5dwi5W+64cMUtTacZ1kgqqaP2dMwv+znaC06GiPzuWeBflQWwvehfFhNi7
         Ql5A==
X-Gm-Message-State: AJIora9J5bwOZaIv4ltn8pr+y7dNLaiCZ/dBTdut22JYI4OrJwANF+qJ
        nE0dbRTcXZSqmU5HJmxfEdFu58l4gw81FfgXWERlKKHT22c5
X-Google-Smtp-Source: AGRyM1ux3kkQzvSIFPWcrFkmxhsv5rm50ueELpl7NWXuihnWIFY1Yx3TFGfhNnEnY6tFF4TSxEAERvdaKBD9bMbhK/GxA6bSNBxk
MIME-Version: 1.0
X-Received: by 2002:a02:ac05:0:b0:33f:449f:6b61 with SMTP id
 a5-20020a02ac05000000b0033f449f6b61mr5363510jao.204.1657526301381; Mon, 11
 Jul 2022 00:58:21 -0700 (PDT)
Date:   Mon, 11 Jul 2022 00:58:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000665b1805e382eaa5@google.com>
Subject: [syzbot] KASAN: use-after-free Read in pipe_release
From:   syzbot <syzbot+2c2316612d8ce40d6e4a@syzkaller.appspotmail.com>
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

HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e58ff4080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=2c2316612d8ce40d6e4a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c2316612d8ce40d6e4a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __wake_up_common+0x637/0x650 kernel/sched/wait.c:100
Read of size 8 at addr ffff88807b2f09b0 by task syz-executor.5/8273

CPU: 0 PID: 8273 Comm: syz-executor.5 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 __wake_up_common+0x637/0x650 kernel/sched/wait.c:100
 __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:137
 pipe_release+0x188/0x310 fs/pipe.c:728
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xaf1/0x29f0 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x2542/0x2600 kernel/signal.c:2857
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fbb65e89109
Code: Unable to access opcode bytes at RIP 0x7fbb65e890df.
RSP: 002b:00007fbb67042168 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: 00000000000002fe RBX: 00007fbb65f9c100 RCX: 00007fbb65e89109
RDX: 0000000001000000 RSI: 00000000000002fe RDI: 0000000000000007
RBP: 00007fbb65ee305d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe29a8142f R14: 00007fbb67042300 R15: 0000000000022000
 </TASK>

Allocated by task 8273:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:600 [inline]
 __io_queue_proc+0x2dc/0x950 io_uring/poll.c:429
 poll_wait include/linux/poll.h:49 [inline]
 pipe_poll+0x294/0x7d0 fs/pipe.c:667
 vfs_poll include/linux/poll.h:88 [inline]
 __io_arm_poll_handler+0x488/0x1060 io_uring/poll.c:511
 io_arm_poll_handler+0x5c6/0xce0 io_uring/poll.c:638
 io_queue_async+0xc1/0x3e0 io_uring/io_uring.c:1753
 io_queue_sqe io_uring/io_uring.c:1787 [inline]
 io_submit_sqe io_uring/io_uring.c:2036 [inline]
 io_submit_sqes+0x15fc/0x1ec0 io_uring/io_uring.c:2147
 __do_sys_io_uring_enter+0xb85/0x1eb0 io_uring/io_uring.c:3087
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 8273:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3534 [inline]
 kfree+0xe2/0x4d0 mm/slub.c:4562
 io_clean_op+0x1b1/0xa40 io_uring/io_uring.c:1555
 io_dismantle_req io_uring/io_uring.c:930 [inline]
 __io_req_complete_put+0x649/0x8b0 io_uring/io_uring.c:801
 __io_req_complete_post io_uring/io_uring.c:812 [inline]
 io_req_complete_post+0x98/0x260 io_uring/io_uring.c:820
 handle_tw_list+0xa8/0x420 io_uring/io_uring.c:1009
 tctx_task_work+0x11b/0x420 io_uring/io_uring.c:1062
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 get_signal+0x1c5/0x2600 kernel/signal.c:2634
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88807b2f0980
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 48 bytes inside of
 64-byte region [ffff88807b2f0980, ffff88807b2f09c0)

The buggy address belongs to the physical page:
page:ffffea0001ecbc00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b2f0
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888011841640
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 4744, tgid 4744 (kworker/u4:22), ts 430287601091, free_ts 430006695756
 prep_new_page mm/page_alloc.c:2535 [inline]
 get_page_from_freelist+0x210d/0x3a30 mm/page_alloc.c:4282
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5506
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x89d/0xef0 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmalloc+0x3a2/0x450 mm/slub.c:4420
 kmalloc include/linux/slab.h:605 [inline]
 ieee802_11_parse_elems_crc+0x14d/0x1050 net/mac80211/util.c:1508
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2269 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1606 [inline]
 ieee80211_ibss_rx_queued_mgmt+0xc82/0x30d0 net/mac80211/ibss.c:1640
 ieee80211_iface_process_skb net/mac80211/iface.c:1594 [inline]
 ieee80211_iface_work+0xa7f/0xd20 net/mac80211/iface.c:1648
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3383 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3479
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2548
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:736 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc+0x2d6/0x4c0 mm/slub.c:3268
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 alloc_buffer_head+0x20/0x140 fs/buffer.c:2973
 jbd2_journal_write_metadata_buffer+0xcc/0xba0 fs/jbd2/journal.c:364
 jbd2_journal_commit_transaction+0x173b/0x6a70 fs/jbd2/commit.c:700
 kjournald2+0x1d0/0x930 fs/jbd2/journal.c:213
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Memory state around the buggy address:
 ffff88807b2f0880: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88807b2f0900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88807b2f0980: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                     ^
 ffff88807b2f0a00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88807b2f0a80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
