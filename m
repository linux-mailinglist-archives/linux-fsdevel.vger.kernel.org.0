Return-Path: <linux-fsdevel+bounces-77343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPbeF/EklGnXAAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:21:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0221E149DF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 09:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51CAC30101E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 08:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCFD2E11DC;
	Tue, 17 Feb 2026 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEDhTGro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47643218ADD;
	Tue, 17 Feb 2026 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316123; cv=none; b=HNjPaNvslnfEKGYRSOw6EJKcBxgakLPwsatUzQ4hKHd1lIPln7StS/av8ZIiF2W5MOFggAD5olO767Yc3Pqb3HiruvNasYtrK4TIxKMWUcLFny6ev60u00h6+cSdUedyFsQNtIyeO7UMS0m1195T2bjL5rmrJr208CjouLIrcF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316123; c=relaxed/simple;
	bh=kI03L6owUvBkTHY1F+Zkymg0Vz2iLvNu18O5umGLqdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGQcTBFOsz0snXEuFYJsiGKvGlnXNjN46l2sFuGRfLFicf7nyhvMCgmTPqh154MgYjDR4WNtoiGMJza7FpBBIgzJqTpcySl3OvHSoSUikum/eWNFWgomD/BGZa/ym/kw7ojQ6GQ4hVfqltsQVfNyltdA3NHbdtiQ5WhQ6NGSYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEDhTGro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA010C4CEF7;
	Tue, 17 Feb 2026 08:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771316122;
	bh=kI03L6owUvBkTHY1F+Zkymg0Vz2iLvNu18O5umGLqdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEDhTGroFPv3qFScJvcDEJQBI3XgvaVbyaI6auh1a09omr9rETl7tL2+NqT9Qz9OB
	 fFX/zqZx2ehM8urH28Ao0BOnCcX+SHzuPgX6HIov4z3bhiGTUJvtmDaQI87D+AO8eo
	 7hZEyjW0pfdxjMAeNoLrwKXmaSuT5jJj5Qhs8ND27eoiQmDp7mWWGtXuOR94PgLaNH
	 iwaPQcGlCQZ+o6zTx9vKZIH51BPB8WxwSe2oVsnCbIS5K8ZshPQDx0D+M2NHHcPq3B
	 J+28eOSwFZ6WJMOxKR930cIVFEsW8O+wGhUPRgmSitaSkJcthF2GnEC34Yz6zYClQZ
	 HFZ9jYPrODE/A==
Date: Tue, 17 Feb 2026 09:15:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com>, 
	NeilBrown <neil@brown.name>
Cc: gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [gfs2?] WARNING in filename_mkdirat
Message-ID: <20260217-fanshop-akteur-af571819f78b@brauner>
References: <6993b6a3.050a0220.340abe.0775.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6993b6a3.050a0220.340abe.0775.GAE@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ac00553de86d6bf0];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77343-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlegroups.com:email,goo.gl:url,storage.googleapis.com:url,appspotmail.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,0ea5108a1f5fb4fcc2d8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 0221E149DF3
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 04:30:27PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15331c02580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ac00553de86d6bf0
> dashboard link: https://syzkaller.appspot.com/bug?extid=0ea5108a1f5fb4fcc2d8
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146b295a580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0f2acd31.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b7d134e71e9c/vmlinux-0f2acd31.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b18643058ceb/bzImage-0f2acd31.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/bbfed09077d3/mount_1.gz
>   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=106b295a580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com

Neil, is this something you have time to look into?

> 
> ------------[ cut here ]------------
> DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff88804a18c9b8, owner = 0x0, curr 0xffff888000ec2480, list empty
> WARNING: kernel/locking/rwsem.c:1381 at __up_write kernel/locking/rwsem.c:1380 [inline], CPU#0: syz.0.53/5774
> WARNING: kernel/locking/rwsem.c:1381 at up_write+0x2d6/0x410 kernel/locking/rwsem.c:1643, CPU#0: syz.0.53/5774
> Modules linked in:
> CPU: 0 UID: 0 PID: 5774 Comm: syz.0.53 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
> RIP: 0010:up_write+0x388/0x410 kernel/locking/rwsem.c:1643
> Code: cc 8b 49 c7 c2 c0 eb cc 8b 4c 0f 44 d0 48 8b 7c 24 08 48 c7 c6 20 ee cc 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 10 41 52 <67> 48 0f b9 3a 48 83 c4 08 e8 ea 60 0a 03 e9 67 fd ff ff 48 c7 c1
> RSP: 0000:ffffc90006407d80 EFLAGS: 00010246
> RAX: ffffffff8bcceba0 RBX: ffff88804a18c9b8 RCX: ffff88804a18c9b8
> RDX: 0000000000000000 RSI: ffffffff8bccee20 RDI: ffffffff9014bf50
> RBP: ffff88804a18ca10 R08: 0000000000000000 R09: ffff888000ec2480
> R10: ffffffff8bcceba0 R11: ffffed1009431939 R12: 0000000000000000
> R13: dffffc0000000000 R14: ffff88804a18c9b8 R15: 1ffff11009431938
> FS:  00007f9e11bfe6c0(0000) GS:ffff88808ca62000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c000d54e20 CR3: 0000000041f2c000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  inode_unlock include/linux/fs.h:1038 [inline]
>  end_dirop fs/namei.c:2947 [inline]
>  end_creating include/linux/namei.h:126 [inline]
>  end_creating_path fs/namei.c:4962 [inline]
>  filename_mkdirat+0x305/0x510 fs/namei.c:5271
>  __do_sys_mkdirat fs/namei.c:5287 [inline]
>  __se_sys_mkdirat+0x35/0x150 fs/namei.c:5284
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9e10d9bf79
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f9e11bfe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
> RAX: ffffffffffffffda RBX: 00007f9e11016090 RCX: 00007f9e10d9bf79
> RDX: 00000000000001c0 RSI: 0000200000000140 RDI: ffffffffffffff9c
> RBP: 00007f9e10e327e0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f9e11016128 R14: 00007f9e11016090 R15: 00007ffffd54f8b8
>  </TASK>
> ----------------
> Code disassembly (best guess), 2 bytes skipped:
>    0:	49 c7 c2 c0 eb cc 8b 	mov    $0xffffffff8bccebc0,%r10
>    7:	4c 0f 44 d0          	cmove  %rax,%r10
>    b:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
>   10:	48 c7 c6 20 ee cc 8b 	mov    $0xffffffff8bccee20,%rsi
>   17:	48 8b 14 24          	mov    (%rsp),%rdx
>   1b:	4c 89 f1             	mov    %r14,%rcx
>   1e:	4d 89 e0             	mov    %r12,%r8
>   21:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
>   26:	41 52                	push   %r10
> * 28:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
>   2d:	48 83 c4 08          	add    $0x8,%rsp
>   31:	e8 ea 60 0a 03       	call   0x30a6120
>   36:	e9 67 fd ff ff       	jmp    0xfffffda2
>   3b:	48                   	rex.W
>   3c:	c7                   	.byte 0xc7
>   3d:	c1                   	.byte 0xc1
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

