Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472E9652DC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 09:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiLUIQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 03:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiLUIPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:15:49 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C726374
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 00:15:46 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id g3-20020a056e021a2300b00305e3da9585so9729016ile.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 00:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMzPRxOPZqhngdN1cZmIq8P1MO04u/BexRoyy50ugc0=;
        b=iZmyCT3BuA8RhjqCoiqbOQNYkS1eBnkJDSe1wmvVNENavlZzAiN21YbzUNfPWzHMZq
         vPxCLqPUNhFjT/vFMvgWjbhs/npBTLzAAOXC2wuvPy7UArP9ArGR7ditJVKyQhjr8pEx
         QD+4N3vKHGB3KBE1DBFlEK1bOLxDeHyhFC29oPpXcQL5plj5B7IBuhWEFGKCcrk68NFo
         m0Exyjr2slE0nUmARfoSxAfNzBiuMWm6PWMymSD7XsUk3a/nNdMT498Ob90Gq6SIVe4H
         8lPsoo0Svlu5lXPoTvx4uk2cISi7vYVoh79xEKb1h7hqN+3bmPUvGn/jTdZ1UOL1Twwo
         oPDA==
X-Gm-Message-State: AFqh2kqjO4RBOjraILoAFq9rbI+hTF/gg2Gm29OcM/u4T3l0HtcFH/bN
        zuR+gttaz1ohoBooczleCRpLhzYXYHbd5ZZjP6xDxc4AuffE
X-Google-Smtp-Source: AMrXdXuqAeEJW/YmlRJHpE1A0vEZhXOkM30EfuEpFQqt88nO7mdzMlR2OfZ8SLhYv/H26aIcJgjOSF74UuK6wHvrfhsaHlfag93E
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c61:b0:302:a229:3090 with SMTP id
 f1-20020a056e020c6100b00302a2293090mr117861ilj.90.1671610546257; Wed, 21 Dec
 2022 00:15:46 -0800 (PST)
Date:   Wed, 21 Dec 2022 00:15:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0021505f0522813@google.com>
Subject: [syzbot] possible deadlock in page_cache_ra_unbounded
From:   syzbot <syzbot+47c7e14e1bd09234d0ad@syzkaller.appspotmail.com>
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

HEAD commit:    6feb57c2fd7c Merge tag 'kbuild-v6.2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13abf993880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3fb546de56fbf8d
dashboard link: https://syzkaller.appspot.com/bug?extid=47c7e14e1bd09234d0ad
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81556e491789/disk-6feb57c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/065c943ec9de/vmlinux-6feb57c2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66e98c522c1f/bzImage-6feb57c2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47c7e14e1bd09234d0ad@syzkaller.appspotmail.com

