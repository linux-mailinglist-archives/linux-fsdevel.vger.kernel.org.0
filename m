Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47976C5CD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 03:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCWCw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 22:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCWCwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:52:54 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC92FCE0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 19:52:49 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id j24-20020a056e02219800b00322f108a4cfso10919728ila.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 19:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679539968;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtTFcPuuCn/4pJ27k+AdyBk87XfuxabB0uI/62qGQO4=;
        b=CTtWaLF6XtEkOYURW8VFbYHTEIQ8dHU8iW8V57qSbjydbs7Y2Lf+LmR+N5tIQy/bK0
         LXLc10WXxVOZzEejXoGy1rMQJONNobpvVLNeZ9UOI33PRbA8NSzwH6MAFFR8Mdqagdef
         mbOeun1xeBErrj9jJu+d8nbBjBze787xxY61AvfxAX9joARCS8LRRZkgHcUCF83yYuRz
         xufm6EV0UiYc8nKaNNRu6vLZHa0jO2xl0VVwqZJKY9J9ilLO8zQHVP7/cyIm8cnVW/sx
         F6ysyfYENRtMItUKL5Inr4ijI3PJihuUeHVCvfyh7rNex9JIBi7S7JG7x8vD9165/wrf
         5o9A==
X-Gm-Message-State: AO0yUKXsf7pPO0OSCPom+1aUOtkLVaLAsYNI+9H+ll+ENwU2x+h4ZnZe
        XS/fdVf41neSsWddHWC0FkiI9ATF1a7jF79hPC+oXV/71Afa
X-Google-Smtp-Source: AK7set+S2YQlTt5AXy6/sRdZwUlDwAedgbG1qDh7WTVn4IrArq2JjByZSS8X6a24dSfgRROeqxJM//VUFSkdqEUFP1wzxXJc0ir0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:962:b0:315:8e92:39ad with SMTP id
 q2-20020a056e02096200b003158e9239admr3569252ilt.1.1679539968412; Wed, 22 Mar
 2023 19:52:48 -0700 (PDT)
Date:   Wed, 22 Mar 2023 19:52:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003414b505f7885f7e@google.com>
Subject: [syzbot] [nilfs?] possible deadlock in __nilfs_error (2)
From:   syzbot <syzbot+979fa7f9c0d086fdc282@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    534293368afa Merge tag 'kbuild-fixes-v6.3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1720c216c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c604fd805569c4b9
dashboard link: https://syzkaller.appspot.com/bug?extid=979fa7f9c0d086fdc282
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+979fa7f9c0d086fdc282@syzkaller.appspotmail.com

NILFS (loop3): bad btree node (ino=3, blocknr=51): level = 0, flags = 0x0, nchildren = 0
NILFS error (device loop3): nilfs_bmap_lookup_at_level: broken bmap (inode number=3)
======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc2-syzkaller-00387-g534293368afa #0 Not tainted
------------------------------------------------------
segctord/6639 is trying to acquire lock:
ffff88801ea8f090 (&nilfs->ns_sem){++++}-{3:3}, at: nilfs_set_error fs/nilfs2/super.c:92 [inline]
ffff88801ea8f090 (&nilfs->ns_sem){++++}-{3:3}, at: __nilfs_error+0x21f/0x4d0 fs/nilfs2/super.c:137

