Return-Path: <linux-fsdevel+bounces-3865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3AE7F955D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 21:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FF5280CB9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 20:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96EB12E5B;
	Sun, 26 Nov 2023 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD16CE
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 12:58:23 -0800 (PST)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1cfaeab7dafso17598205ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 12:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701032303; x=1701637103;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItywWWmtVPRH3yz41L5uTtuSiiqLDq62KMdXCLlngzQ=;
        b=DRcJ+5kw6pz3UY3BtvNEFJbOB4NFYcSYpOcUFQ4Ehamyq2ZpKHVDC64xHdzND66LSw
         r8Negta45GjtRPRG428cBO21iwAFfN3FtOpl7gqrQE2e31WUSy+Xvh6obxopL85tWwSm
         OCmw8YEnE0soif+17g8vKdSh/ncNW+ZxhPV3CjILN5wj71QqQHyueTru+mg3pUudkVKt
         K4kYYX09Yq6/gkz1EyP1Jl/Z6FKgNHSR5KF7gSVvWbeOnL9qCN6msKIBp/Rhw1c3XIwd
         akX2mx/gTEqoE7ruZSSYEiJ7WEa4VZBU8R2mepCN5XLPbtObBEufPT4BVhsYcNz4mmj+
         /ezg==
X-Gm-Message-State: AOJu0YyNPSa35nLn7/ED/vfsk75MHXTZiI/ng6lRH9u+/x7nVtgl0Jyk
	hEsP5NslWzZUUSWdrwgfmDd04pxWOXwP15PMqAeMTNZiHfAj
X-Google-Smtp-Source: AGHT+IHLtbInkGp62/2wt3pz/eF/Q8Sis4M4DCYC5EHqefGZrp+J97JPbt7cTS5jD6JrJAr1PbzgaWe9fz5ee80lX8omgw8IVm+7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:3295:b0:1cc:23d2:bb94 with SMTP id
 jh21-20020a170903329500b001cc23d2bb94mr2056401plb.1.1701032302910; Sun, 26
 Nov 2023 12:58:22 -0800 (PST)
Date: Sun, 26 Nov 2023 12:58:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002aa189060b147268@google.com>
Subject: [syzbot] [fscrypt?] possible deadlock in find_and_lock_process_key
From: syzbot <syzbot+9d04b061c581795e18ce@syzkaller.appspotmail.com>
To: ebiggers@kernel.org, jaegeuk@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b6de136b5f0 Merge tag 'loongarch-fixes-6.7-1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11258d67680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aec35c1281ec0aaf
dashboard link: https://syzkaller.appspot.com/bug?extid=9d04b061c581795e18ce
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-9b6de136.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/434b9bf68626/vmlinux-9b6de136.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd40dbf2926d/bzImage-9b6de136.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d04b061c581795e18ce@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc2-syzkaller-00029-g9b6de136b5f0 #0 Not tainted
------------------------------------------------------
syz-executor.1/27256 is trying to acquire lock:
ffffffff8d114b60 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:303 [inline]
ffffffff8d114b60 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slab.h:710 [inline]
ffffffff8d114b60 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slab.c:3221 [inline]
ffffffff8d114b60 (fs_reclaim){+.+.}-{0:0}, at: __kmem_cache_alloc_node+0x42/0x460 mm/slab.c:3521

