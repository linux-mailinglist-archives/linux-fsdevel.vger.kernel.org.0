Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2826CA1F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjC0LA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjC0LAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:00:54 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA6D4218
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 04:00:52 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l8-20020a056e02066800b003247f2ba648so5515054ilt.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 04:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679914852;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PdTlIHxXe7mbuFEGpighov0Rh2YM+q9OEbNGzuyUuRE=;
        b=CCupRDBQuLtFS5zQrJeru3B3bfD3Q7U0CQwgzFJ7CZ7Wr9nnLuyL/oePXOwLImSsPx
         EXfpIRdbC4qr9EqFZpPvd5BgYE5eFT3yklGgeh8O2W7K/Em/sa88VjH4gkaoI/3ozI96
         pQqQQy2t28IfaG5Re0tZ3X6TuUrryPqh8ct/MAt6EJWDQd7tRZtjgkzaV7WusVvRXopa
         j6YQ217tSubGy+7uQFwFiySFtKvDkkRTERyi+M2/eWvEW/UgPcZcGl9SoKm35Bl2UTOA
         3L3wQJxsTRGcDfWVQ8clCXTavLg///FMBd/Muh1AST8ezhAE00ODaoIdpwd+JAsf4NBf
         8CrA==
X-Gm-Message-State: AO0yUKUfI747qWgvNzrRUCeinlNRNZvzSvfPigrwua45T10bYm9f3d+f
        V2pIOQvPoIIutKYUw/fD41uSS8cpO5zNLock9SNC2J8UFuT2
X-Google-Smtp-Source: AK7set8I9i6j8XL35aBvfcpQwHqOKf8/KZWFufGrylf2WYb8S+ag8AJR5XEPHVQ0ETNqbEpICc5Sy1GhtDJZGyl7+lKK52IEB57b
MIME-Version: 1.0
X-Received: by 2002:a02:85c5:0:b0:406:29c8:2d7c with SMTP id
 d63-20020a0285c5000000b0040629c82d7cmr4161316jai.5.1679914851916; Mon, 27 Mar
 2023 04:00:51 -0700 (PDT)
Date:   Mon, 27 Mar 2023 04:00:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000660d05f7dfa877@google.com>
Subject: [syzbot] [nilfs?] KASAN: slab-use-after-free Read in nilfs_segctor_thread
From:   syzbot <syzbot+b08ebcc22f8f3e6be43a@syzkaller.appspotmail.com>
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

HEAD commit:    2faac9a98f01 Merge tag 'keys-fixes-20230321' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1207516ac80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aaa4b45720ca0519
dashboard link: https://syzkaller.appspot.com/bug?extid=b08ebcc22f8f3e6be43a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b08ebcc22f8f3e6be43a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x405b/0x5d40 kernel/locking/lockdep.c:4926
Read of size 8 at addr ffff888019c16258 by task segctord/11135

