Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DF36A766F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 22:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCAVyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 16:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAVys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:54:48 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709E1B2E6
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 13:54:46 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id x6-20020a920606000000b0031784489cbeso3585685ilg.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 13:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uO4KCLnKlJQ3TCEg4DtAq5LZhFrYZunr4hN8AtmNmUk=;
        b=qY/WSBMtSJFpOle/HMycdvfvDPA34k6UsvlyruYCDwuf3kpEykPGaNfWMO4afokZPQ
         xMcnzUXnLbXFBhNBqpjHb3ad2+Z4MX4lHzFzlkS4xOHdcrzNDdUsWzsTuWcnNwzeBg08
         6AA7qf/oMe5ry3eiKzfD7mYCVNGU7M0/a746GiilMayIoOwcvdN1MIj6rJ1f1BEGKs+O
         9MH272zjwG3VcNTlNaarPKlZXTF0G+gB9L8qGXzuuxEBa/mrczotLHl/lH2ZVqCK7JSD
         SmOlHDuLkBvKb9F5Tir0jSIvW4eJYtKFW8pucYta08wsIR9uHMyIwJL3AaMOIcJ9SOPl
         qSYA==
X-Gm-Message-State: AO0yUKULU3uWIQ1DUGNPNebDIFrsAiosxAMkVOSG5NvAYiPYKNLyvs57
        SoenMOnSo7vkYJw0eVrDMUw+K1YdBZw+4WiFOuCvJcSdK2+U
X-Google-Smtp-Source: AK7set8UFImb52ARvp+X/EngodIIwfLAX09qRWhNXdZpnqX2iO47Mt+7D3CXuwVOd0jSKDS5ED9rP59EiNOx/CZtIrFdirLgroyY
MIME-Version: 1.0
X-Received: by 2002:a92:c5cf:0:b0:310:9afc:aa6 with SMTP id
 s15-20020a92c5cf000000b003109afc0aa6mr311222ilt.0.1677707686118; Wed, 01 Mar
 2023 13:54:46 -0800 (PST)
Date:   Wed, 01 Mar 2023 13:54:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab0b2905f5ddc2dd@google.com>
Subject: [syzbot] [jfs?] KASAN: use-after-free Read in lbmIODone (2)
From:   syzbot <syzbot+aca408372ef0b470a3d2@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, jfs-discussion@lists.sourceforge.net,
        kch@nvidia.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    6e50979a9c87 Merge tag 'mm-hotfixes-stable-2023-01-16-15-2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1418f239480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e71bc04dc70cc888
dashboard link: https://syzkaller.appspot.com/bug?extid=aca408372ef0b470a3d2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/77e5e16121b6/disk-6e50979a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1aff34bbf93f/vmlinux-6e50979a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c04a4948cd33/bzImage-6e50979a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aca408372ef0b470a3d2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
BUG: KASAN: use-after-free in do_raw_spin_lock+0x265/0x2b0 kernel/locking/spinlock_debug.c:114
Read of size 4 at addr ffff888078e11954 by task ksoftirqd/1/20

