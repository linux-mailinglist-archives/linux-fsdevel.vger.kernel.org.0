Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE2718A37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 21:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjEaTdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 15:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjEaTdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 15:33:02 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE2D139
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 12:32:56 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7603d830533so22417739f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 12:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685561576; x=1688153576;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LyvodTfh7mDgMBZGR3/haPvA2HxKEHZOZ0+VgxD6Y4=;
        b=VBoe1uZT10243Cyfm+ZHxdkeLmdp3i78xv+B7zMJTsm/QgMhi95lP4sVN+yZa3TmlX
         VTzLT44qp++skAAfcxL54sdN10cNKR/yd9PwsFprh+bqwjBik3Xp6IPz5ulc4DdNYJnG
         43CAXdvWUVpNDRLacL8E3xZpq/JVjY034eITZith59mT91vF/7/PKOKr5ZIAdURalbZM
         QHZpzGpmd5+CPg348P/hKxllrUo9uulwTApsyvpgIAg5oHXD6aHYqBAc6awaoAFSMRQi
         mybMrPLNsbKSCaS5w1Y4mwhTE41FqPfvx7C+VKm3kHew/ALk+3Mhml4jgVx166ctOwsl
         xeVQ==
X-Gm-Message-State: AC+VfDwdGZ9bt7JaLMp8TUApZ35RC8OzUq7QqUrrcAmiR0lixRBWLCQj
        jZs4fB1S+BQko2LnPQFtpoGAgbEA9zosngnYYTPXq8jVyNUF
X-Google-Smtp-Source: ACHHUZ5jv021XOgfOmq2aWrpQjH44Z2mlMPVF3tsbqSe9rSHM0VGb8lHM0mbMioaRhKeGdvtvtiOAGCEyC7PcAbh+r+qAtks5PTd
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3713:b0:774:8680:b95b with SMTP id
 bh19-20020a056602371300b007748680b95bmr8079663iob.1.1685561575975; Wed, 31
 May 2023 12:32:55 -0700 (PDT)
Date:   Wed, 31 May 2023 12:32:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbaee205fd026244@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in mark_as_free_ex
From:   syzbot <syzbot+e94d98936a0ed08bde43@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    48b1320a674e Merge tag 'for-6.4-rc4-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ccb25d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=e94d98936a0ed08bde43
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1bdd53056bc4/disk-48b1320a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82950e95464f/vmlinux-48b1320a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a58eb21a7a7/bzImage-48b1320a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e94d98936a0ed08bde43@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc4-syzkaller-00051-g48b1320a674e #0 Not tainted
------------------------------------------------------
kworker/u4:0/15666 is trying to acquire lock:
ffff88802d146268 (&wnd->rw_lock){++++}-{3:3}, at: mark_as_free_ex+0x3d/0x330 fs/ntfs3/fsntfs.c:2464

but task is already holding lock:
ffff88804bad60e0 (&ni->ni_lock){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
ffff88804bad60e0 (&ni->ni_lock){+.+.}-{3:3}, at: ni_write_inode+0x167/0x10c0 fs/ntfs3/frecord.c:3252

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->ni_lock){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5705
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       ntfs_set_state+0x212/0x730 fs/ntfs3/fsntfs.c:945
       mark_as_free_ex+0x6e/0x330 fs/ntfs3/fsntfs.c:2466
       run_deallocate_ex+0x244/0x5f0 fs/ntfs3/attrib.c:122
       attr_set_size+0x1684/0x4290 fs/ntfs3/attrib.c:750
       ntfs_truncate fs/ntfs3/file.c:393 [inline]
       ntfs3_setattr+0x556/0xb00 fs/ntfs3/file.c:682
       notify_change+0xc8b/0xf40 fs/attr.c:483
       do_truncate+0x220/0x300 fs/open.c:66
       handle_truncate fs/namei.c:3295 [inline]
       do_open fs/namei.c:3640 [inline]
       path_openat+0x294e/0x3170 fs/namei.c:3791
       do_filp_open+0x234/0x490 fs/namei.c:3818
       do_sys_openat2+0x13f/0x500 fs/open.c:1356
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_creat fs/open.c:1448 [inline]
       __se_sys_creat fs/open.c:1442 [inline]
       __x64_sys_creat+0x123/0x160 fs/open.c:1442
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&wnd->rw_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain+0x166b/0x58f0 kernel/locking/lockdep.c:3847
       __lock_acquire+0x1316/0x2070 kernel/locking/lockdep.c:5088
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5705
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
       mark_as_free_ex+0x3d/0x330 fs/ntfs3/fsntfs.c:2464
       run_deallocate+0x13b/0x230 fs/ntfs3/fsntfs.c:2534
       ni_try_remove_attr_list+0x1558/0x1930 fs/ntfs3/frecord.c:773
       ni_write_inode+0xd14/0x10c0 fs/ntfs3/frecord.c:3318
       write_inode fs/fs-writeback.c:1456 [inline]
       __writeback_single_inode+0x69b/0xfa0 fs/fs-writeback.c:1668
       writeback_sb_inodes+0x8e3/0x11d0 fs/fs-writeback.c:1894
       wb_writeback+0x458/0xc70 fs/fs-writeback.c:2068
       wb_do_writeback fs/fs-writeback.c:2211 [inline]
       wb_workfn+0x400/0xff0 fs/fs-writeback.c:2251
       process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2405
       worker_thread+0xa63/0x1210 kernel/workqueue.c:2552
       kthread+0x2b8/0x350 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock);
                               lock(&wnd->rw_lock);
                               lock(&ni->ni_lock);
  lock(&wnd->rw_lock);

 *** DEADLOCK ***

3 locks held by kworker/u4:0/15666:
 #0: ffff888019e63938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x77e/0x10e0 kernel/workqueue.c:2378
 #1: ffffc9000ae5fd20 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x7c8/0x10e0 kernel/workqueue.c:2380
 #2: ffff88804bad60e0 (&ni->ni_lock){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
 #2: ffff88804bad60e0 (&ni->ni_lock){+.+.}-{3:3}, at: ni_write_inode+0x167/0x10c0 fs/ntfs3/frecord.c:3252

stack backtrace:
CPU: 1 PID: 15666 Comm: kworker/u4:0 Not tainted 6.4.0-rc4-syzkaller-00051-g48b1320a674e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Workqueue: writeback wb_workfn (flush-7:2)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain+0x166b/0x58f0 kernel/locking/lockdep.c:3847
 __lock_acquire+0x1316/0x2070 kernel/locking/lockdep.c:5088
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5705
 down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
 mark_as_free_ex+0x3d/0x330 fs/ntfs3/fsntfs.c:2464
 run_deallocate+0x13b/0x230 fs/ntfs3/fsntfs.c:2534
 ni_try_remove_attr_list+0x1558/0x1930 fs/ntfs3/frecord.c:773
 ni_write_inode+0xd14/0x10c0 fs/ntfs3/frecord.c:3318
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0x69b/0xfa0 fs/fs-writeback.c:1668
 writeback_sb_inodes+0x8e3/0x11d0 fs/fs-writeback.c:1894
 wb_writeback+0x458/0xc70 fs/fs-writeback.c:2068
 wb_do_writeback fs/fs-writeback.c:2211 [inline]
 wb_workfn+0x400/0xff0 fs/fs-writeback.c:2251
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2405
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2552
 kthread+0x2b8/0x350 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
BTRFS info (device loop3): qgroup scan completed (inconsistency flag cleared)


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
