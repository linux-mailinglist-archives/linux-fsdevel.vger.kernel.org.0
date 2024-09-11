Return-Path: <linux-fsdevel+bounces-29071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75049747F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 03:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71891C25CF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 01:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2C25762;
	Wed, 11 Sep 2024 01:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi/SRwpE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B38460;
	Wed, 11 Sep 2024 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726019299; cv=none; b=jNehfqXIzhEhvu2BMO1Nhc5auxlDLNqz1UrPF6Tn89UKixUo0A3n5S2Q6Knsf36i04J2trpM7PRXSoF200TDJ0dR0bTmoK2VQU6udiYEBN4jidVn7Lw39CWnPAm6p5OWTUktQTr8L7q5ooPv7k+9BBi6uOCr7c4P9axcChjOvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726019299; c=relaxed/simple;
	bh=wu9D8GMK4xddW2kkLvlhjUZNk9I/s0JwheSYbmR6ou8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ijTY6iK7gdBY9zp0FPKbjKjIDdezukquG2j3VGsN8yeXXFBTEI4Ab5osIUWOXrgIZ+pIn7wf+sv4/EhZvOshCz+XU8YxuhMU5Rsv62fkKHz2FgvlRi7GSRlRKjXjq4sstMijmrBkdNr/wfnqAoDKHRZgvetd8mEkEo94D8mQCgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi/SRwpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB910C4CEC3;
	Wed, 11 Sep 2024 01:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726019298;
	bh=wu9D8GMK4xddW2kkLvlhjUZNk9I/s0JwheSYbmR6ou8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Hi/SRwpE36fpJCz5j0QZeerRwMyGw8YcM4mHzTNV9DzlCQVEIrPbUrFapPuMDfsL1
	 PjOhgRNIZpqc7dbSW3bhabapqo7858L8HAXpBJ31uEmhvGIwexGQwOwzeWnB1KbqEI
	 g/Ae43cGsNYAu+x6wWKKxvaFmApbwOr0+X0nkVPSru57gzR4zkk74GA7DMMdqfTzU1
	 WVjnsSTnPulUaa71RCxtOnQNMFcpWLd/ablF7ka91Frdt4HP7PIIzq1eD+nnXuK+RD
	 p3eEylvuL/fvXMPh5DFeR2ycjBnMoOthaR2Hm0H4o+kkGODMb1eyxyahpi1hJUCt9k
	 zNFL5RXOzg+Kw==
Message-ID: <2fba030d-bd24-4a3d-852e-e10a484feaaf@kernel.org>
Date: Wed, 11 Sep 2024 09:48:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
To: syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>
References: <000000000000b90a8e061e21d12f@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <000000000000b90a8e061e21d12f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip

On 2024/7/26 15:54, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14955423980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
> dashboard link: https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1237a1f1980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115edac9980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e3f4ec8ccf7c/disk-1722389b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f19bcd908282/vmlinux-1722389b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d93604974a98/bzImage-1722389b.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/e0d10e1258f5/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 58 at kernel/rcu/sync.c:177 rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
> Modules linked in:
> CPU: 1 UID: 0 PID: 58 Comm: kworker/1:2 Not tainted 6.10.0-syzkaller-12562-g1722389b0d86 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> Workqueue: events destroy_super_work
> RIP: 0010:rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
> Code: 74 19 e8 86 d5 00 00 43 0f b6 44 25 00 84 c0 0f 85 82 00 00 00 41 83 3f 00 75 1d 5b 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 <0f> 0b 90 e9 66 ff ff ff 90 0f 0b 90 eb 89 90 0f 0b 90 eb dd 44 89
> RSP: 0018:ffffc9000133fb30 EFLAGS: 00010246
> RAX: 0000000000000002 RBX: 1ffff11005324477 RCX: ffff8880163f5a00
> RDX: 0000000000000000 RSI: ffffffff8c3f9540 RDI: ffff888029922350
> RBP: 0000000000000167 R08: ffffffff82092061 R09: 1ffffffff1cbbbd4
> R10: dffffc0000000000 R11: fffffbfff1cbbbd5 R12: dffffc0000000000
> R13: 1ffff1100532446a R14: ffff888029922350 R15: ffff888029922350
> FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055557c167738 CR3: 000000007ada8000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   percpu_free_rwsem+0x41/0x80 kernel/locking/percpu-rwsem.c:42
>   destroy_super_work+0xec/0x130 fs/super.c:282
>   process_one_work kernel/workqueue.c:3231 [inline]
>   process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>   worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
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


