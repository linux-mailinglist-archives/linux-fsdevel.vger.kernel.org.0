Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A675DCE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 16:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGVON4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jul 2023 10:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGVONz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:13:55 -0400
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594792D50
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jul 2023 07:13:53 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6b9e5c9148dso5867924a34.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jul 2023 07:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690035232; x=1690640032;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vk2T6BNaTNdRZJLDIaBjd8p//aZTXPIfdCAtBG/NKTY=;
        b=LctAr4EpwHFpiPQMF0NC+OIULyh3iVzXNTuP0G2FxpWXoRt22dKgdc7Px/XUEDjX8P
         cnpYX3WxstouqmJbIw19diccRZn/03chulxiLk2mnikeznst9riMSs5WYN1MvqooYjBy
         uIVa0uZL3R+wC6l9DwRu4LG/UTCEmMYPe+w2qZxVmN0Rm5/GA94e1VSveZiYuzlpOpmz
         F78KUBK8NUfWbtjgvZ8IKzzFwv35V9L5b/Ob4PWN8Ux+eUwn0eNstBupsA6aTxRCmbpk
         ucbjbSBgM3QzbP8sveWCP1Nc0WvSiB2mDB1pOFKgKnzE7v4dm/z8kV1UJi83EnKky5Ed
         45uA==
X-Gm-Message-State: ABy/qLasNJcEs8NKH9MfWPT/O4b4cvNltOw+atinvBhFLB+jF6OkIOMx
        GiDe/Ba6OigRxpZnB6GCmgmw04yY90nWiGhToKCEw6UWJBnT
X-Google-Smtp-Source: APBJJlGsLdzsDFYjRrk2yAeug9/3GbUHWL6Al/sJfrA8zgRtqvK/RVCtJYkTw1VjHOh7xnwoT+Zo37DT4pcGPvmqKMTOvyC+Iqbm
MIME-Version: 1.0
X-Received: by 2002:a9d:65d8:0:b0:6b7:54de:87dc with SMTP id
 z24-20020a9d65d8000000b006b754de87dcmr3241367oth.0.1690035232760; Sat, 22 Jul
 2023 07:13:52 -0700 (PDT)
Date:   Sat, 22 Jul 2023 07:13:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4e906060113fd63@google.com>
Subject: [syzbot] [nilfs?] KASAN: slab-use-after-free Read in
 nilfs_load_inode_block (2)
From:   syzbot <syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fdf0eaf11452 Linux 6.5-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11354edca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=74db8b3087f293d3a13a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/227b5c9aa7b3/disk-fdf0eaf1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aedc7f03bef6/vmlinux-fdf0eaf1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec543f1fd878/bzImage-fdf0eaf1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in nilfs_load_inode_block+0x11e/0x280 fs/nilfs2/inode.c:1030
Read of size 8 at addr ffff888023e50230 by task syz-executor.2/5056

CPU: 1 PID: 5056 Comm: syz-executor.2 Not tainted 6.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 nilfs_load_inode_block+0x11e/0x280 fs/nilfs2/inode.c:1030
 __nilfs_mark_inode_dirty+0xa5/0x280 fs/nilfs2/inode.c:1107
 nilfs_dirty_inode+0x164/0x200 fs/nilfs2/inode.c:1148
 __mark_inode_dirty+0x305/0xd90 fs/fs-writeback.c:2430
 mark_inode_dirty_sync include/linux/fs.h:2153 [inline]
 iput+0x1f2/0x8f0 fs/inode.c:1814
 nilfs_dispose_list+0x51d/0x5c0 fs/nilfs2/segment.c:816
 nilfs_detach_log_writer+0xaf1/0xbb0 fs/nilfs2/segment.c:2859
 nilfs_put_super+0x4d/0x160 fs/nilfs2/super.c:498
 generic_shutdown_super+0x134/0x340 fs/super.c:499
 kill_block_super+0x68/0xa0 fs/super.c:1417
 deactivate_locked_super+0xa4/0x110 fs/super.c:330
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f723027de57
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe73394f58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f723027de57
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffe73395010
RBP: 00007ffe73395010 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe733960d0
R13: 00007f72302c73b9 R14: 0000000000032737 R15: 000000000000000c
 </TASK>

