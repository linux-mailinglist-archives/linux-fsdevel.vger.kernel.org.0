Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4235A6D3CE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 07:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjDCFct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 01:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDCFcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:32:45 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A610CB
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Apr 2023 22:32:44 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id a21-20020a5d9595000000b0074c9dc19e16so17089922ioo.15
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Apr 2023 22:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680499963; x=1683091963;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VoxY+rT7GIMQ6klSLscO4dFONaIK7l+LZzBgFk21zk4=;
        b=LPDrOwqt/ip2N5Pt1vxQpFro4CYUxk+wzjW8wM2DbIvQBEfTXqPh7yLbG/q3gJ986G
         kSO/B9d7PQ2WmBvaeDUB5okgDbIvpZF8GOJ6oloyvjq2YBmzRZK+yVE7f53DSClGQC28
         kiuUi10pGO8FTGrl3e8nXnioNOPvOHi1AER3awS01KqQARhN8Gk10pwoIUDyjZr8I+iV
         KKVpU5BZ2S/Iw9apcGhZEha4IRjSr4J6z164wDkN4qCpuh7OJeouo6+0SRiCxDVnWx+L
         yKBzFsv/lEhsp5W46QpXFbWsyG7OvoybaU3R/cMnlQabYAOoiiWXxDKZDR2ckcUPEzWJ
         +37Q==
X-Gm-Message-State: AAQBX9esPDjcmZtNBYQwLoczbUaW5BwVbyc/l3Zss9OMb+X+UxuKfI6g
        n8trkrqxrqicP3dWKQ8kbG1la96KhvCPJtfYNvi74vaxXgaj
X-Google-Smtp-Source: AKy350aj9DfWlgtC1q9A7qu7CvsARLR4v7Jhezgx87uS/jDagSjJrQhrXdT3/YSvRBqRGRzVzD0lJ8qhBZ7KWEeUuqDBxr9MxHLu
MIME-Version: 1.0
X-Received: by 2002:a5d:84ce:0:b0:75c:d7d7:aba with SMTP id
 z14-20020a5d84ce000000b0075cd7d70abamr6015965ior.0.1680499963480; Sun, 02 Apr
 2023 22:32:43 -0700 (PDT)
Date:   Sun, 02 Apr 2023 22:32:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e524d05f867e38d@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-out-of-bounds Write in
 ext4_write_inline_data_end (2)
From:   syzbot <syzbot+ba4fa9ce904fefb787d3@syzkaller.appspotmail.com>
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

HEAD commit:    da8e7da11e4b Merge tag 'nfsd-6.3-4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc9af5c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=ba4fa9ce904fefb787d3
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/62e9c5f4bead/disk-da8e7da1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c11aa933e2a7/vmlinux-da8e7da1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a21bdd49c84/bzImage-da8e7da1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba4fa9ce904fefb787d3@syzkaller.appspotmail.com

EXT4-fs error (device loop1): __ext4_get_inode_loc:4560: comm syz-executor.1: Invalid inode table block 8387954787021251444 in block_group 0
==================================================================
BUG: KASAN: slab-out-of-bounds in ext4_write_inline_data fs/ext4/inline.c:248 [inline]
BUG: KASAN: slab-out-of-bounds in ext4_write_inline_data_end+0x5b4/0x10e0 fs/ext4/inline.c:766
Write of size 1 at addr ffff88802cc1f9ae by task syz-executor.1/23455

CPU: 1 PID: 23455 Comm: syz-executor.1 Not tainted 6.3.0-rc3-syzkaller-00338-gda8e7da11e4b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 ext4_write_inline_data fs/ext4/inline.c:248 [inline]
 ext4_write_inline_data_end+0x5b4/0x10e0 fs/ext4/inline.c:766
 generic_perform_write+0x3ed/0x5e0 mm/filemap.c:3937
 ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:289
 ext4_file_write_iter+0x1d6/0x1930
 do_iter_write+0x6ea/0xc50 fs/read_write.c:861
 iter_file_splice_write+0x843/0xfe0 fs/splice.c:778
 do_splice_from fs/splice.c:856 [inline]
 direct_splice_actor+0xe7/0x1c0 fs/splice.c:1022
 splice_direct_to_actor+0x4c4/0xbd0 fs/splice.c:977
 do_splice_direct+0x283/0x3d0 fs/splice.c:1065
 do_sendfile+0x620/0xff0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f14b828c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f14b8fd4168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f14b83abf80 RCX: 00007f14b828c0f9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000006
RBP: 00007f14b82e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000001ffff R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff8d44f2ff R14: 00007f14b8fd4300 R15: 0000000000022000
 </TASK>

Allocated by task 2:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 lsm_cred_alloc security/security.c:568 [inline]
 security_prepare_creds+0x4c/0x140 security/security.c:1781
 prepare_creds+0x458/0x630 kernel/cred.c:291
 copy_creds+0x14a/0xca0 kernel/cred.c:365
 copy_process+0x94a/0x3fc0 kernel/fork.c:2124
 kernel_clone+0x222/0x800 kernel/fork.c:2679
 kernel_thread+0x156/0x1d0 kernel/fork.c:2739
 create_kthread kernel/kthread.c:399 [inline]
 kthreadd+0x583/0x750 kernel/kthread.c:746
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88802cc1f800
 which belongs to the cache kmalloc-cg-256 of size 256
The buggy address is located 230 bytes to the right of
 allocated 200-byte region [ffff88802cc1f800, ffff88802cc1f8c8)

The buggy address belongs to the physical page:
page:ffffea0000b30780 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802cc1f400 pfn:0x2cc1e
head:ffffea0000b30780 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802fa51901
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff88801244f000 ffff88801244e4c8 ffffea0000940d90
raw: ffff88802cc1f400 0000000000100004 00000001ffffffff ffff88802fa51901
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4381, tgid 4381 (kworker/u4:5), ts 11572064611, free_ts 0
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
 __kmalloc+0xa8/0x230 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 lsm_cred_alloc security/security.c:568 [inline]
 security_prepare_creds+0x4c/0x140 security/security.c:1781
 prepare_creds+0x458/0x630 kernel/cred.c:291
 prepare_exec_creds+0x18/0x270 kernel/cred.c:311
 prepare_bprm_creds fs/exec.c:1477 [inline]
 bprm_execve+0xff/0x1740 fs/exec.c:1815
 kernel_execve+0x8ea/0xa10 fs/exec.c:2020
 call_usermodehelper_exec_async+0x233/0x370 kernel/umh.c:110
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802cc1f880: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff88802cc1f900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802cc1f980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                  ^
 ffff88802cc1fa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802cc1fa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
