Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A36F52AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 10:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjECIGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 04:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjECIGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 04:06:47 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CE14C22
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 01:06:15 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-76998d984b0so140592439f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 01:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683101090; x=1685693090;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZYvpj+DpkXfL/hfrzzciWQpe3C04IENNzmwaX3mfQI=;
        b=T5dU+PUZn68HxJv6Bz/y6WPGRIG7Rp8gTKLj3S9769yvK+m5FpMSklrTG8T9ewpmfT
         wmDOVVB+5maQMDlUfE0caAQF9gRdT4/jWRoGeIBbUNa8DoMofs9drj8H2Ucbg3moaTH2
         MD9FcRDgxCK7G7L0d0EX3Wg3KGxBB4KUsIswbfcrME1vam5Vc7EfpFAYp52tJwAlHDwG
         Vtuwfrc4hQN2Tn1xj6NcuYf5Ls4Owww8zPvrqCCWVdJWQVKdEBMkFGg07XowjuqDPRtZ
         YLt5ybLVpIFwXnXKKBP0FN8PuTRJCXFhQLPeOOE7G6amvSd/35jS3DqG4pvD/Nd8wOkz
         EqRQ==
X-Gm-Message-State: AC+VfDyR/Cf+fz+961MN07ljibag3cDhizjZwfw+upGafCWueBuSq8TD
        LZPsQKVO7wD83Kr78q0q46R3pJQOXTstiJUzdtDNhn/mGc1tfMEFBA==
X-Google-Smtp-Source: ACHHUZ6a6XZr6ZDE+zKtZBduWApFqx8NZbU9SRZlMUNpo6BPSzZoErFYyEmbwm99zQaPqzp6Aw1WOVq2Z4LErHBqLLV7fcEZCF3X
MIME-Version: 1.0
X-Received: by 2002:a6b:ed0f:0:b0:760:9d4c:814 with SMTP id
 n15-20020a6bed0f000000b007609d4c0814mr9698366iog.4.1683101090746; Wed, 03 May
 2023 01:04:50 -0700 (PDT)
Date:   Wed, 03 May 2023 01:04:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2a1e105fac5829e@google.com>
Subject: [syzbot] [hfs?] KASAN: slab-use-after-free Read in hfsplus_bnode_put
From:   syzbot <syzbot+a090513c7f9270b11245@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    22b8cc3e78f5 Merge tag 'x86_mm_for_6.4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b4cda4280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=928de0fc91f6ded8
dashboard link: https://syzkaller.appspot.com/bug?extid=a090513c7f9270b11245
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2b80fd711869/disk-22b8cc3e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5aa32673c503/vmlinux-22b8cc3e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/381e275c15f9/bzImage-22b8cc3e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a090513c7f9270b11245@syzkaller.appspotmail.com

hfsplus: inconsistency in B*Tree (1,0,1,0,2)
hfsplus: xattr searching failed
hfsplus: inconsistency in B*Tree (1,0,1,0,2)
==================================================================
BUG: KASAN: slab-use-after-free in hfsplus_bnode_put+0x48/0x6d0 fs/hfsplus/bnode.c:612
Read of size 8 at addr ffff8880173da100 by task syz-executor.3/8306

CPU: 1 PID: 8306 Comm: syz-executor.3 Not tainted 6.3.0-syzkaller-10656-g22b8cc3e78f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 hfsplus_bnode_put+0x48/0x6d0 fs/hfsplus/bnode.c:612
 hfsplus_brec_find+0x421/0x570 fs/hfsplus/bfind.c:214
 __hfsplus_getxattr+0x364/0xb10 fs/hfsplus/xattr.c:522
 hfsplus_getxattr+0x9c/0xd0 fs/hfsplus/xattr.c:590
 __vfs_getxattr+0x436/0x470 fs/xattr.c:424
 smk_fetch+0xb1/0x140 security/smack/smack_lsm.c:295
 smack_d_instantiate+0x868/0xb40 security/smack/smack_lsm.c:3512
 security_d_instantiate+0x9b/0xf0 security/security.c:3760
 d_instantiate+0x55/0x90 fs/dcache.c:2034
 hfsplus_instantiate fs/hfsplus/dir.c:26 [inline]
 hfsplus_mknod+0x250/0x2a0 fs/hfsplus/dir.c:507
 lookup_open fs/namei.c:3416 [inline]
 open_last_lookups fs/namei.c:3484 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3712
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0fa6c8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0fa7a08168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f0fa6dabf80 RCX: 00007f0fa6c8c169
RDX: 000000000000275a RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 00007f0fa6ce7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe31f70cef R14: 00007f0fa7a08300 R15: 0000000000022000
 </TASK>

