Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78036A5E2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 18:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjB1RZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 12:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1RZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:25:58 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71DC23334
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 09:25:56 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id v18-20020a056e0213d200b00316ec11c950so6332913ilj.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 09:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1USnl8MtnA5ZtjNjR6lFvcohF5NOmt2VPi777HyuJA=;
        b=wfqg3GCUGTeA2ngX4a8ACl7UB1IpYXTA3VW4csJnwMusw1TAJ7SY8PmAntbeEat0Ol
         LhRXsgbsKDr6LbBG/Wb9i08BwZ9z5A0TQugv98ZImlCD9tUF8TM2rBHIDgBSBxp/ANkz
         XC9w4SGZDHWZmZh2frYJcbALziZ9LYKffzZCEVVtksFUGkGwZ2i1lZ0UKWybSf5S2h1F
         HcAImtTUm6BPnqT97hBr7sx/XW6F0e8AHu6yKtBdTGWTFHwWgTJ3vXJKZ1SydMWI74dm
         uQSLSB3Bdavl7waFBHWop/mwyDfFoMkS7VSS1ZBUwh0OYy1F8j9tlB9RbdI81ThCaS9R
         N76Q==
X-Gm-Message-State: AO0yUKX4Misi5Myy9/00O8iPGtzVm04McYi0TQzzOyo5HaZWvmcyJ16K
        +R5Ukmbe59cn6WzZ3GN7L3hzGp0P708U9Mw/JXkOP+aGghaD
X-Google-Smtp-Source: AK7set9FICUYUGCmfAt24hhZBkPfC8lvSbtL6mC9NCVJmtdgtS51Zvf0KrEboSBJTVFapyFQFLZfJhn9cJvcBse4vUssGl+8Z5L8
MIME-Version: 1.0
X-Received: by 2002:a05:6602:210b:b0:74d:5a9:b55a with SMTP id
 x11-20020a056602210b00b0074d05a9b55amr1654209iox.0.1677605155999; Tue, 28 Feb
 2023 09:25:55 -0800 (PST)
Date:   Tue, 28 Feb 2023 09:25:55 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065970505f5c5e3fb@google.com>
Subject: [syzbot] [ext4?] possible deadlock in evict (3)
From:   syzbot <syzbot+dd426ae4af71f1e74729@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
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

HEAD commit:    ae3419fbac84 vc_screen: don't clobber return value in vcs_..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1136fe18c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff98a3b3c1aed3ab
dashboard link: https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd426ae4af71f1e74729@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-syzkaller-12913-gae3419fbac84 #0 Not tainted
------------------------------------------------------
kswapd0/100 is trying to acquire lock:
ffff888047aea650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:665

but task is already holding lock:
ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4716 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4730
       might_alloc include/linux/sched/mm.h:271 [inline]
       prepare_alloc_pages+0x159/0x570 mm/page_alloc.c:5362
       __alloc_pages+0x149/0x5c0 mm/page_alloc.c:5580
       alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
       __get_free_pages+0xc/0x40 mm/page_alloc.c:5641
       kasan_populate_vmalloc_pte mm/kasan/shadow.c:309 [inline]
       kasan_populate_vmalloc_pte+0x27/0x150 mm/kasan/shadow.c:300
       apply_to_pte_range mm/memory.c:2578 [inline]
       apply_to_pmd_range mm/memory.c:2622 [inline]
       apply_to_pud_range mm/memory.c:2658 [inline]
       apply_to_p4d_range mm/memory.c:2694 [inline]
       __apply_to_page_range+0x68c/0x1030 mm/memory.c:2728
       alloc_vmap_area+0x536/0x1f20 mm/vmalloc.c:1638
       __get_vm_area_node+0x145/0x3f0 mm/vmalloc.c:2495
       __vmalloc_node_range+0x250/0x1300 mm/vmalloc.c:3141
       kvmalloc_node+0x156/0x1a0 mm/util.c:628
       kvmalloc include/linux/slab.h:737 [inline]
       ext4_xattr_move_to_block fs/ext4/xattr.c:2570 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2685 [inline]
       ext4_expand_extra_isize_ea+0x7d5/0x1680 fs/ext4/xattr.c:2777
       __ext4_expand_extra_isize+0x33e/0x470 fs/ext4/inode.c:5957
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6000 [inline]
       __ext4_mark_inode_dirty+0x534/0x950 fs/ext4/inode.c:6078
       ext4_inline_data_truncate+0x610/0xd70 fs/ext4/inline.c:2020
       ext4_truncate+0xa5b/0x1620 fs/ext4/inode.c:4298
       ext4_process_orphan+0x158/0x410 fs/ext4/orphan.c:339
       ext4_orphan_cleanup+0x6e5/0x1110 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5500 [inline]
       ext4_fill_super+0xa22f/0xb1f0 fs/ext4/super.c:5628
       get_tree_bdev+0x444/0x760 fs/super.c:1294
       vfs_get_tree+0x8d/0x350 fs/super.c:1501
       do_new_mount fs/namespace.c:3042 [inline]
       path_mount+0x1342/0x1e40 fs/namespace.c:3372
       do_mount fs/namespace.c:3385 [inline]
       __do_sys_mount fs/namespace.c:3594 [inline]
       __se_sys_mount fs/namespace.c:3571 [inline]
       __x64_sys_mount+0x283/0x300 fs/namespace.c:3571
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_xattr_set_handle+0x160/0x1510 fs/ext4/xattr.c:2321
       ext4_initxattrs+0xb9/0x120 fs/ext4/xattr_security.c:44
       security_inode_init_security+0x1c8/0x370 security/security.c:1147
       __ext4_new_inode+0x3b03/0x5890 fs/ext4/ialloc.c:1324
       ext4_create+0x2da/0x4e0 fs/ext4/namei.c:2809
       lookup_open.isra.0+0x105a/0x1400 fs/namei.c:3416
       open_last_lookups fs/namei.c:3484 [inline]
       path_openat+0x975/0x2750 fs/namei.c:3712
       do_filp_open+0x1ba/0x410 fs/namei.c:3742
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1348
       do_sys_open fs/open.c:1364 [inline]
       __do_sys_openat fs/open.c:1380 [inline]
       __se_sys_openat fs/open.c:1375 [inline]
       __x64_sys_openat+0x143/0x1f0 fs/open.c:1375
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xfe7/0x14e0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x39d/0x9d0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x706/0x890 fs/ext4/ext4_jbd2.c:111
       ext4_sample_last_mounted fs/ext4/file.c:841 [inline]
       ext4_file_open+0x618/0xbf0 fs/ext4/file.c:870
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

-> #0 (sb_internal){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
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
  sb_internal --> &ei->xattr_sem --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&ei->xattr_sem);
                               lock(fs_reclaim);
  lock(sb_internal);

 *** DEADLOCK ***

3 locks held by kswapd0/100:
 #0: ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
 #0: ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338
 #1: ffffffff8c8995d0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg mm/vmscan.c:895 [inline]
 #1: ffffffff8c8995d0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x2a0/0x660 mm/vmscan.c:1001
 #2: ffff888047aea0e0 (&type->s_umount_key#50){++++}-{3:3}, at: trylock_super fs/super.c:414 [inline]
 #2: ffff888047aea0e0 (&type->s_umount_key#50){++++}-{3:3}, at: super_cache_scan+0x70/0x590 fs/super.c:79

stack backtrace:
CPU: 2 PID: 100 Comm: kswapd0 Not tainted 6.2.0-syzkaller-12913-gae3419fbac84 #0
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
