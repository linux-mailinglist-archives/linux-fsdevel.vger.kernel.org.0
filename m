Return-Path: <linux-fsdevel+bounces-2951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC447EDE03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5E2280FB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 09:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AB72942B;
	Thu, 16 Nov 2023 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AEFC5
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 01:53:26 -0800 (PST)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-5c16f262317so635746a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 01:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128406; x=1700733206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGFeETijn5gpNnYM4nN6xlKFUYFfT5fG57XpqChy2YI=;
        b=dfBOKSpQwKKmC7qFyGseX+LYTqkPH1ZXvNW7Rr7J/lVlPikDonPe5CnYULHm4fGUsG
         B2oaK5uz57qN47R397y+sBwXVZoFKhjGXvrd0gs3m1JGOgqSfkWsGBM2MnwShJLaK4WR
         sq8fkld6VbPLb7+skmvDXK0arrMQmRQf9ilg93wOPPkjfmMBeQ1LOEpyBLx5K95lFghf
         CBxva9Z/FzKRpZZ5DtHzL/+TDuG0nKsB5+n9pQxWsQU7QF9/FPEEMCO6zDXEatf8s/Hp
         OdwKFy6u6DptSp2bBj77utYqbVK0pdMZGQuvJS2lH6PYLAEyl191rCsPw5WBloFaIw3s
         EDbQ==
X-Gm-Message-State: AOJu0YyZ7VZS+ToJs3DiP/EKrAyRvQ8fRdBemOC1jN1RjeBCxefabAO5
	UeKj5ukmvLNHdFcCuQ59G4OfLF4H7xb17jWUTtE/nOJYtLue
X-Google-Smtp-Source: AGHT+IFogAZ4bvp2CXiUK3PU66MvCM4xJEc50QAjeA1rM2PjVZbIdOiEfChDQOJEzK8Koa8dun6hKvKBJEXoxbjN5QrEwSfcVe6q
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:1017:0:b0:589:5235:b3cb with SMTP id
 f23-20020a631017000000b005895235b3cbmr204427pgl.3.1700128405845; Thu, 16 Nov
 2023 01:53:25 -0800 (PST)
Date: Thu, 16 Nov 2023 01:53:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3fe4d060a41fdeb@google.com>
Subject: [syzbot] [udf?] WARNING in udf_prealloc_blocks (2)
From: syzbot <syzbot+cc2b732891efbf755b78@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1b907d050735 Merge tag '6.7-rc-smb3-client-fixes-part2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d7f898e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=cc2b732891efbf755b78
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/567b9cb02431/disk-1b907d05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7d18e697c356/vmlinux-1b907d05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b0d7c3147ec4/bzImage-1b907d05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc2b732891efbf755b78@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 26000 at fs/udf/udfdecl.h:123 udf_add_free_space fs/udf/balloc.c:121 [inline]
WARNING: CPU: 1 PID: 26000 at fs/udf/udfdecl.h:123 udf_table_prealloc_blocks fs/udf/balloc.c:572 [inline]
WARNING: CPU: 1 PID: 26000 at fs/udf/udfdecl.h:123 udf_prealloc_blocks+0xf13/0x1310 fs/udf/balloc.c:705
Modules linked in:
CPU: 1 PID: 26000 Comm: syz-executor.1 Not tainted 6.6.0-syzkaller-16176-g1b907d050735 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:121 [inline]
RIP: 0010:udf_add_free_space fs/udf/balloc.c:121 [inline]
RIP: 0010:udf_table_prealloc_blocks fs/udf/balloc.c:572 [inline]
RIP: 0010:udf_prealloc_blocks+0xf13/0x1310 fs/udf/balloc.c:705
Code: 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 43 a2 84 fe e9 4b f7 ff ff e8 39 a2 84 fe 0f 0b e9 67 f8 ff ff e8 2d a2 84 fe <0f> 0b e9 c9 fe ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c 08 f2 ff ff
RSP: 0018:ffffc90015907180 EFLAGS: 00010287
RAX: ffffffff830a2023 RBX: 0000000030303d6b RCX: 0000000000040000
RDX: ffffc9000b843000 RSI: 00000000000376bd RDI: 00000000000376be
RBP: ffffc900159072f0 R08: ffffffff830a1ee6 R09: 1ffffffff1e01a45
R10: dffffc0000000000 R11: fffffbfff1e01a46 R12: ffff88801fd724c0
R13: dffffc0000000000 R14: ffff88803d3c901c R15: ffff88802220c630
FS:  00007fbe5ec496c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3093398000 CR3: 000000007b4ef000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_prealloc_extents fs/udf/inode.c:1032 [inline]
 inode_getblk fs/udf/inode.c:890 [inline]
 udf_map_block+0x285d/0x5560 fs/udf/inode.c:444
 __udf_get_block+0x126/0x410 fs/udf/inode.c:458
 __block_write_begin_int+0x54d/0x1ac0 fs/buffer.c:2119
 __block_write_begin fs/buffer.c:2168 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2227
 udf_write_begin+0x10d/0x1a0 fs/udf/inode.c:261
 generic_perform_write+0x31b/0x630 mm/filemap.c:3918
 udf_file_write_iter+0x2fd/0x660 fs/udf/file.c:111
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x792/0xb20 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fbe5de7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbe5ec490c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbe5df9c050 RCX: 00007fbe5de7cae9
RDX: 000000006db6e559 RSI: 0000000020000080 RDI: 0000000000000007
RBP: 00007fbe5dec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fbe5df9c050 R15: 00007ffe85dd4218
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

