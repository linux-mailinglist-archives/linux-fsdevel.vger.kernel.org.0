Return-Path: <linux-fsdevel+bounces-2810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDF47EA80A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 02:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9A31C20905
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 01:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D841646A4;
	Tue, 14 Nov 2023 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B34420
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 01:02:23 +0000 (UTC)
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8AFD5A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 17:02:21 -0800 (PST)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-5b7f3f47547so4611746a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 17:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699923740; x=1700528540;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KN1VPTD/XwpbHmD08h+5JEdAa2L6wLXqNqbY4sMw3iY=;
        b=fjIm6yRQ0pyyt/cIcenFlX7pNmmegthYDZf0skiKkbG03eNW1FAaWOjf5/bsth06Sj
         0su7vG2LlBDYccJTvGfJoIg2TohabbmhYXYhMNMDXctx+bt3LZCBgPyzuI4eNgBVkr5A
         83IDTlWiZgVyO0y+Yu/Ii7B+0+Gqz560Hg7fE4WijOE/x9T0lpG+yNBoSXpMH+GTB+im
         E1C3au/Q85RUWHU9rV4fXYw1JB8MEUCyUtDQS02gBn4OzMM29macB8u1j9K6zfh0T4Xw
         aSQQOLrvqfT981sOpIO3Ye8umnDj5K2ptvVH1hhlU6ZVxubQA2gOJcjNbNpHyntuV2gv
         buWA==
X-Gm-Message-State: AOJu0YzaTOte0Sitvz7Qmyt8MnrH7uGIy6Daf4QARJBJ2IvVdca1CO5w
	1DK/Y19Gkod43chXvoDYNw5rTZD8nvwRTDNTcOomEx9jEY2q
X-Google-Smtp-Source: AGHT+IGQDS/+RsZx5/GmMdEPaSRZ42IsNktfLincp8HEf8aX2nQeqvyPv0Nm1z1fXUxlSQCivx5TbtfzlKj9YnLKWjuOl/3xTeYN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:104a:0:b0:5c1:7124:d9aa with SMTP id
 10-20020a63104a000000b005c17124d9aamr165450pgq.12.1699923740213; Mon, 13 Nov
 2023 17:02:20 -0800 (PST)
Date: Mon, 13 Nov 2023 17:02:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae5995060a125650@google.com>
Subject: [syzbot] [autofs?] general protection fault in autofs_fill_super
From: syzbot <syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4bbdb725a36b Merge tag 'iommu-updates-v6.7' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15dc14a8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=662f87a8ef490f45fa64
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14384a7b680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd459eb1acfc/disk-4bbdb725.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d784829734e1/vmlinux-4bbdb725.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db2c9e9ae9c3/bzImage-4bbdb725.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com

Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe4723a6f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fae5d99bf80 RCX: 00007fae5d87cae9
RDX: 0000000020000040 RSI: 0000000020000380 RDI: 0000000000000000
RBP: 00007ffe4723a750 R08: 0000000020000400 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00000000000009f9 R14: 00007fae5d99bf80 R15: 00007fae5d99bf80
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5098 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-15601-g4bbdb725a36b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:autofs_fill_super+0x47d/0xb50 fs/autofs/inode.c:334
Code: 03 60 d7 9f 8b 4d 8d 67 04 48 8b 14 24 48 89 d0 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 58 03 00 00 8b 1a 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30 84 c0 4c 89 f5 0f 85 61 03 00 00 41 89 5f 04 4d 8d
RSP: 0018:ffffc90003bafc90 EFLAGS: 00010247
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807b190000
RDX: ffff8880136beac0 RSI: ffffffff8bbdc620 RDI: ffffffff8bbdc5e0
RBP: ffff8880206d0580 R08: ffffffff8da2aa13 R09: 1ffffffff1b45542
R10: dffffc0000000000 R11: fffffbfff1b45543 R12: 0000000000000004
R13: ffff8880206d0500 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555555cbc480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe47239e08 CR3: 0000000024f32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_get_super fs/super.c:1338 [inline]
 get_tree_nodev+0xb4/0x140 fs/super.c:1357
 vfs_get_tree+0x8c/0x280 fs/super.c:1771
 do_new_mount+0x28f/0xae0 fs/namespace.c:3337
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fae5d87cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe4723a6f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fae5d99bf80 RCX: 00007fae5d87cae9
RDX: 0000000020000040 RSI: 0000000020000380 RDI: 0000000000000000
RBP: 00007ffe4723a750 R08: 0000000020000400 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00000000000009f9 R14: 00007fae5d99bf80 R15: 00007fae5d99bf80
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:autofs_fill_super+0x47d/0xb50 fs/autofs/inode.c:334
Code: 03 60 d7 9f 8b 4d 8d 67 04 48 8b 14 24 48 89 d0 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 58 03 00 00 8b 1a 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30 84 c0 4c 89 f5 0f 85 61 03 00 00 41 89 5f 04 4d 8d
RSP: 0018:ffffc90003bafc90 EFLAGS: 00010247
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807b190000
RDX: ffff8880136beac0 RSI: ffffffff8bbdc620 RDI: ffffffff8bbdc5e0
RBP: ffff8880206d0580 R08: ffffffff8da2aa13 R09: 1ffffffff1b45542
R10: dffffc0000000000 R11: fffffbfff1b45543 R12: 0000000000000004
R13: ffff8880206d0500 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555555cbc480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe47239e08 CR3: 0000000024f32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	28 00                	sub    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	75 05                	jne    0xb
   6:	48 83 c4 28          	add    $0x28,%rsp
   a:	c3                   	ret
   b:	e8 e1 20 00 00       	call   0x20f1
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
* 2a:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax <-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 c7 c1 b0 ff ff ff 	mov    $0xffffffffffffffb0,%rcx
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

