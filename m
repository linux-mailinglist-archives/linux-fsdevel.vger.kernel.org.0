Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00596A8011
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 11:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjCBKk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 05:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCBKk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:40:58 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D82302A6
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 02:40:54 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id 2-20020a056e020ca200b003033a763270so9546297ilg.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 02:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4y6ekAr2f9pTk4oEDC+4C4bSnqM1bN8NsGnnz+S/8/4=;
        b=cT4LXQaAlOP5AOU4AIivfYhmLrosI/2qE/moisUFopGoyczZXn2sN6rxNTlV/eTGxg
         pFz/7qEYFBLvfAg5pg2Cj/wcwq4szkigaxfp/ssbDqwFWvjLelDt2FgIp75vATLbeZn6
         3qo+s64ySd8IpCHiHeXfAkApIbbjxRi8u0h7rbY/Oit2ABeUwftMi3l/3eH3Hg73rTO9
         WOwKUJ97GChoFOuYWikwloas9L0SGkUXfc/uR9FeUC884+4iyM+DwXwOzTOcckr7rFOy
         dvoD9cw6gUp5eoNnvKLI/L4CZbtnv/iBxFxcuaUBevb+qzJOa4IopQRsAHC1WrfjCxQC
         Jgzw==
X-Gm-Message-State: AO0yUKVZJ7V6hXVN8yjBPmhYvjYrD9162q8MbqFQgocR19RQE7/YPdyE
        SbFh34qRTPkjPYWDRXLbr+I5+5reYpVDRBCRYB5TFiSs7z1pAJM=
X-Google-Smtp-Source: AK7set8t9pWxViAJvea2e6U/bK+ZozpitVQeGrJSzd45kYEAXXJ77ADYs5ycFq/NG3cmjGrN1DvSFPjzCEso082f7S38J5A5nNJV
MIME-Version: 1.0
X-Received: by 2002:a02:a02:0:b0:3e9:4d91:5c9c with SMTP id
 2-20020a020a02000000b003e94d915c9cmr693973jaw.1.1677753654330; Thu, 02 Mar
 2023 02:40:54 -0800 (PST)
Date:   Thu, 02 Mar 2023 02:40:54 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000964cb905f5e876ff@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in delete_one_xattr (2)
From:   syzbot <syzbot+7a278bf8bfa794494110@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    2fcd07b7ccd5 mm/mprotect: Fix successful vma_merge() of ne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16148c50c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56eb47529ec6fdbe
dashboard link: https://syzkaller.appspot.com/bug?extid=7a278bf8bfa794494110
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fe4d914ffdbb/disk-2fcd07b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/590339659f6c/vmlinux-2fcd07b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0ecc3d4d7e9/bzImage-2fcd07b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a278bf8bfa794494110@syzkaller.appspotmail.com

