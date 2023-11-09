Return-Path: <linux-fsdevel+bounces-2601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 950587E6FFE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66315B20CDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1322320;
	Thu,  9 Nov 2023 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861222308
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:16:26 +0000 (UTC)
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3517730D5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 09:16:26 -0800 (PST)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1ccdf149e60so11203105ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 09:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550185; x=1700154985;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nvuStkJjLYEBBvyk6oppowE0GjZD5Nq75zlX0wJdtU=;
        b=GDws7DGAmKcbIbE7WZ1B18kZeHOM1ap6IK0Ln6bYBkZAPaeJTKnriBwYpAKn69J/uw
         KqURtKzO0i7WCEyOlzgiDzCn7uWfXkyQpkhvjVbify6Mb+vkeuAtCqjEpHJhoTTMNM9K
         ZxkT1OLpqEmdJKnVJrLu8nS+cGL4gXywnPmOlTNFjxb3ad8GSxo91v2SZhSNt7eYzhYD
         5im+iNSo31u8tJrF/c1nMLNZfDVP7mluwzV/EtrfcEKVvdyQFDeJsE3ioG9MQ3x9nVFn
         Ovaa8jaxmWTUGg0aDuJISAb3HZnhSWaEYZT1gxPSitH6gzDfQEsPasf3B+7xakwISZhI
         t5YA==
X-Gm-Message-State: AOJu0YzBYhlgmNnHo/TdeE1MbcZ+bsv3BLPnook3aViEOprbzZ7sT8DM
	5Luijr8+YNqSTqDOv8nHz7vFK8G4zA9r3kc0E+HXqsNgO2wC
X-Google-Smtp-Source: AGHT+IE5+3A81GAJ1+aCXHStNxoEX4xBmDCrGeMX5aW+aInVyF2KjxeUsDaWZlw2RY7CmDbfBnAq4JvWTGXgRl1DLtdQaBowDExO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:6cd:b0:1cc:3ac9:717b with SMTP id
 kj13-20020a17090306cd00b001cc3ac9717bmr587738plb.6.1699550185738; Thu, 09 Nov
 2023 09:16:25 -0800 (PST)
Date: Thu, 09 Nov 2023 09:16:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001959d30609bb5d94@google.com>
Subject: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From: syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To: boris@bur.io, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    305230142ae0 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11777b60e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14900138e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10907197680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0aab25a831ba/disk-30523014.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d1b7b8fdf8a/vmlinux-30523014.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9b6822fcd5f/bzImage-30523014.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/82e806de5984/mount_0.gz

The issue was bisected to:

commit 6ed05643ddb166c0fddabac8ee092659006214a9
Author: Boris Burkov <boris@bur.io>
Date:   Wed Jun 28 18:00:05 2023 +0000

    btrfs: create qgroup earlier in snapshot creation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117a7050e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=137a7050e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=157a7050e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")

------------[ cut here ]------------
BTRFS: Transaction aborted (error -17)
WARNING: CPU: 0 PID: 5057 at fs/btrfs/transaction.c:1778 create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
Modules linked in:
CPU: 0 PID: 5057 Comm: syz-executor225 Not tainted 6.6.0-syzkaller-15365-g305230142ae0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
Code: f8 fd 48 c7 c7 00 43 ab 8b 89 de e8 76 4b be fd 0f 0b e9 30 f3 ff ff e8 7a 8d f8 fd 48 c7 c7 00 43 ab 8b 89 de e8 5c 4b be fd <0f> 0b e9 f8 f6 ff ff e8 60 8d f8 fd 48 c7 c7 00 43 ab 8b 89 de e8
RSP: 0018:ffffc90003abf580 EFLAGS: 00010246
RAX: 10fb7cf24e10ea00 RBX: 00000000ffffffef RCX: ffff888023ea9dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003abf870 R08: ffffffff81547c82 R09: 1ffff11017305172
R10: dffffc0000000000 R11: ffffed1017305173 R12: ffff888078ae2878
R13: 00000000ffffffef R14: 0000000000000000 R15: ffff888078ae2818
FS:  000055555667d380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ff7bf2304 CR3: 0000000079f17000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1967
 btrfs_commit_transaction+0xf1c/0x3730 fs/btrfs/transaction.c:2440
 create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:845
 btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:995
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1041
 __btrfs_ioctl_snap_create+0x344/0x460 fs/btrfs/ioctl.c:1294
 btrfs_ioctl_snap_create+0x13c/0x190 fs/btrfs/ioctl.c:1321
 btrfs_ioctl+0xbbf/0xd40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2f791127b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc5dc597b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f2f791127b9
RDX: 0000000020000a80 RSI: 0000000050009401 RDI: 0000000000000004
RBP: 00007f2f7918b610 R08: 00007ffc5dc59988 R09: 00007ffc5dc59988
R10: 00007ffc5dc59988 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc5dc59978 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

