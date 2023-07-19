Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7075965E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 15:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGSNRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 09:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGSNRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:17:06 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E05610FE
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 06:17:02 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3a1bcdd0966so11371343b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 06:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689772621; x=1692364621;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6lFA910N9h0oyRNdB+DDjKFQcuDyhT0urFndGAIdIc=;
        b=QbUERF9S9O/cCmS0rUCBHrux7gJSAgUaWKRM3FuGjtWW1KsJ8WBjTbYA/+SRY5R99W
         LGqZIaLrN7bK3e2T6rTmr6SEv513ZnFjhh3sou6d21i1RUtIeCUThI3Uf48ZWyHnJSul
         p9b0moK4N/Sca0NMD3PGAaibb5oYwssLAg23bWkxHkkvNX/j5WDKZ6cc+MpRUZmCkPOt
         M7glWHDhAHUwdvgPsHmLkkol4AVjNofCdB7XW1BMdnPf+egqxSCBiW4HOmsYk/aAEXJK
         lnmiZRIsy4KsgnKruchRQvSMiYS42MpCp3UpkqZwkP2e9AncYZ0+9aa80Y5pkxMstZ7W
         Rfsw==
X-Gm-Message-State: ABy/qLZjKp1WPm9Pi3AR88BOknvmd96+jHCxHSAnqg7nVaQ2wdigu2lT
        /VeotCZm6gKngBIQsnfK3SGVyNAF9VRG7mUxgLP+BmHbhOs/
X-Google-Smtp-Source: APBJJlFHeR0fZexDsIt3hsoU1LbQ5gb0xpWyzU8vCvjWKd9554M0rQxCNW8KO21sJ67HjDlUWwAnzGtYvHHbGIi9TuFac0WthJx2
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2190:b0:3a4:1082:9e5 with SMTP id
 be16-20020a056808219000b003a4108209e5mr28006410oib.2.1689772621644; Wed, 19
 Jul 2023 06:17:01 -0700 (PDT)
Date:   Wed, 19 Jul 2023 06:17:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd477c0600d6d815@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in lookup_slow (3)
From:   syzbot <syzbot+65459fd3b61877d717a3@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ccff6d117d8d Merge tag 'perf-tools-fixes-for-v6.5-1-2023-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b20fa2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e214fc8e043/disk-ccff6d11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0791f1cf1876/vmlinux-ccff6d11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92b6acf6a807/bzImage-ccff6d11.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65459fd3b61877d717a3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.5.0-rc2-syzkaller-00046-gccff6d117d8d #0 Not tainted
------------------------------------------------------
syz-executor.4/14533 is trying to acquire lock:
ffff888054161e80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:781 [inline]
ffff888054161e80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: lookup_slow+0x45/0x70 fs/namei.c:1706

but task is already holding lock:
ffff88804425e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x4f0 fs/kernfs/file.c:325

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&of->mutex){+.+.}-{3:3}:
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       kernfs_seq_start+0x53/0x3a0 fs/kernfs/file.c:154
       seq_read_iter+0x3d4/0xd10 fs/seq_file.c:225
       call_read_iter include/linux/fs.h:1865 [inline]
       new_sync_read fs/read_write.c:389 [inline]
       vfs_read+0x795/0xb00 fs/read_write.c:470
       ksys_read+0x1a0/0x2c0 fs/read_write.c:613
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       seq_read_iter+0xb2/0xd10 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:1865 [inline]
       copy_splice_read+0x4c9/0x9c0 fs/splice.c:367
       splice_direct_to_actor+0x2c4/0x9e0 fs/splice.c:1070
       do_splice_direct+0x2ac/0x3f0 fs/splice.c:1195
       do_sendfile+0x623/0x1070 fs/read_write.c:1254
       __do_sys_sendfile64 fs/read_write.c:1322 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (sb_writers#4){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1494 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1569
       mnt_want_write+0x3f/0x90 fs/namespace.c:403
       ovl_create_object+0xf8/0x300 fs/overlayfs/dir.c:629
       lookup_open fs/namei.c:3492 [inline]
       open_last_lookups fs/namei.c:3560 [inline]
       path_openat+0x13e7/0x3180 fs/namei.c:3790
       do_filp_open+0x234/0x490 fs/namei.c:3820
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
       do_sys_open fs/open.c:1422 [inline]
       __do_sys_openat fs/open.c:1438 [inline]
       __se_sys_openat fs/open.c:1433 [inline]
       __x64_sys_openat+0x247/0x290 fs/open.c:1433
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
       down_read+0x47/0x2f0 kernel/locking/rwsem.c:1520
       inode_lock_shared include/linux/fs.h:781 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1706
       walk_component+0x2d0/0x400 fs/namei.c:1998
       lookup_last fs/namei.c:2455 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2479
       filename_lookup+0x255/0x610 fs/namei.c:2508
       kern_path+0x3b/0x180 fs/namei.c:2606
       lookup_bdev+0xc5/0x290 block/bdev.c:943
       resume_store+0x19c/0x700 kernel/power/hibernate.c:1177
       kernfs_fop_write_iter+0x3a6/0x4f0 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:1871 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x782/0xaf0 fs/read_write.c:584
       ksys_write+0x1a0/0x2c0 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &ovl_i_mutex_dir_key[depth] --> &p->lock --> &of->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&of->mutex);
                               lock(&p->lock);
                               lock(&of->mutex);
  rlock(&ovl_i_mutex_dir_key[depth]);

 *** DEADLOCK ***

4 locks held by syz-executor.4/14533:
 #0: ffff88807cfc45c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x254/0x2f0 fs/file.c:1047
 #1: ffff88802d7ec410 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x216/0xaf0 fs/read_write.c:580
 #2: ffff88804425e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x4f0 fs/kernfs/file.c:325
 #3: ffff888019277e88 (kn->active#62){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x4f0 fs/kernfs/file.c:326

stack backtrace:
CPU: 0 PID: 14533 Comm: syz-executor.4 Not tainted 6.5.0-rc2-syzkaller-00046-gccff6d117d8d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x375/0x4a0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
 down_read+0x47/0x2f0 kernel/locking/rwsem.c:1520
 inode_lock_shared include/linux/fs.h:781 [inline]
 lookup_slow+0x45/0x70 fs/namei.c:1706
 walk_component+0x2d0/0x400 fs/namei.c:1998
 lookup_last fs/namei.c:2455 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2479
 filename_lookup+0x255/0x610 fs/namei.c:2508
 kern_path+0x3b/0x180 fs/namei.c:2606
 lookup_bdev+0xc5/0x290 block/bdev.c:943
 resume_store+0x19c/0x700 kernel/power/hibernate.c:1177
 kernfs_fop_write_iter+0x3a6/0x4f0 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:1871 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x782/0xaf0 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f538d87cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f538e5020c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f538d99bf80 RCX: 00007f538d87cb29
RDX: 0000000000000012 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007f538d8c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f538d99bf80 R15: 00007ffc07e8a938
 </TASK>
PM: Image not found (code -6)


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
