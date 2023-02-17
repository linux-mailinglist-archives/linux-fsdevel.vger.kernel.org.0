Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0001469AF45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 16:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjBQPPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 10:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBQPPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:15:48 -0500
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D386F6666B
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 07:15:45 -0800 (PST)
Received: by mail-il1-f208.google.com with SMTP id p3-20020a92d683000000b003006328df7bso315400iln.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 07:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOF1NJR2C6VQIkmOaGm3OZ/hC3PZmxuYb581posA0pY=;
        b=abbl8rlwS1FjD9SR341s2+fpS4tUIVUBL9rAy3HHadlKY2jUB7N9fj5vKwXXy/S+cR
         vy/ZUVtTGgPKpqTyv05l6/Nn8un8XVJUIyo/kEP15ROp0BxJlECT0fEepQILRdZi1TAi
         5o9LpqM+gVOA5aOmedOgHWwJCE4kDlCSmVRDsAtHHeYzdDKYST7j9/e6A2GrMY8WpnId
         UKaxLjpoYcwq73AYc5JtG1U463356GewiSjPP9uwAgsFKvk4Iof4T/f0SSdhKJIcQAI1
         UHQrK3NeLlbvek6KBmsC824rXklowh1h5zJiNn1yhsbAPuHjBtcJbKDRLZxPsRFwkgvo
         /IPw==
X-Gm-Message-State: AO0yUKVO9KP1QzidR4wUZ3UcU7APRny4LVD6tcqwjsscevuu7I/udg2v
        K8yz9+6JxGdycVCdJMaipKb0LV4LLVvHTXMPgy7mNWHpcFxe
X-Google-Smtp-Source: AK7set8vsPE+Lbo+ybYE5fGk6chIL2Evqt2sM77c+hW8E0qS33wbuY+st4OMVHbpzwSWn8xFvemqmLAgLWD51yswvGsRCjkphFIo
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1050:b0:314:8c8:de65 with SMTP id
 p16-20020a056e02105000b0031408c8de65mr391899ilj.3.1676646945161; Fri, 17 Feb
 2023 07:15:45 -0800 (PST)
Date:   Fri, 17 Feb 2023 07:15:45 -0800
In-Reply-To: <000000000000471f2d05f1ce8bad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009489a105f4e6c9e6@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: invalid-free in dbUnmount
From:   syzbot <syzbot+6a93efb725385bc4b2e9@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, paskripkin@gmail.com, r33s3n6@gmail.com,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com,
        wuhoipok@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ec35307e18ba Merge tag 'drm-fixes-2023-02-17' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136bc2f0c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4b0f5dd9aee9645
dashboard link: https://syzkaller.appspot.com/bug?extid=6a93efb725385bc4b2e9
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16782d80c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5680df3ffb85/disk-ec35307e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6bdf250f8996/vmlinux-ec35307e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5855b843bfdd/bzImage-ec35307e.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/7c16d31db3c2/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/7cb46f599e58/mount_5.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a93efb725385bc4b2e9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in dbUnmount+0xf8/0x110 fs/jfs/jfs_dmap.c:264
Free of addr ffff888070065000 by task syz-executor.2/5106

CPU: 0 PID: 5106 Comm: syz-executor.2 Not tainted 6.2.0-rc8-syzkaller-00098-gec35307e18ba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x163/0x4f0 mm/kasan/report.c:417
 kasan_report_invalid_free+0x110/0x130 mm/kasan/report.c:482
 ____kasan_slab_free+0xfb/0x120
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0x264/0x3c0 mm/slub.c:3800
 dbUnmount+0xf8/0x110 fs/jfs/jfs_dmap.c:264
 jfs_umount+0x238/0x3a0 fs/jfs/jfs_umount.c:87
 jfs_put_super+0x8a/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x134/0x310 fs/super.c:492
 kill_block_super+0x7e/0xe0 fs/super.c:1386
 deactivate_locked_super+0xa4/0x110 fs/super.c:332
 cleanup_mnt+0x490/0x520 fs/namespace.c:1291
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x2e0 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2586c8d567
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc1f3b418 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f2586c8d567
RDX: 00007ffcc1f3b4ea RSI: 000000000000000a RDI: 00007ffcc1f3b4e0
RBP: 00007ffcc1f3b4e0 R08: 00000000ffffffff R09: 00007ffcc1f3b2b0
R10: 00005555571d08b3 R11: 0000000000000246 R12: 00007f2586ce6b24
R13: 00007ffcc1f3c5a0 R14: 00005555571d0810 R15: 00007ffcc1f3c5e0
 </TASK>

