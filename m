Return-Path: <linux-fsdevel+bounces-5688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C372A80EDDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 14:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F5A281757
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1086ABAD;
	Tue, 12 Dec 2023 13:43:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C41AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 05:43:28 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b9f1f500c1so6182487b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 05:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388607; x=1702993407;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdYinHltukW8CnlXiiCghVX4rn+MwlvSQZ7TLJvRxAU=;
        b=LRjxtCZs5NnZFEVsPtubRbM8+X4imO1X3FANhYZMYrB5JWf/8slyN0CFB6YqunuRyv
         MIK8pGvluHMCI85cU0oHfmY1RdJAkJtJJ9NZ5+ZPyAgaqDNwCFMUln6ZU44+eEAs+Bqw
         FCIPdHulRHDMpjHDoU6ZTgJDfSaZoLwWFUkNYfwfC61jULuBp2fvfk1iVVOgZivIwrAq
         ml2BrQZYMsebp20V3PwY4opFhU+VkuXPmTHdMvPbUmX1XT0lm7LmtsZPri/0U3cXnj8G
         nxlWvxVzaPAOd1ierwXBSRJM4JXi7k5EUxH+b3pWLP8psMYmVO1VjcK4PmHsrYkSARW8
         brQQ==
X-Gm-Message-State: AOJu0YyM65eCibWEhuz9qaDS9REX4EklaSOPYxTpOW/B4y5u5PpGo0DO
	h9p1MHa7GDS3Xpfkj9UcOF5E1Un/QdK+sH+l5DXiISUYrieYy6c=
X-Google-Smtp-Source: AGHT+IGD6hieEK+mL13h/hdTHCo4Afue6351WU03oB8WpJ+9Z3bZGCFLxmFWrW3x4/G9qJR6kkA7ZpF5poDdzZYW6jYQzau04wTe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:208a:b0:3b9:ee89:5423 with SMTP id
 s10-20020a056808208a00b003b9ee895423mr6160957oiw.7.1702388607728; Tue, 12 Dec
 2023 05:43:27 -0800 (PST)
Date: Tue, 12 Dec 2023 05:43:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bc381060c503c07@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in reiserfs_get_block (2)
From: syzbot <syzbot+d5cbfdc994a7376f6088@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c07130e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=d5cbfdc994a7376f6088
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af357ba4767f/disk-bee0e776.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae4d50206171/vmlinux-bee0e776.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e12203376a9f/bzImage-bee0e776.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5cbfdc994a7376f6088@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc4-syzkaller-00009-gbee0e7762ad2 #0 Not tainted
------------------------------------------------------
syz-executor.5/31398 is trying to acquire lock:
ffff88802a4c3aa0 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0xa5/0x120 mm/memory.c:5955

but task is already holding lock:
ffff888021256090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x7a/0xd0 fs/reiserfs/lock.c:27

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->lock){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       reiserfs_write_lock+0x7a/0xd0 fs/reiserfs/lock.c:27
       reiserfs_get_block+0x280/0x5130 fs/reiserfs/inode.c:680
       do_mpage_readpage+0x90c/0x1f60 fs/mpage.c:233
       mpage_readahead+0x44f/0x930 fs/mpage.c:381
       read_pages+0x183/0x830 mm/readahead.c:160
       page_cache_ra_unbounded+0x68e/0x7c0 mm/readahead.c:269
       page_cache_sync_readahead include/linux/pagemap.h:1283 [inline]
       filemap_get_pages+0x49c/0x2080 mm/filemap.c:2497
       filemap_read+0x41b/0xec0 mm/filemap.c:2593
       call_read_iter include/linux/fs.h:2014 [inline]
       new_sync_read fs/read_write.c:389 [inline]
       vfs_read+0x78b/0xb00 fs/read_write.c:470
       ksys_read+0x1a0/0x2c0 fs/read_write.c:613
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #1 (mapping.invalidate_lock#10){.+.+}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       filemap_invalidate_lock_shared include/linux/fs.h:857 [inline]
       filemap_fault+0x646/0x1670 mm/filemap.c:3225
       __do_fault+0x133/0x4e0 mm/memory.c:4265
       do_read_fault mm/memory.c:4628 [inline]
       do_fault mm/memory.c:4762 [inline]
       do_pte_missing mm/memory.c:3730 [inline]
       handle_pte_fault mm/memory.c:5038 [inline]
       __handle_mm_fault mm/memory.c:5179 [inline]
       handle_mm_fault+0x4c9b/0x6680 mm/memory.c:5344
       do_user_addr_fault arch/x86/mm/fault.c:1413 [inline]
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x2ad/0x870 arch/x86/mm/fault.c:1561
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       strncpy_from_user+0x111/0x2e0 lib/strncpy_from_user.c:139
       getname_flags+0xf9/0x4f0 fs/namei.c:151
       do_sys_openat2+0xd2/0x1d0 fs/open.c:1434
       do_sys_open fs/open.c:1455 [inline]
       __do_sys_openat fs/open.c:1471 [inline]
       __se_sys_openat fs/open.c:1466 [inline]
       __x64_sys_openat+0x247/0x290 fs/open.c:1466
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __might_fault+0xc1/0x120 mm/memory.c:5955
       reiserfs_ioctl+0x125/0x2f0 fs/reiserfs/ioctl.c:96
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> mapping.invalidate_lock#10 --> &sbi->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->lock);
                               lock(mapping.invalidate_lock#10);
                               lock(&sbi->lock);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz-executor.5/31398:
 #0: ffff888021256090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x7a/0xd0 fs/reiserfs/lock.c:27

stack backtrace:
CPU: 0 PID: 31398 Comm: syz-executor.5 Not tainted 6.7.0-rc4-syzkaller-00009-gbee0e7762ad2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x366/0x490 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 __might_fault+0xc1/0x120 mm/memory.c:5955
 reiserfs_ioctl+0x125/0x2f0 fs/reiserfs/ioctl.c:96
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f820207cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8202d850c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f820219c050 RCX: 00007f820207cae9
RDX: 00000000200001c0 RSI: 0000000080087601 RDI: 0000000000000004
RBP: 00007f82020c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f820219c050 R15: 00007fff4ebdfa68
 </TASK>
REISERFS warning: reiserfs-5093 is_leaf: item entry count seems wrong *3.5*[2 4106500 0(1) DIR], item_len 35, item_location 3245, free_space(entry_count) 2
REISERFS error (device loop5): vs-5150 search_by_key: invalid format found in block 540. Fsck?
REISERFS (device loop5): Remounting filesystem read-only
REISERFS error (device loop5): vs-13050 reiserfs_update_sd_size: i/o failure occurred trying to update [2 4106500 0x0 SD] stat data


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