CPU: 1 PID: 20 Comm: ksoftirqd/1 Not tainted 6.2.0-rc4-syzkaller-00031-g6e50979a9c87 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x461 mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
 do_raw_spin_lock+0x265/0x2b0 kernel/locking/spinlock_debug.c:114
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x45/0x60 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
 lbmIODone+0x4e7/0x10d0 fs/jfs/jfs_logmgr.c:2280
 bio_endio+0x651/0x7f0 block/bio.c:1615
 req_bio_endio block/blk-mq.c:794 [inline]
 blk_update_request+0x436/0x1380 block/blk-mq.c:926
 blk_mq_end_request+0x4f/0x80 block/blk-mq.c:1053
 lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1131
 __do_softirq+0x1fb/0xadc kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:934 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:926
 smpboot_thread_fn+0x659/0xa20 kernel/smpboot.c:164
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 12940:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa3/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 lbmLogInit fs/jfs/jfs_logmgr.c:1822 [inline]
 lmLogInit+0x3b3/0x17a0 fs/jfs/jfs_logmgr.c:1270
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x7c7/0x13e0 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0x2ed/0x690 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x9c0/0xc80 fs/jfs/super.c:565
 mount_bdev+0x351/0x410 fs/super.c:1359
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 12940:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 __cache_free mm/slab.c:3394 [inline]
 __do_kmem_cache_free mm/slab.c:3580 [inline]
 __kmem_cache_free+0xcd/0x3b0 mm/slab.c:3587
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1865 [inline]
 lmLogInit+0xb5d/0x17a0 fs/jfs/jfs_logmgr.c:1416
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x7c7/0x13e0 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0x2ed/0x690 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x9c0/0xc80 fs/jfs/super.c:565
 mount_bdev+0x351/0x410 fs/super.c:1359
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x7b/0x90 mm/kasan/generic.c:488
 __call_rcu_common.constprop.0+0x99/0x820 kernel/rcu/tree.c:2755
 neigh_parms_release net/core/neighbour.c:1759 [inline]
 neigh_parms_release+0x209/0x290 net/core/neighbour.c:1750
 addrconf_ifdown.isra.0+0x1394/0x1920 net/ipv6/addrconf.c:3904
 addrconf_notify+0x109/0x1c80 net/ipv6/addrconf.c:3673
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1944
 call_netdevice_notifiers_extack net/core/dev.c:1982 [inline]
 call_netdevice_notifiers net/core/dev.c:1996 [inline]
 unregister_netdevice_many_notify+0xa2b/0x19e0 net/core/dev.c:10839
 sit_exit_batch_net+0x534/0x750 net/ipv6/sit.c:1885
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:174
 setup_net+0x9bd/0xe60 net/core/net_namespace.c:356
 copy_net_ns+0x31b/0x6b0 net/core/net_namespace.c:483
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 copy_namespaces+0x3b3/0x4a0 kernel/nsproxy.c:179
 copy_process+0x30d3/0x7520 kernel/fork.c:2269
 kernel_clone+0xeb/0x990 kernel/fork.c:2681
 __do_sys_clone3+0x1cd/0x2e0 kernel/fork.c:2980
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888078e11900
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 84 bytes inside of
 192-byte region [ffff888078e11900, ffff888078e119c0)

The buggy address belongs to the physical page:
page:ffffea0001e38440 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x78e11
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888012440000 ffffea00005ddc10 ffffea000083aad0
raw: 0000000000000000 ffff888078e11000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x3420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 6321, tgid 6313 (syz-executor.5), ts 258457552713, free_ts 250035506651
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x119c/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x94/0x390 mm/slab.c:2574
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2947
 ____cache_alloc mm/slab.c:3023 [inline]
 ____cache_alloc mm/slab.c:3006 [inline]
 __do_cache_alloc mm/slab.c:3206 [inline]
 slab_alloc_node mm/slab.c:3254 [inline]
 __kmem_cache_alloc_node+0x44f/0x510 mm/slab.c:3544
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1062
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 afs_net_init+0x937/0xed0 fs/afs/main.c:106
 ops_init+0xb9/0x680 net/core/net_namespace.c:135
 setup_net+0x793/0xe60 net/core/net_namespace.c:333
 copy_net_ns+0x31b/0x6b0 net/core/net_namespace.c:483
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 copy_namespaces+0x3b3/0x4a0 kernel/nsproxy.c:179
 copy_process+0x30d3/0x7520 kernel/fork.c:2269
 kernel_clone+0xeb/0x990 kernel/fork.c:2681
 __do_sys_clone3+0x1cd/0x2e0 kernel/fork.c:2980
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x65c/0xc00 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page_list+0x176/0xcd0 mm/page_alloc.c:3510
 release_pages+0xcb1/0x1330 mm/swap.c:1076
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x202/0x7b0 mm/mmap.c:3100
 __mmput+0x128/0x4c0 kernel/fork.c:1207
 mmput+0x60/0x70 kernel/fork.c:1229
 exit_mm kernel/exit.c:563 [inline]
 do_exit+0x9ac/0x2950 kernel/exit.c:854
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888078e11800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888078e11880: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888078e11900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff888078e11980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888078e11a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
