Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEDA6DD308
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjDKGkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjDKGkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:40:43 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA2513D
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:40:40 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z13-20020a921a4d000000b00328a272a056so4223133ill.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195240; x=1683787240;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8SB7ddLPiEqbnM2cwS1Xl7hZP3YO9anUyQLlWPDh/c=;
        b=5BU49J17MGmMp1XjIO7cVk+TKf9om4EJxAXCVZ6WAySXeEEVFWkONCIVvqh4XjVKHZ
         xF60covdBQ6GidVnXyyRCxhmrajSw6QJCYZkOrEEBLuFhCLHDUhJv016sRCbP42RamRU
         46uB5RanJEBZUP5wUlBHzPNDMTPkguFLgLYhb7ZCMthgbh2EP+vyg2ZOONzmlT1K1G4E
         nrU4rCxa9vqWPE5Egvy1JFzGJcY7qq2jgCPfpHeGG9yixSyIBgDcAhnygha6gvZIFzl+
         U9u7FreWj8b8LpPn1pArx+AsgD8Ky9BbtlgPOOcGTEM3Zf2hGl+ydAGoNoQsGP4rK/xL
         T2Bg==
X-Gm-Message-State: AAQBX9dVnyUmSpePbtnJH7UhGpaWqGeZnmwn+bljsBKYNX0CbESCANNg
        3JKu8PlX4QgG/KjfhpDyzPA43vEiE/AbQRivoOieSDzyS703SdY=
X-Google-Smtp-Source: AKy350awQ+hl2CuEiNCuwlyZXDUgTbs1LyNqA0dqrXnId+LT3kZemLEq+3QraD73bXxUHmkTKBMrdkh/AGlds5y/tP490l9xIVDJ
MIME-Version: 1.0
X-Received: by 2002:a5d:914f:0:b0:75d:24fe:b2c with SMTP id
 y15-20020a5d914f000000b0075d24fe0b2cmr790024ioq.0.1681195240290; Mon, 10 Apr
 2023 23:40:40 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:40:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000187e5705f909c520@google.com>
Subject: [syzbot] [hfs?] KASAN: slab-use-after-free Read in hfsplus_btree_close
From:   syzbot <syzbot+e2d40f68d1e88d8ad764@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    76f598ba7d8e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1297aeaec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adfc55aec6afccdd
dashboard link: https://syzkaller.appspot.com/bug?extid=e2d40f68d1e88d8ad764
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2d40f68d1e88d8ad764@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
BUG: KASAN: slab-use-after-free in hfsplus_btree_close+0x13e/0x390 fs/hfsplus/btree.c:270
Read of size 4 at addr ffff888029e58b80 by task syz-executor.1/5965

CPU: 2 PID: 5965 Comm: syz-executor.1 Not tainted 6.3.0-rc5-syzkaller-00022-g76f598ba7d8e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
 hfsplus_btree_close+0x13e/0x390 fs/hfsplus/btree.c:270
 hfsplus_put_super+0x24c/0x3f0 fs/hfsplus/super.c:301
 generic_shutdown_super+0x158/0x480 fs/super.c:500
 kill_block_super+0x9b/0xf0 fs/super.c:1407
 deactivate_locked_super+0x98/0x160 fs/super.c:331
 deactivate_super+0xb1/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbb9928d5d7
Code: Unable to access opcode bytes at 0x7fbb9928d5ad.
RSP: 002b:00007ffe3ba772f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fbb9928d5d7
RDX: 00007ffe3ba773cb RSI: 000000000000000a RDI: 00007ffe3ba773c0
RBP: 00007ffe3ba773c0 R08: 00000000ffffffff R09: 00007ffe3ba77190
R10: 00005555560cb8b3 R11: 0000000000000246 R12: 00007fbb992e6cdc
R13: 00007ffe3ba78480 R14: 00005555560cb810 R15: 00007ffe3ba784c0
 </TASK>

