Return-Path: <linux-fsdevel+bounces-45448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7033A77C5E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05327188974A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 13:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFC220459E;
	Tue,  1 Apr 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYBXCQp7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A24D8D1;
	Tue,  1 Apr 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514846; cv=none; b=gKG9/Ozg3EY5K1mejzMRHKtNIq79bpvjUKp8+685+oVq/EAR8MGVd3jKW5XDmP091bwL/lqiE6GYzLJu0K6eMsxK6x7HiiNnQiP2t9mGTTv3vNwxqOybCpH6gUQP//3MfFRwipoyJwjFhQkP01zKsedgMigPv6oLDjJwANadiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514846; c=relaxed/simple;
	bh=W2s+PbdxS5RLec2642MiC+P7mSmC/WMbqF9JswbfS4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoURDYkop8AldTAJOBpU4dPWyXZmU068sLQaFJ0G7hGCzvwkjArGKXMrk08GgljOsp3HKGZSmzV4MeR+wM214pmQvpM92gTFpm0UlV+SsEC4wDftjzITylXbdAKl03yrzZ0GpmyZW5QeMpZ2GbKOXLaG/MPNhfI1U55CqW2prVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYBXCQp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE85C4CEE5;
	Tue,  1 Apr 2025 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743514845;
	bh=W2s+PbdxS5RLec2642MiC+P7mSmC/WMbqF9JswbfS4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYBXCQp719comHnMfDQqRYID9UfioS9hS3IxSWqIWwAbED9APax6YSYdfR6qtgUtt
	 cwRvm1tcPNYivRXVYEH4BfY2ou0kXj1mrTdh7iOQOvd0CZ37HGcxggsDr+1DSCowk0
	 0Lu3YWAKsuO9GAJNtMbwIReSK6bRxUxsHjxfrdfqTieU9C/MItWCF5CR0H16hJB5gt
	 z2JpEBlV4gLi2wZ/uP/+DC6V3pKVq6MDuEENmWGI72vEXIKprjhlYOTrJmsxms2Pp7
	 9R/5fEatIuUgMQEp5CHQTbiMr5G76vpLIl2E5+ywS9EWle7MguiVdZ4EbyUuQ6nOum
	 oXaZwanrRAe1Q==
Date: Tue, 1 Apr 2025 06:40:43 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Swarna Prabhu <sw.prabhu6@gmail.com>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org, linux-mm@kvack.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, xiang@kernel.org, david@redhat.com,
	huang.ying.caritas@gmail.com, willy@infradead.org, jack@suse.cz,
	p.raghav@samsung.com, da.gomez@samsung.com, dave@stgolabs.net,
	gost.dev@samsung.com, Swarna Prabhu <s.prabhu@samsung.com>
Subject: Re: [PATCH] generic/750 : add missing _fixed_by_git_commit line to
 the test
Message-ID: <Z-vs2xvW_Vgir7yY@bombadil.infradead.org>
References: <20250401022921.983259-1-s.prabhu@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401022921.983259-1-s.prabhu@samsung.com>

