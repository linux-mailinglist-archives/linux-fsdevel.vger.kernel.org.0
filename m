Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E3569AB3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 13:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBQMSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 07:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjBQMSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:18:53 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD846604A
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 04:18:51 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id f27-20020a056602089b00b00745469852cfso138215ioz.19
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 04:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wjKkIIUXCi57ViLebZZIDh9oWKEiXoND5Lk++abfRI=;
        b=hEP9k31Ty+CHuggfv0DFub6b8aNGElH38ZFNL4wqL5HpMzzHNauTOgIVux8Iu1mnxG
         c/qz8BuvrqZa/ea4BHGwoGiYUMPxhp4EGzP+55KvPQC4+Qqb/cOr27QxnNDnpTpMW6/C
         hK2CDLgNhfHVE9zCsdKoo+BXjpuiz2/J7OQ6CFYLgARYrSyatYHi7C+R7jXwidCz3k5T
         nhjW1HLenS/aV6gj8/4QvWbdG1uh9+2rm4eXHr82OMjBzSHjqqSUPdEgMxOxZW9iR4a9
         QPFE0kuMDnmtnMFlNz+DHzDows2Sz/xrhRUErK5VmF/Du8N+Y6h/yqEkrqBBllAkAjcb
         Q8aw==
X-Gm-Message-State: AO0yUKXh46i7XUzyfjU6qwAOyZMuOHpcLcT7FSiTz+wpvKRj1HVxTO/Z
        jEe8MUYazT7CNBVhGkrNKSHMfkANJhNLQMeq4ouzD7XoITcz
X-Google-Smtp-Source: AK7set9ANx5RYXxJHOuQ3jbiisOvgUrhKeK0Qz9erBBYL3PaeATLM5Z/q0eo/zHBqMV8Xn2UE+poI8d29NADuLvQuSyZH5583arj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1304:b0:314:24e2:5189 with SMTP id
 g4-20020a056e02130400b0031424e25189mr158674ilr.0.1676636331204; Fri, 17 Feb
 2023 04:18:51 -0800 (PST)
Date:   Fri, 17 Feb 2023 04:18:51 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0674605f4e450c3@google.com>
Subject: [syzbot] [f2fs?] possible deadlock in f2fs_get_node_info
From:   syzbot <syzbot+ad111ebee58835908498@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ceaa837f96ad Linux 6.2-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b3b900c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d9381ac81f4ac15
dashboard link: https://syzkaller.appspot.com/bug?extid=ad111ebee58835908498
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad111ebee58835908498@syzkaller.appspotmail.com

