Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79786A83C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 14:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCBNsz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 2 Mar 2023 08:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCBNsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:48:53 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0D372B0
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 05:48:49 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id 207-20020a6b14d8000000b0074ca9a558feso10509298iou.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 05:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0s2n4U5y0qKV4svJ5D+gJl05Fkw00Nr7kj69wlYYI9Q=;
        b=WYCwvLj/KeKnQ7DvupLXKTQkatr+0HdzTA1brmBuiA4o9eOBpdTHbSMCfKitWjc7MJ
         25KIzcYIKNk3DnQP5YlN8aItXxD8FidtzTBq9HujTmofNBn4pNqw34joCkfTcWv43iBj
         DLQvO1WsORN8JGlObSR9MK+dUWwZBwddHL83Q1ylAVzml/95BOjZizJx9H01gvdv7o1v
         U+PPChViJl9eNvJUYs1haFIuv90KaUxvIz+CoZbEL5XqMNQxXlim35MWNnNPWR7TK15y
         ZEcPWfGY8of3FAUBMNYNxKf9OdOg0njO1Yf5VfJJCQCg9DjvGkHUxGlG0nGWpkGJyAG6
         4X1g==
X-Gm-Message-State: AO0yUKWkMhyoxKdcS7+BRjucV7CiwdhIgL4ku4pF62AB17OPLbGJ5hsQ
        /Pn5lhrB9sYeA9kHe3bfVZZ2s2mApgDne7eQGZNan61yzFzs
X-Google-Smtp-Source: AK7set9+75V439adTzr1+IspZI9EC1OGrWvQYxtdnXKxoR4q+EXHCOJmR4y45Y9W/pbqycIAp+7VeGxV3yQ7hvhoyvb+HdAPER1g
MIME-Version: 1.0
X-Received: by 2002:a02:84c9:0:b0:3a9:75c9:da25 with SMTP id
 f67-20020a0284c9000000b003a975c9da25mr4642012jai.1.1677764928525; Thu, 02 Mar
 2023 05:48:48 -0800 (PST)
Date:   Thu, 02 Mar 2023 05:48:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094dd1005f5eb162c@google.com>
Subject: [syzbot] [ext4?] possible deadlock in __ext4_mark_inode_dirty
From:   syzbot <syzbot+9fcd24c261324f545b8a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

HEAD commit:    1ec35eadc3b4 Merge tag 'clk-for-linus' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17dfa4b0c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56eb47529ec6fdbe
dashboard link: https://syzkaller.appspot.com/bug?extid=9fcd24c261324f545b8a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9fcd24c261324f545b8a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-syzkaller-12017-g1ec35eadc3b4 #0 Not tainted
------------------------------------------------------
syz-executor.3/12021 is trying to acquire lock:
ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:271 [inline]
ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: prepare_alloc_pages+0x159/0x570 mm/page_alloc.c:5362

but task is already holding lock:
ffff8880268143c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
ffff8880268143c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5997 [inline]
ffff8880268143c8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x4a8/0x950 fs/ext4/inode.c:6078

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ei->xattr_sem){++++}-{3:3}:
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
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1312
       do_sys_open fs/open.c:1328 [inline]
       __do_sys_openat fs/open.c:1344 [inline]
       __se_sys_openat fs/open.c:1339 [inline]
       __x64_sys_openat+0x143/0x1f0 fs/open.c:1339
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xfe7/0x14e0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x39d/0x9d0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x706/0x890 fs/ext4/ext4_jbd2.c:111
       ext4_sample_last_mounted fs/ext4/file.c:841 [inline]
       ext4_file_open+0x618/0xbf0 fs/ext4/file.c:870
       do_dentry_open+0x6cc/0x13f0 fs/open.c:884
       do_open fs/namei.c:3560 [inline]
       path_openat+0x1baa/0x2750 fs/namei.c:3715
       do_filp_open+0x1ba/0x410 fs/namei.c:3742
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1312
       do_sys_open fs/open.c:1328 [inline]
       __do_sys_openat fs/open.c:1344 [inline]
       __se_sys_openat fs/open.c:1339 [inline]
       __x64_sys_openat+0x143/0x1f0 fs/open.c:1339
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (sb_internal){.+.+}-{0:0}:
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

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
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

3 locks held by syz-executor.3/12021:
 #0: ffff88801df260e0 (&type->s_umount_key#27/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
 #1: ffff888026814700 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:758 [inline]
 #1: ffff888026814700 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: ext4_process_orphan+0x109/0x410 fs/ext4/orphan.c:337
 #2: ffff8880268143c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
 #2: ffff8880268143c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5997 [inline]
 #2: ffff8880268143c8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x4a8/0x950 fs/ext4/inode.c:6078

stack backtrace:
CPU: 1 PID: 12021 Comm: syz-executor.3 Not tainted 6.2.0-syzkaller-12017-g1ec35eadc3b4 #0
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
RIP: 0033:0x7fd350c8d62a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd3519bff88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000000042c RCX: 00007fd350c8d62a
RDX: 0000000020000440 RSI: 0000000020000480 RDI: 00007fd3519bffe0
RBP: 00007fd3519c0020 R08: 00007fd3519c0020 R09: 0000000000800000
R10: 0000000000800000 R11: 0000000000000202 R12: 0000000020000440
R13: 0000000020000480 R14: 00007fd3519bffe0 R15: 0000000020000100
 </TASK>
