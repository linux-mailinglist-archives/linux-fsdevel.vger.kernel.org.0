Return-Path: <linux-fsdevel+bounces-69124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C78BCC704CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD8944FB38D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5EF350288;
	Wed, 19 Nov 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLhT6SzF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798AC3559EF;
	Wed, 19 Nov 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570451; cv=none; b=Mt6uKjlky7GCIzMrD8CAaWwiUKBuqRhTNocQPMkpSEYrV6BV8af3q0w6dHPeEEsEaXEqYVrVXJklii4NqC79Vc3+3phpdTTXvX1gxdILAWiwvMRqTsiwq9svEjqcq3JfZlJ2D70NFjNEU4Fl9Ho+Ahi2w1JhqPMKBTpSKqJm6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570451; c=relaxed/simple;
	bh=JFhkn6lZcnccDk/Xiy7qQSi9rib1FbFLEz39Orxm4zU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AjohPN4s1honwQEp+PqJkm6zkAy4f6FUuFqo9g18BBL564yXwuqVmknKg3mjEZ4ciLN7jgjHwLZ96ajqiAxztpyHPpv7arzYsU32gc3bcNngKWQBVgAhirMCetqjqMgA1jTFBjLA1YUuIygt61OhoVRDE37ZQ9/LLUS8dlyo6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLhT6SzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD87DC116D0;
	Wed, 19 Nov 2025 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763570450;
	bh=JFhkn6lZcnccDk/Xiy7qQSi9rib1FbFLEz39Orxm4zU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lLhT6SzFU8YnGXsRaD9WXB6PNnLJLV37WDNGmrJy2H1ItVpSERaHHYDaFiYKNaTV8
	 +sVhKIOM1aK6VFMCTMiiclyoJ6FbkMoHm8GmYVEwqN8HqysKqiYA2qFxVtt1FCV6GL
	 rQM3sW9biWpOtyldb5TOmuVQUiSaD48/zJmmAJb/OOdI1uJLtgsMGUt9P8LO0zJ0gD
	 RROcbYYeQdiQrEUnH79JiJ1PCp3fssgXZm7EtH+v7vliUypYK83hjFbI8kc/+cf1u4
	 f3y9tcnYDpu4hBC/zI/fNyQ2y390nUQBi/LQeDuSFAw6ek1nW6BuEi3Ur+HX4anYRQ
	 Gf66G4uOfb/ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0F39D0C22;
	Wed, 19 Nov 2025 16:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v23 00/28] riscv control-flow integrity for usermode
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176357041649.873046.14385292158343476261.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 16:40:16 +0000
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
In-Reply-To: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
 lorenzo.stoakes@oracle.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, conor@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 arnd@arndb.de, brauner@kernel.org, peterz@infradead.org, oleg@redhat.com,
 ebiederm@xmission.com, kees@kernel.org, corbet@lwn.net, shuah@kernel.org,
 jannh@google.com, conor+dt@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, lossin@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
 zong.li@sifive.com, david@redhat.com, cmirabil@redhat.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 12 Nov 2025 16:42:58 -0800 you wrote:
> v23:
> fixed some of the "CHECK:" reported on checkpatch --strict.
> Accepted Joel's suggestion for kselftest's Makefile.
> CONFIG_RISCV_USER_CFI is enabled when zicfiss, zicfilp and fcf-protection
> are all present in toolchain
> 
> v22: fixing build error due to -march=zicfiss being picked in gcc-13 and above
> but not actually doing any codegen or recognizing instruction for zicfiss.
> Change in v22 makes dependence on `-fcf-protection=full` compiler flag to
> ensure that toolchain has support and then only CONFIG_RISCV_USER_CFI will be
> visible in menuconfig.
> 
> [...]

Here is the summary with links:
  - [v23,01/28] mm: VM_SHADOW_STACK definition for riscv
    (no matching commit)
  - [v23,02/28] dt-bindings: riscv: zicfilp and zicfiss in dt-bindings (extensions.yaml)
    (no matching commit)
  - [v23,03/28] riscv: zicfiss / zicfilp enumeration
    (no matching commit)
  - [v23,04/28] riscv: zicfiss / zicfilp extension csr and bit definitions
    (no matching commit)
  - [v23,05/28] riscv: usercfi state for task and save/restore of CSR_SSP on trap entry/exit
    (no matching commit)
  - [v23,06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
    (no matching commit)
  - [v23,07/28] riscv/mm: manufacture shadow stack pte
    (no matching commit)
  - [v23,08/28] riscv/mm: teach pte_mkwrite to manufacture shadow stack PTEs
    (no matching commit)
  - [v23,09/28] riscv/mm: write protect and shadow stack
    (no matching commit)
  - [v23,10/28] riscv/mm: Implement map_shadow_stack() syscall
    (no matching commit)
  - [v23,11/28] riscv/shstk: If needed allocate a new shadow stack on clone
    (no matching commit)
  - [v23,12/28] riscv: Implements arch agnostic shadow stack prctls
    (no matching commit)
  - [v23,13/28] prctl: arch-agnostic prctl for indirect branch tracking
    (no matching commit)
  - [v23,14/28] riscv: Implements arch agnostic indirect branch tracking prctls
    (no matching commit)
  - [v23,15/28] riscv/traps: Introduce software check exception and uprobe handling
    (no matching commit)
  - [v23,16/28] riscv: signal: abstract header saving for setup_sigcontext
    https://git.kernel.org/riscv/c/bfc1388f2753
  - [v23,17/28] riscv/signal: save and restore of shadow stack for signal
    (no matching commit)
  - [v23,18/28] riscv/kernel: update __show_regs to print shadow stack register
    (no matching commit)
  - [v23,19/28] riscv/ptrace: riscv cfi status and state via ptrace and in core files
    (no matching commit)
  - [v23,20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
    (no matching commit)
  - [v23,21/28] riscv: kernel command line option to opt out of user cfi
    (no matching commit)
  - [v23,22/28] riscv: enable kernel access to shadow stack memory via FWFT sbi call
    (no matching commit)
  - [v23,23/28] arch/riscv: compile vdso with landing pad and shadow stack note
    (no matching commit)
  - [v23,24/28] arch/riscv: dual vdso creation logic and select vdso based on hw
    (no matching commit)
  - [v23,25/28] riscv: create a config for shadow stack and landing pad instr support
    (no matching commit)
  - [v23,26/28] riscv: Documentation for landing pad / indirect branch tracking
    (no matching commit)
  - [v23,27/28] riscv: Documentation for shadow stack on riscv
    (no matching commit)
  - [v23,28/28] kselftest/riscv: kselftest for user mode cfi
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



