Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5273E26D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFZOtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 10:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjFZOtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:49:06 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929F410C2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 07:49:03 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77b25d256aaso272034439f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 07:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687790943; x=1690382943;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTN8eHqEhul73km71ivyoMn8wepYg6lP56Aehd1zurw=;
        b=gOCArBGQoJsSOxY9ULtogrJu83jlFWSaNHluBe1y/y51rfnlMTLiULVx3NO/eSIMjs
         +GBfUCTCX9SDS1dl1vuI+ji/AUee8AroiWecdfumoAb4Ip7vy6VNTyeqRJsDmCthrMna
         9cTc88W2yzD1tS9rH0nN4DOCkJGmRXZY6q/br3XF6R8zEPWUb1KPOcAK85U3vwtz7SCj
         xvInHo67rj8iS3fFY5b8YjfYZYCCCVlVpWTzv7Azf2V4bmHKGJvN0jXLIlfrRVm50rBI
         sSynEAFpJFlkvSAkPZZFtDt54/IenUlRUMlQlc2PWhriHe7HwobJ/X9/r6YwsMJjwno5
         WesQ==
X-Gm-Message-State: AC+VfDyGn65Uk2Fbl/fpSgppztSZNPxNBCgtBY0CGLVFgfp7Q9FFjOmW
        FN6OgvNE66keyKEd5ZmW2xXb9DCH6M1S7deHP6UqTkvrvh6Q
X-Google-Smtp-Source: ACHHUZ4+hTti2HmsrPZcwfsQg7QEBOd/QgofzbVD+/4rVBXv8S2zC8hQy1eAdXR3PKj0290cJrV312trnSMGQdB9GycUPZebrj5f
MIME-Version: 1.0
X-Received: by 2002:a02:9505:0:b0:423:ea8:4271 with SMTP id
 y5-20020a029505000000b004230ea84271mr10127175jah.6.1687790942937; Mon, 26 Jun
 2023 07:49:02 -0700 (PDT)
