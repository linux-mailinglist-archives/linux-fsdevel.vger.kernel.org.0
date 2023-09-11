Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FC979C35E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 04:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbjILCzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 22:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbjILCzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:55:45 -0400
Received: from mail-pj1-x1050.google.com (mail-pj1-x1050.google.com [IPv6:2607:f8b0:4864:20::1050])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B31224D9
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 16:36:26 -0700 (PDT)
Received: by mail-pj1-x1050.google.com with SMTP id 98e67ed59e1d1-26ecc4795a4so6319964a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 16:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474999; x=1695079799;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLNqe0waU0vWs6WPgQQQfHWM0cAFJrnUfdwq9iT01aw=;
        b=ajQi8izJeR1xzMF7BtM2oqooDFYQi5e4ulrAGgna69eRdQg+rbwAOz7HkiaXGqn0Ek
         nSXux/vUmSW/wyte1//AyAfeP7w5u6lx0FxNyYnNplQ2LgIGIlqd2AtcoPSbxQJzXDrH
         cT7ojwe+ogJFZm0cmu7JEZrS0bBVMkzOxoXD+bhnGyfUS5Uo/2dBkAusIo1MFvU8jQQa
         TDDqgqsYIBcTlmGxhrmR7Ig3hy69eLvT7x3nrQkw+zNjm7+rFq4NRwj7iPRi1ccoCtr2
         J2wClRIXZmFx2D5ls7zaDEQPJvXDtuGvaJGWlebODuayB9VTnvWo5KXNftt+n32524GM
         k9rg==
X-Gm-Message-State: AOJu0YzVG9ktJGrlOXLinPVMZUiVyVjpsroSdvnyyF/s+jKnVdBkCv/z
        AT98NThsjrdb4MM683wVIuW/G3em+jQ4RDeSIt9U6qeVrHky
X-Google-Smtp-Source: AGHT+IFs1yrquwoHqfPZkpXHNGT+N/Migq2QN9BSa8CWZDf0+l+v+7weWgR6gLRv0Phkhw6svkF187lCi8wo/7A2IjNId5bUtybg
MIME-Version: 1.0
X-Received: by 2002:a17:90b:100a:b0:268:776:e26 with SMTP id
 gm10-20020a17090b100a00b0026807760e26mr2939684pjb.5.1694474999131; Mon, 11
 Sep 2023 16:29:59 -0700 (PDT)
Date:   Mon, 11 Sep 2023 16:29:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006777d506051db4fd@google.com>
Subject: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in ntfs_write_bh
From:   syzbot <syzbot+bc79f8d1898960d41073@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0bb80ecc33a8 Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d3b308680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=bc79f8d1898960d41073
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d506cf29d25/disk-0bb80ecc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca5b56af4b3e/vmlinux-0bb80ecc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa88aed611c1/bzImage-0bb80ecc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc79f8d1898960d41073@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ntfs_write_bh+0x49/0x7b0 fs/ntfs3/fsntfs.c:1401
Read of size 8 at addr ffff88807c08a000 by task syz-executor.0/29687

CPU: 1 PID: 29687 Comm: syz-executor.0 Not tainted 6.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 ntfs_write_bh+0x49/0x7b0 fs/ntfs3/fsntfs.c:1401
 mi_write+0x9b/0x200 fs/ntfs3/record.c:346
 ni_write_inode+0x619/0x1080 fs/ntfs3/frecord.c:3360
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0x69b/0xfa0 fs/fs-writeback.c:1668
 writeback_single_inode+0x21b/0x790 fs/fs-writeback.c:1724
 sync_inode_metadata+0xcc/0x130 fs/fs-writeback.c:2786
 ntfs_set_state+0x556/0x730 fs/ntfs3/fsntfs.c:995
 ntfs_create_inode+0x502/0x3b00 fs/ntfs3/inode.c:1307
 ntfs_atomic_open+0x423/0x570 fs/ntfs3/namei.c:422
 atomic_open fs/namei.c:3358 [inline]
 lookup_open fs/namei.c:3466 [inline]
 open_last_lookups fs/namei.c:3563 [inline]
 path_openat+0x1044/0x3180 fs/namei.c:3793
 do_filp_open+0x234/0x490 fs/namei.c:3823
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4ee967cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4eea3170c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f4ee979bf80 RCX: 00007f4ee967cae9
RDX: 000000000000275a RSI: 0000000020000040 RDI: ffffffffffffff9c
RBP: 00007f4ee96c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0b00000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4ee979bf80 R15: 00007ffda859bad8
 </TASK>

Allocated by task 5123:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1023 [inline]
 __kmalloc_node_track_caller+0xb6/0x230 mm/slab_common.c:1043
 kmalloc_reserve+0xf3/0x260 net/core/skbuff.c:581
 __alloc_skb+0x1b1/0x420 net/core/skbuff.c:650
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x250/0xa90 drivers/net/netdevsim/dev.c:850
 process_one_work+0x781/0x1130 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0xabf/0x1060 kernel/workqueue.c:2784
 kthread+0x2b8/0x350 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Freed by task 5123:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3822
 skb_kfree_head net/core/skbuff.c:945 [inline]
 skb_free_head net/core/skbuff.c:957 [inline]
 skb_release_data+0x660/0x850 net/core/skbuff.c:987
 skb_release_all net/core/skbuff.c:1053 [inline]
 __kfree_skb net/core/skbuff.c:1067 [inline]
 consume_skb+0xb3/0x150 net/core/skbuff.c:1283
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
 nsim_dev_trap_report_work+0x761/0xa90 drivers/net/netdevsim/dev.c:850
 process_one_work+0x781/0x1130 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0xabf/0x1060 kernel/workqueue.c:2784
 kthread+0x2b8/0x350 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff88807c08a000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes inside of
 freed 4096-byte region [ffff88807c08a000, ffff88807c08b000)

The buggy address belongs to the physical page:
page:ffffea0001f02200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c088
head:ffffea0001f02200 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012842140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4483, tgid 4483 (udevd), ts 395872759792, free_ts 395835757815
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xade/0x1100 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x254/0x4e0 security/tomoyo/file.c:771
 security_file_open+0x63/0xa0 security/security.c:2836
 do_dentry_open+0x325/0x1430 fs/open.c:916
 do_open fs/namei.c:3639 [inline]
 path_openat+0x27bb/0x3180 fs/namei.c:3796
 do_filp_open+0x234/0x490 fs/namei.c:3823
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1448
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 discard_slab mm/slub.c:2116 [inline]
 __unfreeze_partials+0x1dc/0x220 mm/slub.c:2655
 put_cpu_partial+0x116/0x180 mm/slub.c:2731
 __slab_free+0x2b6/0x390 mm/slub.c:3679
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x6c/0x3b0 mm/slab.h:762
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x123/0x300 mm/slub.c:3502
 getname_flags+0xbc/0x4e0 fs/namei.c:140
 user_path_at_empty+0x2e/0x180 fs/namei.c:2909
 do_readlinkat+0x118/0x3b0 fs/stat.c:533
 __do_sys_readlink fs/stat.c:566 [inline]
 __se_sys_readlink fs/stat.c:563 [inline]
 __x64_sys_readlink+0x7f/0x90 fs/stat.c:563
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807c089f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807c089f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807c08a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807c08a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c08a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
