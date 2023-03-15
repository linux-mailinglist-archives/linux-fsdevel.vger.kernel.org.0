Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE316BBB89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 18:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCOR6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 13:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjCOR6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:58:06 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3253345E
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 10:57:56 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id bk9-20020a056602400900b007530180bc25so862574iob.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 10:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678903076;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfP2RrGfa+6Gegi6FbN5052XrJmeuObXATx/IVMNmRc=;
        b=pqMnAOQ9kNiLSeLtjx4p8WRbYO0ElfxI9hsK2/N0EUymiaKbgyfMEScPKPt8+KUzrA
         D0CK/MHaJIwQ6c+TlQ/v4lczhOUDLIR+VKrB4S5y436ffhvDyJre74Ag37zHkUulHn+n
         zkfHNlBAzlkaSepZZL7Jg33Q6zgXPRgJh3N8Mj2NnCrKw8yLK0v2ue9KWh4zZvddmfiO
         cH7M4p+cRFCxQjN85AM40ERGiSgE/NRZJVP/eb3JJxpKZx3CObJRlILncZp1LggNt+I9
         rlBBfWsCbjA2rC413pSlhAVPosOlR3lrKcz44nfye0LOOorEwYYeYEh0e0s4NTB2ufGl
         L7Zw==
X-Gm-Message-State: AO0yUKWRCgnnDWBi8vdXlOi27MRDtTNVyjmc7/LUSkkZB/WkxjuS2aFu
        kjQ7tfqlc0hNJZ5sTN15GBk8jeZMpwXp5wqAml7iWde4pSY+
X-Google-Smtp-Source: AK7set+CvUevlQ/ozJc/gsCV323wqZhj4dpP3PLYQoJzXwEYZLxNHHJY/caAiaGCwPiT2h/UZvutF/h9WRAsjmwizceuLfgm88M8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d46:b0:310:9d77:6063 with SMTP id
 h6-20020a056e020d4600b003109d776063mr3650597ilj.5.1678903076058; Wed, 15 Mar
 2023 10:57:56 -0700 (PDT)
Date:   Wed, 15 Mar 2023 10:57:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075fe1b05f6f415f7@google.com>
Subject: [syzbot] [ext4?] WARNING in kvfree (2)
From:   syzbot <syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

Hello,

syzbot found the following issue on:

