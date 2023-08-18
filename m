Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA777813EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 21:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379844AbjHRTwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379846AbjHRTvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:51:40 -0400
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8538D3C06
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 12:51:34 -0700 (PDT)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-56438e966baso1664178a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 12:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692388294; x=1692993094;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTLt7xRmf627+86yGuz9GM7PnjiDtsNM6+2Ur3P8lA0=;
        b=b02hlfSfXdzKORQnRz4K+aDHGqCJJ9ApjBRsu6ySDhsT93njLNTmVno7mTRqnZAVIL
         1RfrTGjBMH1pE7juurb1eRacPCPBrJBhWVtayyMi40KZL1OxBLQ5pvtvMDvM0Qkz5hB+
         H8hcQE0IJ53/LzKTlQKAR+VfIASV/XMtAJuIybWA2Sz9efp/v0loVlq4c5ZNB2XevMlp
         2effzDU7qrO3K3JnHpRFZwCOTWoPoCfpTJnBQwca1B5rkjEh2L2fK17jcBZ7p/d6kQWt
         VHNsrB6B/DPt5CNJmxOcXWMNeMFrZWHVamrSMaBxh96LbwGJfx3W0FyILS6SrlVVTp+S
         bI2A==
X-Gm-Message-State: AOJu0YzX6rCaEGGtoIepyP43vuY5OtCd4mDuvkD4AeA2FoodPfm9DvmX
        Fo9GKRZP4odVxVXeBcpiApjeChQDP3xtGtsPBFKUyOaugurF
X-Google-Smtp-Source: AGHT+IE/Z2CzNGgjIBBJPkbO6w8Ty2ML9X1IN0A6Hbe+ouJjpGk9CVtjZ8bNxowwWZahqnDXsdFR7zR4UpTJmYPQyGkLnmTP1tlj
MIME-Version: 1.0
X-Received: by 2002:a17:90b:f0f:b0:26d:ae3:f6a4 with SMTP id
 br15-20020a17090b0f0f00b0026d0ae3f6a4mr30124pjb.5.1692388293991; Fri, 18 Aug
 2023 12:51:33 -0700 (PDT)
Date:   Fri, 18 Aug 2023 12:51:33 -0700
In-Reply-To: <ZN/Lwr/Gg8n+vhw3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015e552060337dbf2@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_getxattr
From:   syzbot <syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> #syz test: github.com/jaegeuk/f2fs/tree/g-dev-test g-dev-test

"github.com/jaegeuk/f2fs/tree/g-dev-test" does not look like a valid git repo address.

