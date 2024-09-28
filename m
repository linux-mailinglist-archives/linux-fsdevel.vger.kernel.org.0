Return-Path: <linux-fsdevel+bounces-30302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE84988EF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 12:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E6128236E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F5719F11A;
	Sat, 28 Sep 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxA8zuIk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692CA19D88B;
	Sat, 28 Sep 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727518309; cv=none; b=Sb6I05N1Bfk8a9N/wcF2PccYayCEin58W5sf8xbmgCzzmMlUxByCl2yG7bpNYRQudzgaSxfZ0K8G2nR3qFJT4Z8FLrnqKxXvz2IrqQ8bAsJtCvNfRcuwy23f6qSS8NcKGX5G3/fVJKk3AmPjaiP1xbuQ9rz6bRxBkcMSdFWShS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727518309; c=relaxed/simple;
	bh=rK5+fYjE8LWIRBZAvkJwlIUovcCLNU3JySqq79WezGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOfbiYkiQcTnQ/GJ29fM5B/i7enfvlojohSuYwFQvPT0nQV9SLX+j/DI4HcjRDPKPQVzAQ6ocGXrchrsuJRFvogbEGkkMr7ztvLR6HCNWZHWEBGHc4r4eFpXzjpRQc4zQLMdSiNXulO8h4Pm9WyHpP0n242mUvvo+tixl7qoJaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxA8zuIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1DAC4CEC3;
	Sat, 28 Sep 2024 10:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727518308;
	bh=rK5+fYjE8LWIRBZAvkJwlIUovcCLNU3JySqq79WezGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxA8zuIk7Cn2UIoAan4F+WYNC1fCAeQ/UEr8TcicmeAUaFOoxFOuCOUvgW+Z6IKiA
	 4UQCwHRXkT1h6eAk6EvnJCIT3AVu/6UbnycaBu3mjmDfmmq4JyQog8BHBZyTRX0AA2
	 qETftd1uO5AxQB/fkgv9fTG8nvx3XKPjwVGUgmbSfp4ELzunrSdi4xJnrbNbh0z1Ja
	 kT0yumcqeaWltsvRK1vBDA7rIzg5epgF2+OtqsypmxfAGldcYkZGt0whGidQmTK7S8
	 pRln8I7Z/pvKZ7JJrF3Vw/Y8pzzsl+bFo34JVgmcKesBjNxEC+/d4mQuvVyja9TjoJ
	 nW+WkxjAb3jJw==
Date: Sat, 28 Sep 2024 13:11:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs netfs
Message-ID: <20240928101143.GH967758@unreal>
References: <20240927163423.GG967758@unreal>
 <20240926174043.GA2166429@unreal>
 <20240913-vfs-netfs-39ef6f974061@brauner>
 <2238233.1727424079@warthog.procyon.org.uk>
 <2631083.1727469088@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2631083.1727469088@warthog.procyon.org.uk>

On Fri, Sep 27, 2024 at 09:31:28PM +0100, David Howells wrote:
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > I hope that you mean that we have plenty of time before the merge window ends.
> > Otherwise, it will be very inconvenient to open official -next/-rc branches,
> > based on -rc1, remembering to revert so many commits.
> 
> Yes, I'm aware of the time, thank you.
> 
> Can you please try the branch at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes
> 
> see if it fixes your problem?  It runs through -g quick with 9p over TCP for
> me.

I tried it now and it didn't fix my issue.
➜  kernel git:(netfs-fixes) git l
8e18fe180b0a netfs: Abstract out a rolling folio buffer implementation

