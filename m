Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7A639460
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 09:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKZIH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Nov 2022 03:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKZIHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Nov 2022 03:07:48 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C4AF02D
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:07:47 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id m11-20020a056e021c2b00b00302c7ea7e16so4384179ilh.22
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxyo8pas/9DaXV1Yc1vr2zKh52JPX/0mEvpbS6DkExw=;
        b=SjJe/XHpV1HkBL9n8jp51OSPeU24X8Xr8T1kxzIa+NmiAbgGPnbLhNx8t5aYBWwV8C
         sZlLIsPgcozYVPt4ip/LjeFWAnZtKRxP0lrTIUc0NNvi3o6nW/C5Oimr3dTboUv5SR9G
         WO7NEXYycIRBusPkiieWl/OYyAb1qhKsAbP3v3NknXy7yJgWlm7/nbqbS/NMLlsF65r9
         ziDJHBB3VNVCajJ3lwzvflUMA/WOGrzrEg9/3hxlGHF1X69HdJjyuhGV+XNWeZ2hV/XY
         mRV4wfe/lwLQqxBlyQRKX6L6zFh7eCDbVNjoasiKW4qe5yrA2BvN7dfBWxVT+R496ycZ
         ma6w==
X-Gm-Message-State: ANoB5pkdKB8uQuU0KzR3UCRINIxQ1281GGtwg5arPp1MmWyYPBBJrkiY
        5ajJ5xadzZ7pzACRRFgpAY6uViPsCRrPLRJYutKlnOjNItI5
X-Google-Smtp-Source: AA0mqf5Po60U6QDR6AsTPQ4nAjLGuaOnLUJzvKL6sT6RtT5sqgu+wcg3i/sUeNmktBKMFXX+V6cYQpVk9IKfwpwTbQ1nYhaN7K6P
MIME-Version: 1.0
X-Received: by 2002:a5e:aa15:0:b0:6cd:cea6:28af with SMTP id
 s21-20020a5eaa15000000b006cdcea628afmr11443071ioe.151.1669450066403; Sat, 26
 Nov 2022 00:07:46 -0800 (PST)
Date:   Sat, 26 Nov 2022 00:07:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002dabd805ee5b222e@google.com>
Subject: [syzbot] possible deadlock in hfsplus_file_extend
From:   syzbot <syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com>
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

HEAD commit:    0b1dcc2cf55a Merge tag 'mm-hotfixes-stable-2022-11-24' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138ad173880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=436ee340148d5197
dashboard link: https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3af32b89453e/disk-0b1dcc2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/063b631f0d64/vmlinux-0b1dcc2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/959ae1bdec1b/bzImage-0b1dcc2c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc6-syzkaller-00251-g0b1dcc2cf55a #0 Not tainted
------------------------------------------------------
syz-executor.2/23177 is trying to acquire lock:
ffff88805c843dc8 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x1bf/0xf60 fs/hfsplus/extents.c:457

but task is already holding lock:
ffff888089d400b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0x1bb/0x230 fs/hfsplus/bfind.c:30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&tree->tree_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
       hfsplus_file_truncate+0xe87/0x10d0 fs/hfsplus/extents.c:595
       hfsplus_setattr+0x1f2/0x320 fs/hfsplus/inode.c:269
       notify_change+0xcd4/0x1440 fs/attr.c:420
       do_truncate+0x140/0x200 fs/open.c:65
       handle_truncate fs/namei.c:3216 [inline]
       do_open fs/namei.c:3561 [inline]
       path_openat+0x2143/0x2860 fs/namei.c:3714
       do_filp_open+0x1ba/0x410 fs/namei.c:3741
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_creat fs/open.c:1402 [inline]
       __se_sys_creat fs/open.c:1396 [inline]
       __x64_sys_creat+0xcd/0x120 fs/open.c:1396
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
       hfsplus_file_extend+0x1bf/0xf60 fs/hfsplus/extents.c:457
       hfsplus_bmap_reserve+0x31c/0x410 fs/hfsplus/btree.c:358
       hfsplus_create_cat+0x1ea/0x10d0 fs/hfsplus/catalog.c:272
       hfsplus_fill_super+0x1544/0x1a30 fs/hfsplus/super.c:560
       mount_bdev+0x351/0x410 fs/super.c:1401
       legacy_get_tree+0x109/0x220 fs/fs_context.c:610
       vfs_get_tree+0x8d/0x2f0 fs/super.c:1531
       do_new_mount fs/namespace.c:3040 [inline]
       path_mount+0x132a/0x1e20 fs/namespace.c:3370
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tree->tree_lock);
                               lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&tree->tree_lock);
  lock(&HFSPLUS_I(inode)->extents_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.2/23177:
 #0: ffff888077b000e0 (&type->s_umount_key#58/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
 #1: ffff888026292998 (&sbi->vh_mutex){+.+.}-{3:3}, at: hfsplus_fill_super+0x14cd/0x1a30 fs/hfsplus/super.c:553
 #2: ffff888089d400b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0x1bb/0x230 fs/hfsplus/bfind.c:30

stack backtrace:
CPU: 0 PID: 23177 Comm: syz-executor.2 Not tainted 6.1.0-rc6-syzkaller-00251-g0b1dcc2cf55a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
 hfsplus_file_extend+0x1bf/0xf60 fs/hfsplus/extents.c:457
 hfsplus_bmap_reserve+0x31c/0x410 fs/hfsplus/btree.c:358
 hfsplus_create_cat+0x1ea/0x10d0 fs/hfsplus/catalog.c:272
 hfsplus_fill_super+0x1544/0x1a30 fs/hfsplus/super.c:560
 mount_bdev+0x351/0x410 fs/super.c:1401
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1531
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f752048d60a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7521100f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000000005f8 RCX: 00007f752048d60a
RDX: 0000000020000600 RSI: 0000000020000040 RDI: 00007f7521100fe0
RBP: 00007f7521101020 R08: 00007f7521101020 R09: 0000000001a00050
R10: 0000000001a00050 R11: 0000000000000202 R12: 0000000020000600
R13: 0000000020000040 R14: 00007f7521100fe0 R15: 0000000020000280
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
