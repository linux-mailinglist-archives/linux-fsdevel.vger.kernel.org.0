Return-Path: <linux-fsdevel+bounces-1010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3730F7D4D2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 12:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639931C20A1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4022250F1;
	Tue, 24 Oct 2023 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D171250E5
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 10:02:57 +0000 (UTC)
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D07EA
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 03:02:55 -0700 (PDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1e987fa0d87so5886072fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 03:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141774; x=1698746574;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vn0NoukJxAfZILvdsW+icS2xMfxi5fKAUjTvJNIqGUY=;
        b=Gem3H+5AqLsbOvJlXCo0vjZNNa8NcikcmN3nfAVjxHEej94GCh/i8Ykzz/4sX3QpMd
         qaKGy3mBOHhfekAJmXbyF8G3rYr4FRjozHxTTQlHxp36MWFR9IvtA9YQk40u6fwhfXVI
         2KE2bl1wh3F62euxYffUbaOxDc6znySl4buye2+jYZQgEDemZXHER8AX/5E7QcteFvsH
         XLXQ0UfJ0DXSXBEGfOoAL8Mzk5u9G5Tj3lAxqt1dauQjbQyRyhmMqfIgxAeqhBy8FMaR
         dCq+5MSQ8IXuhpuhBgkM26eBJcmPGc9tToQIwhKY1TfDFSAzhUmBp8b362FPYV1cs/V4
         x0yQ==
X-Gm-Message-State: AOJu0YwFvvd3xIo5wIJlVkYRJrjhdyKenepLaRJhmAXAlHqujsXKmVhu
	/Hs8xqJ+BW+h/1o/fOUNQYup+SEDTwmgjoIX7gFkFIY6S/5S
X-Google-Smtp-Source: AGHT+IGHhYm8RudYIBehaCc/J2WJHkqOLHGrUFdReEuwG4sAlvAFt8AhkmU5dW0ni+Q5yLBUZOSxzdGWvD9Grkji+80fry44dWAX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:148d:b0:1d6:5e45:3bc7 with SMTP id
 k13-20020a056870148d00b001d65e453bc7mr5668205oab.5.1698141774531; Tue, 24 Oct
 2023 03:02:54 -0700 (PDT)
Date: Tue, 24 Oct 2023 03:02:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fd455060873718b@google.com>
Subject: [syzbot] [ntfs3?] WARNING in sys_pivot_root
From: syzbot <syzbot+a76a065ad30c6ddea4a1@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ce55c22ec8b2 Merge tag 'net-6.6-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c0c24d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
dashboard link: https://syzkaller.appspot.com/bug?extid=a76a065ad30c6ddea4a1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e511bd680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6762ae43666/disk-ce55c22e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b2c191a2c66/vmlinux-ce55c22e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/931e7d3d48a1/bzImage-ce55c22e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/60186123065f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a76a065ad30c6ddea4a1@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888066862f70, owner = 0x0, curr 0xffff88807d629dc0, list empty
WARNING: CPU: 1 PID: 9840 at kernel/locking/rwsem.c:1370 __up_write kernel/locking/rwsem.c:1369 [inline]
WARNING: CPU: 1 PID: 9840 at kernel/locking/rwsem.c:1370 up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Modules linked in:
CPU: 1 PID: 9840 Comm: syz-executor.5 Not tainted 6.6.0-rc6-syzkaller-00182-gce55c22ec8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Code: 48 c7 c7 a0 98 0a 8b 48 c7 c6 e0 9a 0a 8b 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 53 e8 e0 e9 e7 ff 48 83 c4 08 <0f> 0b e9 75 fd ff ff 48 c7 c1 90 dd 99 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc9000b3ffca0 EFLAGS: 00010296
RAX: da70038a13777500 RBX: ffffffff8b0a9980 RCX: ffff88807d629dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000b3ffd70 R08: ffffffff81543302 R09: 1ffff9200167fee8
R10: dffffc0000000000 R11: fffff5200167fee9 R12: 0000000000000000
R13: ffff888066862f70 R14: 1ffff9200167ff9c R15: dffffc0000000000
FS:  00007f0d80dfe6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ea5934000 CR3: 0000000073a48000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:807 [inline]
 unlock_mount fs/namespace.c:2508 [inline]
 __do_sys_pivot_root fs/namespace.c:4252 [inline]
 __se_sys_pivot_root+0x591/0x1650 fs/namespace.c:4166
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0d81a7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0d80dfe0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000009b
RAX: ffffffffffffffda RBX: 00007f0d81b9c050 RCX: 00007f0d81a7cae9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00007f0d81ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0d81b9c050 R15: 00007ffdbee6f518
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

