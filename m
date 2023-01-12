Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70674666F3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 11:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbjALKPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 05:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbjALKOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:14:49 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01014D21
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 02:13:41 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l14-20020a056e02066e00b0030bff7a1841so13226844ilt.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 02:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLjm2ayRIxurrqVs1ufYqwPJYfqzfet16BX+SArwhO8=;
        b=aBrDCtWvQJS+G1M3DLmusuQREv3npDKGeUDh1IqseAA/TGv3fc8kLjtme1yfpjwoq8
         xw5WT+QP0O5/CkRv9L2Nk4cRUC7QPKoYL9Hx2fvau7gD081na6elYU3CDUTJMioeVhiJ
         b/pBWLACZ8vL2T3Q8UhluFwb7B0Fe0GcmeggUG+daL2oBCnQnjYi7176btravrXPb90p
         ViaqfeDU6tFfgcp1i7omEKgIbg+hntaVAtAfES3Ik7FFICMptwF6343HXQ+qFW32yTMZ
         4SIacEmD4/Vd0DjR8FgognR7peOOZSZYckVDOPcHTMColvM9b/OAdzZB8ujAOm8ceR7I
         +aVQ==
X-Gm-Message-State: AFqh2kr2/RwF5vw/ERqANeOXRu/q0ICCikEXzIAhTnYw2TkGV53MNKfI
        TJ1h9y5/HgorA+ni2o5kL5kUvZJBgAeCNQ9HBZ0agGdz2U27
X-Google-Smtp-Source: AMrXdXs+NQm/91BIGaCVpgJkDHnCgJVI7qTGrxn1Zh7J3yF+1w6AfyLw5WiKF7iz+Sq6kwOIi3TV6C1W5VfuEKYfTKxIVOAy0Bjf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1294:b0:30d:c258:ac1d with SMTP id
 y20-20020a056e02129400b0030dc258ac1dmr654825ilq.79.1673518420392; Thu, 12 Jan
 2023 02:13:40 -0800 (PST)
Date:   Thu, 12 Jan 2023 02:13:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f904fc05f20e5eb9@google.com>
Subject: [syzbot] [vfs?] KASAN: use-after-free Write in pipe_poll
From:   syzbot <syzbot+dcfe8e1b5dfc52d34d0d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=134c4d16480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=dcfe8e1b5dfc52d34d0d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcfe8e1b5dfc52d34d0d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in pipe_poll+0x64d/0x7d0 fs/pipe.c:656
Write of size 1 at addr ffff8880231edd5c by task syz-executor.1/11063

CPU: 0 PID: 11063 Comm: syz-executor.1 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 pipe_poll+0x64d/0x7d0 fs/pipe.c:656
 vfs_poll include/linux/poll.h:88 [inline]
 io_poll_check_events io_uring/poll.c:279 [inline]
 io_poll_task_func+0x3a6/0x1220 io_uring/poll.c:327
 handle_tw_list+0xa8/0x460 io_uring/io_uring.c:1169
 tctx_task_work+0x12e/0x530 io_uring/io_uring.c:1224
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x24f0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc34b68c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc34c41c218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fc34b7abf88 RCX: 00007fc34b68c0c9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fc34b7abf88
RBP: 00007fc34b7abf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc34b7abf8c
R13: 00007ffe7e36d89f R14: 00007fc34c41c300 R15: 0000000000022000
 </TASK>

Allocated by task 11063:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 alloc_pipe_info+0x10e/0x590 fs/pipe.c:790
 get_pipe_inode fs/pipe.c:881 [inline]
 create_pipe_files+0x93/0x8d0 fs/pipe.c:913
 __do_pipe_flags fs/pipe.c:962 [inline]
 do_pipe2+0x96/0x1b0 fs/pipe.c:1010
 __do_sys_pipe fs/pipe.c:1033 [inline]
 __se_sys_pipe fs/pipe.c:1031 [inline]
 __x64_sys_pipe+0x33/0x40 fs/pipe.c:1031
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 11062:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 put_pipe_info fs/pipe.c:711 [inline]
 pipe_release+0x2ba/0x310 fs/pipe.c:734
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880231edc00
 which belongs to the cache kmalloc-cg-512 of size 512
The buggy address is located 348 bytes inside of
 512-byte region [ffff8880231edc00, ffff8880231ede00)

The buggy address belongs to the physical page:
page:ffffea00008c7b00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x231ec
head:ffffea00008c7b00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880285b5901
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff88801244f140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff ffff8880285b5901
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 10953, tgid 10950 (syz-executor.2), ts 766638397032, free_ts 762478646412
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2281
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x330 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node_track_caller+0x4b/0xc0 mm/slab_common.c:987
 kmalloc_reserve net/core/skbuff.c:490 [inline]
 __alloc_skb+0xe9/0x310 net/core/skbuff.c:563
 alloc_skb include/linux/skbuff.h:1270 [inline]
 alloc_skb_with_frags+0x97/0x6c0 net/core/skbuff.c:6193
 sock_alloc_send_pskb+0x7a7/0x930 net/core/sock.c:2741
 unix_dgram_sendmsg+0x419/0x1c30 net/unix/af_unix.c:1943
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xd3/0x120 net/socket.c:734
 ____sys_sendmsg+0x334/0x8c0 net/socket.c:2476
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2530
 __sys_sendmmsg+0x18f/0x460 net/socket.c:2616
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2637
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x17c/0x330 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0x4d/0xd0 mm/slab_common.c:974
 kmalloc_array_node include/linux/slab.h:697 [inline]
 kcalloc_node include/linux/slab.h:702 [inline]
 memcg_alloc_slab_cgroups+0x8f/0x150 mm/memcontrol.c:2899
 memcg_slab_post_alloc_hook+0xa9/0x390 mm/slab.h:546
 slab_post_alloc_hook mm/slab.h:777 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 kmem_cache_alloc_node+0x1b3/0x350 mm/slub.c:3497
 __alloc_skb+0x216/0x310 net/core/skbuff.c:550
 alloc_skb include/linux/skbuff.h:1270 [inline]
 alloc_skb_with_frags+0x97/0x6c0 net/core/skbuff.c:6193
 sock_alloc_send_pskb+0x7a7/0x930 net/core/sock.c:2741
 unix_dgram_sendmsg+0x419/0x1c30 net/unix/af_unix.c:1943
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xd3/0x120 net/socket.c:734

Memory state around the buggy address:
 ffff8880231edc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880231edc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880231edd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff8880231edd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880231ede00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