syz-executor.3: vmalloc error: size 14680064, page order 9, failed to allocate pages, mode:0xc42(GFP_NOFS|__GFP_HIGHMEM), nodemask=(null),cpuset=syz3,mems_allowed=0-1
CPU: 2 PID: 12021 Comm: syz-executor.3 Not tainted 6.2.0-syzkaller-12017-g1ec35eadc3b4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 warn_alloc+0x213/0x360 mm/page_alloc.c:4398
 __vmalloc_area_node mm/vmalloc.c:3027 [inline]
 __vmalloc_node_range+0xf1c/0x1300 mm/vmalloc.c:3181
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
RIP: 0033:0x7fd350c8d62a
Code: Unable to access opcode bytes at 0x7fd350c8d600.
RSP: 002b:00007fd3519bff88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000000042c RCX: 00007fd350c8d62a
RDX: 0000000020000440 RSI: 0000000020000480 RDI: 00007fd3519bffe0
RBP: 00007fd3519c0020 R08: 00007fd3519c0020 R09: 0000000000800000
R10: 0000000000800000 R11: 0000000000000202 R12: 0000000020000440
R13: 0000000020000480 R14: 00007fd3519bffe0 R15: 0000000020000100
 </TASK>
Mem-Info:
active_anon:22072 inactive_anon:139714 isolated_anon:0
 active_file:0 inactive_file:223 isolated_file:0
 unevictable:1536 dirty:11 writeback:0
 slab_reclaimable:16968 slab_unreclaimable:52157
 mapped:8832 shmem:4697 pagetables:757
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:19364 free_pcp:528 free_cma:0
Node 0 active_anon:9508kB inactive_anon:30684kB active_file:0kB inactive_file:44kB unevictable:3072kB isolated(anon):0kB isolated(file):0kB mapped:1500kB dirty:4kB writeback:0kB shmem:5404kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:9072kB pagetables:1168kB sec_pagetables:0kB all_unreclaimable? no
Node 1 active_anon:50700kB inactive_anon:556252kB active_file:280kB inactive_file:920kB unevictable:3072kB isolated(anon):0kB isolated(file):0kB mapped:34028kB dirty:40kB writeback:0kB shmem:13384kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 16384kB writeback_tmp:0kB kernel_stack:2296kB pagetables:1860kB sec_pagetables:0kB all_unreclaimable? no
Node 0 DMA free:4132kB boost:0kB min:736kB low:920kB high:1104kB reserved_highatomic:4096KB active_anon:140kB inactive_anon:8692kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 426 426 426 426
Node 0 DMA32 free:25784kB boost:0kB min:20968kB low:26208kB high:31448kB reserved_highatomic:4096KB active_anon:9272kB inactive_anon:22088kB active_file:0kB inactive_file:324kB unevictable:3072kB writepending:4kB present:1032192kB managed:441400kB mlocked:0kB bounce:0kB free_pcp:884kB local_pcp:100kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 DMA32 free:49240kB boost:0kB min:45876kB low:57344kB high:68812kB reserved_highatomic:2048KB active_anon:556028kB inactive_anon:50924kB active_file:52kB inactive_file:124kB unevictable:3072kB writepending:40kB present:1048436kB managed:955344kB mlocked:0kB bounce:0kB free_pcp:1500kB local_pcp:296kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 126*4kB (UH) 98*8kB (UMH) 31*16kB (UH) 16*32kB (UH) 3*64kB (U) 1*128kB (H) 0*256kB 1*512kB (H) 1*1024kB (H) 0*2048kB 0*4096kB = 4152kB
Node 0 DMA32: 1638*4kB (UME) 683*8kB (UMEH) 309*16kB (UMEH) 99*32kB (UMEH) 40*64kB (UMEH) 9*128kB (MEH) 1*256kB (E) 0*512kB 1*1024kB (H) 0*2048kB 0*4096kB = 25120kB
Node 1 DMA32: 783*4kB (UMEH) 278*8kB (MEH) 273*16kB (UMEH) 239*32kB (UMEH) 106*64kB (UMEH) 45*128kB (UMEH) 25*256kB (UMH) 10*512kB (UME) 7*1024kB (UME) 0*2048kB 0*4096kB = 48604kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
4814 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
524155 pages RAM
0 pages HighMem/MovableOnly
171129 pages reserved
0 pages cma reserved
EXT4-fs error (device loop3): ext4_xattr_inode_iget:391: comm syz-executor.3: inode #8: comm syz-executor.3: iget: illegal inode #
EXT4-fs error (device loop3): ext4_xattr_inode_iget:394: comm syz-executor.3: error while reading EA inode 8 err=-117
EXT4-fs warning (device loop3): ext4_expand_extra_isize_ea:2799: Unable to expand inode 15. Delete some EAs or run e2fsck.
EXT4-fs (loop3): 1 truncate cleaned up
EXT4-fs (loop3): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: writeback.
EXT4-fs error (device loop3): ext4_xattr_inode_iget:391: comm syz-executor.3: inode #8: comm syz-executor.3: iget: illegal inode #
EXT4-fs error (device loop3): ext4_xattr_inode_iget:394: comm syz-executor.3: error while reading EA inode 8 err=-117


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
