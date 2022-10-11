Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DAE5FB6B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiJKPOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 11:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiJKPON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:14:13 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27EE9AFAE
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 08:06:10 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id j20-20020a6b3114000000b006a3211a0ff0so9310479ioa.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 08:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BH+QLa3IouPYJb2ya7X2kzWkicu/Pywo1IKU6QH/caU=;
        b=o/byu78u+7zsP9nsUUYl+b0eDU8xOQ1DRiM/09MF4NKtI/q/QsT4bWIFJa/GOd2Sqk
         JnyR07AcrjZlideFGaVlg4Pj0AFR3fFVOlkLevUXTQG5p7ZiSYUgFiDxgkR5Eir4HRYM
         IgRGkGVgmH5mEXL2cV1efWc0rcyOVMrFeppSV01CTwEhVHhw7imDXvNkZYYk4imhRAD8
         nYOEaAtiEREoifB5Ntc3RBlqAIpECv3FKga/RcKe+LFWh4EHMxJAGKamr0rVxSb6tyJc
         D+e7rupr7O7cuB7yn/H4kRMk3TBXlyR4ls3tAqGbdSV3SkXCwreJ14TI8M5c9oCzIui8
         Mhwg==
X-Gm-Message-State: ACrzQf0iKFv5tyeIPkKxEXxN+1XU34j5mgeTnHnSCyPqJburIXKIY3Ap
        a4nAs/z3eLfLZ9cdwGAOeBjYxIuVBlZ5oPgGZu+1ajnRkDt+
X-Google-Smtp-Source: AMsMyM65VeU5FwdHDNemXjcYsCRofx0Du0icxoRBwzkkkCbcptPWDTE45ILoj/62+SPMgb2ZRALx3FqANBbbX52tRzlGaVcbNgiO
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3181:b0:35b:a719:6675 with SMTP id
 z1-20020a056638318100b0035ba7196675mr13456315jak.203.1665500680766; Tue, 11
 Oct 2022 08:04:40 -0700 (PDT)
Date:   Tue, 11 Oct 2022 08:04:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073500205eac39838@google.com>
Subject: [syzbot] possible deadlock in exfat_get_block
From:   syzbot <syzbot+247e66a2c3ea756332c7@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16c2cd84880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=247e66a2c3ea756332c7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+247e66a2c3ea756332c7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor.4/3569 is trying to acquire lock:
ffff0000edcdd0e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_get_block+0x6c/0x9ec fs/exfat/inode.c:282

but task is already holding lock:
ffff0001036340a0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
ffff0001036340a0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x5c/0x338 mm/readahead.c:220

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (mapping.invalidate_lock#3){.+.+}-{3:3}:
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
       __arch_copy_from_user+0xb8/0x230 arch/arm64/lib/copy_template.S:110
       copy_from_iter include/linux/uio.h:184 [inline]
       copy_from_iter_full include/linux/uio.h:191 [inline]
       memcpy_from_msg include/linux/skbuff.h:3959 [inline]
       netlink_sendmsg+0x394/0x584 net/netlink/af_netlink.c:1906
       sock_sendmsg_nosec net/socket.c:714 [inline]
       sock_sendmsg net/socket.c:734 [inline]
       sock_write_iter+0x140/0x1bc net/socket.c:1108
       call_write_iter include/linux/fs.h:2187 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x2dc/0x46c fs/read_write.c:578
       ksys_write+0xb4/0x160 fs/read_write.c:631
       __do_sys_write fs/read_write.c:643 [inline]
       __se_sys_write fs/read_write.c:640 [inline]
       __arm64_sys_write+0x24/0x34 fs/read_write.c:640
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #1 (&mm->mmap_lock){++++}-{3:3}:
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

-> #0 (&sbi->s_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
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
       __kernel_read+0x128/0x2cc fs/read_write.c:428
       kernel_read+0xb8/0x150 fs/read_write.c:446
       prepare_binprm fs/exec.c:1657 [inline]
       search_binary_handler fs/exec.c:1711 [inline]
       exec_binprm+0x1c8/0x670 fs/exec.c:1768
       bprm_execve+0x334/0x404 fs/exec.c:1837
       do_execveat_common+0x57c/0x5e4 fs/exec.c:1942
       do_execve fs/exec.c:2016 [inline]
       __do_sys_execve fs/exec.c:2092 [inline]
       __se_sys_execve fs/exec.c:2087 [inline]
       __arm64_sys_execve+0x44/0x58 fs/exec.c:2087
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

other info that might help us debug this:

Chain exists of:
  &sbi->s_lock --> &mm->mmap_lock --> mapping.invalidate_lock#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(mapping.invalidate_lock#3);
                               lock(&mm->mmap_lock);
                               lock(mapping.invalidate_lock#3);
  lock(&sbi->s_lock);

 *** DEADLOCK ***

2 locks held by syz-executor.4/3569:
 #0: ffff0000c659c3d0 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: prepare_bprm_creds fs/exec.c:1470 [inline]
 #0: ffff0000c659c3d0 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+0x48/0x404 fs/exec.c:1805
 #1: ffff0001036340a0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #1: ffff0001036340a0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x5c/0x338 mm/readahead.c:220

stack backtrace:
CPU: 0 PID: 3569 Comm: syz-executor.4 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
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
 __kernel_read+0x128/0x2cc fs/read_write.c:428
 kernel_read+0xb8/0x150 fs/read_write.c:446
 prepare_binprm fs/exec.c:1657 [inline]
 search_binary_handler fs/exec.c:1711 [inline]
 exec_binprm+0x1c8/0x670 fs/exec.c:1768
 bprm_execve+0x334/0x404 fs/exec.c:1837
 do_execveat_common+0x57c/0x5e4 fs/exec.c:1942
 do_execve fs/exec.c:2016 [inline]
 __do_sys_execve fs/exec.c:2092 [inline]
 __se_sys_execve fs/exec.c:2087 [inline]
 __arm64_sys_execve+0x44/0x58 fs/exec.c:2087
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
