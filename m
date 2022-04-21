Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBC650A00D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385790AbiDUMzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 08:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383795AbiDUMzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:55:19 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9AB32993
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 05:52:28 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id d19-20020a0566022d5300b0065499cd4a73so3220404iow.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 05:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0wOpHcYRyTy1gHbHRKwr8jrNSS5AepkjjIwI89NNgBY=;
        b=J5QbF3r9EAbCVZuJ5lG1yIiyS4zpekJjA5K+AiKlb6PSA3XIUOaRZCi4Gf5ec15P75
         X4GO60JGyjuqdoQ4QPEegHh6BxIrqAqm6pjBKSGo+PPIDSpIgj38mxDvUAdnxKsJZo/E
         INqV7rlsjui4hR//8gL7mtbUn/YP8MfeatFZ8G8kC2OViIDCcL9IjvmBQzh5JX4rTxQV
         ecosMsmpdqBJXFCuA8G2fsuYK2tL+xccaHRky8kMuA5IHbTBwCK+iI+0Nec2wumADIME
         yg9ongg5e1y/y95zrQv/auibRd7kq+/j4ag/AOInxJOIuqLJTOA7fu1tkHWQ3LcWFHbZ
         688w==
X-Gm-Message-State: AOAM531Bi0TJLiD3C4mpYu8VJCvJsKqZaiwSwoKZv3Qu+EKkBH5cZyIH
        7eTcX0BS+Vs/tJ2R9mtSOuphhDOBxbMAIa/WANtsHPx+ozb3
X-Google-Smtp-Source: ABdhPJxTo+QtKWZ1OIb4VWf752AOKkoFIBH6frJ4VOrtv/GHVPKJgxlHaoXxnjoDwgjGI3jT0QFaiyrWD4/EpvSbVCPld88bpX0s
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:2cc:2ea5:6c98 with SMTP id
 q1-20020a056e0220e100b002cc2ea56c98mr7428759ilv.29.1650545548331; Thu, 21 Apr
 2022 05:52:28 -0700 (PDT)
Date:   Thu, 21 Apr 2022 05:52:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018117c05dd29952c@google.com>
Subject: [syzbot] possible deadlock in evict (2)
From:   syzbot <syzbot+e0fda9a3d66127dea5c2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    a2c29ccd9477 Merge tag 'devicetree-fixes-for-5.18-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13508568f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac042ae170e2c50f
dashboard link: https://syzkaller.appspot.com/bug?extid=e0fda9a3d66127dea5c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0fda9a3d66127dea5c2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.18.0-rc2-syzkaller-00351-ga2c29ccd9477 #0 Not tainted
------------------------------------------------------
khugepaged/49 is trying to acquire lock:
ffff88801ca7a650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:664

