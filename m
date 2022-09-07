Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28555B000B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 11:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIGJLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 05:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiIGJLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:11:30 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B88CA6AF0
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 02:11:26 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id c2-20020a6bec02000000b00689b26e92f0so8605220ioh.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Sep 2022 02:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=96oduF8kJl33Cv0ZIooHJCpu/gbgxvziNk1Od0BxYOc=;
        b=b4U5pzwt7LgnIeRIsewoVOof8d41HAHrxzw3TE/R0xh3SXuz6vQMWtiT0xNcvN71L6
         JSkiYbYYqWb9X37tKBgIrBKvCIgBETDiaOIC3WMFuN3L11CWfIxOOouQQChZ0XXbgm2p
         oZSAGFqKxZoKFYPh+PN4jiad7iQJE4KQOrRNdnyqtgFsyomAbUFnBuhlTyjIxLQD3OYb
         QGmp0Yg4Fxg0GRZyVAvZxqw+pmIAqhU0h8Fe51s0LTbO4292pwktyDgFD/GNMilm54I+
         Gw0FNNXlHVojdh07R1Ci3zEgl3Vph7L+vDauOfzsgeEs3zxPWcPSm2nxqwG++OsYOsGd
         xFaQ==
X-Gm-Message-State: ACgBeo0sJoiONfrMk3Pbg3KpxAJ9pQusnXNvyU5r/ekn5Cr8eKlZ/pTw
        WjgmbJlKsdqUMII2wjzFc8Kn6+rEzCPYdXl9X8tYMn4goSYd
X-Google-Smtp-Source: AA6agR4fD+IsphVja3NQGMW15j08WLql6AJ7IxkvZIajtzTkSPW21veXQ1GLEdeHKt+4n6fmlJpk8b473eZI/rhT0VN/Ks7/n1Ls
MIME-Version: 1.0
X-Received: by 2002:a5e:a70f:0:b0:684:d596:b7e7 with SMTP id
 b15-20020a5ea70f000000b00684d596b7e7mr1236974iod.84.1662541885890; Wed, 07
 Sep 2022 02:11:25 -0700 (PDT)
Date:   Wed, 07 Sep 2022 02:11:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008866ad05e812b2f5@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in fuse_inode_eq (2)
From:   syzbot <syzbot+938055fcae46a26e5239@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    e47eb90a0a9a Add linux-next specific files for 20220901
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=138d5455080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7933882276523081
dashboard link: https://syzkaller.appspot.com/bug?extid=938055fcae46a26e5239
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+938055fcae46a26e5239@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in get_node_id fs/fuse/fuse_i.h:887 [inline]
BUG: KASAN: slab-out-of-bounds in fuse_inode_eq+0x75/0x80 fs/fuse/inode.c:341
Read of size 8 at addr ffff888051c95930 by task syz-executor.3/10946

CPU: 0 PID: 10946 Comm: syz-executor.3 Not tainted 6.0.0-rc3-next-20220901-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 get_node_id fs/fuse/fuse_i.h:887 [inline]
 fuse_inode_eq+0x75/0x80 fs/fuse/inode.c:341
 find_inode+0xe4/0x220 fs/inode.c:917
 ilookup5_nowait fs/inode.c:1430 [inline]
 ilookup5 fs/inode.c:1459 [inline]
 iget5_locked+0xb1/0x2c0 fs/inode.c:1240
 fuse_iget+0x1cc/0x6b0 fs/fuse/inode.c:382
 fuse_lookup_name+0x447/0x630 fs/fuse/dir.c:403
 fuse_lookup.part.0+0xdf/0x390 fs/fuse/dir.c:433
 fuse_lookup fs/fuse/dir.c:429 [inline]
 fuse_atomic_open+0x2d5/0x440 fs/fuse/dir.c:662
 atomic_open fs/namei.c:3276 [inline]
 lookup_open.isra.0+0xb8a/0x12a0 fs/namei.c:3384
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x996/0x28f0 fs/namei.c:3688
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1308
 do_sys_open fs/open.c:1324 [inline]
 __do_sys_openat fs/open.c:1340 [inline]
 __se_sys_openat fs/open.c:1335 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1335
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1c79689279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1c78dff168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f1c7979c050 RCX: 00007f1c79689279
RDX: 0000000000000000 RSI: 00000000200020c0 RDI: ffffffffffffff9c
RBP: 00007f1c796e32e9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc999facef R14: 00007f1c78dff300 R15: 0000000000022000
 </TASK>

