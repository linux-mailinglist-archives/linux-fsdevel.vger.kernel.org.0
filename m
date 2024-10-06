Return-Path: <linux-fsdevel+bounces-31121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6526991E84
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C711F21B76
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222C17966F;
	Sun,  6 Oct 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLb7Bqd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927A1779AB;
	Sun,  6 Oct 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221356; cv=none; b=jUAw4TZVJdUuvUGgrtjhj5KhkNgaSviwa5Pr4j82KN/5MQjTNG+g5ycsNlfo8os0u66DqGdzj/7/3R+QsoW8wSVPSiiDA6B9vk6fAzntar9RrGlalHc/UEoFIeyFCURaSqCYuI4mGhaGVHmIn3kkWTO5r09QvuxxvLdO/sLs/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221356; c=relaxed/simple;
	bh=BtD6uQeKcar4gJLuDMrO7gB7cz+l9whS8y4o3WOSc8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KctZKa+RNQINljSe6O/7DScjUpIV77ujLyzSdnY3hRSL2WwAvM48YwR/hFpLh+UJ1NZMyh1pXqu/7SFDFmRZ/6AJSgW8kOuC99QdICAak8RXXKEiOrFmXxBAAwlTLMOs5poiMH6y3op3HqxKeqkRCerI07xeGEHCM8R7g6swPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLb7Bqd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593B9C4CED1;
	Sun,  6 Oct 2024 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221356;
	bh=BtD6uQeKcar4gJLuDMrO7gB7cz+l9whS8y4o3WOSc8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BLb7Bqd5DUL9igAN334n3NBJRh+b0UM6zZbgFYtlnE72Ov0F1vp+7NrtaTRNv6341
	 49y9XNEFPTgSVrodwUyQtm5isKzB7G1puJcxHBsciFGgw6Gd1qeOvbgUTI9WaJDy7M
	 emG6kYcGhR+RCnlhgJyuqQegLUgpp+dDYLXCPvVr8UeZxgVtbhMVt5AyPFhJwUDuqx
	 6jHUfcyw/vtcfEyZ1dMi/Iu899d3TW220Y/GYvP1qOOoB2XqlJ6z0cDx5EssEd7PHn
	 aR5OXHf7RFeXQshB6Pyx5yFxztobnz5WNspC+ZNiOcA4XPXdX4D+Pqj2aNuuzDpb6c
	 p0Anm5boOhHdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB03806656;
	Sun,  6 Oct 2024 13:29:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/33] riscv control-flow integrity for usermode
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172822135999.3395169.2185051958968934926.git-patchwork-notify@kernel.org>
Date: Sun, 06 Oct 2024 13:29:19 +0000
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
 lorenzo.stoakes@oracle.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, conor@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 arnd@arndb.de, brauner@kernel.org, peterz@infradead.org, oleg@redhat.com,
 ebiederm@xmission.com, kees@kernel.org, corbet@lwn.net, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com, david@redhat.com, carlos.bilbao.osdev@gmail.com,
 samuel.holland@sifive.com, ajones@ventanamicro.com,
 conor.dooley@microchip.com, andy.chiu@sifive.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 01 Oct 2024 09:06:05 -0700 you wrote:
> v5 for cpu assisted riscv user mode control flow integrity.
> zicfiss and zicfilp [1] are ratified riscv CPU extensions.
> 
> Changes in this version are
> - rebased on v6.12-rc1
> - Fixed schema related issues in device tree file
> - Fixed some of the documentation related issues in zicfilp/ss.rst
>   (style issues and added index)
> - added `SHADOW_STACK_SET_MARKER` so that implementation can define base
>   of shadow stack.
> - Fixed warnings on definitions added in usercfi.h when
>   CONFIG_RISCV_USER_CFI is not selected.
> - Adopted context header based signal handling as proposed by Andy Chiu
> - Added support for enabling kernel mode access to shadow stack using
>   FWFT [4]
> 
> [...]

Here is the summary with links:
  - [01/33] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
    (no matching commit)
  - [02/33] mm: helper `is_shadow_stack_vma` to check shadow stack vma
    (no matching commit)
  - [03/33] riscv: Enable cbo.zero only when all harts support Zicboz
    https://git.kernel.org/riscv/c/1b57747e978f
  - [04/33] riscv: Add support for per-thread envcfg CSR values
    (no matching commit)
  - [05/33] riscv: Call riscv_user_isa_enable() only on the boot hart
    (no matching commit)
  - [06/33] riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv
    (no matching commit)
  - [07/33] riscv: zicfilp / zicfiss in dt-bindings (extensions.yaml)
    (no matching commit)
  - [08/33] riscv: zicfiss / zicfilp enumeration
    (no matching commit)
  - [09/33] riscv: zicfiss / zicfilp extension csr and bit definitions
    (no matching commit)
  - [10/33] riscv: usercfi state for task and save/restore of CSR_SSP on trap entry/exit
    (no matching commit)
  - [11/33] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
    (no matching commit)
  - [12/33] riscv mm: manufacture shadow stack pte
    (no matching commit)
  - [13/33] riscv mmu: teach pte_mkwrite to manufacture shadow stack PTEs
    (no matching commit)
  - [14/33] riscv mmu: write protect and shadow stack
    (no matching commit)
  - [15/33] riscv/mm: Implement map_shadow_stack() syscall
    (no matching commit)
  - [16/33] riscv/shstk: If needed allocate a new shadow stack on clone
    (no matching commit)
  - [17/33] prctl: arch-agnostic prctl for shadow stack
    (no matching commit)
  - [18/33] prctl: arch-agnostic prctl for indirect branch tracking
    (no matching commit)
  - [19/33] riscv: Implements arch agnostic shadow stack prctls
    (no matching commit)
  - [20/33] riscv: Implements arch agnostic indirect branch tracking prctls
    (no matching commit)
  - [21/33] riscv/traps: Introduce software check exception
    (no matching commit)
  - [22/33] riscv: signal: abstract header saving for setup_sigcontext
    (no matching commit)
  - [23/33] riscv signal: save and restore of shadow stack for signal
    (no matching commit)
  - [24/33] riscv/kernel: update __show_regs to print shadow stack register
    (no matching commit)
  - [25/33] riscv/ptrace: riscv cfi status and state via ptrace and in core files
    (no matching commit)
  - [26/33] riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
    (no matching commit)
  - [27/33] riscv: Add Firmware Feature SBI extensions definitions
    (no matching commit)
  - [28/33] riscv: enable kernel access to shadow stack memory via FWFT sbi call
    (no matching commit)
  - [29/33] riscv: kernel command line option to opt out of user cfi
    (no matching commit)
  - [30/33] riscv: create a config for shadow stack and landing pad instr support
    (no matching commit)
  - [31/33] riscv: Documentation for landing pad / indirect branch tracking
    (no matching commit)
  - [32/33] riscv: Documentation for shadow stack on riscv
    (no matching commit)
  - [33/33] kselftest/riscv: kselftest for user mode cfi
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



