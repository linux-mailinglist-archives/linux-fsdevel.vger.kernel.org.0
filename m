Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925316C0681
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 00:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCSXJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 19:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCSXJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 19:09:49 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8E113CB
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Mar 2023 16:09:44 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d5-20020a923605000000b003232594207dso5311417ila.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Mar 2023 16:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679267383;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf6D5zVHNj3B4Nek7JIRPj6kUYmVfSDIwMghwK0jGFg=;
        b=BLiAyr440kfTKFGvgmZIxWKzKClbtNYRe/Ep2v0PScol0Br1pLrEsJ0mxLIzsKNARL
         dse/JrG93aO0dpCm5kzqUx+hfyCQibhx2LZ9wXOxsC9zHbcljerZ5k89Wt+oPMB5HGfF
         Q/pfXks/VDEsj8ljXXdAV/PNkq0ylSGb0UE48jE1eX4RVomZ8XPQWeI+n1uOXISXJT9E
         gsDKMbSkFzZaUbrJwBcs4O7auRnQNxkvY6iqGlxe/9xJsJXRIxD9M4wI+YaK5G/LqgeT
         tKYrtPz9YDc8nCqwd3F1BEK9324t42RB4K4fgrc9dwKh5rvu/U76ZXj7V37Xph7M7/aw
         MbGg==
X-Gm-Message-State: AO0yUKWTGllxXKUtYe2DPQ/2FiWHPGECrAx57HvaN/vN4B9V0V0TmAnF
        cbv87Ct7l+47gbLa8kShAI/Qkavsn2GpPsRrJPCHWbyTtTf3
X-Google-Smtp-Source: AK7set+NsupYtxv41oR1V3HTmnkYmYFL5RiDFkKDeD3+vzA2hqgFADVNJIdesjyauofROWc24vnRMja/wOBIYgGjEhwnBfch9YyU
MIME-Version: 1.0
X-Received: by 2002:a02:a1c9:0:b0:3a9:5ec2:ef41 with SMTP id
 o9-20020a02a1c9000000b003a95ec2ef41mr2288137jah.3.1679267381911; Sun, 19 Mar
 2023 16:09:41 -0700 (PDT)
Date:   Sun, 19 Mar 2023 16:09:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c826b605f748e7f2@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in __btrfs_release_delayed_node (2)
From:   syzbot <syzbot+3ae9507d4e2431b56ff4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    9c1bec9c0b08 Merge tag 'linux-kselftest-fixes-6.3-rc3' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163b8aecc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbab9019ad6fc418
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae9507d4e2431b56ff4
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/adcd3c9a01d5/disk-9c1bec9c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f5bb295bb37/vmlinux-9c1bec9c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/029aafd259b9/bzImage-9c1bec9c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ae9507d4e2431b56ff4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc2-syzkaller-00050-g9c1bec9c0b08 #0 Not tainted
------------------------------------------------------
syz-executor.1/26441 is trying to acquire lock:
ffff8880286e5800 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256

