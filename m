Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D802640204
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 09:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiLBIUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 03:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiLBITT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:19:19 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5B113F95
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Dec 2022 00:18:42 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id l22-20020a05660227d600b006dfa191ca8aso4047468ios.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Dec 2022 00:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKLCXP3Fc53XDlKgAGWSc0dbiE40YMywDv9lWM66wec=;
        b=ITox4A/67dIm4rBPHx/C6ZSqZtoNPwShfR/1VpFuPdMIMvw8dRYI7nYa8fdnf7aJKL
         aYH7IUgb1g1kVApMVc59H3IR30APadKp5NVwrf/pjWsnNFtXbAqB0l16STwX0s8z+biN
         uAsMz7Xb/1+a+TqWJRS1pgJNJARxSSJ5aP4pKAI4FcS7tDc0/OLOUqKsl15XHlwAnGmv
         6oFPR2JiEzNLUgNeQgrdz9pf3UMTl1ygHd6rclvsRDMXY53MQr9ogxA9/b+OBCrlwtPR
         +5UIdgLrYfWuKuZ1WiT/qQSzCyt4fsMQY0g09hvbJ4132WVi6Sw5F1qI0P0xLW++Ire9
         Pdpg==
X-Gm-Message-State: ANoB5plAiDkIdu1uDWdjCnwPVKNwbAqtUdUGV+pJim3wr/SZyT/Ro33j
        eWlWgmPGCCQavIDyhIGmToF1rO5SBmYQWAIybRCaqcDvHXs4
X-Google-Smtp-Source: AA0mqf5puYac5s5/K/MITpXoT45GzdArKdIqvIeMh1MSgy/9gM7WesDvEhJnPCN4VYQj/3/6erAacFkPKQKglQ01v8IAcA4RJxGT
MIME-Version: 1.0
X-Received: by 2002:a02:3f60:0:b0:375:2d83:f970 with SMTP id
 c32-20020a023f60000000b003752d83f970mr31914751jaf.205.1669969121385; Fri, 02
 Dec 2022 00:18:41 -0800 (PST)
Date:   Fri, 02 Dec 2022 00:18:41 -0800
In-Reply-To: <0000000000002dabd805ee5b222e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044243d05eed3fc71@google.com>
Subject: Re: [syzbot] possible deadlock in hfsplus_file_extend
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    ef4d3ea40565 afs: Fix server->active leak in afs_put_server
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17b09247880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161ff423880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1130b38d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e840f63d5bd2/disk-ef4d3ea4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/004e32e50436/vmlinux-ef4d3ea4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e371ed85328c/bzImage-ef4d3ea4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/208dde4bde06/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc7-syzkaller-00103-gef4d3ea40565 #0 Not tainted
------------------------------------------------------
syz-executor112/3638 is trying to acquire lock:
ffff88807e8e07c8 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x1af/0x19d0 fs/hfsplus/extents.c:457

but task is already holding lock:
ffff8880183fe0b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0x143/0x1b0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&tree->tree_lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfsplus_file_truncate+0x871/0xbb0 fs/hfsplus/extents.c:595
       hfsplus_setattr+0x1b8/0x280 fs/hfsplus/inode.c:269
       notify_change+0xe38/0x10f0 fs/attr.c:420
       do_truncate+0x1fb/0x2e0 fs/open.c:65
       handle_truncate fs/namei.c:3216 [inline]
       do_open fs/namei.c:3561 [inline]
       path_openat+0x2770/0x2df0 fs/namei.c:3714
       do_filp_open+0x264/0x4f0 fs/namei.c:3741
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_creat fs/open.c:1402 [inline]
       __se_sys_creat fs/open.c:1396 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1396
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfsplus_file_extend+0x1af/0x19d0 fs/hfsplus/extents.c:457
       hfsplus_bmap_reserve+0x123/0x500 fs/hfsplus/btree.c:358
       hfsplus_rename_cat+0x1ab/0x1070 fs/hfsplus/catalog.c:456
       hfsplus_rename+0x129/0x1b0 fs/hfsplus/dir.c:552
       vfs_rename+0xd53/0x1130 fs/namei.c:4779
       do_renameat2+0xb53/0x1370 fs/namei.c:4930
       __do_sys_renameat2 fs/namei.c:4963 [inline]
       __se_sys_renameat2 fs/namei.c:4960 [inline]
       __x64_sys_renameat2+0xce/0xe0 fs/namei.c:4960
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
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

7 locks held by syz-executor112/3638:
 #0: ffff8880183fa460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393
 #1: ffff8880183fa748 (&type->s_vfs_rename_key){+.+.}-{3:3}, at: lock_rename+0x54/0x1a0 fs/namei.c:2994
 #2: ffff88807e8e1e00 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #2: ffff88807e8e1e00 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: lock_rename+0xa0/0x1a0 fs/namei.c:2998
 #3: ffff88807e8e2b80 (&sb->s_type->i_mutex_key#15/2){+.+.}-{3:3}, at: lock_rename+0x16e/0x1a0
 #4: ffff88807e8e3900 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #4: ffff88807e8e3900 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: lock_two_nondirectories+0xdd/0x130 fs/inode.c:1121
 #5: ffff88807e8e3fc0 (&sb->s_type->i_mutex_key#15/4){+.+.}-{3:3}, at: vfs_rename+0x80a/0x1130 fs/namei.c:4749
 #6: ffff8880183fe0b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0x143/0x1b0

stack backtrace:
CPU: 1 PID: 3638 Comm: syz-executor112 Not tainted 6.1.0-rc7-syzkaller-00103-gef4d3ea40565 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 hfsplus_file_extend+0x1af/0x19d0 fs/hfsplus/extents.c:457
 hfsplus_bmap_reserve+0x123/0x500 fs/hfsplus/btree.c:358
 hfsplus_rename_cat+0x1ab/0x1070 fs/hfsplus/catalog.c:456
 hfsplus_rename+0x129/0x1b0 fs/hfsplus/dir.c:552
 vfs_rename+0xd53/0x1130 fs/namei.c:4779
 do_renameat2+0xb53/0x1370 fs/namei.c:4930
 __do_sys_renameat2 fs/namei.c:4963 [inline]
 __se_sys_renameat2 fs/namei.c:4960 [inline]
 __x64_sys_renameat2+0xce/0xe0 fs/namei.c:4960
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1c184509f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff069f5818 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 2f30656c69662f2e RCX: 00007f1c184509f9
RDX: 0000000000000007 RSI: 00000000200001c0 RDI: 0000000000000007
RBP: 00007f1c18410290 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000200002c0 R11: 000000

