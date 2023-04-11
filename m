Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62FA6DD2D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjDKGb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDKGb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:31:56 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D0D30EB
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:31:52 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id bk27-20020a056602401b00b0074c9dc19e16so4905300iob.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681194712; x=1683786712;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIDMq7gAMr0eNC8voL1b4WSvo9hgYUmQf2j4thfq1d8=;
        b=MwVv3x/926UjD5bn7cAvu80yOVYReX4bEb8nIG7XMQK/aEp+8NqNesqvt8Y0Uq1TXY
         QAb7zOJwOhia2BOroK5idmliqY74+565081QM4aNGao7tbWZL+PwV7MY7NYxntvlg6zU
         EtCHPWS5NMW+0y2J3bw4kCajXYUDNJ55GkS6LnOZHJiG5qJq0PLjQk4UQM+Ax02GOVHG
         XzxcANhd5zLy0q8VIflAAQfC3bBSAUox6ehx6LcKAoGvU1u9K+ncc07Rvvmp6aMYwqez
         Tc8vq81UchQ5vOkF/S4bCqAYXOMEhh/lpOiIJZo7romx1B69YJ8nA4ZMWmBCSIcjIRSm
         rWHQ==
X-Gm-Message-State: AAQBX9eVn+7w2iBjaZ5O8Q1UqOs4ScF1hCPZKd3bOMtPzHUqJ+XE3Uyy
        hEvfB77UK420dhds+h/rVFIMLSfVJaSnVA49cMu5vesDm3RJxPkddA==
X-Google-Smtp-Source: AKy350bqbrZUfe5zfEIm4bqVzMiCEySxyFKo0rNTDkmrFnsTjcUZt0hZw/hTAbn59K8zJ+v1bXIkt+IeJGGBBWEv3j8KYA3tEX2g
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11a8:b0:326:34d7:5d68 with SMTP id
 8-20020a056e0211a800b0032634d75d68mr7220568ilj.4.1681194712210; Mon, 10 Apr
 2023 23:31:52 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:31:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ea81a05f909a529@google.com>
Subject: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in squashfs_readahead
From:   syzbot <syzbot+757bfe88d4b4f229c573@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    99ddf2254feb Merge tag 'trace-v6.3-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b015fdc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5666fa6aca264e42
dashboard link: https://syzkaller.appspot.com/bug?extid=757bfe88d4b4f229c573
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/907a43450c5c/disk-99ddf225.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a142637e5396/vmlinux-99ddf225.xz
kernel image: https://storage.googleapis.com/syzbot-assets/447736ad6200/bzImage-99ddf225.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+757bfe88d4b4f229c573@syzkaller.appspotmail.com

SQUASHFS error: Unable to read metadata cache entry [736]
==================================================================
BUG: KASAN: slab-out-of-bounds in __readahead_batch include/linux/pagemap.h:1312 [inline]
BUG: KASAN: slab-out-of-bounds in squashfs_readahead+0x988/0x20c0 fs/squashfs/file.c:569
Write of size 8 at addr ffff888077326a58 by task syz-executor.3/19202

CPU: 1 PID: 19202 Comm: syz-executor.3 Not tainted 6.3.0-rc5-syzkaller-00032-g99ddf2254feb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 __readahead_batch include/linux/pagemap.h:1312 [inline]
 squashfs_readahead+0x988/0x20c0 fs/squashfs/file.c:569
 read_pages+0x183/0x830 mm/readahead.c:161
 page_cache_ra_unbounded+0x697/0x7c0 mm/readahead.c:270
 page_cache_sync_readahead include/linux/pagemap.h:1214 [inline]
 filemap_get_pages+0x49c/0x20c0 mm/filemap.c:2598
 filemap_read+0x45a/0x1170 mm/filemap.c:2693
 __kernel_read+0x422/0x8a0 fs/read_write.c:428
 integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0xa5b/0x1c00 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x3a7/0x880 security/integrity/ima/ima_api.c:293
 process_measurement+0xfdb/0x1ce0 security/integrity/ima/ima_main.c:341
 ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:539
 do_open fs/namei.c:3562 [inline]
 path_openat+0x280a/0x3170 fs/namei.c:3715
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_open fs/open.c:1372 [inline]
 __se_sys_open fs/open.c:1368 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1368
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc04c48c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc04d2cf168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fc04c5abf80 RCX: 00007fc04c48c169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007fc04c4e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff96016ccf R14: 00007fc04d2cf300 R15: 0000000000022000
 </TASK>

