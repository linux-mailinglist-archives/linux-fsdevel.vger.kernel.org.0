Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DCE6FD78D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 08:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjEJG46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 02:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjEJG4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 02:56:55 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4833270E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 23:56:50 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-763da06581dso453022539f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 May 2023 23:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683701810; x=1686293810;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWHOtvYBzvGnDM8MyX8XdBJwis7G7I+vDy9X5ohUnoc=;
        b=gV/vVmSQadBIR4/hITSejQ4TEID3ZQUkhs7/0iOaj8YzbFth5hqCuFSQXGDosyCbIH
         VmpXBEkf2MEr/Yltpku7fXmmjJDRSE+xa+++zNCnT/Bj1wjTkonjedUsAnnnDfxmBuIA
         IN3Y1JdMCpXlZ8DVnwvTIN4CECbuX7++dzzNUOlabVKM6/p7CSqYWtywxy6gOI8M2BQz
         ljURVHvoQxcUH5TO0OFz+xVkLC9BkYzUh3XdI3DxlWaDPBLX+Q0E49LvAs7Mp5l1wiRt
         6vu0rq032OrYg+BEVg0G2Ir3zsjQjf8VC4mLnpwWNYqi5sHgsUBt7hJCizppBckuXzTE
         HwCg==
X-Gm-Message-State: AC+VfDy9+YbMhcCxFrI7vkQyfsOHpw6sCB14zN5zJU19aLIiIy7C+PzX
        5pfM70LnxYehzdNLfH4LA9dN3eYETlZPnGP+Knf8kPxC7pFN
X-Google-Smtp-Source: ACHHUZ4p02poOhCd265HalrkZmCJ8dN/ii6owlWitseqyb91C/EKe6Y8MO5ib8iZ41VRamAP3ad8u0Nso3M6WBCteC+BYzoqOq3K
MIME-Version: 1.0
X-Received: by 2002:a02:9607:0:b0:40f:9859:1fa5 with SMTP id
 c7-20020a029607000000b0040f98591fa5mr2716110jai.2.1683701809969; Tue, 09 May
 2023 23:56:49 -0700 (PDT)
Date:   Tue, 09 May 2023 23:56:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a820c05fb5160ad@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in __btrfs_release_delayed_node
From:   syzbot <syzbot+5927b00bae2996410ad4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7163a2111f6c Merge tag 'acpi-6.4-rc1-3' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11729582280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
dashboard link: https://syzkaller.appspot.com/bug?extid=5927b00bae2996410ad4
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/01051811f2fe/disk-7163a211.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a26c68e4c8a6/vmlinux-7163a211.xz
kernel image: https://storage.googleapis.com/syzbot-assets/17380fb8dad4/bzImage-7163a211.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5927b00bae2996410ad4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:1309 [inline]
BUG: KASAN: slab-use-after-free in __mutex_trylock_common+0x91/0x2e0 kernel/locking/mutex.c:107
Read of size 8 at addr ffff888023d46818 by task btrfs-cleaner/8615

CPU: 1 PID: 8615 Comm: btrfs-cleaner Not tainted 6.3.0-syzkaller-13225-g7163a2111f6c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:1309 [inline]
 __mutex_trylock_common+0x91/0x2e0 kernel/locking/mutex.c:107
 __mutex_trylock kernel/locking/mutex.c:152 [inline]
 __mutex_lock_common+0x1f3/0x2530 kernel/locking/mutex.c:606
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256
 btrfs_evict_inode+0x72e/0x1010 fs/btrfs/inode.c:5333
 evict+0x2a4/0x620 fs/inode.c:665
 __btrfs_run_defrag_inode fs/btrfs/defrag.c:282 [inline]
 btrfs_run_defrag_inodes+0xa90/0xe20 fs/btrfs/defrag.c:328
 cleaner_kthread+0x287/0x3c0 fs/btrfs/disk-io.c:1733
 kthread+0x2b8/0x350 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 10:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 slab_alloc_node mm/slub.c:3451 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x11f/0x2e0 mm/slub.c:3475
 kmem_cache_zalloc include/linux/slab.h:670 [inline]
 btrfs_get_or_create_delayed_node+0xbd/0x470 fs/btrfs/delayed-inode.c:129
 btrfs_delayed_update_inode+0x28/0x4b0 fs/btrfs/delayed-inode.c:1887
 btrfs_update_inode+0x16a/0x360 fs/btrfs/inode.c:4047
 btrfs_update_inode_fallback fs/btrfs/inode.c:4061 [inline]
 btrfs_finish_ordered_io+0x10ae/0x1cc0 fs/btrfs/inode.c:3201
 btrfs_work_helper+0x380/0xbe0 fs/btrfs/async-thread.c:280
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2405
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2552
 kthread+0x2b8/0x350 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Freed by task 7174:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3786 [inline]
 kmem_cache_free+0x297/0x520 mm/slub.c:3808
 btrfs_evict_inode+0x72e/0x1010 fs/btrfs/inode.c:5333
 evict+0x2a4/0x620 fs/inode.c:665
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x5f8/0x690 fs/inode.c:748
 generic_shutdown_super+0x98/0x340 fs/super.c:479
 kill_anon_super+0x3b/0x60 fs/super.c:1107
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2134
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888023d467c0
 which belongs to the cache btrfs_delayed_node of size 432
The buggy address is located 88 bytes inside of
 freed 432-byte region [ffff888023d467c0, ffff888023d46970)

The buggy address belongs to the physical page:
page:ffffea00008f5180 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888023d46f80 pfn:0x23d46
head:ffffea00008f5180 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff88802a0fec80 dead000000000122 0000000000000000
raw: ffff888023d46f80 0000000080100009 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5469, tgid 5464 (syz-executor.2), ts 242695061887, free_ts 242280344120
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x1b9/0x2e0 mm/slub.c:3475
 kmem_cache_zalloc include/linux/slab.h:670 [inline]
 btrfs_get_or_create_delayed_node+0xbd/0x470 fs/btrfs/delayed-inode.c:129
 btrfs_insert_delayed_dir_index+0xa3/0xca0 fs/btrfs/delayed-inode.c:1432
 btrfs_insert_dir_item+0x47d/0x630 fs/btrfs/dir-item.c:166
 btrfs_add_link+0x287/0xc60 fs/btrfs/inode.c:6422
 btrfs_create_new_inode+0x1a57/0x27f0 fs/btrfs/inode.c:6363
 btrfs_create_common+0x1f9/0x300 fs/btrfs/inode.c:6498
 lookup_open fs/namei.c:3492 [inline]
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3788
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2659
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 slab_alloc_node mm/slub.c:3451 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc_lru+0x11f/0x2e0 mm/slub.c:3482
 alloc_inode_sb include/linux/fs.h:2705 [inline]
 alloc_inode fs/inode.c:262 [inline]
 new_inode_pseudo+0x85/0x1d0 fs/inode.c:1018
 get_pipe_inode fs/pipe.c:873 [inline]
 create_pipe_files+0x50/0x700 fs/pipe.c:913
 __do_pipe_flags+0x46/0x200 fs/pipe.c:962
 do_pipe2+0xd4/0x310 fs/pipe.c:1010
 __do_sys_pipe2 fs/pipe.c:1028 [inline]
 __se_sys_pipe2 fs/pipe.c:1026 [inline]
 __x64_sys_pipe2+0x5a/0x70 fs/pipe.c:1026
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888023d46700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888023d46780: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888023d46800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888023d46880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888023d46900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
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
