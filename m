Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391CD6386DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 10:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKYJ6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 04:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiKYJ5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:57:46 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6DB14D0D
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:56:33 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id t2-20020a6b6402000000b006dea34ad528so1864018iog.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUSkP76cq3aYcTr4I+ixSY0EUlW3U5c4YEXhWdyd9B4=;
        b=pJFr9XxIZXMZkggp1SoAiQOi+m772IJptbxiwRd3K9cqeAaY3OViXOrID4KzAR8W2G
         3anhTaYTnDLkijcr2PVENCvSotQV7lJERmNnNozudR0p+Uhs7ODWg8ZWWk5V3zuX+/g7
         qN5wYUdvKY+2PPiRIDZPKxMo1jRwxrsI25PcIgrRsM6xIuU8UkHtr1wuX/aJpwt7zGpD
         CWUGYPO4+LZv2dpt/e2nbb69XxIzd5yWZmGT2MtHR+xVlpZwfFZAGcr+LAYpJRa7OjMg
         7usa5diWKztAGRgm9eKqLoHjxCe3qCZB/gaLfNXRdOJYFnH5XSFBVVI/DSSbHbvZ/t28
         A4Gg==
X-Gm-Message-State: ANoB5pm+vUKMzH855jG50cyO4c7San7qet82frRNpYKfworjH+klVOEW
        YA0/9dPdiZQv4T1WewbWX/sdVXFluxu0Z5RQdeRwDuVuwRrB
X-Google-Smtp-Source: AA0mqf5Ckrc3x5yhpe1j8Yn+Gh0gZFYldrZQnZXsdZ0y96ljxWUOxmpZU2foN2GcIhNE3MAGXkxQB0+VouF7o8qaCRnhiN2bsfrm
MIME-Version: 1.0
X-Received: by 2002:a02:9469:0:b0:363:afc3:b405 with SMTP id
 a96-20020a029469000000b00363afc3b405mr9631171jai.243.1669370193038; Fri, 25
 Nov 2022 01:56:33 -0800 (PST)
Date:   Fri, 25 Nov 2022 01:56:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ad04005ee48897f@google.com>
Subject: [syzbot] KMSAN: uninit-value in hfs_revalidate_dentry
From:   syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

HEAD commit:    a472f15b3d1e kmsan: allow using __msan_instrument_asm_stor..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1206a7fd880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1429f86b132e6d40
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a8bf743ab4c3/disk-a472f15b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7248eae68bc7/vmlinux-a472f15b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e33e55592a5/bzImage-a472f15b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in hfs_revalidate_dentry+0x17f/0x3e0 fs/hfs/sysdep.c:30
 hfs_revalidate_dentry+0x17f/0x3e0 fs/hfs/sysdep.c:30
 d_revalidate fs/namei.c:856 [inline]
 lookup_open fs/namei.c:3345 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x115a/0x5600 fs/namei.c:3710
 do_filp_open+0x249/0x660 fs/namei.c:3740
 do_sys_openat2+0x1f0/0x910 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_compat_sys_openat fs/open.c:1386 [inline]
 __se_compat_sys_openat fs/open.c:1384 [inline]
 __ia32_compat_sys_openat+0x2a7/0x330 fs/open.c:1384
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x9f1/0xe80 mm/page_alloc.c:5578
 alloc_pages+0xaae/0xd80 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x1b5/0x1010 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x10c3/0x2d60 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x6f3/0xb30 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3117 [inline]
 hfs_alloc_inode+0x56/0xc0 fs/hfs/super.c:165
 alloc_inode+0x83/0x440 fs/inode.c:259
 iget_locked+0x2a1/0xe20 fs/inode.c:1286
 hfs_btree_open+0x162/0x1ab0 fs/hfs/btree.c:38
 hfs_mdb_get+0x207d/0x29b0 fs/hfs/mdb.c:199
 hfs_fill_super+0x1d13/0x2400 fs/hfs/super.c:406
 mount_bdev+0x508/0x840 fs/super.c:1401
 hfs_mount+0x49/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x10c/0x280 fs/fs_context.c:610
 vfs_get_tree+0xa1/0x500 fs/super.c:1531
 do_new_mount+0x694/0x1580 fs/namespace.c:3040
 path_mount+0x71a/0x1eb0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x734/0x840 fs/namespace.c:3568
 __ia32_sys_mount+0xdf/0x140 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 0 PID: 4234 Comm: syz-executor.0 Not tainted 6.1.0-rc6-syzkaller-63555-ga472f15b3d1e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