but task is already holding lock:
ffff888028427968 (&nilfs_bmap_dat_lock_key){++++}-{3:3}, at: nilfs_bmap_lookup_at_level+0x7f/0x3e0 fs/nilfs2/bmap.c:68

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&nilfs_bmap_dat_lock_key){++++}-{3:3}:
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       nilfs_bmap_lookup_at_level+0x7f/0x3e0 fs/nilfs2/bmap.c:68
       nilfs_bmap_lookup fs/nilfs2/bmap.h:170 [inline]
       nilfs_mdt_submit_block+0x1a1/0x9d0 fs/nilfs2/mdt.c:142
       nilfs_mdt_read_block+0x92/0x3c0 fs/nilfs2/mdt.c:176
       nilfs_mdt_get_block+0xea/0xcf0 fs/nilfs2/mdt.c:251
       nilfs_palloc_get_block+0xc4/0x2b0 fs/nilfs2/alloc.c:216
       nilfs_palloc_get_desc_block+0x134/0x190 fs/nilfs2/alloc.c:265
       nilfs_palloc_prepare_alloc_entry+0x20a/0xa80 fs/nilfs2/alloc.c:524
       nilfs_dat_prepare_alloc+0x23/0x130 fs/nilfs2/dat.c:78
       nilfs_bmap_prepare_alloc_ptr fs/nilfs2/bmap.h:183 [inline]
       nilfs_direct_insert+0x3f8/0x520 fs/nilfs2/direct.c:122
       nilfs_bmap_do_insert fs/nilfs2/bmap.c:121 [inline]
       nilfs_bmap_insert+0x27e/0x3f0 fs/nilfs2/bmap.c:147
       nilfs_get_block+0x566/0xa50 fs/nilfs2/inode.c:101
       __block_write_begin_int+0x3bd/0x14b0 fs/buffer.c:2034
       __block_write_begin fs/buffer.c:2084 [inline]
       block_write_begin+0xb9/0x4d0 fs/buffer.c:2145
       nilfs_write_begin+0xa0/0x1a0 fs/nilfs2/inode.c:261
       generic_perform_write+0x256/0x570 mm/filemap.c:3926
       __generic_file_write_iter+0x39d/0x500 mm/filemap.c:4022
       generic_file_write_iter+0xe3/0x350 mm/filemap.c:4086
       call_write_iter include/linux/fs.h:1851 [inline]
       do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
       do_iter_write+0x182/0x700 fs/read_write.c:861
       vfs_iter_write+0x74/0xa0 fs/read_write.c:902
       iter_file_splice_write+0x743/0xc80 fs/splice.c:778
       do_splice_from fs/splice.c:856 [inline]
       direct_splice_actor+0x114/0x180 fs/splice.c:1022
       splice_direct_to_actor+0x335/0x8a0 fs/splice.c:977
       do_splice_direct+0x1ab/0x280 fs/splice.c:1065
       do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
       __do_sys_sendfile64 fs/read_write.c:1323 [inline]
       __se_sys_sendfile64 fs/read_write.c:1309 [inline]
       __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&bmap->b_sem){++++}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       nilfs_bmap_clear+0x1c/0x90 fs/nilfs2/bmap.c:311
       nilfs_clear_inode+0x288/0x330 fs/nilfs2/inode.c:906
       nilfs_evict_inode+0x31c/0x440 fs/nilfs2/inode.c:925
       evict+0x2ed/0x6b0 fs/inode.c:665
       dispose_list+0x117/0x1e0 fs/inode.c:698
       prune_icache_sb+0xeb/0x150 fs/inode.c:897
       super_cache_scan+0x391/0x590 fs/super.c:106
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

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4716 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4730
       might_alloc include/linux/sched/mm.h:271 [inline]
       slab_pre_alloc_hook mm/slab.h:728 [inline]
       slab_alloc_node mm/slab.c:3241 [inline]
       __kmem_cache_alloc_node+0x3b/0x3f0 mm/slab.c:3541
       kmalloc_trace+0x26/0xe0 mm/slab_common.c:1061
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

-> #0 (&nilfs->ns_sem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       nilfs_set_error fs/nilfs2/super.c:92 [inline]
       __nilfs_error+0x21f/0x4d0 fs/nilfs2/super.c:137
       nilfs_bmap_convert_error fs/nilfs2/bmap.c:35 [inline]
       nilfs_bmap_lookup_at_level+0x327/0x3e0 fs/nilfs2/bmap.c:71
       nilfs_bmap_lookup fs/nilfs2/bmap.h:170 [inline]
       nilfs_mdt_submit_block+0x1a1/0x9d0 fs/nilfs2/mdt.c:142
       nilfs_mdt_read_block+0x92/0x3c0 fs/nilfs2/mdt.c:176
       nilfs_mdt_get_block+0xea/0xcf0 fs/nilfs2/mdt.c:251
       nilfs_palloc_get_block+0xc4/0x2b0 fs/nilfs2/alloc.c:216
       nilfs_palloc_get_desc_block+0x134/0x190 fs/nilfs2/alloc.c:265
       nilfs_palloc_prepare_alloc_entry+0x20a/0xa80 fs/nilfs2/alloc.c:524
       nilfs_dat_prepare_alloc fs/nilfs2/dat.c:78 [inline]
       nilfs_dat_prepare_update+0xb0/0x270 fs/nilfs2/dat.c:250
       nilfs_direct_propagate fs/nilfs2/direct.c:274 [inline]
       nilfs_direct_propagate+0x1e0/0x320 fs/nilfs2/direct.c:256
       nilfs_bmap_propagate+0x77/0x170 fs/nilfs2/bmap.c:337
       nilfs_collect_file_data+0x49/0xd0 fs/nilfs2/segment.c:568
       nilfs_segctor_apply_buffers+0x14a/0x470 fs/nilfs2/segment.c:1020
       nilfs_segctor_scan_file+0x3f4/0x6f0 fs/nilfs2/segment.c:1069
       nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1178 [inline]
       nilfs_segctor_collect fs/nilfs2/segment.c:1505 [inline]
       nilfs_segctor_do_construct+0x271b/0x7100 fs/nilfs2/segment.c:2047
       nilfs_segctor_construct+0x8e3/0xb30 fs/nilfs2/segment.c:2381
       nilfs_segctor_thread_construct fs/nilfs2/segment.c:2489 [inline]
       nilfs_segctor_thread+0x3c7/0xf30 fs/nilfs2/segment.c:2572
       kthread+0x2e8/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

Chain exists of:
  &nilfs->ns_sem --> &bmap->b_sem --> &nilfs_bmap_dat_lock_key

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&nilfs_bmap_dat_lock_key);
                               lock(&bmap->b_sem);
                               lock(&nilfs_bmap_dat_lock_key);
  lock(&nilfs->ns_sem);

 *** DEADLOCK ***

