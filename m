Return-Path: <linux-fsdevel+bounces-43416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1052BA566AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 12:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7372B3B64C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 11:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D00E21772B;
	Fri,  7 Mar 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t+nS9epQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74398217705
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346632; cv=none; b=f0E8QAG9pWrRnmJfue0Fr8mXNb3v1lkvE9zfIkaUcFmEB3czM4lLgyiHalBFgmLV/IktRDpsMNVBI7OkiOD5sr1XoFBrz3vAp4976pLuHwBord64LKMP3ck1wLlAvQ2evVJKL8bpvCDjaVkXeSn+shqDq5dkbsfOg8KAI940gRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346632; c=relaxed/simple;
	bh=3mimNSb6L2tgCCDQ9UvQWmkElEjB3BD2Ph/JCTZcuR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGd5jJzXCC5UQCeRqXuucWoII7zhXCRTzbD/AGIP3SW2koJ7m5MJSyvK/yYqyDPBbPNB5UuLjbIgW9S8DN3PkOlJPWQoBULujUH3+ttafHVHkIbd6LxKMNBIq9G1F+w7JnWssufUtb+8dCB3heShSsKXV5tZF78FbUUmdJIiBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t+nS9epQ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Mar 2025 06:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741346617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FFfrZu1tiP/7nFJM46dA5vPr4svMNoLjA1XVKj4fYL8=;
	b=t+nS9epQosmtdXpt/UCkhyaYmq0IjCE2PCoBLP5J+w2Bm8VHvOAGr1nowZ7T3vFSlAQX8a
	0WJvoyx8FcgUpRfwjPcBuhow3Ek8WpdvUrpJKzAClP9A98+M74dVa3CgBoUcArZv86XgNd
	S+YxnmeifdA/KrZaPEj9n1p/egN9Lu0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+46cddce16efb51810fff@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [bcachefs?] BUG: unable to handle kernel paging request
 in pipe_write
Message-ID: <5glsajfa3vx7zwr6j4mcwevvv76ivzkhbn3b2zcrfbgfmnki7u@pdbcloi4x653>
References: <67caa53c.050a0220.15b4b9.0078.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67caa53c.050a0220.15b4b9.0078.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

So this is after a bcachefs failure to mount - filesystem bringup error
path - which implies we've got a memory stomper that kasan isn't able to
catch.

There's a couple that fit that pattern, and I think percpu allocations
were involved in all of them...

On Thu, Mar 06, 2025 at 11:50:20PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    848e07631744 Merge tag 'hid-for-linus-2025030501' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=173c4a64580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2040405600e83619
> dashboard link: https://syzkaller.appspot.com/bug?extid=46cddce16efb51810fff
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c7fda8580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-848e0763.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c46426c0526b/vmlinux-848e0763.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d575feb1a7df/bzImage-848e0763.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/50b3934b613c/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+46cddce16efb51810fff@syzkaller.appspotmail.com
> 
> BUG: unable to handle page fault for address: ffff887fabfbcf80
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 0 P4D 0 
> Oops: Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5336 Comm: syz-executor Not tainted 6.14.0-rc5-syzkaller-00039-g848e07631744 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:__percpu_down_read_trylock kernel/locking/percpu-rwsem.c:50 [inline]
> RIP: 0010:__percpu_down_read+0x40/0x130 kernel/locking/percpu-rwsem.c:169
> Code: 49 bd 00 00 00 00 00 fc ff df 4c 8d 77 68 4c 89 f5 48 c1 ed 03 42 80 7c 2d 00 00 74 08 4c 89 f7 e8 35 7e 1e f6 49 8b 44 24 68 <65> ff 00 f0 83 44 24 fc 00 49 8d 9c 24 c8 00 00 00 48 89 df be 04
> RSP: 0018:ffffc9000d1c7aa0 EFLAGS: 00010246
> RAX: ffffffff8c3bcf80 RBX: 000000008e29c24b RCX: ffff8880001fc880
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff8ecc2fd8
> RBP: 1ffffffff1d98608 R08: ffffffff823d3401 R09: 1ffffffff2079e8e
> R10: dffffc0000000000 R11: fffffbfff2079e8f R12: ffffffff8ecc2fd8
> R13: dffffc0000000000 R14: ffffffff8ecc3040 R15: ffffffff8ecc2fd8
> FS:  0000555594365500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff887fabfbcf80 CR3: 000000004349a000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  percpu_down_read_trylock include/linux/percpu-rwsem.h:84 [inline]
>  __sb_start_write_trylock include/linux/fs.h:1790 [inline]
>  sb_start_write_trylock include/linux/fs.h:1926 [inline]
>  pipe_write+0x16db/0x1950 fs/pipe.c:605
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0xacf/0xd10 fs/read_write.c:679
>  ksys_write+0x18f/0x2b0 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc094d8bbe0
> Code: 40 00 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 61 19 1f 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffe88624b48 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000555594379d50 RCX: 00007fc094d8bbe0
> RDX: 0000000000000030 RSI: 00007ffe88624b80 RDI: 000000000000000b
> RBP: 0000555594378f20 R08: 0000000005a61143 R09: 7fffffffffffffff
> R10: 00007fc095b50038 R11: 0000000000000202 R12: 0000000000000001
> R13: 0000000000000000 R14: 00007ffe88624b60 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> CR2: ffff887fabfbcf80
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__percpu_down_read_trylock kernel/locking/percpu-rwsem.c:50 [inline]
> RIP: 0010:__percpu_down_read+0x40/0x130 kernel/locking/percpu-rwsem.c:169
> Code: 49 bd 00 00 00 00 00 fc ff df 4c 8d 77 68 4c 89 f5 48 c1 ed 03 42 80 7c 2d 00 00 74 08 4c 89 f7 e8 35 7e 1e f6 49 8b 44 24 68 <65> ff 00 f0 83 44 24 fc 00 49 8d 9c 24 c8 00 00 00 48 89 df be 04
> RSP: 0018:ffffc9000d1c7aa0 EFLAGS: 00010246
> RAX: ffffffff8c3bcf80 RBX: 000000008e29c24b RCX: ffff8880001fc880
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff8ecc2fd8
> RBP: 1ffffffff1d98608 R08: ffffffff823d3401 R09: 1ffffffff2079e8e
> R10: dffffc0000000000 R11: fffffbfff2079e8f R12: ffffffff8ecc2fd8
> R13: dffffc0000000000 R14: ffffffff8ecc3040 R15: ffffffff8ecc2fd8
> FS:  0000555594365500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff887fabfbcf80 CR3: 000000004349a000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
>    7:	fc ff df
>    a:	4c 8d 77 68          	lea    0x68(%rdi),%r14
>    e:	4c 89 f5             	mov    %r14,%rbp
>   11:	48 c1 ed 03          	shr    $0x3,%rbp
>   15:	42 80 7c 2d 00 00    	cmpb   $0x0,0x0(%rbp,%r13,1)
>   1b:	74 08                	je     0x25
>   1d:	4c 89 f7             	mov    %r14,%rdi
>   20:	e8 35 7e 1e f6       	call   0xf61e7e5a
>   25:	49 8b 44 24 68       	mov    0x68(%r12),%rax
> * 2a:	65 ff 00             	incl   %gs:(%rax) <-- trapping instruction
>   2d:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
>   33:	49 8d 9c 24 c8 00 00 	lea    0xc8(%r12),%rbx
>   3a:	00
>   3b:	48 89 df             	mov    %rbx,%rdi
>   3e:	be                   	.byte 0xbe
>   3f:	04                   	.byte 0x4
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

