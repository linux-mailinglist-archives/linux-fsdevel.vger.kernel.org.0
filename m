Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB56AA8CF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 09:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCDItu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 03:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDItt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:49:49 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1017CE4
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Mar 2023 00:49:47 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id 207-20020a6b14d8000000b0074ca9a558feso2618216iou.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Mar 2023 00:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/clmuQg4csykPnYAr5SPaxhejQDmktnwCZ8F5k+mlU=;
        b=20lAnvGlhGQLbUhuqRwbCisR8oBCXycEcO4bqSKTwB4vHDFaxRPSeJALWTrwj5sL27
         4NeqDHdGyHN0rf0VwDt2ZeNFmq7Xm7Hq6ZS8q6JlqMkEapa8dUECQFojhqBIN1gNTcLJ
         yawfbI+UDWplMhOafggo0LsJaXW0i0l+98ttEtTQ+kMhag6cn3GYVfCLmpE0fI8Iz4lu
         IXoeH9mJAj5T4dyxA3nMjbm/LVzKY3MQPhBIV0qZQQ3Go2xOJwpB5NO4cEev0Bkhm7lj
         dJpfizHfobhQ+l2jdQZsP0T9hVZkGiR2X3044ytuP7A/7vErAtnqew5bQCbWl9rDUcn+
         RErA==
X-Gm-Message-State: AO0yUKXSXtKqZsJ9Uz7Gibk2qpyB1EQHgK+N1/SkTxGIXPQsuHLZSWi8
        kyZbylWV1sMN5AWbgOOwocb512lWXFRATN3Ry4E9bdIZ2N23UyQ=
X-Google-Smtp-Source: AK7set9ciF/2qJqdDLXYIsRzOptOvr6zOAfJZmDYloNbukH4aB5KIpLpBbpH2n5cDkKVhYRWOki2ws5kH0k7C1tGI/l8HUKsypLa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ca7:b0:316:fcbe:522d with SMTP id
 7-20020a056e020ca700b00316fcbe522dmr2109402ilg.4.1677919786805; Sat, 04 Mar
 2023 00:49:46 -0800 (PST)
Date:   Sat, 04 Mar 2023 00:49:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000daaf9305f60f241c@google.com>
Subject: [syzbot] [hfs?] KASAN: invalid-free in hfs_release_folio
From:   syzbot <syzbot+9cfc27352679b68259f8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    982818426a0f Merge tag 'arm-fixes-6.3-1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e07e60c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7dc345c19eeec583
dashboard link: https://syzkaller.appspot.com/bug?extid=9cfc27352679b68259f8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9cfc27352679b68259f8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in slab_free mm/slub.c:3787 [inline]
BUG: KASAN: double-free in __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
Free of addr ffff88805136c100 by task kswapd0/101

CPU: 2 PID: 101 Comm: kswapd0 Not tainted 6.2.0-syzkaller-12765-g982818426a0f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report_invalid_free+0xe8/0x100 mm/kasan/report.c:501
 ____kasan_slab_free+0x185/0x1c0 mm/kasan/common.c:225
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 hfs_release_folio+0x462/0x570 fs/hfs/inode.c:123
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
 kswapd+0x70b/0x1000 mm/vmscan.c:7712
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 12074:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0x5a/0xd0 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 __hfs_bnode_create+0x107/0x820 fs/hfs/bnode.c:259
 hfs_bnode_find+0x423/0xc60 fs/hfs/bnode.c:335
 hfs_brec_find+0x299/0x500 fs/hfs/bfind.c:126
 hfs_brec_read+0x25/0x120 fs/hfs/bfind.c:165
 hfs_cat_find_brec+0x143/0x350 fs/hfs/catalog.c:194
 hfs_fill_super+0xfbd/0x1480 fs/hfs/super.c:419
 mount_bdev+0x351/0x410 fs/super.c:1371
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1501
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

Freed by task 5923:
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
 hfs_btree_close+0xab/0x390 fs/hfs/btree.c:154
 hfs_mdb_put+0xbf/0x380 fs/hfs/mdb.c:360
 generic_shutdown_super+0x158/0x480 fs/super.c:491
 kill_block_super+0x9b/0xf0 fs/super.c:1398
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
 insert_work+0x48/0x350 kernel/workqueue.c:1361
 __queue_work+0x693/0x1440 kernel/workqueue.c:1524
 queue_work_on+0xf2/0x110 kernel/workqueue.c:1552
 queue_work include/linux/workqueue.h:504 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:659 [inline]
 netdevice_event+0x5e9/0x8f0 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1937
 call_netdevice_notifiers_extack net/core/dev.c:1975 [inline]
 call_netdevice_notifiers net/core/dev.c:1989 [inline]
 __dev_notify_flags+0x120/0x2d0 net/core/dev.c:8564
 dev_change_flags+0x11b/0x170 net/core/dev.c:8602
 do_setlink+0x9f4/0x3d30 net/core/rtnetlink.c:2833
 __rtnl_newlink+0xd69/0x1840 net/core/rtnetlink.c:3623
 rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3670
 rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6174
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2574
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:722 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:745
 __sys_sendto+0x23a/0x340 net/socket.c:2145
 __do_compat_sys_socketcall+0x62e/0x720 net/compat.c:474
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

The buggy address belongs to the object at ffff88805136c100
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff88805136c100, ffff88805136c1c0)

The buggy address belongs to the physical page:
page:ffffea000144db00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5136c
flags: 0x4fff00000000200(slab|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000200 ffff888012442a00 ffffea00012e0480 dead000000000004
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5181, tgid 5181 (syz-executor.0), ts 303442564425, free_ts 301948879419
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x1190/0x2f80 mm/page_alloc.c:4325
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5591
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x330 mm/slub.c:3491
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1061
 kmalloc include/linux/slab.h:580 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:643 [inline]
 netdevice_event+0x368/0x8f0 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1937
 call_netdevice_notifiers_extack net/core/dev.c:1975 [inline]
 call_netdevice_notifiers net/core/dev.c:1989 [inline]
 dev_set_mac_address+0x2d7/0x3e0 net/core/dev.c:8786
 dev_set_mac_address_user+0x31/0x50 net/core/dev.c:8800
 do_setlink+0x1af3/0x3d30 net/core/rtnetlink.c:2781
 __rtnl_newlink+0xd69/0x1840 net/core/rtnetlink.c:3623
 rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3670
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x668/0xb50 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x17c/0x330 mm/slub.c:3491
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1061
 kmalloc include/linux/slab.h:580 [inline]
 netdev_name_node_alloc net/core/dev.c:259 [inline]
 netdev_name_node_head_alloc net/core/dev.c:273 [inline]
 register_netdevice+0x40a/0x1640 net/core/dev.c:9968
 veth_newlink+0x4ec/0x9c0 drivers/net/veth.c:1837
 rtnl_newlink_create net/core/rtnetlink.c:3440 [inline]
 __rtnl_newlink+0x10c2/0x1840 net/core/rtnetlink.c:3657
 rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3670
 rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6174
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2574
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:722 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:745

Memory state around the buggy address:
 ffff88805136c000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88805136c080: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805136c100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88805136c180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88805136c200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
