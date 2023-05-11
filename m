Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C6E6FF45A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbjEKOb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbjEKObF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 10:31:05 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5B268E
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 07:30:25 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-76c6048ca2cso207831439f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 07:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815387; x=1686407387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8BIW02MmSn8Dda6MoNgjn4OqqzZHyeGIeTJvSDMiD4=;
        b=EgcHR9Z7Xo4pmmZKapVgASUD4J+4wxdmaBo9McFAghAKnd8wIA1ZfctFvb7VXY+Jv9
         Bnu2SkYAspin8A9D9veN/5V4dK7ZlFYHLNtFfl3OiWafbn9MGjzOOvS7bpMTVzFbf/f3
         g0XkaKpoP5du0pVQnNGb0aIZJyb4i/9hy0+8bjHSxpKAYC2IMnf2kbGk1xyy3dWjGZyF
         7A5P5PqoYHAj3U7bZF3nQl1GiP4kxo4tflMXW1LPmUWhMOqZ+0whBZ6GpIHquod4cP6j
         B8/JuKrTpdi7jM4y5NfNKNoJLocsJYxgKA6/Ta1J97YjeV4RkxIQi1gH2VfdxuRnLIjc
         CHRQ==
X-Gm-Message-State: AC+VfDz11lE0+t8MvsjVR/NTTyLZgygqHMefd1CfIz+NXlqP4sdrD+8R
        1Cia0sM0IUme8ATe4aBg+hTcaiI3B0G/Uk8SOXoeouW2zsv3
X-Google-Smtp-Source: ACHHUZ53K+FAllYz6t0/jICm/3DvlhBkeJjWPN4MZs+Vdf9dzbptXlw4obYKm70+vk5KSXqU2le1DZgDD6KpilBSfCHbYdfmpTUc
MIME-Version: 1.0
X-Received: by 2002:a92:d9c4:0:b0:331:1997:f88c with SMTP id
 n4-20020a92d9c4000000b003311997f88cmr11038290ilq.0.1683815387721; Thu, 11 May
 2023 07:29:47 -0700 (PDT)
Date:   Thu, 11 May 2023 07:29:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d7d6e05fb6bd2d7@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_search_dir
From:   syzbot <syzbot+34a0f26f0f61c4888ea4@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fc4354c6e5c2 Merge tag 'mm-stable-2023-05-06-10-49' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144e2512280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
dashboard link: https://syzkaller.appspot.com/bug?extid=34a0f26f0f61c4888ea4
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f4adc5d40b0/disk-fc4354c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e06af6b6985/vmlinux-fc4354c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d99bbab1361/bzImage-fc4354c6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34a0f26f0f61c4888ea4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ext4_search_dir+0xf2/0x1b0 fs/ext4/namei.c:1523
Read of size 1 at addr ffff88807ed202cc by task syz-executor.2/19699

CPU: 0 PID: 19699 Comm: syz-executor.2 Not tainted 6.3.0-syzkaller-13466-gfc4354c6e5c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 ext4_search_dir+0xf2/0x1b0 fs/ext4/namei.c:1523
 ext4_find_inline_entry+0x4ba/0x5e0 fs/ext4/inline.c:1708
 __ext4_find_entry+0x2b4/0x1b30 fs/ext4/namei.c:1596
 ext4_lookup_entry fs/ext4/namei.c:1751 [inline]
 ext4_lookup+0x17a/0x750 fs/ext4/namei.c:1819
 lookup_one_qstr_excl+0x11b/0x250 fs/namei.c:1605
 do_renameat2+0x6e1/0x1660 fs/namei.c:4952
 __do_sys_rename fs/namei.c:5048 [inline]
 __se_sys_rename fs/namei.c:5046 [inline]
 __x64_sys_rename+0x86/0x90 fs/namei.c:5046
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9f7ce8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9f7dc30168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f9f7cfabf80 RCX: 00007f9f7ce8c169
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000020000440
RBP: 00007f9f7cee7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd9ebba38f R14: 00007f9f7dc30300 R15: 0000000000022000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001fb4800 refcount:0 mapcount:-128 mapping:0000000000000000 index:0x0 pfn:0x7ed20
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffff7f(buddy)
raw: 00fff00000000000 ffffea0001e19608 ffffea00012b0208 0000000000000000
raw: 0000000000000000 0000000000000003 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 15769, tgid 15769 (udevd), ts 3435881805689, free_ts 3440975634402
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x1b9/0x2e0 mm/slub.c:3475
 getname_flags+0xbc/0x4e0 fs/namei.c:140
 do_sys_openat2+0xd6/0x500 fs/open.c:1350
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2659
 discard_slab mm/slub.c:2097 [inline]
 __unfreeze_partials+0x1b1/0x1f0 mm/slub.c:2636
 put_cpu_partial+0x116/0x180 mm/slub.c:2712
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 slab_alloc_node mm/slub.c:3451 [inline]
 kmem_cache_alloc_node+0x157/0x350 mm/slub.c:3496
 __alloc_skb+0x181/0x420 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1288 [inline]
 alloc_skb_with_frags+0xa8/0x750 net/core/skbuff.c:6378
 sock_alloc_send_pskb+0x919/0xa50 net/core/sock.c:2729
 unix_dgram_sendmsg+0x5b5/0x2050 net/unix/af_unix.c:1944
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg net/socket.c:747 [inline]
 __sys_sendto+0x475/0x630 net/socket.c:2144
 __do_sys_sendto net/socket.c:2156 [inline]
 __se_sys_sendto net/socket.c:2152 [inline]
 __x64_sys_sendto+0xde/0xf0 net/socket.c:2152
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80

Memory state around the buggy address:
 ffff88807ed20180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807ed20200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88807ed20280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff88807ed20300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807ed20380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
