Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2E6A6EF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 16:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCAPFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 10:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCAPFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:05:04 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544FC3BD86
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 07:05:00 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y3-20020a927d03000000b003174a027af1so6888009ilc.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 07:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlbiZFc9H2n5/Q8GVm1b2aweZSXo9Y5IAwrUWb6JiWc=;
        b=ALQngU7Lo8/eKE7cmctgyrV3D3nMGx5cgtst7h1wLkySaU1Foat1Jxxon6xN0WZ712
         VMWnWC4atVIZE0cbITz3KNZEszKvmGVOFebW5Hf56XN0XeP2iaRlI8CVlHLmz9h5udNF
         6meO79O38tzkgzZDxCf8eiyVdQCMFASOKpuc0rgE3RhF6zthqUbkKFq1CTO2MshKn+MS
         OLRwAPZaiUmx5RjVPAXUZ0KwuqJicqAoWavIJKt9nURwJ6jiUZTg96dJ2U2deHfOF1nr
         oGd7alqcQoEzokqgW+HzH+66n1qlB+MNfHoufLTm01nnH3Nj0AmkHqWXEbAeN8Pkz3eE
         H/Gw==
X-Gm-Message-State: AO0yUKWhRv/96d6EsW2Iuh/BMb0QeqyaYZkYtLaf1+TsfBXdEvdLUk91
        PQCLrLrKVe+cv1TiSUYxlUpu/PbQk2c2y7h7p1CMMPjpAXQM
X-Google-Smtp-Source: AK7set8EVAUIebqb6pH9XTA1c5MaT8rAyuUQEc8FBQY3Vl6rZ1URMtZnBc3e/vgM0TS0tkqbckMvVrHwa3SF5xqvmEi9ShjaiKhb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1911:b0:3c4:a4d1:cc49 with SMTP id
 p17-20020a056638191100b003c4a4d1cc49mr4171505jal.3.1677683099373; Wed, 01 Mar
 2023 07:04:59 -0800 (PST)
Date:   Wed, 01 Mar 2023 07:04:59 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f1a6205f5d8096b@google.com>
Subject: [syzbot] [fscrypt?] possible deadlock in fscrypt_initialize (2)
From:   syzbot <syzbot+3a3b5221ffafba7d5204@syzkaller.appspotmail.com>
To:     ebiggers@kernel.org, jaegeuk@kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c0927a7a5391 Merge tag 'xfs-6.3-merge-4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1268a838c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=3a3b5221ffafba7d5204
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a3b5221ffafba7d5204@syzkaller.appspotmail.com

syz-executor.3 (pid 10194) is setting deprecated v1 encryption policy; recommend upgrading to v2.
======================================================
WARNING: possible circular locking dependency detected
6.2.0-syzkaller-12998-gc0927a7a5391 #0 Not tainted
------------------------------------------------------
syz-executor.3/10194 is trying to acquire lock:
ffffffff8c972128 (fscrypt_init_mutex){+.+.}-{3:3}, at: fscrypt_initialize+0x40/0xa0 fs/crypto/crypto.c:326

