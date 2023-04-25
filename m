Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1A86EDD16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 09:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjDYHrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 03:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjDYHrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:47:12 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C78610FD
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 00:46:57 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-760d7046e89so866870239f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 00:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682408816; x=1685000816;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZdCUGrRun/DZ+2J4z4VcT5oplJgWlvLJJV6thDj4ZQ=;
        b=cThtkalet7JtSnNfX1O25qcEwMO2LerkHmJm9tiEEjX9aWm/PWmPuNBdeLwuQo19MS
         OS9IiezbeLdcMpuCvMaLZik27cEcCYdy3LqXOj9m0hsivReJIhVDxIeBRC6yZRITDu9s
         AZhl4KsvtAeJdqq5/xSTUA3NtUFMPTF4tjQ0yEJ0jxWwbboHXNmz8/6UDM5Ravvc4JzX
         aOXdYds8SOpLPrd6ky2u7vL8bSRlGqQgZ14CnxtQbXjQIH/ar0GNr3LBFsXH1DeIHnYb
         ORuoc1s61i8Rv2Lf/KqQA/oqMXsc9/7ewSwM5W94+bSVB5bmH+BhAICpWizAZX9dP4Lx
         YkhA==
X-Gm-Message-State: AAQBX9da6D+H24986N88xmEEUID/0mz+mr7mxJOctEYWZ4Y72vpFk89R
        9XZEW4jMBNouapkSM6G/qWTGuuMukrNW6wkJvskygHGgP872
X-Google-Smtp-Source: AKy350a7vloebQrPnbVgpG8TDDz0/mgsWyNkfmQoUBwOjSpqMJ78CtWLPPXfDLSSZoYw0kwq92sxHnOPmDaxAGNHrW8PFeaN2Yr+
MIME-Version: 1.0
X-Received: by 2002:a5e:8c09:0:b0:759:25eb:210d with SMTP id
 n9-20020a5e8c09000000b0075925eb210dmr6188165ioj.0.1682408816712; Tue, 25 Apr
 2023 00:46:56 -0700 (PDT)
Date:   Tue, 25 Apr 2023 00:46:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3230805fa24537d@google.com>
Subject: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in kernfs_xattr_get
From:   syzbot <syzbot+1b11da2ef24dccc2e98d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1a0beef98b58 Merge tag 'tpmdd-v6.4-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12df26a4280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fff005cbc6ca177e
dashboard link: https://syzkaller.appspot.com/bug?extid=1b11da2ef24dccc2e98d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b11da2ef24dccc2e98d@syzkaller.appspotmail.com

usb 5-1: Direct firmware load for ueagle-atm/eagleI.fw failed with error -2
usb 5-1: Falling back to sysfs fallback for: ueagle-atm/eagleI.fw
==================================================================
BUG: KASAN: slab-use-after-free in __kernfs_iattrs fs/kernfs/inode.c:34 [inline]
BUG: KASAN: slab-use-after-free in kernfs_iattrs_noalloc fs/kernfs/inode.c:65 [inline]
BUG: KASAN: slab-use-after-free in kernfs_xattr_get+0x95/0xa0 fs/kernfs/inode.c:299
Read of size 8 at addr ffff888024b44398 by task kworker/2:1/4863

