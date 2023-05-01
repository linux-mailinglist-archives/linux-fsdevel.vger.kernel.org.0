Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E756F34E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjEAROu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjEARLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:11:34 -0400
Received: from mail-il1-x14d.google.com (mail-il1-x14d.google.com [IPv6:2607:f8b0:4864:20::14d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E373B2681
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 10:09:09 -0700 (PDT)
Received: by mail-il1-x14d.google.com with SMTP id e9e14a558f8ab-32a86b6ab85so16163155ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 10:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960819; x=1685552819;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yu+xZYmt+R/b0iytkvmQxEh5KQSPGy0cMwq8ICzHwY=;
        b=X64mWteyNI0/uNxB9ZCxSK9uR4a7oAInxvAW1YQAlsM+cwoMX3y0F4VmTHTpzAkI1y
         3WMk9+N9Sex5w6+Bu1WSYFFE1Cj15vLg0KHCA0TT0x3y0g92B8zfsN4cho0cv6+pnMXp
         iNoKSEZO0oMxntlu54WC+6P2GbQQXNd0AoMR/D6dzBuvGWWW4sWD3Mxff2X7E31V2Jy2
         2fvV1QbHGUFPzTQ/V2Fp07uU33rTzq1d6I6rIYAdmtohMlH9HZWYhIMDsxWvn4IP4KI2
         6vox190fEGJPYh/VXK9E8qxhR/pJuNySgDgtE+IoctvaNvya3c0CI34rpQAGTpF7KH7R
         rGfQ==
X-Gm-Message-State: AC+VfDx9Gioip1iGsVubtae++3n0sm2SMslYLjHDoZOjbFNCZHlCfXUZ
        tUw/136HEEd6xgQMqA0OtkYLCs0LYMNIravv/7DeVIryRrvt
X-Google-Smtp-Source: ACHHUZ6Pwj9qMgUzCKC3UCLlDtadHFChfBAR4VWBNArE7BJthBACaKFXlhA6LPbhyVHvFsqzs2nq02ImwzbBVFE9Laf9gzCvgs4e
MIME-Version: 1.0
X-Received: by 2002:a02:a1de:0:b0:40f:a98f:6aec with SMTP id
 o30-20020a02a1de000000b0040fa98f6aecmr5211924jah.1.1682960819133; Mon, 01 May
 2023 10:06:59 -0700 (PDT)
Date:   Mon, 01 May 2023 10:06:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbb5f505faa4d920@google.com>
Subject: [syzbot] [f2fs?] possible deadlock in f2fs_release_file
From:   syzbot <syzbot+e5b81eaab292e00e7d98@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot found the following issue on:

HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fc7ef7c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=e5b81eaab292e00e7d98
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60130779f509/disk-58390c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7f0cdd29b71/vmlinux-58390c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/de415ad52ae4/bzImage-58390c8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5b81eaab292e00e7d98@syzkaller.appspotmail.com

syz-executor.0: attempt to access beyond end of device
loop0: rw=2049, sector=77824, nr_sectors = 2048 limit=63271
syz-executor.0: attempt to access beyond end of device
loop0: rw=2049, sector=79872, nr_sectors = 2048 limit=63271
======================================================
WARNING: possible circular locking dependency detected
6.3.0-syzkaller-12049-g58390c8ce1bd #0 Not tainted
------------------------------------------------------
syz-executor.0/7526 is trying to acquire lock:
ffff8880366c9bd8 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
ffff8880366c9bd8 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}, at: f2fs_release_file+0x9b/0x100 fs/f2fs/file.c:1866

but task is already holding lock:
ffff888037e0c448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
ffff888037e0c448 (&sbi->node_write){++++}-{3:3}, at: f2fs_write_single_data_page+0xa10/0x1d50 fs/f2fs/data.c:2842

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->node_write){++++}-{3:3}:
       reacquire_held_locks+0x3aa/0x660 kernel/locking/lockdep.c:5216
       __lock_release kernel/locking/lockdep.c:5405 [inline]
       lock_release+0x36f/0x9d0 kernel/locking/lockdep.c:5711
       up_write+0x79/0x580 kernel/locking/rwsem.c:1625
       f2fs_write_checkpoint+0x13a4/0x1f90 fs/f2fs/checkpoint.c:1651
       __write_checkpoint_sync fs/f2fs/checkpoint.c:1768 [inline]
       __checkpoint_and_complete_reqs+0xda/0x3b0 fs/f2fs/checkpoint.c:1787
       issue_checkpoint_thread+0xda/0x260 fs/f2fs/checkpoint.c:1818
       kthread+0x2b8/0x350 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #1 (&sbi->cp_rwsem){++++}-{3:3}:
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
       f2fs_lock_op fs/f2fs/f2fs.h:2130 [inline]
       f2fs_convert_inline_inode+0x578/0x800 fs/f2fs/inline.c:218
       f2fs_setattr+0xb0c/0x1270 fs/f2fs/file.c:995
       notify_change+0xc8b/0xf40 fs/attr.c:483
       do_truncate+0x220/0x300 fs/open.c:66
       do_sys_ftruncate+0x2e4/0x380 fs/open.c:194
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3842
       __lock_acquire+0x1295/0x2000 kernel/locking/lockdep.c:5074
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:775 [inline]
       f2fs_release_file+0x9b/0x100 fs/f2fs/file.c:1866
       __fput+0x3b7/0x890 fs/file_table.c:321
       task_work_run+0x24a/0x300 kernel/task_work.c:179
       get_signal+0x1606/0x17e0 kernel/signal.c:2650
       arch_do_signal_or_restart+0x91/0x670 arch/x86/kernel/signal.c:306
       exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
       exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
       __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
       syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
       do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#29 --> &sbi->cp_rwsem --> &sbi->node_write

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sbi->node_write);
                               lock(&sbi->cp_rwsem);
                               lock(&sbi->node_write);
  lock(&sb->s_type->i_mutex_key#29);

 *** DEADLOCK ***

1 lock held by syz-executor.0/7526:
 #0: ffff888037e0c448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
 #0: ffff888037e0c448 (&sbi->node_write){++++}-{3:3}, at: f2fs_write_single_data_page+0xa10/0x1d50 fs/f2fs/data.c:2842

stack backtrace:
CPU: 1 PID: 7526 Comm: syz-executor.0 Not tainted 6.3.0-syzkaller-12049-g58390c8ce1bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3842
 __lock_acquire+0x1295/0x2000 kernel/locking/lockdep.c:5074
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:775 [inline]
 f2fs_release_file+0x9b/0x100 fs/f2fs/file.c:1866
 __fput+0x3b7/0x890 fs/file_table.c:321
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 get_signal+0x1606/0x17e0 kernel/signal.c:2650
 arch_do_signal_or_restart+0x91/0x670 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9fbc28c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9fbd007168 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: fffffffffffffffb RBX: 00007f9fbc3abf80 RCX: 00007f9fbc28c169
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 00007f9fbc2e7ca1 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000001400 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc6d012c3f R14: 00007f9fbd007300 R15: 0000000000022000
 </TASK>


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
