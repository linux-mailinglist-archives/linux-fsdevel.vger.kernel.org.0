Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BD8758C14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 05:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjGSD1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 23:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjGSD0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:26:38 -0400
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A776326AC
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 20:26:08 -0700 (PDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1b773df6216so9576396fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 20:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689737166; x=1692329166;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAktzDOC7KpSEUrH3Ss7lVoNi/hKqFvUDurD5dZ1Lyo=;
        b=CrAX/DGtFgL65QkW3+zD2+HJ/wj6pgT1eMwmWcdU5RQr0gfelWg3T548S1HwpAp7nm
         vB0qBFzF6W5BzVRhqmiXEPEhpS8mBQN6usNWekLYd3K5mv/Rj40OEips0KtNaYbVoBb9
         Wd6urG6POnzJEAvBSJ8thuVB+7deaL9nOmDKU+m8TzjUsshr30gh6FQpflZbzf8bgPr4
         3EC4MSl5+Nk4cc6XVfmTuB8v62eu46GXG+9XPnA46Wd5+65fcM2+MjtISIRcxcBeWsbk
         IRpaTb6fzuBr9iCBq/hVNOLQciZyZ7GFNLliUD3EPkBtrpV9z3KnVX/a97Ujkw6KH97u
         fWcQ==
X-Gm-Message-State: ABy/qLbXgcxKMDMhc5OxwTodHt341DK1HtSNdDccRtodfHqJWexmMBFo
        yBGlUAFOo8igYqdmSPwR9rRxV4V9D1mgdOCqtMWBTQ5z9d0j
X-Google-Smtp-Source: APBJJlEM0r5s9bd2eq/hYzdvUeB+7RwYdshv1kF0G7KfFhOAmMoLmT/TiDVQENW+hKXEiZvalO6NFkAyeulkzQb9yXvo0eFawUDT
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1a90:b0:1b0:3fac:f557 with SMTP id
 ef16-20020a0568701a9000b001b03facf557mr15900503oab.10.1689737165941; Tue, 18
 Jul 2023 20:26:05 -0700 (PDT)
Date:   Tue, 18 Jul 2023 20:26:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a30ff0600ce97dd@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in walk_component (2)
From:   syzbot <syzbot+39acbe8ff4cab0acdb9d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
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

HEAD commit:    2772d7df3c93 Merge tag 'riscv-for-linus-6.5-rc2' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16849b0aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6769a69bd0e144b4
dashboard link: https://syzkaller.appspot.com/bug?extid=39acbe8ff4cab0acdb9d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/feba8b35b0b4/disk-2772d7df.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2300fb3a26e/vmlinux-2772d7df.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e07347f5489/bzImage-2772d7df.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39acbe8ff4cab0acdb9d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.5.0-rc1-syzkaller-00201-g2772d7df3c93 #0 Not tainted
------------------------------------------------------
syz-executor.3/28959 is trying to acquire lock:
ffff8880340fa450 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:781 [inline]
ffff8880340fa450 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: lookup_slow fs/namei.c:1706 [inline]
ffff8880340fa450 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: walk_component+0x33b/0x5a0 fs/namei.c:1998

but task is already holding lock:
ffff888062425488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x610 fs/kernfs/file.c:325

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&of->mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       kernfs_seq_start+0x4b/0x460 fs/kernfs/file.c:154
       seq_read_iter+0x2ad/0x1280 fs/seq_file.c:225
       kernfs_fop_read_iter+0x4c8/0x680 fs/kernfs/file.c:279
       call_read_iter include/linux/fs.h:1865 [inline]
       new_sync_read fs/read_write.c:389 [inline]
       vfs_read+0x4e0/0x930 fs/read_write.c:470
       ksys_read+0x12f/0x250 fs/read_write.c:613
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       seq_read_iter+0xda/0x1280 fs/seq_file.c:182
       proc_reg_read_iter+0x211/0x300 fs/proc/inode.c:305
       call_read_iter include/linux/fs.h:1865 [inline]
       copy_splice_read+0x418/0x8f0 fs/splice.c:367
       vfs_splice_read fs/splice.c:994 [inline]
       vfs_splice_read+0x2c8/0x3b0 fs/splice.c:963
       splice_direct_to_actor+0x2a5/0xa30 fs/splice.c:1070
       do_splice_direct+0x1af/0x280 fs/splice.c:1195
       do_sendfile+0xb88/0x1390 fs/read_write.c:1254
       __do_sys_sendfile64 fs/read_write.c:1322 [inline]
       __se_sys_sendfile64 fs/read_write.c:1308 [inline]
       __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (sb_writers#4){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1494 [inline]
       sb_start_write include/linux/fs.h:1569 [inline]
       mnt_want_write+0x6f/0x440 fs/namespace.c:403
       ovl_create_object+0x9e/0x2a0 fs/overlayfs/dir.c:629
       lookup_open.isra.0+0x1049/0x1360 fs/namei.c:3492
       open_last_lookups fs/namei.c:3560 [inline]
       path_openat+0x931/0x29c0 fs/namei.c:3790
       do_filp_open+0x1de/0x430 fs/namei.c:3820
       do_sys_openat2+0x176/0x1e0 fs/open.c:1407
       do_sys_open fs/open.c:1422 [inline]
       __do_sys_openat fs/open.c:1438 [inline]
       __se_sys_openat fs/open.c:1433 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1433
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
       lock_acquire kernel/locking/lockdep.c:5761 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
       down_read+0x9c/0x470 kernel/locking/rwsem.c:1520
       inode_lock_shared include/linux/fs.h:781 [inline]
       lookup_slow fs/namei.c:1706 [inline]
       walk_component+0x33b/0x5a0 fs/namei.c:1998
       lookup_last fs/namei.c:2455 [inline]
       path_lookupat+0x17f/0x770 fs/namei.c:2479
       filename_lookup+0x1e7/0x5b0 fs/namei.c:2508
       kern_path+0x35/0x50 fs/namei.c:2606
       lookup_bdev+0xd9/0x280 block/bdev.c:943
       resume_store+0x1d4/0x460 kernel/power/hibernate.c:1177
       kobj_attr_store+0x55/0x80 lib/kobject.c:833
       sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x3ff/0x610 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:1871 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x650/0xe40 fs/read_write.c:584
       ksys_write+0x12f/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
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

4 locks held by syz-executor.3/28959:
 #0: ffff8880426b2d48 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe3/0x100 fs/file.c:1047
 #1: ffff88801bcea410 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12f/0x250 fs/read_write.c:637
 #2: ffff888062425488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x610 fs/kernfs/file.c:325
 #3: ffff88801826ce88 (kn->active#68){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a4/0x610 fs/kernfs/file.c:326

stack backtrace:
CPU: 0 PID: 28959 Comm: syz-executor.3 Not tainted 6.5.0-rc1-syzkaller-00201-g2772d7df3c93 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
 down_read+0x9c/0x470 kernel/locking/rwsem.c:1520
 inode_lock_shared include/linux/fs.h:781 [inline]
 lookup_slow fs/namei.c:1706 [inline]
 walk_component+0x33b/0x5a0 fs/namei.c:1998
 lookup_last fs/namei.c:2455 [inline]
 path_lookupat+0x17f/0x770 fs/namei.c:2479
 filename_lookup+0x1e7/0x5b0 fs/namei.c:2508
 kern_path+0x35/0x50 fs/namei.c:2606
 lookup_bdev+0xd9/0x280 block/bdev.c:943
 resume_store+0x1d4/0x460 kernel/power/hibernate.c:1177
 kobj_attr_store+0x55/0x80 lib/kobject.c:833
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x3ff/0x610 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:1871 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3db0c7cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3db1a280c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3db0d9bf80 RCX: 00007f3db0c7cb29
RDX: 0000000000000012 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007f3db0cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3db0d9bf80 R15: 00007ffc4744d038
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
