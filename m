Return-Path: <linux-fsdevel+bounces-17923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABF48B3CCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 18:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95711C20CAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A85FB84;
	Fri, 26 Apr 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV4UfQP5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6137B;
	Fri, 26 Apr 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149010; cv=none; b=kNwGVi79xBfqVWRdBxFPrQv21MhAHvMtRhDGyz3me9LwrCYNqzdH6DBTNZgAz+lCbzutXwuexlciif8aeyJMqVxM57k5eZFEK6Nt6K8MyH/vkgwYcarfdkV3K+CMoskq6qcWrMFShhI4LurWfVP4xZXfXRnbr4NKo1CDYJwqsJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149010; c=relaxed/simple;
	bh=gpDQKYQMFKZ4S+X+3QY6KF7XzWXstq7o9H1quTSD7nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzLbIMSn/JIOLrEdAKepQqRaZX5vt/jWRh/qFpvHu2+TT7XasdYKJupN3H9Gk9gqjwJWd0ZEVrEd5ZGEuvZOMmacOrfX9WoGREB41Y8t0UVN6MgV7Z3Bk+DIR6bsBt2jS4ZLUXp2tRBuNzDupW9EcjEubl5/aYMXSpVpUEFBNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV4UfQP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7B6C113CD;
	Fri, 26 Apr 2024 16:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714149009;
	bh=gpDQKYQMFKZ4S+X+3QY6KF7XzWXstq7o9H1quTSD7nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GV4UfQP5+96B2mcoV8emZo/qv7wgBUyKBZIpdyScu03ZoGXfjBdxK8g61sbPBvsy5
	 2HeDd2PKMU9nSGda6bvzi4FMrSHFRLspHroJsK3mOIwVLtgfLWpmB2BYJS6oARpAPN
	 hZSKftgalHNORnt9LIH0MbRdllW4XpJ1gJwY15hA1bNln17wXuaQCw40mUJOy/slok
	 WGpBKFnRAnX21vlSSmCcmkG05rO32WyWFurtEi05IADAeUf6j+6UVjErCaFZCcTm60
	 nxZqqHksjCHNozCRRElSXqkLcV5ogpfqSTyJitjaUtAkmvAZHc7bUlh4RurEtIZ6HF
	 A4bBbIbyOlBvg==
Date: Fri, 26 Apr 2024 09:30:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: syzbot <syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_fs_dirty_inode
Message-ID: <20240426163008.GO360919@frogsfrogsfrogs>
References: <000000000000fee02e0616f8fdff@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fee02e0616f8fdff@google.com>

