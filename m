Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAB6425A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 10:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiLEJT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 04:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiLEJTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:19:40 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126A41275F
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Dec 2022 01:19:39 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so4549035ilh.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Dec 2022 01:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y468iOysXD5K+EPVXsktOCNRKCYGbdvNvbmnSUju9X4=;
        b=Z8VF1r634gdVP8xiJjkgEMEWaVV1r2lWOd6vCpCeApvGizF+GMv8FaLZUEQ3Uh6NP8
         HP2zwqcL50uk0FmOZ8WwHj7ncRVmxjE3h2yvfOAfinTyNDn+Gm3OMHnemANiDabXquDr
         CHhpcO5MaTubbbhEdy1s/QKFSq5g20k05EpZHkJWTyEt41EAQ+OX/pFoq6mvNS2Hb6uy
         ywMhXMrZsRE5dJgRXqJKdk9xO3yZoeFG2e27YRRjmV+vXw9srpitPzgVtBuiVtl/DbDE
         U681Cta9/Ts5USMCVhjKVQJW6gb+wHC2eSLlY6RpMltdOXk/eod8Xf+pkgov7d8VH1+n
         zRBg==
X-Gm-Message-State: ANoB5pm2iR/30rfcLqr5LkJ16wGq4py5mkg95hb6Sa5STEpREhmbhXg2
        QpUfLfawDRjcSvBZBdLoEa+H6r/tNmi1R9MWbBOsP/pqhstQ
X-Google-Smtp-Source: AA0mqf5TkxzuRlGJ2PUbvrTX8B++EM+A/hJqV9iALA13YKF0GuS8wkfZPNpEHqFlKNWhx4HdXPxlIZZf3usqk53Ix5qKXM5HQhAl
MIME-Version: 1.0
X-Received: by 2002:a6b:e909:0:b0:6e0:19a2:fa1 with SMTP id
 u9-20020a6be909000000b006e019a20fa1mr591719iof.112.1670231978381; Mon, 05 Dec
 2022 01:19:38 -0800 (PST)
Date:   Mon, 05 Dec 2022 01:19:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c396f805ef112fd3@google.com>
Subject: [syzbot] KMSAN: uninit-value in hfsplus_delete_cat
From:   syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>
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

HEAD commit:    49a9a20768f5 kmsan: allow using __msan_instrument_asm_stor..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1412684d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d901b2d28729cb6a
dashboard link: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a944f9f50fb/disk-49a9a207.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a2ec5594e201/vmlinux-49a9a207.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3aafc1a9ba37/bzImage-49a9a207.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in hfsplus_subfolders_dec fs/hfsplus/catalog.c:248 [inline]
BUG: KMSAN: uninit-value in hfsplus_delete_cat+0x1207/0x14d0 fs/hfsplus/catalog.c:419
 hfsplus_subfolders_dec fs/hfsplus/catalog.c:248 [inline]
 hfsplus_delete_cat+0x1207/0x14d0 fs/hfsplus/catalog.c:419
 hfsplus_rmdir+0x141/0x3d0 fs/hfsplus/dir.c:425
 hfsplus_rename+0x102/0x2e0 fs/hfsplus/dir.c:545
 vfs_rename+0x1e4c/0x2800 fs/namei.c:4779
 do_renameat2+0x173d/0x1dc0 fs/namei.c:4930
 __do_sys_renameat2 fs/namei.c:4963 [inline]
 __se_sys_renameat2 fs/namei.c:4960 [inline]
 __ia32_sys_renameat2+0x14b/0x1f0 fs/namei.c:4960
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was stored to memory at:
 hfsplus_subfolders_inc fs/hfsplus/catalog.c:232 [inline]
 hfsplus_create_cat+0x19e3/0x19f0 fs/hfsplus/catalog.c:314
 hfsplus_mknod+0x1fd/0x560 fs/hfsplus/dir.c:494
 hfsplus_mkdir+0x54/0x60 fs/hfsplus/dir.c:529
 vfs_mkdir+0x62a/0x870 fs/namei.c:4036
 do_mkdirat+0x466/0x7b0 fs/namei.c:4061
 __do_sys_mkdirat fs/namei.c:4076 [inline]
 __se_sys_mkdirat fs/namei.c:4074 [inline]
 __ia32_sys_mkdirat+0xc4/0x120 fs/namei.c:4074
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x9f1/0xe80 mm/page_alloc.c:5581
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
 alloc_inode_sb include/linux/fs.h:3125 [inline]
 hfsplus_alloc_inode+0x56/0xc0 fs/hfsplus/super.c:627
 alloc_inode+0x83/0x440 fs/inode.c:259
 iget_locked+0x2a1/0xe20 fs/inode.c:1286
 hfsplus_iget+0x5f/0xb60 fs/hfsplus/super.c:64
 hfsplus_btree_open+0x13b/0x1cf0 fs/hfsplus/btree.c:150
 hfsplus_fill_super+0x12b0/0x2a80 fs/hfsplus/super.c:473
 mount_bdev+0x508/0x840 fs/super.c:1401
 hfsplus_mount+0x49/0x60 fs/hfsplus/super.c:641
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

CPU: 1 PID: 3898 Comm: syz-executor.2 Not tainted 6.1.0-rc7-syzkaller-63931-g49a9a20768f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
