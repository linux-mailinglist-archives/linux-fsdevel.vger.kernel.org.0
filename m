Return-Path: <linux-fsdevel+bounces-3449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52F7F4B4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 16:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7547AB20F27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B0B56B68;
	Wed, 22 Nov 2023 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CE4272D
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 07:43:24 -0800 (PST)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1cf644b090cso39724075ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 07:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667804; x=1701272604;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWVwyNQEDfvaOtWm2dnHqh31z5AnRQ95a3YCW/ap4Xo=;
        b=S31Gs+bBpIaGnPJEq9w4l9Kbzp240edJgBPMZQmjOAqT6+VTzCvEo9MJFG1LKXeiSJ
         BzUlXcOAgEZhWv7HkBfIegH5PUDZx1N4MtNoYOMaN9MkLbTdPyQnGnUyyYs09gQd/RJs
         RVpEDXZ86iMhdHwl51SY4h+2OMGIZ+kEGdsZyYHr3yJZNjogs8wA8SbYBk6oxMscVv5p
         09psEvQzE+9zx1mLs5jDxEXza0gmZdc/due0enoqcvtXjQhxobZCwg1MthFvQSUjHPgz
         vL2zhcgzT7WapGENvK4cIhQft8kncXjidaJOagMxA9G1sczWbqAAQJWcYLu4GHhTT4mp
         JMtg==
X-Gm-Message-State: AOJu0Ywl5PoAseHO8VQWTbjIghcVW6Rxh1TM3Cup18uOHDtShnHYdyH2
	mK7t3arq07XD16Rxrk7HHcIxa+yuCGbmXo0Cgi2+vplyYCc2YW53fw==
X-Google-Smtp-Source: AGHT+IGilZWxCKJSlxhhHl2+1QTqPEAVF968tnpuhYXMHjC17woOEVJfeu4C2jfWjOFIy5tsgtd/PNw4+e/O683gyE6lT00+hOEY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:9896:b0:1cc:3355:9fa9 with SMTP id
 s22-20020a170902989600b001cc33559fa9mr558766plp.10.1700667804379; Wed, 22 Nov
 2023 07:43:24 -0800 (PST)
Date: Wed, 22 Nov 2023 07:43:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c72b5060abf946a@google.com>
Subject: [syzbot] [reiserfs?] kernel BUG in entry_points_to_object
From: syzbot <syzbot+927b0cd57b86eedb4193@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98b1cc82c4af Linux 6.7-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17f637b7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52c9552def2a0fdd
dashboard link: https://syzkaller.appspot.com/bug?extid=927b0cd57b86eedb4193
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101b9214e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fb7214e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/77af735993e1/disk-98b1cc82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/806c51c6c6ae/vmlinux-98b1cc82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9af67744e298/bzImage-98b1cc82.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7d091cb75f24/mount_0.gz

The issue was bisected to:

commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri Mar 31 12:32:18 2023 +0000

    reiserfs: Add security prefix to xattr name in reiserfs_security_write()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17989114e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14589114e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10589114e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+927b0cd57b86eedb4193@syzkaller.appspotmail.com
Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")

REISERFS warning (device loop0): vs-13060 reiserfs_update_sd_size: stat data of object [1 2 0x0 SD] (nlink == 1) not found (pos 2)
REISERFS warning (device loop0): vs-13060 reiserfs_update_sd_size: stat data of object [1 2 0x0 SD] (nlink == 1) not found (pos 2)
REISERFS panic (device loop0): vs-7042 entry_points_to_object: entry must be visible
------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:390!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5057 Comm: syz-executor309 Not tainted 6.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__reiserfs_panic+0x140/0x150 fs/reiserfs/prints.c:390
Code: c1 a0 69 7c 8b 48 0f 44 c8 48 0f 44 d8 48 c7 c7 60 6a 7c 8b 4c 89 fe 48 89 da 4d 89 f0 49 c7 c1 80 53 6f 92 e8 71 21 de 08 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 55 48
RSP: 0018:ffffc9000391f320 EFLAGS: 00010246
RAX: 0000000000000054 RBX: ffffffff8b7c1b00 RCX: bc3f3e0b1fc0be00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000391f410 R08: ffffffff817136dc R09: 1ffff92000723e04
R10: dffffc0000000000 R11: fffff52000723e05 R12: ffffffff8b7c1b20
R13: ffffc9000391f340 R14: ffffffff8d13e152 R15: ffff88801cee8660
FS:  0000555555e10380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c020b77818 CR3: 0000000078e9b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 entry_points_to_object+0x6e7/0x6f0
 reiserfs_rename+0xff3/0x2110 fs/reiserfs/namei.c:1526
 vfs_rename+0xaba/0xde0 fs/namei.c:4844
 do_renameat2+0xd5a/0x1390 fs/namei.c:4996
 __do_sys_rename fs/namei.c:5042 [inline]
 __se_sys_rename fs/namei.c:5040 [inline]
 __x64_sys_rename+0x86/0x90 fs/namei.c:5040
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f695d1e66b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff86426978 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0032656c69662f2e RCX: 00007f695d1e66b9
RDX: 00007f695d1e66b9 RSI: 00000000200002c0 RDI: 00000000200000c0
RBP: 0030656c69662f31 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 2f31656c69662f2e
R13: 00007fff86426b58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__reiserfs_panic+0x140/0x150 fs/reiserfs/prints.c:390
Code: c1 a0 69 7c 8b 48 0f 44 c8 48 0f 44 d8 48 c7 c7 60 6a 7c 8b 4c 89 fe 48 89 da 4d 89 f0 49 c7 c1 80 53 6f 92 e8 71 21 de 08 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 55 48
RSP: 0018:ffffc9000391f320 EFLAGS: 00010246
RAX: 0000000000000054 RBX: ffffffff8b7c1b00 RCX: bc3f3e0b1fc0be00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000391f410 R08: ffffffff817136dc R09: 1ffff92000723e04
R10: dffffc0000000000 R11: fffff52000723e05 R12: ffffffff8b7c1b20
R13: ffffc9000391f340 R14: ffffffff8d13e152 R15: ffff88801cee8660
FS:  0000555555e10380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c020b77818 CR3: 0000000078e9b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

