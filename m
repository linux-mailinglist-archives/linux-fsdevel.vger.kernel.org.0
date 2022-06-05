Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30AE53DAE5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 10:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350878AbiFEIt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350872AbiFEItX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:49:23 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254D231915
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jun 2022 01:49:20 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id y18-20020a927d12000000b002d3dd2a5d53so8894229ilc.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jun 2022 01:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IV7ywz665Ix+gipK57R8q4zD7XQNIWjTZkn3xvyHthk=;
        b=FmFhAQun+JhvAc/MhD13MyaZH3kpSiOAos1XUt8TxDmeigoML7TEHjnBffvZ03ihLy
         oa1LPLaCLJy9+XBBp3Uv+LONeHLfYgWXUUypVx2xHMJLrk64H45wLP7Tq1KPDDk5wqGC
         oUsWu6xLXEy8je0tS7TQr/L6r0nRXxYxlSSSmw/0ET1NQQK/O3pc9gYWNFEUzP0wSf5p
         nciZCOtGsosL7UBd2JyKtQWr0seACL4lpeFfc3i+sNu0sPeHaX4KcZPrPGSu2r6LgqKo
         Ak7bwDj4LI5lVo29KClOkBOQf1qPvLBvMdcPdykNtKJMvIlk23MRCfqpQn2nGqzC1izO
         hP9g==
X-Gm-Message-State: AOAM530vGf8K6wmzJRgItByP6/KyUZkpFEEj2WJ6ChHC8cuvEP0v7E9U
        SrNCzylelxLtAfopQfsDOu/GP9l3bZD7DL3rxzi2y8xjP0xU
X-Google-Smtp-Source: ABdhPJz1GT0ws86rdTjOQ11QAyVwn7fLFfVi0amY52RUv4weK/BEWC96JEfE6xFZUifcU4Ya61jZZVhPjbvrPx0yYvZmAwQn7p7W
MIME-Version: 1.0
X-Received: by 2002:a02:c6cf:0:b0:331:617f:ce6c with SMTP id
 r15-20020a02c6cf000000b00331617fce6cmr10027479jan.203.1654418959492; Sun, 05
 Jun 2022 01:49:19 -0700 (PDT)
Date:   Sun, 05 Jun 2022 01:49:19 -0700
In-Reply-To: <000000000000fd54f805e0351875@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063ee3105e0af6e6e@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in filp_close
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    952923ddc011 Merge tag 'pull-18-rc1-work.namei' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173fb6dbf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3096247591885bfa
dashboard link: https://syzkaller.appspot.com/bug?extid=47dd250f527cb7bebf24
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114f7bcdf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1659a94ff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47dd250f527cb7bebf24@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
BUG: KASAN: use-after-free in filp_close+0x22/0x160 fs/open.c:1382
Read of size 8 at addr ffff88807a11a7f0 by task syz-executor408/4522

CPU: 1 PID: 4522 Comm: syz-executor408 Not tainted 5.18.0-syzkaller-13842-g952923ddc011 #0
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
 close_files fs/file.c:432 [inline]
 put_files_struct fs/file.c:447 [inline]
 put_files_struct+0x1d0/0x350 fs/file.c:444
 exit_files+0x7e/0xa0 fs/file.c:464
 do_exit+0xac8/0x2a00 kernel/exit.c:790
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x2542/0x2600 kernel/signal.c:2857
 arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f2201c1f159
Code: Unable to access opcode bytes at RIP 0x7f2201c1f12f.
RSP: 002b:00007f2201bcc308 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f2201ca2428 RCX: 00007f2201c1f159
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f2201ca2428
RBP: 00007f2201ca2420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2201c70074
R13: 0000000000000005 R14: 00007f2201bcc400 R15: 0000000000022000
 </TASK>

Allocated by task 4522:
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
 io_close fs/io_uring.c:6053 [inline]
 io_issue_sqe+0x3f29/0x9780 fs/io_uring.c:8464
 io_queue_sqe fs/io_uring.c:8794 [inline]
 io_req_task_submit+0xce/0x400 fs/io_uring.c:3110
 handle_tw_list fs/io_uring.c:2984 [inline]
 tctx_task_work+0x16a/0xe10 fs/io_uring.c:3013
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 get_signal+0x1c5/0x2600 kernel/signal.c:2634
 arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88807a11a780
 which belongs to the cache filp of size 456
The buggy address is located 112 bytes inside of
 456-byte region [ffff88807a11a780, ffff88807a11a948)

The buggy address belongs to the physical page:
page:ffffea0001e84680 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88807a11bb80 pfn:0x7a11a
head:ffffea0001e84680 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001eed500 dead000000000004 ffff8881400078c0
raw: ffff88807a11bb80 00000000800c000a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3296, tgid 3296 (dhcpcd-run-hook), ts 21001730150, free_ts 17870277790
 prep_new_page mm/page_alloc.c:2456 [inline]
 get_page_from_freelist+0x1290/0x3b70 mm/page_alloc.c:4198
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5426
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
 free_pages_prepare mm/page_alloc.c:1371 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1421
 free_unref_page_prepare mm/page_alloc.c:3343 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3438
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
 getname_flags+0x9a/0xe0 include/linux/audit.h:323
 vfs_fstatat+0x73/0xb0 fs/stat.c:254
 __do_sys_newfstatat+0x91/0x110 fs/stat.c:425
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff88807a11a680: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
 ffff88807a11a700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807a11a780: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88807a11a800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807a11a880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

