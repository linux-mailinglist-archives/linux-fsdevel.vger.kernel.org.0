Return-Path: <linux-fsdevel+bounces-5685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCD480EDAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 14:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD8A1C20C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095F61FC1;
	Tue, 12 Dec 2023 13:32:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924BFAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 05:32:34 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb34e3da36so9977237fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 05:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387954; x=1702992754;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGYX1JcahWQVmmbjS2b0eMoTc8GaaY/bTCt82bEmxHs=;
        b=lfKQpmztHjk4WC+Cqn8dgoSBjCgDfUfWuFImFnlWMtwDATMIwyRPLe0glSV9LcIzRE
         I4sjoLlyxIGm6mXA7nIezhCAgaXVO1Cv8TB2adRjG1cYWOiqMAKUy/njiy0EblLHeZyO
         DXNAz58XLBVRlu0pifnAq3aQCpluoJlyc0BBev2INm8G3bXf4q5QQsLdqIlkClw1hJ73
         +7eJ3TlB23mkyyzBn0aHo+HWv3sOiEVzO/oPeYTiRKuq4Z3lzgPK7rf7bXUbw4lzSBbM
         zCTi0/0q/xnEkufugV5Hp6y5zr9l0Wn65+TNu2/XhJMI6zMVa/aV5oeStq5jW0sYOGU5
         CHbA==
X-Gm-Message-State: AOJu0YwauO/XMSezf1DpmSuxocG9rx3+I6lsUxsk/jUdbWOvjqhXiMI3
	19VrLt4Ppm5ZQdonQ/8il7gUjkePdtTmVVzk6C7lDNl0qcY9
X-Google-Smtp-Source: AGHT+IHV473fRfDVaXq62bjejr4Dhd4YONJaik+XJVoq0djyWs4yOJdc9z6wKrwtRtBu2oXqoV7pGtWIpm6/RDBP30auXzpRshae
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:6393:b0:1fb:483:a1d5 with SMTP id
 t19-20020a056870639300b001fb0483a1d5mr6941506oap.10.1702387953977; Tue, 12
 Dec 2023 05:32:33 -0800 (PST)
Date: Tue, 12 Dec 2023 05:32:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000444fa8060c501557@google.com>
Subject: [syzbot] [btrfs?] WARNING in fiemap_process_hole
From: syzbot <syzbot+35281eae12e6fa221f16@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

Hello,

syzbot found the following issue on:

HEAD commit:    815fb87b7530 Merge tag 'pm-6.7-rc4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16865c18e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f341086b9b65f3
dashboard link: https://syzkaller.appspot.com/bug?extid=35281eae12e6fa221f16
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5207d4e5f747/disk-815fb87b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5255f6dfc8c3/vmlinux-815fb87b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/876a2e66fa94/bzImage-815fb87b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35281eae12e6fa221f16@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 31576 at fs/btrfs/extent_io.c:2454 emit_fiemap_extent fs/btrfs/extent_io.c:2454 [inline]
WARNING: CPU: 1 PID: 31576 at fs/btrfs/extent_io.c:2454 fiemap_process_hole+0x9e0/0xaf0 fs/btrfs/extent_io.c:2695
Modules linked in:
CPU: 1 PID: 31576 Comm: syz-executor.4 Not tainted 6.7.0-rc3-syzkaller-00284-g815fb87b7530 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:emit_fiemap_extent fs/btrfs/extent_io.c:2454 [inline]
RIP: 0010:fiemap_process_hole+0x9e0/0xaf0 fs/btrfs/extent_io.c:2695
Code: 85 ed 0f 45 c8 89 4c 24 14 4c 8b 7c 24 18 49 89 dd eb 39 e8 82 d2 f0 fd eb 32 e8 7b d2 f0 fd e9 a5 00 00 00 e8 71 d2 f0 fd 90 <0f> 0b 90 41 bd ea ff ff ff 49 bc 00 00 00 00 00 fc ff df e9 87 00
RSP: 0018:ffffc90003897520 EFLAGS: 00010287
RAX: ffffffff839da7cf RBX: 0000000000027000 RCX: 0000000000040000
RDX: ffffc9000c740000 RSI: 00000000000057d1 RDI: 00000000000057d2
RBP: ffffc90003897690 R08: ffffffff839da273 R09: 1ffffffff21bae90
R10: dffffc0000000000 R11: fffffbfff21bae91 R12: 1ffff92000712f1e
R13: 00000000000d9000 R14: 0000000000101000 R15: 1ffff92000712f1f
FS:  00007f73188496c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f39fba05000 CR3: 000000005143e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 extent_fiemap+0xeae/0x1fe0
 btrfs_fiemap+0x178/0x1e0 fs/btrfs/inode.c:7830
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x19ea/0x2b40 fs/ioctl.c:811
 __do_sys_ioctl fs/ioctl.c:869 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f7317a7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f73188490c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7317b9c120 RCX: 00007f7317a7cae9
RDX: 00000000200000c0 RSI: 00000000c020660b RDI: 0000000000000005
RBP: 00007f7317ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f7317b9c120 R15: 00007fff6ffca378
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

