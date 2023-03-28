Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90046CCAF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 21:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjC1TxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 15:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1TxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:53:15 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8831706
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:53:09 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id 3-20020a6b1403000000b007588213c81aso8292662iou.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680033188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4IIIa2l/718HpTartHrDgnaysXLL10buxkJxJadiB0=;
        b=YZz/tn9KHWlRYUto+7ltCnD6uOHg16HH4JjU8xo4c/opgOFKBGCbRRE+rV9VA9ZoQ5
         fk3dzcLOifwXEB4nXagFIrxtWxKrOz+nru70mZw0xDEA6/R0yRS4rWyq9e+sjFUsxDyY
         /6+t5HbRyfwT5H4XHeis6QOhn1bF0tqEU0mRf/V7UX0ewP7tWGIEeBzAUxlQB1FpoC7C
         JA2MOkU+e6YMZFW/iYOiwWHbX92coZIVtQl6HpTQkmbsEvnLw+1xcgOkcKJdZ3tsuB5K
         Bw3pMbr6RqgGxrqEg/5QTYToDCd5khhPrwhoH1I9QVXWjNjZ2LOQZ2qLMRBXPWvimSQ7
         TfHg==
X-Gm-Message-State: AAQBX9eBwa6JZfdYugUpbSJehHkZ97GIQdoYE4FY+KPw5mOzWMQ45WNo
        lY9cZnmgwfxNXn5LsEs/CSKDpER3VmvUfrRsU1blq1ZLg5Sh
X-Google-Smtp-Source: AKy350ayo+QM0+HyzHTRjgJQhxKQVHeD3NBIJKzol9C66FD512No5njWO7QW/B7Y1iPUzG1OGotWTcpPPhGOxrRSHUqpIDIfq93c
MIME-Version: 1.0
X-Received: by 2002:a02:29c5:0:b0:3c5:14ca:58c6 with SMTP id
 p188-20020a0229c5000000b003c514ca58c6mr680716jap.4.1680033188515; Tue, 28 Mar
 2023 12:53:08 -0700 (PDT)
Date:   Tue, 28 Mar 2023 12:53:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069948205f7fb357f@google.com>
Subject: [syzbot] [fat?] possible deadlock in do_user_addr_fault
From:   syzbot <syzbot+278098b0faaf0595072b@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    3a93e40326c8 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126b5661c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40b592130bb7abb
dashboard link: https://syzkaller.appspot.com/bug?extid=278098b0faaf0595072b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e4e99f83edc/disk-3a93e403.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd7a2ef894d8/vmlinux-3a93e403.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8054ad68a13e/bzImage-3a93e403.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+278098b0faaf0595072b@syzkaller.appspotmail.com

exFAT-fs (loop5): failed to load upcase table (idx : 0x00010000, chksum : 0xac19d315, utbl_chksum : 0xe619d30d)
======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc4-syzkaller-00025-g3a93e40326c8 #0 Not tainted
------------------------------------------------------
syz-executor.5/29002 is trying to acquire lock:
ffff88807c924b98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
ffff88807c924b98 (&mm->mmap_lock){++++}-{3:3}, at: do_user_addr_fault+0xa51/0x1230 arch/x86/mm/fault.c:1358