Date:   Mon, 26 Jun 2023 07:49:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009be70d05ff097338@google.com>
Subject: [syzbot] [nilfs?] possible deadlock in nilfs_dirty_inode
From:   syzbot <syzbot+903a7b353239d83ad434@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dad9774deaf1 Merge tag 'timers-urgent-2023-06-21' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106a4b33280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=903a7b353239d83ad434
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-dad9774d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04ba8cb302c4/vmlinux-dad9774d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b26d41c591b/bzImage-dad9774d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+903a7b353239d83ad434@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc7-syzkaller-00072-gdad9774deaf1 #0 Not tainted
------------------------------------------------------
kswapd0/111 is trying to acquire lock:
ffff888050c6e650 (sb_internal#3){.+.+}-{0:0}, at: nilfs_dirty_inode+0x18a/0x260 fs/nilfs2/inode.c:1147

but task is already holding lock:
ffffffff8c8efae0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:512 [inline]
ffffffff8c8efae0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7349

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3893 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:3907
       might_alloc include/linux/sched/mm.h:303 [inline]
       prepare_alloc_pages+0x159/0x570 mm/page_alloc.c:4539
       __alloc_pages+0x149/0x4a0 mm/page_alloc.c:4757
       alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
       folio_alloc+0x20/0x70 mm/mempolicy.c:2289
       filemap_alloc_folio+0x3c1/0x470 mm/filemap.c:976
       __filemap_get_folio+0x2a6/0x990 mm/filemap.c:1971
       pagecache_get_page+0x2e/0x270 mm/folio-compat.c:99
       block_write_begin+0x35/0x4d0 fs/buffer.c:2171
       nilfs_write_begin+0xa0/0x1a0 fs/nilfs2/inode.c:261
       page_symlink+0x386/0x480 fs/namei.c:5193
       nilfs_symlink+0x235/0x3c0 fs/nilfs2/namei.c:153
       vfs_symlink fs/namei.c:4475 [inline]
       vfs_symlink+0x10c/0x2c0 fs/namei.c:4459
       do_symlinkat+0x262/0x2e0 fs/namei.c:4501
       __do_sys_symlinkat fs/namei.c:4517 [inline]
       __se_sys_symlinkat fs/namei.c:4514 [inline]
       __ia32_sys_symlinkat+0x97/0xc0 fs/namei.c:4514
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #1 (&nilfs->ns_segctor_sem){++++}-{3:3}:
       down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
       nilfs_transaction_begin+0x31a/0xa20 fs/nilfs2/segment.c:223
       nilfs_create+0x9b/0x300 fs/nilfs2/namei.c:82
       lookup_open.isra.0+0x105a/0x1400 fs/namei.c:3492
       open_last_lookups fs/namei.c:3560 [inline]
       path_openat+0x975/0x2750 fs/namei.c:3788
       do_filp_open+0x1ba/0x410 fs/namei.c:3818
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
       do_sys_open fs/open.c:1372 [inline]
       __do_compat_sys_open fs/open.c:1423 [inline]
       __se_compat_sys_open fs/open.c:1421 [inline]
       __ia32_compat_sys_open+0x11d/0x1c0 fs/open.c:1421
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #0 (sb_internal#3){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
       lock_acquire kernel/locking/lockdep.c:5705 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1494 [inline]
       sb_start_intwrite include/linux/fs.h:1616 [inline]
       nilfs_transaction_begin+0x21e/0xa20 fs/nilfs2/segment.c:220
       nilfs_dirty_inode+0x18a/0x260 fs/nilfs2/inode.c:1147
       __mark_inode_dirty+0x1e0/0xd60 fs/fs-writeback.c:2424
       mark_inode_dirty_sync include/linux/fs.h:2149 [inline]
       iput.part.0+0x57/0x740 fs/inode.c:1770
       iput+0x5c/0x80 fs/inode.c:1763
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
       shrink_dentry_list+0x12c/0x4f0 fs/dcache.c:1201
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
       super_cache_scan+0x33a/0x590 fs/super.c:104
       do_shrink_slab+0x428/0xaa0 mm/vmscan.c:895
       shrink_slab_memcg mm/vmscan.c:964 [inline]
       shrink_slab+0x38f/0x6c0 mm/vmscan.c:1043
       shrink_one+0x4f9/0x710 mm/vmscan.c:5365
       shrink_many mm/vmscan.c:5415 [inline]
       lru_gen_shrink_node mm/vmscan.c:5532 [inline]
       shrink_node+0x1fd5/0x3500 mm/vmscan.c:6473
       kswapd_shrink_node mm/vmscan.c:7273 [inline]
       balance_pgdat+0xa02/0x1ac0 mm/vmscan.c:7463
       kswapd+0x677/0xd60 mm/vmscan.c:7723
       kthread+0x344/0x440 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

Chain exists of:
  sb_internal#3 --> &nilfs->ns_segctor_sem --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&nilfs->ns_segctor_sem);
                               lock(fs_reclaim);
  rlock(sb_internal#3);

 *** DEADLOCK ***

3 locks held by kswapd0/111:
 #0: ffffffff8c8efae0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:512 [inline]
 #0: ffffffff8c8efae0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7349
 #1: ffffffff8c8a3b10 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg mm/vmscan.c:937 [inline]
 #1: ffffffff8c8a3b10 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x2a0/0x6c0 mm/vmscan.c:1043
 #2: ffff888050c6e0e0 (&type->s_umount_key#61){++++}-{3:3}, at: trylock_super fs/super.c:414 [inline]
 #2: ffff888050c6e0e0 (&type->s_umount_key#61){++++}-{3:3}, at: super_cache_scan+0x70/0x590 fs/super.c:79

stack backtrace:
CPU: 0 PID: 111 Comm: kswapd0 Not tainted 6.4.0-rc7-syzkaller-00072-gdad9774deaf1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain kernel/locking/lockdep.c:3847 [inline]
 __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1494 [inline]
 sb_start_intwrite include/linux/fs.h:1616 [inline]
 nilfs_transaction_begin+0x21e/0xa20 fs/nilfs2/segment.c:220
 nilfs_dirty_inode+0x18a/0x260 fs/nilfs2/inode.c:1147
 __mark_inode_dirty+0x1e0/0xd60 fs/fs-writeback.c:2424
 mark_inode_dirty_sync include/linux/fs.h:2149 [inline]
 iput.part.0+0x57/0x740 fs/inode.c:1770
 iput+0x5c/0x80 fs/inode.c:1763
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 shrink_dentry_list+0x12c/0x4f0 fs/dcache.c:1201
 prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
 super_cache_scan+0x33a/0x590 fs/super.c:104
 do_shrink_slab+0x428/0xaa0 mm/vmscan.c:895
 shrink_slab_memcg mm/vmscan.c:964 [inline]
 shrink_slab+0x38f/0x6c0 mm/vmscan.c:1043
 shrink_one+0x4f9/0x710 mm/vmscan.c:5365
 shrink_many mm/vmscan.c:5415 [inline]
 lru_gen_shrink_node mm/vmscan.c:5532 [inline]
 shrink_node+0x1fd5/0x3500 mm/vmscan.c:6473
 kswapd_shrink_node mm/vmscan.c:7273 [inline]
 balance_pgdat+0xa02/0x1ac0 mm/vmscan.c:7463
 kswapd+0x677/0xd60 mm/vmscan.c:7723
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
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
