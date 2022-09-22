Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3235E6FB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiIVWZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 18:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiIVWZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:25:08 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356F193C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:24:39 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id d2-20020a6b7d42000000b006a1760fc2a1so5616456ioq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=fExIYii4xSXdc2eIKeZX94gzboJbFgiY9eZcLdCQl3s=;
        b=AN2CjavQMSY/1M4CHbTA0tL5mC79+QbADtW+N5rD79G8KsaiawJSdrOHNogi00AlcO
         Xh0YKNsGqa2VGmk3EoenUatZy7lA8kE3FaO8YO0mGnw32BH7qjY/XU6htHZoRp2gPqb7
         +eLEdjT5ytTYtoqh912cF2ztZVQdZQ5UBFHRG8veH/bKN8bSxxr6dz7lI0h5crzrBxbR
         fgvo/5qr7ALkkVN/wseeYt0t3dYJ6jythJTI5vWLKVal2tQA7ZFyIO/HN3kGp4Ck0v6Y
         f4iraF+zMKBPzv0n5hjg0vmxsOsr6iKovpZF/bScIKPfPHZ7Otkw+IaBHR4axruBMk8i
         9Gag==
X-Gm-Message-State: ACrzQf0aqOnaiT9DYpK+66ImmO5eze3JnQpvHxVCchjmzcm9UJXWVRmZ
        tFw3h/Y/M4Gk2N8FMqpP2Ags87Ry0jrmb5n9YxIgafx4vVL0
X-Google-Smtp-Source: AMsMyM7vsNDq8PzUsLffyDou3qAqIQn4O1zy+CQUdpmzRl8p0nV/kZ8E9zLljrYQM0v6951JYHH9DzzSXzM+LPLBAf/3sQnflPh5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:2f5:45c6:fd12 with SMTP id
 j13-20020a056e02218d00b002f545c6fd12mr2820850ila.77.1663885478288; Thu, 22
 Sep 2022 15:24:38 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:24:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1632f05e94b86a0@google.com>
Subject: [syzbot] possible deadlock in lock_two_nondirectories
From:   syzbot <syzbot+fa80832503dc44cfd65d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    38eddeedbbea Merge tag 'io_uring-6.0-2022-09-18' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134eed64880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98a30118ec9215e9
dashboard link: https://syzkaller.appspot.com/bug?extid=fa80832503dc44cfd65d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa80832503dc44cfd65d@syzkaller.appspotmail.com

