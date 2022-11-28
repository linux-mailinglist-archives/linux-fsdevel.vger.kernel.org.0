Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3163A594
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 11:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiK1KCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 05:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiK1KCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:02:37 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A882F4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 02:02:35 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id y12-20020a056e021bec00b00302a7d5bc83so8441899ilv.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 02:02:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuMDQXrQJI5bLgNlAUFHn9AbPdwrhvP4abr+9RSvNgI=;
        b=ISOUJXv4I3ihb/VbzE6GisLnpy8yexE74u7ekKzbM2XHueBUt/E0khzokoJxZMaMBg
         +ECmsKH7gfJfyv0mVD3SczmFCYoD5afSwRFJTMvFF0QT/tFULht5mAcyyX9v2QfNVvCO
         YK/zoN9siJQrY8OA7pHaBacjR6ZDhbF4ETLYaUCYZ8dqJ1zzUh/82K1y4jhviit58oVP
         R1BJRjUwVd/qP/lC7lqslQNgSmd7q5Fp7UAWcAQLYvgu0NbLRvcdB4VeykcMWulPQKa+
         A3Aq+FLKwF8RPNHBLUl3hwyL46nXSD6KtB3Z8wRQ6ujAjaBrLPbnrWcPuO+OVHIpL3bL
         tXOw==
X-Gm-Message-State: ANoB5pkzmITlL19Yx0/8AvG8m0LwRlx9krmCBiN/4FW8GKVkucwyfw52
        yIxi8Vz01ueVcpK6AGfO4WkM/KQzFOi9wjpXPkc1zch/eWMv
X-Google-Smtp-Source: AA0mqf5F/tQKQSiBuKboe8SFjrnGJ513EySs0veclV8Yogbsoe5JcSrUEfJd3sIeD8wIi1dU0w66xBCTg8WkwTRr13QPN7aRSwwT
MIME-Version: 1.0
X-Received: by 2002:a05:6638:11d4:b0:389:ce3c:4ca5 with SMTP id
 g20-20020a05663811d400b00389ce3c4ca5mr4857781jas.308.1669629754780; Mon, 28
 Nov 2022 02:02:34 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:02:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070b0b205ee84f87f@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
From:   syzbot <syzbot+076d963e115823c4b9be@syzkaller.appspotmail.com>
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

HEAD commit:    faf68e3523c2 Merge tag 'kbuild-fixes-v6.1-4' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14c2e5c3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10505e8d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137b71c3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bfa6577f378/disk-faf68e35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7bf0af58cde3/vmlinux-faf68e35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e15d7d640b0/bzImage-faf68e35.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ebef14156e65/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+076d963e115823c4b9be@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
==================================================================
BUG: KASAN: slab-out-of-bounds in hfsplus_uni2asc+0x683/0x1290 fs/hfsplus/unicode.c:179
Read of size 2 at addr ffff88801887a40c by task syz-executor412/3632

CPU: 1 PID: 3632 Comm: syz-executor412 Not tainted 6.1.0-rc6-syzkaller-00315-gfaf68e3523c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 hfsplus_uni2asc+0x683/0x1290 fs/hfsplus/unicode.c:179
 hfsplus_readdir+0x8be/0x1230 fs/hfsplus/dir.c:207
 iterate_dir+0x257/0x5f0
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64+0x1db/0x4c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc1946c8869
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9a1bc768 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 000000000000003f RCX: 00007fc1946c8869
RDX: 0000000000000061 RSI: 0000000020000340 RDI: 0000000000000004
RBP: 00007fc194688100 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc194688190
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
 hfsplus_find_init+0x80/0x1b0 fs/hfsplus/bfind.c:21
 hfsplus_readdir+0x1a5/0x1230 fs/hfsplus/dir.c:144
 iterate_dir+0x257/0x5f0
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64+0x1db/0x4c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801887a000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1036 bytes inside of
 2048-byte region [ffff88801887a000, ffff88801887a800)

The buggy address belongs to the physical page:
page:ffffea0000621e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x18878
head:ffffea0000621e00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888012842000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 2305445820, free_ts 0
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_page_interleave+0x22/0x1c0 mm/mempolicy.c:2118
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1045
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 acpi_os_allocate_zeroed include/acpi/platform/aclinuxex.h:57 [inline]
 acpi_ds_create_walk_state+0xe2/0x292 drivers/acpi/acpica/dswstate.c:518
 acpi_ds_auto_serialize_method+0xe1/0x22c drivers/acpi/acpica/dsmethod.c:81
 acpi_ds_init_one_object+0x1a8/0x34f drivers/acpi/acpica/dsinit.c:110
 acpi_ns_walk_namespace+0x250/0x4bf
 acpi_ds_initialize_objects+0x149/0x23d drivers/acpi/acpica/dsinit.c:189
 acpi_ns_load_table+0xf4/0x118 drivers/acpi/acpica/nsload.c:106
 acpi_tb_load_namespace+0x283/0x6cc drivers/acpi/acpica/tbxfload.c:158
 acpi_load_tables+0x45/0xf5 drivers/acpi/acpica/tbxfload.c:59
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801887a300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801887a380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88801887a400: 00 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                      ^
 ffff88801887a480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801887a500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
