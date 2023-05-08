Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC26FB57E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjEHQsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjEHQsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 12:48:03 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FBF5BBC
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 May 2023 09:48:01 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-33539445684so59135045ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 May 2023 09:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564480; x=1686156480;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9GMJOjHlBih2iaTGUzZxRC5iM+ZwrV3nEjnpyC9JsE=;
        b=U6mG6vk+K8hRRHoiUIJBKcKpXd/ODi5xGEHOrnsHFFJHW/e2jCFpSPlTSOHBjxBVL6
         SYqNVpynBpaqaSaKHDONb7EjxWafHJtl+13eMdhVXoi4YHV8qvaDJIy1oD2yfKPtwYSy
         xkZgurau5PEhFYL16cpA/WQ8MwMVer92RMUsDpAqTvVKGWwPLBHYdjyygrfrS4r/v0q/
         1rRVIjVXCWmCNJlBWj0y9EtQhb1olnj7r+LC6ttlMLsatzq5TH2G+vi1H3QGO+x2w/jL
         bF1XOZxqbcebeUyF8m2lZJzV6t6F4BsP++cBk/ok/2GG534mIduED0Hheoq6iE+YhhlZ
         Y7uw==
X-Gm-Message-State: AC+VfDyOzG5YKvDRkF9ZwfmnyNXNV8fF0JdaGPOW6T8qne7j50dod08a
        yK0DlCtwEoIMJyryoPNquLc7Q+6swt+3B68aj0PouY4rjHiZISXyLg==
X-Google-Smtp-Source: ACHHUZ7P2wgx3G45cW8Esf7vOLmDlNqNzCljRWkyglxQU6h0HQYsPJ+1/vCHscn6hXGJAUaUFxC8sYNftlFa01WlZjCJMReM244U
MIME-Version: 1.0
X-Received: by 2002:a92:d5c8:0:b0:335:252b:4fc6 with SMTP id
 d8-20020a92d5c8000000b00335252b4fc6mr3487775ilq.2.1683564480524; Mon, 08 May
 2023 09:48:00 -0700 (PDT)
Date:   Mon, 08 May 2023 09:48:00 -0700
In-Reply-To: <000000000000964cb905f5e876ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d17bff05fb316670@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in delete_one_xattr (2)
From:   syzbot <syzbot+7a278bf8bfa794494110@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ac9a78681b92 Linux 6.4-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12d2a75a280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
dashboard link: https://syzkaller.appspot.com/bug?extid=7a278bf8bfa794494110
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1295e4b8280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140af20a280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09860189d36b/disk-ac9a7868.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3eb9c32c8830/vmlinux-ac9a7868.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14b50dd219a1/bzImage-ac9a7868.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/10efaa5d185c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a278bf8bfa794494110@syzkaller.appspotmail.com

