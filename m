Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B2540346
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 18:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344715AbiFGQCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 12:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiFGQCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:02:30 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5304F2A413
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 09:02:28 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i16-20020a056e021d1000b002d3bbe39232so14039942ila.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 09:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6pazMwnEZdGqok3Ss4M7H81NmMHYzu+I9eFPPS07dLg=;
        b=GHgLaogBSCBsBcuJfx0UVdNtdfuCFc+SMFsiKIcJiRrdWMNhF//Vrhi7f2ZbEHRwog
         v5hZnUl780kil3We6jzrsAXJIglqrUInCFyDCs5kTnBA+VnhDKwXzeQeqqo9l57pzEWB
         H0ZHUcboChCiHkLi0J6fBLXqsCkAMUO/m1gFCJ7dKuRK/QjJPdceIN5wieKTlF6xbAG4
         Sv6qBC+t1La/pNM1UlMprcZAzb70d9AFsDKW/Ju9OyTdnehHGemSWhxOftcQn6yEElR2
         SFy3jrRW6qhKN4kG3fdsT0lRaz+s1WjdyRkidc80n5rAoi2IhrN+feEnrCWRjJMTaZqU
         +l4g==
X-Gm-Message-State: AOAM530MCGm347ccYp4N9Qy+sv3TtY6+gvITjwt2qub4y57IlOhw4tX7
        zJnDuXiuBKh4IelljdbOKJCsB6Mbhb5C36RuW1obda3mpVdb
X-Google-Smtp-Source: ABdhPJzUmyNxH7TM3sxBGRC7S9rgG1s2eC16WiwDyPCi+wnWEaNJi2cTZkfhEY54u5b/ywAP4YIW3BsboMHmWxzJpNFtnEcK4zDT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:2d1:abab:8806 with SMTP id
 m2-20020a056e021c2200b002d1abab8806mr16151700ilh.300.1654617747661; Tue, 07
 Jun 2022 09:02:27 -0700 (PDT)
Date:   Tue, 07 Jun 2022 09:02:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016aa8805e0ddb7db@google.com>
Subject: [syzbot] KASAN: use-after-free Read in mas_find
From:   syzbot <syzbot+53a201cf0c3cd0082a4e@syzkaller.appspotmail.com>
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

HEAD commit:    1cfd968b58a1 Add linux-next specific files for 20220603
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e69f1ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7da8386e3742814f
dashboard link: https://syzkaller.appspot.com/bug?extid=53a201cf0c3cd0082a4e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53a201cf0c3cd0082a4e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ma_dead_node lib/maple_tree.c:532 [inline]
BUG: KASAN: use-after-free in mas_next_entry lib/maple_tree.c:4638 [inline]
BUG: KASAN: use-after-free in mas_find+0xada/0xce0 lib/maple_tree.c:5874
Read of size 8 at addr ffff888023d1c800 by task syz-executor.5/3458

CPU: 0 PID: 3458 Comm: syz-executor.5 Not tainted 5.18.0-next-20220603-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 ma_dead_node lib/maple_tree.c:532 [inline]
 mas_next_entry lib/maple_tree.c:4638 [inline]
 mas_find+0xada/0xce0 lib/maple_tree.c:5874
 userfaultfd_release+0x239/0x670 fs/userfaultfd.c:879
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f11c7089109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f11c8259168 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f11c719c030 RCX: 00007f11c7089109
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f11c70e308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe6d2c0bdf R14: 00007f11c8259300 R15: 0000000000022000
 </TASK>

Allocated by task 3457:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 kmem_cache_alloc_bulk+0x39f/0x720 mm/slub.c:3728
 mt_alloc_bulk lib/maple_tree.c:151 [inline]
 mas_alloc_nodes+0x2b0/0x6b0 lib/maple_tree.c:1244
 mas_preallocate+0xfb/0x270 lib/maple_tree.c:5586
 __vma_adjust+0x226/0x1900 mm/mmap.c:762
 vma_adjust include/linux/mm.h:2659 [inline]
 __split_vma+0x295/0x530 mm/mmap.c:2315
 do_mas_align_munmap+0x2c0/0xf00 mm/mmap.c:2412
 do_mas_munmap+0x202/0x2c0 mm/mmap.c:2569
 do_munmap+0xc3/0x100 mm/mmap.c:2583
 move_vma+0x776/0xf60 mm/mremap.c:701
 mremap_to mm/mremap.c:859 [inline]
 __do_sys_mremap+0xe68/0x1540 mm/mremap.c:970
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 3458:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kmem_cache_free_bulk mm/slub.c:3654 [inline]
 kmem_cache_free_bulk+0x2c0/0xb60 mm/slub.c:3641
 mt_free_bulk lib/maple_tree.c:157 [inline]
 mas_destroy+0x394/0x5c0 lib/maple_tree.c:5690
 mas_store_prealloc+0xec/0x150 lib/maple_tree.c:5571
 __vma_adjust+0x6d7/0x1900 mm/mmap.c:832
 vma_merge+0x39f/0x950 mm/mmap.c:1141
 userfaultfd_release+0x4c5/0x670 fs/userfaultfd.c:888
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff888023d1c800
 which belongs to the cache maple_node of size 256
The buggy address is located 0 bytes inside of
 256-byte region [ffff888023d1c800, ffff888023d1c900)

The buggy address belongs to the physical page:
page:ffffea00008f4700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23d1c
head:ffffea00008f4700 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001c8b880 dead000000000002 ffff88801184fdc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 28727, tgid 28727 (sed), ts 1369208986499, free_ts 1341001205352
 prep_new_page mm/page_alloc.c:2460 [inline]
 get_page_from_freelist+0xa64/0x3d10 mm/page_alloc.c:4279
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5503
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1797 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3002
 kmem_cache_alloc_bulk+0x21c/0x720 mm/slub.c:3704
 mt_alloc_bulk lib/maple_tree.c:151 [inline]
 mas_alloc_nodes+0x2b0/0x6b0 lib/maple_tree.c:1244
 mas_preallocate+0xfb/0x270 lib/maple_tree.c:5586
 __vma_adjust+0x226/0x1900 mm/mmap.c:762
 vma_adjust include/linux/mm.h:2659 [inline]
 __split_vma+0x443/0x530 mm/mmap.c:2312
 do_mas_align_munmap+0x9f6/0xf00 mm/mmap.c:2433
 do_mas_munmap+0x202/0x2c0 mm/mmap.c:2569
 mmap_region+0x219/0x1bf0 mm/mmap.c:2617
 do_mmap+0x825/0xf60 mm/mmap.c:1493
 vm_mmap_pgoff+0x1b7/0x290 mm/util.c:520
 ksys_mmap_pgoff+0x40d/0x5a0 mm/mmap.c:1539
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1375 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1425
 free_unref_page_prepare mm/page_alloc.c:3311 [inline]
 free_unref_page+0x19/0x7b0 mm/page_alloc.c:3426
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmalloc+0x200/0x350 mm/slub.c:4413
 kmalloc include/linux/slab.h:605 [inline]
 tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
 security_inode_getattr+0xcf/0x140 security/security.c:1344
 vfs_getattr fs/stat.c:157 [inline]
 vfs_statx+0x16a/0x390 fs/stat.c:232
 vfs_fstatat+0x8c/0xb0 fs/stat.c:255
 __do_sys_newfstatat+0x91/0x110 fs/stat.c:425
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff888023d1c700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888023d1c780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888023d1c800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888023d1c880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888023d1c900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
