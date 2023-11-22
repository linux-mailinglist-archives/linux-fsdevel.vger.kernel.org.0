Return-Path: <linux-fsdevel+bounces-3349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971267F3D3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 06:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E886281E91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 05:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B1011710;
	Wed, 22 Nov 2023 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA4B110
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 21:21:23 -0800 (PST)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-5c1d1212631so9428331a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 21:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700630483; x=1701235283;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jv57hKCODxYrzZthLIomnSbbu4eI0XselGu/K5imZtU=;
        b=GXWZ7MqM0cN+AsySRsfO80TPn3/P5042GXvqgwHZtw+Ulz08xGbDmP3g4OT8WCGjI1
         fkag6Zao595lZsi8Zc/kxKxeS7AaPdApdz/xTdm8K1Ai1yQC/f1iCsMM0p8aJajJzp08
         iDpUyeBjKOL2cYDvt7EWiCe9NCoYZ0Bj/qII10iYuUCyoO5JhL9zjoV4VAo/B+eOUlvP
         x3gU91ZnOeGMB1vB5C4yzfnAjx9OCd++afJhQT9Atb3mlPlC5LOtegV51BmB2n5w0aEh
         hrUmeHVYYHYSPdfzp0AOGDP3jT0EtCG7uI42tN4EWfmGqCYUhtr1QrcItLgVuqgp0SPv
         +EEA==
X-Gm-Message-State: AOJu0Yx0EMCG+ISicCL9EdvUMJFUfklxTKRMknYQlVVkeQQiP8hS2tlc
	cqhg/ve4zDeTJtBQLk/48fV8qRmo+cqaYiEinPqwEKcd0o8/
X-Google-Smtp-Source: AGHT+IFYsXF5dC8iNtVFMw5ZY9OZfLhgs+qoF4p1jCh4Px90aDh3audhE0uCMwWjh7coLnX+YluUBSetXkVXNgsnPSUtkL+8vn/i
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a65:64d7:0:b0:5bd:3b33:88c7 with SMTP id
 t23-20020a6564d7000000b005bd3b3388c7mr245706pgv.0.1700630483169; Tue, 21 Nov
 2023 21:21:23 -0800 (PST)
Date: Tue, 21 Nov 2023 21:21:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7f8ce060ab6e38e@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_set_size
From: syzbot <syzbot+18f543fc90dd1194c616@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    791c8ab095f7 Merge tag 'bcachefs-2023-11-17' of https://ev..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1294d267680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84217b7fc4acdc59
dashboard link: https://syzkaller.appspot.com/bug?extid=18f543fc90dd1194c616
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-791c8ab0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e433bf284ce1/vmlinux-791c8ab0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef2e25e71c51/bzImage-791c8ab0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18f543fc90dd1194c616@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc1-syzkaller-00213-g791c8ab095f7 #0 Not tainted
------------------------------------------------------
syz-executor.1/29095 is trying to acquire lock:
ffffffff8d11bae0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:303 [inline]
ffffffff8d11bae0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slab.h:710 [inline]
ffffffff8d11bae0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3460 [inline]
ffffffff8d11bae0 (fs_reclaim){+.+.}-{0:0}, at: __kmem_cache_alloc_node+0x51/0x310 mm/slub.c:3517

