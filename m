Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3164B6EC6FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 09:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjDXHXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 03:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDXHXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:23:17 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4F2D5D
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:22:52 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-32addcf3a73so157697115ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320959; x=1684912959;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9yZx5o6TdXd9TV+oVLUI0JE6+dVoBosgMKvILIdJinA=;
        b=W8EFFDDTlA+r+4GEkH3DNAHwHso32eLxsX6JE5sLsm/xn+I09V4JFd3vu3v9LjyOLD
         COifq2rLPEvJzNO3uL701vI/HFVuhQripK5yR9XLtVZFAzKGok5lMPWMMs/FIc7Akg7R
         PIMwXWn9oG5i2VZ9D5SmyvfiEOdulQumW5ytjHixCcOaarh3J+QAJSAXp0X7Ag1YcWOk
         UMptxWm+b6NJVGrQk0sxn/feY07DU4G7XOhXMSqyHP6njVoheUm+J2AMV/6+MqoucycI
         pKoQ9pLwkov0Z0OM77s+ligXQjQucG5HvND89vjnsALL6RiA4r6QqGgAhTQEnoCFQsE9
         aduQ==
X-Gm-Message-State: AAQBX9ctb/CITxsf43fIejp2cgq1h3ue1sGDL4tD+YQwfXTk1TMzUu73
        9K++aoaNPO5XVqQ5sAzmN6wm3hJKv9DYkc1EXldG9BiDDq+ZMRo=
X-Google-Smtp-Source: AKy350aVaudWuq6TWaY0645B9elJS+Yq2OwDuWlvc2IqzGUdqyMRvZz12lLrCNNBHG3MiIQWXOXbp1aV3qHBfgz0TpMOCURE2R61
MIME-Version: 1.0
X-Received: by 2002:a92:d392:0:b0:32c:3272:ffdc with SMTP id
 o18-20020a92d392000000b0032c3272ffdcmr4301291ilo.3.1682320959144; Mon, 24 Apr
 2023 00:22:39 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:22:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b0ba505fa0fdf37@google.com>
Subject: [syzbot] [hfs?] KASAN: slab-use-after-free Read in hfs_btree_close
From:   syzbot <syzbot+d729df28d933979e017a@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1497b0d0280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11869c60f54496a7
dashboard link: https://syzkaller.appspot.com/bug?extid=d729df28d933979e017a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d729df28d933979e017a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
BUG: KASAN: slab-use-after-free in hfs_btree_close+0x13e/0x390 fs/hfs/btree.c:150
Read of size 4 at addr ffff8880490cfe80 by task syz-executor.0/5198

CPU: 0 PID: 5198 Comm: syz-executor.0 Not tainted 6.3.0-rc7-syzkaller-00191-g622322f53c6d #0
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
 hfs_btree_close+0x13e/0x390 fs/hfs/btree.c:150
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
RIP: 0023:0xf7fa0579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff95f7ac EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ff95f850 RCX: 000000000000000a
RDX: 00000000f734e000 RSI: 0000000000000000 RDI: 00000000f72a2535
RBP: 00000000ff95f850 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 13482:
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
 hfs_cat_find_brec+0x143/0x350 fs/hfs/catalog.c:194
 hfs_fill_super+0xfbd/0x1480 fs/hfs/super.c:419
 mount_bdev+0x351/0x410 fs/super.c:1380
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
 call_usermodehelper_exec+0x32d/0x4c0 kernel/umh.c:434
 call_modprobe kernel/kmod.c:98 [inline]
 __request_module+0x42f/0x9c0 kernel/kmod.c:170
 load_nls fs/nls/nls_base.c:293 [inline]
 load_nls+0x44/0x60 fs/nls/nls_base.c:291
 parse_options fs/hfs/super.c:341 [inline]
 hfs_fill_super+0x725/0x1480 fs/hfs/super.c:396
 mount_bdev+0x351/0x410 fs/super.c:1380
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

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 insert_work+0x48/0x350 kernel/workqueue.c:1361
 __queue_work+0x625/0x1120 kernel/workqueue.c:1524
 queue_work_on+0xf2/0x110 kernel/workqueue.c:1552
 queue_work include/linux/workqueue.h:504 [inline]
 call_usermodehelper_exec+0x32d/0x4c0 kernel/umh.c:434
 call_modprobe kernel/kmod.c:98 [inline]
 __request_module+0x42f/0x9c0 kernel/kmod.c:170
 load_nls fs/nls/nls_base.c:293 [inline]
 load_nls+0x44/0x60 fs/nls/nls_base.c:291
 parse_options fs/hfs/super.c:341 [inline]
 hfs_fill_super+0x725/0x1480 fs/hfs/super.c:396
 mount_bdev+0x351/0x410 fs/super.c:1380
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

The buggy address belongs to the object at ffff8880490cfe00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 128 bytes inside of
 freed 192-byte region [ffff8880490cfe00, ffff8880490cfec0)

The buggy address belongs to the physical page:
page:ffffea00012433c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880490cfb00 pfn:0x490cf
flags: 0x4fff00000000200(slab|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000200 ffff888012442a00 dead000000000100 dead000000000122
raw: ffff8880490cfb00 000000008010000a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5493, tgid 5491 (syz-executor.2), ts 339193208624, free_ts 338228739649
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4326
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5592
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_slab_page mm/slub.c:1853 [inline]
 allocate_slab+0xa7/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0x51/0x1a0 mm/slab_common.c:974
 kmalloc_array_node include/linux/slab.h:697 [inline]
 kcalloc_node include/linux/slab.h:702 [inline]
 memcg_alloc_slab_cgroups+0x8f/0x150 mm/memcontrol.c:2899
 memcg_slab_post_alloc_hook+0xa9/0x390 mm/slab.h:546
 slab_post_alloc_hook mm/slab.h:777 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x23c/0x600 mm/slub.c:3483
 __d_alloc+0x32/0x980 fs/dcache.c:1769
 d_alloc_pseudo+0x1d/0x70 fs/dcache.c:1899
 alloc_file_pseudo+0xca/0x250 fs/file_table.c:266
 sock_alloc_file+0x53/0x190 net/socket.c:466
 sock_map_fd net/socket.c:490 [inline]
 __sys_socket+0x1a8/0x250 net/socket.c:1669
 __do_sys_socket net/socket.c:1674 [inline]
 __se_sys_socket net/socket.c:1672 [inline]
 __ia32_sys_socket+0x73/0xb0 net/socket.c:1672
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1504
 free_unref_page_prepare mm/page_alloc.c:3388 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3483
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc5/0x140 mm/swap.c:129
 folio_put include/linux/mm.h:1309 [inline]
 put_page include/linux/mm.h:1378 [inline]
 free_page_and_swap_cache+0x257/0x2c0 mm/swap_state.c:305
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:153 [inline]
 tlb_remove_table_rcu+0x89/0xe0 mm/mmu_gather.c:208
 rcu_do_batch kernel/rcu/tree.c:2112 [inline]
 rcu_core+0x814/0x1960 kernel/rcu/tree.c:2372
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571

Memory state around the buggy address:
 ffff8880490cfd80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880490cfe00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880490cfe80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff8880490cff00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880490cff80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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