Allocated by task 5412:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:582 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 nilfs_find_or_create_root+0x137/0x4e0 fs/nilfs2/the_nilfs.c:851
 nilfs_attach_checkpoint+0x123/0x4d0 fs/nilfs2/super.c:550
 nilfs_fill_super+0x321/0x600 fs/nilfs2/super.c:1095
 nilfs_mount+0x637/0x950 fs/nilfs2/super.c:1343
 legacy_get_tree+0xef/0x190 fs/fs_context.c:611
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5056:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook mm/slub.c:1818 [inline]
 slab_free mm/slub.c:3801 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3814
 nilfs_segctor_destroy fs/nilfs2/segment.c:2782 [inline]
 nilfs_detach_log_writer+0x8c1/0xbb0 fs/nilfs2/segment.c:2845
 nilfs_put_super+0x4d/0x160 fs/nilfs2/super.c:498
 generic_shutdown_super+0x134/0x340 fs/super.c:499
 kill_block_super+0x68/0xa0 fs/super.c:1417
 deactivate_locked_super+0xa4/0x110 fs/super.c:330
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888023e50200
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 48 bytes inside of
 freed 256-byte region [ffff888023e50200, ffff888023e50300)

The buggy address belongs to the physical page:
page:ffffea00008f9400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23e50
head:ffffea00008f9400 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012841b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5181, tgid 5181 (syz-executor.2), ts 197741582486, free_ts 196828318372
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x31e8/0x3370 mm/page_alloc.c:3221
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4477
 alloc_slab_page+0x6a/0x160 mm/slub.c:1862
 allocate_slab mm/slub.c:2009 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2062
 ___slab_alloc+0xade/0x1100 mm/slub.c:3215
 __slab_alloc mm/slub.c:3314 [inline]
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3509
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1076
 kmalloc include/linux/slab.h:582 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 smk_fetch+0x92/0x140 security/smack/smack_lsm.c:291
 smack_d_instantiate+0x868/0xb40 security/smack/smack_lsm.c:3541
 security_d_instantiate+0x9b/0xf0 security/security.c:3760
 d_instantiate_new+0x65/0x120 fs/dcache.c:2053
 ext4_add_nondir+0x22d/0x290 fs/ext4/namei.c:2797
 ext4_symlink+0x908/0xb30 fs/ext4/namei.c:3431
 vfs_symlink+0x12f/0x2a0 fs/namei.c:4477
 do_symlinkat+0x201/0x610 fs/namei.c:4503
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2348
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2443
 discard_slab mm/slub.c:2108 [inline]
 __unfreeze_partials+0x1dc/0x220 mm/slub.c:2647
 put_cpu_partial+0x116/0x180 mm/slub.c:2723
 __slab_free+0x2b6/0x390 mm/slub.c:3671
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x6c/0x3b0 mm/slab.h:762
 slab_alloc_node mm/slub.c:3470 [inline]
 __kmem_cache_alloc_node+0x141/0x270 mm/slub.c:3509
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1076
 kmalloc include/linux/slab.h:582 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 mca_alloc net/ipv6/mcast.c:880 [inline]
 __ipv6_dev_mc_inc+0x426/0xa80 net/ipv6/mcast.c:936
 addrconf_join_solict net/ipv6/addrconf.c:2179 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:3995 [inline]
 addrconf_dad_work+0x424/0x16b0 net/ipv6/addrconf.c:4120
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2597
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2748
 kthread+0x2b8/0x350 kernel/kthread.c:389

Memory state around the buggy address:
 ffff888023e50100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888023e50180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888023e50200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888023e50280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888023e50300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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
