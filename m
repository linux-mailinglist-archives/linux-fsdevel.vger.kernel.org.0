Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1067877B8E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 14:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjHNMnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 08:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjHNMnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:43:02 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F746E5D
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 05:43:00 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-56506e5dbfeso4601466a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 05:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692016980; x=1692621780;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s66UEJ3FnW1sRqt3mtQxYx1xMdeoNhCsvPvucrN4BdI=;
        b=YXVV4n5hKnO00YGFW+Acw9IrdmHqZDvuwME6S6X+f2xN50rS2+pCFeQ3PkTf92uhcu
         1WtL4/uejG3z8sOmaFPYzp9XhvhqmdzF5K7dtvCGzY06jjRWs7pIwkEj6DjTVB7+a2gn
         LzM7W+tNUWcVZo976pZkM6C0/z/mpJSkvCN2c7mGXrUp4VPSH00237KlnsL6BxY85eAY
         SwDGAoASJ+kcwiXXwpgIyOkQC+waoaAhVy1OCwgjk62mpAfbUKh98qiFtKHQMoPt2zaY
         RgXZDYAYGtq1YLDu2sGvPkQy3XEC4aNhmPQQJrtk/9UaOSX6/YcbnM23e4aIUdyIc3v9
         2PdA==
X-Gm-Message-State: AOJu0Yyhl5mn4v55o8Fa67QzJ4HDPXTJVgHskVk343rMratUQBVy5f3E
        8IVDXB5vNAZ1YRVpDftili0E7W9m5sAZuNgBWWVa5JuO2f4G
X-Google-Smtp-Source: AGHT+IF+0WsJMEX8EUGbR3mA0k/wCKQ+X+6InwHWSWMsHIknVL3uIRwiQqs7xaYmfBjC7vbXpCgHlYznoJbTnC9lo4757K0Jid5P
MIME-Version: 1.0
X-Received: by 2002:a63:954e:0:b0:565:58b6:70b9 with SMTP id
 t14-20020a63954e000000b0056558b670b9mr1552559pgn.11.1692016979907; Mon, 14
 Aug 2023 05:42:59 -0700 (PDT)
Date:   Mon, 14 Aug 2023 05:42:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a9c9e0602e167e8@google.com>
Subject: [syzbot] [ext4?] possible deadlock in __ext4_mark_inode_dirty (2)
From:   syzbot <syzbot+1422c4a798761a48ea4f@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    374a7f47bf40 Merge tag '6.5-rc5-ksmbd-server' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c292d7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=1422c4a798761a48ea4f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-374a7f47.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ea517da243c/vmlinux-374a7f47.xz
kernel image: https://storage.googleapis.com/syzbot-assets/443cf2c4cd8a/bzImage-374a7f47.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1422c4a798761a48ea4f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.5.0-rc5-syzkaller-00063-g374a7f47bf40 #0 Not tainted
------------------------------------------------------
syz-executor.0/10326 is trying to acquire lock:
ffffffff8cb0c720 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:303 [inline]
ffffffff8cb0c720 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slab.h:709 [inline]
ffffffff8cb0c720 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3452 [inline]
ffffffff8cb0c720 (fs_reclaim){+.+.}-{0:0}, at: __kmem_cache_alloc_node+0x51/0x350 mm/slub.c:3509