overlayfs: upper fs needs to support d_type.
overlayfs: upper fs does not support tmpfile.
overlayfs: upper fs does not support RENAME_WHITEOUT.
======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc1-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor174/4998 is trying to acquire lock:
ffff888073d4aaa0 (&type->i_mutex_dir_key#6/2){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
ffff888073d4aaa0 (&type->i_mutex_dir_key#6/2){+.+.}-{3:3}, at: xattr_rmdir fs/reiserfs/xattr.c:107 [inline]
ffff888073d4aaa0 (&type->i_mutex_dir_key#6/2){+.+.}-{3:3}, at: delete_one_xattr+0x141/0x2d0 fs/reiserfs/xattr.c:339

but task is already holding lock:
ffff888073d496c0 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
ffff888073d496c0 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: reiserfs_for_each_xattr+0x6fd/0x9a0 fs/reiserfs/xattr.c:310

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}:
       down_write_nested+0x96/0x200 kernel/locking/rwsem.c:1689
       inode_lock_nested include/linux/fs.h:810 [inline]
       open_xa_root fs/reiserfs/xattr.c:128 [inline]
       open_xa_dir+0x127/0x840 fs/reiserfs/xattr.c:153
       xattr_lookup+0x21/0x3d0 fs/reiserfs/xattr.c:396
       reiserfs_xattr_set_handle+0xfb/0xb00 fs/reiserfs/xattr.c:534
       reiserfs_xattr_set+0x454/0x5b0 fs/reiserfs/xattr.c:634
       trusted_set+0xa7/0xd0 fs/reiserfs/xattr_trusted.c:31
       __vfs_setxattr+0x173/0x1e0 fs/xattr.c:201
       __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:235
       __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:296
       vfs_setxattr+0x143/0x340 fs/xattr.c:322
       ovl_do_setxattr fs/overlayfs/overlayfs.h:255 [inline]
       ovl_setxattr fs/overlayfs/overlayfs.h:267 [inline]
       ovl_make_workdir fs/overlayfs/super.c:1332 [inline]
       ovl_get_workdir fs/overlayfs/super.c:1436 [inline]
       ovl_fill_super+0x2276/0x7270 fs/overlayfs/super.c:1992
       mount_nodev+0x64/0x120 fs/super.c:1426
       legacy_get_tree+0x109/0x220 fs/fs_context.c:610
       vfs_get_tree+0x8d/0x350 fs/super.c:1510
       do_new_mount fs/namespace.c:3039 [inline]
       path_mount+0x134b/0x1e40 fs/namespace.c:3369
       do_mount fs/namespace.c:3382 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&type->i_mutex_dir_key#6){++++}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:775 [inline]
       vfs_rename+0x4f9/0x17a0 fs/namei.c:4821
       do_renameat2+0xc04/0xd40 fs/namei.c:5002
       __do_sys_rename fs/namei.c:5048 [inline]
       __se_sys_rename fs/namei.c:5046 [inline]
       __x64_sys_rename+0x81/0xa0 fs/namei.c:5046
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->i_mutex_dir_key#6/2){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain kernel/locking/lockdep.c:3842 [inline]
       __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
       lock_acquire kernel/locking/lockdep.c:5691 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
       down_write_nested+0x96/0x200 kernel/locking/rwsem.c:1689
       inode_lock_nested include/linux/fs.h:810 [inline]
       xattr_rmdir fs/reiserfs/xattr.c:107 [inline]
       delete_one_xattr+0x141/0x2d0 fs/reiserfs/xattr.c:339
       reiserfs_for_each_xattr+0x70e/0x9a0 fs/reiserfs/xattr.c:312
       reiserfs_delete_xattrs+0x20/0xa0 fs/reiserfs/xattr.c:365
       reiserfs_evict_inode+0x2e7/0x540 fs/reiserfs/inode.c:53
       evict+0x2ed/0x6b0 fs/inode.c:665
       iput_final fs/inode.c:1747 [inline]
       iput.part.0+0x50a/0x740 fs/inode.c:1773
       iput+0x5c/0x80 fs/inode.c:1763
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
       dentry_kill fs/dcache.c:745 [inline]
       dput+0x6ac/0xe10 fs/dcache.c:913
       cleanup_mnt+0x286/0x3d0 fs/namespace.c:1176
       task_work_run+0x16f/0x270 kernel/task_work.c:179
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xad3/0x2960 kernel/exit.c:871
       do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
       __do_sys_exit_group kernel/exit.c:1032 [inline]
       __se_sys_exit_group kernel/exit.c:1030 [inline]
       __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#6/2 --> &type->i_mutex_dir_key#6 --> &type->i_mutex_dir_key#6/3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->i_mutex_dir_key#6/3);
                               lock(&type->i_mutex_dir_key#6);
                               lock(&type->i_mutex_dir_key#6/3);
  lock(&type->i_mutex_dir_key#6/2);

 *** DEADLOCK ***

1 lock held by syz-executor174/4998:
 #0: ffff888073d496c0 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #0: ffff888073d496c0 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: reiserfs_for_each_xattr+0x6fd/0x9a0 fs/reiserfs/xattr.c:310

stack backtrace:
CPU: 0 PID: 4998 Comm: syz-executor174 Not tainted 6.4.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain kernel/locking/lockdep.c:3842 [inline]
 __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
 lock_acquire kernel/locking/lockdep.c:5691 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
 down_write_nested+0x96/0x200 kernel/locking/rwsem.c:1689
 inode_lock_nested include/linux/fs.h:810 [inline]
 xattr_rmdir fs/reiserfs/xattr.c:107 [inline]
 delete_one_xattr+0x141/0x2d0 fs/reiserfs/xattr.c:339
 reiserfs_for_each_xattr+0x70e/0x9a0 fs/reiserfs/xattr.c:312
 reiserfs_delete_xattrs+0x20/0xa0 fs/reiserfs/xattr.c:365
 reiserfs_evict_inode+0x2e7/0x540 fs/reiserfs/inode.c:53
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x50a/0x740 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:745 [inline]
 dput+0x6ac/0xe10 fs/dcache.c:913
 cleanup_mnt+0x286/0x3d0 fs/namespace.c:1176
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xad3/0x2960 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f73aae31bb9
Code: Unable to access opcode bytes at 0x7f73aae31b8f.
RSP: 002b:00007fff0a6df368 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f73aaea8330 RCX: 00007f73aae31bb9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00007f73aaea2e40
R10: 00007f73aaea2


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
