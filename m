Return-Path: <linux-fsdevel+bounces-27194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8400195F644
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 18:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93901C2204B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E787B194A5C;
	Mon, 26 Aug 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6IAYPYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53550186619;
	Mon, 26 Aug 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689060; cv=none; b=CGcBr8Xf9JVhPzLadiFG7uj8WWrPr/2KeSLraLVJW3K1UOzJsysmQTLGPDN2AA57lDvEj7otxInj3mfFrkZq3xRfYBRpe+hRKfnjwRIi3oOr1oXUkmPo5WOenklpZv0RkQ0706Jpdtw6lPDr3D6dbw/Z5My0QEhWhvedaNf/lWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689060; c=relaxed/simple;
	bh=nwUdJnv3OTdwVRbKbCAMU7Vdrg+XlNYSxoPu4SuORdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKHbTeIiw2jghCifEQ7o65ot1+A7oomSfEYM4I7DMRfQBNO5XEM3K0TvZSLWBTLSJP0Bw7OT+jN5TjQPFrhpXzN4QAWtWUs2YDdvP61frZ9vvpuYPYrAnpK8hOSakwctSiprKJjCRNUKD9D/CSlvYm2FWzQ/6P8Xo11MZnFe0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6IAYPYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320ADC52FC0;
	Mon, 26 Aug 2024 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724689060;
	bh=nwUdJnv3OTdwVRbKbCAMU7Vdrg+XlNYSxoPu4SuORdA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=E6IAYPYJ3pTQNHFladrmU6yamW9X71SXsd2M3YCQmY2U94xEXQ50eGkg8zbaVwG72
	 0YGyb6X4Iq2Xrxs+NynVsg2CLgjuonL4SLr3QwwHkMkLImkdeJryr35QixJZS89H9f
	 aW/PXWt6JoP9NZ6AU3e6BEeO/jMf/JfYcmBQyOvseiWDGLGsoOr/Tz6bOnBGlwFLV0
	 wBfPYNpgYZ90LSDkmASfPAp1Hfgrxl8f0H87xMTLeVUNiDx3tNMDTTxQDAxxPLJIYl
	 6SuyP72sXzHu9VQl7GY6oR48b08oKorUbGiIEVTI1O3LkDViswX4SizwP5iswCMoBX
	 LDtE07zd0vuBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BCA1BCE0B78; Mon, 26 Aug 2024 09:17:39 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:17:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Dave Jones <davej@codemonkey.org.uk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [paulmckrcu:dev] [mm/filemap]  199735cdc2:
 BUG:sleeping_function_called_from_invalid_context_at_mm/filemap.c
Message-ID: <be1fea35-6590-473d-a047-8ab02228d916@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202408251605.df83b338-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408251605.df83b338-lkp@intel.com>

On Sun, Aug 25, 2024 at 04:46:52PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_mm/filemap.c" on:
> 
> commit: 199735cdc2b09f27ee095b39d1a67ea6888d2dc8 ("mm/filemap: Add cond_resched() to find_get_entry() retry loop")
> https://github.com/paulmckrcu/linux dev
> 
> in testcase: boot
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)

