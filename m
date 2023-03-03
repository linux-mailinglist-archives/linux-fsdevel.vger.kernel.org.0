Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B916A8E4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 01:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCCAsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 19:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCCAsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:48:43 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980A114484
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 16:48:40 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id y187-20020a6bc8c4000000b0074d28aa136dso469977iof.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 16:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVWORoaCBQDh6CbYt/bpV8YwYd9I/tB65Ocv2JmS2H8=;
        b=UOOZ3kIursZ4Z7V3LaNYymKYZOh1NTmYn9lD4RhXemIMmZskHZaxZY7zebiDJY/XwH
         3IqKU9dgAwmTFl99Q1l4tDIxWZbsCHDEpu47WTgy9K7Kpu6fLvkEqAuhgynbhrDE+v2/
         hMJVlXv0SBnWka8iDtpHLU4k1vdYjrOu6vS0ZTnW7hizhD+J2T6LPaXxU6ixf+ii+c2i
         TFTpOsItGhdW1CRV9seq3W2VcCqkfFgB5Fl979XRb8qa8F0J6I5EgFLQrUTz2InpWq3U
         mlaOVw/Vl/FUPWSGKeABCFqLLR3uO+ol0SjmEzKFdUEVI23OWyMmh9xTDmcx73bfp3OE
         +AAQ==
X-Gm-Message-State: AO0yUKXq7zYkXAjRCgY7qY9POWYvuA1EUDxYv0VLVbQkGdmI72F9CDYI
        WEZuvj3mdutGehg2UaylkskZXQWroRvfvFEWmNXSWfnJXOur
X-Google-Smtp-Source: AK7set90KFuFssDEa3fo+inSWbOdVzUlHWgNP0f5J8AgpMevsna6k/e09FBASrtD20D9UuDYRPjNH325eRtlkOiqJf6FrIblpBpF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dcb:b0:317:6d19:332d with SMTP id
 l11-20020a056e020dcb00b003176d19332dmr196276ilj.3.1677804519997; Thu, 02 Mar
 2023 16:48:39 -0800 (PST)
Date:   Thu, 02 Mar 2023 16:48:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ac86605f5f44eb9@google.com>
Subject: [syzbot] [nilfs?] possible deadlock in nilfs_evict_inode
From:   syzbot <syzbot+5b7d542076d9bddc3c6a@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    2fcd07b7ccd5 mm/mprotect: Fix successful vma_merge() of ne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149da9f7480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56eb47529ec6fdbe
dashboard link: https://syzkaller.appspot.com/bug?extid=5b7d542076d9bddc3c6a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b7d542076d9bddc3c6a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-syzkaller-12018-g2fcd07b7ccd5 #0 Not tainted
------------------------------------------------------
kswapd0/101 is trying to acquire lock:
ffff88802a8dc650 (sb_internal#2){.+.+}-{0:0}, at: nilfs_evict_inode+0x13b/0x440 fs/nilfs2/inode.c:928

but task is already holding lock:
ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4716 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4730
       might_alloc include/linux/sched/mm.h:271 [inline]
       slab_pre_alloc_hook mm/slab.h:728 [inline]
       slab_alloc_node mm/slab.c:3241 [inline]
       __kmem_cache_alloc_node+0x3b/0x3f0 mm/slab.c:3541
       kmalloc_trace+0x26/0x60 mm/slab_common.c:1061
       kmalloc include/linux/slab.h:580 [inline]
       kzalloc include/linux/slab.h:720 [inline]
       nilfs_sysfs_create_device_group+0x81/0x850 fs/nilfs2/sysfs.c:982
       init_nilfs+0xdc0/0x12f0 fs/nilfs2/the_nilfs.c:700
       nilfs_fill_super fs/nilfs2/super.c:1056 [inline]
       nilfs_mount+0x921/0x1150 fs/nilfs2/super.c:1324
       legacy_get_tree+0x109/0x220 fs/fs_context.c:610
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

-> #2 (&nilfs->ns_sem){++++}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       nilfs_set_error fs/nilfs2/super.c:92 [inline]
       __nilfs_error+0x21f/0x4d0 fs/nilfs2/super.c:137
       nilfs_check_page fs/nilfs2/dir.c:156 [inline]
       nilfs_get_page.isra.0+0x9b9/0xc90 fs/nilfs2/dir.c:197
       nilfs_empty_dir+0xc9/0x420 fs/nilfs2/dir.c:630
       nilfs_rmdir+0x11d/0x240 fs/nilfs2/namei.c:325
       vfs_rmdir.part.0+0x1b0/0x5a0 fs/namei.c:4121
       vfs_rmdir fs/namei.c:4106 [inline]
       do_rmdir+0x3a8/0x420 fs/namei.c:4180
       __do_sys_rmdir fs/namei.c:4199 [inline]
       __se_sys_rmdir fs/namei.c:4197 [inline]
       __x64_sys_rmdir+0xca/0x110 fs/namei.c:4197
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&nilfs->ns_segctor_sem){++++}-{3:3}:
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       nilfs_transaction_begin+0x31a/0xa20 fs/nilfs2/segment.c:223
       nilfs_rmdir+0xb9/0x240 fs/nilfs2/namei.c:320
       vfs_rmdir.part.0+0x1b0/0x5a0 fs/namei.c:4121
       vfs_rmdir fs/namei.c:4106 [inline]
       do_rmdir+0x3a8/0x420 fs/namei.c:4180
       __do_sys_rmdir fs/namei.c:4199 [inline]
       __se_sys_rmdir fs/namei.c:4197 [inline]
       __x64_sys_rmdir+0xca/0x110 fs/namei.c:4197
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sb_internal#2){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1477 [inline]
       sb_start_intwrite include/linux/fs.h:1599 [inline]
       nilfs_transaction_begin+0x21e/0xa20 fs/nilfs2/segment.c:220
       nilfs_evict_inode+0x13b/0x440 fs/nilfs2/inode.c:928
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
  sb_internal#2 --> &nilfs->ns_sem --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&nilfs->ns_sem);
                               lock(fs_reclaim);
  lock(sb_internal#2);

 *** DEADLOCK ***

3 locks held by kswapd0/101:
 #0: ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
 #0: ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338
 #1: ffffffff8c8995d0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg mm/vmscan.c:895 [inline]
 #1: ffffffff8c8995d0 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x2a0/0x660 mm/vmscan.c:1001
 #2: ffff88802a8dc0e0 (&type->s_umount_key#65){++++}-{3:3}, at: trylock_super fs/super.c:414 [inline]
 #2: ffff88802a8dc0e0 (&type->s_umount_key#65){++++}-{3:3}, at: super_cache_scan+0x70/0x590 fs/super.c:79

stack backtrace:
CPU: 0 PID: 101 Comm: kswapd0 Not tainted 6.2.0-syzkaller-12018-g2fcd07b7ccd5 #0
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
 nilfs_transaction_begin+0x21e/0xa20 fs/nilfs2/segment.c:220
 nilfs_evict_inode+0x13b/0x440 fs/nilfs2/inode.c:928
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
