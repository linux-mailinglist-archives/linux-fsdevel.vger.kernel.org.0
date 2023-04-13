Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB86E088A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDMID1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDMIDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:03:25 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA419A
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 01:03:21 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7606d6b2fddso27686839f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 01:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681373001; x=1683965001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oz4mjXpmd6bVlAuJwX4qtDfoS0M+5mzeYmp+fqBB2yU=;
        b=iyrOvK+d9HtOQd1ffsAwVxCGq8jzx/OCpJoyHBT1bdHl1H+LMyS36BvyycTEc//8YF
         vMv9N9198131HXiqUPuWcOqXKqo5kNK37+e9q0WzOX4Rfe4pyiGgsKBJcboEo/kNDWuk
         3EMR7gWih68YdJGrcj67uaZpN8D3A9kxIk1poAGkypkqpBoRRucrzNuNeFxFlbau1oXl
         KdgGqIqxNme6Cfh27r2CCBRLoPZlJfMPDYOljG4Vd9YvVN5FuaBx/BOZhJqbjUh2KeVC
         FUJcocjEOSSqHAELd87B2TN44LS8YPloVA99jxqG/8NZe45aNRRZlv5a6dfkKPFtlEAI
         yl4A==
X-Gm-Message-State: AAQBX9edx3xMR66nntps5tZXJcYaACvGU73GAf/tFSlOOnCflZJUefXq
        hVhrBpBPwH9Dm/uB0Aq0YI2Qg+vWZWatdcWN5cThZIsThija
X-Google-Smtp-Source: AKy350YUbJEJXImeZ2lEdV+8FNAI09xbtCA/OPyIC20PmG1Eb2xx0V27CtoxQKHs5zs8AaZ8zN8M74b/SdgOhcXjddcpLc+VU07R
MIME-Version: 1.0
X-Received: by 2002:a92:d03:0:b0:329:5114:eb1f with SMTP id
 3-20020a920d03000000b003295114eb1fmr494385iln.3.1681373001314; Thu, 13 Apr
 2023 01:03:21 -0700 (PDT)
Date:   Thu, 13 Apr 2023 01:03:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a779505f9332827@google.com>
Subject: [syzbot] [xfs?] KASAN: slab-use-after-free Read in iomap_finish_ioend
From:   syzbot <syzbot+9c656068e71c1b06dc1f@syzkaller.appspotmail.com>
To:     djwong@kernel.org, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a79d5c76f705 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e54345c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5666fa6aca264e42
dashboard link: https://syzkaller.appspot.com/bug?extid=9c656068e71c1b06dc1f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/adf61ecd5810/disk-a79d5c76.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8192876ea15a/vmlinux-a79d5c76.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80c6e54ddbe7/bzImage-a79d5c76.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c656068e71c1b06dc1f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in iomap_finish_ioend+0x8a4/0x960 fs/iomap/buffered-io.c:1353
Read of size 8 at addr ffff88807925b090 by task kworker/1:0/22