REISERFS (device loop2): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.2.0-syzkaller-12018-g2fcd07b7ccd5 #0 Not tainted
------------------------------------------------------
syz-executor.2/12978 is trying to acquire lock:
ffff888070d27ac0 (&type->i_mutex_dir_key#8/2){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
ffff888070d27ac0 (&type->i_mutex_dir_key#8/2){+.+.}-{3:3}, at: xattr_rmdir fs/reiserfs/xattr.c:106 [inline]
ffff888070d27ac0 (&type->i_mutex_dir_key#8/2){+.+.}-{3:3}, at: delete_one_xattr+0x141/0x2d0 fs/reiserfs/xattr.c:338

but task is already holding lock:
ffff888031d2a3e0 (&type->i_mutex_dir_key#8/3){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
ffff888031d2a3e0 (&type->i_mutex_dir_key#8/3){+.+.}-{3:3}, at: reiserfs_for_each_xattr+0x6fd/0x9a0 fs/reiserfs/xattr.c:309

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&type->i_mutex_dir_key#8/3){+.+.}-{3:3}:
       down_write_nested+0x96/0x200 kernel/locking/rwsem.c:1689
       inode_lock_nested include/linux/fs.h:793 [inline]
       open_xa_root fs/reiserfs/xattr.c:127 [inline]
       open_xa_dir+0x127/0x840 fs/reiserfs/xattr.c:152
       xattr_lookup+0x21/0x3d0 fs/reiserfs/xattr.c:395
       reiserfs_xattr_get+0x118/0xa80 fs/reiserfs/xattr.c:677
       security_get+0x83/0xb0 fs/reiserfs/xattr_security.c:19
       __vfs_getxattr+0x138/0x1a0 fs/xattr.c:426
       cap_inode_need_killpriv+0x40/0x60 security/commoncap.c:301
       security_inode_need_killpriv+0x44/0xa0 security/security.c:1492
       dentry_needs_remove_privs fs/inode.c:1968 [inline]
       __file_remove_privs+0x3a0/0x640 fs/inode.c:1999
       __generic_file_write_iter+0xc7/0x500 mm/filemap.c:3999
       generic_file_write_iter+0xe3/0x350 mm/filemap.c:4086
       call_write_iter include/linux/fs.h:1851 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x9ed/0xe10 fs/read_write.c:584
       ksys_write+0x12b/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:758 [inline]
       lock_two_nondirectories+0xf0/0x110 fs/inode.c:1122
       vfs_rename+0x9ac/0x17a0 fs/namei.c:4742
       do_renameat2+0xb62/0xc90 fs/namei.c:4923
       __do_sys_renameat2 fs/namei.c:4956 [inline]
       __se_sys_renameat2 fs/namei.c:4953 [inline]
       __x64_sys_renameat2+0xe8/0x120 fs/namei.c:4953
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->i_mutex_dir_key#8/2){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
       down_write_nested+0x96/0x200 kernel/locking/rwsem.c:1689
       inode_lock_nested include/linux/fs.h:793 [inline]
       xattr_rmdir fs/reiserfs/xattr.c:106 [inline]
       delete_one_xattr+0x141/0x2d0 fs/reiserfs/xattr.c:338
       reiserfs_for_each_xattr+0x70e/0x9a0 fs/reiserfs/xattr.c:311
       reiserfs_delete_xattrs+0x20/0xa0 fs/reiserfs/xattr.c:364
       reiserfs_evict_inode+0x2e7/0x540 fs/reiserfs/inode.c:53
       evict+0x2ed/0x6b0 fs/inode.c:665
       iput_final fs/inode.c:1748 [inline]
       iput.part.0+0x59b/0x8a0 fs/inode.c:1774
       iput+0x5c/0x80 fs/inode.c:1764
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
       dentry_kill fs/dcache.c:745 [inline]
       dput+0x6ac/0xe10 fs/dcache.c:913
       path_put+0x31/0x70 fs/namei.c:559
       path_setxattr+0xd6/0x1c0 fs/xattr.c:655
       __do_sys_lsetxattr fs/xattr.c:674 [inline]
       __se_sys_lsetxattr fs/xattr.c:670 [inline]
       __x64_sys_lsetxattr+0xc1/0x160 fs/xattr.c:670
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#8/2 --> &sb->s_type->i_mutex_key#21 --> &type->i_mutex_dir_key#8/3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->i_mutex_dir_key#8/3);
                               lock(&sb->s_type->i_mutex_key#21);
                               lock(&type->i_mutex_dir_key#8/3);
  lock(&type->i_mutex_dir_key#8/2);

 *** DEADLOCK ***

1 lock held by syz-executor.2/12978:
 #0: ffff888031d2a3e0 (&type->i_mutex_dir_key#8/3){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
 #0: ffff888031d2a3e0 (&type->i_mutex_dir_key#8/3){+.+.}-{3:3}, at: reiserfs_for_each_xattr+0x6fd/0x9a0 fs/reiserfs/xattr.c:309

stack backtrace:
CPU: 0 PID: 12978 Comm: syz-executor.2 Not tainted 6.2.0-syzkaller-12018-g2fcd07b7ccd5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain kernel/locking/lockdep.c:3832 [inline]
 __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
 lock_acquire kernel/locking/lockdep.c:5669 [inline]
 lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
 down_write_nested+0x96/0x200 kernel/locking/rwsem.c:1689
 inode_lock_nested include/linux/fs.h:793 [inline]
 xattr_rmdir fs/reiserfs/xattr.c:106 [inline]
 delete_one_xattr+0x141/0x2d0 fs/reiserfs/xattr.c:338
 reiserfs_for_each_xattr+0x70e/0x9a0 fs/reiserfs/xattr.c:311
 reiserfs_delete_xattrs+0x20/0xa0 fs/reiserfs/xattr.c:364
 reiserfs_evict_inode+0x2e7/0x540 fs/reiserfs/inode.c:53
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x59b/0x8a0 fs/inode.c:1774
 iput+0x5c/0x80 fs/inode.c:1764
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:745 [inline]
 dput+0x6ac/0xe10 fs/dcache.c:913
 path_put+0x31/0x70 fs/namei.c:559
 path_setxattr+0xd6/0x1c0 fs/xattr.c:655
 __do_sys_lsetxattr fs/xattr.c:674 [inline]
 __se_sys_lsetxattr fs/xattr.c:670 [inline]
 __x64_sys_lsetxattr+0xc1/0x160 fs/xattr.c:670
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efd9908c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efd99e3b168 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 00007efd991abf80 RCX: 00007efd9908c0f9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000020000040
RBP: 00007efd990e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdc761bbef R14: 00007efd99e3b300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
