Return-Path: <linux-fsdevel+bounces-67875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1181C4CBBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0409A4FA7BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2DE2F260C;
	Tue, 11 Nov 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1N/v3/a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C152EBBA8;
	Tue, 11 Nov 2025 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853793; cv=none; b=TH483+NamsLcV6OwIioErjc1V74ZfxEvEHju16TgQ1f/wefbnIUKiaHUBHhRda9mXd9egUjN1ubu/QJWltNYMAn7iL37j7rYGz6io4yGdngHZWkc4dQi+BT7V3WgIuv8mgWxXORVLxfGBOZjqCcDlGstp5TMXkaVMMxpAx7jzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853793; c=relaxed/simple;
	bh=kMeHaYaR4RkOd0wfcEBGj6Li4yDHZkzpHCvRrYWDPeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLIIO/YujfN/+So94VFThvMTcQ9XfFQmv15ggYHRCch0675Px+6GDCnSK8FcOvIBE1IGr5JJxo26ud+l2kFaVmr8N5umUsZcEDeF50OFvQleOZten7X30jUj0IehVA0xjc4XE/AeGmFPfU/qbgEJZw01P3OEjNLGj/63hfaYqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1N/v3/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBC4C116B1;
	Tue, 11 Nov 2025 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762853792;
	bh=kMeHaYaR4RkOd0wfcEBGj6Li4yDHZkzpHCvRrYWDPeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1N/v3/aXlvSJNqErENP+I6ESD2HjWFULqe5rcWLDRBQQhXi77/hj3TlTQL5TQ5Ne
	 GHD3exZuxCcdjMt/VqOk1no2aNZ7WNhx5NKV0M78SHBPLTIe2g9DSRQBDq1L1HwQQ/
	 o93P5K15mx25KdpI4eK7oqWo9Zn2EjVf5uXnIYdosJ86ZUet/77dajflzD2lBpdAcf
	 +w48EIvZwDHDkqT5GUct9R8wZh/OmTMb3SuGg6Ll9CXULgLMiMppMitn41wRnSvxSq
	 A0eTPyh0+pHdAQZjfkNPL+Kn0w4tfmy6dm3xb+9iE7TxF6g6QXmWbfagQM/5nrFDFY
	 /mxX3uiKKYaCw==
Date: Tue, 11 Nov 2025 10:36:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [linux-next:master] [ns]  3a18f80918:
 WARNING:at_include/linux/ns_common.h:#put_cred_rcu
Message-ID: <20251111-neuproduktion-eliminieren-acc4b549e4b8@brauner>
References: <202511111547.de480df9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202511111547.de480df9-lkp@intel.com>

On Tue, Nov 11, 2025 at 03:08:10PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_include/linux/ns_common.h:#put_cred_rcu" on:
> 
> commit: 3a18f809184bc5a1cfad7cde5b8b026e2ff61587 ("ns: add active reference count")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

This is fixed in namespace-6.19 which should've made it into -next about
five hours ago.

Note that "linux-next.git master" is pretty useless. By the time I read
this mail linux-next's master branch will have already been updated. So
you should give a commit hash as well or a tag.

