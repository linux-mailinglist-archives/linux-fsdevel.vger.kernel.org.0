Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C476EC7AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 10:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjDXILl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDXILj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:11:39 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022EA1B7
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 01:11:38 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32b532ee15bso158276335ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 01:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682323897; x=1684915897;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=la37d+qfPeKJVd2GQq3nMgGF4BXmkpQNTs8xfb02sr0=;
        b=lFDIBrl+9MeAV/eNV1QKuzx+x/8TbQJIJ1Ie+60BCNPAp6EdcHz9G7ivwu5yj/z+iW
         tuXdK1MK+4zvkYsVTKLWWoVt6gRb4xnQ0HqsH247v4RfG0B0VwN+Q4eEUq+ywFQYdk7L
         b/SbbbxQiMUFEpQBuyQlXVXnfIpYurQ/8bpDhQAgjR94edNmqxxKZvUPtvcqUwVMZV3p
         rWtJMrFaYiCKKUzdOtDmfI/Hl31C4BiRbgaK3gRDXD0cjQqMS2hXfVmvgOKNGP8xv/qd
         n+5Zk5vz6ljtx936mhKZ1CazN6UBs5dkihp+ZQEQlqZSRm0MYo3MSEl3eE8deZRyJe9W
         rfgQ==
X-Gm-Message-State: AAQBX9cqjAA4oEe5quy5dt7jxCggbiayo01egkjNcrndKLrX4Et82+1K
        VfDzUsO2LXfaZPrXr6helWbcpeIqFRSDWlXsxtrfLJh2xt/n
X-Google-Smtp-Source: AKy350ZqU5Bed8pxPoOPyzjcqzZoYYhNb5ceSd8Uf+oAdrTomw2mMygTIRTlvnmvguaMZx21hftKFdQ/mCDf3CTxIWHEHDpnZV2B
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:32b:fc:52b1 with SMTP id
 i11-20020a056e021d0b00b0032b00fc52b1mr5819575ila.0.1682323897343; Mon, 24 Apr
 2023 01:11:37 -0700 (PDT)
Date:   Mon, 24 Apr 2023 01:11:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c66b405fa108e27@google.com>
Subject: [syzbot] [fs?] [mm?] possible deadlock in do_writepages
From:   syzbot <syzbot+6898da502aef574c5f8a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    e8d018dd0257 Linux 6.3-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cd8a86c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cde06fe2cf5765b7
dashboard link: https://syzkaller.appspot.com/bug?extid=6898da502aef574c5f8a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6898da502aef574c5f8a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/100 is trying to acquire lock:
ffff88801e636b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551

but task is already holding lock:
ffffffff8c8e1280 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
ffffffff8c8e1280 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4716 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4730
       might_alloc include/linux/sched/mm.h:271 [inline]
       slab_pre_alloc_hook mm/slab.h:728 [inline]
       slab_alloc_node mm/slab.c:3241 [inline]
       slab_alloc mm/slab.c:3266 [inline]
       __kmem_cache_alloc_lru mm/slab.c:3443 [inline]
       kmem_cache_alloc+0x3d/0x3f0 mm/slab.c:3452
       kmem_cache_zalloc include/linux/slab.h:710 [inline]
       ext4_init_io_end+0x27/0x180 fs/ext4/page-io.c:278
       ext4_do_writepages+0xbea/0x31e0 fs/ext4/inode.c:2824
       ext4_writepages+0x27c/0x5e0 fs/ext4/inode.c:2964
       do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
       __writeback_single_inode+0x121/0xdc0 fs/fs-writeback.c:1600
       writeback_sb_inodes+0x54d/0xe70 fs/fs-writeback.c:1891
       __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1962
       wb_writeback+0x7e9/0xa50 fs/fs-writeback.c:2067
       wb_check_background_flush fs/fs-writeback.c:2133 [inline]
       wb_do_writeback fs/fs-writeback.c:2221 [inline]
       wb_workfn+0x8b0/0xfc0 fs/fs-writeback.c:2248
       process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
       worker_thread+0x669/0x1090 kernel/workqueue.c:2537
       kthread+0x2e8/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #0 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       ext4_writepages+0x1a9/0x5e0 fs/ext4/inode.c:2963
       do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
       __writeback_single_inode+0x121/0xdc0 fs/fs-writeback.c:1600
       writeback_single_inode+0x2ad/0x590 fs/fs-writeback.c:1721
       write_inode_now+0x16e/0x1e0 fs/fs-writeback.c:2757
       iput_final fs/inode.c:1735 [inline]
       iput.part.0+0x408/0x740 fs/inode.c:1774
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

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&sbi->s_writepages_rwsem);
                               lock(fs_reclaim);
  lock(&sbi->s_writepages_rwsem);

 *** DEADLOCK ***

