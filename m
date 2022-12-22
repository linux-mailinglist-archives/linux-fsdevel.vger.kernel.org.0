Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF0653C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 08:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiLVHc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 02:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiLVHc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 02:32:56 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF623E9C
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 23:32:55 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id j3-20020a056e02154300b00304bc968ef1so714952ilu.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 23:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIkHxDubkjuQslZrjT1X+xdpYct/nDKr2hboTqeeD0A=;
        b=rRMk2C6QkCHsahRpzZ7zfOUCZWdBybFnwKPbsj8hSwUSVx+RdWzMKgdXGNCFCIA8SE
         wUvAz7NvTqJq5P+hSLEZp8tpyOMlI+68loQcmD5KP6FNFx2ZCK0S3q2eB/hVpoZIfy71
         T2xIJWkXJABIFVIePKZ3m9Z40OuaWh/H/kGGmrmUfjQFaEANkAjc2GVlOiDcc8xlTcnq
         YpTxY4sNxyFGL1Md4yMjPMqMh7liom4eGa3x1rfl6cB7/Z0qy6XQJJ44FGg2XMXyZVA6
         GiBoSu3VWNCNDQbrh1G0MKikTXZNY9S+8pB06IRWCyCFGBaXvUaV95KwAfaPKe7Qb03K
         2GVw==
X-Gm-Message-State: AFqh2koEpsMPgJIin1rj2r2QJFIZlKiuE2I/vC0+f7bEAsak1GbMV30l
        xEfBCVYg07f11jzH5vnJcm9x/hX1CFWxI93C5pbqTqkZA5ER
X-Google-Smtp-Source: AMrXdXsKrYCCsV5zrx5z/esYEJVAmIAHQ2g2HwX6axV9m2MqlDyhHAjTIz5biSlETwyJgmcv0oR7TjJa4UTY0sczipilRiLQrEv9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:48a:b0:30b:b9a9:ca8 with SMTP id
 b10-20020a056e02048a00b0030bb9a90ca8mr452268ils.216.1671694374940; Wed, 21
 Dec 2022 23:32:54 -0800 (PST)
Date:   Wed, 21 Dec 2022 23:32:54 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006436bb05f065adbc@google.com>
Subject: [syzbot] [hfs?] possible deadlock in hfs_extend_file
From:   syzbot <syzbot+a4919d77e3a0272910bb@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    b6bb9676f216 Merge tag 'm68knommu-for-v6.2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bd42cf880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3fb546de56fbf8d
dashboard link: https://syzkaller.appspot.com/bug?extid=a4919d77e3a0272910bb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f703f794500/disk-b6bb9676.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0cca7cdd545b/vmlinux-b6bb9676.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0ce2560b7652/bzImage-b6bb9676.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4919d77e3a0272910bb@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-syzkaller-13872-gb6bb9676f216 #0 Not tainted
------------------------------------------------------
syz-executor.5/10745 is trying to acquire lock:
ffff88802b21e8f8 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xde/0x1420 fs/hfs/extent.c:397