but task is already holding lock:
ffff88802057dac8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
ffff88802057dac8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5809 [inline]
ffff88802057dac8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x4a1/0x800 fs/ext4/inode.c:5890

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x93/0x200 kernel/locking/rwsem.c:1573
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_xattr_set_handle+0x167/0x14c0 fs/ext4/xattr.c:2371
       __ext4_set_acl+0x362/0x5d0 fs/ext4/acl.c:217
       ext4_set_acl+0x2c8/0x620 fs/ext4/acl.c:259
       set_posix_acl+0x259/0x320 fs/posix_acl.c:956
       vfs_remove_acl+0x2cd/0x620 fs/posix_acl.c:1243
       ovl_do_remove_acl fs/overlayfs/overlayfs.h:300 [inline]
       ovl_workdir_create+0x4a1/0x820 fs/overlayfs/super.c:331
       ovl_make_workdir fs/overlayfs/super.c:711 [inline]
       ovl_get_workdir fs/overlayfs/super.c:864 [inline]
       ovl_fill_super+0xdab/0x6180 fs/overlayfs/super.c:1400
       vfs_get_super+0xf9/0x290 fs/super.c:1152
       vfs_get_tree+0x88/0x350 fs/super.c:1519
       do_new_mount fs/namespace.c:3335 [inline]
       path_mount+0x1492/0x1ed0 fs/namespace.c:3662
       do_mount fs/namespace.c:3675 [inline]
       __do_sys_mount fs/namespace.c:3884 [inline]
       __se_sys_mount fs/namespace.c:3861 [inline]
       __ia32_sys_mount+0x291/0x310 fs/namespace.c:3861
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #2 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0x1116/0x1600 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x391/0x690 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x40f/0x5c0 fs/ext4/ext4_jbd2.c:111
       ext4_sample_last_mounted fs/ext4/file.c:863 [inline]
       ext4_file_open+0x632/0xc80 fs/ext4/file.c:892
       do_dentry_open+0x88b/0x1780 fs/open.c:914
       do_open fs/namei.c:3636 [inline]
       path_openat+0x19af/0x29c0 fs/namei.c:3793
       do_filp_open+0x1de/0x430 fs/namei.c:3820
       do_sys_openat2+0x176/0x1e0 fs/open.c:1407
       do_sys_open fs/open.c:1422 [inline]
       __do_sys_openat fs/open.c:1438 [inline]
       __se_sys_openat fs/open.c:1433 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1433
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1494 [inline]
       sb_start_intwrite include/linux/fs.h:1616 [inline]
       ext4_evict_inode+0xe55/0x1a30 fs/ext4/inode.c:212
       evict+0x2ed/0x6b0 fs/inode.c:665
       iput_final fs/inode.c:1791 [inline]
       iput.part.0+0x55e/0x7a0 fs/inode.c:1817
       iput+0x5c/0x80 fs/inode.c:1807
       dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
       __dentry_kill+0x3b8/0x640 fs/dcache.c:607
       dentry_kill fs/dcache.c:745 [inline]
       dput+0x703/0xfd0 fs/dcache.c:913
       ovl_stack_put fs/overlayfs/util.c:105 [inline]
       ovl_free_entry+0x8e/0xd0 fs/overlayfs/util.c:127
       ovl_destroy_inode+0x6a/0x110 fs/overlayfs/super.c:176
       destroy_inode+0xc4/0x1b0 fs/inode.c:310
       iput_final fs/inode.c:1791 [inline]
       iput.part.0+0x55e/0x7a0 fs/inode.c:1817
       iput+0x5c/0x80 fs/inode.c:1807
       dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
       __dentry_kill+0x3b8/0x640 fs/dcache.c:607
       shrink_dentry_list+0x235/0x7e0 fs/dcache.c:1201
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
       super_cache_scan+0x332/0x560 fs/super.c:104
       do_shrink_slab+0x422/0xaa0 mm/vmscan.c:900
       shrink_slab_memcg mm/vmscan.c:969 [inline]
       shrink_slab+0x48b/0x6e0 mm/vmscan.c:1048
       shrink_one+0x4f7/0x700 mm/vmscan.c:5403
       shrink_many mm/vmscan.c:5453 [inline]
       lru_gen_shrink_node mm/vmscan.c:5570 [inline]
       shrink_node+0x20c2/0x3730 mm/vmscan.c:6510
       kswapd_shrink_node mm/vmscan.c:7315 [inline]
       balance_pgdat+0xa37/0x1b90 mm/vmscan.c:7505
       kswapd+0x5be/0xbf0 mm/vmscan.c:7765
       kthread+0x33a/0x430 kernel/kthread.c:389
       ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
       lock_acquire kernel/locking/lockdep.c:5761 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
       __fs_reclaim_acquire mm/page_alloc.c:3602 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:3616
       might_alloc include/linux/sched/mm.h:303 [inline]
       slab_pre_alloc_hook mm/slab.h:709 [inline]
       slab_alloc_node mm/slub.c:3452 [inline]
       __kmem_cache_alloc_node+0x51/0x350 mm/slub.c:3509
       __do_kmalloc_node mm/slab_common.c:984 [inline]
       __kmalloc_node+0x4f/0x100 mm/slab_common.c:992
       kmalloc_node include/linux/slab.h:602 [inline]
       kvmalloc_node+0x99/0x1a0 mm/util.c:604
       kvmalloc include/linux/slab.h:720 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1535 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1577 [inline]
       ext4_xattr_set_entry+0x1c3d/0x3c70 fs/ext4/xattr.c:1719
       ext4_xattr_block_set+0x678/0x30e0 fs/ext4/xattr.c:1970
       ext4_xattr_move_to_block fs/ext4/xattr.c:2667 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
       ext4_expand_extra_isize_ea+0x1306/0x1b20 fs/ext4/xattr.c:2834
       __ext4_expand_extra_isize+0x342/0x470 fs/ext4/inode.c:5769
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5812 [inline]
       __ext4_mark_inode_dirty+0x52b/0x800 fs/ext4/inode.c:5890
       __ext4_unlink+0x65e/0xcd0 fs/ext4/namei.c:3290
       ext4_unlink+0x40b/0x580 fs/ext4/namei.c:3319
       vfs_unlink+0x2f1/0x900 fs/namei.c:4329
       do_unlinkat+0x3da/0x6d0 fs/namei.c:4395
       __do_sys_unlinkat fs/namei.c:4438 [inline]
       __se_sys_unlinkat fs/namei.c:4431 [inline]
       __ia32_sys_unlinkat+0xc1/0x130 fs/namei.c:4431
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> jbd2_handle --> &ei->xattr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->xattr_sem);
                               lock(jbd2_handle);
                               lock(&ei->xattr_sem);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by syz-executor.0/10326:
 #0: ffff88806fdf2410 (sb_writers#4){.+.+}-{0:0}, at: do_unlinkat+0x1ca/0x6d0 fs/namei.c:4376
 #1: ffff888062214000 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:806 [inline]
 #1: ffff888062214000 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0x27c/0x6d0 fs/namei.c:4380
 #2: ffff88802057de00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
 #2: ffff88802057de00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_unlink+0xd3/0x900 fs/namei.c:4318
 #3: ffff88802057dac8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
 #3: ffff88802057dac8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5809 [inline]
 #3: ffff88802057dac8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x4a1/0x800 fs/ext4/inode.c:5890