On Thu, Apr 25, 2024 at 10:15:29PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3b68086599f8 Merge tag 'sched_urgent_for_v6.9_rc5' of git:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=158206bb180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
> dashboard link: https://syzkaller.appspot.com/bug?extid=1619d847a7b9ba3a9137
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/caa90b55d476/disk-3b680865.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/17940f1c5e8f/vmlinux-3b680865.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b03bd6929a1c/bzImage-3b680865.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.9.0-rc4-syzkaller-00274-g3b68086599f8 #0 Not tainted
> ------------------------------------------------------
> kswapd0/81 is trying to acquire lock:
> ffff8881a895a610 (sb_internal#3){.+.+}-{0:0}, at: xfs_fs_dirty_inode+0x158/0x250 fs/xfs/xfs_super.c:689
> 
> but task is already holding lock:
> ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6782 [inline]
> ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb20/0x30c0 mm/vmscan.c:7164
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (fs_reclaim){+.+.}-{0:0}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
>        fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3712
>        might_alloc include/linux/sched/mm.h:312 [inline]
>        slab_pre_alloc_hook mm/slub.c:3746 [inline]
>        slab_alloc_node mm/slub.c:3827 [inline]
>        kmalloc_trace+0x47/0x360 mm/slub.c:3992
>        kmalloc include/linux/slab.h:628 [inline]
>        add_stack_record_to_list mm/page_owner.c:177 [inline]
>        inc_stack_record_count mm/page_owner.c:219 [inline]
>        __set_page_owner+0x561/0x810 mm/page_owner.c:334
>        set_page_owner include/linux/page_owner.h:32 [inline]
>        post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
>        prep_new_page mm/page_alloc.c:1541 [inline]
>        get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
>        __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
>        __alloc_pages_node include/linux/gfp.h:238 [inline]
>        alloc_pages_node include/linux/gfp.h:261 [inline]
>        alloc_slab_page+0x5f/0x160 mm/slub.c:2175
>        allocate_slab mm/slub.c:2338 [inline]
>        new_slab+0x84/0x2f0 mm/slub.c:2391
>        ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
>        __slab_alloc mm/slub.c:3610 [inline]
>        __slab_alloc_node mm/slub.c:3663 [inline]
>        slab_alloc_node mm/slub.c:3835 [inline]
>        kmem_cache_alloc+0x252/0x340 mm/slub.c:3852
>        kmem_cache_zalloc include/linux/slab.h:739 [inline]
>        xfs_btree_alloc_cursor fs/xfs/libxfs/xfs_btree.h:679 [inline]
>        xfs_refcountbt_init_cursor+0x65/0x2a0 fs/xfs/libxfs/xfs_refcount_btree.c:367
>        xfs_reflink_find_shared fs/xfs/xfs_reflink.c:147 [inline]
>        xfs_reflink_trim_around_shared+0x53a/0x9d0 fs/xfs/xfs_reflink.c:194
>        xfs_buffered_write_iomap_begin+0xebf/0x1b40 fs/xfs/xfs_iomap.c:1062

Hm.  We've taken an ILOCK in xfs_buffered_write_iomap_begin, and now
we're allocating a btree cursor but we don't have PF_MEMALLOC_NOFS set,
nor do we pass GFP_NOFS.

Ah, because nothing in this code path sets PF_MEMALLOC_NOFS explicitly,
nor does it create a xfs_trans_alloc_empty, which would set that.  Prior
to the removal of kmem_alloc, I think we were much more aggressive about
GFP_NOFS usage.

Seeing as we're about to walk a btree, we probably want the empty
transaction to guard against btree cycle livelocks.

--D

>        iomap_iter+0x691/0xf60 fs/iomap/iter.c:91
>        iomap_file_unshare+0x17a/0x710 fs/iomap/buffered-io.c:1364
>        xfs_reflink_unshare+0x173/0x5f0 fs/xfs/xfs_reflink.c:1710
>        xfs_file_fallocate+0x87c/0xd00 fs/xfs/xfs_file.c:1082
>        vfs_fallocate+0x564/0x6c0 fs/open.c:330
>        ksys_fallocate fs/open.c:353 [inline]
>        __do_sys_fallocate fs/open.c:361 [inline]
>        __se_sys_fallocate fs/open.c:359 [inline]
>        __x64_sys_fallocate+0xbd/0x110 fs/open.c:359
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #1 (&xfs_nondir_ilock_class#3){++++}-{3:3}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
>        xfs_dquot_disk_alloc+0x399/0xe50 fs/xfs/xfs_dquot.c:332
>        xfs_qm_dqread+0x1a3/0x650 fs/xfs/xfs_dquot.c:693
>        xfs_qm_dqget+0x2bb/0x6f0 fs/xfs/xfs_dquot.c:905
>        xfs_qm_quotacheck_dqadjust+0xea/0x5a0 fs/xfs/xfs_qm.c:1096
>        xfs_qm_dqusage_adjust+0x4db/0x6f0 fs/xfs/xfs_qm.c:1215
>        xfs_iwalk_ag_recs+0x4e0/0x860 fs/xfs/xfs_iwalk.c:213
>        xfs_iwalk_run_callbacks+0x218/0x470 fs/xfs/xfs_iwalk.c:372
>        xfs_iwalk_ag+0xa39/0xb50 fs/xfs/xfs_iwalk.c:478
>        xfs_iwalk_ag_work+0xfb/0x1b0 fs/xfs/xfs_iwalk.c:620
>        xfs_pwork_work+0x7f/0x190 fs/xfs/xfs_pwork.c:47
>        process_one_work kernel/workqueue.c:3254 [inline]
>        process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
>        worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>        kthread+0x2f0/0x390 kernel/kthread.c:388
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> -> #0 (sb_internal#3){.+.+}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write include/linux/fs.h:1664 [inline]
>        sb_start_intwrite include/linux/fs.h:1847 [inline]
>        xfs_trans_alloc+0xe5/0x830 fs/xfs/xfs_trans.c:264
>        xfs_fs_dirty_inode+0x158/0x250 fs/xfs/xfs_super.c:689
>        __mark_inode_dirty+0x325/0xe20 fs/fs-writeback.c:2477
>        mark_inode_dirty_sync include/linux/fs.h:2410 [inline]
>        iput+0x1fe/0x930 fs/inode.c:1764
>        __dentry_kill+0x20d/0x630 fs/dcache.c:603
>        shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
>        shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
>        prune_dcache_sb+0x10f/0x180 fs/dcache.c:1156
>        super_cache_scan+0x34f/0x4b0 fs/super.c:221
>        do_shrink_slab+0x705/0x1160 mm/shrinker.c:435
>        shrink_slab_memcg mm/shrinker.c:548 [inline]
>        shrink_slab+0x883/0x14d0 mm/shrinker.c:626
>        shrink_node_memcgs mm/vmscan.c:5875 [inline]
>        shrink_node+0x11f5/0x2d60 mm/vmscan.c:5908
>        kswapd_shrink_node mm/vmscan.c:6704 [inline]
>        balance_pgdat mm/vmscan.c:6895 [inline]
>        kswapd+0x1a25/0x30c0 mm/vmscan.c:7164
>        kthread+0x2f0/0x390 kernel/kthread.c:388
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   sb_internal#3 --> &xfs_nondir_ilock_class#3 --> fs_reclaim
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(&xfs_nondir_ilock_class#3);
>                                lock(fs_reclaim);
>   rlock(sb_internal#3);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by kswapd0/81:
>  #0: ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6782 [inline]
>  #0: ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb20/0x30c0 mm/vmscan.c:7164
>  #1: ffff8881a895a0e0 (&type->s_umount_key#65){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
>  #1: ffff8881a895a0e0 (&type->s_umount_key#65){++++}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196
> 
> stack backtrace:
> CPU: 1 PID: 81 Comm: kswapd0 Not tainted 6.9.0-rc4-syzkaller-00274-g3b68086599f8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>  percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>  __sb_start_write include/linux/fs.h:1664 [inline]
>  sb_start_intwrite include/linux/fs.h:1847 [inline]
>  xfs_trans_alloc+0xe5/0x830 fs/xfs/xfs_trans.c:264
>  xfs_fs_dirty_inode+0x158/0x250 fs/xfs/xfs_super.c:689
>  __mark_inode_dirty+0x325/0xe20 fs/fs-writeback.c:2477
>  mark_inode_dirty_sync include/linux/fs.h:2410 [inline]
>  iput+0x1fe/0x930 fs/inode.c:1764
>  __dentry_kill+0x20d/0x630 fs/dcache.c:603
>  shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
>  shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
>  prune_dcache_sb+0x10f/0x180 fs/dcache.c:1156
>  super_cache_scan+0x34f/0x4b0 fs/super.c:221
>  do_shrink_slab+0x705/0x1160 mm/shrinker.c:435
>  shrink_slab_memcg mm/shrinker.c:548 [inline]
>  shrink_slab+0x883/0x14d0 mm/shrinker.c:626
>  shrink_node_memcgs mm/vmscan.c:5875 [inline]
>  shrink_node+0x11f5/0x2d60 mm/vmscan.c:5908
>  kswapd_shrink_node mm/vmscan.c:6704 [inline]
>  balance_pgdat mm/vmscan.c:6895 [inline]
>  kswapd+0x1a25/0x30c0 mm/vmscan.c:7164
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> NILFS (loop4): discard dirty page: offset=98304, ino=3
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty block: blocknr=0, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty page: offset=0, ino=12
> NILFS (loop4): discard dirty block: blocknr=17, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty page: offset=0, ino=3
> NILFS (loop4): discard dirty block: blocknr=42, size=1024
> NILFS (loop4): discard dirty block: blocknr=43, size=1024
> NILFS (loop4): discard dirty block: blocknr=44, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty page: offset=4096, ino=6
> NILFS (loop4): discard dirty block: blocknr=39, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty page: offset=196608, ino=3
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> NILFS (loop4): discard dirty block: blocknr=49, size=1024
> NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