but task is already holding lock:
ffffffff8beac660 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4621 [inline]
ffffffff8beac660 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4646 [inline]
ffffffff8beac660 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0xa1e/0x20e0 mm/page_alloc.c:5046

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4572 [inline]
       fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4586
       might_alloc include/linux/sched/mm.h:254 [inline]
       slab_pre_alloc_hook mm/slab.h:722 [inline]
       slab_alloc_node mm/slab.c:3214 [inline]
       kmem_cache_alloc_node_trace+0x48/0x5b0 mm/slab.c:3625
       kmalloc_node include/linux/slab.h:599 [inline]
       kzalloc_node include/linux/slab.h:725 [inline]
       mempool_create_node mm/mempool.c:266 [inline]
       mempool_create+0x4e/0xc0 mm/mempool.c:255
       mempool_create_page_pool include/linux/mempool.h:107 [inline]
       fscrypt_initialize+0x86/0xa0 fs/crypto/crypto.c:330
       fscrypt_setup_encryption_info+0xef/0xf00 fs/crypto/keysetup.c:545
       fscrypt_get_encryption_info+0x34a/0x3f0 fs/crypto/keysetup.c:654
       fscrypt_setup_filename+0x238/0xec0 fs/crypto/fname.c:426
       __fscrypt_prepare_lookup+0x28/0xf0 fs/crypto/hooks.c:102
       fscrypt_prepare_lookup include/linux/fscrypt.h:898 [inline]
       ext4_fname_prepare_lookup+0x2b1/0x330 fs/ext4/ext4.h:2770
       ext4_lookup_entry fs/ext4/namei.c:1694 [inline]
       ext4_lookup fs/ext4/namei.c:1769 [inline]
       ext4_lookup+0x12d/0x730 fs/ext4/namei.c:1760
       lookup_open.isra.0+0x9aa/0x1690 fs/namei.c:3308
       open_last_lookups fs/namei.c:3400 [inline]
       path_openat+0x9a2/0x2910 fs/namei.c:3606
       do_filp_open+0x1aa/0x400 fs/namei.c:3636
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1213
       do_sys_open fs/open.c:1229 [inline]
       __do_sys_openat fs/open.c:1245 [inline]
       __se_sys_openat fs/open.c:1240 [inline]
       __x64_sys_openat+0x13f/0x1f0 fs/open.c:1240
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (fscrypt_init_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:600 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
       fscrypt_initialize+0x3c/0xa0 fs/crypto/crypto.c:324
       fscrypt_setup_encryption_info+0xef/0xf00 fs/crypto/keysetup.c:545
       fscrypt_get_encryption_info+0x34a/0x3f0 fs/crypto/keysetup.c:654
       fscrypt_setup_filename+0x238/0xec0 fs/crypto/fname.c:426
       ext4_fname_setup_filename+0x8d/0x240 fs/ext4/ext4.h:2751
       ext4_find_entry+0x8c/0x170 fs/ext4/namei.c:1674
       __ext4_unlink+0x92/0x920 fs/ext4/namei.c:3155
       ext4_unlink+0x346/0x9e0 fs/ext4/namei.c:3231
       vfs_unlink+0x351/0x920 fs/namei.c:4148
       do_unlinkat+0x3c9/0x650 fs/namei.c:4216
       __do_sys_unlink fs/namei.c:4264 [inline]
       __se_sys_unlink fs/namei.c:4262 [inline]
       __x64_sys_unlink+0xc6/0x110 fs/namei.c:4262
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xfe7/0x14a0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x3a8/0x4a0 fs/ext4/ext4_jbd2.c:105
       ext4_sample_last_mounted fs/ext4/file.c:820 [inline]
       ext4_file_open+0x5e7/0xb50 fs/ext4/file.c:849
       do_dentry_open+0x4a1/0x11e0 fs/open.c:824
       do_open fs/namei.c:3476 [inline]
       path_openat+0x1c71/0x2910 fs/namei.c:3609
       do_filp_open+0x1aa/0x400 fs/namei.c:3636
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1213
       do_sys_open fs/open.c:1229 [inline]
       __do_sys_openat fs/open.c:1245 [inline]
       __se_sys_openat fs/open.c:1240 [inline]
       __x64_sys_openat+0x13f/0x1f0 fs/open.c:1240
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (sb_internal){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3065 [inline]
       check_prevs_add kernel/locking/lockdep.c:3188 [inline]
       validate_chain kernel/locking/lockdep.c:3803 [inline]
       __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5029
       lock_acquire kernel/locking/lockdep.c:5641 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1698 [inline]
       sb_start_intwrite include/linux/fs.h:1815 [inline]
       ext4_evict_inode+0xe81/0x1960 fs/ext4/inode.c:240
       evict+0x2ed/0x6b0 fs/inode.c:664
       iput_final fs/inode.c:1744 [inline]
       iput.part.0+0x562/0x820 fs/inode.c:1770
       iput+0x58/0x70 fs/inode.c:1760
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
       dentry_kill fs/dcache.c:745 [inline]
       dput+0x64d/0xdb0 fs/dcache.c:913
       ovl_entry_stack_free fs/overlayfs/super.c:61 [inline]
       ovl_dentry_release+0xca/0x130 fs/overlayfs/super.c:74
       __dentry_kill+0x42b/0x640 fs/dcache.c:612
       shrink_dentry_list+0x23c/0x800 fs/dcache.c:1201
       prune_dcache_sb+0xe7/0x140 fs/dcache.c:1282
       super_cache_scan+0x336/0x590 fs/super.c:104
       do_shrink_slab+0x42d/0xbd0 mm/vmscan.c:774
       shrink_slab_memcg mm/vmscan.c:843 [inline]
       shrink_slab+0x3ee/0x6f0 mm/vmscan.c:922
       shrink_node_memcgs mm/vmscan.c:3100 [inline]
       shrink_node+0x8b3/0x1df0 mm/vmscan.c:3221
       shrink_zones mm/vmscan.c:3458 [inline]
       do_try_to_free_pages+0x3b5/0x1700 mm/vmscan.c:3516
       try_to_free_pages+0x2ac/0x840 mm/vmscan.c:3751
       __perform_reclaim mm/page_alloc.c:4624 [inline]
       __alloc_pages_direct_reclaim mm/page_alloc.c:4646 [inline]
       __alloc_pages_slowpath.constprop.0+0xac7/0x20e0 mm/page_alloc.c:5046
       __alloc_pages+0x412/0x500 mm/page_alloc.c:5421
       __alloc_pages_node include/linux/gfp.h:587 [inline]
       khugepaged_alloc_page+0xa0/0x170 mm/khugepaged.c:868
       collapse_huge_page mm/khugepaged.c:1071 [inline]
       khugepaged_scan_pmd mm/khugepaged.c:1357 [inline]
       khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
       khugepaged_do_scan mm/khugepaged.c:2248 [inline]
       khugepaged+0x3474/0x66e0 mm/khugepaged.c:2293
       kthread+0x2e9/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

other info that might help us debug this:

Chain exists of:
  sb_internal --> fscrypt_init_mutex --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(fscrypt_init_mutex);
                               lock(fs_reclaim);
  lock(sb_internal);

 *** DEADLOCK ***

3 locks held by khugepaged/49:
 #0: ffffffff8beac660 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4621 [inline]
 #0: ffffffff8beac660 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4646 [inline]
 #0: ffffffff8beac660 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0xa1e/0x20e0 mm/page_alloc.c:5046
 #1: ffffffff8be6e310 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg mm/vmscan.c:816 [inline]
 #1: ffffffff8be6e310 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x2b4/0x6f0 mm/vmscan.c:922
 #2: ffff8880241a40e0 (&type->s_umount_key#75){++++}-{3:3}, at: trylock_super fs/super.c:415 [inline]
 #2: ffff8880241a40e0 (&type->s_umount_key#75){++++}-{3:3}, at: super_cache_scan+0x6c/0x590 fs/super.c:79

stack backtrace:
CPU: 2 PID: 49 Comm: khugepaged Not tainted 5.18.0-rc2-syzkaller-00351-ga2c29ccd9477 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2145
 check_prev_add kernel/locking/lockdep.c:3065 [inline]
 check_prevs_add kernel/locking/lockdep.c:3188 [inline]
 validate_chain kernel/locking/lockdep.c:3803 [inline]
 __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5029
 lock_acquire kernel/locking/lockdep.c:5641 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1698 [inline]
 sb_start_intwrite include/linux/fs.h:1815 [inline]
 ext4_evict_inode+0xe81/0x1960 fs/ext4/inode.c:240
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:745 [inline]
 dput+0x64d/0xdb0 fs/dcache.c:913
 ovl_entry_stack_free fs/overlayfs/super.c:61 [inline]
 ovl_dentry_release+0xca/0x130 fs/overlayfs/super.c:74
 __dentry_kill+0x42b/0x640 fs/dcache.c:612
 shrink_dentry_list+0x23c/0x800 fs/dcache.c:1201
 prune_dcache_sb+0xe7/0x140 fs/dcache.c:1282
 super_cache_scan+0x336/0x590 fs/super.c:104
 do_shrink_slab+0x42d/0xbd0 mm/vmscan.c:774
 shrink_slab_memcg mm/vmscan.c:843 [inline]
 shrink_slab+0x3ee/0x6f0 mm/vmscan.c:922
 shrink_node_memcgs mm/vmscan.c:3100 [inline]
 shrink_node+0x8b3/0x1df0 mm/vmscan.c:3221
 shrink_zones mm/vmscan.c:3458 [inline]
 do_try_to_free_pages+0x3b5/0x1700 mm/vmscan.c:3516
 try_to_free_pages+0x2ac/0x840 mm/vmscan.c:3751
 __perform_reclaim mm/page_alloc.c:4624 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4646 [inline]
 __alloc_pages_slowpath.constprop.0+0xac7/0x20e0 mm/page_alloc.c:5046
 __alloc_pages+0x412/0x500 mm/page_alloc.c:5421
 __alloc_pages_node include/linux/gfp.h:587 [inline]
 khugepaged_alloc_page+0xa0/0x170 mm/khugepaged.c:868
 collapse_huge_page mm/khugepaged.c:1071 [inline]
 khugepaged_scan_pmd mm/khugepaged.c:1357 [inline]
 khugepaged_scan_mm_slot mm/khugepaged.c:2167 [inline]
 khugepaged_do_scan mm/khugepaged.c:2248 [inline]
 khugepaged+0x3474/0x66e0 mm/khugepaged.c:2293
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
