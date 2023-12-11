Return-Path: <linux-fsdevel+bounces-5467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A6B80C8A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 12:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250C1281CFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F0238F92;
	Mon, 11 Dec 2023 11:58:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C815D0
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 03:58:27 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9dff5942fso6706535b6e.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 03:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702295906; x=1702900706;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXKTIALbyouSGf/POO3O289jn5YeMVhjl/ASe319lHc=;
        b=eeX3rFhbdctK8w4yOWAMMRy4/r1qnOkGtXmGxdv4Djr8RQlu+RkKY5WpxDzN2Z10Cc
         3jAwSWxsDKMznnNFhPv3XUWbrp2sono12xu4lFhI/10dBVTOHi1X+RVXmzjY9Nle064J
         hJ6zVzSx2aew7MZHo1NXQf7E1O03QAR1ggK2Ra0cA75+Z5aJTcEIfDgmGq7H1HSRg5hT
         so8tVpUwNPrAzA7F3/vmG4fsFc7oMEDROucrCKLODWijDyNG8cN1TlP4eOUtBeaHYXK/
         u7Sg28zu65CPjaLUdU3k5dm2r+VKMi1hBMd65p5nsVbtvnTe1maAvWBuAphSK7Ppz3yl
         vsRg==
X-Gm-Message-State: AOJu0Yxw4rQZMarKvISr8PvpuvUyohjliIrLxjdRKS4JZ8n8MfxfogEQ
	mCm6ai5onrD5NGD15wgJOoo+bdiAOoOoYdl57uzIoSVfoEqi
X-Google-Smtp-Source: AGHT+IE27QIdYr079A/T3mwVVk3ZrwtRaYf+m0GsAZwN6tQ+StzdigAG/5Oe3+IkyvCBIyQAzmTUkzfevoPxSc+vk936ATPccYDa
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2087:b0:3b9:de11:cc9c with SMTP id
 s7-20020a056808208700b003b9de11cc9cmr4131856oiw.5.1702295906763; Mon, 11 Dec
 2023 03:58:26 -0800 (PST)
Date: Mon, 11 Dec 2023 03:58:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3490c060c3aa67a@google.com>
Subject: [syzbot] [gfs2] WARNING in vfs_utimes
From: syzbot <syzbot+0c64a8706d587f73409e@syzkaller.appspotmail.com>
To: brauner@kernel.org, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aed8aee11130 Merge tag 'pmdomain-v6.6-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ec0a28680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=0c64a8706d587f73409e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/310bcfc234f7/disk-aed8aee1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ca036d3eeb2/vmlinux-aed8aee1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1e0032b9919c/bzImage-aed8aee1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c64a8706d587f73409e@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x1, magic = 0xffff8880371ddef0, owner = 0xffff88801d773b80, curr 0xffff888023728000, list empty
WARNING: CPU: 0 PID: 13147 at kernel/locking/rwsem.c:1370 __up_write kernel/locking/rwsem.c:1369 [inline]
WARNING: CPU: 0 PID: 13147 at kernel/locking/rwsem.c:1370 up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Modules linked in:
CPU: 0 PID: 13147 Comm: syz-executor.1 Not tainted 6.6.0-rc1-syzkaller-00072-gaed8aee11130 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Code: 48 c7 c7 a0 98 0a 8b 48 c7 c6 e0 9a 0a 8b 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 53 e8 b0 12 e8 ff 48 83 c4 08 <0f> 0b e9 75 fd ff ff 48 c7 c1 10 9b 9a 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc9001520fbe0 EFLAGS: 00010292
RAX: 144e8f9151b91a00 RBX: ffffffff8b0a9980 RCX: ffff888023728000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9001520fcb0 R08: ffffffff81542432 R09: 1ffff92002a41ee8
R10: dffffc0000000000 R11: fffff52002a41ee9 R12: ffff88801d773b80
R13: ffff8880371ddef0 R14: 1ffff92002a41f84 R15: dffffc0000000000
FS:  00007fadafbfe6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f527c5b8000 CR3: 000000001c7cb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:807 [inline]
 vfs_utimes+0x4c2/0x760 fs/utimes.c:68
 do_utimes_path fs/utimes.c:99 [inline]
 do_utimes fs/utimes.c:145 [inline]
 __do_sys_utime fs/utimes.c:226 [inline]
 __se_sys_utime+0x1e1/0x2e0 fs/utimes.c:215
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fadb847cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fadafbfe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000084
RAX: ffffffffffffffda RBX: 00007fadb859c050 RCX: 00007fadb847cae9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000020000080
RBP: 00007fadb84c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fadb859c050 R15: 00007ffca2821ba8
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

