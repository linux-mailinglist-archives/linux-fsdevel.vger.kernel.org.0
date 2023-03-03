Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0877E6A9076
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 06:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCCFdz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 3 Mar 2023 00:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCCFdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:33:54 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8AAA27E
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 21:33:52 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id 207-20020a6b14d8000000b0074ca9a558feso772547iou.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 21:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Piu1Yu9jLUO178Oc6jIQS7nC++mrqsytvUME2W0QH2I=;
        b=dhIiZafmKk7Pcmuhcu58MDOXLm2u9AidNbLhLDqFMGGO8e4yy7XOYDVzNYHtss2YHk
         PLFI92MUfOOENGPLSwatmSA3WpbyTevUKw1hbFSrXM7TPyP1cb16Oc7mLcf6TB794OC1
         PO9x1d+47wlAo2EWxY2jCePNvlGqJmiziniU03bE9Nnie0T4as6J2vd4XaCfSXvxSrVX
         TQOBFZ5fJOP17xK/tRVy/WtFcrXZI17ZMIHVNAk9+oEjqfg2PecjKr+JjI/f4uBUHdFh
         xXQSHKa4GVjplb2wTmM+nyovqraGhxS0eczkgt1hlb/f11G6UH6d47e/98WxmLh5JTFv
         U2HA==
X-Gm-Message-State: AO0yUKXHRO6eypLsoSDXnRsaaNV3ddBfQOtUag0ZF4L+UE8jkF9RXL0G
        OxSKFw6Eg+BLsqKmlPSGdolZJJG63jGAdyGA2Zk2WFFpJzCi
X-Google-Smtp-Source: AK7set8nxYu/1UlH35t+WyzfTCMIUNS8P6SS3HiK3kDo/ld/2R2HH9RUKY62L1mwA2BZA+NMhkeTVvS94d0WQrDV/0zKVCtn33D1
MIME-Version: 1.0
X-Received: by 2002:a6b:670c:0:b0:74c:a82e:eed1 with SMTP id
 b12-20020a6b670c000000b0074ca82eeed1mr2306101ioc.0.1677821632015; Thu, 02 Mar
 2023 21:33:52 -0800 (PST)
Date:   Thu, 02 Mar 2023 21:33:52 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f781e05f5f84a94@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in __dquot_initialize
From:   syzbot <syzbot+e365f9547b2452e771c6@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    04a357b1f6f0 Merge tag 'mips_6.3_1' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b4bdb0c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=e365f9547b2452e771c6
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e9f8326ebe2/disk-04a357b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/138ae11c9b96/vmlinux-04a357b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d0594947835d/bzImage-04a357b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e365f9547b2452e771c6@syzkaller.appspotmail.com

EXT4-fs (loop3): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: writeback.
ext4 filesystem being mounted at /root/syzkaller-testdir612288279/syzkaller.HN2LiR/1251/file0 supports timestamps until 2038 (0x7fffffff)
==================================================================
BUG: KASAN: slab-use-after-free in __dquot_initialize+0x214/0xe20 fs/quota/dquot.c:1470
Read of size 8 at addr ffff88803b89a2c8 by task syz-executor.3/374

CPU: 1 PID: 374 Comm: syz-executor.3 Not tainted 6.2.0-syzkaller-13163-g04a357b1f6f0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x143/0x170 mm/kasan/report.c:536
 __dquot_initialize+0x214/0xe20 fs/quota/dquot.c:1470
 reiserfs_setattr+0x33c/0x1140 fs/reiserfs/inode.c:3280
 notify_change+0xc8b/0xf40 fs/attr.c:482
 chown_common+0x500/0x850 fs/open.c:774
 do_fchownat+0x16d/0x240 fs/open.c:805
 __do_sys_lchown fs/open.c:830 [inline]
 __se_sys_lchown fs/open.c:828 [inline]
 __x64_sys_lchown+0x85/0x90 fs/open.c:828
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5098a8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50997e8168 EFLAGS: 00000246 ORIG_RAX: 000000000000005e
RAX: ffffffffffffffda RBX: 00007f5098babf80 RCX: 00007f5098a8c0f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000340
RBP: 00007f5098ae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd89efa7ef R14: 00007f50997e8300 R15: 0000000000022000
 </TASK>

