Return-Path: <linux-fsdevel+bounces-43051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21A4A4D680
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936107A30AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 08:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45751FAC3B;
	Tue,  4 Mar 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5QLYN0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3C1DFD8B;
	Tue,  4 Mar 2025 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077150; cv=none; b=PVLywjDrFWTDX8xgk8Bj0mgnCEuePhJ0PfOIXfUceySM+PBh0fawkc0h3ZdUymn7jXEEiUKLHsmSMOcfOuyzgcVFP8QOVBmbfsoAntH6m6Tfq7dCWFce8kjPhIRqcPgZqZSWRVoBDdfhgec0uO9dln0eV/jO185UsmTgVtmyLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077150; c=relaxed/simple;
	bh=AhRwnYjlX63aHPHhlDNV54hbir6Fu4Bo4vRLL7/oSSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajgw8aktO/lvtGYsm4WKQCxdwoDiJKlKHnqILAPiZGbuDh0uscFEtm+TA+iVTYQlvFU4w8HelqudWSFFfv767LTqLlm2/lHPj9PjtEGkuPg2fQxp+Jc5z6JKk7FIP1zVyGHQXfdU9S1R0JVzlc1c9VwtKVzf/jYWASsrFoa5aUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5QLYN0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D79C4CEE5;
	Tue,  4 Mar 2025 08:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741077149;
	bh=AhRwnYjlX63aHPHhlDNV54hbir6Fu4Bo4vRLL7/oSSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5QLYN0/buTIEByPYTiPubUp0hbrIFlusENjpNcb9dnuRraUbP28UwbagILic3jnj
	 lDR5w9CVBTl27AdZIV3ERdS4Sclka7EQvJQ2qhA8uv6jRi28Nfw6lNBEw7Iq4eXsen
	 b05xMn6wGh853ZkK2y2OxvcZL5/q9/SmEeFCegoTx5d/x/CBvUqYE17pIGE6SahTuB
	 TlHzvlFVyzrjkKVcBfOlD6AqTUjKewXqXqRqpXvIK9KhWuynF1dH5YzJBlricYfadR
	 /8/GfF/LDvyvLIO511Ah1JjwG4S4Q1I9eAiBQTgTzmDabiLQmtaIsof5cKhkzx0V+3
	 nWUG3/yb1pv4g==
Date: Tue, 4 Mar 2025 09:32:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [fs]  becb2cae42:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20250304-beiwerk-gefischt-89dcf567973b@brauner>
References: <202503041421.38b0d0c-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202503041421.38b0d0c-lkp@intel.com>

On Tue, Mar 04, 2025 at 02:14:55PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> 
> commit: becb2cae42ea9092ad4fca06c85328e1f7f7312b ("fs: record sequence number of origin mount namespace")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Should now be fixed, thanks!