3 locks held by segctord/6639:
 #0: ffff88801ea8f2a0 (&nilfs->ns_segctor_sem){++++}-{3:3}, at: nilfs_transaction_lock+0x266/0x410 fs/nilfs2/segment.c:357
 #1: ffff888028235828 (&bmap->b_sem){++++}-{3:3}, at: nilfs_bmap_propagate+0x25/0x170 fs/nilfs2/bmap.c:336
 #2: ffff888028427968 (&nilfs_bmap_dat_lock_key){++++}-{3:3}, at: nilfs_bmap_lookup_at_level+0x7f/0x3e0 fs/nilfs2/bmap.c:68

stack backtrace:
CPU: 1 PID: 6639 Comm: segctord Not tainted 6.3.0-rc2-syzkaller-00387-g534293368afa #0
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
 down_write+0x92/0x200 kernel/locking/rwsem.c:1573
 nilfs_set_error fs/nilfs2/super.c:92 [inline]
 __nilfs_error+0x21f/0x4d0 fs/nilfs2/super.c:137
 nilfs_bmap_convert_error fs/nilfs2/bmap.c:35 [inline]
 nilfs_bmap_lookup_at_level+0x327/0x3e0 fs/nilfs2/bmap.c:71
 nilfs_bmap_lookup fs/nilfs2/bmap.h:170 [inline]
 nilfs_mdt_submit_block+0x1a1/0x9d0 fs/nilfs2/mdt.c:142
 nilfs_mdt_read_block+0x92/0x3c0 fs/nilfs2/mdt.c:176
 nilfs_mdt_get_block+0xea/0xcf0 fs/nilfs2/mdt.c:251
 nilfs_palloc_get_block+0xc4/0x2b0 fs/nilfs2/alloc.c:216
 nilfs_palloc_get_desc_block+0x134/0x190 fs/nilfs2/alloc.c:265
 nilfs_palloc_prepare_alloc_entry+0x20a/0xa80 fs/nilfs2/alloc.c:524
 nilfs_dat_prepare_alloc fs/nilfs2/dat.c:78 [inline]
 nilfs_dat_prepare_update+0xb0/0x270 fs/nilfs2/dat.c:250
 nilfs_direct_propagate fs/nilfs2/direct.c:274 [inline]
 nilfs_direct_propagate+0x1e0/0x320 fs/nilfs2/direct.c:256
 nilfs_bmap_propagate+0x77/0x170 fs/nilfs2/bmap.c:337
 nilfs_collect_file_data+0x49/0xd0 fs/nilfs2/segment.c:568
 nilfs_segctor_apply_buffers+0x14a/0x470 fs/nilfs2/segment.c:1020
 nilfs_segctor_scan_file+0x3f4/0x6f0 fs/nilfs2/segment.c:1069
 nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1178 [inline]
 nilfs_segctor_collect fs/nilfs2/segment.c:1505 [inline]
 nilfs_segctor_do_construct+0x271b/0x7100 fs/nilfs2/segment.c:2047
 nilfs_segctor_construct+0x8e3/0xb30 fs/nilfs2/segment.c:2381
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2489 [inline]
 nilfs_segctor_thread+0x3c7/0xf30 fs/nilfs2/segment.c:2572
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Remounting filesystem read-only
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6639 at fs/nilfs2/sufile.c:539 nilfs_sufile_set_segment_usage+0x51c/0x6a0 fs/nilfs2/sufile.c:539
Modules linked in:
CPU: 0 PID: 6639 Comm: segctord Not tainted 6.3.0-rc2-syzkaller-00387-g534293368afa #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:nilfs_sufile_set_segment_usage+0x51c/0x6a0 fs/nilfs2/sufile.c:539
Code: 24 55 fe 48 8b 6c 24 48 48 85 ed 0f 85 5b ff ff ff e9 63 ff ff ff e8 13 24 55 fe e8 6e a4 d3 fd e9 db fe ff ff e8 04 24 55 fe <0f> 0b e9 0d fe ff ff e8 b8 40 a5 fe e9 c6 fb ff ff e8 ae 40 a5 fe
RSP: 0000:ffffc9000d44f9a8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880293d7418 RCX: 0000000000000000
RDX: ffff888026862000 RSI: ffffffff832ce1ac RDI: 0000000000000005
RBP: ffff888075c13050 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000004 R11: 69746e756f6d6552 R12: 0000000000000000
R13: 1ffff92001a89f3a R14: ffff8880293d78a0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f2bd32ea60 CR3: 0000000025013000 CR4: 0000000000152ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_cancel_segusage fs/nilfs2/segment.c:1462 [inline]
 nilfs_segctor_abort_construction+0x5c1/0xe20 fs/nilfs2/segment.c:1803
 nilfs_segctor_do_construct+0x363d/0x7100 fs/nilfs2/segment.c:2111
 nilfs_segctor_construct+0x8e3/0xb30 fs/nilfs2/segment.c:2381
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2489 [inline]
 nilfs_segctor_thread+0x3c7/0xf30 fs/nilfs2/segment.c:2572
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
