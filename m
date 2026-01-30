Return-Path: <linux-fsdevel+bounces-75926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GKyK242fGmvLQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 05:41:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA7B7204
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 05:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B56F830125EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 04:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62324679C;
	Fri, 30 Jan 2026 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oc1YHuRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413461B4138
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769748071; cv=none; b=p5ikzuajgnD5ZPbbHuPPXY+7zUDDU46f3NKIsgJh9jy2gIR4rLt0z7gfGo2D6GwHxYL7NJIyejjGf0h7q1rYqJey461chzqEZvWtxooCkz7tg4YQ1tXnN/KKsRlaZZHuuF8LloAW4+Z0FngnrJMJ9amBMJRZcX5GXaTB2aEY3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769748071; c=relaxed/simple;
	bh=1Cyos39adMrdgVLY0jZzM0tZluNimrJHAEGHgnHbxB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiKm2bHwPluKOfC+GeX9jdEnOI/S2jaEQlr6aYoHQJRlbDUvuunPEaKXIPnyfoictUK7rHT378naD5qRZiM7fEoM3XtVSaYw3YcQmLyEMuqWUOKCxiGN2LiZ5w4yEbNQqVkZlrntuFgD573dflOvXl/EeMsrDJZoi0k8mKciuU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oc1YHuRP; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCXx/efCft+UJ1Vmx3GqBd/r75VoVUkhBUdVC75Ur+fwhgX+0xA1L/BM8VoxwrHPvxk61MtJrulUjdTa1B54@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769748066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poUS4vM9rHYGHWvOUpUh/Id1h6SEo5+dkcFnRx9fiFc=;
	b=Oc1YHuRPF7b520kK7B12u7I5Uc7I7FZzctLyVdx08SyzzqAhZUG2eMYtBbyw5XAwm3W6Gk
	K1PuRwdxW3ClvSsdLnR7bJgIZXKpayXB1UYcsrNTaYgazM+MUFt7cXr3RyV+ZAy+CBf6QO
	wyt9hzDcz/U1lf8rlmTRwaKkoLOr7vo=
X-Gm-Message-State: AOJu0Yy8eSSZtQIKPjZJCZwLAnMVnwbiAca2AbzvqnFCwfPUGeH5Ezpm
	xY8HXSvtsMlpfDAondYKB1zeDComU/5UEP3X5S8iOxEzD16rd723t4z+RYZ8BfnFPcAnbnwI/1X
	7N4VcYjNcca4LSozsBmkIB/Iznu6WQf8=
X-Received: by 2002:a05:6102:2920:b0:5f5:2e63:f571 with SMTP id
 ada2fe7eead31-5f8e24e04f3mr566640137.19.1769748062182; Thu, 29 Jan 2026
 20:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129215340.3742283-1-andrii@kernel.org>
In-Reply-To: <20260129215340.3742283-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Thu, 29 Jan 2026 20:40:51 -0800
X-Gmail-Original-Message-ID: <CAGj-7pXkzS1sioE9t_wXZK=w0O-FDK3k4n6oEsruhnc1X_0=rQ@mail.gmail.com>
X-Gm-Features: AZwV_Qg5dfk2ht8JupIDFXTqsdxMg36LioUN_5yZDOZCUGFX3Rv7JHpElpOR8RI
Message-ID: <CAGj-7pXkzS1sioE9t_wXZK=w0O-FDK3k4n6oEsruhnc1X_0=rQ@mail.gmail.com>
Subject: Re: [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
To: Andrii Nakryiko <andrii@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75926-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,appspotmail.com:email,linux.dev:email,linux.dev:dkim]
X-Rspamd-Queue-Id: 18FA7B7204
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 1:53=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_loc=
k or
> per-VMA lock, whichever was used to lock VMA under question, to avoid dea=
dlock
> reported by syzbot:
>
>  -> #1 (&mm->mmap_lock){++++}-{4:4}:
>         __might_fault+0xed/0x170
>         _copy_to_iter+0x118/0x1720
>         copy_page_to_iter+0x12d/0x1e0
>         filemap_read+0x720/0x10a0
>         blkdev_read_iter+0x2b5/0x4e0
>         vfs_read+0x7f4/0xae0
>         ksys_read+0x12a/0x250
>         do_syscall_64+0xcb/0xf80
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
>         __lock_acquire+0x1509/0x26d0
>         lock_acquire+0x185/0x340
>         down_read+0x98/0x490
>         blkdev_read_iter+0x2a7/0x4e0
>         __kernel_read+0x39a/0xa90
>         freader_fetch+0x1d5/0xa80
>         __build_id_parse.isra.0+0xea/0x6a0
>         do_procmap_query+0xd75/0x1050
>         procfs_procmap_ioctl+0x7a/0xb0
>         __x64_sys_ioctl+0x18e/0x210
>         do_syscall_64+0xcb/0xf80
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  other info that might help us debug this:
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    rlock(&mm->mmap_lock);
>                                 lock(&sb->s_type->i_mutex_key#8);
>                                 lock(&mm->mmap_lock);
>    rlock(&sb->s_type->i_mutex_key#8);
>
>   *** DEADLOCK ***
>
> To make this safe, we need to grab file refcount while VMA is still locke=
d, but
> other than that everything is pretty straightforward. Internal build_id_p=
arse()
> API assumes VMA is passed, but it only needs the underlying file referenc=
e, so
> just add another variant build_id_parse_file() that expects file passed
> directly.
>
> Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for=
 /proc/<pid>/maps")
> Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Tested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

