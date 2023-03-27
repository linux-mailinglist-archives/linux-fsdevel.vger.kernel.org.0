Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDEE6CA1F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 13:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjC0LB7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 07:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjC0LB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:01:58 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2553C29
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 04:01:54 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id z7-20020a921a47000000b0032600db79f7so2091486ill.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 04:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679914914;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrsIpso27Q4AtZRUyk0BFfoM9bmAxvhkuXfA78FHMEY=;
        b=BSAmAoPoxdaE42/tU/oz6OWfF5JIUf6x/glZneUIkW7GWXAkvcfFHuzzKukQIR9hxW
         eKa9IreocRSW6RLt9xywldt2tLT5Nd0nsAH05dXRQMvh1QZ4Z+jl6H0w3rpzJDPojWHV
         9WRMazovAFegLdIbviyT2AWFYOu1h1imQ86vM5yUXJs8bdNV8cvd32/k13KSNd89VXj/
         PrEYYseCc44JOgQlEqfhMyGMmn0IM20muteINkZgyP1NFrxu2EpDwh5Rwuu8MA4SQHwW
         KwXlBcOJndtz1K8k7xQkk9nKJwkIO169jVqlr/jfdL2jC6Z64AY9mxR1gUwKMa9T6qQv
         BOBw==
X-Gm-Message-State: AO0yUKUSzf/WddP39+SCQCdZlMTB1VFdeUVeTRAkJhl9oMloL3M2Ekt1
        3CEf1PSMYpc31QR4Ql6o1uKNalvjOGJJ/O9h/izs3hctuw35
X-Google-Smtp-Source: AK7set9Wemj1mlLhH2L0v0gV1Z9gsOuGdhdT/4LRA9Oawb+/nH7vCTdiZC6/pV6drv/n89Qr+pcx5ZggQloP1tvhjqDhf3LeOmmi
MIME-Version: 1.0
X-Received: by 2002:a02:95a6:0:b0:3a7:e46f:1016 with SMTP id
 b35-20020a0295a6000000b003a7e46f1016mr4401649jai.0.1679914914159; Mon, 27 Mar
 2023 04:01:54 -0700 (PDT)
Date:   Mon, 27 Mar 2023 04:01:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b62cdb05f7dfab8b@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-use-after-free Read in ext4_convert_inline_data_nolock
From:   syzbot <syzbot+db6caad9ebd2c8022b41@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    17214b70a159 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1123dba6c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
dashboard link: https://syzkaller.appspot.com/bug?extid=db6caad9ebd2c8022b41
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d166fda7fbbd/disk-17214b70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c16461022b9/vmlinux-17214b70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53e9e40da8bb/bzImage-17214b70.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db6caad9ebd2c8022b41@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ext4_read_inline_data fs/ext4/inline.c:199 [inline]
BUG: KASAN: slab-use-after-free in ext4_convert_inline_data_nolock+0x31a/0xd80 fs/ext4/inline.c:1204
Read of size 20 at addr ffff888023fbe1a3 by task syz-executor.0/14243

CPU: 1 PID: 14243 Comm: syz-executor.0 Not tainted 6.3.0-rc3-syzkaller-00012-g17214b70a159 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 ext4_read_inline_data fs/ext4/inline.c:199 [inline]
 ext4_convert_inline_data_nolock+0x31a/0xd80 fs/ext4/inline.c:1204
 ext4_convert_inline_data+0x4da/0x620 fs/ext4/inline.c:2065
 ext4_fallocate+0x14d/0x2050 fs/ext4/extents.c:4701
 vfs_fallocate+0x54b/0x6b0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xbd/0x100 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f01bac8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f01bba76168 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f01badac050 RCX: 00007f01bac8c0f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f01bace7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000008000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc150e1a5f R14: 00007f01bba76300 R15: 0000000000022000
 </TASK>

Allocated by task 4435:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x254/0x4e0 security/tomoyo/file.c:771
 security_file_open+0x63/0xa0 security/security.c:1719
 do_dentry_open+0x308/0x10f0 fs/open.c:907
 do_open fs/namei.c:3560 [inline]
 path_openat+0x27b3/0x3170 fs/namei.c:3715
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_openat fs/open.c:1380 [inline]
 __se_sys_openat fs/open.c:1375 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1375
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 4435:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0x264/0x3c0 mm/slub.c:3800
 tomoyo_realpath_from_path+0x5a3/0x5e0 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x254/0x4e0 security/tomoyo/file.c:771
 security_file_open+0x63/0xa0 security/security.c:1719
 do_dentry_open+0x308/0x10f0 fs/open.c:907
 do_open fs/namei.c:3560 [inline]
 path_openat+0x27b3/0x3170 fs/namei.c:3715
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_openat fs/open.c:1380 [inline]
 __se_sys_openat fs/open.c:1375 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1375
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888023fbe000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 419 bytes inside of
 freed 4096-byte region [ffff888023fbe000, ffff888023fbf000)

The buggy address belongs to the physical page:
page:ffffea00008fee00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23fb8
head:ffffea00008fee00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012442140 ffffea0000835200 dead000000000002
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 6719, tgid 6717 (syz-executor.3), ts 223345556670, free_ts 223329495124
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x3246/0x33c0 mm/page_alloc.c:4325
 __alloc_pages+0x255/0x670 mm/page_alloc.c:5591
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3491
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1061
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 alloc_super+0x59/0x930 fs/super.c:202
 sget_fc+0x222/0x630 fs/super.c:581
 get_tree_bdev+0x26f/0x620 fs/super.c:1271
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3042
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare mm/page_alloc.c:1503 [inline]
 free_unref_page_prepare+0xe2f/0xe70 mm/page_alloc.c:3387
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:3482
 discard_slab mm/slub.c:2098 [inline]
 __unfreeze_partials+0x1b1/0x1f0 mm/slub.c:2637
 put_cpu_partial+0x116/0x180 mm/slub.c:2713
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:769
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x11f/0x2e0 mm/slub.c:3476
 getname_flags+0xbc/0x4e0 fs/namei.c:140
 getname fs/namei.c:219 [inline]
 __do_sys_symlink fs/namei.c:4445 [inline]
 __se_sys_symlink fs/namei.c:4443 [inline]
 __x64_sys_symlink+0x5f/0x90 fs/namei.c:4443
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888023fbe080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888023fbe100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888023fbe180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888023fbe200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888023fbe280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
