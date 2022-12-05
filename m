Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB88F642609
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 10:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiLEJrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 04:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiLEJrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:47:48 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0FB65A0
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Dec 2022 01:47:47 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so11707694ila.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Dec 2022 01:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEKKEZGF+jgdIDc8NVBi3tp/tqdDla5lQNVIkx0HBX4=;
        b=PDHo0xdgsmqu2OYw3q4SipFkFN4Fl2PhB04MD5AQcRH6byEAqxAeZF5C2eMFfM0LDq
         yvCLNP9Aw7CmGkobUsz/nYXuPYEcGj0KHebUHm9LhcL1/3kRsyrR2jEqGqw52zlry+ns
         h3h0HgMeoUUzoa4VXDdfpjY7ivbTUOLVVpNyk+uZL5AxNzqROhNpp0sOu0ztp2KxC1JL
         wRsb6mBy4WLqbg/Vror5Dq9OP5P1Uh6QENGIbdiyjb+AQyJXQSAqYwEHqen6uH/0UNv0
         UKksvnSxz38aY4sksUhe4b5n7NGSlwbuybgBGGPg/wsxMBOWYQKsCkzf14YCtnvaQAGa
         ihPA==
X-Gm-Message-State: ANoB5pkvJnl1+dqo4+3tCXVQ0YHUqmRUlEygfoaKkV2bSFI+u5nzJoFV
        FtNgBqWieJacLm7KtDLoI8IM1iEOp5y1W9w35dMHrp+C0pyS
X-Google-Smtp-Source: AA0mqf7xNzka+tLGeTasGH5jvcELtTAyV3P0g8v3mT4BTvojg5BCpo89j/YKPphQeSfFLG++MPhgib2Mjf4rGYYTPWGuzfLjW31N
MIME-Version: 1.0
X-Received: by 2002:a02:cf21:0:b0:38a:2f59:53d7 with SMTP id
 s1-20020a02cf21000000b0038a2f5953d7mr4288843jar.10.1670233666821; Mon, 05 Dec
 2022 01:47:46 -0800 (PST)
Date:   Mon, 05 Dec 2022 01:47:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067270b05ef119467@google.com>
Subject: [syzbot] KASAN: use-after-free Read in hfsplus_btree_open
From:   syzbot <syzbot+8d39c1e195e443de0dfe@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        ira.weiny@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a4412fdd49dc error-injection: Add prompt for function erro..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119c684d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=8d39c1e195e443de0dfe
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bbe66b25958/disk-a4412fdd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6851483ca667/vmlinux-a4412fdd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d5b23cb4616/bzImage-a4412fdd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d39c1e195e443de0dfe@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 1024
==================================================================
BUG: KASAN: use-after-free in hfsplus_btree_open+0x918/0xd00 fs/hfsplus/btree.c:155
Read of size 4 at addr ffff88804402bc74 by task syz-executor.1/6533

CPU: 1 PID: 6533 Comm: syz-executor.1 Not tainted 6.1.0-rc7-syzkaller-00123-ga4412fdd49dc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 hfsplus_btree_open+0x918/0xd00 fs/hfsplus/btree.c:155
 hfsplus_fill_super+0xa7b/0x1b50 fs/hfsplus/super.c:473
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f974568d60a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f974632af88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000000005e7 RCX: 00007f974568d60a
RDX: 0000000020000600 RSI: 0000000020000640 RDI: 00007f974632afe0
RBP: 00007f974632b020 R08: 00007f974632b020 R09: 0000000000a00010
R10: 0000000000a00010 R11: 0000000000000202 R12: 0000000020000600
R13: 0000000020000640 R14: 00007f974632afe0 R15: 0000000020000140
 </TASK>

Allocated by task 4560:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x180/0x2e0 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3125 [inline]
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1366
 alloc_inode fs/inode.c:259 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1286
 f2fs_iget+0x51/0x4bb0 fs/f2fs/inode.c:505
 f2fs_fill_super+0x52c4/0x6c40 fs/f2fs/super.c:4333
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:481
 call_rcu+0x163/0x9c0 kernel/rcu/tree.c:2798
 f2fs_fill_super+0x5669/0x6c40 fs/f2fs/super.c:4516
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88804402b540
 which belongs to the cache f2fs_inode_cache of size 2144
The buggy address is located 1844 bytes inside of
 2144-byte region [ffff88804402b540, ffff88804402bda0)

The buggy address belongs to the physical page:
page:ffffea0001100a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88804402f360 pfn:0x44028
head:ffffea0001100a00 order:3 compound_mapcount:0 compound_pincount:0
memcg:ffff88801df0f201
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff88801ccc23c0
raw: ffff88804402f360 00000000800e0001 00000001ffffffff ffff88801df0f201
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 4517, tgid 4516 (syz-executor.1), ts 148789358194, free_ts 135585079530
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x233/0x2e0 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3125 [inline]
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1366
 alloc_inode fs/inode.c:259 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1286
 f2fs_iget+0x51/0x4bb0 fs/f2fs/inode.c:505
 f2fs_fill_super+0x38b1/0x6c40 fs/f2fs/super.c:4222
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3483
 free_slab mm/slub.c:2031 [inline]
 discard_slab mm/slub.c:2037 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2586
 put_cpu_partial+0x106/0x170 mm/slub.c:2662
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x180/0x2e0 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3125 [inline]
 sock_alloc_inode+0x21/0xc0 net/socket.c:304
 alloc_inode fs/inode.c:259 [inline]
 new_inode_pseudo+0x61/0x1d0 fs/inode.c:1018
 sock_alloc net/socket.c:627 [inline]
 __sock_create+0x12b/0x850 net/socket.c:1479
 sock_create net/socket.c:1566 [inline]
 __sys_socket_create net/socket.c:1603 [inline]
 __sys_socket+0x119/0x360 net/socket.c:1636
 __do_sys_socket net/socket.c:1649 [inline]
 __se_sys_socket net/socket.c:1647 [inline]
 __x64_sys_socket+0x76/0x80 net/socket.c:1647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88804402bb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804402bb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88804402bc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88804402bc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804402bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