but task is already holding lock:
ffff8880592c24d8 (btrfs-root-01#2){++++}-{3:3}, at: __btrfs_tree_lock+0x3c/0x2a0 fs/btrfs/locking.c:197

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (btrfs-root-01#2){++++}-{3:3}:
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       down_read_nested+0x40/0x60 kernel/locking/rwsem.c:1645
       __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:135
       btrfs_tree_read_lock fs/btrfs/locking.c:141 [inline]
       btrfs_read_lock_root_node+0x292/0x3c0 fs/btrfs/locking.c:280
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1774 [inline]
       btrfs_search_slot+0x571/0x2f70 fs/btrfs/ctree.c:2096
       btrfs_insert_empty_items fs/btrfs/ctree.c:4202 [inline]
       btrfs_insert_empty_item fs/btrfs/ctree.h:646 [inline]
       btrfs_insert_item+0x198/0x3a0 fs/btrfs/ctree.c:4231
       create_pending_snapshot+0xdef/0x28c0 fs/btrfs/transaction.c:1783
       create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1894
       btrfs_commit_transaction+0x1304/0x3440 fs/btrfs/transaction.c:2351
       create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:844
       btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:994
       btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1040
       __btrfs_ioctl_snap_create+0x338/0x450 fs/btrfs/ioctl.c:1293
       btrfs_ioctl_snap_create+0x136/0x190 fs/btrfs/ioctl.c:1320
       btrfs_ioctl+0xbbc/0xd40
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (btrfs-tree-01/7){+.+.}-{3:3}:
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
       __btrfs_tree_lock+0x3c/0x2a0 fs/btrfs/locking.c:197
       btrfs_init_new_buffer fs/btrfs/extent-tree.c:4840 [inline]
       btrfs_alloc_tree_block+0x515/0x1800 fs/btrfs/extent-tree.c:4918
       btrfs_copy_root+0x345/0xcf0 fs/btrfs/ctree.c:327
       create_pending_snapshot+0xcc7/0x28c0 fs/btrfs/transaction.c:1768
       create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1894
       btrfs_commit_transaction+0x1304/0x3440 fs/btrfs/transaction.c:2351
       create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:844
       btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:994
       btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1040
       __btrfs_ioctl_snap_create+0x338/0x450 fs/btrfs/ioctl.c:1293
       btrfs_ioctl_snap_create+0x136/0x190 fs/btrfs/ioctl.c:1320
       btrfs_ioctl+0xbbc/0xd40
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (btrfs-tree-01){++++}-{3:3}:
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       down_read_nested+0x40/0x60 kernel/locking/rwsem.c:1645
       __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:135
       btrfs_tree_read_lock fs/btrfs/locking.c:141 [inline]
       btrfs_read_lock_root_node+0x292/0x3c0 fs/btrfs/locking.c:280
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1774 [inline]
       btrfs_search_slot+0x571/0x2f70 fs/btrfs/ctree.c:2096
       btrfs_insert_empty_items+0x9c/0x180 fs/btrfs/ctree.c:4202
       btrfs_insert_delayed_item fs/btrfs/delayed-inode.c:746 [inline]
       btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:824 [inline]
       __btrfs_commit_inode_delayed_items+0xd53/0x2400 fs/btrfs/delayed-inode.c:1111
       __btrfs_run_delayed_items+0x1db/0x430 fs/btrfs/delayed-inode.c:1153
       flush_space+0x26d/0xe30 fs/btrfs/space-info.c:729
       btrfs_async_reclaim_metadata_space+0x106/0x350 fs/btrfs/space-info.c:1087
       process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
       worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
       kthread+0x270/0x300 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #0 (&delayed_node->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
       __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256
       btrfs_evict_inode+0x6f4/0x1090 fs/btrfs/inode.c:5398
       evict+0x2a4/0x620 fs/inode.c:665
       dispose_list fs/inode.c:698 [inline]
       prune_icache_sb+0x239/0x2e0 fs/inode.c:897
       super_cache_scan+0x376/0x480 fs/super.c:106
       do_shrink_slab+0x544/0xdb0 mm/vmscan.c:853
       shrink_slab_memcg mm/vmscan.c:922 [inline]
       shrink_slab+0x578/0x8c0 mm/vmscan.c:1001
       shrink_node_memcgs mm/vmscan.c:6439 [inline]
       shrink_node+0x1143/0x2730 mm/vmscan.c:6473
       shrink_zones mm/vmscan.c:6711 [inline]
       do_try_to_free_pages+0x67e/0x1900 mm/vmscan.c:6773
       try_to_free_mem_cgroup_pages+0x455/0xa50 mm/vmscan.c:7088
       reclaim_high+0x1e5/0x270 mm/memcontrol.c:2403
       mem_cgroup_handle_over_high+0x14a/0x2b0 mm/memcontrol.c:2588
       try_charge_memcg+0x13b5/0x16d0 mm/memcontrol.c:2826
       try_charge mm/memcontrol.c:2837 [inline]
       charge_memcg+0x11a/0x3f0 mm/memcontrol.c:6960
       __mem_cgroup_charge+0x27/0x80 mm/memcontrol.c:6981
       mem_cgroup_charge include/linux/memcontrol.h:678 [inline]
       __filemap_add_folio+0xe78/0x1b50 mm/filemap.c:857
       filemap_add_folio+0x121/0x580 mm/filemap.c:939
       __filemap_get_folio+0x7d5/0xe50 mm/filemap.c:1981
       pagecache_get_page+0x2c/0x240 mm/folio-compat.c:99
       find_or_create_page include/linux/pagemap.h:632 [inline]
       alloc_extent_buffer+0x252/0xff0 fs/btrfs/extent_io.c:4044
       btrfs_init_new_buffer fs/btrfs/extent-tree.c:4799 [inline]
       btrfs_alloc_tree_block+0x2a0/0x1800 fs/btrfs/extent-tree.c:4918
       __btrfs_cow_block+0x470/0x1830 fs/btrfs/ctree.c:541
       btrfs_cow_block+0x403/0x780 fs/btrfs/ctree.c:696
       btrfs_search_slot+0xc89/0x2f70 fs/btrfs/ctree.c:2136
       del_balance_item fs/btrfs/volumes.c:3502 [inline]
       reset_balance_state+0x1e5/0x3a0 fs/btrfs/volumes.c:3577
       btrfs_balance+0xf17/0x1120 fs/btrfs/volumes.c:4415
       btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3592
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &delayed_node->mutex --> btrfs-tree-01/7 --> btrfs-root-01#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-root-01#2);
                               lock(btrfs-tree-01/7);
                               lock(btrfs-root-01#2);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

8 locks held by syz-executor.1/26441:
 #0: ffff88807eb2e460 (sb_writers#14){.+.+}-{0:0}, at: mnt_want_write_file+0x5e/0x1f0 fs/namespace.c:438
 #1: ffff88807c1cd440 (&fs_info->balance_mutex){+.+.}-{3:3}, at: btrfs_balance+0xbeb/0x1120 fs/btrfs/volumes.c:4381
 #2: ffff88807eb2e650 (sb_internal#2){.+.+}-{0:0}, at: del_balance_item fs/btrfs/volumes.c:3492 [inline]
 #2: ffff88807eb2e650 (sb_internal#2){.+.+}-{0:0}, at: reset_balance_state+0x12e/0x3a0 fs/btrfs/volumes.c:3577
 #3: ffff88807c1ce390 (btrfs_trans_num_writers){++++}-{0:0}, at: spin_unlock include/linux/spinlock.h:390 [inline]
 #3: ffff88807c1ce390 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0xbfd/0xe80 fs/btrfs/transaction.c:287
 #4: ffff88807c1ce3b8 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0xc28/0xe80 fs/btrfs/transaction.c:288
 #5: ffff8880592c24d8 (btrfs-root-01#2){++++}-{3:3}, at: __btrfs_tree_lock+0x3c/0x2a0 fs/btrfs/locking.c:197
 #6: ffffffff8cfd4690 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg mm/vmscan.c:895 [inline]
 #6: ffffffff8cfd4690 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x2dc/0x8c0 mm/vmscan.c:1001
 #7: ffff88807eb2e0e0 (&type->s_umount_key#77){++++}-{3:3}, at: trylock_super fs/super.c:414 [inline]
 #7: ffff88807eb2e0e0 (&type->s_umount_key#77){++++}-{3:3}, at: super_cache_scan+0x77/0x480 fs/super.c:79

stack backtrace:
CPU: 0 PID: 26441 Comm: syz-executor.1 Not tainted 6.3.0-rc2-syzkaller-00050-g9c1bec9c0b08 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
 __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
 lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
 __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256
 btrfs_evict_inode+0x6f4/0x1090 fs/btrfs/inode.c:5398
 evict+0x2a4/0x620 fs/inode.c:665
 dispose_list fs/inode.c:698 [inline]
 prune_icache_sb+0x239/0x2e0 fs/inode.c:897
 super_cache_scan+0x376/0x480 fs/super.c:106
 do_shrink_slab+0x544/0xdb0 mm/vmscan.c:853
 shrink_slab_memcg mm/vmscan.c:922 [inline]
 shrink_slab+0x578/0x8c0 mm/vmscan.c:1001
 shrink_node_memcgs mm/vmscan.c:6439 [inline]
 shrink_node+0x1143/0x2730 mm/vmscan.c:6473
 shrink_zones mm/vmscan.c:6711 [inline]
 do_try_to_free_pages+0x67e/0x1900 mm/vmscan.c:6773
 try_to_free_mem_cgroup_pages+0x455/0xa50 mm/vmscan.c:7088
 reclaim_high+0x1e5/0x270 mm/memcontrol.c:2403
 mem_cgroup_handle_over_high+0x14a/0x2b0 mm/memcontrol.c:2588
 try_charge_memcg+0x13b5/0x16d0 mm/memcontrol.c:2826
 try_charge mm/memcontrol.c:2837 [inline]
 charge_memcg+0x11a/0x3f0 mm/memcontrol.c:6960
 __mem_cgroup_charge+0x27/0x80 mm/memcontrol.c:6981
 mem_cgroup_charge include/linux/memcontrol.h:678 [inline]
 __filemap_add_folio+0xe78/0x1b50 mm/filemap.c:857
 filemap_add_folio+0x121/0x580 mm/filemap.c:939
 __filemap_get_folio+0x7d5/0xe50 mm/filemap.c:1981
 pagecache_get_page+0x2c/0x240 mm/folio-compat.c:99
 find_or_create_page include/linux/pagemap.h:632 [inline]
 alloc_extent_buffer+0x252/0xff0 fs/btrfs/extent_io.c:4044
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4799 [inline]
 btrfs_alloc_tree_block+0x2a0/0x1800 fs/btrfs/extent-tree.c:4918
 __btrfs_cow_block+0x470/0x1830 fs/btrfs/ctree.c:541
 btrfs_cow_block+0x403/0x780 fs/btrfs/ctree.c:696
 btrfs_search_slot+0xc89/0x2f70 fs/btrfs/ctree.c:2136
 del_balance_item fs/btrfs/volumes.c:3502 [inline]
 reset_balance_state+0x1e5/0x3a0 fs/btrfs/volumes.c:3577
 btrfs_balance+0xf17/0x1120 fs/btrfs/volumes.c:4415
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3592
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0f3488c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f35588168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0f349abf80 RCX: 00007f0f3488c0f9
RDX: 0000000020000480 RSI: 00000000c4009420 RDI: 0000000000000007
RBP: 00007f0f348e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc6a443d8f R14: 00007f0f35588300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
