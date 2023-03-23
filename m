Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45C76C5D16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 04:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCWDOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 23:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCWDOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:14:41 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F82F061
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 20:14:39 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id n17-20020a056e02141100b003259a56715bso5740670ilo.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 20:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679541278;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xv7dlT07bhytpQH6+HIJVHPdJktguAUbYyAxEjJ2CA8=;
        b=H4J0UnuM2ytV77j1i/M4+YcKIAm08ZpQydhc/6wCqkBpbC1Ft4qQEBGpezRzg5UVnv
         +C4j5NM02tuDYvcxATgMyINd7xIZuN3YArTSiJISBUQVd7ZgVHoNnP2Bggl3TtgG67kl
         ZS315zL0LK2MGUBvZJQO+yu3t10hPEXG5tmzMXsn+sAqPglxkof3edvb3uSiS0mRhOXT
         xTMNX+1F/GmC2VT1MIWMSSEvvMupWfsubszv042NV4GUF1gZ+e6JQx73qPxr2nMR2Gp5
         DG+uBlobch0vxOTrU6g73+ASU0eBLlSf2V+6C2WgCaDBvprgQpAyrVg3f9EZc3N/CQ6o
         UwmQ==
X-Gm-Message-State: AO0yUKUY+rUT0SBZzsQil8OILARO67phqlIMQNbBOdB+5Vevyaf97bIE
        hFPbL5vvPYKVtzZKUUdpEk7BhWWFNxQOs0y8j9bqFuQCgumd
X-Google-Smtp-Source: AK7set+QsSWHgyUqgDPGWjqUg0/6yNUx1vnD/4MMh9XKj1Db2PO1EnmiT2Atzr8ctktT0blfyZeTdAqNVCG/FgfdX1SRIPz7ZBkQ
MIME-Version: 1.0
X-Received: by 2002:a92:c5ae:0:b0:324:610a:5956 with SMTP id
 r14-20020a92c5ae000000b00324610a5956mr3642389ilt.4.1679541278602; Wed, 22 Mar
 2023 20:14:38 -0700 (PDT)
Date:   Wed, 22 Mar 2023 20:14:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bffe205f788ad8e@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_inline_data_truncate
From:   syzbot <syzbot+b8e6e6822d493a4630f3@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    534293368afa Merge tag 'kbuild-fixes-v6.3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12247281c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e23c4bcf73cdc669
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e6e6822d493a4630f3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8e6e6822d493a4630f3@syzkaller.appspotmail.com

EXT4-fs (loop2): 1 truncate cleaned up
EXT4-fs (loop2): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: writeback.
======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc2-syzkaller-00387-g534293368afa #0 Not tainted
------------------------------------------------------
syz-executor.2/1999 is trying to acquire lock:
ffff888029121ee0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
ffff888029121ee0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_inline_data_truncate+0x1a8/0xd70 fs/ext4/inline.c:1932