On Tue, Apr 01, 2025 at 02:29:21AM +0000, Swarna Prabhu wrote:
> Testing generic/750 with older kernels indicated that more work has to
> be done, since we were able to reproduce a hang with v6.10-rc7 with 2.5
> hours soak duration. We tried to reproduce the same issue on v6.12 and could
> no longer reproduce the original hang. This motivated us to identify the commit
> 2e6506e1c4ee ("mm/migrate: fix deadlock in migrate_pages_batch() on large folios")
> that fixes the originally reported deadlock hang annotated as pending work
> to evaluate on generic/750. Hence if you are using kernel older than v6.11-rc4
> this commit is needed.
> 
> Below is the kernel trace collected on v6.10-rc7 without the above
> commit and CONFGI_PROVE_LOCKING enabled:
> 
> [ 8942.920967]  ret_from_fork_asm+0x1a/0x30
> [ 8942.921450]  </TASK>
> [ 8942.921711] INFO: task 750:2532 blocked for more than 241 seconds.                                                                                         [ 8942.922413]       Not tainted 6.10.0-rc7 #9
> [ 8942.922894] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.                                                                      [ 8942.923770] task:750             state:D stack:0     pid:2532  tgid:2532  ppid:2349   flags:0x00004002                                                     [ 8942.924820] Call Trace:
> [ 8942.925109]  <TASK>
> [ 8942.925362]  __schedule+0x465/0xe10
> [ 8942.925756]  schedule+0x39/0x140
> [ 8942.926114]  io_schedule+0x42/0x70
> [ 8942.926493]  folio_wait_bit_common+0x10e/0x330
> [ 8942.926986]  ? __pfx_wake_page_function+0x10/0x10
> [ 8942.927506]  migrate_pages_batch+0x765/0xeb0
> [ 8942.927986]  ? __pfx_compaction_alloc+0x10/0x10
> [ 8942.928488]  ? __pfx_compaction_free+0x10/0x10
> [ 8942.928983]  migrate_pages+0xbfd/0xf50
> [ 8942.929377]  ? __pfx_compaction_alloc+0x10/0x10
> [ 8942.929838]  ? __pfx_compaction_free+0x10/0x10
> [ 8942.930553]  compact_zone+0xa4d/0x11d0
> [ 8942.930936]  ? rcu_is_watching+0xd/0x40
> [ 8942.931332]  compact_node+0xa9/0x120
> [ 8942.931704]  sysctl_compaction_handler+0x71/0xd0
> [ 8942.932177]  proc_sys_call_handler+0x1b8/0x2d0
> [ 8942.932641]  vfs_write+0x281/0x530
> [ 8942.932993]  ksys_write+0x67/0xf0
> [ 8942.933381]  do_syscall_64+0x69/0x140
> [ 8942.933822]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 8942.934415] RIP: 0033:0x7f8a460215c7
> [ 8942.934843] RSP: 002b:00007fff75cf7bb0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [ 8942.935720] RAX: ffffffffffffffda RBX: 00007f8a45f8f740 RCX: 00007f8a460215c7
> [ 8942.936550] RDX: 0000000000000002 RSI: 000055e89e3a7790 RDI: 0000000000000001
> [ 8942.937405] RBP: 000055e89e3a7790 R08: 0000000000000000 R09: 0000000000000000                                                                              [ 8942.938236] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> [ 8942.939068] R13: 00007f8a4617a5c0 R14: 00007f8a46177e80 R15: 0000000000000000
> [ 8942.939902]  </TASK>
> [ 8942.940169] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
> [ 8942.941150] INFO: lockdep is turned off.
> 
> With the commit cherry picked to v6.10-rc7 , the test passes
> successfully without any hang/deadlock, however
> with CONFIG_PROVE_LOCKING enabled we do see the below trace for the
> passing case:
> 
>  BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
>  turning off the locking correctness validator.
>  CPU: 1 PID: 2959 Comm: kworker/u34:5 Not tainted 6.10.0-rc7+ #12
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
>  Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x68/0x90
>   __lock_acquire.cold+0x186/0x1b1
>   lock_acquire+0xd6/0x2e0
>   ? btrfs_get_alloc_profile+0x27/0x90 [btrfs]
>   seqcount_lockdep_reader_access+0x70/0x90 [btrfs]
>   ? btrfs_get_alloc_profile+0x27/0x90 [btrfs]
>   btrfs_get_alloc_profile+0x27/0x90 [btrfs]
>   btrfs_reserve_extent+0xa9/0x290 [btrfs]
>   btrfs_alloc_tree_block+0xa5/0x520 [btrfs]
>   ? lockdep_unlock+0x5e/0xd0
>   ? __lock_acquire+0xc6f/0x1fa0
>   btrfs_force_cow_block+0x111/0x5f0 [btrfs]
>   btrfs_cow_block+0xcc/0x2d0 [btrfs]
>   btrfs_search_slot+0x502/0xd00 [btrfs]
>   ? stack_depot_save_flags+0x24/0x8a0
>   btrfs_lookup_file_extent+0x48/0x70 [btrfs]
>   btrfs_drop_extents+0x108/0xce0 [btrfs]
>   ? _raw_spin_unlock_irqrestore+0x35/0x60
>   ? __create_object+0x5e/0x90
>   ? rcu_is_watching+0xd/0x40
>   ? kmem_cache_alloc_noprof+0x280/0x320
>   insert_reserved_file_extent+0xea/0x3a0 [btrfs]
>   ? btrfs_init_block_rsv+0x51/0x60 [btrfs]
>   btrfs_finish_one_ordered+0x3ea/0x840 [btrfs]
>   btrfs_work_helper+0x103/0x4b0 [btrfs]
>   ? lock_release+0x177/0x2e0
>   process_one_work+0x21a/0x590
>   ? lock_is_held_type+0xd5/0x130
>   worker_thread+0x1bf/0x3c0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xdd/0x110
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x2d/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Started fstests-check.scope - [systemd-run] /usr/bin/bash -c "exit 77".
>  fstests-check.scope: Deactivated successfully.
> 
> Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

