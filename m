Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96A8716AB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 19:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjE3RVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjE3RVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:02 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D186A3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 10:20:57 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-763997ab8cdso660916939f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 10:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685467256; x=1688059256;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RoI4PndI5mS+7NVQVinwhSwL+K74gYdL70viuIrUJM=;
        b=lbd1/OTGRB/pw1Y7yaBXVmzxFdgM0w9s7xqES15JJmsKMlWVnpcJrDf/BLpAqItyoF
         fX6YxCn3d29IDM2gskIRqgI9osQF/yAinbKrGoXS8pGJBhCOXddj6c3VqzD7COt6BfhD
         2xn3XUCHhZA/8SqQ5Y/eVvz1ytll5/BMuUnLpl4oX+c3cJ+Q7Q+Iw8umGnQbDowz+ZX+
         juPkAgZ0TZqJi/g4W9vuoZdAxWQ/PebaEIKk6KbKZo8I1xb53qYj1k4sJl0t2ysWyVyN
         UktXLo477kzwwHENKkI5qQePaam/1Hv2VBdwoXKK07U/Co1kirnRG68+Qu1uQH6Z6QRv
         L7RA==
X-Gm-Message-State: AC+VfDx4+V9mxbLbryMjs1Mr/vvUrRXQiFrjrNwGid3URtu5Fq7ISf7o
        UMcw4CvvWlkA+dTVJgxd6qPIewwk6ER1ajmMtvnvgYjzQjwc8r4qNw==
X-Google-Smtp-Source: ACHHUZ529Fqq1//KVvRKEvEF7TiTZVOgu3Obdoq/hF5y3eaObUyzzXHIQj041V5HO0PDjyYfPUWYJwtwuUJZ4QMsAVoHC4JdaBOc
MIME-Version: 1.0
X-Received: by 2002:a5e:9816:0:b0:774:8f36:bb8e with SMTP id
 s22-20020a5e9816000000b007748f36bb8emr1359890ioj.2.1685467256572; Tue, 30 May
 2023 10:20:56 -0700 (PDT)
Date:   Tue, 30 May 2023 10:20:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bd66b05fcec6d92@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in vfs_setxattr (2)
From:   syzbot <syzbot+c98692bac73aedb459c3@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eb0f1697d729 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1545e64d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8860074b9a9d6c45
dashboard link: https://syzkaller.appspot.com/bug?extid=c98692bac73aedb459c3
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/034232da7cff/disk-eb0f1697.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b11411bec33e/vmlinux-eb0f1697.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a53c52e170dd/Image-eb0f1697.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c98692bac73aedb459c3@syzkaller.appspotmail.com

reiserfs: enabling write barrier flush mode
REISERFS (device loop5): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc3-syzkaller-geb0f1697d729 #0 Not tainted
------------------------------------------------------
syz-executor.5/11246 is trying to acquire lock:
ffff0000e040a400 (&type->i_mutex_dir_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
ffff0000e040a400 (&type->i_mutex_dir_key#10){+.+.}-{3:3}, at: vfs_setxattr+0x17c/0x344 fs/xattr.c:321

but task is already holding lock:
ffff000113b8a460 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write_file+0x64/0x1e8 fs/namespace.c:438

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#12){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1494 [inline]
       sb_start_write+0x60/0x2ec include/linux/fs.h:1569
       mnt_want_write_file+0x64/0x1e8 fs/namespace.c:438
       reiserfs_ioctl+0x184/0x454 fs/reiserfs/ioctl.c:103
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:856
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

-> #1 (&sbi->lock){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x7c/0xe8 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x128/0x45c fs/reiserfs/namei.c:364
       __lookup_slow+0x250/0x374 fs/namei.c:1690
       lookup_one_len+0x178/0x28c fs/namei.c:2742
       reiserfs_lookup_privroot+0x8c/0x184 fs/reiserfs/xattr.c:976
       reiserfs_fill_super+0x15b4/0x2028 fs/reiserfs/super.c:2192
       mount_bdev+0x26c/0x368 fs/super.c:1380
       get_super_block+0x44/0x58 fs/reiserfs/super.c:2601
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
       vfs_get_tree+0x90/0x274 fs/super.c:1510
       do_new_mount+0x25c/0x8c8 fs/namespace.c:3039
       path_mount+0x590/0xe04 fs/namespace.c:3369
       do_mount fs/namespace.c:3382 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3568
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

-> #0 (&type->i_mutex_dir_key#10){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain kernel/locking/lockdep.c:3842 [inline]
       __lock_acquire+0x3310/0x75f0 kernel/locking/lockdep.c:5074
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5691
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:775 [inline]
       vfs_setxattr+0x17c/0x344 fs/xattr.c:321
       do_setxattr fs/xattr.c:630 [inline]
       setxattr+0x208/0x29c fs/xattr.c:653
       __do_sys_fsetxattr fs/xattr.c:709 [inline]
       __se_sys_fsetxattr fs/xattr.c:698 [inline]
       __arm64_sys_fsetxattr+0x1a8/0x224 fs/xattr.c:698
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#10 --> &sbi->lock --> sb_writers#12

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#12);
                               lock(&sbi->lock);
                               lock(sb_writers#12);
  lock(&type->i_mutex_dir_key#10);

 *** DEADLOCK ***

1 lock held by syz-executor.5/11246:
 #0: ffff000113b8a460 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write_file+0x64/0x1e8 fs/namespace.c:438

stack backtrace:
CPU: 0 PID: 11246 Comm: syz-executor.5 Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2066
 check_noncircular+0x2cc/0x378 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain kernel/locking/lockdep.c:3842 [inline]
 __lock_acquire+0x3310/0x75f0 kernel/locking/lockdep.c:5074
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5691
 down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:775 [inline]
 vfs_setxattr+0x17c/0x344 fs/xattr.c:321
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x208/0x29c fs/xattr.c:653
 __do_sys_fsetxattr fs/xattr.c:709 [inline]
 __se_sys_fsetxattr fs/xattr.c:698 [inline]
 __arm64_sys_fsetxattr+0x1a8/0x224 fs/xattr.c:698
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
