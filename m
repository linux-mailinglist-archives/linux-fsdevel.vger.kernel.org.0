Return-Path: <linux-fsdevel+bounces-5687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4235080EDD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 14:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A4F1C20AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B465EB6;
	Tue, 12 Dec 2023 13:42:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98860A1
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 05:42:31 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fafc2d40dfso10110696fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 05:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388551; x=1702993351;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQC2VoGpz4KnyayalX4OPROwAGZU1516SRmXs+RaVXM=;
        b=gndglMR4mESJasehLtxuQukcvNUG9eCNB85ibBnFFQCGi/LCIOV6dkoeLppxzlbVOK
         MOBvVKz6Cd+l/q/FxeFU9JU50XtHS/30rEJEXM6SCuwk24U/Zc8BcQTUtUMaJYCiz97g
         2Qew6iPavvBUfjiZdcZaWPaDPwwWcQydX7kx82YQM+2d/KdAZoj/Rb06cUChqulgUBCw
         Qme/dfFD2ormoomN6dcmmdfBZtO09riNB+IcgL/P4Su9Ivrs3eUD1CDJH8wH37+7OO/L
         PeF/VevBdpMtXYklpIRERv5VmdpO9jUc54YjCQTFLlDdpIHMc8M4rPRn9XK3OgiFpLYz
         yJZg==
X-Gm-Message-State: AOJu0Yz7A+DKE9iJUasrNZlbAly4MlRydmCkObaq4tE+qW5IMxbrc/p0
	zAWJwhSkBmx6Xd+F1gDC3fpVO+QzpVZsk9c96mf4kFu4SLN9qhA=
X-Google-Smtp-Source: AGHT+IHRvinaL8erjK4QewnAiEbb6KlxFYX7LfoBKy3cmssVmw5gM03G2DlXp22ZltJtiDxP9R7oRO/hUGr6DoznfXHkCfyg+XxK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:7a9:b0:202:d78c:c4d8 with SMTP id
 o41-20020a05687107a900b00202d78cc4d8mr2472512oap.5.1702388550947; Tue, 12 Dec
 2023 05:42:30 -0800 (PST)
Date: Tue, 12 Dec 2023 05:42:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d95cf9060c5038e3@google.com>
Subject: [syzbot] [hfs?] possible deadlock in hfs_extend_file (2)
From: syzbot <syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1500ff54e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=41a88b825a315aac2254
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af357ba4767f/disk-bee0e776.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae4d50206171/vmlinux-bee0e776.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e12203376a9f/bzImage-bee0e776.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 64
======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc4-syzkaller-00009-gbee0e7762ad2 #0 Not tainted
------------------------------------------------------
syz-executor.5/10381 is trying to acquire lock:
ffff888080716f78 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xff/0x1440 fs/hfs/extent.c:397