but task is already holding lock:
ffff88807b0f20e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x111/0xb40 fs/exfat/dir.c:232

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->s_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       exfat_get_block+0x18d/0x16e0 fs/exfat/inode.c:280
       do_mpage_readpage+0x768/0x1960 fs/mpage.c:208
       mpage_readahead+0x344/0x580 fs/mpage.c:356
       read_pages+0x1a2/0xd40 mm/readahead.c:161
       page_cache_ra_unbounded+0x477/0x5e0 mm/readahead.c:270
       do_page_cache_ra mm/readahead.c:300 [inline]
       page_cache_ra_order+0x6ec/0xa00 mm/readahead.c:560
       ondemand_readahead+0x6b3/0x1080 mm/readahead.c:682
       page_cache_sync_ra+0x1c9/0x200 mm/readahead.c:709
       page_cache_sync_readahead include/linux/pagemap.h:1214 [inline]
       filemap_get_pages+0x28d/0x1620 mm/filemap.c:2598
       filemap_read+0x35e/0xc70 mm/filemap.c:2693
       generic_file_read_iter+0x3ad/0x5b0 mm/filemap.c:2840
       __kernel_read+0x2ca/0x830 fs/read_write.c:428
       integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:199
       ima_calc_file_hash_tfm+0x2aa/0x3b0 security/integrity/ima/ima_crypto.c:485
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
       ima_calc_file_hash+0x195/0x4a0 security/integrity/ima/ima_crypto.c:573
       ima_collect_measurement+0x55b/0x670 security/integrity/ima/ima_api.c:293
       process_measurement+0xd2f/0x1930 security/integrity/ima/ima_main.c:341
       ima_file_check+0xba/0x100 security/integrity/ima/ima_main.c:539
       do_open fs/namei.c:3562 [inline]
       path_openat+0x15d3/0x2750 fs/namei.c:3715
       do_filp_open+0x1ba/0x410 fs/namei.c:3742
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1348
       do_sys_open fs/open.c:1364 [inline]
       __do_sys_openat fs/open.c:1380 [inline]
       __se_sys_openat fs/open.c:1375 [inline]
       __x64_sys_openat+0x143/0x1f0 fs/open.c:1375
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (mapping.invalidate_lock#9){.+.+}-{3:3}:
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       filemap_invalidate_lock_shared include/linux/fs.h:813 [inline]
       filemap_fault+0xb99/0x2450 mm/filemap.c:3274
       __do_fault+0x107/0x600 mm/memory.c:4141
       do_read_fault mm/memory.c:4492 [inline]
       do_fault mm/memory.c:4621 [inline]
       handle_pte_fault mm/memory.c:4909 [inline]
       __handle_mm_fault+0x24f3/0x3e60 mm/memory.c:5051
       handle_mm_fault+0x2ba/0x9c0 mm/memory.c:5197
       do_user_addr_fault+0x475/0x1230 arch/x86/mm/fault.c:1407
       handle_page_fault arch/x86/mm/fault.c:1498 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1554
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       do_strncpy_from_user lib/strncpy_from_user.c:41 [inline]
       strncpy_from_user+0x1c1/0x3c0 lib/strncpy_from_user.c:139
       getname_flags.part.0+0x95/0x4f0 fs/namei.c:151
       getname_flags include/linux/audit.h:321 [inline]
       getname+0x92/0xd0 fs/namei.c:219
       do_sys_openat2+0xf5/0x4c0 fs/open.c:1342
       do_sys_open fs/open.c:1364 [inline]
       __do_sys_openat fs/open.c:1380 [inline]
       __se_sys_openat fs/open.c:1375 [inline]
       __x64_sys_openat+0x143/0x1f0 fs/open.c:1375
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       mmap_read_lock include/linux/mmap_lock.h:117 [inline]
       do_user_addr_fault+0xa51/0x1230 arch/x86/mm/fault.c:1358
       handle_page_fault arch/x86/mm/fault.c:1498 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1554
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       filldir+0x1ec/0x680 fs/readdir.c:253
       dir_emit_dot include/linux/fs.h:3144 [inline]
       dir_emit_dots include/linux/fs.h:3155 [inline]
       exfat_iterate+0x56b/0xb40 fs/exfat/dir.c:235
       iterate_dir+0x1fd/0x6f0 fs/readdir.c:67
       __do_sys_getdents fs/readdir.c:286 [inline]
       __se_sys_getdents fs/readdir.c:271 [inline]
       __x64_sys_getdents+0x13e/0x2c0 fs/readdir.c:271
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> mapping.invalidate_lock#9 --> &sbi->s_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_lock);
                               lock(mapping.invalidate_lock#9);
                               lock(&sbi->s_lock);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.5/29002:
 #0: ffff88801e0019e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe7/0x100 fs/file.c:1047
 #1: ffff88803cc2d0b0 (&sb->s_type->i_mutex_key#21){++++}-{3:3}, at: iterate_dir+0x504/0x6f0 fs/readdir.c:57
 #2: ffff88807b0f20e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_iterate+0x111/0xb40 fs/exfat/dir.c:232

stack backtrace:
CPU: 0 PID: 29002 Comm: syz-executor.5 Not tainted 6.3.0-rc4-syzkaller-00025-g3a93e40326c8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain kernel/locking/lockdep.c:3832 [inline]
 __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
 lock_acquire kernel/locking/lockdep.c:5669 [inline]
 lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
 down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 do_user_addr_fault+0xa51/0x1230 arch/x86/mm/fault.c:1358
 handle_page_fault arch/x86/mm/fault.c:1498 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1554
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:filldir+0x1ec/0x680 fs/readdir.c:253
Code: 48 89 c6 48 89 44 24 20 e8 e1 c3 9a ff 48 8b 44 24 20 49 39 c6 0f 87 44 02 00 00 e8 de c7 9a ff 0f 01 cb 0f ae e8 48 8b 04 24 <49> 89 46 08 e8 cb c7 9a ff 4c 8b 74 24 38 48 8b 7c 24 10 49 89 3e
RSP: 0018:ffffc9000b04fc00 EFLAGS: 00050202
RAX: 0000000000000000 RBX: ffffc9000b04fe98 RCX: ffffc90014ab2000
RDX: 0000000000040000 RSI: ffffffff81e81072 RDI: 0000000000000006
RBP: 0000000000000001 R08: 0000000000000006 R09: 0000000020001fc0
R10: 00007fffffffefe8 R11: 0000000000000002 R12: 0000000000000018
R13: ffffffff8a65d5c0 R14: 0000000020001fc0 R15: 0000000000000018
 dir_emit_dot include/linux/fs.h:3144 [inline]
 dir_emit_dots include/linux/fs.h:3155 [inline]
 exfat_iterate+0x56b/0xb40 fs/exfat/dir.c:235
 iterate_dir+0x1fd/0x6f0 fs/readdir.c:67
 __do_sys_getdents fs/readdir.c:286 [inline]
 __se_sys_getdents fs/readdir.c:271 [inline]
 __x64_sys_getdents+0x13e/0x2c0 fs/readdir.c:271
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fead2a8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fead388c168 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007fead2babf80 RCX: 00007fead2a8c0f9
RDX: 00000000000000b8 RSI: 0000000020001fc0 RDI: 0000000000000006
RBP: 00007fead2ae7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc3d6931df R14: 00007fead388c300 R15: 0000000000022000
 </TASK>
exFAT-fs (loop5): error, invalid access to FAT (entry 0x00000005) bogus content (0x91852372)
exFAT-fs (loop5): Filesystem has been set read-only
exFAT-fs (loop5): error, invalid access to FAT (entry 0x00000005) bogus content (0x91852372)
----------------
Code disassembly (best guess):
   0:	48 89 c6             	mov    %rax,%rsi
   3:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   8:	e8 e1 c3 9a ff       	callq  0xff9ac3ee
   d:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  12:	49 39 c6             	cmp    %rax,%r14
  15:	0f 87 44 02 00 00    	ja     0x25f
  1b:	e8 de c7 9a ff       	callq  0xff9ac7fe
  20:	0f 01 cb             	stac
  23:	0f ae e8             	lfence
  26:	48 8b 04 24          	mov    (%rsp),%rax
* 2a:	49 89 46 08          	mov    %rax,0x8(%r14) <-- trapping instruction
  2e:	e8 cb c7 9a ff       	callq  0xff9ac7fe
  33:	4c 8b 74 24 38       	mov    0x38(%rsp),%r14
  38:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  3d:	49 89 3e             	mov    %rdi,(%r14)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