CPU: 2 PID: 4863 Comm: kworker/2:1 Not tainted 6.3.0-syzkaller-00113-g1a0beef98b58 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 __kernfs_iattrs fs/kernfs/inode.c:34 [inline]
 kernfs_iattrs_noalloc fs/kernfs/inode.c:65 [inline]
 kernfs_xattr_get+0x95/0xa0 fs/kernfs/inode.c:299
 selinux_kernfs_init_security+0xfe/0x4c0 security/selinux/hooks.c:3473
 security_kernfs_init_security+0x4c/0xa0 security/security.c:2520
 __kernfs_new_node+0x54f/0x8b0 fs/kernfs/dir.c:650
 kernfs_new_node fs/kernfs/dir.c:673 [inline]
 kernfs_create_dir_ns+0xa0/0x230 fs/kernfs/dir.c:1029
 sysfs_create_dir_ns+0x12b/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2c9/0x9c0 lib/kobject.c:231
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x154/0x230 lib/kobject.c:418
 class_dir_create_and_add drivers/base/core.c:3121 [inline]
 get_device_parent+0x3d7/0x590 drivers/base/core.c:3177
 device_add+0x2b4/0x1c50 drivers/base/core.c:3513
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:82 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:158 [inline]
 firmware_fallback_sysfs+0x2d9/0xc10 drivers/base/firmware_loader/fallback.c:234
 _request_firmware+0xbe4/0x11f0 drivers/base/firmware_loader/main.c:856
 request_firmware_work_func+0xe1/0x240 drivers/base/firmware_loader/main.c:1105
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 32492:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slab.c:3257 [inline]
 slab_alloc mm/slab.c:3266 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3443 [inline]
 kmem_cache_alloc+0x1bd/0x3f0 mm/slab.c:3452
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:611
 kernfs_new_node fs/kernfs/dir.c:673 [inline]
 kernfs_create_dir_ns+0xa0/0x230 fs/kernfs/dir.c:1029
 sysfs_create_dir_ns+0x12b/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2c9/0x9c0 lib/kobject.c:231
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_add+0x154/0x230 lib/kobject.c:418
 device_add+0x37d/0x1c50 drivers/base/core.c:3527
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2575
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 process_scheduled_works kernel/workqueue.c:2453 [inline]
 worker_thread+0x858/0x1090 kernel/workqueue.c:2539
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Freed by task 32492:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 __cache_free mm/slab.c:3390 [inline]
 __do_kmem_cache_free mm/slab.c:3577 [inline]
 kmem_cache_free mm/slab.c:3602 [inline]
 kmem_cache_free+0x105/0x370 mm/slab.c:3595
 kernfs_put.part.0+0x228/0x470 fs/kernfs/dir.c:565
 kernfs_put+0x46/0x50 fs/kernfs/dir.c:539
 sysfs_put include/linux/sysfs.h:657 [inline]
 __kobject_del+0xea/0x1f0 lib/kobject.c:597
 kobject_del lib/kobject.c:619 [inline]
 kobject_del+0x40/0x60 lib/kobject.c:611
 device_del+0x753/0xb80 drivers/base/core.c:3784
 usb_disconnect+0x51e/0x8a0 drivers/usb/core/hub.c:2264
 hub_port_connect drivers/usb/core/hub.c:5246 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x1fbf/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 process_scheduled_works kernel/workqueue.c:2453 [inline]
 worker_thread+0x858/0x1090 kernel/workqueue.c:2539
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888024b442f8
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 160 bytes inside of
 freed 168-byte region [ffff888024b442f8, ffff888024b443a0)

The buggy address belongs to the physical page:
page:ffffea000092d100 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x24b44
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888013e06500 ffffea0000955450 ffffea00008fbcd0
raw: 0000000000000000 ffff888024b44040 0000000100000011 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 9114, tgid 9112 (syz-executor.0), ts 2172882098243, free_ts 1945755322860
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
 __do_cache_alloc mm/slab.c:3202 [inline]
 slab_alloc_node mm/slab.c:3250 [inline]
 slab_alloc mm/slab.c:3266 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3443 [inline]
 kmem_cache_alloc+0x397/0x3f0 mm/slab.c:3452
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:611
 kernfs_new_node fs/kernfs/dir.c:673 [inline]
 kernfs_create_dir_ns+0xa0/0x230 fs/kernfs/dir.c:1029
 sysfs_create_dir_ns+0x12b/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2c9/0x9c0 lib/kobject.c:231
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_init_and_add+0x101/0x170 lib/kobject.c:449
 bus_add_driver+0x186/0x640 drivers/base/bus.c:666
 driver_register+0x162/0x4a0 drivers/base/driver.c:246
 usb_gadget_register_driver_owner+0xff/0x2b0 drivers/usb/gadget/udc/core.c:1560
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:546 [inline]
 raw_ioctl+0x18e9/0x2a60 drivers/usb/gadget/legacy/raw_gadget.c:1253
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
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
 slab_alloc mm/slab.c:3266 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3443 [inline]
 kmem_cache_alloc+0x1bd/0x3f0 mm/slab.c:3452
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags include/linux/audit.h:321 [inline]
 getname fs/namei.c:219 [inline]
 __do_sys_unlink fs/namei.c:4364 [inline]
 __se_sys_unlink fs/namei.c:4362 [inline]
 __x64_sys_unlink+0xb5/0x110 fs/namei.c:4362
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888024b44280: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fa
 ffff888024b44300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888024b44380: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
                            ^
 ffff888024b44400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024b44480: fb fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