but task is already holding lock:
ffff88801ae60650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:665

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1477 [inline]
       sb_start_intwrite include/linux/fs.h:1599 [inline]
       ext4_evict_inode+0x114b/0x1ca0 fs/ext4/inode.c:240
       evict+0x2ed/0x6b0 fs/inode.c:665
       iput_final fs/inode.c:1748 [inline]
       iput.part.0+0x50a/0x740 fs/inode.c:1774
       iput+0x5c/0x80 fs/inode.c:1764
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
       shrink_dentry_list+0x12c/0x4f0 fs/dcache.c:1201
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
       super_cache_scan+0x33a/0x590 fs/super.c:104
       do_shrink_slab+0x428/0xaa0 mm/vmscan.c:853
       shrink_slab_memcg mm/vmscan.c:922 [inline]
       shrink_slab+0x388/0x660 mm/vmscan.c:1001
       shrink_one+0x502/0x810 mm/vmscan.c:5343
       shrink_many mm/vmscan.c:5394 [inline]
       lru_gen_shrink_node mm/vmscan.c:5511 [inline]
       shrink_node+0x2064/0x35f0 mm/vmscan.c:6459
       kswapd_shrink_node mm/vmscan.c:7262 [inline]
       balance_pgdat+0xa02/0x1ac0 mm/vmscan.c:7452
       kswapd+0x677/0xd60 mm/vmscan.c:7712
       kthread+0x2e8/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4716 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4730
       might_alloc include/linux/sched/mm.h:271 [inline]
       slab_pre_alloc_hook mm/slab.h:728 [inline]
       slab_alloc_node mm/slub.c:3434 [inline]
       __kmem_cache_alloc_node+0x41/0x320 mm/slub.c:3491
       __do_kmalloc_node mm/slab_common.c:966 [inline]
       __kmalloc_node+0x51/0x1a0 mm/slab_common.c:974
       kmalloc_node include/linux/slab.h:610 [inline]
       kvmalloc_node+0xa2/0x1a0 mm/util.c:603
       kvmalloc include/linux/slab.h:737 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1552 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1595 [inline]
       ext4_xattr_set_entry+0x1d82/0x39e0 fs/ext4/xattr.c:1737
       ext4_xattr_block_set+0x618/0x3030 fs/ext4/xattr.c:1974
       ext4_xattr_move_to_block fs/ext4/xattr.c:2668 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
       ext4_expand_extra_isize_ea+0xa84/0x1880 fs/ext4/xattr.c:2835
       __ext4_expand_extra_isize+0x33e/0x470 fs/ext4/inode.c:5960
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6003 [inline]
       __ext4_mark_inode_dirty+0x51b/0x800 fs/ext4/inode.c:6081
       __ext4_unlink+0x667/0xcd0 fs/ext4/namei.c:3269
       ext4_unlink+0x41f/0x590 fs/ext4/namei.c:3298
       vfs_unlink+0x355/0x930 fs/namei.c:4250
       do_unlinkat+0x3df/0x670 fs/namei.c:4316
       __do_sys_unlinkat fs/namei.c:4359 [inline]
       __se_sys_unlinkat fs/namei.c:4352 [inline]
       __ia32_sys_unlinkat+0xc1/0x130 fs/namei.c:4352
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #0 (&ei->xattr_sem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_inline_data_truncate+0x1a8/0xd70 fs/ext4/inline.c:1932
       ext4_truncate+0x992/0x1340 fs/ext4/inode.c:4298
       ext4_evict_inode+0xb9f/0x1ca0 fs/ext4/inode.c:286
       evict+0x2ed/0x6b0 fs/inode.c:665
       iput_final fs/inode.c:1748 [inline]
       iput.part.0+0x50a/0x740 fs/inode.c:1774
       iput+0x5c/0x80 fs/inode.c:1764
       do_unlinkat+0x42e/0x670 fs/namei.c:4323
       __do_sys_unlinkat fs/namei.c:4359 [inline]
       __se_sys_unlinkat fs/namei.c:4352 [inline]
       __ia32_sys_unlinkat+0xc1/0x130 fs/namei.c:4352
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

other info that might help us debug this:

Chain exists of:
  &ei->xattr_sem --> fs_reclaim --> sb_internal

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_internal);
                               lock(fs_reclaim);
                               lock(sb_internal);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

2 locks held by syz-executor.2/1999:
 #0: ffff88801ae60460 (sb_writers#4){.+.+}-{0:0}, at: do_unlinkat+0x18c/0x670 fs/namei.c:4297
 #1: ffff88801ae60650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:665

stack backtrace:
CPU: 0 PID: 1999 Comm: syz-executor.2 Not tainted 6.3.0-rc2-syzkaller-00387-g534293368afa #0
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
 lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
 down_write+0x92/0x200 kernel/locking/rwsem.c:1573
 ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 ext4_inline_data_truncate+0x1a8/0xd70 fs/ext4/inline.c:1932
 ext4_truncate+0x992/0x1340 fs/ext4/inode.c:4298
 ext4_evict_inode+0xb9f/0x1ca0 fs/ext4/inode.c:286
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x50a/0x740 fs/inode.c:1774
 iput+0x5c/0x80 fs/inode.c:1764
 do_unlinkat+0x42e/0x670 fs/namei.c:4323
 __do_sys_unlinkat fs/namei.c:4359 [inline]
 __se_sys_unlinkat fs/namei.c:4352 [inline]
 __ia32_sys_unlinkat+0xc1/0x130 fs/namei.c:4352
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fcf579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7fca5cc EFLAGS: 00000296 ORIG_RAX: 000000000000012d
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000200003c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
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
