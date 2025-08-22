Return-Path: <linux-fsdevel+bounces-58840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB4B3206B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EB31CC35E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED4928137A;
	Fri, 22 Aug 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w5HR0ADz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8eHg1iS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDB279DC3;
	Fri, 22 Aug 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879646; cv=none; b=njM/abb9UciWRjdDsqaA48fj8W72s5xPIDZakasq5AjImq67gmfCsUB7R2PBo5EXOErT8TY/9OIzc8CdFhNFz3y0uFwfcXsq/XhwuSqzLNRyX6Y/KGOiwyRmWmzpSXqPLwBqBlM5S/ZTWKh1szjBgtw22FOqzViRuS6vZzUBKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879646; c=relaxed/simple;
	bh=pUefhvtx3fa9NKd7t7x8qj/cQQxg+Sux7Educwfd/bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hy0KI4rtAvOOW1U22qs/lj03E3tQIwkn9faiR8KzJfNmmAwcr3A/3mmT4bgFADdUiuv8KqNI+5CbHh2qk0aDNNAcUK1dIeqGF5VzPlCCwizThVinxG4X0QqmjzMwDRxqcNV62YQ5zKIcbKCe4qjllcM70m8Z4FPChHc99BifLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w5HR0ADz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8eHg1iS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 18:20:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755879643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtQFGIIZgwtLl5kOnn6MiSKJx7hARPjf03xjlGYheR0=;
	b=w5HR0ADzMEB1gfQs/FxLabGL0IVBvCgZa4l5SuQsyDFRdOPQx+ZhKiqJI34Wuj3hVmGW06
	hQUEDXb8L3M7t2jUIhXFFH/hjM17MRMoc4Kopg+FHAMWPmBW7NXiFLa+RdBquNMoXzAfsW
	UpJCcUEzYibM2RtnROSzOdl8Aec92GC3w5PvTONy6O6laAF7hZNei5od2tj7DkomsFNgk3
	Klz4WEA/ytY8c78nOd6bpPXZV+elMG8zSoYJ56J0RXGp+KB79bdHrhWQKF9taPQ79DW+fy
	p5aDZ6WrsELON3+KwZN9UAtQuOyYEQssQnIqeyABWgdGook1WhCrDuZAjn9MUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755879643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtQFGIIZgwtLl5kOnn6MiSKJx7hARPjf03xjlGYheR0=;
	b=t8eHg1iSaaYcDhGsPl+SqXNKwRd9lmq9DvOkVx/LQLla7fm/FVfwAYbPCLYQOTXimi7WmX
	yQ9e7cWWtwYKCiDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: syzbot <syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [exfat?] [ext4?] WARNING in __rt_mutex_slowlock_locked
Message-ID: <20250822162041.gXcLgwIW@linutronix.de>
References: <68a72860.050a0220.3d78fd.002a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <68a72860.050a0220.3d78fd.002a.GAE@google.com>

On 2025-08-21 07:08:32 [-0700], syzbot wrote:
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da725ab460fc1def=
9896f
=E2=80=A6
> The issue was bisected to:
>=20
> commit d2d6422f8bd17c6bb205133e290625a564194496
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Fri Sep 6 10:59:04 2024 +0000
>=20
>     x86: Allow to enable PREEMPT_RT.
>=20
=E2=80=A6
> exFAT-fs (loop0): Medium has reported failures. Some data may be lost.
> exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum :=
 0xe5674ec2, utbl_chksum : 0xe619d30d)
> ------------[ cut here ]------------
> rtmutex deadlock detected
> WARNING: CPU: 0 PID: 6000 at kernel/locking/rtmutex.c:1674 rt_mutex_handl=
e_deadlock kernel/locking/rtmutex.c:1674 [inline]
> WARNING: CPU: 0 PID: 6000 at kernel/locking/rtmutex.c:1674 __rt_mutex_slo=
wlock kernel/locking/rtmutex.c:1734 [inline]
> WARNING: CPU: 0 PID: 6000 at kernel/locking/rtmutex.c:1674 __rt_mutex_slo=
wlock_locked+0xed2/0x25e0 kernel/locking/rtmutex.c:1760

RT detected a deadlock and complained. The same testcase on !RT results
in:

| [   15.363878] loop0: detected capacity change from 0 to 256
| [   15.367981] exFAT-fs (loop0): Volume was not properly unmounted. Some =
data may be corrupt. Please run fsck.
| [   15.373808] exFAT-fs (loop0): Medium has reported failures. Some data =
may be lost.
| [   15.380396] exFAT-fs (loop0): failed to load upcase table (idx : 0x000=
10000, chksum : 0xe5674ec2, utbl_chksum : 0xe619d30d)
| [   62.668182] INFO: task exfat-repro:2155 blocked for more than 30 secon=
ds.
| [   62.669405]       Not tainted 6.17.0-rc2+ #10
| [   62.670181] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
| [   62.671612] task:exfat-repro     state:D stack:0     pid:2155  tgid:21=
55  ppid:1      task_flags:0x400140 flags:0x00004006
| [   62.673557] Call Trace:
| [   62.674008]  <TASK>
| [   62.674400]  __schedule+0x4ef/0xbb0
| [   62.675069]  schedule+0x22/0xd0
| [   62.675656]  schedule_preempt_disabled+0x10/0x20
| [   62.676495]  rwsem_down_write_slowpath+0x1e2/0x6c0
| [   62.679028]  down_write+0x66/0x70
| [   62.679645]  vfs_rename+0x5c6/0xc30
| [   62.681734]  do_renameat2+0x3c4/0x570
| [   62.682395]  __x64_sys_renameat2+0x7b/0xc0
| [   62.683187]  do_syscall_64+0x7f/0x290
| [   62.695576]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

After ctrl+c that testcase terminates but one thread remains in D state.
This is from=20
|         lock_new_subdir =3D new_dir !=3D old_dir || !(flags & RENAME_EXCH=
ANGE);
|         if (is_dir) {
|                 if (lock_old_subdir)
|                         inode_lock_nested(source, I_MUTEX_CHILD);
                          ^^^
| 5 locks held by exfat-repro/2156:
|  #0: ffff888113b69400 (sb_writers#11){.+.+}-{0:0}, at: do_renameat2+0x1c8=
/0x580
|  #1: ffff888113b69710 (&type->s_vfs_rename_key){+.+.}-{4:4}, at: do_renam=
eat2+0x24d/0x580
|  #2: ffff88810fb79b88 (&sb->s_type->i_mutex_key#16/1){+.+.}-{4:4}, at: lo=
ck_two_directories+0x6c/0x110
|  #3: ffff88810fb7a1c0 (&sb->s_type->i_mutex_key#17/5){+.+.}-{4:4}, at: lo=
ck_two_directories+0x82/0x110
|  #4: ffffffff82f618a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_loc=
ks+0x3d/0x184

#2 and #3 are from the "(r =3D=3D p1)" case. The lock it appears to acquire
is #2.
Could an exfat take a look, please?

Sebastian