[    1.506633][    T1] Run /sbin/init as init process
[    1.506800][    T1]   with arguments:
[    1.506895][    T1]     /sbin/init
[    1.507004][    T1]   with environment:
[    1.507104][    T1]     HOME=/
[    1.507201][    T1]     TERM=linux
[    1.512981][    T1] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6ce48
[    1.513934][    T1] flags: 0x4000000000000000(zone=1)
[    1.514142][    T1] raw: 4000000000000000 ffffea0001b39248 ffffea00001583c8 0000000000000000
[    1.514536][    T1] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[    1.514796][    T1] page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))
[    1.515087][    T1] ------------[ cut here ]------------
[    1.515231][    T1] kernel BUG at include/linux/mm.h:1444!
[    1.515375][    T1] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
[    1.515596][    T1] CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0+ #2546
[    1.515823][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.516153][    T1] RIP: 0010:__iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.516345][    T1] Code: 84 f2 fa ff ff 48 89 ef e8 c9 20 98 ff e9 e5 fa ff ff 48 8d 48 ff e9 2c fe ff ff 48 c7 c6 00 eb 21 83 48 89 cf e8 fc 25 8a ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 8b 74 24 68 44 8b 5c 24 30
[    1.516874][    T1] RSP: 0000:ffff8880060f6e40 EFLAGS: 00010286
[    1.517126][    T1] RAX: 000000000000005c RBX: ffffea0001b39234 RCX: 0000000000000000
[    1.517434][    T1] RDX: 000000000000005c RSI: 0000000000000004 RDI: ffffed1000c1edbb
[    1.517676][    T1] RBP: dffffc0000000000 R08: 0000000000000000 R09: fffffbfff0718ce0
[    1.517898][    T1] R10: 0000000000000003 R11: 0000000000000001 R12: ffff88800950f420
[    1.518111][    T1] R13: ffff88800aba0c00 R14: 0000000000000002 R15: 0000000000001000
[    1.518321][    T1] FS:  0000000000000000(0000) GS:ffff88806d000000(0000) knlGS:0000000000000000
[    1.518587][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.518804][    T1] CR2: 0000000000000000 CR3: 0000000003881001 CR4: 0000000000370eb0
[    1.519058][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.519302][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.519553][    T1] Call Trace:
[    1.519687][    T1]  <TASK>
[    1.519790][    T1]  ? __die+0x52/0x8f
[    1.519947][    T1]  ? die+0x2a/0x50
[    1.520107][    T1]  ? do_trap+0x1d9/0x2c0
[    1.520227][    T1]  ? __iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.520421][    T1]  ? do_error_trap+0xa3/0x160
[    1.520599][    T1]  ? __iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.520813][    T1]  ? handle_invalid_op+0x2c/0x30
[    1.520991][    T1]  ? __iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.521245][    T1]  ? exc_invalid_op+0x29/0x40
[    1.521438][    T1]  ? asm_exc_invalid_op+0x16/0x20
[    1.521601][    T1]  ? __iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.521799][    T1]  ? iov_iter_extract_pages+0x1ee0/0x1ee0
[    1.521954][    T1]  ? radix_tree_node_alloc.constprop.0+0x16a/0x2c0
[    1.522148][    T1]  ? lock_acquire+0xe2/0x500
[    1.522308][    T1]  ? mark_lock+0xfc/0x2dc0
[    1.522462][    T1]  iov_iter_get_pages_alloc2+0x3d/0xe0
[    1.522624][    T1]  ? print_usage_bug.part.0+0x600/0x600                                                                                                                 
[    1.522795][    T1]  p9_get_mapped_pages.part.0.constprop.0+0x3bf/0x6c0
[    1.523025][    T1]  ? p9pdu_vwritef+0x320/0x1f20
[    1.523239][    T1]  ? p9_virtio_request+0x550/0x550
[    1.523427][    T1]  ? pdu_read+0xc0/0xc0
[    1.523551][    T1]  ? lock_release+0x220/0x780
[    1.523714][    T1]  ? pdu_read+0xc0/0xc0
[    1.523824][    T1]  p9_virtio_zc_request+0x728/0x1020
[    1.523975][    T1]  ? p9pdu_vwritef+0x320/0x1f20
[    1.524119][    T1]  ? p9_virtio_probe+0xa20/0xa20
[    1.524271][    T1]  ? netfs_read_to_pagecache+0x600/0xd90
[    1.524424][    T1]  ? mark_lock+0xfc/0x2dc0
[    1.524586][    T1]  ? p9pdu_finalize+0xdc/0x1d0
[    1.524762][    T1]  ? p9_client_prepare_req+0x235/0x360
[    1.524918][    T1]  ? p9_tag_alloc+0x6e0/0x6e0
[    1.525084][    T1]  ? lock_release+0x220/0x780
[    1.525241][    T1]  p9_client_zc_rpc.constprop.0+0x236/0x7d0
[    1.525434][    T1]  ? __create_object+0x5e/0x80
[    1.525595][    T1]  ? p9_client_flush.isra.0+0x390/0x390
[    1.525746][    T1]  ? lockdep_hardirqs_on_prepare+0x268/0x3e0
[    1.525911][    T1]  ? __call_rcu_common.constprop.0+0x475/0xc80
[    1.526092][    T1]  ? p9_req_put+0x17a/0x200
[    1.526226][    T1]  p9_client_read_once+0x343/0x840
[    1.526361][    T1]  ? p9_client_getlock_dotl+0x3c0/0x3c0
[    1.526501][    T1]  p9_client_read+0xf1/0x150
[    1.526649][    T1]  v9fs_issue_read+0x107/0x300
[    1.526788][    T1]  ? v9fs_issue_write+0x140/0x140
[    1.526934][    T1]  ? __rwlock_init+0x150/0x150
[    1.527073][    T1]  ? lockdep_hardirqs_on_prepare+0x268/0x3e0
[    1.527249][    T1]  netfs_read_to_pagecache+0x600/0xd90
[    1.527396][    T1]  netfs_readahead+0x47a/0x960
[    1.527552][    T1]  read_pages+0x17b/0xaf0
[    1.527676][    T1]  ? lru_move_tail+0x8f0/0x8f0
[    1.527842][    T1]  ? file_ra_state_init+0xd0/0xd0
[    1.528004][    T1]  page_cache_ra_unbounded+0x324/0x5f0
[    1.528167][    T1]  filemap_get_pages+0x597/0x16b0
[    1.528324][    T1]  ? filemap_add_folio+0x140/0x140
[    1.528476][    T1]  ? lock_is_held_type+0x81/0xe0
[    1.528637][    T1]  filemap_read+0x2ec/0xa90
[    1.528799][    T1]  ? filemap_get_pages+0x16b0/0x16b0
[    1.528969][    T1]  ? 0xffffffff81000000
[    1.529090][    T1]  ? find_held_lock+0x2d/0x110
[    1.529286][    T1]  ? lock_is_held_type+0x81/0xe0
[    1.529437][    T1]  ? down_read_interruptible+0x1f6/0x490
[    1.529601][    T1]  ? down_read+0x450/0x450
[    1.529748][    T1]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[    1.529953][    T1]  ? find_held_lock+0x2d/0x110
[    1.530098][    T1]  netfs_buffered_read_iter+0xe2/0x130
[    1.530254][    T1]  ? netfs_file_read_iter+0xb2/0x130
[    1.530398][    T1]  __kernel_read+0x2db/0x8a0
[    1.530554][    T1]  ? __x64_sys_lseek+0x1d0/0x1d0
[    1.530700][    T1]  bprm_execve+0x548/0x1410
[    1.530864][    T1]  ? setup_arg_pages+0xb40/0xb40
[    1.531007][    T1]  ? __cond_resched+0x17/0x70
[    1.531152][    T1]  kernel_execve+0x26a/0x2f0
[    1.531296][    T1]  try_to_run_init_process+0xf/0x30
[    1.531445][    T1]  ? rest_init+0x1b0/0x1b0
[    1.531595][    T1]  kernel_init+0xe2/0x140
[    1.531704][    T1]  ? _raw_spin_unlock_irq+0x24/0x30
[    1.531862][    T1]  ret_from_fork+0x2d/0x70
[    1.532013][    T1]  ? rest_init+0x1b0/0x1b0
[    1.532162][    T1]  ret_from_fork_asm+0x11/0x20
[    1.532342][    T1]  </TASK>
[    1.532463][    T1] Modules linked in:
[    1.532679][    T1] ---[ end trace 0000000000000000 ]---
[    1.532827][    T1] RIP: 0010:__iov_iter_get_pages_alloc+0x16d4/0x2210
[    1.533109][    T1] Code: 84 f2 fa ff ff 48 89 ef e8 c9 20 98 ff e9 e5 fa ff ff 48 8d 48 ff e9 2c fe ff ff 48 c7 c6 00 eb 21 83 48 89 cf e8 fc 25 8a ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 8b 74 24 68 44 8b 5c 24 30
[    1.533633][    T1] RSP: 0000:ffff8880060f6e40 EFLAGS: 00010286
[    1.533847][    T1] RAX: 000000000000005c RBX: ffffea0001b39234 RCX: 0000000000000000
[    1.534054][    T1] RDX: 000000000000005c RSI: 0000000000000004 RDI: ffffed1000c1edbb
[    1.534261][    T1] RBP: dffffc0000000000 R08: 0000000000000000 R09: fffffbfff0718ce0
[    1.534459][    T1] R10: 0000000000000003 R11: 0000000000000001 R12: ffff88800950f420
[    1.534668][    T1] R13: ffff88800aba0c00 R14: 0000000000000002 R15: 0000000000001000
[    1.534878][    T1] FS:  0000000000000000(0000) GS:ffff88806d000000(0000) knlGS:0000000000000000
[    1.535129][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.535309][    T1] CR2: 0000000000000000 CR3: 0000000003881001 CR4: 0000000000370eb0
[    1.535517][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.535734][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.535953][    T1] ------------[ cut here ]------------


> 
> David
> 

