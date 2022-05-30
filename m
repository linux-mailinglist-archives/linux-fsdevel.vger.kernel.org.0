Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1FC5374CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 09:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiE3GwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 02:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiE3GwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 02:52:23 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF5579BD
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 May 2022 23:52:21 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id a3-20020a924443000000b002d1bc79da14so7897776ilm.15
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 May 2022 23:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fcHkapimJF4SbHQqfW94bnVePzFm6l0FaU5tLfmyMwQ=;
        b=2c+MifTcyJ3NIgcNRTeOv41FoD4SHpPTXiJbhkrLAbi54QR+xSK56WaAVimGuMHN01
         5lyx7GDrbtTgNS5MgJ2hbkxyPfw5Q+RETcRjv11yk/wSLDbUELyAJ0kLlJ/N+NxCBp4C
         Ek4jB0iZQR1ALUzX5/NC9Egd+QqG2A4+OhN98NXJnnX1CXvubsYyQJop67Eem0dGJWa5
         EDcd+QJky/w4g/bL1Ik2kWkeVjKCD2qL8aJfIZswMnkCOEtEcgh+NVtkFiuPJ0sHRA3C
         hUqUJ/6axGEP/Gdw1/tx6yN/PoYQTtVUz5UoNSUUVyGo+ztFmnvX6hBTjTTlRJ7Wbvw1
         2S6g==
X-Gm-Message-State: AOAM532SgjY7O+z9piLRq5oxkRwD29vSvgFg4SKV9KMkve0f04QaQR9c
        lcLrDMk6Ibz4J82CUmnyTFjzNkBKFY4Q066QJLMUKl7s9Bb8
X-Google-Smtp-Source: ABdhPJw4P9PXzcYfVLK+AWJ9by1ydUKctufrvDiiIfud3exksMZjfgaLLuThv97tN8WJZbk/HPxWvlbdISHOnePw39evxaRjjFbk
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1687:b0:330:b377:40a0 with SMTP id
 f7-20020a056638168700b00330b37740a0mr12256866jat.50.1653893540695; Sun, 29
 May 2022 23:52:20 -0700 (PDT)
Date:   Sun, 29 May 2022 23:52:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd54f805e0351875@google.com>
Subject: [syzbot] KASAN: use-after-free Read in filp_close
From:   syzbot <syzbot+47dd250f527cb7bebf24@syzkaller.appspotmail.com>
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

HEAD commit:    09ce5091ff97 Add linux-next specific files for 20220524
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b2d9c3f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39c2df848969b1de
dashboard link: https://syzkaller.appspot.com/bug?extid=47dd250f527cb7bebf24
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47dd250f527cb7bebf24@syzkaller.appspotmail.com

==================================================================
==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
BUG: KASAN: use-after-free in filp_close+0x22/0x160 fs/open.c:1382
Read of size 8 at addr ffff8880732abbf0 by task syz-executor.2/5896

CPU: 1 PID: 5896 Comm: syz-executor.2 Not tainted 5.18.0-next-20220524-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
 filp_close+0x22/0x160 fs/open.c:1382
 close_fd+0x76/0xa0 fs/file.c:664
 __do_sys_close fs/open.c:1407 [inline]
 __se_sys_close fs/open.c:1405 [inline]
 __x64_sys_close+0x2f/0xa0 fs/open.c:1405
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f2dab83bd4b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffd73d7f330 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f2dab83bd4b
RDX: 00007f2dab9a18b0 RSI: ffffffffffffffff RDI: 0000000000000004
RBP: 00007f2dab99d960 R08: 0000000000000000 R09: 00007f2dab9a18b8
R10: 00007ffd73d7f430 R11: 0000000000000293 R12: 000000000002dac5
R13: 00007ffd73d7f430 R14: 00007f2dab99bf60 R15: 0000000000000032
 </TASK>

Allocated by task 5898:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x204/0x3b0 mm/slub.c:3239
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 __alloc_file+0x21/0x270 fs/file_table.c:138
 alloc_empty_file+0x6d/0x170 fs/file_table.c:187
 alloc_file+0x59/0x590 fs/file_table.c:229
 alloc_file_pseudo+0x165/0x250 fs/file_table.c:269
 sock_alloc_file+0x4f/0x190 net/socket.c:463
 sock_map_fd net/socket.c:487 [inline]
 __sys_socket+0x1a4/0x240 net/socket.c:1644
 __do_sys_socket net/socket.c:1649 [inline]
 __se_sys_socket net/socket.c:1647 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 22:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kmem_cache_free+0xdd/0x5a0 mm/slub.c:3524
 rcu_do_batch kernel/rcu/tree.c:2578 [inline]
 rcu_core+0x7b1/0x1880 kernel/rcu/tree.c:2838
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 call_rcu+0x99/0x790 kernel/rcu/tree.c:3126
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 get_signal+0x1c5/0x2600 kernel/signal.c:2634
 arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 task_work_add+0x3a/0x1f0 kernel/task_work.c:48
 fput fs/file_table.c:378 [inline]
 fput+0xe7/0x190 fs/file_table.c:371
 io_close fs/io_uring.c:6032 [inline]
 io_issue_sqe+0x39cf/0xaa20 fs/io_uring.c:8360
 io_queue_sqe fs/io_uring.c:8703 [inline]
 io_req_task_submit+0xce/0x400 fs/io_uring.c:3066
 handle_tw_list fs/io_uring.c:2938 [inline]
 tctx_task_work+0x16a/0xe10 fs/io_uring.c:2967
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 get_signal+0x1c5/0x2600 kernel/signal.c:2634
 arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff8880732abb80
 which belongs to the cache filp of size 456
The buggy address is located 112 bytes inside of
 456-byte region [ffff8880732abb80, ffff8880732abd48)

The buggy address belongs to the physical page:
page:ffffea0001ccaa80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x732aa
head:ffffea0001ccaa80 order:1 compound_mapcount:0 compound_pincount:0
memcg:ffff88807f60f401
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff8881400078c0
raw: 0000000000000000 00000000000c000c 00000001ffffffff ffff88807f60f401
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 2981, tgid 2981 (udevd), ts 187061397867, free_ts 187031412765
 prep_new_page mm/page_alloc.c:2439 [inline]
 get_page_from_freelist+0xa64/0x3d10 mm/page_alloc.c:4258
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5482
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1797 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3002
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3089
 slab_alloc_node mm/slub.c:3180 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x360/0x3b0 mm/slub.c:3239
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 __alloc_file+0x21/0x270 fs/file_table.c:138
 alloc_empty_file+0x6d/0x170 fs/file_table.c:187
 path_openat+0xe4/0x2910 fs/namei.c:3639
 do_filp_open+0x1aa/0x400 fs/namei.c:3680
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1354 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3290 [inline]
 free_unref_page+0x19/0x7b0 mm/page_alloc.c:3405
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2521
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x204/0x3b0 mm/slub.c:3239
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags include/linux/audit.h:323 [inline]
 getname+0x8e/0xd0 fs/namei.c:218
 do_sys_openat2+0xf5/0x4c0 fs/open.c:1272
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff8880732aba80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8880732abb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880732abb80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff8880732abc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880732abc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
