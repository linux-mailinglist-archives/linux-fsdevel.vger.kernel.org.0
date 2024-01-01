Return-Path: <linux-fsdevel+bounces-7053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D82821330
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 08:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5415282918
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2342E17E4;
	Mon,  1 Jan 2024 07:31:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E11370
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jan 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fc915c090so61216745ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Dec 2023 23:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704094278; x=1704699078;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpDQtILZyak7GDYsorwhHv1L2+lsH2umUZXaFhIIUUY=;
        b=HMwg1DDhDoMpIntUuetM5SQfYF0ev2dyh++dCHp9mJtXZ4Iz+a+U1j4B0eBnb/YQEH
         SVtRiq7Z9yJtkksRTBoMA7c56uZxeZwCMvYJJTIlv3+NYKeTV/27oOgG8taDwFx6lchr
         jZJMTuYB3XZy/S34CQlLwVwMsJjpqd+B3DDES2L3Epb7Tdx6DvAvpzr5SrICbO8P9X4Y
         awv//MXftm2rZhf8wh/oXudM5meazusdYTmROx8MWqma/6VuWMRI3fwdO0d8zwzb+Yxw
         P0SNLJUCBbaNTF/eb41VulKY+ewii8I20ZSP45tPlbeEoEqsu+nUROxHj7hCWelLKjjS
         xgKQ==
X-Gm-Message-State: AOJu0Yy0CtB1BjB5dt7pR0zdAv0Y8DqbnWcS02iECasXRUWFHjxFhxW1
	st2SCNl+0sqk1cMIjoV1UTe84fT/k3I709QUFabD38o/oEYD
X-Google-Smtp-Source: AGHT+IGkjfLT6Ywi5JnV0rbIQLiUfW7kPvK59Rr7w01QPaO8ffCJUxLRTVzWJL/O+WwZZQeptPsaMTgkCGpv7h0sQBnICfVjSR4U
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:340d:b0:35f:e800:eb79 with SMTP id
 bo13-20020a056e02340d00b0035fe800eb79mr583656ilb.1.1704094278522; Sun, 31 Dec
 2023 23:31:18 -0800 (PST)
Date: Sun, 31 Dec 2023 23:31:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000229e93060ddd5ea6@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in mnt_want_write (3)
From: syzbot <syzbot+3800901c18018cf7ff68@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    453f5db0619e Merge tag 'trace-v6.7-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1011351de80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=3800901c18018cf7ff68
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/38b92a7149e8/disk-453f5db0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4f872267133f/vmlinux-453f5db0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/587572061791/bzImage-453f5db0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3800901c18018cf7ff68@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc7-syzkaller-00049-g453f5db0619e #0 Not tainted
------------------------------------------------------
syz-executor.4/5849 is trying to acquire lock:
ffff88814c8dc418 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:404

but task is already holding lock:
ffff88807d50efe0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
ffff88807d50efe0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
ffff88807d50efe0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: path_openat+0x7bc/0x3290 fs/namei.c:3776

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:812 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1710
       walk_component+0x2d0/0x400 fs/namei.c:2002
       lookup_last fs/namei.c:2459 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2483
       filename_lookup+0x255/0x610 fs/namei.c:2512
       kern_path+0x35/0x50 fs/namei.c:2610
       lookup_bdev+0xc5/0x290 block/bdev.c:979
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1177
       kernfs_fop_write_iter+0x3b3/0x510 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:2020 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x792/0xb20 fs/read_write.c:584
       ksys_write+0x1a0/0x2c0 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #2 (&of->mutex){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       kernfs_seq_start+0x53/0x3a0 fs/kernfs/file.c:154
       seq_read_iter+0x3d4/0xd10 fs/seq_file.c:225
       call_read_iter include/linux/fs.h:2014 [inline]
       new_sync_read fs/read_write.c:389 [inline]
       vfs_read+0x78b/0xb00 fs/read_write.c:470
       ksys_read+0x1a0/0x2c0 fs/read_write.c:613
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #1 (&p->lock){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       seq_read_iter+0xb2/0xd10 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2014 [inline]
       copy_splice_read+0x4c9/0x9c0 fs/splice.c:364
       splice_direct_to_actor+0x2c4/0x9e0 fs/splice.c:1069
       do_splice_direct+0x2ac/0x3f0 fs/splice.c:1194
       do_sendfile+0x62c/0x1000 fs/read_write.c:1254
       __do_sys_sendfile64 fs/read_write.c:1322 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #0 (sb_writers#4){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1635 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1710
       mnt_want_write+0x3f/0x90 fs/namespace.c:404
       ovl_create_object+0x13b/0x360 fs/overlayfs/dir.c:629
       lookup_open fs/namei.c:3477 [inline]
       open_last_lookups fs/namei.c:3546 [inline]
       path_openat+0x13fa/0x3290 fs/namei.c:3776
       do_filp_open+0x234/0x490 fs/namei.c:3809
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x247/0x290 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

Chain exists of:
  sb_writers#4 --> &of->mutex --> &ovl_i_mutex_dir_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ovl_i_mutex_dir_key[depth]);
                               lock(&of->mutex);
                               lock(&ovl_i_mutex_dir_key[depth]);
  rlock(sb_writers#4);

 *** DEADLOCK ***

2 locks held by syz-executor.4/5849:
 #0: ffff888079772418 (sb_writers#28){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:404
 #1: ffff88807d50efe0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #1: ffff88807d50efe0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #1: ffff88807d50efe0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: path_openat+0x7bc/0x3290 fs/namei.c:3776

stack backtrace:
CPU: 0 PID: 5849 Comm: syz-executor.4 Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x366/0x490 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1635 [inline]
 sb_start_write+0x4d/0x1c0 include/linux/fs.h:1710
 mnt_want_write+0x3f/0x90 fs/namespace.c:404
 ovl_create_object+0x13b/0x360 fs/overlayfs/dir.c:629
 lookup_open fs/namei.c:3477 [inline]
 open_last_lookups fs/namei.c:3546 [inline]
 path_openat+0x13fa/0x3290 fs/namei.c:3776
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fa7b5a7cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa7b686b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fa7b5b9bf80 RCX: 00007fa7b5a7cce9
RDX: 0000000000141842 RSI: 0000000020000440 RDI: ffffffffffffff9c
RBP: 00007fa7b5ac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa7b5b9bf80 R15: 00007ffec2fc2058
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

