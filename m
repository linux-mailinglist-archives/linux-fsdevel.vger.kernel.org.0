Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4A5394CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbiEaQPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346050AbiEaQPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 12:15:23 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132F595DF0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 09:15:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id y12-20020a5e920c000000b006657a63c653so7122991iop.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 09:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nWWp8j9KvBiixeLt1X1k4Z45jEknma1ERNmRamILpco=;
        b=M8p8Qck/iIV9xMxK7WDbC5Wg8lDE15kSgOlTmXbIxBGfE4WXmbEWfnpONdI7EWyXxs
         Bf0VQaWAkOd/1SeXc3cQbTwFl0BfXf70j4Q/qz4F8LWD0eM0n9HTSsS9KYK1/SztHSuq
         gZm5acIH9JU+v8csqCGexdAnAB5gFHWRQoaQByBW7NSNebhYtIIjVc5t5DNaSCo9x1Q4
         etuUzFuePoz1h2bgl6fAsV1QApW78Hx/IF8zNV6fmopaSwPXj/AGVIk4kuAtFL8oMJXr
         kvy5aHgvboAydU54IE/HQBdtM3M8v40uakpnZltq7mxBmrrtU8zqmabGp1+ubWr/aIHc
         kwFQ==
X-Gm-Message-State: AOAM533He6QlKwR1d50tcHQeOXNhl7Cuhx/3FU8t8cuypJQNsdsOgYaj
        ReTGNpftbh6sFap69cfcfDoy+HaVc0Rbid1S79/ou0AA4bmS
X-Google-Smtp-Source: ABdhPJykoVUQiy/wPBTxFuazw7T3ySul+uhFSduE5EHkFcTRZauVLSc9w/ZQ2AyLIJYoAJDTZHAAVwlJH1J90z4SM8Yx3RqjIpL/
MIME-Version: 1.0
X-Received: by 2002:a92:c566:0:b0:2d1:a097:f8b7 with SMTP id
 b6-20020a92c566000000b002d1a097f8b7mr25335148ilj.136.1654013721408; Tue, 31
 May 2022 09:15:21 -0700 (PDT)
Date:   Tue, 31 May 2022 09:15:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000517ca505e0511450@google.com>
Subject: [syzbot] KASAN: invalid-free in put_fs_context
From:   syzbot <syzbot+c43f99ad3371be25945f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=103d9af5f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
dashboard link: https://syzkaller.appspot.com/bug?extid=c43f99ad3371be25945f
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c43f99ad3371be25945f@syzkaller.appspotmail.com

cgroup: Unknown subsys name 'net'
==================================================================
BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3509 [inline]
BUG: KASAN: double-free or invalid-free in kfree+0xe0/0x3e4 mm/slub.c:4562

