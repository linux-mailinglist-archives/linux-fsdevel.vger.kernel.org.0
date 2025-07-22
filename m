Return-Path: <linux-fsdevel+bounces-55707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA3B0E29E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A331567F29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CA627E056;
	Tue, 22 Jul 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BShZqh2i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC595234
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205485; cv=none; b=uHLuzKGDYXfyVDTeMay4W8f3mklayKHFvURbooBp5o1KdK1N0e38NgIbt5LGA6btR/AOPPSREOTEJbBvr70FKnN884/6jrth1i3JTPFAhKdK80Fth3tWUJcphiWYP6PKZyGz3y4+obnF4M/URxSHibOJiiMOkLjDRMYjobfffFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205485; c=relaxed/simple;
	bh=PrQAZTg14IOAm+DRtwIuL1ZvBzxMtVGxSxhr7HUmZVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmmQZ27dvxvemNLtyZdtHUUbOk6fq8MRB71ymqNhfEeLpdhARBPbMHE3pqz86NedJpMuESG0HQ+dPGlXddNcsTyuAU/zJT2Bh3oXd48xIvHRREe23LygxR2brxbPt8/WfDlJ6Dow5JIzM1Cj/Lj9pCjwz4bYSSHjssxRZMMcrLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BShZqh2i; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 13:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753205470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XpnmGx8Qe1HEPsT1JE8ns7neS7sOfpbPECAjbCeJMzg=;
	b=BShZqh2iCTxQIRMFWJ5QzeiI9riLGBk5t7ICvYSx3yCv/eu1n+iaCEAb8EC7JQf/zGcJ02
	nXKXIZoosXwz1sLODbgtr1YwwF6v3r6yspD0ZysAqjeMJ0IgOMt+Fj/Germb3C4mrKnNIO
	2zwQgN0tSdLyQ1Dk3sDXVX/oe8lNKE8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+0ee1ef35cf7e70ce55d7@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [kernfs?] INFO: task hung in fdget_pos
Message-ID: <cu7oc32pbuz42gsd3bsmwjns54bqhtlpdi5xlimnjx4rebp3yz@fps6oycum3rf>
References: <670658e6.050a0220.22840d.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670658e6.050a0220.22840d.0012.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 09, 2024 at 03:20:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=110fb307980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9775e9a1af839423
> dashboard link: https://syzkaller.appspot.com/bug?extid=0ee1ef35cf7e70ce55d7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0a79f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/64ef5d6cfda3/disk-fc20a3e5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/42c0ee676795/vmlinux-fc20a3e5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a3072d6383ea/bzImage-fc20a3e5.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/a8f928c45431/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0ee1ef35cf7e70ce55d7@syzkaller.appspotmail.com
> 
> INFO: task syz.2.17:5434 blocked for more than 159 seconds.
>       Not tainted 6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.2.17        state:D stack:27424 pid:5434  tgid:5432  ppid:5316   flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5315 [inline]
>  __schedule+0x1843/0x4ae0 kernel/sched/core.c:6675
>  __schedule_loop kernel/sched/core.c:6752 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6767
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
>  fdget_pos+0x24e/0x320 fs/file.c:1160
>  ksys_read+0x7e/0x2b0 fs/read_write.c:703
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f993c77dff9
> RSP: 002b:00007f993d54e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007f993c936058 RCX: 00007f993c77dff9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00007f993c7f0296 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000001 R14: 00007f993c936058 R15: 00007fffb8436518
>  </TASK>
> INFO: task syz.3.18:5439 blocked for more than 167 seconds.
>       Not tainted 6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.3.18        state:D stack:27424 pid:5439  tgid:5436  ppid:5317   flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5315 [inline]
>  __schedule+0x1843/0x4ae0 kernel/sched/core.c:6675
>  __schedule_loop kernel/sched/core.c:6752 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6767
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
>  fdget_pos+0x24e/0x320 fs/file.c:1160
>  ksys_read+0x7e/0x2b0 fs/read_write.c:703
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1134d7dff9
> RSP: 002b:00007f1135adc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007f1134f36058 RCX: 00007f1134d7dff9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00007f1134df0296 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000001 R14: 00007f1134f36058 R15: 00007ffe6e122188
>  </TASK>
> INFO: task syz.4.19:5441 blocked for more than 168 seconds.
>       Not tainted 6.12.0-rc1-syzkaller-00330-gfc20a3e57247 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.4.19        state:D stack:27424 pid:5441  tgid:5438  ppid:5327   flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5315 [inline]
>  __schedule+0x1843/0x4ae0 kernel/sched/core.c:6675
>  __schedule_loop kernel/sched/core.c:6752 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6767
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
>  fdget_pos+0x24e/0x320 fs/file.c:1160
>  ksys_read+0x7e/0x2b0 fs/read_write.c:703
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4c9ad7dff9
> RSP: 002b:00007f4c9bc43038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
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

Someone assigned this to bcachefs, and it's clearly not:

#syz set subsystems: fs kernfs

