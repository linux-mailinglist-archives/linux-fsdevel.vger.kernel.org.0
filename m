Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF06EC671
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 08:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjDXGpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 02:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjDXGpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:45:00 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659C26B7
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 23:44:52 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7606df33b58so314609839f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 23:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682318691; x=1684910691;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udXLCRs4rTkgWo6mox+Ws2n/gtvqlvXJXZNFCfiwEhA=;
        b=dRwmWVdy3sBL4+hjQ94gYPR8sIm9WYG/5pdzHrw08CGS8ap0fFv6GbDpC1K8AHBcBh
         SAcUcPk8KGfBirsnRnebBviw0dnfjj2hdW1lIpREC1kvRb8Lka65DeeZa6ITFgVtLB8r
         tkQNJAUd7xnlwWPhYfH5W24oziJTh+LXrAvtFue8Bt6/y+FRv+XyBImAsInF8oiR9OT2
         XFeoiWue0WC1g1lK9/xg3Rkie5IGXxMceRxbtKdg7OEDUptqHjlFZSoptXnZzs/xhMgJ
         tfPl2yLtZ8YYlJOjfrXDlP9QmpDjt+vy0L0wfRmGqT9yqn7d78wd39HrWF5wtLQ4LLzX
         7dHg==
X-Gm-Message-State: AAQBX9flPC7483X5zHj9Q675nNZWgIn7JM6/Z4vX1FA2KPfFm6Wjdced
        1oJp6CnIPRhfqN/0V/gjJLj1/XjRPBlIKmwjLQc7H1pu+fOsGy4=
X-Google-Smtp-Source: AKy350bsELAdoJVg1aQoQ2bbCWQZoEpzU9iHPbaDDXUyh41KhWyoFwZHHjkWCn5pSMUYSwgZZ3J1zGcLLK53z+oh2B5lDPqibT4U
MIME-Version: 1.0
X-Received: by 2002:a6b:ed12:0:b0:763:ad78:6b46 with SMTP id
 n18-20020a6bed12000000b00763ad786b46mr4091669iog.3.1682318691517; Sun, 23 Apr
 2023 23:44:51 -0700 (PDT)
Date:   Sun, 23 Apr 2023 23:44:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000024c8a05fa0f5876@google.com>
Subject: [syzbot] [hfs?] KASAN: invalid-free in hfsplus_release_folio
From:   syzbot <syzbot+fe580b81668777c77370@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    622322f53c6d Merge tag 'mips-fixes_6.3_2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171a5858280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f50728861d49a880
dashboard link: https://syzkaller.appspot.com/bug?extid=fe580b81668777c77370
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe580b81668777c77370@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in hfsplus_release_folio+0x28d/0x5f0 fs/hfsplus/inode.c:103
Free of addr ffff888027e37500 by task kswapd1/111

CPU: 1 PID: 111 Comm: kswapd1 Not tainted 6.3.0-rc7-syzkaller-00191-g622322f53c6d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report_invalid_free+0xe8/0x100 mm/kasan/report.c:501
 ____kasan_slab_free+0x160/0x1a0 mm/kasan/common.c:225
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
 </TASK>