CPU: 1 PID: 2044 Comm: syz-executor Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
[<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
[<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
[<ffffffff8047479e>] print_address_description.constprop.0+0x2a/0x330 mm/kasan/report.c:255
[<ffffffff80474b98>] kasan_report_invalid_free+0x62/0x92 mm/kasan/report.c:381
[<ffffffff80473a82>] ____kasan_slab_free+0x170/0x180 mm/kasan/common.c:346
[<ffffffff80473fde>] __kasan_slab_free+0x10/0x18 mm/kasan/common.c:374
[<ffffffff80469750>] kasan_slab_free include/linux/kasan.h:236 [inline]
[<ffffffff80469750>] slab_free_hook mm/slub.c:1728 [inline]
[<ffffffff80469750>] slab_free_freelist_hook+0x8e/0x1cc mm/slub.c:1754
[<ffffffff8046d302>] slab_free mm/slub.c:3509 [inline]
[<ffffffff8046d302>] kfree+0xe0/0x3e4 mm/slub.c:4562
[<ffffffff80558ba2>] put_fs_context+0x2b8/0x404 fs/fs_context.c:478
[<ffffffff805225a0>] do_new_mount fs/namespace.c:2998 [inline]
[<ffffffff805225a0>] path_mount+0x606/0x14dc fs/namespace.c:3324
[<ffffffff80524014>] do_mount fs/namespace.c:3337 [inline]
[<ffffffff80524014>] __do_sys_mount fs/namespace.c:3545 [inline]
[<ffffffff80524014>] sys_mount+0x360/0x3ee fs/namespace.c:3522
[<ffffffff80005716>] ret_from_syscall+0x0/0x2

Allocated by task 0:
(stack is not available)

Freed by task 2044:
 stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
 kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38
 kasan_set_track+0x1a/0x26 mm/kasan/common.c:45
 kasan_set_free_info+0x1e/0x3a mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x15e/0x180 mm/kasan/common.c:328
 __kasan_slab_free+0x10/0x18 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8e/0x1cc mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xe0/0x3e4 mm/slub.c:4562
 put_fs_context+0x2b8/0x404 fs/fs_context.c:478
 do_new_mount fs/namespace.c:2998 [inline]
 path_mount+0x606/0x14dc fs/namespace.c:3324
 do_mount fs/namespace.c:3337 [inline]
 __do_sys_mount fs/namespace.c:3545 [inline]
 sys_mount+0x360/0x3ee fs/namespace.c:3522
 ret_from_syscall+0x0/0x2

The buggy address belongs to the object at ffffaf800ecb0000
 which belongs to the cache kmalloc-cg-512 of size 512
The buggy address is located 272 bytes inside of
 512-byte region [ffffaf800ecb0000, ffffaf800ecb0200)
The buggy address belongs to the page:
page:ffffaf807aa72180 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8eeb0
head:ffffaf807aa72180 order:2 compound_mapcount:0 compound_pincount:0
flags: 0x8800010200(slab|head|section=17|node=0|zone=0)
raw: 0000008800010200 0000000000000100 0000000000000122 ffffaf8007202dc0
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
raw: 00000000000007ff
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1985, ts 260391268800, free_ts 256018013500
 __set_page_owner+0x48/0x136 mm/page_owner.c:183
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0xd0/0x10a mm/page_alloc.c:2427
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0x8da/0x12d8 mm/page_alloc.c:4165
 __alloc_pages+0x150/0x3b6 mm/page_alloc.c:5389
 alloc_pages+0x132/0x2a6 mm/mempolicy.c:2271
 alloc_slab_page.constprop.0+0xc2/0xfa mm/slub.c:1799
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0x25a/0x2cc mm/slub.c:2004
 ___slab_alloc+0x56e/0x918 mm/slub.c:3018
 __slab_alloc.constprop.0+0x50/0x8c mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 __kmalloc_node_track_caller+0x26c/0x362 mm/slub.c:4957
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0xee/0x2e4 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1158 [inline]
 alloc_skb_with_frags+0x78/0x30c net/core/skbuff.c:5956
 sock_alloc_send_pskb+0x536/0x558 net/core/sock.c:2586
 unix_stream_sendmsg+0x472/0xbb8 net/unix/af_unix.c:2152
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg+0xa0/0xc4 net/socket.c:725
 sock_write_iter+0x1c0/0x272 net/socket.c:1061
page last free stack trace:
 __reset_page_owner+0x4a/0xea mm/page_owner.c:142
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x29c/0x45e mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x6a/0x31e mm/page_alloc.c:3404
 free_the_page mm/page_alloc.c:706 [inline]
 __free_pages+0xe2/0x112 mm/page_alloc.c:5474
 free_thread_stack kernel/fork.c:297 [inline]
 release_task_stack kernel/fork.c:434 [inline]
 put_task_stack+0x1d0/0x2b0 kernel/fork.c:445
 finish_task_switch.isra.0+0x3ce/0x420 kernel/sched/core.c:4898
 context_switch kernel/sched/core.c:4989 [inline]
 __schedule+0x58e/0x118e kernel/sched/core.c:6296
 preempt_schedule_common+0x4e/0xde kernel/sched/core.c:6462
 preempt_schedule+0x34/0x36 kernel/sched/core.c:6487
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x8c/0x98 kernel/locking/spinlock.c:194
 debug_object_active_state lib/debugobjects.c:945 [inline]
 debug_object_active_state+0x1ea/0x1f4 lib/debugobjects.c:914
 debug_rcu_head_queue kernel/rcu/rcu.h:177 [inline]
 __call_rcu kernel/rcu/tree.c:3010 [inline]
 call_rcu+0x54/0x4ce kernel/rcu/tree.c:3106
 destroy_inode+0xa4/0xda fs/inode.c:315
 evict+0x2ca/0x344 fs/inode.c:679
 iput_final fs/inode.c:1744 [inline]
 iput fs/inode.c:1770 [inline]
 iput+0x410/0x61c fs/inode.c:1756
 proc_invalidate_siblings_dcache+0x288/0x5ba fs/proc/inode.c:160

Memory state around the buggy address:
 ffffaf800ecb0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffffaf800ecb0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffffaf800ecb0100: fb fb 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                         ^
 ffffaf800ecb0180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffaf800ecb0200: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
cgroup: Unknown subsys name 'rlimit'


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