but task is already holding lock:
ffff88806083e0b0 (&tree->tree_lock#2/1){+.+.}-{3:3}, at: hfs_find_init+0x167/0x1e0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&tree->tree_lock#2/1){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfs_find_init+0x167/0x1e0
       hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
       hfs_extend_file+0x2f8/0x1420 fs/hfs/extent.c:401
       hfs_bmap_reserve+0xfa/0x410 fs/hfs/btree.c:234
       hfs_cat_create+0x1b5/0x8a0 fs/hfs/catalog.c:104
       hfs_create+0x62/0xd0 fs/hfs/dir.c:202
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x12ac/0x2dd0 fs/namei.c:3711
       do_filp_open+0x264/0x4f0 fs/namei.c:3741
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_open fs/open.c:1334 [inline]
       __se_sys_open fs/open.c:1330 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1330
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfs_extend_file+0xde/0x1420 fs/hfs/extent.c:397
       hfs_bmap_reserve+0xfa/0x410 fs/hfs/btree.c:234
       __hfs_ext_write_extent+0x1ea/0x460 fs/hfs/extent.c:121
       __hfs_ext_cache_extent+0x67/0x980 fs/hfs/extent.c:174
       hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
       hfs_extend_file+0x323/0x1420 fs/hfs/extent.c:401
       hfs_get_block+0x3fc/0xbb0 fs/hfs/extent.c:353
       __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
       __block_write_begin fs/buffer.c:2041 [inline]
       block_write_begin+0x93/0x1e0 fs/buffer.c:2102
       cont_write_begin+0x606/0x860 fs/buffer.c:2456
       hfs_write_begin+0x86/0xd0 fs/hfs/inode.c:58
       cont_expand_zero fs/buffer.c:2383 [inline]
       cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
       hfs_write_begin+0x86/0xd0 fs/hfs/inode.c:58
       hfs_file_truncate+0x159/0xa10 fs/hfs/extent.c:494
       hfs_inode_setattr+0x45d/0x690 fs/hfs/inode.c:651
       notify_change+0xe50/0x1100 fs/attr.c:482
       do_truncate+0x200/0x2f0 fs/open.c:65
       do_sys_ftruncate+0x2b0/0x350 fs/open.c:193
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tree->tree_lock#2/1);
                               lock(&HFS_I(tree->inode)->extents_lock);
                               lock(&tree->tree_lock#2/1);
  lock(&HFS_I(tree->inode)->extents_lock);

 *** DEADLOCK ***

4 locks held by syz-executor.5/10745:
 #0: ffff8880231a8460 (sb_writers#22){.+.+}-{0:0}, at: do_sys_ftruncate+0x243/0x350 fs/open.c:190
 #1: ffff88802b21a328 (&sb->s_type->i_mutex_key#28){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88802b21a328 (&sb->s_type->i_mutex_key#28){+.+.}-{3:3}, at: do_truncate+0x1ec/0x2f0 fs/open.c:63
 #2: ffff88802b21a178 (&HFS_I(inode)->extents_lock#2){+.+.}-{3:3}, at: hfs_extend_file+0xde/0x1420 fs/hfs/extent.c:397
 #3: ffff88806083e0b0 (&tree->tree_lock#2/1){+.+.}-{3:3}, at: hfs_find_init+0x167/0x1e0

stack backtrace:
CPU: 0 PID: 10745 Comm: syz-executor.5 Not tainted 6.1.0-syzkaller-13872-gb6bb9676f216 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 hfs_extend_file+0xde/0x1420 fs/hfs/extent.c:397
 hfs_bmap_reserve+0xfa/0x410 fs/hfs/btree.c:234
 __hfs_ext_write_extent+0x1ea/0x460 fs/hfs/extent.c:121
 __hfs_ext_cache_extent+0x67/0x980 fs/hfs/extent.c:174
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_extend_file+0x323/0x1420 fs/hfs/extent.c:401
 hfs_get_block+0x3fc/0xbb0 fs/hfs/extent.c:353
 __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0x93/0x1e0 fs/buffer.c:2102
 cont_write_begin+0x606/0x860 fs/buffer.c:2456
 hfs_write_begin+0x86/0xd0 fs/hfs/inode.c:58
 cont_expand_zero fs/buffer.c:2383 [inline]
 cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
 hfs_write_begin+0x86/0xd0 fs/hfs/inode.c:58
 hfs_file_truncate+0x159/0xa10 fs/hfs/extent.c:494
 hfs_inode_setattr+0x45d/0x690 fs/hfs/inode.c:651
 notify_change+0xe50/0x1100 fs/attr.c:482
 do_truncate+0x200/0x2f0 fs/open.c:65
 do_sys_ftruncate+0x2b0/0x350 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4373c8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f43749db168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f4373dabf80 RCX: 00007f4373c8c0d9
RDX: 0000000000000000 RSI: 0000000002007fff RDI: 0000000000000005
RBP: 00007f4373ce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffda414b44f R14: 00007f43749db300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