CPU: 1 PID: 11135 Comm: segctord Not tainted 6.3.0-rc3-syzkaller-00016-g2faac9a98f01 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 __lock_acquire+0x405b/0x5d40 kernel/locking/lockdep.c:4926
 lock_acquire kernel/locking/lockdep.c:5669 [inline]
 lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
 nilfs_segctor_thread+0x6d0/0xf30 fs/nilfs2/segment.c:2616
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 11132:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 nilfs_segctor_new fs/nilfs2/segment.c:2659 [inline]
 nilfs_attach_log_writer+0x15a/0xa50 fs/nilfs2/segment.c:2789
 nilfs_fill_super fs/nilfs2/super.c:1082 [inline]
 nilfs_mount+0xc35/0x1150 fs/nilfs2/super.c:1324
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3042 [inline]
 path_mount+0x1342/0x1e40 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __ia32_sys_mount+0x282/0x300 fs/namespace.c:3571
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Freed by task 5177:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 nilfs_segctor_destroy fs/nilfs2/segment.c:2758 [inline]
 nilfs_detach_log_writer+0x59b/0x9f0 fs/nilfs2/segment.c:2816
 nilfs_put_super+0x43/0x1b0 fs/nilfs2/super.c:477
 generic_shutdown_super+0x158/0x480 fs/super.c:500
 kill_block_super+0x9b/0xf0 fs/super.c:1407
 deactivate_locked_super+0x98/0x160 fs/super.c:331
 deactivate_super+0xb1/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 kvfree_call_rcu+0x70/0xad0 kernel/rcu/tree.c:3316
 neigh_destroy+0x433/0x660 net/core/neighbour.c:941
 neigh_release include/net/neighbour.h:449 [inline]
 neigh_cleanup_and_release+0x1f8/0x280 net/core/neighbour.c:103
 neigh_flush_dev+0x4cb/0x890 net/core/neighbour.c:421
 __neigh_ifdown.isra.0+0x54/0x400 net/core/neighbour.c:438
 neigh_ifdown+0x1f/0x30 net/core/neighbour.c:456
 rt6_disable_ip+0x14d/0x9e0 net/ipv6/route.c:4894
 addrconf_ifdown.isra.0+0x11a/0x1940 net/ipv6/addrconf.c:3755
 addrconf_notify+0x106/0x19f0 net/ipv6/addrconf.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1937
 call_netdevice_notifiers_extack net/core/dev.c:1975 [inline]
 call_netdevice_notifiers net/core/dev.c:1989 [inline]
 dev_close_many+0x309/0x630 net/core/dev.c:1530
 unregister_netdevice_many_notify+0x414/0x1910 net/core/dev.c:10816
 unregister_netdevice_many net/core/dev.c:10899 [inline]
 default_device_exit_batch+0x451/0x5b0 net/core/dev.c:11352
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:174
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2622
 pwq_unbound_release_workfn+0x26b/0x340 kernel/workqueue.c:3849
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888019c16000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 600 bytes inside of
 freed 1024-byte region [ffff888019c16000, ffff888019c16400)

The buggy address belongs to the physical page:
page:ffffea0000670400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x19c10
head:ffffea0000670400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012442dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5215, tgid 5215 (kworker/3:3), ts 201052079376, free_ts 61109797375
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4325
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5591
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node_track_caller+0x4f/0x1a0 mm/slab_common.c:987
 kmalloc_reserve+0xf0/0x270 net/core/skbuff.c:537
 __alloc_skb+0x129/0x330 net/core/skbuff.c:606
 alloc_skb include/linux/skbuff.h:1277 [inline]
 nlmsg_new include/net/netlink.h:1003 [inline]
 inet6_rt_notify+0xf0/0x2b0 net/ipv6/route.c:6166
 fib6_add_rt2node net/ipv6/ip6_fib.c:1251 [inline]
 fib6_add+0x200d/0x4080 net/ipv6/ip6_fib.c:1477
 __ip6_ins_rt net/ipv6/route.c:1302 [inline]
 ip6_ins_rt+0xb6/0x110 net/ipv6/route.c:1312
 __ipv6_ifa_notify+0x8fe/0xb90 net/ipv6/addrconf.c:6162
 ipv6_ifa_notify net/ipv6/addrconf.c:6201 [inline]
 addrconf_dad_completed+0x133/0xda0 net/ipv6/addrconf.c:4214
 addrconf_dad_begin net/ipv6/addrconf.c:4019 [inline]
 addrconf_dad_work+0x820/0x1390 net/ipv6/addrconf.c:4121
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc5/0x140 mm/swap.c:129
 folio_put include/linux/mm.h:1309 [inline]
 put_page include/linux/mm.h:1378 [inline]
 anon_pipe_buf_release+0x3fb/0x4c0 fs/pipe.c:138
 pipe_buf_release include/linux/pipe_fs_i.h:203 [inline]
 pipe_read+0x614/0x1110 fs/pipe.c:324
 call_read_iter include/linux/fs.h:1845 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7fa/0x930 fs/read_write.c:470
 ksys_read+0x1ec/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888019c16100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888019c16180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888019c16200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888019c16280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888019c16300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
