Return-Path: <linux-fsdevel+bounces-4576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43402800D49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F101C20983
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F43E492
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:36:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FCD10FC
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 05:47:28 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so536356a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 05:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438448; x=1702043248;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ubg4CkkqI3qHcp6AvgCSIHVx9LzIZ9ITG/mX/n79muk=;
        b=P1XN2A6DqoxMhFsN8jEEB5IgThYIWkoHos0PR8s43/tDYLfMBG2GyQrilaeGu2YmbJ
         s4L5Sr0yjAlhFkl9C8yERDBABu3vjwW7RfdJCETHNruW5Sikcnx28KMMm4bP4UkOALLq
         /6Ne4k49ym0aSxkRUZVGpBo2uFhQ+M/e5a+MD2djnvkEgqaNZqm84tra5hn8IHUnqZW0
         lHmDiEhbI1ESo4zTGnEJ/7NoCg6jZGrik/3+FdP9W/JsKLwKEAO3TSkD/AtoiQQ2PRv5
         lLsLJ48YX18mIR4Vu/3E3HaNhB/uMwt17kCyRrBF+CDOaGdGxPWg3ItpzX/j/l+pzQkX
         2ymQ==
X-Gm-Message-State: AOJu0YyZlhBxAYhpay3RBKd3+YE5MtoG6hJynFBZdEn8Tu8p1zWjbPYj
	QEx7t/50rb8ZUnOjFavFqSfUGhRn8hp+RSTf6V2Y8SFJz05U
X-Google-Smtp-Source: AGHT+IEWk4jKP+y3oDg/U2wTff41+4PtCwDGGw/BiglWNWuuHGSe11XLgals7sY/Q5zZms7peKy1rI5d6r8o5OxuwU96areV9AIU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:1009:0:b0:5b9:6677:b8d with SMTP id
 f9-20020a631009000000b005b966770b8dmr3798970pgl.6.1701438448308; Fri, 01 Dec
 2023 05:47:28 -0800 (PST)
Date: Fri, 01 Dec 2023 05:47:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051a218060b7302be@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in __reserve_bytes
From: syzbot <syzbot+1c134362d18de07842ca@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8f60209d6cf Merge tag 'pmdomain-v6.7-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b3499ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb39fe85d254f638
dashboard link: https://syzkaller.appspot.com/bug?extid=1c134362d18de07842ca
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2af2eefe2f60/disk-e8f60209.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15130e50c05d/vmlinux-e8f60209.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e0a0602189b/bzImage-e8f60209.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c134362d18de07842ca@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/btrfs/space-info.c:1638!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 15269 Comm: syz-executor.2 Not tainted 6.7.0-rc3-syzkaller-00048-ge8f60209d6cf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__reserve_bytes+0xd8e/0x12e0 fs/btrfs/space-info.c:1638
Code: e9 b3 f5 ff ff e8 d2 db ed fd b9 66 06 00 00 48 c7 c2 e0 2c 19 8b 48 c7 c6 a0 32 19 8b 48 c7 c7 80 2d 19 8b e8 b3 b7 d0 fd 90 <0f> 0b e8 ab db ed fd e8 b6 39 dd fd 48 89 44 24 18 e9 62 f7 ff ff
RSP: 0018:ffffc90017956bd0 EFLAGS: 00010282
RAX: 000000000000003b RBX: ffff88807a22c000 RCX: ffffc9000b468000
RDX: 0000000000000000 RSI: ffffffff816b0182 RDI: 0000000000000005
RBP: 0000000000000005 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 000000000019c548 R12: 0000000000000000
R13: ffff88805bc04000 R14: 1ffff92002f2ad81 R15: dffffc0000000000
FS:  00007fa7588a16c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000078fa2000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 btrfs_reserve_metadata_bytes+0x2a/0x110 fs/btrfs/space-info.c:1783
 btrfs_reserve_trans_metadata fs/btrfs/transaction.c:598 [inline]
 start_transaction+0x1837/0x1c90 fs/btrfs/transaction.c:692
 btrfs_dirty_inode+0x189/0x200 fs/btrfs/inode.c:6015
 btrfs_update_time fs/btrfs/inode.c:6041 [inline]
 btrfs_update_time+0xae/0xe0 fs/btrfs/inode.c:6032
 inode_update_time fs/inode.c:1955 [inline]
 touch_atime+0x34f/0x5d0 fs/inode.c:2028
 file_accessed include/linux/fs.h:2360 [inline]
 filemap_read+0xb09/0xcf0 mm/filemap.c:2661
 btrfs_file_read_iter+0x1dc/0x830 fs/btrfs/file.c:3823
 __kernel_read+0x301/0x870 fs/read_write.c:428
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:221
 ima_calc_file_hash_tfm+0x2c5/0x3d0 security/integrity/ima/ima_crypto.c:485
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1c6/0x4a0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x85e/0xa20 security/integrity/ima/ima_api.c:290
 process_measurement+0xe92/0x2260 security/integrity/ima/ima_main.c:359
 ima_file_check+0xc2/0x110 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3624 [inline]
 path_openat+0x1821/0x2c50 fs/namei.c:3779
 do_filp_open+0x1de/0x430 fs/namei.c:3809
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_open fs/open.c:1463 [inline]
 __se_sys_open fs/open.c:1459 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1459
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fa757a7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa7588a10c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fa757b9c050 RCX: 00007fa757a7cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000240
RBP: 00007fa757ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fa757b9c050 R15: 00007ffd9a11eb28
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__reserve_bytes+0xd8e/0x12e0 fs/btrfs/space-info.c:1638
Code: e9 b3 f5 ff ff e8 d2 db ed fd b9 66 06 00 00 48 c7 c2 e0 2c 19 8b 48 c7 c6 a0 32 19 8b 48 c7 c7 80 2d 19 8b e8 b3 b7 d0 fd 90 <0f> 0b e8 ab db ed fd e8 b6 39 dd fd 48 89 44 24 18 e9 62 f7 ff ff
RSP: 0018:ffffc90017956bd0 EFLAGS: 00010282

RAX: 000000000000003b RBX: ffff88807a22c000 RCX: ffffc9000b468000
RDX: 0000000000000000 RSI: ffffffff816b0182 RDI: 0000000000000005
RBP: 0000000000000005 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 000000000019c548 R12: 0000000000000000
R13: ffff88805bc04000 R14: 1ffff92002f2ad81 R15: dffffc0000000000
FS:  00007fa7588a16c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3245f000 CR3: 0000000078fa2000 CR4: 0000000000350ef0


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

