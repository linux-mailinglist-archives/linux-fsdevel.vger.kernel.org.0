Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2480574C20D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 13:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjGILO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 07:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjGILOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 07:14:55 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E431A7
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Jul 2023 04:14:53 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1b890ca6718so41676925ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Jul 2023 04:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688901293; x=1691493293;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zt4SI8WORJdus1Ygq3DWgRwLe4BLynkHwbrmmFqAhyA=;
        b=AFkCbc9MavAUD2ME5jp2mCR8xV1vlLpzgoicmV/PoeX2JjLylI2y6RSFDincLxMe4Z
         elXBJMNuICiaXCVhp+nA5zoEpuDAn4Nx6O6ZJteBM7nftOQ0llf5lhVl1Sbs30bXWV1g
         wx6PxiaSDVVhKV/C4YlEIFSGgkLa/bsrINPFV2eoYkzD/qNTeHPZsyrQNlNcolImzmfm
         p3eLBtnkz/DM1hGguS8buNloR3PYPrTy8zlu3fVHDW6WSLbb9r8FxBjdfAQRwQS8hqvY
         CTk4zrTzWB65kFkxRHpJZdUJ355pnUvbeFYjisTEiV8RqmfKLc4Vha5+YavipJ/vcwJI
         ILyg==
X-Gm-Message-State: ABy/qLYwqcFAXJ7T4xSImDu+hsYTn+HIbZmX9cqGhwgHpys5u7RQ9Fbi
        3bPhiv60+IjTjiMV/UpX7glcZWUe3wPMraRUtFo3ZALP4OtK
X-Google-Smtp-Source: APBJJlFVKu9VbXeBsGdjzUPZ4R+XwnrroRHvXCnaCB791SESJv2SwFL9pg1vV5nC01eHasDD3SAi3NMs3vr4/FBtxgF/a9oOIU4g
MIME-Version: 1.0
X-Received: by 2002:a17:902:ec88:b0:1af:e4e8:6847 with SMTP id
 x8-20020a170902ec8800b001afe4e86847mr9278604plg.1.1688901293226; Sun, 09 Jul
 2023 04:14:53 -0700 (PDT)
Date:   Sun, 09 Jul 2023 04:14:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4c09206000bf929@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_da_get_block_prep
From:   syzbot <syzbot+a86b193140e10df1aff2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d528014517f2 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d1b8aca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d576750da57ebbb5
dashboard link: https://syzkaller.appspot.com/bug?extid=a86b193140e10df1aff2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e5e1d8e2898a/disk-d5280145.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9c6252b0cf2/vmlinux-d5280145.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ecdc540999f3/bzImage-d5280145.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a86b193140e10df1aff2@syzkaller.appspotmail.com

RSP: 002b:00007f8159569168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f81589ac1f0 RCX: 00007f815888c389
RDX: 000000000208e24b RSI: 00000000200001c0 RDI: 0000000000000005
RBP: 00007f81595691d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff9711b43f R14: 00007f8159569300 R15: 0000000000022000
 </TASK>
======================================================
WARNING: possible circular locking dependency detected
6.4.0-syzkaller-11478-gd528014517f2 #0 Not tainted
------------------------------------------------------
syz-executor.4/1427 is trying to acquire lock:
ffffffff8cb06aa0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:303 [inline]
ffffffff8cb06aa0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slab.h:709 [inline]
ffffffff8cb06aa0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3452 [inline]
ffffffff8cb06aa0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc mm/slub.c:3478 [inline]
ffffffff8cb06aa0 (fs_reclaim){+.+.}-{0:0}, at: __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
ffffffff8cb06aa0 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc+0x48/0x380 mm/slub.c:3494

