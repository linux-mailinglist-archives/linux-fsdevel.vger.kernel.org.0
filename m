Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC608400B39
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Sep 2021 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhIDL62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Sep 2021 07:58:28 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56908 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbhIDL62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Sep 2021 07:58:28 -0400
Received: by mail-il1-f197.google.com with SMTP id v9-20020a92c6c9000000b00226d10082a6so1134985ilm.23
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Sep 2021 04:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mVw9JDyATIuAC54DQacSwmFjeXq6JmM1c62KNszdhhc=;
        b=ZU3+keV1wokrl7O3keDMOj84SXw6Sq0TW0H4JME6nsAnGzTmg/tIQLV+TbJtbb2wj1
         WKDFrZ6RsTa/xbsdpJ9ZVcnKYoUiaR3gzz9XI/56WVBLMPSN+EHf0bhbhO0VW+9Q3dio
         UIfLlA1fzbSCwpR6X9I/BqmYR1hGdfwMq0fW/6qmKV44wiMA5DXqcqZZwnMKWFTu2Zdn
         1t+gotYzO0RsrsflU6u90/m84UKbJJf7O1tHeAxPlwgCjn8R/DvvOMhASTi0EZ98fCUu
         +TguP2HEmfiuk8Bmap4276gvOKoFSDla20ljvDRT38hIxbpEqmu1Aakdg/17XwO2IP4e
         DSLQ==
X-Gm-Message-State: AOAM531eRlidauc+yBFKxNqsIemk6B16GK0jE4dW1OZ4/qwt96Ks28Rn
        E6EJdeDA5eeD2MgBEBRbXqzAOJdt427hbhVwpVLMOhXCaSIV
X-Google-Smtp-Source: ABdhPJz6RuNG1Aqat8FM5q2Ld6AcaL4UoZAwc1G9Kmn8MYDoHcv1bfhN3C52rU9sTipTBS2jK429kyYCo/A9L6U9e+rEHmPZmIaN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2728:: with SMTP id m40mr3000968jav.141.1630756646669;
 Sat, 04 Sep 2021 04:57:26 -0700 (PDT)
Date:   Sat, 04 Sep 2021 04:57:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3cf8605cb2a1ec0@google.com>
Subject: [syzbot] upstream test error: KASAN: invalid-access Read in __entry_tramp_text_end
From:   syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f1583cb1be35 Merge tag 'linux-kselftest-next-5.15-rc1' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16354043300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fe535c85e8d7384
dashboard link: https://syzkaller.appspot.com/bug?extid=488ddf8087564d6de6e2
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: arm64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: invalid-access in __entry_tramp_text_end+0xdfc/0x3000
Read at addr f4ff000002a361a0 by task kdevtmpfs/22
Pointer tag: [f4], memory tag: [fe]

CPU: 1 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-syzkaller-09284-gf1583cb1be35 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x1ac arch/arm64/kernel/stacktrace.c:76
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:215
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x68/0x84 lib/dump_stack.c:105
 print_address_description+0x7c/0x2b4 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report+0x134/0x380 mm/kasan/report.c:459
 __do_kernel_fault+0x128/0x1bc arch/arm64/mm/fault.c:317
 do_bad_area arch/arm64/mm/fault.c:466 [inline]
 do_tag_check_fault+0x74/0x90 arch/arm64/mm/fault.c:737
 do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
 el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
 el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
 __entry_tramp_text_end+0xdfc/0x3000
 d_lookup+0x44/0x70 fs/dcache.c:2370
 lookup_dcache+0x24/0x84 fs/namei.c:1520
 __lookup_hash+0x24/0xd0 fs/namei.c:1543
 kern_path_locked+0x90/0x10c fs/namei.c:2567
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756

Allocated by task 22:
 kasan_save_stack+0x28/0x60 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0xb0/0x110 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:2959 [inline]
 slab_alloc mm/slub.c:2967 [inline]
 kmem_cache_alloc+0x1cc/0x340 mm/slub.c:2972
 getname_kernel+0x30/0x150 fs/namei.c:226
 kern_path_locked+0x2c/0x10c fs/namei.c:2558
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756

Freed by task 22:
 kasan_save_stack+0x28/0x60 mm/kasan/common.c:38
 kasan_set_track+0x28/0x3c mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/tags.c:36
 ____kasan_slab_free.constprop.0+0x178/0x1e0 mm/kasan/common.c:366
 __kasan_slab_free+0x10/0x1c mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1628 [inline]
 slab_free_freelist_hook+0xc4/0x20c mm/slub.c:1653
 slab_free mm/slub.c:3213 [inline]
 kmem_cache_free+0x9c/0x420 mm/slub.c:3229
 putname.part.0+0x68/0x7c fs/namei.c:270
 putname include/linux/err.h:41 [inline]
 filename_parentat fs/namei.c:2547 [inline]
 kern_path_locked+0x64/0x10c fs/namei.c:2558
 handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
 kthread+0x150/0x15c kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756

The buggy address belongs to the object at ffff000002a36180
 which belongs to the cache names_cache of size 4096
The buggy address is located 32 bytes inside of
 4096-byte region [ffff000002a36180, ffff000002a37180)
The buggy address belongs to the page:
page:00000000a105b3ae refcount:1 mapcount:0 mapping:0000000000000000 index:0xf3ff000002a34100 pfn:0x42a30
head:00000000a105b3ae order:3 compound_mapcount:0 compound_pincount:0
flags: 0x1ffc00000010200(slab|head|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc00000010200 0000000000000000 dead000000000122 faff000002837700
raw: f3ff000002a34100 0000000080070003 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff000002a35f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff000002a36000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>ffff000002a36100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                                                 ^
 ffff000002a36200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff000002a36300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
