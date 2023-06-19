Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E51735B17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjFSPZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjFSPYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:24:50 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8710D
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 08:24:47 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-341de9586d4so30567415ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 08:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188287; x=1689780287;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dd9mLnsTgoIMT3DnkpH3y2thLKhOTY9gRQ8MaRlhcyY=;
        b=XKPTpppca0gCCgKzdkDLv90/76198YACOxhwzeCQxXQSdbpnjML0nGRFGAb4HF0kK+
         AY8mDQzYnd79I94RGDbUcSXdRWVouSUaXvlGB9vFQVCLZXfkEZaUxWjqFrbFk9DT7jd2
         sWFj5LA6vylrIgAgCP7AgkC+N7g5O2L1YtSfHCNLMzsgVpWjr5hsM828AvscbmPqDsED
         jIVOqGmdeA8PLY9ugYXFrpUAtM7iWM7XjikM6gZuFmHtZZBIBbxIx7b+aGbGfzUG3j3f
         LK795hYZYl99WWH28shxt0ZQhKdDV6P993tr49g97nOuch8FSmkQjwichcXn4kS/zv4L
         G3bw==
X-Gm-Message-State: AC+VfDxZsK4lW9GHJdoZLkQNGTk3SCH3AzOauXfE+QEXRkdsCB+RMBFx
        4Drca8V6rzJFmT2UNmwmTzsRuCBlcyaJRG7wjEN6yX3qqIaEO6sV9A==
X-Google-Smtp-Source: ACHHUZ78A6gGKmXn+JLgBm1Cp8SVfVMxu4juCBP2/hsbcEcaXcVbAIwcZJoZXZTWK1vTwS9MlBZse2MePa++xLq0ej/4kjY4tALQ
MIME-Version: 1.0
X-Received: by 2002:a92:d4ce:0:b0:331:3c0d:5a20 with SMTP id
 o14-20020a92d4ce000000b003313c0d5a20mr2996028ilm.0.1687188287205; Mon, 19 Jun
 2023 08:24:47 -0700 (PDT)
Date:   Mon, 19 Jun 2023 08:24:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000873a0f05fe7d2229@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in vfs_removexattr
From:   syzbot <syzbot+309478c06ab5fcc08e1f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    f86b85033b8c Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11590ef7280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd4213541e5ab26f
dashboard link: https://syzkaller.appspot.com/bug?extid=309478c06ab5fcc08e1f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b1a81c2e44b/disk-f86b8503.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2cda1b607bbd/vmlinux-f86b8503.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fcac528565e1/Image-f86b8503.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+309478c06ab5fcc08e1f@syzkaller.appspotmail.com

REISERFS (device loop2): using 3.5.x disk format
REISERFS warning (device loop2): jdm-13090 reiserfs_new_inode: ACLs aren't enabled in the fs, but vfs thinks they are!
REISERFS (device loop2): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc5-syzkaller-gf86b85033b8c #0 Not tainted
------------------------------------------------------
syz-executor.2/7662 is trying to acquire lock:
ffff00012da302e0 (&type->i_mutex_dir_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
ffff00012da302e0 (&type->i_mutex_dir_key#15){+.+.}-{3:3}, at: vfs_removexattr+0xcc/0x23c fs/xattr.c:575

but task is already holding lock:
ffff0000da4de460 (sb_writers#23){.+.+}-{0:0}, at: mnt_want_write_file+0x64/0x1e8 fs/namespace.c:438

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#23){.+.+}-{0:0}:
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
       el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
       el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
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
       mount_bdev+0x274/0x370 fs/super.c:1380
       get_super_block+0x44/0x58 fs/reiserfs/super.c:2601
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
       vfs_get_tree+0x90/0x274 fs/super.c:1510
       do_new_mount+0x25c/0x8c4 fs/namespace.c:3039
       path_mount+0x590/0xe04 fs/namespace.c:3369
       do_mount fs/namespace.c:3382 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3568
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
       el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

-> #0 (&type->i_mutex_dir_key#15){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x3308/0x7604 kernel/locking/lockdep.c:5088
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5705
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:775 [inline]
       vfs_removexattr+0xcc/0x23c fs/xattr.c:575
       removexattr+0x148/0x1c4 fs/xattr.c:918
       __do_sys_fremovexattr fs/xattr.c:965 [inline]
       __se_sys_fremovexattr fs/xattr.c:955 [inline]
       __arm64_sys_fremovexattr+0x14c/0x1c4 fs/xattr.c:955
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
       el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#15 --> &sbi->lock --> sb_writers#23

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#23);
                               lock(&sbi->lock);
                               lock(sb_writers#23);
  lock(&type->i_mutex_dir_key#15);

 *** DEADLOCK ***

1 lock held by syz-executor.2/7662:
 #0: ffff0000da4de460 (sb_writers#23){.+.+}-{0:0}, at: mnt_want_write_file+0x64/0x1e8 fs/namespace.c:438

stack backtrace:
CPU: 1 PID: 7662 Comm: syz-executor.2 Not tainted 6.4.0-rc5-syzkaller-gf86b85033b8c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2066
 check_noncircular+0x2cc/0x378 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain kernel/locking/lockdep.c:3847 [inline]
 __lock_acquire+0x3308/0x7604 kernel/locking/lockdep.c:5088
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5705
 down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:775 [inline]
 vfs_removexattr+0xcc/0x23c fs/xattr.c:575
 removexattr+0x148/0x1c4 fs/xattr.c:918
 __do_sys_fremovexattr fs/xattr.c:965 [inline]
 __se_sys_fremovexattr fs/xattr.c:955 [inline]
 __arm64_sys_fremovexattr+0x14c/0x1c4 fs/xattr.c:955
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
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