REISERFS (device loop4): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.1.0-syzkaller-13822-g6feb57c2fd7c #0 Not tainted
------------------------------------------------------
syz-executor.4/3542 is trying to acquire lock:
ffff88803bf4f520 (mapping.invalidate_lock#11){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
ffff88803bf4f520 (mapping.invalidate_lock#11){.+.+}-{3:3}, at: page_cache_ra_unbounded+0xe9/0x820 mm/readahead.c:226

but task is already holding lock:
ffff88802540e090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
       reiserfs_get_block+0x24e/0x5180 fs/reiserfs/inode.c:680
       do_mpage_readpage+0x970/0x1c50 fs/mpage.c:208
       mpage_readahead+0x210/0x380 fs/mpage.c:361
       read_pages+0x169/0x9c0 mm/readahead.c:161
       page_cache_ra_unbounded+0x703/0x820 mm/readahead.c:270
       page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
       filemap_get_pages+0x465/0x10d0 mm/filemap.c:2600
       filemap_read+0x3cf/0xea0 mm/filemap.c:2694
       call_read_iter include/linux/fs.h:2180 [inline]
       generic_file_splice_read+0x1ff/0x5d0 fs/splice.c:309
       do_splice_to fs/splice.c:793 [inline]
       splice_direct_to_actor+0x41b/0xc00 fs/splice.c:865
       do_splice_direct+0x279/0x3d0 fs/splice.c:974
       do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
       __do_sys_sendfile64 fs/read_write.c:1323 [inline]
       __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (mapping.invalidate_lock#11){.+.+}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read+0x39/0x50 kernel/locking/rwsem.c:1509
       filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
       page_cache_ra_unbounded+0xe9/0x820 mm/readahead.c:226
       do_sync_mmap_readahead+0x4b2/0x9a0
       filemap_fault+0x38d/0x1060 mm/filemap.c:3154
       __do_fault+0x136/0x4f0 mm/memory.c:4163
       do_shared_fault mm/memory.c:4569 [inline]
       do_fault mm/memory.c:4647 [inline]
       handle_pte_fault mm/memory.c:4931 [inline]
       __handle_mm_fault mm/memory.c:5073 [inline]
       handle_mm_fault+0x18bc/0x26b0 mm/memory.c:5219
       do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
       __put_user_4+0x12/0x20 arch/x86/lib/putuser.S:93
       reiserfs_ioctl+0x14b/0x340 fs/reiserfs/ioctl.c:96
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->lock);
                               lock(mapping.invalidate_lock#11);
                               lock(&sbi->lock);
  lock(mapping.invalidate_lock#11);

 *** DEADLOCK ***

1 lock held by syz-executor.4/3542:
 #0: ffff88802540e090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27

stack backtrace:
CPU: 1 PID: 3542 Comm: syz-executor.4 Not tainted 6.1.0-syzkaller-13822-g6feb57c2fd7c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 down_read+0x39/0x50 kernel/locking/rwsem.c:1509
 filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 page_cache_ra_unbounded+0xe9/0x820 mm/readahead.c:226
 do_sync_mmap_readahead+0x4b2/0x9a0
 filemap_fault+0x38d/0x1060 mm/filemap.c:3154
 __do_fault+0x136/0x4f0 mm/memory.c:4163
 do_shared_fault mm/memory.c:4569 [inline]
 do_fault mm/memory.c:4647 [inline]
 handle_pte_fault mm/memory.c:4931 [inline]
 __handle_mm_fault mm/memory.c:5073 [inline]
 handle_mm_fault+0x18bc/0x26b0 mm/memory.c:5219
 do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:__put_user_4+0x12/0x20 arch/x86/lib/putuser.S:95
Code: 01 31 c9 0f 01 ca c3 90 0f 01 cb 66 89 01 31 c9 0f 01 ca c3 0f 1f 40 00 48 bb fd ef ff ff ff 7f 00 00 48 39 d9 73 54 0f 01 cb <89> 01 31 c9 0f 01 ca c3 66 0f 1f 44 00 00 0f 01 cb 89 01 31 c9 0f
RSP: 0018:ffffc90014c97eb0 EFLAGS: 00050297
RAX: 0000000000000000 RBX: 00007fffffffeffd RCX: 0000000020000000
RDX: 0000000000000001 RSI: ffffffff8aedcc60 RDI: ffffffff8b4bc060
RBP: 1ffff110077e9e4b R08: dffffc0000000000 R09: fffffbfff1d2ccfe
R10: fffffbfff1d2ccfe R11: 1ffffffff1d2ccfd R12: 0000000020000000
R13: ffff88803bf4f698 R14: ffff88803bf4f258 R15: ffff8880205c9400
 reiserfs_ioctl+0x14b/0x340 fs/reiserfs/ioctl.c:96
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0a0548c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0a061d5168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0a055abf80 RCX: 00007f0a0548c0d9
RDX: 0000000020000000 RSI: 0000000080087601 RDI: 0000000000000004
RBP: 00007f0a054e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc8aa2e79f R14: 00007f0a061d5300 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	01 31                	add    %esi,(%rcx)
   2:	c9                   	leaveq
   3:	0f 01 ca             	clac
   6:	c3                   	retq
   7:	90                   	nop
   8:	0f 01 cb             	stac
   b:	66 89 01             	mov    %ax,(%rcx)
   e:	31 c9                	xor    %ecx,%ecx
  10:	0f 01 ca             	clac
  13:	c3                   	retq
  14:	0f 1f 40 00          	nopl   0x0(%rax)
  18:	48 bb fd ef ff ff ff 	movabs $0x7fffffffeffd,%rbx
  1f:	7f 00 00
  22:	48 39 d9             	cmp    %rbx,%rcx
  25:	73 54                	jae    0x7b
  27:	0f 01 cb             	stac
* 2a:	89 01                	mov    %eax,(%rcx) <-- trapping instruction
  2c:	31 c9                	xor    %ecx,%ecx
  2e:	0f 01 ca             	clac
  31:	c3                   	retq
  32:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  38:	0f 01 cb             	stac
  3b:	89 01                	mov    %eax,(%rcx)
  3d:	31 c9                	xor    %ecx,%ecx
  3f:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
