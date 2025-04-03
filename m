Return-Path: <linux-fsdevel+bounces-45612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C32A79E2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508A0173FD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4A1242900;
	Thu,  3 Apr 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ4QXInb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842124113C;
	Thu,  3 Apr 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668982; cv=none; b=KOmNw5idOfRs5omQ0StuXksQXrUq/Iet+py5j+1jMZYph6ZVgyjPFQI4NtH0a5+PacPSa0GSR1zh4oKjF/4cfj9QZoAvAlH1mwbGbgKmK4+zHogzrrXEUGJUyqBMy9uEc/EeCeGUjir/VJVN6PucuOnT/ItBUfuHAxi2Kt+ffCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668982; c=relaxed/simple;
	bh=uGsMOr+hzaR5Ta4J6v62aPI6wt3KTWrKF9LmFBOrikw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK/lXLs6KGrvdLf7S82Fiv85QFAkZKDTsBUKd5WUL5J96ukJIgY8ZmpOw0upTuQIuwFzbfUsJSJQvevpNdnf+psTs/yX47Wb/ckyCQclAeVD61O9uOoZkZn7UdsO889yCi+63RVwie7y8qBj9qnSRkZjOb8OjrYdpg33VOQXSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ4QXInb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A4EC4CEE3;
	Thu,  3 Apr 2025 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743668982;
	bh=uGsMOr+hzaR5Ta4J6v62aPI6wt3KTWrKF9LmFBOrikw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ4QXInb9muw5uYMD3cJV/6tfDv2t6loaKZG8XmHF7ggydxaGWtjsAIRbKrTB+8+u
	 4swcoFzi50t8Hi4vdgOr8NALLns6CR5bIamLzc8FfIdydlGgWKfxxsGTfzJM7GEfdd
	 N1SGqw8PIj6nDUUirop29jvNqrpMNGBXu+d1RsD6bAJHor5ncGK82tUd6hUEfvobIn
	 gKeRl/nN5cF2Lnw7eEZUkrWZyPbk4JRqrHUji3rlryvJowjTWgfyjWlMqw4byYNFpg
	 Svvng2DNG65ecsR+HvdRBNjd+cxZXJbccS67LS2gbAFYiLMBHzuEahYtYjdYsD2Lg5
	 ponUKb0iYo5MA==
Date: Thu, 3 Apr 2025 10:29:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: pr-tracker-bot@kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <20250403-bankintern-unsympathisch-03272ab45229@brauner>
References: <20250322-vfs-mount-b08c842965f4@brauner>
 <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401170715.GA112019@unreal>

On Tue, Apr 01, 2025 at 08:07:15PM +0300, Leon Romanovsky wrote:
> On Mon, Mar 24, 2025 at 09:00:59PM +0000, pr-tracker-bot@kernel.org wrote:
> > The pull request you sent on Sat, 22 Mar 2025 11:13:18 +0100:
> > 
> > > git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount
> > 
> > has been merged into torvalds/linux.git:
> > https://git.kernel.org/torvalds/c/fd101da676362aaa051b4f5d8a941bd308603041
> 
> I didn't bisect, but this PR looks like the most relevant candidate.
> The latest Linus's master generates the following slab-use-after-free:

Sorry, did just see this today. I'll take a look now.