> 
> [test failed on linux-next/master c0eb65494e59d9834af7cbad983629e9017b25a1]
> 
> in testcase: trinity
> version: trinity-x86_64-ba2360ed-1_20241228
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-00
> 	nr_groups: 5
> 
> 
> 
> config: x86_64-randconfig-075-20250228
> compiler: clang-19
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +---------------------------------------------------------------------------+------------+------------+
> |                                                                           | 822c115925 | becb2cae42 |
> +---------------------------------------------------------------------------+------------+------------+
> | BUG:kernel_NULL_pointer_dereference,address                               | 0          | 6          |
> | Oops                                                                      | 0          | 6          |
> | RIP:__se_sys_open_tree                                                    | 0          | 6          |
> | Kernel_panic-not_syncing:Fatal_exception                                  | 0          | 6          |
> +---------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202503041421.38b0d0c-lkp@intel.com
> 
> 
> [  133.969970][ T4356] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  133.971269][ T4356] #PF: supervisor read access in kernel mode
> [  133.972087][ T4356] #PF: error_code(0x0000) - not-present page
> [  133.972943][ T4356] PGD 800000016ebda067 P4D 800000016ebda067 PUD 0
> [  133.973896][ T4356] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [  133.974732][ T4356] CPU: 1 UID: 65534 PID: 4356 Comm: trinity-c2 Tainted: G                T  6.14.0-rc1-00005-gbecb2cae42ea #1
> [  133.976486][ T4356] Tainted: [T]=RANDSTRUCT
> [  133.977174][ T4356] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 133.978731][ T4356] RIP: 0010:__se_sys_open_tree (fs/mount.h:152 fs/namespace.c:2873 fs/namespace.c:2943 fs/namespace.c:2905) 
> [ 133.979644][ T4356] Code: 01 f0 ff ff 72 0a e8 62 8a c4 ff e9 59 02 00 00 4c 89 64 24 10 48 c7 c7 78 e5 6e 84 e8 8c c8 82 01 48 8b 44 24 08 4c 8b 68 d0 <4d> 8b 65 00 31 ff 4c 89 e6 e8 f5 8f c4 ff 4d 85 e4 74 07 e8 2b 8a
> All code
> ========
>    0:	01 f0                	add    %esi,%eax
>    2:	ff                   	(bad)
>    3:	ff 72 0a             	push   0xa(%rdx)
>    6:	e8 62 8a c4 ff       	call   0xffffffffffc48a6d
>    b:	e9 59 02 00 00       	jmp    0x269
>   10:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
>   15:	48 c7 c7 78 e5 6e 84 	mov    $0xffffffff846ee578,%rdi
>   1c:	e8 8c c8 82 01       	call   0x182c8ad
>   21:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
>   26:	4c 8b 68 d0          	mov    -0x30(%rax),%r13
>   2a:*	4d 8b 65 00          	mov    0x0(%r13),%r12		<-- trapping instruction
>   2e:	31 ff                	xor    %edi,%edi
>   30:	4c 89 e6             	mov    %r12,%rsi
>   33:	e8 f5 8f c4 ff       	call   0xffffffffffc4902d
>   38:	4d 85 e4             	test   %r12,%r12
>   3b:	74 07                	je     0x44
>   3d:	e8                   	.byte 0xe8
>   3e:	2b                   	.byte 0x2b
>   3f:	8a                   	.byte 0x8a
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	4d 8b 65 00          	mov    0x0(%r13),%r12
>    4:	31 ff                	xor    %edi,%edi
>    6:	4c 89 e6             	mov    %r12,%rsi
>    9:	e8 f5 8f c4 ff       	call   0xffffffffffc49003
>    e:	4d 85 e4             	test   %r12,%r12
>   11:	74 07                	je     0x1a
>   13:	e8                   	.byte 0xe8
>   14:	2b                   	.byte 0x2b
>   15:	8a                   	.byte 0x8a
> [  133.982199][ T4356] RSP: 0018:ffff88819bff7eb8 EFLAGS: 00010202
> [  133.983064][ T4356] RAX: ffff88819a47c338 RBX: 00000000000001b7 RCX: 0000000000000000
> [  133.984255][ T4356] RDX: ffff88819a650000 RSI: 0000000000000000 RDI: 0000000000000000
> [  133.985462][ T4356] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> [  133.986638][ T4356] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88819a650000
> [  133.987842][ T4356] R13: 0000000000000000 R14: ffff88819bd68e00 R15: 0000000000000001
> [  133.989130][ T4356] FS:  00007f0d165f6740(0000) GS:ffff88842fd00000(0000) knlGS:0000000000000000
> [  133.990567][ T4356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  133.991590][ T4356] CR2: 0000000000000000 CR3: 000000019bc54000 CR4: 00000000000406f0
> [  133.992731][ T4356] Call Trace:
> [  133.993247][ T4356]  <TASK>
> [ 133.993714][ T4356] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
> [ 133.994395][ T4356] ? page_fault_oops (arch/x86/mm/fault.c:710) 
> [ 133.995182][ T4356] ? do_user_addr_fault (arch/x86/mm/fault.c:?) 
> [ 133.996009][ T4356] ? exc_page_fault (arch/x86/mm/fault.c:? arch/x86/mm/fault.c:1538) 
> [ 133.996790][ T4356] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
> [ 133.997605][ T4356] ? __se_sys_open_tree (fs/mount.h:152 fs/namespace.c:2873 fs/namespace.c:2943 fs/namespace.c:2905) 
> [ 133.998433][ T4356] ? __se_sys_open_tree (fs/namespace.c:2872 fs/namespace.c:2943 fs/namespace.c:2905) 
> [ 133.999267][ T4356] ? do_syscall_64 (arch/x86/entry/common.c:83) 
> [ 133.999925][ T4356] ? do_int80_emulation (arch/x86/entry/common.c:257) 
> [ 134.000690][ T4356] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> [  134.001567][ T4356]  </TASK>
> [  134.002006][ T4356] Modules linked in: af_key ieee802154_socket ieee802154 caif_socket caif crc_ccitt rxrpc bluetooth rfkill pptp gre pppoe pppox ppp_generic slhc crypto_user scsi_transport_iscsi xfrm_user sctp dccp_ipv4 dccp ipmi_devintf ipmi_msghandler sr_mod cdrom sg ata_generic ata_piix libata sha1_ssse3 aesni_intel scsi_mod scsi_common input_leds serio_raw stm_p_basic
> [  134.007226][ T4356] CR2: 0000000000000000
> [  134.008040][ T4356] ---[ end trace 0000000000000000 ]---
> [ 134.013890][ T4356] RIP: 0010:__se_sys_open_tree (fs/mount.h:152 fs/namespace.c:2873 fs/namespace.c:2943 fs/namespace.c:2905) 
> [ 134.015705][ T4356] Code: 01 f0 ff ff 72 0a e8 62 8a c4 ff e9 59 02 00 00 4c 89 64 24 10 48 c7 c7 78 e5 6e 84 e8 8c c8 82 01 48 8b 44 24 08 4c 8b 68 d0 <4d> 8b 65 00 31 ff 4c 89 e6 e8 f5 8f c4 ff 4d 85 e4 74 07 e8 2b 8a
> All code
> ========
>    0:	01 f0                	add    %esi,%eax
>    2:	ff                   	(bad)
>    3:	ff 72 0a             	push   0xa(%rdx)
>    6:	e8 62 8a c4 ff       	call   0xffffffffffc48a6d
>    b:	e9 59 02 00 00       	jmp    0x269
>   10:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
>   15:	48 c7 c7 78 e5 6e 84 	mov    $0xffffffff846ee578,%rdi
>   1c:	e8 8c c8 82 01       	call   0x182c8ad
>   21:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
>   26:	4c 8b 68 d0          	mov    -0x30(%rax),%r13
>   2a:*	4d 8b 65 00          	mov    0x0(%r13),%r12		<-- trapping instruction
>   2e:	31 ff                	xor    %edi,%edi
>   30:	4c 89 e6             	mov    %r12,%rsi
>   33:	e8 f5 8f c4 ff       	call   0xffffffffffc4902d
>   38:	4d 85 e4             	test   %r12,%r12
>   3b:	74 07                	je     0x44
>   3d:	e8                   	.byte 0xe8
>   3e:	2b                   	.byte 0x2b
>   3f:	8a                   	.byte 0x8a
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	4d 8b 65 00          	mov    0x0(%r13),%r12
>    4:	31 ff                	xor    %edi,%edi
>    6:	4c 89 e6             	mov    %r12,%rsi
>    9:	e8 f5 8f c4 ff       	call   0xffffffffffc49003
>    e:	4d 85 e4             	test   %r12,%r12
>   11:	74 07                	je     0x1a
>   13:	e8                   	.byte 0xe8
>   14:	2b                   	.byte 0x2b
>   15:	8a                   	.byte 0x8a
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250304/202503041421.38b0d0c-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

