Return-Path: <linux-fsdevel+bounces-45920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D248A7F1B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 02:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86AC3ADE61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247725EFBE;
	Tue,  8 Apr 2025 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="djZ5+E7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7225EFB8
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073513; cv=none; b=S6jYuLKrH6hjDOGiDpnEY8VtA38D0XEwxCXZQdzrtfRIOnz5CiIxwz1jOqQwEu2o9K9jQ//yhrv1fnPDKKYUJqo1zT3oMmkq8Ys3bP7iFGpB+QmIY1deJfMWZtLThES3JOmfKOdIrgbKa9KVHDISbrjxmXwtaNEWNMPm8PCB1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073513; c=relaxed/simple;
	bh=otGrTM+fxSGcq6yelD3MNpOPEUh4PYa6liVSiQgXgq8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=XdjSCYpAUsmYALpyU2ILRDu8OwmUbY6oKnxzQ4Z4zhA4AWzFEPfDnZoh7i902US1PknX+0Vuv2uMJUtqEsjmLQrf7y4HoiVreBh6stUNmwRHvBrijddL0C9FnyKZfyBRn4bn1Yd6dxYlCKJYYHHP0bRCTtE3PFxgt+EXunarKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=djZ5+E7T; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <b395436343d8df2efdebb737580fe976@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1744073508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMuKSUtZuVZwIpMHPl0nE/X6Q9X3ze9GVg1L2gw4mcY=;
	b=djZ5+E7TlQKN0U7snJwHCvAp5bV4naZEONlwz1pDLjE+xuvBvDTh5M8mzEMGg2L078BpfW
	31ei3oe6Kx9HsZ/7avrEHkVozfmG4JFQJqQfM4iNTkOIQ4jmaV6yCzCijRwXAvTl7+uCc/
	MUDKAE8MsvComBz8t3SBXOHYDTQ35DSaMQJWkh6r/3S8V9BNhEnPBSd7K5yO0TopbnDnmw
	zXKgA2UUsv2sLYa8sbqJRLhXP39EmQuo3CIeBzWq33X8VVqEai7E1NMjfADYwKjmK1Gco8
	6f5uy2WD9EABTRBH++3xQdCfagMTHQR2TaUv65KcXvaJAw1GLctLSXAoS2XfIQ==
From: Paulo Alcantara <pc@manguebit.com>
To: Song Liu <song@kernel.org>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Cc: dhowells@redhat.com, kernel-team@fb.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH] netfs: Let netfs depends on PROC_FS
In-Reply-To: <notmuch-sha1-7bf7bb81673494d9bbe96c6cfbeaf9005a6bd491>
References: <20250407184730.3568147-1-song@kernel.org>
Date: Mon, 07 Apr 2025 21:51:41 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Song,

Paulo Alcantara <pc@manguebit.com> writes:

> Song Liu <song@kernel.org> writes:
>
>> When testing a special config:
>>
>> CONFIG_NETFS_SUPPORTS=y
>> CONFIG_PROC_FS=n
>>
>> The system crashes with something like:
>>
>> [    3.766197] ------------[ cut here ]------------
>> [    3.766484] kernel BUG at mm/mempool.c:560!
>> [    3.766789] Oops: invalid opcode: 0000 [#1] SMP NOPTI
>> [    3.767123] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W
>> [    3.767777] Tainted: [W]=WARN
>> [    3.767968] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> [    3.768523] RIP: 0010:mempool_alloc_slab.cold+0x17/0x19
>> [    3.768847] Code: 50 fe ff 58 5b 5d 41 5c 41 5d 41 5e 41 5f e9 93 95 13 00
>> [    3.769977] RSP: 0018:ffffc90000013998 EFLAGS: 00010286
>> [    3.770315] RAX: 000000000000002f RBX: ffff888100ba8640 RCX: 0000000000000000
>> [    3.770749] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000ffffffff
>> [    3.771217] RBP: 0000000000092880 R08: 0000000000000000 R09: ffffc90000013828
>> [    3.771664] R10: 0000000000000001 R11: 00000000ffffffea R12: 0000000000092cc0
>> [    3.772117] R13: 0000000000000400 R14: ffff8881004b1620 R15: ffffea0004ef7e40
>> [    3.772554] FS:  0000000000000000(0000) GS:ffff8881b5f3c000(0000) knlGS:0000000000000000
>> [    3.773061] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    3.773443] CR2: ffffffff830901b4 CR3: 0000000004296001 CR4: 0000000000770ef0
>> [    3.773884] PKRU: 55555554
>> [    3.774058] Call Trace:
>> [    3.774232]  <TASK>
>> [    3.774371]  mempool_alloc_noprof+0x6a/0x190
>> [    3.774649]  ? _printk+0x57/0x80
>> [    3.774862]  netfs_alloc_request+0x85/0x2ce
>> [    3.775147]  netfs_readahead+0x28/0x170
>> [    3.775395]  read_pages+0x6c/0x350
>> [    3.775623]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    3.775928]  page_cache_ra_unbounded+0x1bd/0x2a0
>> [    3.776247]  filemap_get_pages+0x139/0x970
>> [    3.776510]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    3.776820]  filemap_read+0xf9/0x580
>> [    3.777054]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    3.777368]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    3.777674]  ? find_held_lock+0x32/0x90
>> [    3.777929]  ? netfs_start_io_read+0x19/0x70
>> [    3.778221]  ? netfs_start_io_read+0x19/0x70
>> [    3.778489]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    3.778800]  ? lock_acquired+0x1e6/0x450
>> [    3.779054]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [    3.779379]  netfs_buffered_read_iter+0x57/0x80
>> [    3.779670]  __kernel_read+0x158/0x2c0
>> [    3.779927]  bprm_execve+0x300/0x7a0
>> [    3.780185]  kernel_execve+0x10c/0x140
>> [    3.780423]  ? __pfx_kernel_init+0x10/0x10
>> [    3.780690]  kernel_init+0xd5/0x150
>> [    3.780910]  ret_from_fork+0x2d/0x50
>> [    3.781156]  ? __pfx_kernel_init+0x10/0x10
>> [    3.781414]  ret_from_fork_asm+0x1a/0x30
>> [    3.781677]  </TASK>
>> [    3.781823] Modules linked in:
>> [    3.782065] ---[ end trace 0000000000000000 ]---
>>
>> This is caused by the following error path in netfs_init():
>>
>>         if (!proc_mkdir("fs/netfs", NULL))
>>                 goto error_proc;
>>
>> Fix this by letting netfs depends on PROC_FS.
>>
>> Signed-off-by: Song Liu <song@kernel.org>
>> ---
>>  fs/netfs/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>

Sorry, I take it back.  Reviewed it way too soon :-/

It wouldn't make sense to make it depend on PROC_FS.

I see two problems here:

(1) We shouldn't be creating /proc/fs/netfs if CONFIG_PROC_FS=n

(2) There's a wrong assumption in the API that @netfs_request_pool and
@netfs_subrequest_pool will always be initialized.  For example, we
should return an error from netfs_alloc_[sub]rquest() functions in case
@mempool == NULL.

Dave, any thoughts?