overlayfs: fs on './file0' does not support file handles, falling back to index=off,nfs_export=off.
======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc5-syzkaller-00097-g38eddeedbbea #0 Not tainted
------------------------------------------------------
syz-executor.5/15945 is trying to acquire lock:
ffff88807faf5e48 (&sb->s_type->i_mutex_key#8/4){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
ffff88807faf5e48 (&sb->s_type->i_mutex_key#8/4){+.+.}-{3:3}, at: lock_two_nondirectories+0xd1/0x110 fs/inode.c:1124

but task is already holding lock:
ffff8880300bb628 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff8880300bb628 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: lock_two_nondirectories+0xec/0x110 fs/inode.c:1122

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
       down_read+0x98/0x450 kernel/locking/rwsem.c:1499
       inode_lock_shared include/linux/fs.h:766 [inline]
       ext4_bmap+0x4e/0x460 fs/ext4/inode.c:3157
       bmap+0xaa/0x120 fs/inode.c:1799
       jbd2_journal_bmap+0xa8/0x180 fs/jbd2/journal.c:971
       __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
       jbd2_journal_flush+0x84f/0xc00 fs/jbd2/journal.c:2490
       ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
       __ext4_ioctl+0x28fd/0x4ab0 fs/ext4/ioctl.c:1586
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       mutex_lock_io_nested+0x13f/0x1190 kernel/locking/mutex.c:833
       __jbd2_log_wait_for_space+0x234/0x460 fs/jbd2/checkpoint.c:110
       add_transaction_credits+0xa2d/0xb70 fs/jbd2/transaction.c:298
       start_this_handle+0x3ae/0x14a0 fs/jbd2/transaction.c:422
       jbd2__journal_start+0x38c/0x910 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x3a3/0x490 fs/ext4/ext4_jbd2.c:105
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_evict_inode+0x990/0x1d40 fs/ext4/inode.c:251
       evict+0x2ed/0x6b0 fs/inode.c:665
       iput_final fs/inode.c:1748 [inline]
       iput.part.0+0x55d/0x810 fs/inode.c:1774
       iput+0x58/0x70 fs/inode.c:1764
       d_delete_notify include/linux/fsnotify.h:261 [inline]
       vfs_rmdir.part.0+0x496/0x5a0 fs/namei.c:4111
       vfs_rmdir fs/namei.c:4083 [inline]
       do_rmdir+0x3a6/0x430 fs/namei.c:4159
       __do_sys_unlinkat fs/namei.c:4339 [inline]
       __se_sys_unlinkat fs/namei.c:4333 [inline]
       __x64_sys_unlinkat+0xeb/0x130 fs/namei.c:4333
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_intwrite include/linux/fs.h:1948 [inline]
       ext4_evict_inode+0x11de/0x1d40 fs/ext4/inode.c:240
       evict+0x2ed/0x6b0 fs/inode.c:665
       iput_final fs/inode.c:1748 [inline]
       iput.part.0+0x55d/0x810 fs/inode.c:1774
       iput+0x58/0x70 fs/inode.c:1764
       ext4_rename+0x1411/0x2650 fs/ext4/namei.c:3985
       ext4_rename2+0x1c3/0x270 fs/ext4/namei.c:4164
       vfs_rename+0x115e/0x1a90 fs/namei.c:4756
       do_renameat2+0xb5e/0xc80 fs/namei.c:4907
       __do_sys_renameat2 fs/namei.c:4940 [inline]
       __se_sys_renameat2 fs/namei.c:4937 [inline]
       __x64_sys_renameat2+0xe4/0x120 fs/namei.c:4937
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sb->s_type->i_mutex_key#8/4){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       down_write_nested+0x94/0x150 kernel/locking/rwsem.c:1662
       inode_lock_nested include/linux/fs.h:791 [inline]
       lock_two_nondirectories+0xd1/0x110 fs/inode.c:1124
       vfs_rename+0xc14/0x1a90 fs/namei.c:4726
       ovl_do_rename fs/overlayfs/overlayfs.h:297 [inline]
       ovl_rename+0xe33/0x1770 fs/overlayfs/dir.c:1257
       vfs_rename+0x115e/0x1a90 fs/namei.c:4756
       do_renameat2+0xb5e/0xc80 fs/namei.c:4907
       __do_sys_rename fs/namei.c:4953 [inline]
       __se_sys_rename fs/namei.c:4951 [inline]
       __x64_sys_rename+0x7d/0xa0 fs/namei.c:4951
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#8/4 --> &journal->j_checkpoint_mutex --> &sb->s_type->i_mutex_key#8

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#8);
                               lock(&journal->j_checkpoint_mutex);
                               lock(&sb->s_type->i_mutex_key#8);
  lock(&sb->s_type->i_mutex_key#8/4);

 *** DEADLOCK ***

12 locks held by syz-executor.5/15945:
 #0: ffff888040a1e460 (sb_writers#14){.+.+}-{0:0}, at: do_renameat2+0x37b/0xc80 fs/namei.c:4843
 #1: ffff888040a1e748 (&type->s_vfs_rename_key#2){+.+.}-{3:3}, at: lock_rename+0x54/0x280 fs/namei.c:2994
 #2: ffff88803037b030 (&ovl_i_mutex_dir_key[depth]#2/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #2: ffff88803037b030 (&ovl_i_mutex_dir_key[depth]#2/1){+.+.}-{3:3}, at: lock_rename+0x132/0x280 fs/namei.c:3005
 #3: ffff88803037a480 (&ovl_i_mutex_dir_key[depth]#2/2){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #3: ffff88803037a480 (&ovl_i_mutex_dir_key[depth]#2/2){+.+.}-{3:3}, at: lock_rename+0x166/0x280 fs/namei.c:3006
 #4: ffff88803037eaa0 (&ovl_i_mutex_key[depth]#2){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #4: ffff88803037eaa0 (&ovl_i_mutex_key[depth]#2){+.+.}-{3:3}, at: lock_two_nondirectories+0xec/0x110 fs/inode.c:1122
 #5: ffff88803037f078 (&ovl_i_mutex_key[depth]#2/4){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #5: ffff88803037f078 (&ovl_i_mutex_key[depth]#2/4){+.+.}-{3:3}, at: lock_two_nondirectories+0xd1/0x110 fs/inode.c:1124
 #6: ffff88807e942460 (sb_writers#4){.+.+}-{0:0}, at: ovl_rename+0x25f/0x1770 fs/overlayfs/dir.c:1137
 #7: ffff88803037ee60 (&ovl_i_lock_key[depth]#2){+.+.}-{3:3}, at: ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:499 [inline]
 #7: ffff88803037ee60 (&ovl_i_lock_key[depth]#2){+.+.}-{3:3}, at: ovl_nlink_start+0xe1/0x2e0 fs/overlayfs/util.c:915
 #8: ffff88807e942748 (&type->s_vfs_rename_key){+.+.}-{3:3}, at: lock_rename+0x54/0x280 fs/namei.c:2994
 #9: ffff8880300bc030 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #9: ffff8880300bc030 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: lock_rename+0x132/0x280 fs/namei.c:3005
 #10: ffff88801e3e3628 (&type->i_mutex_dir_key#3/2){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #10: ffff88801e3e3628 (&type->i_mutex_dir_key#3/2){+.+.}-{3:3}, at: lock_rename+0x166/0x280 fs/namei.c:3006
 #11: ffff8880300bb628 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #11: ffff8880300bb628 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: lock_two_nondirectories+0xec/0x110 fs/inode.c:1122

stack backtrace:
CPU: 1 PID: 15945 Comm: syz-executor.5 Not tainted 6.0.0-rc5-syzkaller-00097-g38eddeedbbea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 down_write_nested+0x94/0x150 kernel/locking/rwsem.c:1662
 inode_lock_nested include/linux/fs.h:791 [inline]
 lock_two_nondirectories+0xd1/0x110 fs/inode.c:1124
 vfs_rename+0xc14/0x1a90 fs/namei.c:4726
 ovl_do_rename fs/overlayfs/overlayfs.h:297 [inline]
 ovl_rename+0xe33/0x1770 fs/overlayfs/dir.c:1257
 vfs_rename+0x115e/0x1a90 fs/namei.c:4756
 do_renameat2+0xb5e/0xc80 fs/namei.c:4907
 __do_sys_rename fs/namei.c:4953 [inline]
 __se_sys_rename fs/namei.c:4951 [inline]
 __x64_sys_rename+0x7d/0xa0 fs/namei.c:4951
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f693c089409
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f693d1f1168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f693c19bf80 RCX: 00007f693c089409
RDX: 0000000000000000 RSI: 0000000020000440 RDI: 0000000020000100
RBP: 00007f693c0e4367 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdde820edf R14: 00007f693d1f1300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