Allocated by task 6074:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x80 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x9b/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:580 [inline]
 dbMount+0x58/0x9a0 fs/jfs/jfs_dmap.c:164
 jfs_mount+0x1e5/0x830 fs/jfs/jfs_mount.c:121
 jfs_fill_super+0x59c/0xc50 fs/jfs/super.c:556
 mount_bdev+0x271/0x3a0 fs/super.c:1359
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1489
 do_new_mount+0x28f/0xae0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 6095:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x80 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:523
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0x264/0x3c0 mm/slub.c:3800
 dbUnmount+0xf8/0x110 fs/jfs/jfs_dmap.c:264
 jfs_mount_rw+0x4ac/0x6a0 fs/jfs/jfs_mount.c:247
 jfs_remount+0x3d1/0x6b0 fs/jfs/super.c:454
 reconfigure_super+0x3c9/0x7c0 fs/super.c:935
 vfs_fsconfig_locked fs/fsopen.c:254 [inline]
 __do_sys_fsconfig fs/fsopen.c:439 [inline]
 __se_sys_fsconfig+0xa29/0xf70 fs/fsopen.c:314
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888070065000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 0 bytes inside of
 2048-byte region [ffff888070065000, ffff888070065800)

The buggy address belongs to the physical page:
page:ffffea0001c01800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x70060
head:ffffea0001c01800 order:3 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012442000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5107, tgid 5107 (syz-executor.4), ts 445079557996, free_ts 18734675106
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x3449/0x35c0 mm/page_alloc.c:4283
 __alloc_pages+0x291/0x7e0 mm/page_alloc.c:5549
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x1b8/0x2a0 mm/slub.c:3491
 kmalloc_trace+0x2a/0x60 mm/slab_common.c:1062
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 nsim_fib_create+0xa8/0xbb0 drivers/net/netdevsim/fib.c:1558
 nsim_drv_probe+0x6ed/0xb30 drivers/net/netdevsim/dev.c:1581
 really_probe+0x2ab/0xcd0 drivers/base/dd.c:639
 __driver_probe_device+0x1c3/0x3f0 drivers/base/dd.c:778
 driver_probe_device+0x50/0x420 drivers/base/dd.c:808
 __device_attach_driver+0x2d3/0x520 drivers/base/dd.c:936
 bus_for_each_drv+0x187/0x210 drivers/base/bus.c:427
 __device_attach+0x35d/0x580 drivers/base/dd.c:1008
 bus_probe_device+0xbe/0x1e0 drivers/base/bus.c:487
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare mm/page_alloc.c:1496 [inline]
 free_unref_page_prepare+0xf3a/0x1040 mm/page_alloc.c:3369
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:3464
 free_contig_range+0x9e/0x150 mm/page_alloc.c:9488
 destroy_args+0x102/0x9a0 mm/debug_vm_pgtable.c:998
 debug_vm_pgtable+0x40a/0x470 mm/debug_vm_pgtable.c:1318
 do_one_initcall+0x2c3/0xa60 init/main.c:1306
 do_initcall_level+0x157/0x210 init/main.c:1379
 do_initcalls+0x3f/0x80 init/main.c:1395
 kernel_init_freeable+0x477/0x630 init/main.c:1634
 kernel_init+0x1d/0x2a0 init/main.c:1522
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888070064f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888070064f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888070065000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888070065080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888070065100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