Allocated by task 30088:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:769
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x127/0x270 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:2686 [inline]
 reiserfs_alloc_inode+0x2a/0xc0 fs/reiserfs/super.c:642
 alloc_inode fs/inode.c:260 [inline]
 new_inode_pseudo+0x65/0x1d0 fs/inode.c:1019
 new_inode+0x29/0x1d0 fs/inode.c:1047
 reiserfs_mkdir+0x1c0/0x8f0 fs/reiserfs/namei.c:815
 xattr_mkdir fs/reiserfs/xattr.c:76 [inline]
 create_privroot fs/reiserfs/xattr.c:882 [inline]
 reiserfs_xattr_init+0x34c/0x730 fs/reiserfs/xattr.c:1005
 reiserfs_fill_super+0x2207/0x2620 fs/reiserfs/super.c:2175
 mount_bdev+0x271/0x3a0 fs/super.c:1371
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1501
 do_new_mount+0x28f/0xae0 fs/namespace.c:3042
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:491
 __call_rcu_common kernel/rcu/tree.c:2622 [inline]
 call_rcu+0x167/0xac0 kernel/rcu/tree.c:2736
 reiserfs_new_inode+0x7c1/0x1da0 fs/reiserfs/inode.c:2156
 reiserfs_mkdir+0x5b0/0x8f0 fs/reiserfs/namei.c:845
 xattr_mkdir fs/reiserfs/xattr.c:76 [inline]
 create_privroot fs/reiserfs/xattr.c:882 [inline]
 reiserfs_xattr_init+0x34c/0x730 fs/reiserfs/xattr.c:1005
 reiserfs_fill_super+0x2207/0x2620 fs/reiserfs/super.c:2175
 mount_bdev+0x271/0x3a0 fs/super.c:1371
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1501
 do_new_mount+0x28f/0xae0 fs/namespace.c:3042
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88803b89a120
 which belongs to the cache reiser_inode_cache of size 1568
The buggy address is located 424 bytes inside of
 freed 1568-byte region [ffff88803b89a120, ffff88803b89a740)

The buggy address belongs to the physical page:
page:ffffea0000ee2600 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88803b8986a0 pfn:0x3b898
head:ffffea0000ee2600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88801de87901
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888017fdeb40 dead000000000122 0000000000000000
raw: ffff88803b8986a0 0000000080130012 00000001ffffffff ffff88801de87901
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 29976, tgid 29973 (syz-executor.0), ts 902319248816, free_ts 900804093094
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x37e0/0x3970 mm/page_alloc.c:4325
 __alloc_pages+0x291/0x7f0 mm/page_alloc.c:5591
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x1ad/0x270 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:2686 [inline]
 reiserfs_alloc_inode+0x2a/0xc0 fs/reiserfs/super.c:642
 alloc_inode fs/inode.c:260 [inline]
 iget5_locked+0xa0/0x270 fs/inode.c:1242
 reiserfs_fill_super+0x12e4/0x2620 fs/reiserfs/super.c:2053
 mount_bdev+0x271/0x3a0 fs/super.c:1371
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1501
 do_new_mount+0x28f/0xae0 fs/namespace.c:3042
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare mm/page_alloc.c:1503 [inline]
 free_unref_page_prepare+0xf0e/0xf70 mm/page_alloc.c:3387
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:3482
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x15a/0x170 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:769
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x12c/0x280 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 seq_open+0x62/0x140 fs/seq_file.c:63
 kernfs_fop_open+0x602/0xcc0
 do_dentry_open+0x7f9/0x10f0 fs/open.c:920
 do_open fs/namei.c:3560 [inline]
 path_openat+0x27b3/0x3170 fs/namei.c:3715
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_openat fs/open.c:1380 [inline]
 __se_sys_openat fs/open.c:1375 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1375
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88803b89a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803b89a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803b89a280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88803b89a300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803b89a380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
