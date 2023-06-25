Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D612473D2C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jun 2023 19:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjFYRpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 13:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFYRpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 13:45:49 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5D18E
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 10:45:48 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-345ac144755so96145ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 10:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687715148; x=1690307148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMnS8yteeq908fCMk+lnJPrDlGNebwY4YZGBzDeFebs=;
        b=AOVP/bzJd0ht+AGlUSv0KU3E+anJN3y2tZDrQJkFNXqh38LlZbNdLFvsavrIZA8lSl
         YpFNYW1SKKkbKm6FB/M+nS7fB/QC9i4+yzlNO+28lChLIlXdkI0h1++skqE96orvxDgk
         kkE++d0ocuQhRqp3tPMaa7kw1m/2Cr8ggPqwKIIjQ8EFCev2bqjcY68H0WmAqu9oR4tt
         LbtuiY1fFHHmJW9YrjnvHJmrcB7CwXk1aqMf1xJ4xuz6fNgiQwTVcphq0SyRWx51TSih
         Y2w/BXeF5dO6GAjRcz53Et2geBQZduKSKzbKKKlA2TgU29sfq5zHUBhINVHPmc5n3ZIo
         jlPQ==
X-Gm-Message-State: AC+VfDxHdPayR68ZUonxM/G2fn06sPwyFpljfBm0WiliYHaZ6vhr3pBg
        1oiT2l7yLrWyw7t+jWEboh3HRBkSRNnP/M/gwoXO6m1BNgvE
X-Google-Smtp-Source: ACHHUZ7meTc6+Z+5poB65do2Ielys1kCaWw4bc2j1x7NcxiHnCpOClMs2a8om3mzT5+pT5aWWSWVhdcq3n7MnESuzK/B67HFQxgl
MIME-Version: 1.0
X-Received: by 2002:a92:d350:0:b0:345:a49a:32d7 with SMTP id
 a16-20020a92d350000000b00345a49a32d7mr608409ilh.5.1687715147862; Sun, 25 Jun
 2023 10:45:47 -0700 (PDT)
Date:   Sun, 25 Jun 2023 10:45:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ded70105fef7cd35@google.com>
Subject: [syzbot] [f2fs?] possible deadlock in f2fs_fiemap
From:   syzbot <syzbot+dd6352699b8027673b35@syzkaller.appspotmail.com>
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

HEAD commit:    15e71592dbae Add linux-next specific files for 20230621
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=101c827b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4e51841f618f374
dashboard link: https://syzkaller.appspot.com/bug?extid=dd6352699b8027673b35
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b6464ef4887/disk-15e71592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81eba5775318/vmlinux-15e71592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc7983587629/bzImage-15e71592.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd6352699b8027673b35@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 40427
F2FS-fs (loop4): Found nat_bits in checkpoint
F2FS-fs (loop4): Mounted with checkpoint version = 48b305e5
======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc7-next-20230621-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/7658 is trying to acquire lock:
ffff888012869e20 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0xb2/0x190 mm/memory.c:5716

but task is already holding lock:
ffff8880865b1a10 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
ffff8880865b1a10 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: f2fs_fiemap+0x1e3/0x1670 fs/f2fs/data.c:1998

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:771 [inline]
       f2fs_file_mmap+0x154/0x290 fs/f2fs/file.c:527
       call_mmap include/linux/fs.h:1876 [inline]
       mmap_region+0x6cf/0x2570 mm/mmap.c:2669
       do_mmap+0x850/0xee0 mm/mmap.c:1373
       vm_mmap_pgoff+0x1a2/0x3b0 mm/util.c:543
       ksys_mmap_pgoff+0x42b/0x5b0 mm/mmap.c:1419
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
       lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5761
       __might_fault mm/memory.c:5717 [inline]
       __might_fault+0x115/0x190 mm/memory.c:5710
       _copy_to_user+0x2b/0xc0 lib/usercopy.c:36
       copy_to_user include/linux/uaccess.h:191 [inline]
       fiemap_fill_next_extent+0x217/0x370 fs/ioctl.c:144
       f2fs_fiemap+0x5a5/0x1670 fs/f2fs/data.c:2066
       ioctl_fiemap fs/ioctl.c:219 [inline]
       do_vfs_ioctl+0x478/0x16c0 fs/ioctl.c:810
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x10c/0x210 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#23);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#23);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz-executor.4/7658:
 #0: ffff8880865b1a10 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
 #0: ffff8880865b1a10 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: f2fs_fiemap+0x1e3/0x1670 fs/f2fs/data.c:1998

stack backtrace:
CPU: 1 PID: 7658 Comm: syz-executor.4 Not tainted 6.4.0-rc7-next-20230621-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x2df/0x3b0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
 lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5761
 __might_fault mm/memory.c:5717 [inline]
 __might_fault+0x115/0x190 mm/memory.c:5710
 _copy_to_user+0x2b/0xc0 lib/usercopy.c:36
 copy_to_user include/linux/uaccess.h:191 [inline]
 fiemap_fill_next_extent+0x217/0x370 fs/ioctl.c:144
 f2fs_fiemap+0x5a5/0x1670 fs/f2fs/data.c:2066
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x478/0x16c0 fs/ioctl.c:810
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x10c/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3f8028c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3f81084168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3f803abf80 RCX: 00007f3f8028c389
RDX: 00000000200000c0 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00007f3f802d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe04349abf R14: 00007f3f81084300 R15: 0000000000022000
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