> 
> in testcase: trinity
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-01
> 	nr_groups: 5
> 
> 
> 
> config: x86_64-randconfig-r053-20251109
> compiler: gcc-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202511111547.de480df9-lkp@intel.com
> 
> 
> [   41.172047][    C1] ------------[ cut here ]------------
> [   41.172821][    C1] WARNING: CPU: 1 PID: 0 at include/linux/ns_common.h:227 put_cred_rcu (include/linux/ns_common.h:227 include/linux/user_namespace.h:189 kernel/cred.c:88)
> [   41.173907][    C1] Modules linked in: serio_raw(F) floppy(F) tiny_power_button(F) button(F)
> [   41.174959][    C1] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: GF               T   6.18.0-rc2-00014-g3a18f809184b #1 PREEMPTLAZY  9f2dc8152166a7dcc87d7d6a6b2b12a17475cded
> [   41.176815][    C1] Tainted: [F]=FORCED_MODULE, [T]=RANDSTRUCT
> [   41.177517][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   41.178764][    C1] RIP: 0010:put_cred_rcu (include/linux/ns_common.h:227 include/linux/user_namespace.h:189 kernel/cred.c:88)
> [   41.179419][    C1] Code: 02 48 89 e8 83 e0 07 83 c0 03 38 d0 7c 0c 84 d2 74 08 48 89 ef e8 0d 9f 55 00 8b 83 30 03 00 00 85 c0 74 09 e8 ae 24 1c 00 90 <0f> 0b 90 e8 a5 24 1c 00 48 89 df e8 fd a9 1b 00 e8 98 24 1c 00 4c
> All code
> ========
>    0:	02 48 89             	add    -0x77(%rax),%cl
>    3:	e8 83 e0 07 83       	call   0xffffffff8307e08b
>    8:	c0 03 38             	rolb   $0x38,(%rbx)
>    b:	d0 7c 0c 84          	sarb   $1,-0x7c(%rsp,%rcx,1)
>    f:	d2 74 08 48          	shlb   %cl,0x48(%rax,%rcx,1)
>   13:	89 ef                	mov    %ebp,%edi
>   15:	e8 0d 9f 55 00       	call   0x559f27
>   1a:	8b 83 30 03 00 00    	mov    0x330(%rbx),%eax
>   20:	85 c0                	test   %eax,%eax
>   22:	74 09                	je     0x2d
>   24:	e8 ae 24 1c 00       	call   0x1c24d7
>   29:	90                   	nop
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	90                   	nop
>   2d:	e8 a5 24 1c 00       	call   0x1c24d7
>   32:	48 89 df             	mov    %rbx,%rdi
>   35:	e8 fd a9 1b 00       	call   0x1baa37
>   3a:	e8 98 24 1c 00       	call   0x1c24d7
>   3f:	4c                   	rex.WR
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	90                   	nop
>    3:	e8 a5 24 1c 00       	call   0x1c24ad
>    8:	48 89 df             	mov    %rbx,%rdi
>    b:	e8 fd a9 1b 00       	call   0x1baa0d
>   10:	e8 98 24 1c 00       	call   0x1c24ad
>   15:	4c                   	rex.WR
> [   41.181507][    C1] RSP: 0018:ffffc900001c8e58 EFLAGS: 00010246
> [   41.182352][    C1] RAX: 0000000000000000 RBX: ffff8881649b8780 RCX: 0000000000000000
> [   41.183326][    C1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [   41.184311][    C1] RBP: ffff8881649b8ab0 R08: 0000000000000000 R09: 0000000000000000
> [   41.185324][    C1] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88815d490c80
> [   41.186287][    C1] R13: ffffffff83d2b7c0 R14: 0000000000000004 R15: ffffffff813e6e70
> [   41.187244][    C1] FS:  0000000000000000(0000) GS:ffff888799e76000(0000) knlGS:0000000000000000
> [   41.188285][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   41.191457][    C1] CR2: 00000000004003c0 CR3: 0000000003c88000 CR4: 00000000000406b0
> [   41.192491][    C1] Call Trace:
> [   41.192939][    C1]  <IRQ>
> [   41.193359][    C1]  rcu_do_batch (include/linux/rcupdate.h:341 kernel/rcu/tree.c:2607)
> [   41.193952][    C1]  ? rcu_pending (kernel/rcu/tree.c:2529)
> [   41.194567][    C1]  ? rcu_disable_urgency_upon_qs (kernel/rcu/tree.c:725 (discriminator 1))
> [   41.195408][    C1]  ? trace_irq_enable+0xac/0xe0
> [   41.196177][    C1]  rcu_core (kernel/rcu/tree.c:2863)
> [   41.196782][    C1]  handle_softirqs (arch/x86/include/asm/jump_label.h:36 include/trace/events/irq.h:142 kernel/softirq.c:623)
> [   41.197442][    C1]  __irq_exit_rcu (kernel/softirq.c:496 kernel/softirq.c:723)
> [   41.198071][    C1]  irq_exit_rcu (kernel/softirq.c:741 (discriminator 38))
> [   41.198779][    C1]  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052 (discriminator 35) arch/x86/kernel/apic/apic.c:1052 (discriminator 35))
> [   41.199466][    C1]  </IRQ>
> [   41.199885][    C1]  <TASK>
> [   41.200311][    C1]  asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:569)
> [   41.201027][    C1] RIP: 0010:pv_native_safe_halt (arch/x86/kernel/paravirt.c:82)
> [   41.201736][    C1] Code: 48 8b 3d 28 51 54 02 e8 23 00 00 00 48 2b 05 fc cf af 00 31 ff c3 cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d 97 fc 0e 00 fb f4 <c3> cc cc cc cc 41 57 41 56 41 55 41 54 55 48 89 fd 53 44 8b 6d 00
> All code
> ========
>    0:	48 8b 3d 28 51 54 02 	mov    0x2545128(%rip),%rdi        # 0x254512f
>    7:	e8 23 00 00 00       	call   0x2f
>    c:	48 2b 05 fc cf af 00 	sub    0xafcffc(%rip),%rax        # 0xafd00f
>   13:	31 ff                	xor    %edi,%edi
>   15:	c3                   	ret
>   16:	cc                   	int3
>   17:	cc                   	int3
>   18:	cc                   	int3
>   19:	cc                   	int3
>   1a:	cc                   	int3
>   1b:	cc                   	int3
>   1c:	cc                   	int3
>   1d:	cc                   	int3
>   1e:	cc                   	int3
>   1f:	eb 07                	jmp    0x28
>   21:	0f 00 2d 97 fc 0e 00 	verw   0xefc97(%rip)        # 0xefcbf
>   28:	fb                   	sti
>   29:	f4                   	hlt
>   2a:*	c3                   	ret		<-- trapping instruction
>   2b:	cc                   	int3
>   2c:	cc                   	int3
>   2d:	cc                   	int3
>   2e:	cc                   	int3
>   2f:	41 57                	push   %r15
>   31:	41 56                	push   %r14
>   33:	41 55                	push   %r13
>   35:	41 54                	push   %r12
>   37:	55                   	push   %rbp
>   38:	48 89 fd             	mov    %rdi,%rbp
>   3b:	53                   	push   %rbx
>   3c:	44 8b 6d 00          	mov    0x0(%rbp),%r13d
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	c3                   	ret
>    1:	cc                   	int3
>    2:	cc                   	int3
>    3:	cc                   	int3
>    4:	cc                   	int3
>    5:	41 57                	push   %r15
>    7:	41 56                	push   %r14
>    9:	41 55                	push   %r13
>    b:	41 54                	push   %r12
>    d:	55                   	push   %rbp
>    e:	48 89 fd             	mov    %rdi,%rbp
>   11:	53                   	push   %rbx
>   12:	44 8b 6d 00          	mov    0x0(%rbp),%r13d
> [   41.203822][    C1] RSP: 0018:ffffc9000014fe38 EFLAGS: 00000246
> [   41.204551][    C1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [   41.205618][    C1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [   41.206601][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [   41.207613][    C1] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881008322c0
> [   41.208650][    C1] R13: 1ffff92000029fca R14: dffffc0000000000 R15: 0000000000000000
> [   41.209689][    C1]  default_idle (arch/x86/include/asm/paravirt.h:107 arch/x86/kernel/process.c:767)
> [   41.210257][    C1]  default_idle_call (include/linux/cpuidle.h:143 (discriminator 1) kernel/sched/idle.c:123 (discriminator 1))
> [   41.210879][    C1]  cpuidle_idle_call (kernel/sched/idle.c:191)
> [   41.211506][    C1]  ? arch_cpu_idle_exit+0x30/0x30
> [   41.215390][    C1]  ? tick_nohz_start_idle (kernel/time/tick-sched.c:753)
> [   41.216069][    C1]  ? tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:81)
> [   41.216763][    C1]  do_idle (kernel/sched/idle.c:332)
> [   41.217295][    C1]  cpu_startup_entry (kernel/sched/idle.c:427)
> [   41.217929][    C1]  start_secondary (arch/x86/kernel/smpboot.c:315)
> [   41.218650][    C1]  ? set_cpu_sibling_map (arch/x86/kernel/smpboot.c:233)
> [   41.219100][    C1]  common_startup_64 (arch/x86/kernel/head_64.S:419)
> [   41.219506][    C1]  </TASK>
> [   41.219783][    C1] irq event stamp: 42022
> [   41.220131][    C1] hardirqs last  enabled at (42021): tick_nohz_idle_exit (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 kernel/time/tick-sched.c:1472)
> [   41.220844][    C1] hardirqs last disabled at (42022): __schedule (kernel/sched/core.c:6814)
> [   41.221520][    C1] softirqs last  enabled at (42010): handle_softirqs (kernel/softirq.c:469 (discriminator 2) kernel/softirq.c:650 (discriminator 2))
> [   41.222380][    C1] softirqs last disabled at (42001): __irq_exit_rcu (kernel/softirq.c:496 kernel/softirq.c:723)
> [   41.223139][    C1] ---[ end trace 0000000000000000 ]---
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251111/202511111547.de480df9-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