>
> On 07/06, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    a452483508d7 Merge tag 's390-6.5-2' of git://git.kernel.or..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=161917a0a80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=15873d91ff37a949
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e5600587fa9cbf8e3826
>> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/5a4997524374/disk-a4524835.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/a0d32791e67c/vmlinux-a4524835.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/ff545ba23349/bzImage-a4524835.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com
>> 
>> F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
>> F2FS-fs (loop0): Found nat_bits in checkpoint
>> F2FS-fs (loop0): Try to recover 1th superblock, ret: 0
>> F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.4.0-syzkaller-12155-ga452483508d7 #0 Not tainted
>> ------------------------------------------------------
>> syz-executor.0/5180 is trying to acquire lock:
>> ffff88803c1b90a0 (&fi->i_xattr_sem){.+.+}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
>> ffff88803c1b90a0 (&fi->i_xattr_sem){.+.+}-{3:3}, at: f2fs_getxattr+0xb8/0x1460 fs/f2fs/xattr.c:532
>> 
>> but task is already holding lock:
>> ffff88803c0196d8 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
>> ffff88803c0196d8 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_do_tmpfile+0x25/0x170 fs/f2fs/dir.c:838
>> 
>> which lock already depends on the new lock.
>> 
>> 
>> the existing dependency chain (in reverse order) is:
>> 
>> -> #1 (&fi->i_sem){+.+.}-{3:3}:
>>        down_write+0x3a/0x50 kernel/locking/rwsem.c:1573
>>        f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
>>        f2fs_add_inline_entry+0x3a8/0x760 fs/f2fs/inline.c:644
>>        f2fs_add_dentry+0xba/0x1e0 fs/f2fs/dir.c:784
>>        f2fs_do_add_link+0x21e/0x340 fs/f2fs/dir.c:827
>>        f2fs_add_link fs/f2fs/f2fs.h:3554 [inline]
>>        f2fs_create+0x32c/0x530 fs/f2fs/namei.c:377
>>        lookup_open fs/namei.c:3492 [inline]
>>        open_last_lookups fs/namei.c:3560 [inline]
>>        path_openat+0x13e7/0x3180 fs/namei.c:3790
>>        do_filp_open+0x234/0x490 fs/namei.c:3820
>>        do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
>>        do_sys_open fs/open.c:1422 [inline]
>>        __do_sys_open fs/open.c:1430 [inline]
>>        __se_sys_open fs/open.c:1426 [inline]
>>        __x64_sys_open+0x225/0x270 fs/open.c:1426
>>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>        do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> 
>> -> #0 (&fi->i_xattr_sem){.+.+}-{3:3}:
>>        check_prev_add kernel/locking/lockdep.c:3142 [inline]
>>        check_prevs_add kernel/locking/lockdep.c:3261 [inline]
>>        validate_chain kernel/locking/lockdep.c:3876 [inline]
>>        __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
>>        lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
>>        down_read+0x47/0x2f0 kernel/locking/rwsem.c:1520
>>        f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
>>        f2fs_getxattr+0xb8/0x1460 fs/f2fs/xattr.c:532
>>        __f2fs_get_acl+0x52/0x8e0 fs/f2fs/acl.c:179
>>        f2fs_acl_create fs/f2fs/acl.c:377 [inline]
>>        f2fs_init_acl+0xd7/0x9a0 fs/f2fs/acl.c:420
>>        f2fs_init_inode_metadata+0x824/0x1190 fs/f2fs/dir.c:558
>>        f2fs_do_tmpfile+0x34/0x170 fs/f2fs/dir.c:839
>>        __f2fs_tmpfile+0x1f9/0x380 fs/f2fs/namei.c:884
>>        f2fs_ioc_start_atomic_write+0x4a3/0x9e0 fs/f2fs/file.c:2099
>>        __f2fs_ioctl+0x1b5c/0xb770
>>        vfs_ioctl fs/ioctl.c:51 [inline]
>>        __do_sys_ioctl fs/ioctl.c:870 [inline]
>>        __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
>>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>        do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> 
>> other info that might help us debug this:
>> 
>>  Possible unsafe locking scenario:
>> 
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(&fi->i_sem);
>>                                lock(&fi->i_xattr_sem);
>>                                lock(&fi->i_sem);
>>   rlock(&fi->i_xattr_sem);
>> 
>>  *** DEADLOCK ***
>> 
>> 5 locks held by syz-executor.0/5180:
>>  #0: ffff888078fb2410 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write_file+0x61/0x200 fs/namespace.c:447
>>  #1: ffff88803c018a28 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
>>  #1: ffff88803c018a28 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: f2fs_ioc_start_atomic_write+0x1b2/0x9e0 fs/f2fs/file.c:2060
>>  #2: ffff88803c019008 (&fi->i_gc_rwsem[WRITE]){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
>>  #2: ffff88803c019008 (&fi->i_gc_rwsem[WRITE]){+.+.}-{3:3}, at: f2fs_ioc_start_atomic_write+0x276/0x9e0 fs/f2fs/file.c:2074
>>  #3: ffff88802b7e03b0 (&sbi->cp_rwsem){.+.+}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
>>  #3: ffff88802b7e03b0 (&sbi->cp_rwsem){.+.+}-{3:3}, at: f2fs_lock_op fs/f2fs/f2fs.h:2151 [inline]
>>  #3: ffff88802b7e03b0 (&sbi->cp_rwsem){.+.+}-{3:3}, at: __f2fs_tmpfile+0x1ce/0x380 fs/f2fs/namei.c:879
>>  #4: ffff88803c0196d8 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
>>  #4: ffff88803c0196d8 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_do_tmpfile+0x25/0x170 fs/f2fs/dir.c:838
>> 
>> stack backtrace:
>> CPU: 1 PID: 5180 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-12155-ga452483508d7 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:88 [inline]
>>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>>  check_noncircular+0x375/0x4a0 kernel/locking/lockdep.c:2195
>>  check_prev_add kernel/locking/lockdep.c:3142 [inline]
>>  check_prevs_add kernel/locking/lockdep.c:3261 [inline]
>>  validate_chain kernel/locking/lockdep.c:3876 [inline]
>>  __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
>>  lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
>>  down_read+0x47/0x2f0 kernel/locking/rwsem.c:1520
>>  f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
>>  f2fs_getxattr+0xb8/0x1460 fs/f2fs/xattr.c:532
>>  __f2fs_get_acl+0x52/0x8e0 fs/f2fs/acl.c:179
>>  f2fs_acl_create fs/f2fs/acl.c:377 [inline]
>>  f2fs_init_acl+0xd7/0x9a0 fs/f2fs/acl.c:420
>>  f2fs_init_inode_metadata+0x824/0x1190 fs/f2fs/dir.c:558
>>  f2fs_do_tmpfile+0x34/0x170 fs/f2fs/dir.c:839
>>  __f2fs_tmpfile+0x1f9/0x380 fs/f2fs/namei.c:884
>>  f2fs_ioc_start_atomic_write+0x4a3/0x9e0 fs/f2fs/file.c:2099
>>  __f2fs_ioctl+0x1b5c/0xb770
>>  vfs_ioctl fs/ioctl.c:51 [inline]
>>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>>  __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7fc9e168c389
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fc9e2476168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 00007fc9e17abf80 RCX: 00007fc9e168c389
>> RDX: 0000000000000000 RSI: 000000000000f501 RDI: 0000000000000005
>> RBP: 00007fc9e16d7493 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00007fffcc104f8f R14: 00007fc9e2476300 R15: 0000000000022000
>>  </TASK>
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> 
>> If the bug is already fixed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>> 
>> If you want to change bug's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>> 
>> If the bug is a duplicate of another bug, reply with:
>> #syz dup: exact-subject-of-another-report
>> 
>> If you want to undo deduplication, reply with:
>> #syz undup