CPU: 1 PID: 22 Comm: kworker/1:0 Not tainted 6.3.0-rc5-syzkaller-00202-ga79d5c76f705 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: xfs-conv/loop2 xfs_end_io
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 iomap_finish_ioend+0x8a4/0x960 fs/iomap/buffered-io.c:1353
 iomap_finish_ioends+0x1af/0x3a0 fs/iomap/buffered-io.c:1377
 xfs_end_ioend+0x36e/0x4d0 fs/xfs/xfs_aops.c:136
 xfs_end_io+0x2e5/0x370 fs/xfs/xfs_aops.c:173
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 12928:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:769
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x11f/0x2e0 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:2686 [inline]
 xfs_inode_alloc+0x88/0x6c0 fs/xfs/xfs_icache.c:81
 xfs_iget_cache_miss fs/xfs/xfs_icache.c:585 [inline]
 xfs_iget+0xad2/0x2fd0 fs/xfs/xfs_icache.c:751
 xfs_init_new_inode+0x1ca/0x10a0 fs/xfs/xfs_inode.c:815
 xfs_create+0x8ce/0x1240 fs/xfs/xfs_inode.c:1023
 xfs_generic_create+0x491/0xd70 fs/xfs/xfs_iops.c:199
 lookup_open fs/namei.c:3416 [inline]
 open_last_lookups fs/namei.c:3484 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3712
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_openat fs/open.c:1380 [inline]
 __se_sys_openat fs/open.c:1375 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1375
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0x297/0x520 mm/slub.c:3809
 rcu_do_batch kernel/rcu/tree.c:2112 [inline]
 rcu_core+0xa4d/0x16f0 kernel/rcu/tree.c:2372
 __do_softirq+0x2ab/0x908 kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:491
 __call_rcu_common kernel/rcu/tree.c:2622 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2736
 __xfs_inode_free fs/xfs/xfs_icache.c:161 [inline]
 xfs_reclaim_inode fs/xfs/xfs_icache.c:953 [inline]
 xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1635 [inline]
 xfs_icwalk_ag+0x1366/0x1a60 fs/xfs/xfs_icache.c:1717
 xfs_icwalk fs/xfs/xfs_icache.c:1766 [inline]
 xfs_reclaim_inodes+0x1f7/0x310 fs/xfs/xfs_icache.c:986
 xfs_unmount_flush_inodes+0xaf/0xc0 fs/xfs/xfs_mount.c:594
 xfs_unmountfs+0xc4/0x280 fs/xfs/xfs_mount.c:1071
 xfs_fs_put_super+0x74/0x2d0 fs/xfs/xfs_super.c:1126
 generic_shutdown_super+0x134/0x340 fs/super.c:500
 kill_block_super+0x7e/0xe0 fs/super.c:1407
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:491
 insert_work+0x54/0x3d0 kernel/workqueue.c:1361
 __queue_work+0xb37/0xf10 kernel/workqueue.c:1524
 queue_work_on+0x14f/0x250 kernel/workqueue.c:1552
 queue_work include/linux/workqueue.h:504 [inline]
 xfs_end_bio+0xf6/0x1e0 fs/xfs/xfs_aops.c:188
 req_bio_endio block/blk-mq.c:795 [inline]
 blk_update_request+0x4d7/0xfe0 block/blk-mq.c:927
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1054
 blk_complete_reqs block/blk-mq.c:1132 [inline]
 blk_done_softirq+0xfc/0x150 block/blk-mq.c:1137
 __do_softirq+0x2ab/0x908 kernel/softirq.c:571

The buggy address belongs to the object at ffff88807925ae80
 which belongs to the cache xfs_inode of size 1808
The buggy address is located 528 bytes inside of
 freed 1808-byte region [ffff88807925ae80, ffff88807925b590)

The buggy address belongs to the physical page:
page:ffffea0001e49600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79258
head:ffffea0001e49600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888034708001
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888145f6e780 ffffea0000ecce00 dead000000000002
raw: 0000000000000000 0000000080100010 00000001ffffffff ffff888034708001
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 30191, tgid 30185 (syz-executor.2), ts 2829909820429, free_ts 2816156356992
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x3246/0x33c0 mm/page_alloc.c:4326
 __alloc_pages+0x255/0x670 mm/page_alloc.c:5592
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x1b9/0x2e0 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:2686 [inline]
 xfs_inode_alloc+0x88/0x6c0 fs/xfs/xfs_icache.c:81
 xfs_iget_cache_miss fs/xfs/xfs_icache.c:585 [inline]
 xfs_iget+0xad2/0x2fd0 fs/xfs/xfs_icache.c:751
 xfs_init_new_inode+0x1ca/0x10a0 fs/xfs/xfs_inode.c:815
 xfs_symlink+0xb7b/0x1e80 fs/xfs/xfs_symlink.c:234
 xfs_vn_symlink+0x1f5/0x740 fs/xfs/xfs_iops.c:419
 vfs_symlink+0x12f/0x2a0 fs/namei.c:4398
 do_symlinkat+0x201/0x610 fs/namei.c:4424
 __do_sys_symlink fs/namei.c:4445 [inline]
 __se_sys_symlink fs/namei.c:4443 [inline]
 __x64_sys_symlink+0x7e/0x90 fs/namei.c:4443
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare mm/page_alloc.c:1504 [inline]
 free_unref_page_prepare+0xe2f/0xe70 mm/page_alloc.c:3388
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:3483
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:769
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x11f/0x2e0 mm/slub.c:3476
 getname_flags+0xbc/0x4e0 fs/namei.c:140
 do_sys_openat2+0xd6/0x500 fs/open.c:1342
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_open fs/open.c:1372 [inline]
 __se_sys_open fs/open.c:1368 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1368
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807925af80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807925b000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807925b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88807925b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807925b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