3 locks held by kswapd0/100:
 #0: ffffffff8c8e1280 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
 #0: ffffffff8c8e1280 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338
 #1: ffffffff8c8980b0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg mm/vmscan.c:895 [inline]
 #1: ffffffff8c8980b0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x2a0/0x660 mm/vmscan.c:1001
 #2: ffff88801e6300e0 (&type->s_umount_key#50){++++}-{3:3}, at: trylock_super fs/super.c:414 [inline]
 #2: ffff88801e6300e0 (&type->s_umount_key#50){++++}-{3:3}, at: super_cache_scan+0x70/0x590 fs/super.c:79

stack backtrace:
CPU: 1 PID: 100 Comm: kswapd0 Not tainted 6.3.0-rc3-syzkaller #0
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
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 ext4_writepages+0x1a9/0x5e0 fs/ext4/inode.c:2963
 do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
 __writeback_single_inode+0x121/0xdc0 fs/fs-writeback.c:1600
 writeback_single_inode+0x2ad/0x590 fs/fs-writeback.c:1721
 write_inode_now+0x16e/0x1e0 fs/fs-writeback.c:2757
 iput_final fs/inode.c:1735 [inline]
 iput.part.0+0x408/0x740 fs/inode.c:1774
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
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 1 PID: 100 at fs/ext4/inode.c:5325 ext4_write_inode+0x337/0x590 fs/ext4/inode.c:5325
Modules linked in:
CPU: 1 PID: 100 Comm: kswapd0 Not tainted 6.3.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:ext4_write_inode+0x337/0x590 fs/ext4/inode.c:5325
Code: b6 04 02 84 c0 74 08 3c 03 0f 8e 3d 02 00 00 8b b5 b0 06 00 00 4c 89 f7 e8 c6 94 12 00 41 89 c4 e9 ed fd ff ff e8 e9 4e 5a ff <0f> 0b 45 31 e4 e9 de fd ff ff e8 da 4e 5a ff 48 89 ef 48 8d 74 24
RSP: 0018:ffffc90000c87360 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff92000190e6c RCX: 0000000000000000
RDX: ffff8880169700c0 RSI: ffffffff8227b6c7 RDI: 0000000000000005
RBP: ffff8880283852f0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000800 R11: 3e4b5341542f3c20 R12: 0000000000000800
R13: ffffc90000c874e0 R14: dffffc0000000000 R15: ffff888028385318
FS:  0000000000000000(0000) GS:ffff88802ca80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe7eabfe718 CR3: 00000000738f6000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 write_inode fs/fs-writeback.c:1453 [inline]
 __writeback_single_inode+0x9f8/0xdc0 fs/fs-writeback.c:1665
 writeback_single_inode+0x2ad/0x590 fs/fs-writeback.c:1721
 write_inode_now+0x16e/0x1e0 fs/fs-writeback.c:2757
 iput_final fs/inode.c:1735 [inline]
 iput.part.0+0x408/0x740 fs/inode.c:1774
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
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
