Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3123639466
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 09:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKZIIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Nov 2022 03:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKZIHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Nov 2022 03:07:48 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55240FCED
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:07:47 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id be26-20020a056602379a00b006dd80a0ba1cso2748788iob.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8ze7VYp6vrzD1rGwv501UMpLfYMzpEGSjqQxmeeKU4=;
        b=BiP6OgAZKpoDGGDoRZ2WoO6hMQbuTFJ4cbv2RmKI7bYABvGMiRotywrG/oCSx8QsFP
         7yKSm85AWLbdnHYg6CXuHqR4uoSDesxfPucGKbHrV6VHunnef881l626ctu9w3vLKmXG
         sXLWJYaemtJpZ5gw5sWaj7R2Ex6+soRiPlMVBuZrHMrOCsQcvs593qdAR+8FJnOoLLLk
         HSqwRrTCV3CEpJcrT2KsyfHoL8rEEX8qtSgfafMab5AHrdJMWZ8QgHKL6bUHL0TaZp9c
         oGupwkZqxkH4VWTYKELKJRp1LWjwnMbbepU2JACjpQwr1+uSZY1AW419cwbEcOdwVP8S
         VMhw==
X-Gm-Message-State: ANoB5pl1FHUUv0OXULjRcFDFCbwWvZ21YsIIxagdyhkfXfVfTHF9f9UM
        ZEa4Suw7eHzLr99l8OK5FLAsmHlrlpVVoq8eo15md+yQC3v7
X-Google-Smtp-Source: AA0mqf5pIJPCnbucwYehje9CxitliutSNTaX7TZ6RnSMoVj0I7uqJmXQekSNpqCEUsZmcVKf/4w+3yzbS4GjWM6akXikEo+5WT6j
MIME-Version: 1.0
X-Received: by 2002:a5e:8412:0:b0:6bf:ea95:9891 with SMTP id
 h18-20020a5e8412000000b006bfea959891mr11873178ioj.8.1669450066651; Sat, 26
 Nov 2022 00:07:46 -0800 (PST)
Date:   Sat, 26 Nov 2022 00:07:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031714f05ee5b2257@google.com>
Subject: [syzbot] possible deadlock in hfsplus_file_truncate
From:   syzbot <syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com>
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

HEAD commit:    08ad43d554ba Merge tag 'net-6.1-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11da779b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e40e255b7cf8/disk-08ad43d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfabe238c5ee/vmlinux-08ad43d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2bcb24a7bbed/bzImage-08ad43d5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 1024
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc6-syzkaller-00176-g08ad43d554ba #0 Not tainted
------------------------------------------------------
syz-executor.4/25725 is trying to acquire lock:
ffff888146b700b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x871/0xbb0 fs/hfsplus/extents.c:595

but task is already holding lock:
ffff888029f69c08 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x280/0xbb0 fs/hfsplus/extents.c:576

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfsplus_file_extend+0x1af/0x19d0 fs/hfsplus/extents.c:457
       hfsplus_bmap_reserve+0x123/0x500 fs/hfsplus/btree.c:358
       hfsplus_create_cat+0x178/0xa20 fs/hfsplus/catalog.c:272
       hfsplus_fill_super+0x1379/0x1b50 fs/hfsplus/super.c:560
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

-> #0 (&tree->tree_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
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
       path_openat+0x2770/0x2df0 fs/namei.c:3713
       do_filp_open+0x264/0x4f0 fs/namei.c:3740
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_creat fs/open.c:1402 [inline]
       __se_sys_creat fs/open.c:1396 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1396
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&tree->tree_lock);
                               lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&tree->tree_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.4/25725:
 #0: ffff888146b76460 (sb_writers#29){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393
 #1: ffff888029f69e00 (&sb->s_type->i_mutex_key#36){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888029f69e00 (&sb->s_type->i_mutex_key#36){+.+.}-{3:3}, at: do_truncate+0x1e7/0x2e0 fs/open.c:63
 #2: ffff888029f69c08 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x280/0xbb0 fs/hfsplus/extents.c:576

stack backtrace:
CPU: 0 PID: 25725 Comm: syz-executor.4 Not tainted 6.1.0-rc6-syzkaller-00176-g08ad43d554ba #0
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
 hfsplus_file_truncate+0x871/0xbb0 fs/hfsplus/extents.c:595
 hfsplus_setattr+0x1b8/0x280 fs/hfsplus/inode.c:269
 notify_change+0xe38/0x10f0 fs/attr.c:420
 do_truncate+0x1fb/0x2e0 fs/open.c:65
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x2770/0x2df0 fs/namei.c:3713
 do_filp_open+0x264/0x4f0 fs/namei.c:3740
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe76648c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe767238168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fe7665abf80 RCX: 00007fe76648c0d9
RDX: 0000000000000000 RSI: 00000000000000b8 RDI: 0000000020000100
RBP: 00007fe7664e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffef191c68f R14: 00007fe767238300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
