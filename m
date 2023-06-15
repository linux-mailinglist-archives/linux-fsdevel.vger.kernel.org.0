Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAED731088
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbjFOH1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244645AbjFOH1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:27:51 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA412119
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 00:27:47 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77b25d256aaso305991539f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 00:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686814067; x=1689406067;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xAv63TK6+H8amkIBOVsEgbBnijtiwu/OiHnNubY28M0=;
        b=VHxBtlfceDnAolATnul9A98jTWxJsbkr/mHFe9ip5SSkeqBS6vyXVGsQX91Aim5UV+
         eqv/WrXTsvrxRI28XUp/oXzgDLWfBJeoOt9R23YX+BzezEvJCGSHpEO6hI79vtus5FIO
         4lMw7/fTb/aR1htvO1Xsvxzvc/NvaXD/gkjXWsm3OKp5ArZ3nb0Sd9rY4t9Api6z9oh1
         /qQWgKGSTpkzT3OSdZkNIoOxfAMznArrP4jdF1oX05UQizkD4ZkegHfjP6G/mmTvZP4W
         5CGK0PYWeaY5c0FDx5Xwg2OpKes5dELvBOxyyIXdJ5OnQDEogj7L8TepuNQ1kgoDW0sQ
         OqEQ==
X-Gm-Message-State: AC+VfDygD0bUidVn7SpRjIexZZ9nNhDzsvjMF+8Quhs3zbeVVSs3+Jsx
        OuA0P3+IBrAx8MoXCF8u+Gsufiqm8937Em5IavmFnHQcN0YK
X-Google-Smtp-Source: ACHHUZ5sb7GjIFSuDe3CEciOQwdJcLFlQlLG869WUQS3uNV0+5NXdk8XX2TAaburY3p6s9bHWn+LvjgWJoZNf4M0BVAeeV4lj0Bq
MIME-Version: 1.0
X-Received: by 2002:a02:b0ce:0:b0:423:ea8:4271 with SMTP id
 w14-20020a02b0ce000000b004230ea84271mr806622jah.6.1686814067268; Thu, 15 Jun
 2023 00:27:47 -0700 (PDT)
Date:   Thu, 15 Jun 2023 00:27:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048228805fe260165@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-use-after-free Read in check_igot_inode
From:   syzbot <syzbot+741810aea4ac24243b2f@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    022ce8862dff Merge tag 'i2c-for-6.4-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b1e263280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=741810aea4ac24243b2f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-022ce886.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dec1ef12175c/vmlinux-022ce886.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9c8021b7538/bzImage-022ce886.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+741810aea4ac24243b2f@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 512
EXT4-fs (loop1): encrypted files will use data=ordered instead of data journaling mode
==================================================================
BUG: KASAN: slab-use-after-free in check_igot_inode+0x196/0x1c0 fs/ext4/inode.c:4648
Read of size 8 at addr ffff88805f1b0c70 by task syz-executor.1/16946

CPU: 2 PID: 16946 Comm: syz-executor.1 Not tainted 6.4.0-rc5-syzkaller-00305-g022ce8862dff #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 check_igot_inode+0x196/0x1c0 fs/ext4/inode.c:4648
 __ext4_iget+0x1598/0x4460 fs/ext4/inode.c:4700
 __ext4_fill_super fs/ext4/super.c:5446 [inline]
 ext4_fill_super+0x680f/0xafa0 fs/ext4/super.c:5672
 get_tree_bdev+0x44a/0x770 fs/super.c:1303
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __ia32_sys_mount+0x282/0x300 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f26579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f21410 EFLAGS: 00000296 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f7f21480 RCX: 0000000020000000
RDX: 0000000020000040 RSI: 000000000000000e RDI: 00000000f7f214c0
RBP: 00000000f7f214c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5890:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slub.c:3451 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc_lru+0x20a/0x600 mm/slub.c:3482
 alloc_inode_sb include/linux/fs.h:2705 [inline]
 reiserfs_alloc_inode+0x28/0xc0 fs/reiserfs/super.c:642
 alloc_inode+0x61/0x230 fs/inode.c:260
 new_inode_pseudo fs/inode.c:1018 [inline]
 new_inode+0x2b/0x280 fs/inode.c:1046
 reiserfs_mkdir+0x1f1/0x990 fs/reiserfs/namei.c:813
 xattr_mkdir fs/reiserfs/xattr.c:77 [inline]
 create_privroot fs/reiserfs/xattr.c:890 [inline]
 reiserfs_xattr_init+0x57e/0xbc0 fs/reiserfs/xattr.c:1006
 reiserfs_fill_super+0x2129/0x2eb0 fs/reiserfs/super.c:2175
 mount_bdev+0x358/0x420 fs/super.c:1380
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __ia32_sys_mount+0x282/0x300 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2627
 destroy_inode+0x129/0x1b0 fs/inode.c:315
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x50a/0x740 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 reiserfs_new_inode+0x402/0x2110 fs/reiserfs/inode.c:2154
 reiserfs_mkdir+0x4b8/0x990 fs/reiserfs/namei.c:843
 xattr_mkdir fs/reiserfs/xattr.c:77 [inline]
 create_privroot fs/reiserfs/xattr.c:890 [inline]
 reiserfs_xattr_init+0x57e/0xbc0 fs/reiserfs/xattr.c:1006
 reiserfs_fill_super+0x2129/0x2eb0 fs/reiserfs/super.c:2175
 mount_bdev+0x358/0x420 fs/super.c:1380
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __ia32_sys_mount+0x282/0x300 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

The buggy address belongs to the object at ffff88805f1b06a0
 which belongs to the cache reiser_inode_cache of size 1568
The buggy address is located 1488 bytes inside of
 freed 1568-byte region [ffff88805f1b06a0, ffff88805f1b0cc0)

The buggy address belongs to the physical page:
page:ffffea00017c6c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88805f1b13e0 pfn:0x5f1b0
head:ffffea00017c6c00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888042f00c01
flags: 0x4fff00000010200(slab|head|node=1|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 04fff00000010200 ffff888042d81040 dead000000000122 0000000000000000
raw: ffff88805f1b13e0 0000000080130011 00000001ffffffff ffff888042f00c01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5890, tgid 5888 (syz-executor.2), ts 111007407408, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc_lru+0x4a8/0x600 mm/slub.c:3482
 alloc_inode_sb include/linux/fs.h:2705 [inline]
 reiserfs_alloc_inode+0x28/0xc0 fs/reiserfs/super.c:642
 alloc_inode+0x61/0x230 fs/inode.c:260
 iget5_locked fs/inode.c:1241 [inline]
 iget5_locked+0x1cf/0x2c0 fs/inode.c:1234
 reiserfs_fill_super+0xf8c/0x2eb0 fs/reiserfs/super.c:2053
 mount_bdev+0x358/0x420 fs/super.c:1380
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88805f1b0b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805f1b0b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805f1b0c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88805f1b0c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88805f1b0d00: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	retq
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
