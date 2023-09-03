Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5449790EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 00:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245099AbjICWa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 18:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244007AbjICWay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:30:54 -0400
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8956DA
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Sep 2023 15:30:49 -0700 (PDT)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-5709e2551bcso252835a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Sep 2023 15:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780249; x=1694385049;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uvjNZ30LBEHGWu5hFTDkWGufH/rb9S8Ay/l9GigndY=;
        b=DOMB+pyS4mD2uZ2QxyJyeEfW/YWfZtuNQB0Q4IH1aLgoumXGb4dTobNCUr7xuKW9fi
         eJqxNQKL0ru5LpKqyJK7/6e9V4frR3ftIOEJeIKmT81Qes+ZyMBiRt4g2BHdRjNDfhiC
         hudnEHqOpyc1NaoNnldWBn+hBF+pCbhV/a9fcYVNtjoEcdZ0lPP36NqEe3iyVlLQgAJ3
         qZSvK6lkTdtBsPNt8wPm/zoE+61WrSfmYZI6MRSniSstkvZRxUutBjxndg/k1IVRUk1M
         Wfhk0YxKP1BNxP/tpcL4CqCDirCnW5UzjDBv7VS1TQ2zbsCi8CGKV67wpqOmn0WsEAuD
         s9wA==
X-Gm-Message-State: AOJu0YwybNgrYamdciwghdtR6GPRaQlQAO3z75s1Bo33Wk04DINFxKvW
        fv+A1fGlhc2/zr+DjpdiyyPxvy19YmTkCJX/wq+OD7bEMOI8
X-Google-Smtp-Source: AGHT+IEXT2qrOqWzU6OZ8OLjQpbiKOTHuAbsdErDcr6GxN7nF7gabr/2juLru+7RCP9ARrdnz9DEVUrHMi9NILSo63+dEF/0gfHe
MIME-Version: 1.0
X-Received: by 2002:a63:3dc9:0:b0:564:1f95:71f1 with SMTP id
 k192-20020a633dc9000000b005641f9571f1mr1995310pga.3.1693780249419; Sun, 03
 Sep 2023 15:30:49 -0700 (PDT)
Date:   Sun, 03 Sep 2023 15:30:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001825ce06047bf2a6@google.com>
Subject: [syzbot] [f2fs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6c1b980a7e79 Merge tag 'dma-mapping-6.6-2023-08-29' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a9669fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2212484c18930a61
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6e2281f5cb6b/disk-6c1b980a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5fc2481dcded/vmlinux-6c1b980a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/283bb76567da/bzImage-6c1b980a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.5.0-syzkaller-04808-g6c1b980a7e79 #0 Not tainted
------------------------------------------------------
syz-executor.4/22893 is trying to acquire lock:
ffff888039b740e0 (&type->s_umount_key#25){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
ffff888039b740e0 (&type->s_umount_key#25){++++}-{3:3}, at: super_lock+0x23c/0x380 fs/super.c:117

but task is already holding lock:
ffff88801e60ba88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_flushbuf block/ioctl.c:368 [inline]
ffff88801e60ba88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_common_ioctl+0x14e9/0x1ce0 block/ioctl.c:500

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&bdev->bd_holder_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       bdev_mark_dead+0x25/0x230 block/bdev.c:961
       disk_force_media_change+0x51/0x80 block/disk-events.c:303
       __loop_clr_fd+0x3ab/0x8f0 drivers/block/loop.c:1174
       lo_release+0x188/0x1c0 drivers/block/loop.c:1743
       blkdev_put_whole+0xa5/0xe0 block/bdev.c:663
       blkdev_put+0x40f/0x8e0 block/bdev.c:898
       kill_block_super+0x58/0x70 fs/super.c:1623
       kill_f2fs_super+0x2b7/0x3d0 fs/f2fs/super.c:4879
       deactivate_locked_super+0x9a/0x170 fs/super.c:481
       deactivate_super+0xde/0x100 fs/super.c:514
       cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
       task_work_run+0x14d/0x240 kernel/task_work.c:179
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
       exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
       __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
       syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
       do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       blkdev_get_by_dev.part.0+0x4f0/0xb20 block/bdev.c:786
       blkdev_get_by_dev+0x75/0x80 block/bdev.c:829
       journal_init_dev fs/reiserfs/journal.c:2626 [inline]
       journal_init+0xbb8/0x64b0 fs/reiserfs/journal.c:2786
       reiserfs_fill_super+0xcc6/0x3150 fs/reiserfs/super.c:2022
       mount_bdev+0x1f3/0x2e0 fs/super.c:1603
       legacy_get_tree+0x109/0x220 fs/fs_context.c:638
       vfs_get_tree+0x8c/0x370 fs/super.c:1724
       do_new_mount fs/namespace.c:3335 [inline]
       path_mount+0x1492/0x1ed0 fs/namespace.c:3662
       do_mount fs/namespace.c:3675 [inline]
       __do_sys_mount fs/namespace.c:3884 [inline]
       __se_sys_mount fs/namespace.c:3861 [inline]
       __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->s_umount_key#25){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       down_read+0x9c/0x470 kernel/locking/rwsem.c:1520
       __super_lock fs/super.c:58 [inline]
       super_lock+0x23c/0x380 fs/super.c:117
       super_lock_shared fs/super.c:146 [inline]
       super_lock_shared_active fs/super.c:1387 [inline]
       fs_bdev_sync+0x94/0x1b0 fs/super.c:1422
       blkdev_flushbuf block/ioctl.c:370 [inline]
       blkdev_common_ioctl+0x1550/0x1ce0 block/ioctl.c:500
       blkdev_ioctl+0x249/0x770 block/ioctl.c:622
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl fs/ioctl.c:857 [inline]
       __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &type->s_umount_key#25 --> &disk->open_mutex --> &bdev->bd_holder_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&bdev->bd_holder_lock);
                               lock(&disk->open_mutex);
                               lock(&bdev->bd_holder_lock);
  rlock(&type->s_umount_key#25);

 *** DEADLOCK ***

1 lock held by syz-executor.4/22893:
 #0: ffff88801e60ba88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_flushbuf block/ioctl.c:368 [inline]
 #0: ffff88801e60ba88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_common_ioctl+0x14e9/0x1ce0 block/ioctl.c:500

stack backtrace:
CPU: 1 PID: 22893 Comm: syz-executor.4 Not tainted 6.5.0-syzkaller-04808-g6c1b980a7e79 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 down_read+0x9c/0x470 kernel/locking/rwsem.c:1520
 __super_lock fs/super.c:58 [inline]
 super_lock+0x23c/0x380 fs/super.c:117
 super_lock_shared fs/super.c:146 [inline]
 super_lock_shared_active fs/super.c:1387 [inline]
 fs_bdev_sync+0x94/0x1b0 fs/super.c:1422
 blkdev_flushbuf block/ioctl.c:370 [inline]
 blkdev_common_ioctl+0x1550/0x1ce0 block/ioctl.c:500
 blkdev_ioctl+0x249/0x770 block/ioctl.c:622
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6f9f67cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6fa03670c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6f9f79bf80 RCX: 00007f6f9f67cae9
RDX: ffffffffffffffff RSI: 0000000000001261 RDI: 0000000000000003
RBP: 00007f6f9f6c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6f9f79bf80 R15: 00007ffc6e219ec8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
