Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF12C5F4693
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 17:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJDPXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 11:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiJDPXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:23:37 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D875FDFC
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Oct 2022 08:23:36 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id j20-20020a6b3114000000b006a3211a0ff0so9072285ioa.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Oct 2022 08:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Tx70LnHgrcbySmYB773/hUxSj1SSVjuJS/a66PMZEsM=;
        b=eHFaOHmt/I4c+XcnVFIt+xMp+g/ibaZgaDyH4KHhCmSB2yiAECpGwqgexa25MG2K0P
         Mtc1J5KrRgi6rCQJLjEUEXNAlCpxbIAdcHbz/Kjx+NHDURiahWKPxxCfuJrfgdRJMtDe
         l3QtmJ1Kb1N+HFOS5W4N0n/OIqa9PJC4duCCjzTEVRyMiCeNTO77hUr/6vMEqeX7q1eF
         t+GPDcKT2AinTj33zjq+I7aNuIGyDqG6TC/0xfeuSaHdBMAXRc+3gAEz4GFigji92el9
         prYP11hqjuHGiQap8UKb6Z3zEL7E5hOFX3Uxoj5XX12lHRIDI1++zxnwFOukr7u1PyU3
         DB8A==
X-Gm-Message-State: ACrzQf3CLICR2Y4VygQNrJwP8oz3YjTVHmT9ncfgSXjYYxbfDxVhRgGp
        MPrB/aCDsLG55sNpmvEI0vVhegqP5iK12YbHQHVHOseHCKhl
X-Google-Smtp-Source: AMsMyM6j7Ur7/oUmN7yWxJ+ucCyDplXOYKtcziG2PTnNGru8ehU0o5wAwQv9X7ioK257YqLI0hI+684KFfkq5921FmTsIZJEnLiQ
MIME-Version: 1.0
X-Received: by 2002:a02:5108:0:b0:35a:eca0:92c1 with SMTP id
 s8-20020a025108000000b0035aeca092c1mr13154892jaa.81.1664897015554; Tue, 04
 Oct 2022 08:23:35 -0700 (PDT)
Date:   Tue, 04 Oct 2022 08:23:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033295305ea370bb5@google.com>
Subject: [syzbot] possible deadlock in exfat_iterate
From:   syzbot <syzbot+38655f1298fefc58a904@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12781dbc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aae2d21e7dd80684
dashboard link: https://syzkaller.appspot.com/bug?extid=38655f1298fefc58a904
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11078f50b80b/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/398e5f1e6c84/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38655f1298fefc58a904@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor.5/7308 is trying to acquire lock:
ffff000109945b58 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x54/0xb4 mm/memory.c:5576

but task is already holding lock:
ffff00010d89e0e0 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_iterate+0x74/0xcd8 fs/exfat/dir.c:228

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->s_lock#2){+.+.}-{3:3}:
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
       generic_file_splice_read+0xa0/0x1c8 fs/splice.c:309
       do_splice_to fs/splice.c:793 [inline]
       splice_direct_to_actor+0x16c/0x3e4 fs/splice.c:865
       do_splice_direct+0xc4/0x14c fs/splice.c:974
       do_sendfile+0x298/0x68c fs/read_write.c:1249
       __do_sys_sendfile64 fs/read_write.c:1317 [inline]
       __se_sys_sendfile64 fs/read_write.c:1303 [inline]
       __arm64_sys_sendfile64+0xb0/0x230 fs/read_write.c:1303
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #1 (mapping.invalidate_lock#3){.+.+}-{3:3}:
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
       do_strncpy_from_user lib/strncpy_from_user.c:41 [inline]
       strncpy_from_user+0x1a8/0x3d8 lib/strncpy_from_user.c:139
       getname_flags+0x84/0x278 fs/namei.c:150
       getname+0x28/0x38 fs/namei.c:218
       do_sys_openat2+0x78/0x22c fs/open.c:1307
       do_sys_open fs/open.c:1329 [inline]
       __do_sys_openat fs/open.c:1345 [inline]
       __se_sys_openat fs/open.c:1340 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
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

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> mapping.invalidate_lock#3 --> &sbi->s_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_lock#2);
                               lock(mapping.invalidate_lock#3);
                               lock(&sbi->s_lock#2);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.5/7308:
 #0: ffff0000c71e8ce8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x12c/0x154 fs/file.c:1036
 #1: ffff0001091738f8 (&sb->s_type->i_mutex_key#21){++++}-{3:3}, at: iterate_dir+0xb8/0x28c fs/readdir.c:57
 #2: ffff00010d89e0e0 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_iterate+0x74/0xcd8 fs/exfat/dir.c:228

stack backtrace:
CPU: 1 PID: 7308 Comm: syz-executor.5 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
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


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
