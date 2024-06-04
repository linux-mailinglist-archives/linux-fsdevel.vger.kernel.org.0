Return-Path: <linux-fsdevel+bounces-20959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28EE8FB629
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5E91C21EEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA1146006;
	Tue,  4 Jun 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnyxY9H1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F713CFA0;
	Tue,  4 Jun 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512297; cv=none; b=qgwM9Pcq3eLU6S7aRv2OZzbakzZ33ABvqvU4xVTNKJ2kDboCDMJFz07Xzot/IVR5aRLicZT49ULBhb7XxQoMqfZOJye6q385C0FhUrDl9zd7sQbtoCqUB3KBLXM0QcA4Sm1GJj+ZCtbaE5oPC9W0TxA4qOrFcohvKxyOzaOr6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512297; c=relaxed/simple;
	bh=3luimiBYat2ale2rBuxxg5iPFTGpNL4uMLOTpn+g+dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SafuVp2hZrr3o4oxcuQ5v++BurKgaHWssWmAbisZieGfNheNMNWme5W8rd6kAlehdkZLIricPbONb42nLAKKVAL4+xN4Ae5rKok4GJcgHA/QspSNFJHC5MiUVfbGsVElhbxRgBT7RK8SzLgl5ZHbLBJCT08Xrda+CN6Hc9dU/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnyxY9H1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA6CC2BBFC;
	Tue,  4 Jun 2024 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717512296;
	bh=3luimiBYat2ale2rBuxxg5iPFTGpNL4uMLOTpn+g+dA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fnyxY9H1e5mH32IRhHzadoKHggB3/iD+UAIvFEayqmtGpUO62LSlu7sFz4D7iWF9T
	 ZJo+MkOBd46wRF9ZMgfrblHZ7ndkbde2ZZDwRzfxIqonjPGakmLqE3/k+Aak7UVu0N
	 b9kyJ0wJTCOlLCHrRcJ6X4UHOCGaEAI2XK/tQ5A21I4EDWCxaAD/RmNslO0zpTrWqp
	 Rnjnrkho9X1s10Lfu1seV+lwhOVxL/M9LrRf7QXrknQf4b4ybLhcZkHZna2Qph/ZEF
	 1FWjweaHXnuMW6DorvbWYO5xhIO+RQYQkRV/qXG4x1GIiA5Fp1Hh6CIvlEVWqc5TxL
	 GlnOejAXlo1Tg==
Message-ID: <a67e82fc-4658-4784-8d5b-e8a048e749e2@kernel.org>
Date: Tue, 4 Jun 2024 22:44:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (2)
To: syzbot <syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000e890bc0609a55cff@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <000000000000e890bc0609a55cff@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip

On 2023/11/8 23:01, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10222eeb680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
> dashboard link: https://syzkaller.appspot.com/bug?extid=31e4659a3fe953aec2f4
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a2847b680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1579d0df680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/10c213d23300/disk-90b0c2b2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0c55e6e441c1/vmlinux-90b0c2b2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c7f0436ea052/bzImage-90b0c2b2.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/dbf260983b94/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/inode.c:933!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5054 Comm: syz-executor410 Not tainted 6.6.0-syzkaller-14142-g90b0c2b2edd1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
> RIP: 0010:f2fs_evict_inode+0x1576/0x1590 fs/f2fs/inode.c:933
> Code: fd 31 ff 89 de e8 5a 4f bf fd 40 84 ed 75 29 e8 c0 4c bf fd 4c 8b 74 24 08 e9 c9 eb ff ff e8 b1 4c bf fd 0f 0b e8 aa 4c bf fd <0f> 0b e8 a3 4c bf fd 0f 0b e9 f6 fe ff ff e8 97 4c bf fd e8 72 e7
> RSP: 0018:ffffc900039df918 EFLAGS: 00010293
> RAX: ffffffff83cf9f56 RBX: 0000000000000002 RCX: ffff888014b30000
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff83cf984a R09: 1ffff1100ed0061d
> R10: dffffc0000000000 R11: ffffed100ed0061e R12: 1ffff1100ed0058f
> R13: ffff888076802c38 R14: ffff8880768030e8 R15: dffffc0000000000
> FS:  00005555556ae3c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffdbe23ce18 CR3: 00000000727e8000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   evict+0x2a4/0x620 fs/inode.c:664
>   dispose_list fs/inode.c:697 [inline]
>   evict_inodes+0x5f8/0x690 fs/inode.c:747
>   generic_shutdown_super+0x9d/0x2c0 fs/super.c:675
>   kill_block_super+0x44/0x90 fs/super.c:1667
>   kill_f2fs_super+0x303/0x3b0 fs/f2fs/super.c:4894
>   deactivate_locked_super+0xc1/0x130 fs/super.c:484
>   cleanup_mnt+0x426/0x4c0 fs/namespace.c:1256
>   task_work_run+0x24a/0x300 kernel/task_work.c:180
>   ptrace_notify+0x2cd/0x380 kernel/signal.c:2399
>   ptrace_report_syscall include/linux/ptrace.h:411 [inline]
>   ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
>   syscall_exit_work kernel/entry/common.c:251 [inline]
>   syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
>   syscall_exit_to_user_mode+0x15c/0x280 kernel/entry/common.c:296
>   do_syscall_64+0x50/0x110 arch/x86/entry/common.c:88
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7fa1a5e8ee77
> Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
> RSP: 002b:00007ffdbe23d5c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 0000000000021a97 RCX: 00007fa1a5e8ee77
> RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffdbe23d680
> RBP: 00007ffdbe23d680 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffdbe23e740
> R13: 00005555556af700 R14: 431bde82d7b634db R15: 00007ffdbe23e6e4
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:f2fs_evict_inode+0x1576/0x1590 fs/f2fs/inode.c:933
> Code: fd 31 ff 89 de e8 5a 4f bf fd 40 84 ed 75 29 e8 c0 4c bf fd 4c 8b 74 24 08 e9 c9 eb ff ff e8 b1 4c bf fd 0f 0b e8 aa 4c bf fd <0f> 0b e8 a3 4c bf fd 0f 0b e9 f6 fe ff ff e8 97 4c bf fd e8 72 e7
> RSP: 0018:ffffc900039df918 EFLAGS: 00010293
> RAX: ffffffff83cf9f56 RBX: 0000000000000002 RCX: ffff888014b30000
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff83cf984a R09: 1ffff1100ed0061d
> R10: dffffc0000000000 R11: ffffed100ed0061e R12: 1ffff1100ed0058f
> R13: ffff888076802c38 R14: ffff8880768030e8 R15: dffffc0000000000
> FS:  00005555556ae3c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffdbe23ce18 CR3: 00000000727e8000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

