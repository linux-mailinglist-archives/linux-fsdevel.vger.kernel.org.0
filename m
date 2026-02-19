Return-Path: <linux-fsdevel+bounces-77688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAtJNzO7lml0lAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 08:26:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4167115CA57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 08:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0E0301C8BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B8333426;
	Thu, 19 Feb 2026 07:26:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E6E32F759
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771485990; cv=none; b=it+hgT+evCuaTVpRv+Xd0KY8ZrEFejWhpfGLsIaBr9YY/Gg7Zfu1XDww01yaXoFo8hNWI2J8ILattUHR2n7N5tnT6VW8N+1a8wAb5hikQpEXmEmuHicv0K0mxZJqBC7axPE/tzJzsOBAHdm6XwcRKmIoIhZWgqAcj7kGAtTheE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771485990; c=relaxed/simple;
	bh=d7tX339UUt2N4n7H/0cWHIR30theTfZmsg7UJ5LhH+E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cCgjQLIJzAZhem1suIxAqncfKiTEmMlYrt9vl9j6EjuWn3UXcP54O008anBXGiIst/4MXpE9One2O0ucSWKXBsDCgyRQIT996sZq2UMPNAYtlS+2BLi2LhGkNzRe7q5UFnRsXXaGh2oW4iPjYksttjIGbOIg0nPZsZCFYilU2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-66308f16ea1so7193593eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 23:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771485988; x=1772090788;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91+WVkCDRs7290LF9M6RNmtTe9b1ikHVhcqIknyWWUc=;
        b=IcqRGMcSGE2+V6aaBLw2HO551WETv4NSWTyPLQ7VQ/6MXgOLqLO5jUOmucQByTvxKb
         REN8BxVo2A7PZw3oi51AxSgc6+bMdPZ/woYy+Afx2Pp0mzVt9yEpCy/k4h+igLmP65oD
         VxEDJL6gVEq3X6D/Dv3WD5hbQdEvw5P6eJbLMhoJ0XW/S5u7EDBtzZP9C0ja71lCi+lt
         sN5E5hd48SIzdC3TvMM2AH/IltFBl2gNMSlBUj44qeKHVPXi0OcqAD0Zhgs9B1PuQm4F
         Zh7HaapmAkG9sNyx8EqghINN6vcBlzKnR4LHv6xnosmV5bsRu+6ttfVqHAPOK0ZfJHTr
         sEXw==
X-Forwarded-Encrypted: i=1; AJvYcCXT+1ctIVy/Ghj1TOI7iBeAFGQcnloi5ik/dS2yk7S7/o0duwBjmGCHZSY9n7rJWidNkWltjYVgJHupRvc/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/TNuxxNeEJW4Sdh0shDgrqeBEIffAfhPWjzw8nbvSnFmM3UJ8
	AW79zIdYM09thNZKWgrsaTEvZXVSTPcnpVQKVfSU46Mr17AK9MuYT5VJ7dLKM7n9Kpjp0rr/RVr
	Ac2INhKvcHK1uoK2uVJV7/Qbk8naSSYPKjUwqIPolbFR0W1/mflPi8umYvlA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:151b:b0:677:bd4a:8f79 with SMTP id
 006d021491bc7-679a71c9a20mr2415713eaf.20.1771485987661; Wed, 18 Feb 2026
 23:26:27 -0800 (PST)
Date: Wed, 18 Feb 2026 23:26:27 -0800
In-Reply-To: <6993b6a3.050a0220.340abe.0775.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6996bb23.a70a0220.2c38d7.0122.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in filename_mkdirat
From: syzbot <syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com>
To: brauner@kernel.org, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, neil@brown.name, 
	neilb@ownmail.net, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77688-lists,linux-fsdevel=lfdr.de,0ea5108a1f5fb4fcc2d8];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,lists.linux.dev,suse.cz,vger.kernel.org,brown.name,ownmail.net,googlegroups.com,zeniv.linux.org.uk];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 4167115CA57
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    956b9cbd7f15 Merge tag 'kbuild-fixes-7.0-1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c81ffa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e
dashboard link: https://syzkaller.appspot.com/bug?extid=0ea5108a1f5fb4fcc2d8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1622495a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1600e95a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-956b9cbd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f0b3757a15ed/vmlinux-956b9cbd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c564e8613b4e/bzImage-956b9cbd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2e0152c5e6ec/mount_1.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=141eb15a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff88804665f818, owner = 0x0, curr 0xffff888035922480, list empty
WARNING: kernel/locking/rwsem.c:1381 at __up_write kernel/locking/rwsem.c:1380 [inline], CPU#0: syz.0.30/5574
WARNING: kernel/locking/rwsem.c:1381 at up_write+0x2d6/0x410 kernel/locking/rwsem.c:1643, CPU#0: syz.0.30/5574
Modules linked in:
CPU: 0 UID: 0 PID: 5574 Comm: syz.0.30 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x388/0x410 kernel/locking/rwsem.c:1643
Code: cc 8b 49 c7 c2 80 eb cc 8b 4c 0f 44 d0 48 8b 7c 24 08 48 c7 c6 e0 ed cc 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 10 41 52 <67> 48 0f b9 3a 48 83 c4 08 e8 0a 0c 0b 03 e9 67 fd ff ff 48 c7 c1
RSP: 0018:ffffc90006407d80 EFLAGS: 00010246
RAX: ffffffff8bcceb60 RBX: ffff88804665f818 RCX: ffff88804665f818
RDX: 0000000000000000 RSI: ffffffff8bccede0 RDI: ffffffff9014e210
RBP: ffff88804665f870 R08: 0000000000000000 R09: ffff888035922480
R10: ffffffff8bcceb60 R11: ffffed1008ccbf05 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88804665f818 R15: 1ffff11008ccbf04
FS:  00007fe0f01196c0(0000) GS:ffff88808ca5b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe0f0118ff8 CR3: 000000004158f000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:1038 [inline]
 end_dirop fs/namei.c:2947 [inline]
 end_creating include/linux/namei.h:126 [inline]
 end_creating_path fs/namei.c:4962 [inline]
 filename_mkdirat+0x305/0x510 fs/namei.c:5271
 __do_sys_mkdir fs/namei.c:5293 [inline]
 __se_sys_mkdir+0x34/0x150 fs/namei.c:5290
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe0ef19c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe0f0119028 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007fe0ef416090 RCX: 00007fe0ef19c629
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000040
RBP: 00007fe0ef232b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe0ef416128 R14: 00007fe0ef416090 R15: 00007ffff03e4318
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	49 c7 c2 80 eb cc 8b 	mov    $0xffffffff8bcceb80,%r10
   7:	4c 0f 44 d0          	cmove  %rax,%r10
   b:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  10:	48 c7 c6 e0 ed cc 8b 	mov    $0xffffffff8bccede0,%rsi
  17:	48 8b 14 24          	mov    (%rsp),%rdx
  1b:	4c 89 f1             	mov    %r14,%rcx
  1e:	4d 89 e0             	mov    %r12,%r8
  21:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
  26:	41 52                	push   %r10
* 28:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2d:	48 83 c4 08          	add    $0x8,%rsp
  31:	e8 0a 0c 0b 03       	call   0x30b0c40
  36:	e9 67 fd ff ff       	jmp    0xfffffda2
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	c1                   	.byte 0xc1


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