It is a good thing I have a brown paper bag at hand.  :-(

Good catch, and thank you for your testing efforts.  In the short term,
I will be dropping this patch.

							Thanx, Paul

> +-------------------------------------------------------------------+------------+------------+
> |                                                                   | cf6115748c | 199735cdc2 |
> +-------------------------------------------------------------------+------------+------------+
> | boot_successes                                                    | 18         | 0          |
> | boot_failures                                                     | 0          | 18         |
> | BUG:sleeping_function_called_from_invalid_context_at_mm/filemap.c | 0          | 18         |
> +-------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408251605.df83b338-lkp@intel.com
> 
> 
> [    8.441495][   T10] BUG: sleeping function called from invalid context at mm/filemap.c:1989
> [    8.442309][   T10] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 10, name: kworker/u4:0
> [    8.443047][   T10] preempt_count: 0, expected: 0
> [    8.443427][   T10] RCU nest depth: 1, expected: 0
> [    8.443813][   T10] 4 locks held by kworker/u4:0/10:
> [ 8.444214][ T10] #0: ffff888100a76d50 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3206) 
> [ 8.445025][ T10] #1: ffff888101e7be48 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3207) 
> [ 8.446045][ T10] #2: ffff888100e71430 (sb_writers#2){.+.+}-{0:0}, at: do_unlinkat (fs/namei.c:4470) 
> [ 8.446763][ T10] #3: ffffffff833f0d00 (rcu_read_lock){....}-{1:2}, at: find_lock_entries (include/linux/rcupdate.h:337 include/linux/rcupdate.h:849 mm/filemap.c:2091) 
> [    8.447523][   T10] CPU: 0 UID: 0 PID: 10 Comm: kworker/u4:0 Not tainted 6.11.0-rc1-00121-g199735cdc2b0 #1 ada3dbbd8db49aa7f6dc3bbe9d2d7b34f1d68c93
> [    8.448151][   T10] Workqueue: async async_run_entry_fn
> [    8.448151][   T10] Call Trace:
> [    8.448151][   T10]  <TASK>
> [ 8.448151][ T10] dump_stack_lvl (lib/dump_stack.c:122 (discriminator 1)) 
> [ 8.448151][ T10] __might_resched (kernel/sched/core.c:8439) 
> [ 8.448151][ T10] find_lock_entries (include/linux/sched.h:2007 mm/filemap.c:1989 mm/filemap.c:2092) 
> [ 8.448151][ T10] ? find_lock_entries (include/linux/rcupdate.h:337 include/linux/rcupdate.h:849 mm/filemap.c:2091) 
> [ 8.448151][ T10] truncate_inode_pages_range (mm/truncate.c:338 (discriminator 1)) 
> [ 8.448151][ T10] ? save_trace (kernel/locking/lockdep.c:585) 
> [ 8.448151][ T10] ? add_lock_to_list (include/linux/rculist.h:79 include/linux/rculist.h:128 kernel/locking/lockdep.c:1431) 
> [ 8.448151][ T10] ? check_prev_add (kernel/locking/lockdep.c:3213) 
> [ 8.448151][ T10] ? validate_chain (kernel/locking/lockdep.c:156 kernel/locking/lockdep.c:185 kernel/locking/lockdep.c:3872) 
> [    8.448151][   T10]  ? 0xffffffff81000000
> [ 8.448151][ T10] ? truncate_inode_pages_final (include/linux/spinlock.h:401 mm/truncate.c:455) 
> [ 8.448151][ T10] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
> [ 8.448151][ T10] ? mark_held_locks (kernel/locking/lockdep.c:4273) 
> [ 8.448151][ T10] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4422) 
> [ 8.448151][ T10] evict (fs/inode.c:672) 
> [ 8.448151][ T10] do_unlinkat (fs/namei.c:4493) 
> [ 8.448151][ T10] clean_path (init/initramfs.c:341) 
> [ 8.448151][ T10] do_symlink (init/initramfs.c:428) 
> [ 8.448151][ T10] ? do_collect (init/initramfs.c:267) 
> [ 8.448151][ T10] flush_buffer (init/initramfs.c:452 init/initramfs.c:464) 
> [ 8.448151][ T10] ? bunzip2 (lib/decompress_inflate.c:37) 
> [ 8.448151][ T10] ? do_name (init/initramfs.c:458) 
> [ 8.448151][ T10] __gunzip+0x2b0/0x380 
> [ 8.448151][ T10] unpack_to_rootfs (init/initramfs.c:522) 
> [ 8.448151][ T10] ? initrd_load (init/initramfs.c:59) 
> [ 8.448151][ T10] do_populate_rootfs (init/initramfs.c:706 (discriminator 1)) 
> [ 8.448151][ T10] async_run_entry_fn (kernel/async.c:136) 
> [ 8.448151][ T10] process_one_work (kernel/workqueue.c:3236) 
> [ 8.448151][ T10] ? process_one_work (kernel/workqueue.c:3207) 
> [ 8.448151][ T10] ? worker_thread (kernel/workqueue.c:3349) 
> [ 8.448151][ T10] worker_thread (kernel/workqueue.c:3306 kernel/workqueue.c:3390) 
> [ 8.448151][ T10] ? rescuer_thread (kernel/workqueue.c:3339) 
> [ 8.448151][ T10] kthread (kernel/kthread.c:389) 
> [ 8.448151][ T10] ? kthread_park (kernel/kthread.c:342) 
> [ 8.448151][ T10] ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 8.448151][ T10] ? kthread_park (kernel/kthread.c:342) 
> [ 8.448151][ T10] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
> [    8.448151][   T10]  </TASK>
> [    8.949844][   T10] Freeing initrd memory: 198316K
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240825/202408251605.df83b338-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