HEAD commit:    fe15c26ee26e Linux 6.3-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1100fce2c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7573cbcd881a88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=64b645917ce07d89bde5
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89d41abd07bd/disk-fe15c26e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa75f5030ade/vmlinux-fe15c26e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/590d0f5903ee/Image-fe15c26e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 9389 at mm/slab_common.c:935 free_large_kmalloc+0x34/0x138 mm/slab_common.c:936
Modules linked in:
CPU: 1 PID: 9389 Comm: syz-executor.5 Not tainted 6.3.0-rc1-syzkaller-gfe15c26ee26e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : free_large_kmalloc+0x34/0x138 mm/slab_common.c:936
lr : kfree+0x184/0x228 mm/slab_common.c:1013
sp : ffff8000227974e0
x29: ffff8000227974e0 x28: 00000000000003bc x27: ffff000142fd15a4
x26: dfff800000000000 x25: 0000000000000020 x24: ffff0000c4f01c00
x23: 0000000000000020 x22: ffff00012f6d48e8 x21: ffff800008829ce8
x20: ffff000142fd15a4 x19: fffffc00050bf440 x18: ffff8000227970e0
x17: ffff800015cdd000 x16: ffff800008313a3c x15: 0000000000000000
x14: 00000000ffff8000 x13: 00000000ecdf532c x12: 0000000000000003
x11: ff8080000809b854 x10: 0000000000000000 x9 : 05ffc0000000203a
x8 : ffff8000186ee000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : fffffffffffffff0 x3 : 0000000000000000
x2 : 0000000000000006 x1 : ffff000142fd15a4 x0 : fffffc00050bf440
Call trace:
 free_large_kmalloc+0x34/0x138 mm/slab_common.c:936
 kfree+0x184/0x228 mm/slab_common.c:1013
 kvfree+0x40/0x50 mm/util.c:649
 ext4_xattr_move_to_block fs/ext4/xattr.c:2680 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
 ext4_expand_extra_isize_ea+0xcf8/0x1620 fs/ext4/xattr.c:2835
 __ext4_expand_extra_isize+0x290/0x348 fs/ext4/inode.c:5955
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5998 [inline]
 __ext4_mark_inode_dirty+0x5dc/0xa94 fs/ext4/inode.c:6076
 __ext4_unlink+0x768/0x998 fs/ext4/namei.c:3256
 ext4_unlink+0x2ec/0xb10 fs/ext4/namei.c:3299
 vfs_unlink+0x2f0/0x508 fs/namei.c:4250
 do_unlinkat+0x4c8/0x82c fs/namei.c:4316
 __do_sys_unlinkat fs/namei.c:4359 [inline]
 __se_sys_unlinkat fs/namei.c:4352 [inline]
 __arm64_sys_unlinkat+0xcc/0xfc fs/namei.c:4352
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 3482
hardirqs last  enabled at (3481): [<ffff80000898bb44>] kasan_quarantine_put+0x1a0/0x1c8 mm/kasan/quarantine.c:242
hardirqs last disabled at (3482): [<ffff80001245e098>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (3300): [<ffff800008034240>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (3298): [<ffff80000803420c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
object pointer: 0x000000000b8c335f
==================================================================
BUG: KASAN: invalid-free in kfree+0x184/0x228 mm/slab_common.c:1013
Free of addr ffff000142fd15a4 by task syz-executor.5/9389

CPU: 0 PID: 9389 Comm: syz-executor.5 Tainted: G        W          6.3.0-rc1-syzkaller-gfe15c26ee26e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call trace:
 dump_backtrace+0x1c8/0x1f4 arch/arm64/kernel/stacktrace.c:158
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:165
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:430
 kasan_report_invalid_free+0xc4/0x114 mm/kasan/report.c:501
 __kasan_kfree_large+0xa4/0xc0 mm/kasan/common.c:272
 kasan_kfree_large include/linux/kasan.h:170 [inline]
 free_large_kmalloc+0x70/0x138 mm/slab_common.c:939
 kfree+0x184/0x228 mm/slab_common.c:1013
 kvfree+0x40/0x50 mm/util.c:649
 ext4_xattr_move_to_block fs/ext4/xattr.c:2680 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
 ext4_expand_extra_isize_ea+0xcf8/0x1620 fs/ext4/xattr.c:2835
 __ext4_expand_extra_isize+0x290/0x348 fs/ext4/inode.c:5955
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5998 [inline]
 __ext4_mark_inode_dirty+0x5dc/0xa94 fs/ext4/inode.c:6076
 __ext4_unlink+0x768/0x998 fs/ext4/namei.c:3256
 ext4_unlink+0x2ec/0xb10 fs/ext4/namei.c:3299
 vfs_unlink+0x2f0/0x508 fs/namei.c:4250
 do_unlinkat+0x4c8/0x82c fs/namei.c:4316
 __do_sys_unlinkat fs/namei.c:4359 [inline]
 __se_sys_unlinkat fs/namei.c:4352 [inline]
 __arm64_sys_unlinkat+0xcc/0xfc fs/namei.c:4352
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

The buggy address belongs to the physical page:
page:000000004ed01e6f refcount:2 mapcount:0 mapping:0000000047d3c139 index:0x1 pfn:0x182fd1
memcg:ffff000131a56000
aops:def_blk_aops ino:700005
flags: 0x5ffc0000000203a(referenced|dirty|lru|active|private|node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc0000000203a fffffc0003531048 fffffc0005118988 ffff0000c0497610
raw: 0000000000000001 ffff0000e0738cb0 00000002ffffffff ffff000131a56000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff000142fd1480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff000142fd1500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff000142fd1580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                               ^
 ffff000142fd1600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff000142fd1680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