> 
>  [ 1845.404658] ==================================================================
>  [ 1845.405460] BUG: KASAN: slab-use-after-free in clone_private_mount+0x309/0x390
>  [ 1845.406205] Read of size 8 at addr ffff8881507b5ab0 by task dockerd/8697
>  [ 1845.406847]
>  [ 1845.407081] CPU: 5 UID: 0 PID: 8697 Comm: dockerd Not tainted 6.14.0master_fbece6d #1 NONE
>  [ 1845.407086] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  [ 1845.407097] Call Trace:
>  [ 1845.407102]  <TASK>
>  [ 1845.407104]  dump_stack_lvl+0x69/0xa0
>  [ 1845.407114]  print_report+0x156/0x523
>  [ 1845.407120]  ? __virt_addr_valid+0x1de/0x3c0
>  [ 1845.407124]  ? clone_private_mount+0x309/0x390
>  [ 1845.407128]  kasan_report+0xc1/0xf0
>  [ 1845.407134]  ? clone_private_mount+0x309/0x390
>  [ 1845.407138]  clone_private_mount+0x309/0x390
>  [ 1845.407144]  ovl_fill_super+0x2965/0x59e0 [overlay]
>  [ 1845.407165]  ? ovl_workdir_create+0x900/0x900 [overlay]
>  [ 1845.407177]  ? wait_for_completion_io_timeout+0x20/0x20
>  [ 1845.407182]  ? lockdep_init_map_type+0x58/0x220
>  [ 1845.407186]  ? lockdep_init_map_type+0x58/0x220
>  [ 1845.407189]  ? shrinker_register+0x177/0x200
>  [ 1845.407194]  ? sget_fc+0x449/0xb30
>  [ 1845.407199]  ? ovl_workdir_create+0x900/0x900 [overlay]
>  [ 1845.407211]  ? get_tree_nodev+0xa5/0x130
>  [ 1845.407214]  get_tree_nodev+0xa5/0x130
>  [ 1845.407218]  ? cap_capable+0xd0/0x320
>  [ 1845.407223]  vfs_get_tree+0x83/0x2e0
>  [ 1845.407227]  ? ns_capable+0x55/0xb0
>  [ 1845.407232]  path_mount+0x891/0x1aa0
>  [ 1845.407237]  ? finish_automount+0x860/0x860
>  [ 1845.407240]  ? kmem_cache_free+0x14c/0x4f0
>  [ 1845.407245]  ? user_path_at+0x3d/0x50
>  [ 1845.407250]  __x64_sys_mount+0x2d4/0x3a0
>  [ 1845.407254]  ? path_mount+0x1aa0/0x1aa0
>  [ 1845.407259]  do_syscall_64+0x6d/0x140
>  [ 1845.407263]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1845.407267] RIP: 0033:0x55e3487f1fea
>  [ 1845.407274] Code: e8 1b 96 fa ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
>  [ 1845.407278] RSP: 002b:000000c000b563b8 EFLAGS: 00000212 ORIG_RAX: 00000000000000a5
>  [ 1845.407282] RAX: ffffffffffffffda RBX: 000000c00006c000 RCX: 000055e3487f1fea
>  [ 1845.407285] RDX: 000000c0012cf7d8 RSI: 000000c0012616c0 RDI: 000000c0012cf7d0
>  [ 1845.407287] RBP: 000000c000b56458 R08: 000000c0004fa600 R09: 0000000000000000
>  [ 1845.407289] R10: 0000000000000000 R11: 0000000000000212 R12: 000000c0012cf7d0
>  [ 1845.407291] R13: 0000000000000000 R14: 000000c00098b6c0 R15: ffffffffffffffff
>  [ 1845.407296]  </TASK>
>  [ 1845.407297]
>  [ 1845.431635] Allocated by task 17044:
>  [ 1845.432033]  kasan_save_stack+0x1e/0x40
>  [ 1845.432463]  kasan_save_track+0x10/0x30
>  [ 1845.432882]  __kasan_slab_alloc+0x62/0x70
>  [ 1845.433308]  kmem_cache_alloc_noprof+0x1a0/0x4a0
>  [ 1845.433781]  alloc_vfsmnt+0x23/0x6c0
>  [ 1845.434195]  vfs_create_mount+0x82/0x4a0
>  [ 1845.434623]  path_mount+0x939/0x1aa0
>  [ 1845.435018]  __x64_sys_mount+0x2d4/0x3a0
>  [ 1845.435440]  do_syscall_64+0x6d/0x140
>  [ 1845.435842]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1845.436355]
>  [ 1845.436601] Freed by task 0:
>  [ 1845.436945]  kasan_save_stack+0x1e/0x40
>  [ 1845.437354]  kasan_save_track+0x10/0x30
>  [ 1845.437770]  kasan_save_free_info+0x37/0x60
>  [ 1845.438217]  __kasan_slab_free+0x33/0x40
>  [ 1845.438646]  kmem_cache_free+0x14c/0x4f0
>  [ 1845.439068]  rcu_core+0x605/0x1d50
>  [ 1845.439451]  handle_softirqs+0x192/0x810
>  [ 1845.439880]  irq_exit_rcu+0x106/0x190
>  [ 1845.440280]  sysvec_apic_timer_interrupt+0x7c/0xb0
>  [ 1845.440785]  asm_sysvec_apic_timer_interrupt+0x16/0x20
>  [ 1845.441300]
>  [ 1845.441544] Last potentially related work creation:
>  [ 1845.442048]  kasan_save_stack+0x1e/0x40
>  [ 1845.442465]  kasan_record_aux_stack+0x97/0xa0
>  [ 1845.442921]  __call_rcu_common.constprop.0+0x6d/0xb40
>  [ 1845.443437]  task_work_run+0x111/0x1f0
>  [ 1845.443851]  syscall_exit_to_user_mode+0x1df/0x1f0
>  [ 1845.444337]  do_syscall_64+0x79/0x140
>  [ 1845.444758]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1845.445272]
>  [ 1845.445505] Second to last potentially related work creation:
>  [ 1845.446078]  kasan_save_stack+0x1e/0x40
>  [ 1845.446494]  kasan_record_aux_stack+0x97/0xa0
>  [ 1845.446947]  task_work_add+0x178/0x250
>  [ 1845.447356]  mntput_no_expire+0x4fc/0x9f0
>  [ 1845.447789]  path_umount+0x4ed/0x10d0
>  [ 1845.448190]  __x64_sys_umount+0xfb/0x120
>  [ 1845.448617]  do_syscall_64+0x6d/0x140
>  [ 1845.449016]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1845.449529]
>  [ 1845.449766] The buggy address belongs to the object at ffff8881507b5a40
>  [ 1845.449766]  which belongs to the cache mnt_cache of size 368
>  [ 1845.450898] The buggy address is located 112 bytes inside of
>  [ 1845.450898]  freed 368-byte region [ffff8881507b5a40, ffff8881507b5bb0)
>  [ 1845.452009]
>  [ 1845.452250] The buggy address belongs to the physical page:
>  [ 1845.452808] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1507b4
>  [ 1845.453595] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>  [ 1845.454363] anon flags: 0x200000000000040(head|node=0|zone=2)
>  [ 1845.454936] page_type: f5(slab)
>  [ 1845.455300] raw: 0200000000000040 ffff8881009f5680 0000000000000000 dead000000000001
>  [ 1845.456077] raw: 0000000000000000 0000000080240024 00000000f5000000 0000000000000000
>  [ 1845.456857] head: 0200000000000040 ffff8881009f5680 0000000000000000 dead000000000001
>  [ 1845.457616] head: 0000000000000000 0000000080240024 00000000f5000000 0000000000000000
>  [ 1845.458399] head: 0200000000000002 ffffea000541ed01 ffffffffffffffff 0000000000000000
>  [ 1845.459169] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
>  [ 1845.459945] page dumped because: kasan: bad access detected
>  [ 1845.460506]
>  [ 1845.460745] Memory state around the buggy address:
>  [ 1845.461228]  ffff8881507b5980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
>  [ 1845.461963]  ffff8881507b5a00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>  [ 1845.462759] >ffff8881507b5a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  [ 1845.463480]                                      ^
>  [ 1845.463968]  ffff8881507b5b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  [ 1845.464704]  ffff8881507b5b80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>  [ 1845.465430] ==================================================================
>  [ 1845.466181] Disabling lock debugging due to kernel taint
>  [ 1845.466717] ==================================================================
>  [ 1845.467443] BUG: KASAN: slab-use-after-free in clone_private_mount+0x313/0x390
>  [ 1845.468192] Read of size 8 at addr ffff8881507b5a58 by task dockerd/8697
>  [ 1845.468837]
>  [ 1845.469072] CPU: 5 UID: 0 PID: 8697 Comm: dockerd Tainted: G    B               6.14.0master_fbece6d #1 NONE
>  [ 1845.469078] Tainted: [B]=BAD_PAGE
>  [ 1845.469079] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  [ 1845.469082] Call Trace:
>  [ 1845.469084]  <TASK>
>  [ 1845.469086]  dump_stack_lvl+0x69/0xa0
>  [ 1845.469093]  print_report+0x156/0x523
>  [ 1845.469098]  ? __virt_addr_valid+0x1de/0x3c0
>  [ 1845.469103]  ? clone_private_mount+0x313/0x390
>  [ 1845.469107]  kasan_report+0xc1/0xf0
>  [ 1845.469112]  ? clone_private_mount+0x313/0x390
>  [ 1845.469116]  clone_private_mount+0x313/0x390
>  [ 1845.469121]  ovl_fill_super+0x2965/0x59e0 [overlay]
>  [ 1845.469140]  ? ovl_workdir_create+0x900/0x900 [overlay]
>  [ 1845.469152]  ? wait_for_completion_io_timeout+0x20/0x20
>  [ 1845.469157]  ? lockdep_init_map_type+0x58/0x220
>  [ 1845.469161]  ? lockdep_init_map_type+0x58/0x220
>  [ 1845.469164]  ? shrinker_register+0x177/0x200
>  [ 1845.469169]  ? sget_fc+0x449/0xb30
>  [ 1845.469174]  ? ovl_workdir_create+0x900/0x900 [overlay]
>  [ 1845.469185]  ? get_tree_nodev+0xa5/0x130
>  [ 1845.469189]  get_tree_nodev+0xa5/0x130
>  [ 1845.469192]  ? cap_capable+0xd0/0x320
>  [ 1845.469198]  vfs_get_tree+0x83/0x2e0
>  [ 1845.469202]  ? ns_capable+0x55/0xb0
>  [ 1845.469206]  path_mount+0x891/0x1aa0
>  [ 1845.469210]  ? finish_automount+0x860/0x860
>  [ 1845.469217]  ? kmem_cache_free+0x14c/0x4f0
>  [ 1845.469221]  ? user_path_at+0x3d/0x50
>  [ 1845.469227]  __x64_sys_mount+0x2d4/0x3a0
>  [ 1845.469231]  ? path_mount+0x1aa0/0x1aa0
>  [ 1845.469235]  do_syscall_64+0x6d/0x140
>  [ 1845.469239]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1845.469242] RIP: 0033:0x55e3487f1fea
>  [ 1845.469246] Code: e8 1b 96 fa ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 4c 8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
>  [ 1845.469249] RSP: 002b:000000c000b563b8 EFLAGS: 00000212 ORIG_RAX: 00000000000000a5
>  [ 1845.469253] RAX: ffffffffffffffda RBX: 000000c00006c000 RCX: 000055e3487f1fea
>  [ 1845.469256] RDX: 000000c0012cf7d8 RSI: 000000c0012616c0 RDI: 000000c0012cf7d0
>  [ 1845.469260] RBP: 000000c000b56458 R08: 000000c0004fa600 R09: 0000000000000000
>  [ 1845.469261] R10: 0000000000000000 R11: 0000000000000212 R12: 000000c0012cf7d0
>  [ 1845.469263] R13: 0000000000000000 R14: 000000c00098b6c0 R15: ffffffffffffffff
>  [ 1845.469268]  </TASK>
>  [ 1845.469269]
>  [ 1845.494368] Allocated by task 17044:
>  [ 1845.494768]  kasan_save_stack+0x1e/0x40
>  [ 1845.495185]  kasan_save_track+0x10/0x30
>  [ 1845.495594]  __kasan_slab_alloc+0x62/0x70
>  [ 1845.496024]  kmem_cache_alloc_noprof+0x1a0/0x4a0
>  [ 1845.496518]  alloc_vfsmnt+0x23/0x6c0
>  [ 1845.496911]  vfs_create_mount+0x82/0x4a0
>  [ 1845.497333]  path_mount+0x939/0x1aa0
>  [ 1845.497728]  __x64_sys_mount+0x2d4/0x3a0
>  [ 1845.498167]  do_syscall_64+0x6d/0x140
>  [ 1845.498563]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1845.499064]
>  [ 1845.499295] Freed by task 0:
>  [ 1845.499636]  kasan_save_stack+0x1e/0x40
>  [ 1845.500052]  kasan_save_track+0x10/0x30
>  [ 1845.500494]  kasan_save_free_info+0x37/0x60
>  [ 1845.500934]  __kasan_slab_free+0x33/0x40
>  [ 1845.501355]  kmem_cache_free+0x14c/0x4f0
>  [ 1845.501774]  rcu_core+0x605/0x1d50
>  [ 1845.502162]  handle_softirqs+0x192/0x810
>  [ 1845.502587]  irq_exit_rcu+0x106/0x190
>  [ 1845.502995]  sysvec_apic_timer_interrupt+0x7c/0xb0
>  [ 1845.503487]  asm_sysvec_apic_timer_interrupt+0x16/0x20
>  [ 1845.504002]
>  [ 1845.504236] Last potentially related work creation:
>  [ 1845.504748]  kasan_save_stack+0x1e/0x40
>  [ 1845.505164]  kasan_record_aux_stack+0x97/0xa0
>  [ 1845.505621]  __call_rcu_common.constprop.0+0x6d/0xb40
>  [ 1845.506136]  task_work_run+0x111/0x1f0
>  [ 1845.506545]  syscall_exit_to_user_mode+0x1df/0x1f0
>  [ 1845.507038]  do_syscall_64+0x79/0x140
>  [ 1845.507439]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1845.507949]
>  [ 1845.508187] Second to last potentially related work creation:
>  [ 1845.508760]  kasan_save_stack+0x1e/0x40
>  [ 1845.509175]  kasan_record_aux_stack+0x97/0xa0
>  [ 1845.509630]  task_work_add+0x178/0x250
>  [ 1845.510040]  mntput_no_expire+0x4fc/0x9f0
>  [ 1845.510468]  path_umount+0x4ed/0x10d0
>  [ 1845.510870]  __x64_sys_umount+0xfb/0x120
>  [ 1845.511298]  do_syscall_64+0x6d/0x140
>  [ 1845.511700]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  [ 1845.512210]
>  [ 1845.512442] The buggy address belongs to the object at ffff8881507b5a40
>  [ 1845.512442]  which belongs to the cache mnt_cache of size 368
>  [ 1845.513553] The buggy address is located 24 bytes inside of
>  [ 1845.513553]  freed 368-byte region [ffff8881507b5a40, ffff8881507b5bb0)
>  [ 1845.514650]
>  [ 1845.514883] The buggy address belongs to the physical page:
>  [ 1845.515436] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1507b4
>  [ 1845.516221] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>  [ 1845.516986] anon flags: 0x200000000000040(head|node=0|zone=2)
>  [ 1845.517549] page_type: f5(slab)
>  [ 1845.517912] raw: 0200000000000040 ffff8881009f5680 0000000000000000 dead000000000001
>  [ 1845.518684] raw: 0000000000000000 0000000080240024 00000000f5000000 0000000000000000
>  [ 1845.519445] head: 0200000000000040 ffff8881009f5680 0000000000000000 dead000000000001
>  [ 1845.520220] head: 0000000000000000 0000000080240024 00000000f5000000 0000000000000000
>  [ 1845.521006] head: 0200000000000002 ffffea000541ed01 ffffffffffffffff 0000000000000000
>  [ 1845.521812] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
>  [ 1845.522581] page dumped because: kasan: bad access detected
>  [ 1845.523131]
>  [ 1845.523362] Memory state around the buggy address:
>  [ 1845.523851]  ffff8881507b5900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  [ 1845.524588]  ffff8881507b5980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
>  [ 1845.525321] >ffff8881507b5a00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>  [ 1845.526059]                                                     ^
>  [ 1845.526651]  ffff8881507b5a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  [ 1845.527378]  ffff8881507b5b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  [ 1845.528095] ==================================================================
> 
> > 
> > Thank you!
> > 
> > -- 
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/prtracker.html

