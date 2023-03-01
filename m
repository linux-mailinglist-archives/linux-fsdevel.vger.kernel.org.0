Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C996A63FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 01:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCAACj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 19:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCAACj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:02:39 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCF6367C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 16:02:37 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id m7-20020a924b07000000b003170cef3f12so7107889ilg.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 16:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FUfIDj4D8j6RMb63P8VxiauNL1Smwo79tHVupo7sXQ=;
        b=ITMP71qgwA858zfBxTHNjhm63ihZ5DB2/GnoS2axZYMRIESoA4bisiFshAYAgQ34hJ
         ZBDL6PZvMGPd+odRXQ5Qfkh1msTgxLqhxiLJuH16uJewCUdf3YMRnGjxfCJToKeRjNxr
         6by/x6hxMw53+EMTOOhgsRoaVD7cVyijZfUwoggBBs5YgRfaR9Qj0zhyc/YxzJ1RneEi
         1+JIP0BfgCN7BKSFg/quokJtql2wVtWdhC70sw4z1Q4WW5csxhP4wtpMWHTErl7GLCOa
         rI80HLTMP9Y/KW2dtNPX8PM0fqeHENHVDMDsGAsmnXXaTeyXKjst+2F0EQqoLELhFg/R
         Mugw==
X-Gm-Message-State: AO0yUKXgBN0aEA8nTu/N4NBhpmkctwkwujEtlqnNSpGlYh61gXTwCtgn
        F2SRgZptLtneyzff2p6gJ5jTw6VIrq/lKS2zBEd7Dv5Fp1sF
X-Google-Smtp-Source: AK7set8eP3JGOiihkwa0Xht5oStOFmLrGikIDEsudE2a47Kd2GwDVQn6txOQVlZFrQ5JUo6NDVGRzspJPPcRm3XlsnhpiKrw2yKs
MIME-Version: 1.0
X-Received: by 2002:a5d:841a:0:b0:745:dfde:ecec with SMTP id
 i26-20020a5d841a000000b00745dfdeececmr2147625ion.1.1677628956854; Tue, 28 Feb
 2023 16:02:36 -0800 (PST)
Date:   Tue, 28 Feb 2023 16:02:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009d6c905f5cb6e07@google.com>
Subject: [syzbot] [ext4?] possible deadlock in start_this_handle (4)
From:   syzbot <syzbot+cf0b4280f19be4031cf2@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a93e884edf61 Merge tag 'driver-core-6.3-rc1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b9dea8c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=537cd86b8ac8f12d
dashboard link: https://syzkaller.appspot.com/bug?extid=cf0b4280f19be4031cf2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf0b4280f19be4031cf2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-syzkaller-10217-ga93e884edf61 #0 Not tainted
------------------------------------------------------
kswapd0/100 is trying to acquire lock:
ffff888043c64990 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xfb4/0x14e0 fs/jbd2/transaction.c:461

but task is already holding lock:
ffffffff8c8e9ae0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
ffffffff8c8e9ae0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
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
       __fscrypt_prepare_lookup+0x2c/0xf0 fs/crypto/hooks.c:100
       fscrypt_prepare_lookup include/linux/fscrypt.h:935 [inline]
       ext4_fname_prepare_lookup+0x1be/0x200 fs/ext4/crypto.c:46
       ext4_lookup_entry fs/ext4/namei.c:1745 [inline]
       ext4_lookup fs/ext4/namei.c:1820 [inline]
       ext4_lookup+0x131/0x700 fs/ext4/namei.c:1811
       __lookup_slow+0x24c/0x460 fs/namei.c:1686
       lookup_slow fs/namei.c:1703 [inline]
       walk_component+0x33f/0x5a0 fs/namei.c:1994
       lookup_last fs/namei.c:2451 [inline]
       path_lookupat+0x1ba/0x840 fs/namei.c:2475
       filename_lookup+0x1d2/0x590 fs/namei.c:2504
       user_path_at_empty+0x46/0x60 fs/namei.c:2877
       user_path_at include/linux/namei.h:57 [inline]
       __do_sys_chdir fs/open.c:515 [inline]
       __se_sys_chdir fs/open.c:509 [inline]
       __ia32_sys_chdir+0xbb/0x260 fs/open.c:509
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #1 (fscrypt_init_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       fscrypt_initialize+0x40/0xa0 fs/crypto/crypto.c:326
       fscrypt_setup_encryption_info+0xef/0xeb0 fs/crypto/keysetup.c:563
       fscrypt_get_encryption_info+0x375/0x450 fs/crypto/keysetup.c:668
       fscrypt_setup_filename+0x23c/0xec0 fs/crypto/fname.c:458
       ext4_fname_setup_filename+0x8c/0x110 fs/ext4/crypto.c:28
       ext4_add_entry+0x3aa/0xe30 fs/ext4/namei.c:2380
       ext4_rename+0x1979/0x2620 fs/ext4/namei.c:3904
       ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4184
       vfs_rename+0xef6/0x17a0 fs/namei.c:4772
       do_renameat2+0xb62/0xc90 fs/namei.c:4923
       __do_sys_renameat2 fs/namei.c:4956 [inline]
       __se_sys_renameat2 fs/namei.c:4953 [inline]
       __ia32_sys_renameat2+0xe8/0x120 fs/namei.c:4953
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #0 (jbd2_handle){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
       start_this_handle+0xfe7/0x14e0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x39d/0x9d0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x706/0x890 fs/ext4/ext4_jbd2.c:111
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0xa5/0x130 fs/ext4/inode.c:6107
       __mark_inode_dirty+0x247/0x1250 fs/fs-writeback.c:2421
       mark_inode_dirty_sync include/linux/fs.h:2132 [inline]
       iput.part.0+0x57/0x8a0 fs/inode.c:1771
       iput+0x5c/0x80 fs/inode.c:1764
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
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

other info that might help us debug this:

Chain exists of:
  jbd2_handle --> fscrypt_init_mutex --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(fscrypt_init_mutex);
                               lock(fs_reclaim);
  lock(jbd2_handle);

 *** DEADLOCK ***

3 locks held by kswapd0/100:
 #0: ffffffff8c8e9ae0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
 #0: ffffffff8c8e9ae0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338
 #1: ffffffff8c8a06d0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg mm/vmscan.c:895 [inline]
 #1: ffffffff8c8a06d0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x2a0/0x660 mm/vmscan.c:1001
 #2: ffff88801b18a0e0 (&type->s_umount_key#31){++++}-{3:3}, at: trylock_super fs/super.c:414 [inline]
 #2: ffff88801b18a0e0 (&type->s_umount_key#31){++++}-{3:3}, at: super_cache_scan+0x70/0x590 fs/super.c:79

stack backtrace:
CPU: 1 PID: 100 Comm: kswapd0 Not tainted 6.2.0-syzkaller-10217-ga93e884edf61 #0
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
 start_this_handle+0xfe7/0x14e0 fs/jbd2/transaction.c:463
 jbd2__journal_start+0x39d/0x9d0 fs/jbd2/transaction.c:520
 __ext4_journal_start_sb+0x706/0x890 fs/ext4/ext4_jbd2.c:111
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0xa5/0x130 fs/ext4/inode.c:6107
 __mark_inode_dirty+0x247/0x1250 fs/fs-writeback.c:2421
 mark_inode_dirty_sync include/linux/fs.h:2132 [inline]
 iput.part.0+0x57/0x8a0 fs/inode.c:1771
 iput+0x5c/0x80 fs/inode.c:1764
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
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
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