but task is already holding lock:
ffff8880396060b0 (&tree->tree_lock#2/1){+.+.}-{3:3}, at: hfs_find_init+0x16e/0x1f0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&tree->tree_lock#2/1){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       hfs_find_init+0x16e/0x1f0
       hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
       hfs_extend_file+0x31b/0x1440 fs/hfs/extent.c:401
       hfs_bmap_reserve+0xd9/0x3f0 fs/hfs/btree.c:234
       hfs_cat_create+0x1e0/0x970 fs/hfs/catalog.c:104
       hfs_create+0x66/0xd0 fs/hfs/dir.c:202
       lookup_open fs/namei.c:3477 [inline]
       open_last_lookups fs/namei.c:3546 [inline]
       path_openat+0x13fa/0x3290 fs/namei.c:3776
       do_filp_open+0x234/0x490 fs/namei.c:3809
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
       do_sys_open fs/open.c:1455 [inline]
       __do_sys_openat fs/open.c:1471 [inline]
       __se_sys_openat fs/open.c:1466 [inline]
       __x64_sys_openat+0x247/0x290 fs/open.c:1466
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #0 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       hfs_extend_file+0xff/0x1440 fs/hfs/extent.c:397
       hfs_bmap_reserve+0xd9/0x3f0 fs/hfs/btree.c:234
       __hfs_ext_write_extent+0x22e/0x4f0 fs/hfs/extent.c:121
       __hfs_ext_cache_extent+0x6a/0x990 fs/hfs/extent.c:174
       hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
       hfs_extend_file+0x344/0x1440 fs/hfs/extent.c:401
       hfs_get_block+0x3e4/0xb60 fs/hfs/extent.c:353
       __block_write_begin_int+0x54d/0x1ad0 fs/buffer.c:2119
       __block_write_begin fs/buffer.c:2168 [inline]
       block_write_begin+0x9b/0x1e0 fs/buffer.c:2227
       cont_write_begin+0x643/0x880 fs/buffer.c:2582
       hfs_write_begin+0x8a/0xd0 fs/hfs/inode.c:58
       generic_perform_write+0x31b/0x630 mm/filemap.c:3918
       generic_file_write_iter+0xaf/0x310 mm/filemap.c:4039
       call_write_iter include/linux/fs.h:2020 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x792/0xb20 fs/read_write.c:584
       ksys_write+0x1a0/0x2c0 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tree->tree_lock#2/1);
                               lock(&HFS_I(tree->inode)->extents_lock);
                               lock(&tree->tree_lock#2/1);
  lock(&HFS_I(tree->inode)->extents_lock);

 *** DEADLOCK ***

5 locks held by syz-executor.5/10381:
 #0: ffff888018664fc8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x2b0/0x340 fs/file.c:1177
 #1: ffff88807234c418 (sb_writers#20){.+.+}-{0:0}, at: vfs_write+0x223/0xb20 fs/read_write.c:580
 #2: ffff888080715da8 (&sb->s_type->i_mutex_key#28){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #2: ffff888080715da8 (&sb->s_type->i_mutex_key#28){+.+.}-{3:3}, at: generic_file_write_iter+0x83/0x310 mm/filemap.c:4036
 #3: ffff888080715bf8 (&HFS_I(inode)->extents_lock#2){+.+.}-{3:3}, at: hfs_extend_file+0xff/0x1440 fs/hfs/extent.c:397
 #4: ffff8880396060b0 (&tree->tree_lock#2/1){+.+.}-{3:3}, at: hfs_find_init+0x16e/0x1f0

stack backtrace:
CPU: 1 PID: 10381 Comm: syz-executor.5 Not tainted 6.7.0-rc4-syzkaller-00009-gbee0e7762ad2 #0
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
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
 hfs_extend_file+0xff/0x1440 fs/hfs/extent.c:397
 hfs_bmap_reserve+0xd9/0x3f0 fs/hfs/btree.c:234
 __hfs_ext_write_extent+0x22e/0x4f0 fs/hfs/extent.c:121
 __hfs_ext_cache_extent+0x6a/0x990 fs/hfs/extent.c:174
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_extend_file+0x344/0x1440 fs/hfs/extent.c:401
 hfs_get_block+0x3e4/0xb60 fs/hfs/extent.c:353
 __block_write_begin_int+0x54d/0x1ad0 fs/buffer.c:2119
 __block_write_begin fs/buffer.c:2168 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2227
 cont_write_begin+0x643/0x880 fs/buffer.c:2582
 hfs_write_begin+0x8a/0xd0 fs/hfs/inode.c:58
 generic_perform_write+0x31b/0x630 mm/filemap.c:3918
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4039
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x792/0xb20 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f8f6167cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8f6230d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8f6179bf80 RCX: 00007f8f6167cae9
RDX: 00000000000ffe00 RSI: 0000000020004200 RDI: 0000000000000004
RBP: 00007f8f616c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8f6179bf80 R15: 00007ffcca30fd58
 </TASK>


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

