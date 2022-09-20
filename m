Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478A95BE36F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 12:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiITKh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 06:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiITKhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:37:43 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3F77286F
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 03:35:37 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id e9-20020a6b7309000000b006a27af93e45so1187942ioh.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 03:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=HPj9algLbMrRfnhVa0iGOto4gsetCcc6Vj6GkXOTxZY=;
        b=POvZgRrYmc9DXoLMCuaplr9lRBHEu7kMWR/egnZ98S0rue87l9HY6I+VUxz6cxp3nB
         x0E3ffov3QgYnpqRyxBdPHyW5FMUF0hhWJ/wPaY8PvBoIDgGvW1wn+VwPiyNVvpjI3ph
         i7wA4f8a2IjKCc0Qdl7pWko6KmqJ8+1XWjo7yfiP4177SXb2bVd0avllrl/fxxXmKzIY
         qI87lGzCSubdYsBX3MhWEVfes1WMvSY4GnawbwJqjAU8S80VrcGBJRyYACH/zQU1xfXi
         TBSr2ZUS+jTVJWpx2lGiep630OhGLuXval5YBTyhtYVymeJQHndGtpdq5un5K9J1rK5x
         5Wbw==
X-Gm-Message-State: ACrzQf3qNtnycZXaiNFdrEjt3eTjltX9fEFronPLF62+1qSn80cAcz06
        3Z3kEnFeGD0BW054QKOHwcbZtjBCnJCUgHV5XvHn+mrtSjuo
X-Google-Smtp-Source: AMsMyM4OubIzLTCl1xMP+SFbmEyENO9Aeq/WZMN2SZVq8dg4fgKHVIS30XWLvpZyIWERvOht1zn95I7homdN6POyDc4OApivtlLL
MIME-Version: 1.0
X-Received: by 2002:a92:cd89:0:b0:2f1:9850:7ded with SMTP id
 r9-20020a92cd89000000b002f198507dedmr9815831ilb.271.1663670136886; Tue, 20
 Sep 2022 03:35:36 -0700 (PDT)
Date:   Tue, 20 Sep 2022 03:35:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000885d8605e91963fd@google.com>
Subject: [syzbot] KASAN: stack-out-of-bounds Read in iput
From:   syzbot <syzbot+870ae3a4c7a251c996bd@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    521a547ced64 Linux 6.0-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c41580880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=870ae3a4c7a251c996bd
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110f0654880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1625e737080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7daadf43221d/disk-521a547c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e776edd0f78/vmlinux-521a547c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+870ae3a4c7a251c996bd@syzkaller.appspotmail.com

ntfs3: loop2: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
==================================================================
BUG: KASAN: stack-out-of-bounds in native_save_fl arch/x86/include/asm/irqflags.h:35 [inline]
BUG: KASAN: stack-out-of-bounds in arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
BUG: KASAN: stack-out-of-bounds in arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
BUG: KASAN: stack-out-of-bounds in lock_acquire+0x1c3/0x3c0 kernel/locking/lockdep.c:5669
Read of size 8 at addr ffffc9000b7df95f by task syz-executor383/13922

CPU: 0 PID: 13922 Comm: syz-executor383 Not tainted 6.0.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 native_save_fl arch/x86/include/asm/irqflags.h:35 [inline]
 arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
 arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
 lock_acquire+0x1c3/0x3c0 kernel/locking/lockdep.c:5669
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 iput_final fs/inode.c:1737 [inline]
 iput+0x3ee/0x760 fs/inode.c:1774
 ntfs_fill_super+0x2352/0x42a0 fs/ntfs3/super.c:1278
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f203d446d7a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 d8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f203d3f1078 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f203d3f10d0 RCX: 00007f203d446d7a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f203d3f1090
RBP: 000000000000000e R08: 00007f203d3f10d0 R09: 00007f203d3f16b8
R10: 0000000000000000 R11: 0000000000000286 R12: 00007f203d3f1090
R13: 0000000020000350 R14: 0000000000000003 R15: 0000000000000004
 </TASK>

The buggy address belongs to stack of task syz-executor383/13922
 and is located at offset 31 in frame:
 lock_acquire+0x0/0x3c0 kernel/locking/lockdep.c:5621

This frame has 3 objects:
 [32, 40) 'flags.i.i.i87'
 [64, 72) 'flags.i.i.i'
 [96, 136) 'hlock'

The buggy address belongs to the virtual mapping at
 [ffffc9000b7d8000, ffffc9000b7e1000) created by:
 dup_task_struct+0x8b/0x490 kernel/fork.c:977

The buggy address belongs to the physical page:
page:ffffea0001bcb8c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6f2e3
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 3629, tgid 3629 (syz-executor383), ts 473162860658, free_ts 11190855215
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5515
 vm_area_alloc_pages mm/vmalloc.c:2958 [inline]
 __vmalloc_area_node mm/vmalloc.c:3026 [inline]
 __vmalloc_node_range+0x8f4/0x1290 mm/vmalloc.c:3196
 alloc_thread_stack_node+0x307/0x500 kernel/fork.c:312
 dup_task_struct+0x8b/0x490 kernel/fork.c:977
 copy_process+0x65b/0x3fd0 kernel/fork.c:2088
 kernel_clone+0x21f/0x790 kernel/fork.c:2674
 __do_sys_clone kernel/fork.c:2808 [inline]
 __se_sys_clone kernel/fork.c:2792 [inline]
 __x64_sys_clone+0x228/0x290 kernel/fork.c:2792
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3476
 free_contig_range+0xa3/0x160 mm/page_alloc.c:9408
 destroy_args+0xfe/0x91d mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x43e/0x497 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0x1b9/0x3e0 init/main.c:1296
 do_initcall_level+0x168/0x218 init/main.c:1369
 do_initcalls+0x4b/0x8c init/main.c:1385
 kernel_init_freeable+0x3f1/0x57b init/main.c:1623
 kernel_init+0x19/0x2b0 init/main.c:1512
 ret_from_fork+0x1f/0x30

Memory state around the buggy address:
 ffffc9000b7df800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000b7df880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000b7df900: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2
                                                    ^
 ffffc9000b7df980: 00 f2 f2 f2 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3
 ffffc9000b7dfa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