Allocated by task 5392:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 __hfs_bnode_create+0xf8/0x770 fs/hfsplus/bnode.c:409
 hfsplus_bnode_find+0x237/0x10c0 fs/hfsplus/bnode.c:486
 hfsplus_btree_write+0x24/0x4c0 fs/hfsplus/btree.c:289
 hfsplus_system_write_inode fs/hfsplus/super.c:136 [inline]
 hfsplus_write_inode+0x4c0/0x5e0 fs/hfsplus/super.c:162
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0x69b/0xfa0 fs/fs-writeback.c:1668
 writeback_sb_inodes+0x8e3/0x11d0 fs/fs-writeback.c:1894
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:1965
 wb_writeback+0x46c/0xc70 fs/fs-writeback.c:2070
 wb_check_start_all fs/fs-writeback.c:2192 [inline]
 wb_do_writeback fs/fs-writeback.c:2218 [inline]
 wb_workfn+0x98f/0xff0 fs/fs-writeback.c:2251
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x2b8/0x350 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Freed by task 8315:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3786 [inline]
 __kmem_cache_free+0x264/0x3c0 mm/slub.c:3799
 hfsplus_release_folio+0x45d/0x550 fs/hfsplus/inode.c:103
 shrink_folio_list+0x25fa/0x8b80 mm/vmscan.c:2066
 shrink_inactive_list mm/vmscan.c:2592 [inline]
 shrink_list mm/vmscan.c:2833 [inline]
 shrink_lruvec+0x16e6/0x2d30 mm/vmscan.c:6269
 shrink_node_memcgs mm/vmscan.c:6456 [inline]
 shrink_node+0x115c/0x2790 mm/vmscan.c:6491
 shrink_zones mm/vmscan.c:6726 [inline]
 do_try_to_free_pages+0x67e/0x1900 mm/vmscan.c:6788
 try_to_free_mem_cgroup_pages+0x455/0xa50 mm/vmscan.c:7103
 try_charge_memcg+0x5de/0x16d0 mm/memcontrol.c:2724
 try_charge mm/memcontrol.c:2866 [inline]
 mem_cgroup_charge_skmem+0xad/0x2b0 mm/memcontrol.c:7351
 sock_reserve_memory+0x101/0x610 net/core/sock.c:1025
 sk_setsockopt+0xc8e/0x3430 net/core/sock.c:1520
 __sys_setsockopt+0x47b/0x980 net/socket.c:2269
 __do_sys_setsockopt net/socket.c:2284 [inline]
 __se_sys_setsockopt net/socket.c:2281 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2281
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880173da100
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 freed 192-byte region [ffff8880173da100, ffff8880173da1c0)

The buggy address belongs to the physical page:
page:ffffea00005cf680 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880173da600 pfn:0x173da
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888012441a00 ffffea0000af6a00 dead000000000002
raw: ffff8880173da600 000000008010000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 7799, tgid 7792 (syz-executor.3), ts 372538230491, free_ts 372528219086
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1722
 prep_new_page mm/page_alloc.c:1729 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3493
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4759
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_slab_page+0x59/0x160 mm/slub.c:1853
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc_node+0xa7/0x230 mm/slab_common.c:973
 kmalloc_array_node include/linux/slab.h:657 [inline]
 kcalloc_node include/linux/slab.h:662 [inline]
 memcg_alloc_slab_cgroups+0x81/0x120 mm/memcontrol.c:2928
 account_slab mm/slab.h:597 [inline]
 allocate_slab mm/slub.c:2016 [inline]
 new_slab+0xc0/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc_lru+0x1b9/0x2e0 mm/slub.c:3482
 __d_alloc+0x31/0x710 fs/dcache.c:1769
 d_alloc fs/dcache.c:1849 [inline]
 d_alloc_parallel+0xce/0x13a0 fs/dcache.c:2638
 lookup_open fs/namei.c:3341 [inline]
 open_last_lookups fs/namei.c:3484 [inline]
 path_openat+0x90e/0x3170 fs/namei.c:3712
 do_filp_open+0x234/0x490 fs/namei.c:3742
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2555
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2650
 vfree+0x186/0x2e0 mm/vmalloc.c:2798
 copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:882 [inline]
 get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
 do_ip6t_get_ctl+0x11f7/0x18d0 net/ipv6/netfilter/ip6_tables.c:1669
 nf_getsockopt+0x292/0x2c0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x25d/0x380 net/ipv6/ipv6_sockglue.c:1500
 tcp_getsockopt+0x160/0x1c0 net/ipv4/tcp.c:4410
 __sys_getsockopt+0x2b6/0x5e0 net/socket.c:2317
 __do_sys_getsockopt net/socket.c:2332 [inline]
 __se_sys_getsockopt net/socket.c:2329 [inline]
 __x64_sys_getsockopt+0xb5/0xd0 net/socket.c:2329
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff8880173da000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880173da080: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>ffff8880173da100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880173da180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880173da200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