stack backtrace:
CPU: 0 PID: 10326 Comm: syz-executor.0 Not tainted 6.5.0-rc5-syzkaller-00063-g374a7f47bf40 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
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
 __fs_reclaim_acquire mm/page_alloc.c:3602 [inline]
 fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:3616
 might_alloc include/linux/sched/mm.h:303 [inline]
 slab_pre_alloc_hook mm/slab.h:709 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x51/0x350 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc_node+0x4f/0x100 mm/slab_common.c:992
 kmalloc_node include/linux/slab.h:602 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:604
 kvmalloc include/linux/slab.h:720 [inline]
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1535 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1577 [inline]
 ext4_xattr_set_entry+0x1c3d/0x3c70 fs/ext4/xattr.c:1719
 ext4_xattr_block_set+0x678/0x30e0 fs/ext4/xattr.c:1970
 ext4_xattr_move_to_block fs/ext4/xattr.c:2667 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
 ext4_expand_extra_isize_ea+0x1306/0x1b20 fs/ext4/xattr.c:2834
 __ext4_expand_extra_isize+0x342/0x470 fs/ext4/inode.c:5769
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5812 [inline]
 __ext4_mark_inode_dirty+0x52b/0x800 fs/ext4/inode.c:5890
 __ext4_unlink+0x65e/0xcd0 fs/ext4/namei.c:3290
 ext4_unlink+0x40b/0x580 fs/ext4/namei.c:3319
 vfs_unlink+0x2f1/0x900 fs/namei.c:4329
 do_unlinkat+0x3da/0x6d0 fs/namei.c:4395
 __do_sys_unlinkat fs/namei.c:4438 [inline]
 __se_sys_unlinkat fs/namei.c:4431 [inline]
 __ia32_sys_unlinkat+0xc1/0x130 fs/namei.c:4431
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f1e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f195ac EFLAGS: 00000292 ORIG_RAX: 000000000000012d
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000200003c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
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

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