Allocated by task 14963:
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
 hfsplus_btree_write+0x1e/0x470 fs/hfsplus/btree.c:289
 hfsplus_system_write_inode fs/hfsplus/super.c:136 [inline]
 hfsplus_write_inode fs/hfsplus/super.c:162 [inline]
 hfsplus_write_inode+0x323/0x520 fs/hfsplus/super.c:147
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0x9f8/0xdc0 fs/fs-writeback.c:1668
 writeback_sb_inodes+0x54d/0xe70 fs/fs-writeback.c:1894
 wb_writeback+0x294/0xa50 fs/fs-writeback.c:2068
 wb_do_writeback fs/fs-writeback.c:2211 [inline]
 wb_workfn+0x2a5/0xfc0 fs/fs-writeback.c:2251
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Freed by task 26614:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 __cache_free mm/slab.c:3390 [inline]
 __do_kmem_cache_free mm/slab.c:3577 [inline]
 __kmem_cache_free+0xcd/0x2c0 mm/slab.c:3584
 hfsplus_btree_close+0xab/0x390 fs/hfsplus/btree.c:275
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

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x7b/0x90 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2622
 neigh_parms_release net/core/neighbour.c:1781 [inline]
 neigh_parms_release+0x209/0x290 net/core/neighbour.c:1772
 addrconf_ifdown.isra.0+0x1394/0x1940 net/ipv6/addrconf.c:3909
 addrconf_notify+0x106/0x19f0 net/ipv6/addrconf.c:3678
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1937
 call_netdevice_notifiers_extack net/core/dev.c:1975 [inline]
 call_netdevice_notifiers net/core/dev.c:1989 [inline]
 unregister_netdevice_many_notify+0x75f/0x18c0 net/core/dev.c:10844
 unregister_netdevice_many net/core/dev.c:10900 [inline]
 default_device_exit_batch+0x451/0x5b0 net/core/dev.c:11353
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:174
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x7b/0x90 mm/kasan/generic.c:491
 insert_work+0x48/0x350 kernel/workqueue.c:1361
 __queue_work+0x625/0x1120 kernel/workqueue.c:1524
 queue_work_on+0xf2/0x110 kernel/workqueue.c:1552
 queue_work include/linux/workqueue.h:504 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:659 [inline]
 netdevice_event+0x5e9/0x8f0 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1937
 call_netdevice_notifiers_extack net/core/dev.c:1975 [inline]
 call_netdevice_notifiers net/core/dev.c:1989 [inline]
 register_netdevice+0xfb4/0x1640 net/core/dev.c:10080
 __ip_tunnel_create+0x398/0x5b0 net/ipv4/ip_tunnel.c:267
 ip_tunnel_init_net+0x1f9/0x5d0 net/ipv4/ip_tunnel.c:1073
 ops_init+0xb9/0x6b0 net/core/net_namespace.c:135
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:338
 copy_net_ns+0x4ee/0x8e0 net/core/net_namespace.c:490
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x449/0x920 kernel/fork.c:3204
 __do_sys_unshare kernel/fork.c:3275 [inline]
 __se_sys_unshare kernel/fork.c:3273 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3273
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888027e37500
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff888027e37500, ffff888027e375c0)

The buggy address belongs to the physical page:
page:ffffea00009f8dc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888027e37c00 pfn:0x27e37
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888012440000 ffffea000000e1d0 ffffea00008f5d90
raw: ffff888027e37c00 ffff888027e37000 000000010000000e 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 5187, tgid 5187 (syz-executor.3), ts 324581905282, free_ts 324551889087
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
 __do_cache_alloc mm/slab.c:3205 [inline]
 slab_alloc_node mm/slab.c:3250 [inline]
 __kmem_cache_alloc_node+0x382/0x3f0 mm/slab.c:3541
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0x51/0x1a0 mm/slab_common.c:974
 kmalloc_array_node include/linux/slab.h:697 [inline]
 kcalloc_node include/linux/slab.h:702 [inline]
 memcg_alloc_slab_cgroups+0xee/0x1e0 mm/memcontrol.c:2899
 memcg_slab_post_alloc_hook+0xaa/0x340 mm/slab.h:546
 slab_post_alloc_hook mm/slab.h:777 [inline]
 slab_alloc_node mm/slab.c:3257 [inline]
 slab_alloc mm/slab.c:3266 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3443 [inline]
 kmem_cache_alloc+0x1f1/0x3f0 mm/slab.c:3452
 vm_area_dup+0x21/0x1f0 kernel/fork.c:466
 dup_mmap+0x6bd/0x1480 kernel/fork.c:644
 dup_mm kernel/fork.c:1549 [inline]
 copy_mm kernel/fork.c:1598 [inline]
 copy_process+0x7082/0x7590 kernel/fork.c:2268
 kernel_clone+0xeb/0x890 kernel/fork.c:2683
 __do_sys_clone+0xba/0x100 kernel/fork.c:2824
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
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
 kzalloc include/linux/slab.h:720 [inline]
 tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
 tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
 tomoyo_encode+0x2c/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x185/0x600 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x297/0x3a0 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:332 [inline]
 tomoyo_file_open+0xa1/0xc0 security/tomoyo/tomoyo.c:327
 security_file_open+0x49/0xb0 security/security.c:1719
 do_dentry_open+0x575/0x13f0 fs/open.c:907

Memory state around the buggy address:
 ffff888027e37400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027e37480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888027e37500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888027e37580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888027e37600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
