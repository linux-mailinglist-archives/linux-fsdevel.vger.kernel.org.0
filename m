Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D04547FBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 08:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiFMGrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 02:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiFMGrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:47:39 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9411448
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jun 2022 23:47:27 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id k4-20020a6b4004000000b006697f6074e6so2208470ioa.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jun 2022 23:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qZj+mPmzYopsuWJNtoK6AumfVed4a3AhFSi49Edkd8k=;
        b=VJkG75/4yBJ2bwIuduVE4MkLq5fAvXMpvi+3ujhKJ3MV1Tl48oBT/XVke2ZrP50GHA
         hnoIIhaSqyAPy2jA48LFMpshnNC0vARN5f5xu91+hHqa/zzMFMX0bEdl5ZaA4v/K7VMj
         7yrIbVKhaxC2rvAlNRRcqTs11VOO2U+4tv18GHxB/vdt4KNGpkKbhKHJE/3KR1YxVj8T
         h6x3lxMIZxY6pT89+aqoyIUei7aQaSouLSD4eCVWuL5Y9Zyhpi4gwhzMC3TUnCqurUDw
         XMO3bbe44xMBPzcNBsc737waS+0HEzxvvpMP7MMBe8A/1AGCT4MGSltOgBJbG7j7nDG6
         X1ug==
X-Gm-Message-State: AOAM533JfFw3uiKS4TtvSzMlvEFd0cxtuxw7fJ46PfHLQyKpVD8PIuGw
        T5GmpMGJXC+F31r3RdqCTM7zGKkaJ1xgYMJAk12eB8NgqzR2
X-Google-Smtp-Source: ABdhPJw49d0ebXsLuEz1UB7NrfZot7Me1pMcHPWzjTKJPYfvKpCU8wP4w1Y8wfIbZb0FXhGZ7wMlS/EDu9UaFDNsoYFnUMNfBT66
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14cb:b0:669:e8a5:71b3 with SMTP id
 b11-20020a05660214cb00b00669e8a571b3mr1631318iow.150.1655102846814; Sun, 12
 Jun 2022 23:47:26 -0700 (PDT)
Date:   Sun, 12 Jun 2022 23:47:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004053b205e14ea988@google.com>
Subject: [syzbot] WARNING: locking bug in inode_insert5
From:   syzbot <syzbot+55178a000c85f0e0cf64@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    fe43c0188911 Merge tag 'docs-5.19-3' of git://git.lwn.net/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1786d7f0080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34139cb754ba01d0
dashboard link: https://syzkaller.appspot.com/bug?extid=55178a000c85f0e0cf64
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55178a000c85f0e0cf64@syzkaller.appspotmail.com

ntfs3: loop3: failed to read volume at offset 0x102000
ntfs3: loop3: failed to read volume at offset 0x104000
ntfs3: loop3: failed to read volume at offset 0x108000
=============================
[ BUG: Invalid wait context ]
5.19.0-rc1-syzkaller-00214-gfe43c0188911 #0 Not tainted
-----------------------------
syz-executor.3/9358 is trying to lock:
ffffffff8c230a98 (&local->iflist_mtx){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:349 [inline]
ffffffff8c230a98 (&local->iflist_mtx){+.+.}-{3:3}, at: inode_sb_list_add fs/inode.c:493 [inline]
ffffffff8c230a98 (&local->iflist_mtx){+.+.}-{3:3}, at: inode_insert5+0x2df/0x6e0 fs/inode.c:1203
other info that might help us debug this:
context-{4:4}
2 locks held by syz-executor.3/9358:
 #0: ffff888076c200e0 (&type->s_umount_key#71/1){+.+.}-{3:3}, at: alloc_super+0x1dd/0xa80 fs/super.c:228
 #1: ffffffff8ba146d8 (inode_hash_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #1: ffffffff8ba146d8 (inode_hash_lock){+.+.}-{2:2}, at: inode_insert5+0x10a/0x6e0 fs/inode.c:1171
stack backtrace:
CPU: 3 PID: 9358 Comm: syz-executor.3 Not tainted 5.19.0-rc1-syzkaller-00214-gfe43c0188911 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4705 [inline]
 check_wait_context kernel/locking/lockdep.c:4766 [inline]
 __lock_acquire.cold+0xdb/0x3b4 kernel/locking/lockdep.c:5003
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 inode_sb_list_add fs/inode.c:493 [inline]
 inode_insert5+0x2df/0x6e0 fs/inode.c:1203
 iget5_locked fs/inode.c:1242 [inline]
 iget5_locked+0x239/0x2e0 fs/inode.c:1231
 ntfs_iget5+0xcc/0x3240 fs/ntfs3/inode.c:493
 ntfs_fill_super+0x2d8e/0x3730 fs/ntfs3/super.c:1185
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7ff821a8a63a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff822b4af88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007ff821a8a63a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ff822b4afe0
RBP: 00007ff822b4b020 R08: 00007ff822b4b020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007ff822b4afe0 R15: 000000002007aa80
 </TASK>
================================================================================
UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.c:131:9
index 8967 is out of range for type 'long unsigned int [8]'
CPU: 3 PID: 9358 Comm: syz-executor.3 Not tainted 5.19.0-rc1-syzkaller-00214-gfe43c0188911 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:283
 decode_tail kernel/locking/qspinlock.c:131 [inline]
 __pv_queued_spin_lock_slowpath+0xa4d/0xb50 kernel/locking/qspinlock.c:471
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
 spin_lock include/linux/spinlock.h:349 [inline]
 inode_sb_list_add fs/inode.c:493 [inline]
 inode_insert5+0x2df/0x6e0 fs/inode.c:1203
 iget5_locked fs/inode.c:1242 [inline]
 iget5_locked+0x239/0x2e0 fs/inode.c:1231
 ntfs_iget5+0xcc/0x3240 fs/ntfs3/inode.c:493
 ntfs_fill_super+0x2d8e/0x3730 fs/ntfs3/super.c:1185
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7ff821a8a63a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff822b4af88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007ff821a8a63a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ff822b4afe0
RBP: 00007ff822b4b020 R08: 00007ff822b4b020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007ff822b4afe0 R15: 000000002007aa80
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
