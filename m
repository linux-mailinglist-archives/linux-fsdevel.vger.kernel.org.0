Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D301618B35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiKCWOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 18:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiKCWOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:14:43 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFFF21273
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 15:14:40 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id l9-20020a5d8f89000000b006bd33712128so1893932iol.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 15:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNx/xrXlOj1gag8JQNSKzoYOtQS92/lKcLuxTIRHnPs=;
        b=qOSAnGdkEoRmIpBbwIkBLRkqo4mKy7nVa4vHpcxxDje/6x381oC5mtkSO08jTPS2HS
         13yqOc8aTNgAMd4BFWDMqKzecottdNxcVzaWndJqvbvMHADXMjgD+s1vI63xXJ0/d4MR
         NQe1owws3gYLdR2xkNp5WOaR+fgBrZlzGSyUm0JmhHhQRQQ0I/fgF0D3vL+YfLXbC2T1
         KVtHJp7D8rMZZz1t/cWQvfiF8eWkLmWorI6SalHtWbimoYOOmk76ry7+ugm4gepXeq77
         XyvPU1g0eHRw8zqTjX5+ImT5eZMPBCuJWkQ1Lq3XIkNY7Jbkp7ldPUO9EH7Jv9V5CTgo
         Lhug==
X-Gm-Message-State: ACrzQf0sgbaU4dxtInVTlrmIfavV6J0nrvGAnmzNuj01RHTgRUlDsBog
        SbolJ5rAmp+zP0/Bg+TFJu+BvD4N5RST5WIg0/XPNxwPMqcm
X-Google-Smtp-Source: AMsMyM5pRm8Z30ukAR3/aIHJzPAp6OxBVyI+b/l5ojhB9dokMKZhkvaqNnHbI5pm0tFphFqIbYGoNWc7ZyawpnAkvXmCRqVNqvD/
MIME-Version: 1.0
X-Received: by 2002:a92:b07:0:b0:300:e141:40cc with SMTP id
 b7-20020a920b07000000b00300e14140ccmr2241867ilf.309.1667513679779; Thu, 03
 Nov 2022 15:14:39 -0700 (PDT)
Date:   Thu, 03 Nov 2022 15:14:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008aa01105ec98487b@google.com>
Subject: [syzbot] possible deadlock in filemap_fault
From:   syzbot <syzbot+7736960b837908f3a81d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=138e3dce880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7736960b837908f3a81d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor.1/6659 is trying to acquire lock:
ffff000117379c70 (mapping.invalidate_lock#4){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
ffff000117379c70 (mapping.invalidate_lock#4){.+.+}-{3:3}, at: filemap_fault+0x104/0x804 mm/filemap.c:3112

but task is already holding lock:
ffff0000c0e10658 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
ffff0000c0e10658 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault+0x1ec/0x79c arch/arm64/mm/fault.c:583

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault+0x7c/0xb4 mm/memory.c:5577
       filldir64+0x1e4/0x56c fs/readdir.c:335
       dir_emit_dot include/linux/fs.h:3547 [inline]
       dir_emit_dots include/linux/fs.h:3558 [inline]
       exfat_iterate+0xd8/0xcd8 fs/exfat/dir.c:231
       iterate_dir+0x114/0x28c
       __do_sys_getdents64 fs/readdir.c:369 [inline]
       __se_sys_getdents64 fs/readdir.c:354 [inline]
       __arm64_sys_getdents64+0x80/0x204 fs/readdir.c:354
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #1 (&sbi->s_lock#3){+.+.}-{3:3}:
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       exfat_get_block+0x6c/0x9ec fs/exfat/inode.c:282
       do_mpage_readpage+0x474/0xd38 fs/mpage.c:208
       mpage_readahead+0xf0/0x1b8 fs/mpage.c:361
       exfat_readahead+0x28/0x38 fs/exfat/inode.c:345
       read_pages+0x74/0x4a0 mm/readahead.c:158
       page_cache_ra_unbounded+0x2cc/0x338 mm/readahead.c:263
       do_page_cache_ra mm/readahead.c:293 [inline]
       page_cache_ra_order+0x348/0x380 mm/readahead.c:550
       ondemand_readahead+0x3cc/0x724 mm/readahead.c:672
       page_cache_sync_ra+0xc4/0xdc mm/readahead.c:699
       page_cache_sync_readahead include/linux/pagemap.h:1215 [inline]
       filemap_get_pages+0x108/0x574 mm/filemap.c:2566
       filemap_read+0x14c/0x6fc mm/filemap.c:2660
       generic_file_read_iter+0x6c/0x25c mm/filemap.c:2806
       call_read_iter include/linux/fs.h:2181 [inline]
       new_sync_read fs/read_write.c:389 [inline]
       vfs_read+0x2d4/0x448 fs/read_write.c:470
       ksys_read+0xb4/0x160 fs/read_write.c:607
       __do_sys_read fs/read_write.c:617 [inline]
       __se_sys_read fs/read_write.c:615 [inline]
       __arm64_sys_read+0x24/0x34 fs/read_write.c:615
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #0 (mapping.invalidate_lock#4){.+.+}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
       filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
       filemap_fault+0x104/0x804 mm/filemap.c:3112
       __do_fault+0x60/0x358 mm/memory.c:4173
       do_read_fault mm/memory.c:4518 [inline]
       do_fault+0x338/0x550 mm/memory.c:4647
       handle_pte_fault mm/memory.c:4911 [inline]
       __handle_mm_fault mm/memory.c:5053 [inline]
       handle_mm_fault+0x784/0xa40 mm/memory.c:5151
       __do_page_fault arch/arm64/mm/fault.c:502 [inline]
       do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:602
       do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:685
       do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:821
       el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:366
       el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:426
       el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
       __arch_copy_from_user+0x94/0x230 arch/arm64/lib/copy_template.S:91
       __sys_bpf+0x1d8/0x5f4 kernel/bpf/syscall.c:4926
       __do_sys_bpf kernel/bpf/syscall.c:5057 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5055 [inline]
       __arm64_sys_bpf+0x2c/0x40 kernel/bpf/syscall.c:5055
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

other info that might help us debug this:

Chain exists of:
  mapping.invalidate_lock#4 --> &sbi->s_lock#3 --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&sbi->s_lock#3);
                               lock(&mm->mmap_lock);
  lock(mapping.invalidate_lock#4);

 *** DEADLOCK ***

1 lock held by syz-executor.1/6659:
 #0: ffff0000c0e10658 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff0000c0e10658 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault+0x1ec/0x79c arch/arm64/mm/fault.c:583

stack backtrace:
CPU: 0 PID: 6659 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2053
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
 filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 filemap_fault+0x104/0x804 mm/filemap.c:3112
 __do_fault+0x60/0x358 mm/memory.c:4173
 do_read_fault mm/memory.c:4518 [inline]
 do_fault+0x338/0x550 mm/memory.c:4647
 handle_pte_fault mm/memory.c:4911 [inline]
 __handle_mm_fault mm/memory.c:5053 [inline]
 handle_mm_fault+0x784/0xa40 mm/memory.c:5151
 __do_page_fault arch/arm64/mm/fault.c:502 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:602
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:685
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:821
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:366
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:426
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:576
 __arch_copy_from_user+0x94/0x230 arch/arm64/lib/copy_template.S:91
 __sys_bpf+0x1d8/0x5f4 kernel/bpf/syscall.c:4926
 __do_sys_bpf kernel/bpf/syscall.c:5057 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5055 [inline]
 __arm64_sys_bpf+0x2c/0x40 kernel/bpf/syscall.c:5055
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