but task is already holding lock:
ffff8880354d2e98 (&type->lock_class#5){++++}-{3:3}, at: find_and_lock_process_key+0x97/0x390 fs/crypto/keysetup_v1.c:112

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&type->lock_class#5){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       find_and_lock_process_key+0x97/0x390 fs/crypto/keysetup_v1.c:112
       fscrypt_setup_v1_file_key_via_subscribed_keyrings+0x115/0x2d0 fs/crypto/keysetup_v1.c:310
       setup_file_encryption_key fs/crypto/keysetup.c:485 [inline]
       fscrypt_setup_encryption_info+0xb69/0x1080 fs/crypto/keysetup.c:590
       fscrypt_get_encryption_info+0x3d1/0x4b0 fs/crypto/keysetup.c:675
       fscrypt_setup_filename+0x238/0xd80 fs/crypto/fname.c:458
       ext4_fname_setup_filename+0xa3/0x250 fs/ext4/crypto.c:28
       ext4_add_entry+0x32b/0xe40 fs/ext4/namei.c:2403
       ext4_rename+0x165e/0x2880 fs/ext4/namei.c:3932
       ext4_rename2+0x1bc/0x270 fs/ext4/namei.c:4212
       vfs_rename+0x13e0/0x1c30 fs/namei.c:4844
       do_renameat2+0xc3c/0xdc0 fs/namei.c:4996
       __do_sys_renameat fs/namei.c:5036 [inline]
       __se_sys_renameat fs/namei.c:5033 [inline]
       __x64_sys_renameat+0xc6/0x100 fs/namei.c:5033
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #2 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0x10ff/0x15e0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x391/0x840 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x343/0x5d0 fs/ext4/ext4_jbd2.c:112
       ext4_sample_last_mounted fs/ext4/file.c:835 [inline]
       ext4_file_open+0x632/0xc80 fs/ext4/file.c:864
       do_dentry_open+0x8d6/0x18c0 fs/open.c:948
       do_open fs/namei.c:3622 [inline]
       path_openat+0x1e5a/0x2c50 fs/namei.c:3779
       do_filp_open+0x1de/0x430 fs/namei.c:3809
       do_sys_openat2+0x176/0x1e0 fs/open.c:1440
       do_sys_open fs/open.c:1455 [inline]
       __do_sys_openat fs/open.c:1471 [inline]
       __se_sys_openat fs/open.c:1466 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1466
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #1 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1635 [inline]
       sb_start_intwrite include/linux/fs.h:1757 [inline]
       ext4_evict_inode+0xe5b/0x1a40 fs/ext4/inode.c:212
       evict+0x2ed/0x6b0 fs/inode.c:664
       iput_final fs/inode.c:1775 [inline]
       iput.part.0+0x560/0x7b0 fs/inode.c:1801
       iput+0x5c/0x80 fs/inode.c:1791
       dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
       __dentry_kill+0x3b8/0x640 fs/dcache.c:607
       shrink_dentry_list+0x11e/0x4a0 fs/dcache.c:1201
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
       super_cache_scan+0x327/0x540 fs/super.c:228
       do_shrink_slab+0x428/0x1120 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa83/0x1310 mm/shrinker.c:626
       shrink_one+0x4f7/0x700 mm/vmscan.c:4724
       shrink_many mm/vmscan.c:4776 [inline]
       lru_gen_shrink_node mm/vmscan.c:4893 [inline]
       shrink_node+0x20cd/0x3790 mm/vmscan.c:5833
       kswapd_shrink_node mm/vmscan.c:6638 [inline]
       balance_pgdat+0x9d2/0x1a90 mm/vmscan.c:6828
       kswapd+0x5be/0xbf0 mm/vmscan.c:7088
       kthread+0x2c6/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2464/0x3b10 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5718
       __fs_reclaim_acquire mm/page_alloc.c:3693 [inline]
       fs_reclaim_acquire+0x100/0x150 mm/page_alloc.c:3707
       might_alloc include/linux/sched/mm.h:303 [inline]
       slab_pre_alloc_hook mm/slab.h:710 [inline]
       slab_alloc_node mm/slab.c:3221 [inline]
       __kmem_cache_alloc_node+0x42/0x460 mm/slab.c:3521
       __do_kmalloc_node mm/slab_common.c:1006 [inline]
       __kmalloc+0x49/0x90 mm/slab_common.c:1020
       kmalloc include/linux/slab.h:604 [inline]
       setup_v1_file_key_derived fs/crypto/keysetup_v1.c:278 [inline]
       fscrypt_setup_v1_file_key+0x167/0x550 fs/crypto/keysetup_v1.c:299
       fscrypt_setup_v1_file_key_via_subscribed_keyrings+0x159/0x2d0 fs/crypto/keysetup_v1.c:321
       setup_file_encryption_key fs/crypto/keysetup.c:485 [inline]
       fscrypt_setup_encryption_info+0xb69/0x1080 fs/crypto/keysetup.c:590
       fscrypt_get_encryption_info+0x3d1/0x4b0 fs/crypto/keysetup.c:675
       fscrypt_prepare_readdir include/linux/fscrypt.h:1004 [inline]
       ext4_readdir+0x1175/0x3730 fs/ext4/dir.c:137
       iterate_dir+0x1e5/0x5b0 fs/readdir.c:106
       __do_sys_getdents64 fs/readdir.c:405 [inline]
       __se_sys_getdents64 fs/readdir.c:390 [inline]
       __x64_sys_getdents64+0x14f/0x2e0 fs/readdir.c:390
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> jbd2_handle --> &type->lock_class#5

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&type->lock_class#5);
                               lock(jbd2_handle);
                               lock(&type->lock_class#5);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz-executor.1/27256:
 #0: ffff88802cf39148 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe7/0x170 fs/file.c:1177
 #1: ffff88810704e6c0 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: iterate_dir+0xe4/0x5b0 fs/readdir.c:99
 #2: ffff8880354d2e98 (&type->lock_class#5){++++}-{3:3}, at: find_and_lock_process_key+0x97/0x390 fs/crypto/keysetup_v1.c:112

stack backtrace:
CPU: 2 PID: 27256 Comm: syz-executor.1 Not tainted 6.7.0-rc2-syzkaller-00029-g9b6de136b5f0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x317/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2464/0x3b10 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5718
 __fs_reclaim_acquire mm/page_alloc.c:3693 [inline]
 fs_reclaim_acquire+0x100/0x150 mm/page_alloc.c:3707
 might_alloc include/linux/sched/mm.h:303 [inline]
 slab_pre_alloc_hook mm/slab.h:710 [inline]
 slab_alloc_node mm/slab.c:3221 [inline]
 __kmem_cache_alloc_node+0x42/0x460 mm/slab.c:3521
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x49/0x90 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 setup_v1_file_key_derived fs/crypto/keysetup_v1.c:278 [inline]
 fscrypt_setup_v1_file_key+0x167/0x550 fs/crypto/keysetup_v1.c:299
 fscrypt_setup_v1_file_key_via_subscribed_keyrings+0x159/0x2d0 fs/crypto/keysetup_v1.c:321
 setup_file_encryption_key fs/crypto/keysetup.c:485 [inline]
 fscrypt_setup_encryption_info+0xb69/0x1080 fs/crypto/keysetup.c:590
 fscrypt_get_encryption_info+0x3d1/0x4b0 fs/crypto/keysetup.c:675
 fscrypt_prepare_readdir include/linux/fscrypt.h:1004 [inline]
 ext4_readdir+0x1175/0x3730 fs/ext4/dir.c:137
 iterate_dir+0x1e5/0x5b0 fs/readdir.c:106
 __do_sys_getdents64 fs/readdir.c:405 [inline]
 __se_sys_getdents64 fs/readdir.c:390 [inline]
 __x64_sys_getdents64+0x14f/0x2e0 fs/readdir.c:390
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fb94fa7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb9507a70c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fb94fb9bf80 RCX: 00007fb94fa7cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fb94fac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb94fb9bf80 R15: 00007fff154447b8
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

