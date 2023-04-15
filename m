Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12006E3483
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 01:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDOXgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 19:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDOXgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 19:36:46 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F71D26B8
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Apr 2023 16:36:44 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id i5-20020a6b5405000000b00760b628983bso2561424iob.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Apr 2023 16:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681601803; x=1684193803;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDIgoJJi6nUN/EkER2pX/8ELlDitB/1nSQvwRNhRY+M=;
        b=VcfXQLeJUvQr5fmaWOwvBOVcb+OVLVMymcExXRp4UYSM+a2RmRdxKCbr2HYHYFzHXP
         FtqMB3CYBZCMJ08lZczN2/8ZOJho6mtPIj6/j83fOKbEUw1HjRJCohEe/wuG60H542pQ
         BZ3box1N7eFyYjHATFQgJIcNNRP6E6vjiy1en7NDu6FsYwWZV6MLGH2aCoJ+Qi/2jcqQ
         hxGNjcKYUQ1vJQQstYMateoaH2XMXvJp1N7uuCSyFI8MLPkzCiUayJpceLU0Uk0OX+1Y
         AwGZmhkgiASj4tmIqS28mXpG1j35xg6ZtizvMlie4B9z2LRu627fIU2I/r2S25RkaMw4
         /1jw==
X-Gm-Message-State: AAQBX9fLBXBItgbdvYQ9OB+Mx92Yq5P9iYkpAP+GE770XIP9pBf+Uzf+
        a1HEth3qbQQ/EIFDCspzZTR+7N7aqpkFnzW3zmDc59TyyyQcF8c=
X-Google-Smtp-Source: AKy350bfuMehOzP4znnpfXH3MEAvPvfYGjvfz7oLeOOBW1twiy+136N9iAYh1sCwQ0mFeWbpIntPK9LLj6oga0t1sFQP+qF8RWmV
MIME-Version: 1.0
X-Received: by 2002:a02:734e:0:b0:40f:910c:92d6 with SMTP id
 a14-20020a02734e000000b0040f910c92d6mr1511062jae.6.1681601803480; Sat, 15 Apr
 2023 16:36:43 -0700 (PDT)
Date:   Sat, 15 Apr 2023 16:36:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026822805f9686ec3@google.com>
Subject: [syzbot] [hfs?] KASAN: invalid-free in hfs_btree_close
From:   syzbot <syzbot+94ed80383f40da9ffb73@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    2c40519251d6 Merge tag 'for-6.3-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137431adc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
dashboard link: https://syzkaller.appspot.com/bug?extid=94ed80383f40da9ffb73
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94ed80383f40da9ffb73@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in slab_free mm/slub.c:3787 [inline]
BUG: KASAN: double-free in __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
Free of addr ffff888076ef5500 by task syz-executor.2/5186

CPU: 3 PID: 5186 Comm: syz-executor.2 Not tainted 6.3.0-rc6-syzkaller-00030-g2c40519251d6 #0
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
 hfs_btree_close+0xab/0x390 fs/hfs/btree.c:154
 hfs_mdb_put+0xbf/0x380 fs/hfs/mdb.c:360
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
 __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f06579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffa8baec EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffa8bb90 RCX: 000000000000000a
