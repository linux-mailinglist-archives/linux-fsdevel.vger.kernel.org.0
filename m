Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9368C6C372D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 17:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCUQmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCUQme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:42:34 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF24532BE
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 09:42:04 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id h19-20020a056e021d9300b00318f6b50475so7994490ila.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 09:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679416923;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHMca3wBCutZtAdQFZ/VNGTHdO3FijtlGJn+CEWok5o=;
        b=AzwJx3inSxdlPLkvUe7h4aYNeAN/EaTAeUdLN13cogHKVWcJmuG9MTfwlRF+SHej+7
         yKWSenGtYe2UtCegMtcKABqyBBqvnIWnB15JKMTozWDTg9q+3aHd9n5rcnPaNee9s8qI
         4lN0spHG6K/FCyN2gJx/Ssp+zqWDWyzkGlDyWoNYVHPcphXLnzrL0a+c3TDD5rdE7WVG
         m4x96hXPPCCRZU3QPbPtrYv9s4aC+Dq+GbQqRndyjdbMp39uisfb2D4esrtrXdozpIZj
         zz254zyW0VCS5ipbNtskNSItRUl/ND/smbdUSlOBzIP3xmP690AuSyJNuGdTLZv4jtDn
         F/4w==
X-Gm-Message-State: AO0yUKU3A9UK0mHgonVpOW1Ya7A5rVmSnkBsSs2qBcCcQiWBShRZzPYG
        sduc16Rg4BPPTi7PwfOhY4iBISODL2EtHg56NDbY2Wf7aoKL
X-Google-Smtp-Source: AK7set8cgc2X0LhzNhWl5jeVeMFe7l6Z2LjWJKoFKGMSUYyhMO/Rjc5Qt2rtYenkzDVceKJSUr91K2pBKtJpeZPqTYtlFhjIUUQE
MIME-Version: 1.0
X-Received: by 2002:a02:63c7:0:b0:3e5:a7d9:17f0 with SMTP id
 j190-20020a0263c7000000b003e5a7d917f0mr1294426jac.4.1679416923506; Tue, 21
 Mar 2023 09:42:03 -0700 (PDT)
Date:   Tue, 21 Mar 2023 09:42:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027d44f05f76bb96e@google.com>
Subject: [syzbot] [ntfs?] possible deadlock in ntfs_sync_mft_mirror
From:   syzbot <syzbot+c9340661f4a0bb3e7e65@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    17214b70a159 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d86d31c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cde06fe2cf5765b7
dashboard link: https://syzkaller.appspot.com/bug?extid=c9340661f4a0bb3e7e65
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9340661f4a0bb3e7e65@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc3-syzkaller-00012-g17214b70a159 #0 Not tainted
------------------------------------------------------
kworker/u8:1/10 is trying to acquire lock:
ffff8880722f1840 (&rl->lock){++++}-{3:3}, at: ntfs_sync_mft_mirror+0x18bf/0x1ea0 fs/ntfs/mft.c:536

but task is already holding lock:
ffff8880723aa290 (&ni->mrec_lock){+.+.}-{3:3}, at: map_mft_record+0x40/0x6c0 fs/ntfs/mft.c:154

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->mrec_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       map_mft_record+0x40/0x6c0 fs/ntfs/mft.c:154
       ntfs_truncate+0x243/0x2a50 fs/ntfs/inode.c:2383
       ntfs_truncate_vfs fs/ntfs/inode.c:2862 [inline]
       ntfs_setattr+0x397/0x560 fs/ntfs/inode.c:2914
       notify_change+0xb2c/0x1180 fs/attr.c:482
       do_truncate+0x143/0x200 fs/open.c:66
       handle_truncate fs/namei.c:3219 [inline]
       do_open fs/namei.c:3564 [inline]
       path_openat+0x2083/0x2750 fs/namei.c:3715
       do_filp_open+0x1ba/0x410 fs/namei.c:3742
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1348
       do_sys_open fs/open.c:1364 [inline]
       __do_sys_creat fs/open.c:1440 [inline]
       __se_sys_creat fs/open.c:1434 [inline]
       __x64_sys_creat+0xcd/0x120 fs/open.c:1434
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&rl->lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       ntfs_sync_mft_mirror+0x18bf/0x1ea0 fs/ntfs/mft.c:536
       write_mft_record_nolock+0x198e/0x1cc0 fs/ntfs/mft.c:787
       write_mft_record+0x14e/0x3b0 fs/ntfs/mft.h:95
       __ntfs_write_inode+0x915/0xc40 fs/ntfs/inode.c:3050
       write_inode fs/fs-writeback.c:1453 [inline]
       __writeback_single_inode+0x9f8/0xdc0 fs/fs-writeback.c:1665
       writeback_sb_inodes+0x54d/0xe70 fs/fs-writeback.c:1891
       wb_writeback+0x294/0xa50 fs/fs-writeback.c:2065
       wb_do_writeback fs/fs-writeback.c:2208 [inline]
       wb_workfn+0x2a5/0xfc0 fs/fs-writeback.c:2248
       process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
       worker_thread+0x669/0x1090 kernel/workqueue.c:2537
       kthread+0x2e8/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->mrec_lock);
                               lock(&rl->lock);
                               lock(&ni->mrec_lock);
  lock(&rl->lock);

 *** DEADLOCK ***

3 locks held by kworker/u8:1/10:
 #0: ffff888015421938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888015421938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888015421938 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888015421938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:639 [inline]
 #0: ffff888015421938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:666 [inline]
 #0: ffff888015421938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x87a/0x15c0 kernel/workqueue.c:2361
 #1: ffffc900004cfda8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x15c0 kernel/workqueue.c:2365
 #2: ffff8880723aa290 (&ni->mrec_lock){+.+.}-{3:3}, at: map_mft_record+0x40/0x6c0 fs/ntfs/mft.c:154

stack backtrace:
CPU: 0 PID: 10 Comm: kworker/u8:1 Not tainted 6.3.0-rc3-syzkaller-00012-g17214b70a159 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: writeback wb_workfn (flush-7:2)
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
 lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
 down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
 ntfs_sync_mft_mirror+0x18bf/0x1ea0 fs/ntfs/mft.c:536
 write_mft_record_nolock+0x198e/0x1cc0 fs/ntfs/mft.c:787
 write_mft_record+0x14e/0x3b0 fs/ntfs/mft.h:95
 __ntfs_write_inode+0x915/0xc40 fs/ntfs/inode.c:3050
 write_inode fs/fs-writeback.c:1453 [inline]
 __writeback_single_inode+0x9f8/0xdc0 fs/fs-writeback.c:1665
 writeback_sb_inodes+0x54d/0xe70 fs/fs-writeback.c:1891
 wb_writeback+0x294/0xa50 fs/fs-writeback.c:2065
 wb_do_writeback fs/fs-writeback.c:2208 [inline]
 wb_workfn+0x2a5/0xfc0 fs/fs-writeback.c:2248
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