WARNING: possible circular locking dependency detected
6.2.0-rc8-syzkaller #0 Not tainted
------------------------------------------------------
kswapd1/111 is trying to acquire lock:
ffff88806914b130 (&nm_i->nat_tree_lock){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2188 [inline]
ffff88806914b130 (&nm_i->nat_tree_lock){++++}-{3:3}, at: f2fs_get_node_info+0x1ac/0x1070 fs/f2fs/node.c:564

but task is already holding lock:
ffffffff8c8d7080 (fs_reclaim){+.+.}-{0:0}, at: try_to_freeze include/linux/freezer.h:56 [inline]
ffffffff8c8d7080 (fs_reclaim){+.+.}-{0:0}, at: try_to_freeze include/linux/freezer.h:51 [inline]
ffffffff8c8d7080 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xb88/0x1530 mm/vmscan.c:7165

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4674 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4688
       might_alloc include/linux/sched/mm.h:271 [inline]
       prepare_alloc_pages+0x159/0x570 mm/page_alloc.c:5320
       __alloc_pages+0x149/0x5b0 mm/page_alloc.c:5538
       __folio_alloc+0x16/0x40 mm/page_alloc.c:5581
       vma_alloc_folio+0x155/0x870 mm/mempolicy.c:2248
       alloc_page_vma include/linux/gfp.h:284 [inline]
       do_anonymous_page mm/memory.c:4074 [inline]
       handle_pte_fault mm/memory.c:4929 [inline]
       __handle_mm_fault+0x1822/0x3c90 mm/memory.c:5073
       handle_mm_fault+0x1b6/0x850 mm/memory.c:5219
       do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       copy_user_short_string+0xd/0x40 arch/x86/lib/copy_user_64.S:232
       copy_user_generic arch/x86/include/asm/uaccess_64.h:37 [inline]
       raw_copy_to_user arch/x86/include/asm/uaccess_64.h:58 [inline]
       _copy_to_user lib/usercopy.c:34 [inline]
       _copy_to_user+0x127/0x150 lib/usercopy.c:27
       copy_to_user include/linux/uaccess.h:169 [inline]
       f2fs_ioc_get_encryption_pwsalt+0x2b2/0x370 fs/f2fs/file.c:2365
       __f2fs_ioctl+0x29f1/0xaaf0 fs/f2fs/file.c:4169
       f2fs_compat_ioctl+0x399/0x630 fs/f2fs/file.c:4867
       __do_compat_sys_ioctl+0x255/0x2b0 fs/ioctl.c:968
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #1 (&sbi->sb_lock
){++++}-{3:3}:
       down_write+0x94/0x220 kernel/locking/rwsem.c:1562
       f2fs_down_write fs/f2fs/f2fs.h:2213 [inline]
       f2fs_handle_error+0x8e/0x200 fs/f2fs/super.c:3926
       f2fs_check_nid_range.part.0+0x4d/0x60 fs/f2fs/node.c:39
       f2fs_check_nid_range fs/f2fs/node.c:2278 [inline]
       add_free_nid.isra.0+0x781/0x940 fs/f2fs/node.c:2285
       scan_nat_page fs/f2fs/node.c:2387 [inline]
       __f2fs_build_free_nids+0x5b5/0xe10 fs/f2fs/node.c:2493
       f2fs_build_free_nids fs/f2fs/node.c:2531 [inline]
       f2fs_build_node_manager+0x2007/0x2fb0 fs/f2fs/node.c:3316
       f2fs_fill_super+0x3ade/0x7680 fs/f2fs/super.c:4334
       mount_bdev+0x351/0x410 fs/super.c:1359
       legacy_get_tree+0x109/0x220 fs/fs_context.c:610
       vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
       do_new_mount fs/namespace.c:3145 [inline]
       path_mount+0x132a/0x1e20 fs/namespace.c:3475
       do_mount fs/namespace.c:3488 [inline]
       __do_sys_mount fs/namespace.c:3697 [inline]
       __se_sys_mount fs/namespace.c:3674 [inline]
       __ia32_sys_mount+0x282/0x300 fs/namespace.c:3674
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #0 (&nm_i->nat_tree_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       down_read+0x9c/0x450 kernel/locking/rwsem.c:1509
       f2fs_down_read fs/f2fs/f2fs.h:2188 [inline]
       f2fs_get_node_info+0x1ac/0x1070 fs/f2fs/node.c:564
       __write_node_page+0x89f/0x2140 fs/f2fs/node.c:1616
       f2fs_write_node_page+0x2c/0x40 fs/f2fs/node.c:1725
       pageout+0x38a/0xa70 mm/vmscan.c:1298
       shrink_folio_list+0x2bf3/0x3a60 mm/vmscan.c:1947
       shrink_inactive_list mm/vmscan.c:2526 [inline]
       shrink_list mm/vmscan.c:2767 [inline]
       shrink_lruvec+0xd0e/0x27a0 mm/vmscan.c:5954
       shrink_node_memcgs mm/vmscan.c:6141 [inline]
       shrink_node+0x8f2/0x1f40 mm/vmscan.c:6172
       kswapd_shrink_node mm/vmscan.c:6961 [inline]
       balance_pgdat+0x8f5/0x1530 mm/vmscan.c:7151
       kswapd+0x70b/0xfc0 mm/vmscan.c:7411
       kthread+0x2e8/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

Chain exists of:
  &nm_i->nat_tree_lock --> &sbi->sb_lock --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&sbi->sb_lock);
                               lock(fs_reclaim);
  lock(&nm_i->nat_tree_lock);

 *** DEADLOCK ***

1 lock held by kswapd1/111:
 #0: ffffffff8c8d7080 (fs_reclaim){+.+.}-{0:0}, at: try_to_freeze include/linux/freezer.h:56 [inline]
 #0: ffffffff8c8d7080 (fs_reclaim){+.+.}-{0:0}, at: try_to_freeze include/linux/freezer.h:51 [inline]
 #0: ffffffff8c8d7080 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xb88/0x1530 mm/vmscan.c:7165

stack backtrace:
CPU: 1 PID: 111 Comm: kswapd1 Not tainted 6.2.0-rc8-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 down_read+0x9c/0x450 kernel/locking/rwsem.c:1509
 f2fs_down_read fs/f2fs/f2fs.h:2188 [inline]
 f2fs_get_node_info+0x1ac/0x1070 fs/f2fs/node.c:564
 __write_node_page+0x89f/0x2140 fs/f2fs/node.c:1616
 f2fs_write_node_page+0x2c/0x40 fs/f2fs/node.c:1725
 pageout+0x38a/0xa70 mm/vmscan.c:1298
 shrink_folio_list+0x2bf3/0x3a60 mm/vmscan.c:1947
 shrink_inactive_list mm/vmscan.c:2526 [inline]
 shrink_list mm/vmscan.c:2767 [inline]
 shrink_lruvec+0xd0e/0x27a0 mm/vmscan.c:5954
 shrink_node_memcgs mm/vmscan.c:6141 [inline]
 shrink_node+0x8f2/0x1f40 mm/vmscan.c:6172
 kswapd_shrink_node mm/vmscan.c:6961 [inline]
 balance_pgdat+0x8f5/0x1530 mm/vmscan.c:7151
 kswapd+0x70b/0xfc0 mm/vmscan.c:7411
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