but task is already holding lock:
ffff888044f84990 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xfb4/0x14e0 fs/jbd2/transaction.c:461

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xfe7/0x14e0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x39d/0x9d0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x706/0x890 fs/ext4/ext4_jbd2.c:111
       ext4_sample_last_mounted fs/ext4/file.c:851 [inline]
       ext4_file_open+0x618/0xbf0 fs/ext4/file.c:880
       do_dentry_open+0x6cc/0x13f0 fs/open.c:920
       do_open fs/namei.c:3560 [inline]
       path_openat+0x1baa/0x2750 fs/namei.c:3715
       do_filp_open+0x1ba/0x410 fs/namei.c:3742
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1348
       do_sys_open fs/open.c:1364 [inline]
       __do_sys_openat fs/open.c:1380 [inline]
       __se_sys_openat fs/open.c:1375 [inline]
       __x64_sys_openat+0x143/0x1f0 fs/open.c:1375
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1477 [inline]
       sb_start_intwrite include/linux/fs.h:1599 [inline]
       ext4_evict_inode+0xfc7/0x1b50 fs/ext4/inode.c:240
       evict+0x2ed/0x6b0 fs/inode.c:665
       iput_final fs/inode.c:1748 [inline]
       iput.part.0+0x59b/0x8a0 fs/inode.c:1774
       iput+0x5c/0x80 fs/inode.c:1764
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
       dentry_kill fs/dcache.c:745 [inline]
       dput+0x6ac/0xe10 fs/dcache.c:913
       ovl_entry_stack_free fs/overlayfs/super.c:62 [inline]
       ovl_dentry_release+0xce/0x140 fs/overlayfs/super.c:75
       __dentry_kill+0x42b/0x640 fs/dcache.c:612
       shrink_dentry_list+0x12c/0x4f0 fs/dcache.c:1201
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
       super_cache_scan+0x33a/0x590 fs/super.c:104
       do_shrink_slab+0x464/0xd20 mm/vmscan.c:853
       shrink_slab_memcg mm/vmscan.c:922 [inline]
       shrink_slab+0x388/0x660 mm/vmscan.c:1001
       shrink_one+0x502/0x810 mm/vmscan.c:5343
       shrink_many mm/vmscan.c:5394 [inline]
       lru_gen_shrink_node mm/vmscan.c:5511 [inline]
       shrink_node+0x2064/0x35f0 mm/vmscan.c:6459
       kswapd_shrink_node mm/vmscan.c:7262 [inline]
       balance_pgdat+0xa02/0x1ac0 mm/vmscan.c:7452
       kswapd+0x70b/0x1000 mm/vmscan.c:7712
       kthread+0x2e8/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4716 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4730
       might_alloc include/linux/sched/mm.h:271 [inline]
       slab_pre_alloc_hook mm/slab.h:728 [inline]
       slab_alloc_node mm/slub.c:3434 [inline]
       __kmem_cache_alloc_node+0x41/0x330 mm/slub.c:3491
       kmalloc_node_trace+0x21/0x60 mm/slab_common.c:1074
       kmalloc_node include/linux/slab.h:606 [inline]
       kzalloc_node include/linux/slab.h:731 [inline]
       mempool_create_node mm/mempool.c:272 [inline]
       mempool_create+0x52/0xc0 mm/mempool.c:261
       mempool_create_page_pool include/linux/mempool.h:112 [inline]
       fscrypt_initialize+0x8a/0xa0 fs/crypto/crypto.c:332
       fscrypt_setup_encryption_info+0xef/0xeb0 fs/crypto/keysetup.c:563
       fscrypt_get_encryption_info+0x375/0x450 fs/crypto/keysetup.c:668
       fscrypt_setup_filename+0x23c/0xec0 fs/crypto/fname.c:458
       ext4_fname_setup_filename+0x8c/0x110 fs/ext4/crypto.c:28
       ext4_find_entry+0x8c/0x140 fs/ext4/namei.c:1725
       ext4_rename+0x51d/0x26d0 fs/ext4/namei.c:3829
       ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4193
       vfs_rename+0xef6/0x17a0 fs/namei.c:4772
       do_renameat2+0xb62/0xc90 fs/namei.c:4923
       __do_sys_renameat2 fs/namei.c:4956 [inline]
       __se_sys_renameat2 fs/namei.c:4953 [inline]
       __ia32_sys_renameat2+0xe8/0x120 fs/namei.c:4953
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #0 (fscrypt_init_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       fscrypt_initialize+0x40/0xa0 fs/crypto/crypto.c:326
       fscrypt_setup_encryption_info+0xef/0xeb0 fs/crypto/keysetup.c:563
       fscrypt_get_encryption_info+0x375/0x450 fs/crypto/keysetup.c:668
       fscrypt_setup_filename+0x23c/0xec0 fs/crypto/fname.c:458
       ext4_fname_setup_filename+0x8c/0x110 fs/ext4/crypto.c:28
       ext4_add_entry+0x3aa/0xe30 fs/ext4/namei.c:2380
       ext4_rename+0x19ff/0x26d0 fs/ext4/namei.c:3911
       ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4193
       vfs_rename+0xef6/0x17a0 fs/namei.c:4772
       do_renameat2+0xb62/0xc90 fs/namei.c:4923
       __do_sys_renameat2 fs/namei.c:4956 [inline]
       __se_sys_renameat2 fs/namei.c:4953 [inline]
       __ia32_sys_renameat2+0xe8/0x120 fs/namei.c:4953
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

other info that might help us debug this:

Chain exists of:
  fscrypt_init_mutex --> sb_internal --> jbd2_handle

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(jbd2_handle);
                               lock(sb_internal);
                               lock(jbd2_handle);
  lock(fscrypt_init_mutex);

 *** DEADLOCK ***

6 locks held by syz-executor.3/10194:
 #0: ffff888044f80460 (sb_writers#4){.+.+}-{0:0}, at: do_renameat2+0x37f/0xc90 fs/namei.c:4859
 #1: ffff888044f80748 (&type->s_vfs_rename_key){+.+.}-{3:3}, at: lock_rename+0x58/0x280 fs/namei.c:2995
 #2: ffff888027b17258 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
 #2: ffff888027b17258 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: lock_rename+0xa4/0x280 fs/namei.c:2999
 #3: ffff88801caa0400 (&type->i_mutex_dir_key#3/2){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
 #3: ffff88801caa0400 (&type->i_mutex_dir_key#3/2){+.+.}-{3:3}, at: lock_rename+0xd8/0x280 fs/namei.c:3000
 #4: ffff888028c35440 (&sb->s_type->i_mutex_key#8/4){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
 #4: ffff888028c35440 (&sb->s_type->i_mutex_key#8/4){+.+.}-{3:3}, at: lock_two_nondirectories+0xd5/0x110 fs/inode.c:1124
 #5: ffff888044f84990 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xfb4/0x14e0 fs/jbd2/transaction.c:461

stack backtrace:
CPU: 1 PID: 10194 Comm: syz-executor.3 Not tainted 6.2.0-syzkaller-12998-gc0927a7a5391 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
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
 lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
 fscrypt_initialize+0x40/0xa0 fs/crypto/crypto.c:326
 fscrypt_setup_encryption_info+0xef/0xeb0 fs/crypto/keysetup.c:563
 fscrypt_get_encryption_info+0x375/0x450 fs/crypto/keysetup.c:668
 fscrypt_setup_filename+0x23c/0xec0 fs/crypto/fname.c:458
 ext4_fname_setup_filename+0x8c/0x110 fs/ext4/crypto.c:28
 ext4_add_entry+0x3aa/0xe30 fs/ext4/namei.c:2380
 ext4_rename+0x19ff/0x26d0 fs/ext4/namei.c:3911
 ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4193
 vfs_rename+0xef6/0x17a0 fs/namei.c:4772
 do_renameat2+0xb62/0xc90 fs/namei.c:4923
 __do_sys_renameat2 fs/namei.c:4956 [inline]
 __se_sys_renameat2 fs/namei.c:4953 [inline]
 __ia32_sys_renameat2+0xe8/0x120 fs/namei.c:4953
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f22579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f1d5cc EFLAGS: 00000296 ORIG_RAX: 0000000000000161
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000200001c0
RDX: 0000000000000004 RSI: 0000000020000200 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
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
  2b:	c3                   	retq
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