but task is already holding lock:
ffff88816ca53488 (&ei->i_data_sem){++++}-{3:3}, at: ext4_da_map_blocks fs/ext4/inode.c:1735 [inline]
ffff88816ca53488 (&ei->i_data_sem){++++}-{3:3}, at: ext4_da_get_block_prep+0x5d7/0x1170 fs/ext4/inode.c:1813

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->i_data_sem){++++}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       ext4_truncate+0xd50/0x1340 fs/ext4/inode.c:4122
       ext4_setattr+0x1b24/0x2880 fs/ext4/inode.c:5434
       notify_change+0xb2c/0x1180 fs/attr.c:483
       do_truncate+0x143/0x200 fs/open.c:66
       do_sys_ftruncate+0x549/0x780 fs/open.c:194
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xfe9/0x14e0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x390/0x850 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x411/0x5d0 fs/ext4/ext4_jbd2.c:111
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0xa5/0x130 fs/ext4/inode.c:5919
       __mark_inode_dirty+0x1e0/0xd60 fs/fs-writeback.c:2430
       mark_inode_dirty_sync include/linux/fs.h:2153 [inline]
       iput.part.0+0x57/0x740 fs/inode.c:1812
       iput+0x5c/0x80 fs/inode.c:1805
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
       shrink_dentry_list+0x12c/0x4f0 fs/dcache.c:1201
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
       super_cache_scan+0x33a/0x590 fs/super.c:104
       do_shrink_slab+0x428/0xaa0 mm/vmscan.c:900
       shrink_slab+0x175/0x6c0 mm/vmscan.c:1060
       shrink_one+0x4f9/0x710 mm/vmscan.c:5403
       shrink_many mm/vmscan.c:5453 [inline]
       lru_gen_shrink_node mm/vmscan.c:5570 [inline]
       shrink_node+0x20ed/0x3690 mm/vmscan.c:6510
       kswapd_shrink_node mm/vmscan.c:7315 [inline]
       balance_pgdat+0xa02/0x1ac0 mm/vmscan.c:7505
       kswapd+0x677/0xd60 mm/vmscan.c:7765
       kthread+0x344/0x440 kernel/kthread.c:389
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
       lock_acquire kernel/locking/lockdep.c:5761 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
       __fs_reclaim_acquire mm/page_alloc.c:3602 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:3616
       might_alloc include/linux/sched/mm.h:303 [inline]
       slab_pre_alloc_hook mm/slab.h:709 [inline]
       slab_alloc_node mm/slub.c:3452 [inline]
       slab_alloc mm/slub.c:3478 [inline]
       __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
       kmem_cache_alloc+0x48/0x380 mm/slub.c:3494
       kmem_cache_zalloc include/linux/slab.h:693 [inline]
       __es_alloc_extent fs/ext4/extents_status.c:469 [inline]
       ext4_es_insert_delayed_block+0x3e6/0x5d0 fs/ext4/extents_status.c:2044
       ext4_insert_delayed_block fs/ext4/inode.c:1664 [inline]
       ext4_da_map_blocks fs/ext4/inode.c:1752 [inline]
       ext4_da_get_block_prep+0x942/0x1170 fs/ext4/inode.c:1813
       ext4_block_write_begin+0x3be/0xdd0 fs/ext4/inode.c:1043
       ext4_da_write_begin+0x407/0x8c0 fs/ext4/inode.c:2892
       generic_perform_write+0x26b/0x5d0 mm/filemap.c:3923
       ext4_buffered_write_iter+0x123/0x3d0 fs/ext4/file.c:299
       ext4_file_write_iter+0x8f2/0x1880 fs/ext4/file.c:722
       call_write_iter include/linux/fs.h:1871 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x981/0xda0 fs/read_write.c:584
       ksys_write+0x122/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> jbd2_handle --> &ei->i_data_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&ei->i_data_sem);
                               lock(jbd2_handle);
                               lock(&ei->i_data_sem);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by syz-executor.4/1427:
 #0: ffff888092316348 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xd7/0xf0 fs/file.c:1047
 #1: ffff88814c1d0410 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x122/0x250 fs/read_write.c:637
 #2: ffff88816ca53600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
 #2: ffff88816ca53600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb4/0x3d0 fs/ext4/file.c:294
 #3: ffff88816ca53488 (&ei->i_data_sem){++++}-{3:3}, at: ext4_da_map_blocks fs/ext4/inode.c:1735 [inline]
 #3: ffff88816ca53488 (&ei->i_data_sem){++++}-{3:3}, at: ext4_da_get_block_prep+0x5d7/0x1170 fs/ext4/inode.c:1813

stack backtrace:
CPU: 0 PID: 1427 Comm: syz-executor.4 Not tainted 6.4.0-syzkaller-11478-gd528014517f2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x2df/0x3b0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 __fs_reclaim_acquire mm/page_alloc.c:3602 [inline]
 fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:3616
 might_alloc include/linux/sched/mm.h:303 [inline]
 slab_pre_alloc_hook mm/slab.h:709 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x48/0x380 mm/slub.c:3494
 kmem_cache_zalloc include/linux/slab.h:693 [inline]
 __es_alloc_extent fs/ext4/extents_status.c:469 [inline]
 ext4_es_insert_delayed_block+0x3e6/0x5d0 fs/ext4/extents_status.c:2044
 ext4_insert_delayed_block fs/ext4/inode.c:1664 [inline]
 ext4_da_map_blocks fs/ext4/inode.c:1752 [inline]
 ext4_da_get_block_prep+0x942/0x1170 fs/ext4/inode.c:1813
 ext4_block_write_begin+0x3be/0xdd0 fs/ext4/inode.c:1043
 ext4_da_write_begin+0x407/0x8c0 fs/ext4/inode.c:2892
 generic_perform_write+0x26b/0x5d0 mm/filemap.c:3923
 ext4_buffered_write_iter+0x123/0x3d0 fs/ext4/file.c:299
 ext4_file_write_iter+0x8f2/0x1880 fs/ext4/file.c:722
 call_write_iter include/linux/fs.h:1871 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x981/0xda0 fs/read_write.c:584
 ksys_write+0x122/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f815888c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8159569168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f81589ac1f0 RCX: 00007f815888c389
RDX: 000000000208e24b RSI: 00000000200001c0 RDI: 0000000000000005
RBP: 00007f81595691d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff9711b43f R14: 00007f8159569300 R15: 0000000000022000
 </TASK>


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
