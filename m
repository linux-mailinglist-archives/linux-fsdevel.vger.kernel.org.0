Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6236BFCB1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 21:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCRUVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCRUVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 16:21:47 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3100022000
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 13:21:45 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i14-20020a056e0212ce00b0031d17f33e9aso4115436ilm.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 13:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679170904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WhVjyP1hMBd0iICsWNn1VxSyGjwlHQtVMdZ+C73RvI=;
        b=t2kp1OuPVCZlGdVkR5cFfzv+1P1C+1dx71I0/JUxuUj/gu7M1cYvQZA0PEt3/TQ9b0
         PAIZOoQBcwz82OsrXbzuxxp1n/LU4arf8BfpSCNOkeepGGxuDV7H1zqaWilF4qYRtjMH
         NkRrEwJJrrLSzhhVIPzdtiqoApjILzsZQTZJEkH5WsAae+JDcq6VpdsZjFhix6PciUme
         2gdG7kO0R9XeFoTe5E0UxrxBIuxAEBvG+izTU9pIfZmQNq82GuV/iykilCtSdnr0ndyz
         Nd4nUyDW/sG5A2NSb1JaXBjxj4VgnepW5lmUbNpV8DhRcEVKJ6vyNLlMA/BiD3MiXBnI
         3r/g==
X-Gm-Message-State: AO0yUKX9PM+FfvwWUtFMybPVX/zJzR36/Jyrh0PCQoNrxGJcf76ZUvm8
        PEKsxJ2rh6wpwO4sCq3lCML0xa9lVxe2aOWbR8gmdZ30o6zw
X-Google-Smtp-Source: AK7set8Mk9mQS09Kny5mmYe4novIvdDn7A0KJuJ65IZQWBoEvGD3gR43fDzVJW3U93v8zxNBIjDVvbql/uiRgEpWIT9y+FBxNMtV
MIME-Version: 1.0
X-Received: by 2002:a92:c5a5:0:b0:315:8f6c:50a6 with SMTP id
 r5-20020a92c5a5000000b003158f6c50a6mr1082275ilt.1.1679170904569; Sat, 18 Mar
 2023 13:21:44 -0700 (PDT)
Date:   Sat, 18 Mar 2023 13:21:44 -0700
In-Reply-To: <000000000000a3818b05f18916e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048c13c05f732717f@google.com>
Subject: Re: [syzbot] [reiserfs?] BUG: unable to handle kernel paging request
 in reiserfs_readdir_inode
From:   syzbot <syzbot+3f6ef04b7cf85153b528@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6f08c1de13a9 Add linux-next specific files for 20230317
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1103fed2c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8cdb12af294ab55
dashboard link: https://syzkaller.appspot.com/bug?extid=3f6ef04b7cf85153b528
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fc4481c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b4df26c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/300a30f8157b/disk-6f08c1de.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7cad5b8b07a2/vmlinux-6f08c1de.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eded56f08b63/bzImage-6f08c1de.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6a74fc0a1124/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f6ef04b7cf85153b528@syzkaller.appspotmail.com

REISERFS (device loop0): Using r5 hash to sort names
==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: use-after-free in test_bit_le include/asm-generic/bitops/le.h:21 [inline]
BUG: KASAN: use-after-free in reiserfs_readdir_inode+0xb0d/0x13b0 fs/reiserfs/dir.c:147
Read of size 8 at addr ffff88807384d000 by task syz-executor532/5096

CPU: 0 PID: 5096 Comm: syz-executor532 Not tainted 6.3.0-rc2-next-20230317-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 test_bit_le include/asm-generic/bitops/le.h:21 [inline]
 reiserfs_readdir_inode+0xb0d/0x13b0 fs/reiserfs/dir.c:147
 iterate_dir+0x56e/0x6f0 fs/readdir.c:65
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __x64_sys_getdents64+0x13e/0x2c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc13aaf8939
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe499b2a68 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000000000012701 RCX: 00007fc13aaf8939
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffe499b2a90 R09: 00007ffe499b2a90
R10: 0000000000001131 R11: 0000000000000246 R12: 00007ffe499b2a8c
R13: 00007ffe499b2ac0 R14: 00007ffe499b2aa0 R15: 0000000000000005
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001ce1340 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x7384d
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001ce1388 ffff8880b9943620 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5086, tgid 5086 (udevd), ts 77632421048, free_ts 77634242475
 prep_new_page mm/page_alloc.c:2472 [inline]
 get_page_from_freelist+0xf75/0x2ab0 mm/page_alloc.c:4236
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5502
 __folio_alloc+0x16/0x40 mm/page_alloc.c:5534
 vma_alloc_folio+0x155/0x850 mm/mempolicy.c:2244
 shmem_alloc_folio+0x119/0x1e0 mm/shmem.c:1557
 shmem_alloc_and_acct_folio+0x15e/0x5d0 mm/shmem.c:1581
 shmem_get_folio_gfp+0xa86/0x1a80 mm/shmem.c:1926
 shmem_get_folio mm/shmem.c:2057 [inline]
 shmem_write_begin+0x14a/0x380 mm/shmem.c:2663
 generic_perform_write+0x256/0x570 mm/filemap.c:3921
 __generic_file_write_iter+0x2ae/0x500 mm/filemap.c:4049
 generic_file_write_iter+0xe3/0x350 mm/filemap.c:4081
 call_write_iter include/linux/fs.h:1854 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9f6/0xe20 fs/read_write.c:584
 ksys_write+0x12b/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1468 [inline]
 free_unref_page_prepare+0x4d1/0xb60 mm/page_alloc.c:3298
 free_unref_page_list+0xe3/0xa70 mm/page_alloc.c:3439
 release_pages+0xcd7/0x1380 mm/swap.c:1042
 __pagevec_release+0x77/0xe0 mm/swap.c:1062
 pagevec_release include/linux/pagevec.h:63 [inline]
 folio_batch_release include/linux/pagevec.h:132 [inline]
 shmem_undo_range+0x5c0/0x1350 mm/shmem.c:929
 shmem_truncate_range mm/shmem.c:1027 [inline]
 shmem_evict_inode+0x32f/0xb60 mm/shmem.c:1142
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput fs/inode.c:1774 [inline]
 iput+0x4a7/0x7a0 fs/inode.c:1760
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:745 [inline]
 dput+0x6ac/0xe10 fs/dcache.c:913
 do_renameat2+0xb72/0xc90 fs/namei.c:4925
 __do_sys_rename fs/namei.c:4969 [inline]
 __se_sys_rename fs/namei.c:4967 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:4967
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807384cf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807384cf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807384d000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807384d080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807384d100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