but task is already holding lock:
ffff8880241bf050 (&ni->file.run_lock#2){++++}-{3:3}, at: ntfs_set_size+0x119/0x220 fs/ntfs3/inode.c:838

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ni->file.run_lock#2){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       mi_read+0x301/0x650 fs/ntfs3/record.c:129
       mi_format_new+0x39c/0x580 fs/ntfs3/record.c:420
       ni_add_subrecord+0xd1/0x4f0 fs/ntfs3/frecord.c:372
       ntfs_look_free_mft+0x209/0xdd0 fs/ntfs3/fsntfs.c:715
       ni_create_attr_list+0x93b/0x1520 fs/ntfs3/frecord.c:876
       ni_ins_attr_ext+0x23f/0xaf0 fs/ntfs3/frecord.c:974
       ni_insert_attr+0x310/0x870 fs/ntfs3/frecord.c:1141
       ni_insert_resident+0xd2/0x3a0 fs/ntfs3/frecord.c:1525
       ni_add_name+0x48b/0x820 fs/ntfs3/frecord.c:3047
       ni_rename+0xa1/0x1a0 fs/ntfs3/frecord.c:3087
       ntfs_rename+0x91f/0xec0 fs/ntfs3/namei.c:322
       vfs_rename+0xe23/0x1c30 fs/namei.c:4844
       do_renameat2+0xc3c/0xdc0 fs/namei.c:4996
       __do_sys_rename fs/namei.c:5042 [inline]
       __se_sys_rename fs/namei.c:5040 [inline]
       __ia32_sys_rename+0x80/0xa0 fs/namei.c:5040
       do_syscall_32_irqs_on arch/x86/entry/common.c:164 [inline]
       __do_fast_syscall_32+0x62/0xe0 arch/x86/entry/common.c:230
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:255
       entry_SYSENTER_compat_after_hwframe+0x70/0x7a

-> #1 (&wnd->rw_lock/1){+.+.}-{3:3}:
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
       ntfs_mark_rec_free+0x2f4/0x400 fs/ntfs3/fsntfs.c:742
       ni_delete_all+0x6ad/0x880 fs/ntfs3/frecord.c:1637
       ni_clear+0x515/0x6a0 fs/ntfs3/frecord.c:106
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
       slab_alloc_node mm/slub.c:3460 [inline]
       __kmem_cache_alloc_node+0x51/0x310 mm/slub.c:3517
       __do_kmalloc_node mm/slab_common.c:1006 [inline]
       __kmalloc_node+0x4c/0x90 mm/slab_common.c:1014
       kmalloc_node include/linux/slab.h:620 [inline]
       kvmalloc_node+0x99/0x1a0 mm/util.c:617
       kvmalloc include/linux/slab.h:738 [inline]
       run_add_entry+0x7b2/0xbe0 fs/ntfs3/run.c:389
       attr_allocate_clusters+0x213/0x710 fs/ntfs3/attrib.c:181
       attr_set_size+0x14d7/0x2ca0 fs/ntfs3/attrib.c:572
       ntfs_set_size+0x13d/0x220 fs/ntfs3/inode.c:840
       ntfs_extend+0x3fd/0x560 fs/ntfs3/file.c:333
       ntfs_file_write_iter+0x33f/0x1e60 fs/ntfs3/file.c:1077
       call_write_iter include/linux/fs.h:2020 [inline]
       do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
       do_iter_write+0x17f/0x7f0 fs/read_write.c:860
       vfs_writev+0x221/0x700 fs/read_write.c:933
       do_writev+0x137/0x370 fs/read_write.c:976
       do_syscall_32_irqs_on arch/x86/entry/common.c:164 [inline]
       __do_fast_syscall_32+0x62/0xe0 arch/x86/entry/common.c:230
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:255
       entry_SYSENTER_compat_after_hwframe+0x70/0x7a

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &wnd->rw_lock/1 --> &ni->file.run_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->file.run_lock#2);
                               lock(&wnd->rw_lock/1);
                               lock(&ni->file.run_lock#2);
  lock(fs_reclaim);

 *** DEADLOCK ***

5 locks held by syz-executor.1/29095:
 #0: ffff888024ffd4c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe7/0x170 fs/file.c:1177
 #1: ffff888015250418 (sb_writers#17){.+.+}-{0:0}, at: do_writev+0x137/0x370 fs/read_write.c:976
 #2: ffff8880241bf240 (&sb->s_type->i_mutex_key#25){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:822 [inline]
 #2: ffff8880241bf240 (&sb->s_type->i_mutex_key#25){+.+.}-{3:3}, at: ntfs_file_write_iter+0x23b/0x1e60 fs/ntfs3/file.c:1061
 #3: ffff8880241befa0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 #3: ffff8880241befa0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_set_size+0x111/0x220 fs/ntfs3/inode.c:837
 #4: ffff8880241bf050 (&ni->file.run_lock#2){++++}-{3:3}, at: ntfs_set_size+0x119/0x220 fs/ntfs3/inode.c:838

stack backtrace:
CPU: 2 PID: 29095 Comm: syz-executor.1 Not tainted 6.7.0-rc1-syzkaller-00213-g791c8ab095f7 #0
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
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x51/0x310 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node+0x4c/0x90 mm/slab_common.c:1014
 kmalloc_node include/linux/slab.h:620 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:617
 kvmalloc include/linux/slab.h:738 [inline]
 run_add_entry+0x7b2/0xbe0 fs/ntfs3/run.c:389
 attr_allocate_clusters+0x213/0x710 fs/ntfs3/attrib.c:181
 attr_set_size+0x14d7/0x2ca0 fs/ntfs3/attrib.c:572
 ntfs_set_size+0x13d/0x220 fs/ntfs3/inode.c:840
 ntfs_extend+0x3fd/0x560 fs/ntfs3/file.c:333
 ntfs_file_write_iter+0x33f/0x1e60 fs/ntfs3/file.c:1077
 call_write_iter include/linux/fs.h:2020 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x7f0 fs/read_write.c:860
 vfs_writev+0x221/0x700 fs/read_write.c:933
 do_writev+0x137/0x370 fs/read_write.c:976
 do_syscall_32_irqs_on arch/x86/entry/common.c:164 [inline]
 __do_fast_syscall_32+0x62/0xe0 arch/x86/entry/common.c:230
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:255
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a
RIP: 0023:0xf7f1e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f195ac EFLAGS: 00000292 ORIG_RAX: 0000000000000092
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