Allocated by task 9952:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa3/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0x5e/0x190 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 __hfs_bnode_create+0x107/0x840 fs/hfsplus/bnode.c:409
 hfsplus_bnode_find+0x41c/0xc60 fs/hfsplus/bnode.c:486
 hfsplus_brec_find+0x2b3/0x520 fs/hfsplus/bfind.c:183
 hfsplus_brec_read+0x2c/0x120 fs/hfsplus/bfind.c:222
 hfsplus_find_cat+0x1d4/0x4c0 fs/hfsplus/catalog.c:202
 hfsplus_iget+0x480/0x7c0 fs/hfsplus/super.c:82
 hfsplus_fill_super+0xc86/0x1c40 fs/hfsplus/super.c:503
 mount_bdev+0x351/0x410 fs/super.c:1380
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3042 [inline]
 path_mount+0x1342/0x1e40 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 101:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 __cache_free mm/slab.c:3390 [inline]
 __do_kmem_cache_free mm/slab.c:3577 [inline]
 __kmem_cache_free+0xcd/0x2c0 mm/slab.c:3584
 hfsplus_release_folio+0x28d/0x5f0 fs/hfsplus/inode.c:103
 filemap_release_folio+0x13f/0x1b0 mm/filemap.c:4121
 shrink_folio_list+0x1fe3/0x3c80 mm/vmscan.c:2010
 evict_folios+0x794/0x1940 mm/vmscan.c:5121
 try_to_shrink_lruvec+0x82c/0xb90 mm/vmscan.c:5297
 shrink_one+0x46b/0x810 mm/vmscan.c:5341
 shrink_many mm/vmscan.c:5394 [inline]
 lru_gen_shrink_node mm/vmscan.c:5511 [inline]
 shrink_node+0x2064/0x35f0 mm/vmscan.c:6459
 kswapd_shrink_node mm/vmscan.c:7262 [inline]
 balance_pgdat+0xa02/0x1ac0 mm/vmscan.c:7452
 kswapd+0x677/0xd60 mm/vmscan.c:7712
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x7b/0x90 mm/kasan/generic.c:491
 insert_work+0x48/0x350 kernel/workqueue.c:1361
 __queue_work+0x625/0x1120 kernel/workqueue.c:1524
 queue_work_on+0xf2/0x110 kernel/workqueue.c:1552
 queue_work include/linux/workqueue.h:504 [inline]
 addr_event.part.0+0x33e/0x4f0 drivers/infiniband/core/roce_gid_mgmt.c:853
 addr_event drivers/infiniband/core/roce_gid_mgmt.c:824 [inline]
 inetaddr_event+0x130/0x1a0 drivers/infiniband/core/roce_gid_mgmt.c:869
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 blocking_notifier_call_chain kernel/notifier.c:382 [inline]
 blocking_notifier_call_chain+0x6b/0xa0 kernel/notifier.c:370
 __inet_insert_ifa+0x955/0xc10 net/ipv4/devinet.c:555
 inet_rtm_newaddr+0x579/0x9d0 net/ipv4/devinet.c:961
 rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6174
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2574
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 __sys_sendto+0x23a/0x340 net/socket.c:2142
 __do_sys_sendto net/socket.c:2154 [inline]
 __se_sys_sendto net/socket.c:2150 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2150
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x7b/0x90 mm/kasan/generic.c:491
 kvfree_call_rcu+0x70/0xad0 kernel/rcu/tree.c:3316
 fib_rules_unregister+0x35f/0x450 net/core/fib_rules.c:207
 ip_fib_net_exit+0x212/0x310 net/ipv4/fib_frontend.c:1593
 fib_net_exit_batch+0x53/0xa0 net/ipv4/fib_frontend.c:1640
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:174
 setup_net+0x7fb/0xc50 net/core/net_namespace.c:361
 copy_net_ns+0x4ee/0x8e0 net/core/net_namespace.c:490
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x449/0x920 kernel/fork.c:3200
 __do_sys_unshare kernel/fork.c:3271 [inline]
 __se_sys_unshare kernel/fork.c:3269 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3269
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888029e58b00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 128 bytes inside of
 freed 192-byte region [ffff888029e58b00, ffff888029e58bc0)

The buggy address belongs to the physical page:
page:ffffea0000a79600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29e58
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888012440000 ffffea0000a0d190 ffffea00003f2e10
raw: 0000000000000000 ffff888029e58000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 6257, tgid 6247 (syz-executor.1), ts 431044709602, free_ts 369099121584
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4326
 __alloc_pages_slowpath.constprop.0+0x2e7/0x2170 mm/page_alloc.c:5126
 __alloc_pages+0x408/0x4a0 mm/page_alloc.c:5605
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1360 [inline]
 cache_grow_begin+0x9b/0x3b0 mm/slab.c:2570
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2943
 ____cache_alloc mm/slab.c:3019 [inline]
 ____cache_alloc mm/slab.c:3002 [inline]
 __do_cache_alloc mm/slab.c:3202 [inline]
 slab_alloc_node mm/slab.c:3250 [inline]
 __kmem_cache_alloc_node+0x360/0x3f0 mm/slab.c:3541
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x4e/0x190 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 ops_init+0x16b/0x6b0 net/core/net_namespace.c:125
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:338
 copy_net_ns+0x4ee/0x8e0 net/core/net_namespace.c:490
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x449/0x920 kernel/fork.c:3200
 __do_sys_unshare kernel/fork.c:3271 [inline]
 __se_sys_unshare kernel/fork.c:3269 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3269
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1504
 free_unref_page_prepare mm/page_alloc.c:3388 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3483
 slab_destroy mm/slab.c:1613 [inline]
 slabs_destroy+0x85/0xc0 mm/slab.c:1633
 cache_flusharray mm/slab.c:3361 [inline]
 ___cache_free+0x2ae/0x3d0 mm/slab.c:3424
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x4f/0x1a0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slab.c:3257 [inline]
 __kmem_cache_alloc_node+0x1fc/0x3f0 mm/slab.c:3541
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x4e/0x190 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 tomoyo_realpath_from_path+0xc3/0x600 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x297/0x3a0 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:332 [inline]
 tomoyo_file_open+0xa1/0xc0 security/tomoyo/tomoyo.c:327
 security_file_open+0x49/0xb0 security/security.c:1719
 do_dentry_open+0x575/0x13f0 fs/open.c:907
 do_open fs/namei.c:3560 [inline]
 path_openat+0x1baa/0x2750 fs/namei.c:3715
 do_filp_open+0x1ba/0x410 fs/namei.c:3742

Memory state around the buggy address:
 ffff888029e58a80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888029e58b00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888029e58b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff888029e58c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888029e58c80: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