RDX: 00000000f734e000 RSI: 0000000000000000 RDI: 00000000f72a2535
RBP: 00000000ffa8bb90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 19287:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0x5e/0x190 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 __hfs_bnode_create+0x107/0x820 fs/hfs/bnode.c:259
 hfs_bnode_find+0x423/0xc60 fs/hfs/bnode.c:335
 hfs_brec_find+0x299/0x500 fs/hfs/bfind.c:126
 hfs_brec_read+0x25/0x120 fs/hfs/bfind.c:165
 hfs_lookup+0x1e2/0x310 fs/hfs/dir.c:32
 lookup_open.isra.0+0x944/0x1400 fs/namei.c:3394
 open_last_lookups fs/namei.c:3484 [inline]
 path_openat+0x975/0x2750 fs/namei.c:3712
 do_filp_open+0x1ba/0x410 fs/namei.c:3742
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_compat_sys_openat fs/open.c:1424 [inline]
 __se_compat_sys_openat fs/open.c:1422 [inline]
 __ia32_compat_sys_openat+0x143/0x1f0 fs/open.c:1422
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Freed by task 110:
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
 kswapd+0x677/0xd60 mm/vmscan.c:7712
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 insert_work+0x48/0x350 kernel/workqueue.c:1361
 __queue_work+0x625/0x1120 kernel/workqueue.c:1524
 queue_work_on+0xf2/0x110 kernel/workqueue.c:1552
 queue_work include/linux/workqueue.h:504 [inline]
 addr_event.part.0+0x33e/0x4f0 drivers/infiniband/core/roce_gid_mgmt.c:853
 addr_event drivers/infiniband/core/roce_gid_mgmt.c:824 [inline]
 inet6addr_event+0x142/0x1c0 drivers/infiniband/core/roce_gid_mgmt.c:883
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 atomic_notifier_call_chain+0x73/0x1c0 kernel/notifier.c:225
 ipv6_add_addr+0x1266/0x1e30 net/ipv6/addrconf.c:1165
 inet6_addr_add+0x412/0xae0 net/ipv6/addrconf.c:2969
 inet6_rtm_newaddr+0xfa8/0x1a60 net/ipv6/addrconf.c:4932
 rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6174
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2577
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 __sys_sendto+0x23a/0x340 net/socket.c:2142
 __do_compat_sys_socketcall+0x62e/0x720 net/compat.c:474
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

The buggy address belongs to the object at ffff888076ef5500
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff888076ef5500, ffff888076ef55c0)

The buggy address belongs to the physical page:
page:ffffea0001dbbd40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76ef5
anon flags: 0x4fff00000000200(slab|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000200 ffff888012442a00 ffffea0001c03480 dead000000000005
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 14016, tgid 14015 (syz-executor.1), ts 422366999569, free_ts 418984846962
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4326
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5592
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
 __do_krealloc mm/slab_common.c:1364 [inline]
 krealloc+0x5e/0x100 mm/slab_common.c:1397
 copy_array+0x81/0xe0 kernel/bpf/verifier.c:1221
 copy_verifier_state+0xa9/0xc60 kernel/bpf/verifier.c:1405
 is_state_visited kernel/bpf/verifier.c:14429 [inline]
 do_check kernel/bpf/verifier.c:14547 [inline]
 do_check_common+0x272e/0xbd20 kernel/bpf/verifier.c:17098
 do_check_main kernel/bpf/verifier.c:17161 [inline]
 bpf_check+0x77ac/0xae80 kernel/bpf/verifier.c:17768
 bpf_prog_load+0x16d9/0x21d0 kernel/bpf/syscall.c:2632
 __sys_bpf+0x1435/0x5100 kernel/bpf/syscall.c:4992
 __do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
 __ia32_sys_bpf+0x78/0xe0 kernel/bpf/syscall.c:5094
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1504
 free_unref_page_prepare mm/page_alloc.c:3388 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3483
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 kmem_cache_alloc_node+0x185/0x3e0 mm/slub.c:3497
 __alloc_skb+0x288/0x330 net/core/skbuff.c:596
 alloc_skb include/linux/skbuff.h:1277 [inline]
 nlmsg_new include/net/netlink.h:1003 [inline]
 netlink_ack+0x357/0x1360 net/netlink/af_netlink.c:2514
 netlink_rcv_skb+0x34f/0x440 net/netlink/af_netlink.c:2583
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x71c/0x900 net/socket.c:2501
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2555
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2584

Memory state around the buggy address:
 ffff888076ef5400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888076ef5480: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888076ef5500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888076ef5580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888076ef5600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	retq
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
