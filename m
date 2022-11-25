Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66170638683
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKYJrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 04:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKYJqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:46:42 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3788F3C6C9
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:45:42 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id z15-20020a5e860f000000b006c09237cc06so1845144ioj.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNmOgQUdnHf0FOrxseVFmnTKfBB1wBhht5m8M1r4Ei8=;
        b=dq8ow29IW0ZIeC4R4KWRPMMxtah+Zl7nt3oDCvetCWoCklanYsmJ9SEygJXHMF8N92
         VHyaQ+V1qwV9snlXJwEb3l58ViyzfdwfdPxsn1aGAq9WZmmVN2Fb89tv+9axvU7stvr9
         Uusd9ySiC50wtREXEsE05nF1LDwmqcAnFC0gd0cs46Cqofp69dVAaFi1ZT5thGC9FiQ4
         zoym3i5mpgRV4ul2udXROErwktIW7CHqKKmAhH6Gc2sB5H+jnr8GI88rdnPxtL4dyg9h
         DUlg9u4mrbnp5NEwmoLHeBwWnyq2twaALwPcUpLZRoaOmz/nDWPX2W2z+JHhHtPXb0l6
         IAww==
X-Gm-Message-State: ANoB5pmSlbP7StmRpveT5ouPzH21bKpfCT2jYQnnLtWiGl653yMSZZTY
        /ejWMUfmiaVCKDfnfOGlqIa1ZeLwrVyPm0Evr/LahcFhureV
X-Google-Smtp-Source: AA0mqf502lIFNy4s5sG3wHgBhsX5KJJ5ozRq1lUDw2kX+xrjH3pkFixYHATOhhnG2DnwLUJeo5TeGN5C+Gn6IAmh1FHKOzLL+TBY
MIME-Version: 1.0
X-Received: by 2002:a5d:971a:0:b0:6d5:2f6e:834 with SMTP id
 h26-20020a5d971a000000b006d52f6e0834mr16781691iol.181.1669369541601; Fri, 25
 Nov 2022 01:45:41 -0800 (PST)
Date:   Fri, 25 Nov 2022 01:45:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086b19705ee486240@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Write in hfs_asc2mac
From:   syzbot <syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com>
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

HEAD commit:    4312098baf37 Merge tag 'spi-fix-v6.1-rc6' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11fd0a73880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=dc3b1cf9111ab5fe98e7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e49a3d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a15a73880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7073d20a37/disk-4312098b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36a0367a5593/vmlinux-4312098b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/265bedb3086b/bzImage-4312098b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cf5f83add496/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
==================================================================
BUG: KASAN: slab-out-of-bounds in hfs_asc2mac+0x467/0x9a0 fs/hfs/trans.c:133
Write of size 1 at addr ffff88801848314e by task syz-executor391/3632

CPU: 0 PID: 3632 Comm: syz-executor391 Not tainted 6.1.0-rc6-syzkaller-00012-g4312098baf37 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 hfs_asc2mac+0x467/0x9a0 fs/hfs/trans.c:133
 hfs_cat_build_key+0x92/0x170 fs/hfs/catalog.c:28
 hfs_lookup+0x1ab/0x2c0 fs/hfs/dir.c:31
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3710
 do_filp_open+0x264/0x4f0 fs/namei.c:3740
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdc79c9d839
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd57f47648 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdc79c9d839
RDX: 0000000000000100 RSI: 0000000000002000 RDI: 0000000020000800
RBP: 00007fdc79c5d0d0 R08: 0000000000000245 R09: 0000000000000000
R10: 00007ffd57f47510 R11: 0000000000000246 R12: 00007fdc79c5d160
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 3632:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:955 [inline]
 __kmalloc+0xaf/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 hfs_find_init+0x8b/0x1e0 fs/hfs/bfind.c:21
 hfs_lookup+0x105/0x2c0 fs/hfs/dir.c:28
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3710
 do_filp_open+0x264/0x4f0 fs/namei.c:3740
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888018483100
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 78 bytes inside of
 96-byte region [ffff888018483100, ffff888018483160)

The buggy address belongs to the physical page:
page:ffffea00006120c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x18483
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888012841780
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 2311131230, free_ts 0
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4288
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5555
 alloc_page_interleave+0x22/0x1c0 mm/mempolicy.c:2118
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc_node_track_caller+0x9c/0x190 mm/slab_common.c:975
 __do_krealloc mm/slab_common.c:1348 [inline]
 krealloc+0x61/0xf0 mm/slab_common.c:1381
 add_sysfs_param+0x134/0x800 kernel/params.c:660
 kernel_add_sysfs_param+0xb0/0x126 kernel/params.c:812
 param_sysfs_builtin+0x1fb/0x2a5 kernel/params.c:851
 param_sysfs_init+0x68/0x6c kernel/params.c:970
 do_one_initcall+0x1c9/0x400 init/main.c:1303
 do_initcall_level+0x168/0x218 init/main.c:1376
 do_initcalls+0x4b/0x8c init/main.c:1392
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888018483000: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888018483080: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
>ffff888018483100: 00 00 00 00 00 00 00 00 00 06 fc fc fc fc fc fc
                                              ^
 ffff888018483180: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff888018483200: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