Allocated by task 19202:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:980
 kmalloc_array include/linux/slab.h:636 [inline]
 squashfs_readahead+0x30f/0x20c0 fs/squashfs/file.c:552
 read_pages+0x183/0x830 mm/readahead.c:161
 page_cache_ra_unbounded+0x697/0x7c0 mm/readahead.c:270
 page_cache_sync_readahead include/linux/pagemap.h:1214 [inline]
 filemap_get_pages+0x49c/0x20c0 mm/filemap.c:2598
 filemap_read+0x45a/0x1170 mm/filemap.c:2693
 __kernel_read+0x422/0x8a0 fs/read_write.c:428
 integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0xa5b/0x1c00 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x3a7/0x880 security/integrity/ima/ima_api.c:293
 process_measurement+0xfdb/0x1ce0 security/integrity/ima/ima_main.c:341
 ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:539
 do_open fs/namei.c:3562 [inline]
 path_openat+0x280a/0x3170 fs/namei.c:3715
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_open fs/open.c:1372 [inline]
 __se_sys_open fs/open.c:1368 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1368
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888077326a50
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 8-byte region [ffff888077326a50, ffff888077326a58)

The buggy address belongs to the physical page:
page:ffffea0001dcc980 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77326
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888012441280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5104, tgid 5104 (syz-executor.3), ts 464019978331, free_ts 464019896524
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x3246/0x33c0 mm/page_alloc.c:4326
 __alloc_pages+0x255/0x670 mm/page_alloc.c:5592
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0xa7/0x230 mm/slab_common.c:974
 kmalloc_node include/linux/slab.h:610 [inline]
 __vmalloc_area_node mm/vmalloc.c:3015 [inline]
 __vmalloc_node_range+0x5f9/0x13f0 mm/vmalloc.c:3199
 __vmalloc_node mm/vmalloc.c:3264 [inline]
 vzalloc+0x79/0x90 mm/vmalloc.c:3337
 alloc_counters+0xd7/0x760 net/ipv4/netfilter/ip_tables.c:801
 copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:839 [inline]
 get_entries net/ipv6/netfilter/ip6_tables.c:1041 [inline]
 do_ip6t_get_ctl+0xec4/0x18d0 net/ipv6/netfilter/ip6_tables.c:1671
 nf_getsockopt+0x292/0x2c0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x25d/0x380 net/ipv6/ipv6_sockglue.c:1499
 tcp_getsockopt+0x160/0x1c0 net/ipv4/tcp.c:4409
 __sys_getsockopt+0x2b6/0x5e0 net/socket.c:2315
 __do_sys_getsockopt net/socket.c:2330 [inline]
 __se_sys_getsockopt net/socket.c:2327 [inline]
 __x64_sys_getsockopt+0xb5/0xd0 net/socket.c:2327
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare mm/page_alloc.c:1504 [inline]
 free_unref_page_prepare+0xe2f/0xe70 mm/page_alloc.c:3388
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:3483
 vfree+0x186/0x2e0 mm/vmalloc.c:2742
 copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:884 [inline]
 get_entries net/ipv6/netfilter/ip6_tables.c:1041 [inline]
 do_ip6t_get_ctl+0x11f7/0x18d0 net/ipv6/netfilter/ip6_tables.c:1671
 nf_getsockopt+0x292/0x2c0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x25d/0x380 net/ipv6/ipv6_sockglue.c:1499
 tcp_getsockopt+0x160/0x1c0 net/ipv4/tcp.c:4409
 __sys_getsockopt+0x2b6/0x5e0 net/socket.c:2315
 __do_sys_getsockopt net/socket.c:2330 [inline]
 __se_sys_getsockopt net/socket.c:2327 [inline]
 __x64_sys_getsockopt+0xb5/0xd0 net/socket.c:2327
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888077326900: fc fc fa fc fc fc fc fa fc fc fc fc fa fc fc fc
 ffff888077326980: fc fa fc fc fc fc fa fc fc fc fc fa fc fc fc fc
>ffff888077326a00: fa fc fc fc fc fa fc fc fc fc 00 fc fc fc fc fa
                                                    ^
 ffff888077326a80: fc fc fc fc fa fc fc fc fc fa fc fc fc fc 00 fc
 ffff888077326b00: fc fc fc fb fc fc fc fc fa fc fc fc fc fa fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
