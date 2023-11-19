Return-Path: <linux-fsdevel+bounces-3133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE157F0488
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 07:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33665280F8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C1E569D;
	Sun, 19 Nov 2023 06:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8C6192
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 22:06:25 -0800 (PST)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1cc1682607eso50307955ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 22:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700373985; x=1700978785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcoToEzIjuWlVRlkxDJCBRksQxV3S4p7gMxTk5svtkc=;
        b=mbopWTCjKudAoxFRjsf6teSqRUwUCoJ4A9MA/diZz16yhlkmxDTHWyyIRju/JTvWg1
         +c3cBGHEs5LdUbYq3aRdLe6DVV7rfPwuwYAUgrgkb0b4zpgfWjIIX6ac/esFtJmyoJ1s
         KLs2vL3nAZxxW1SA+MhtXm5ZmS8HQoTZvqzu2kmrqJdDZj8JwnYrdhvwZ/WrR9DX0EJY
         Gx+JOhdsPcBFJfjcK6ggKDp4+e1fKKfz07ScOdNIwXk6sc40JhxjFTjxFzZqmtAzIssJ
         uWwt50JDlthhwdVnx8J0U0Oe0iiD41sFxVjNY/Il+EqiImFWkqO/ohDHggf2dgxoyYNl
         1PTw==
X-Gm-Message-State: AOJu0YzMyxXWfZGcZh5G7N/t8DaZe7a7Dg58INm3L34W5YOIB5VwHZwM
	i8Po2WWO3+FIYn16Z8gAjJSqyNlaltladVUlQlTXov7uX9F8
X-Google-Smtp-Source: AGHT+IEkhDf27h6ff96lsYOl/JSI6lud4gtxp1uFAw4oaayEo4mz0Cu+FpmN4COtiC2ITydC6LWX/pZI8MixiQGTMZVvoRpoxLlu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:4282:b0:1cc:47d4:492c with SMTP id
 ju2-20020a170903428200b001cc47d4492cmr1094677plb.11.1700373985144; Sat, 18
 Nov 2023 22:06:25 -0800 (PST)
Date: Sat, 18 Nov 2023 22:06:24 -0800
In-Reply-To: <000000000000cf826706067d18fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005eb612060a7b2b01@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_release_global_block_rsv
From: syzbot <syzbot+10e8dae9863cb83db623@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    23dfa043f6d5 Merge tag 'i2c-for-6.7-rc2' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=123446f4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=10e8dae9863cb83db623
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17722e24e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11201350e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9653b0ce60b2/disk-23dfa043.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/edbde0f08008/vmlinux-23dfa043.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5490b400b0f9/bzImage-23dfa043.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5b312257ba2d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10e8dae9863cb83db623@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5065 at fs/btrfs/block-rsv.c:459 btrfs_release_global_block_rsv+0x24f/0x270 fs/btrfs/block-rsv.c:459
Modules linked in:
CPU: 0 PID: 5065 Comm: syz-executor138 Not tainted 6.7.0-rc1-syzkaller-00304-g23dfa043f6d5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:btrfs_release_global_block_rsv+0x24f/0x270 fs/btrfs/block-rsv.c:459
Code: 0f 0b 90 e9 e6 fe ff ff e8 4e d0 d6 fd 90 0f 0b 90 e9 10 ff ff ff e8 40 d0 d6 fd 90 0f 0b 90 e9 3a ff ff ff e8 32 d0 d6 fd 90 <0f> 0b 90 e9 6b ff ff ff e8 24 d0 d6 fd 90 0f 0b 90 eb 8d 66 2e 0f
RSP: 0018:ffffc90003c779f8 EFLAGS: 00010293
RAX: ffffffff83b7ae7e RBX: 000000000005e000 RCX: ffff888075723b80
RDX: 0000000000000000 RSI: 000000000005e000 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff83b7ade4 R09: 1ffff110280edd00
R10: dffffc0000000000 R11: ffffed10280edd01 R12: ffff88814076e000
R13: ffff88814076e058 R14: ffff88801ed3c418 R15: dffffc0000000000
FS:  0000555556ab23c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f2b88cc448 CR3: 000000001ab8c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_free_block_groups+0xc39/0x1070 fs/btrfs/block-group.c:4366
 close_ctree+0x75a/0xd40 fs/btrfs/disk-io.c:4389
 generic_shutdown_super+0x13a/0x2c0 fs/super.c:696
 kill_anon_super+0x3b/0x70 fs/super.c:1295
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2097
 deactivate_locked_super+0xc1/0x130 fs/super.c:484
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1256
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2399
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x168/0x2a0 kernel/entry/common.c:296
 do_syscall_64+0x52/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f7262b90fa7
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd1c915058 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f7262b90fa7
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffd1c915110
RBP: 00007ffd1c915110 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffd1c9161c0
R13: 0000555556ab3700 R14: 431bde82d7b634db R15: 00007ffd1c916164
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