Allocated by task 29165:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3317 [inline]
 slab_alloc mm/slub.c:3325 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3332 [inline]
 kmem_cache_alloc_lru+0x255/0x730 mm/slub.c:3348
 alloc_inode_sb include/linux/fs.h:3104 [inline]
 nilfs_alloc_inode+0x24/0x150 fs/nilfs2/super.c:154
 alloc_inode+0x61/0x230 fs/inode.c:261
 iget5_locked fs/inode.c:1243 [inline]
 iget5_locked+0x1cb/0x2c0 fs/inode.c:1236
 nilfs_iget_locked+0xa0/0xd0 fs/nilfs2/inode.c:588
 nilfs_ifile_read+0x2c/0x1a0 fs/nilfs2/ifile.c:187
 nilfs_attach_checkpoint+0x258/0x4b0 fs/nilfs2/super.c:541
 nilfs_fill_super fs/nilfs2/super.c:1064 [inline]
 nilfs_mount+0xb12/0xfb0 fs/nilfs2/super.c:1317
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888051c95348
 which belongs to the cache nilfs2_inode_cache of size 1512
The buggy address is located 0 bytes to the right of
 1512-byte region [ffff888051c95348, ffff888051c95930)

The buggy address belongs to the physical page:
page:ffffea0001472400 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888051c90000 pfn:0x51c90
head:ffffea0001472400 order:3 compound_mapcount:0 compound_pincount:0
memcg:ffff888078d1b801
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888146e09dc0
raw: ffff888051c90000 000000008013000c 00000001ffffffff ffff888078d1b801
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 29150, tgid 29149 (syz-executor.3), ts 1182464121975, free_ts 1152885638731
 prep_new_page mm/page_alloc.c:2534 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4284
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5542
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1721 [inline]
 allocate_slab+0x228/0x370 mm/slub.c:1866
 new_slab mm/slub.c:1919 [inline]
 ___slab_alloc+0xad0/0x1440 mm/slub.c:3100
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3198
 slab_alloc_node mm/slub.c:3283 [inline]
 slab_alloc mm/slub.c:3325 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3332 [inline]
 kmem_cache_alloc_lru+0x4aa/0x730 mm/slub.c:3348
 alloc_inode_sb include/linux/fs.h:3104 [inline]
 nilfs_alloc_inode+0x24/0x150 fs/nilfs2/super.c:154
 alloc_inode+0x61/0x230 fs/inode.c:261
 iget5_locked fs/inode.c:1243 [inline]
 iget5_locked+0x1cb/0x2c0 fs/inode.c:1236
 nilfs_iget_locked+0xa0/0xd0 fs/nilfs2/inode.c:588
 nilfs_dat_read+0x84/0x360 fs/nilfs2/dat.c:483
 nilfs_load_super_root fs/nilfs2/the_nilfs.c:120 [inline]
 load_nilfs+0x368/0x1330 fs/nilfs2/the_nilfs.c:269
 nilfs_fill_super fs/nilfs2/super.c:1059 [inline]
 nilfs_mount+0xa9a/0xfb0 fs/nilfs2/super.c:1317
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3382 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3478
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2514
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3317 [inline]
 slab_alloc mm/slub.c:3325 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3332 [inline]
 kmem_cache_alloc+0x2b7/0x3d0 mm/slub.c:3341
 vm_area_alloc+0x1c/0xf0 kernel/fork.c:458
 mmap_region+0x448/0x1bf0 mm/mmap.c:2604
 do_mmap+0x825/0xf50 mm/mmap.c:1411
 vm_mmap_pgoff+0x1ab/0x270 mm/util.c:520
 ksys_mmap_pgoff+0x79/0x5a0 mm/mmap.c:1457
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888051c95800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888051c95880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888051c95900: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
                                     ^
 ffff888051c95980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888051c95a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
