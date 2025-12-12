Return-Path: <linux-fsdevel+bounces-71184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F0CB7F8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 06:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10C5930155C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 05:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815B830E0CE;
	Fri, 12 Dec 2025 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyO/BSfw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E823C465;
	Fri, 12 Dec 2025 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765518802; cv=none; b=ls8Bs8YjOTnJtho1gY+NFjisv4S2hK4tY9xBaECDiZmX7moo0eMkFsL+8fxIbY+wVsIz7DMZx2e0vvrESuoXn+dsNbt/MTU8k97SauT0SA67QHsvrYbrytcZt/yIuz+UfMjXd77g0TCj6qIFhBvAYZy7pM6Sxd6+WtVjMQN0+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765518802; c=relaxed/simple;
	bh=hqZiXxUv6smJHZEauESfPalDA9+KANqTpadXMEusfNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UtSESvPkb/iSuX3SpjXZjQYcz5M0VIDGRnSVTJhdoyrs5Bi5tJfutSTpmE0Eixc8gKJ+XepFxKYjQDHI5BQCpqtJasYvaQmOaFN3QgInhQiuuC9pwYnKICIwru0JM+f34FyQLq5I7ynY1OS3eQnlMydMCH/qUQNh2CQLNHU0rZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyO/BSfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4EAC4CEF1;
	Fri, 12 Dec 2025 05:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765518802;
	bh=hqZiXxUv6smJHZEauESfPalDA9+KANqTpadXMEusfNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AyO/BSfwTPEnPYiKTNe49XE5ReOcZayLHxn1jhIueisyharCn+IGjtVnILr1TyT4G
	 nKspnHRVYrODD0i8/slxWhZO45GVoryW8+V/nxlc/cl74nTuJRbLhh3ggNHZOEBuYb
	 QDmLjiWrVjXjswh87/9uwuRkEI8eFewPySbNTeNTwGLTcMN1WG3UEMMW4dyWT3R8WC
	 usqvWUjSdiWX6RPs7TcBpBmWUvNqIWTkoQltHM7P5Np0sArdIfW5uDHthsrsmogOdO
	 hIkW5ifAR2CVWEU0QaSLWbDYhAy2B4dDGsH3opzA5PTXmucpnskg1uCN7anY9zjNbX
	 o+vLEGqelWAfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F34E13809A37;
	Fri, 12 Dec 2025 05:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v26 00/28] riscv control-flow integrity for usermode
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176551861579.2032148.13920544388182691102.git-patchwork-notify@kernel.org>
Date: Fri, 12 Dec 2025 05:50:15 +0000
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
In-Reply-To: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
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
 zong.li@sifive.com, david@redhat.com, andreas.korb@aisec.fraunhofer.de,
 valentin.haudiquet@canonical.com, cmirabil@redhat.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Thu, 11 Dec 2025 09:20:33 -0800 you wrote:
> v26: CONFIG_RISCV_USER_CFI depends on CONFIG_MMU (dependency of shadow stack
> on MMU). Used b4 to pick tags, apparantly it messed up some tag picks. Fixing it
> 
> v25: Removal of `riscv_nousercfi` from `cpufeature.c` and instead placing
> it as extern in `usercfi.h` was leading to build error whene cfi config
> is not selected. Placed `riscv_nousercfi` outside cfi config ifdef block
> in `usercfi.h`
> 
> [...]

Here is the summary with links:
  - [v26,01/28] mm: VM_SHADOW_STACK definition for riscv
    https://git.kernel.org/riscv/c/e53803e4a8c5
  - [v26,02/28] dt-bindings: riscv: zicfilp and zicfiss in dt-bindings (extensions.yaml)
    https://git.kernel.org/riscv/c/d6c9672baa77
  - [v26,03/28] riscv: zicfiss / zicfilp enumeration
    (no matching commit)
  - [v26,04/28] riscv: zicfiss / zicfilp extension csr and bit definitions
    (no matching commit)
  - [v26,05/28] riscv: usercfi state for task and save/restore of CSR_SSP on trap entry/exit
    https://git.kernel.org/riscv/c/2acf75f432dc
  - [v26,06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
    https://git.kernel.org/riscv/c/813c549f5b08
  - [v26,07/28] riscv/mm: manufacture shadow stack pte
    https://git.kernel.org/riscv/c/d3cea05f52a7
  - [v26,08/28] riscv/mm: teach pte_mkwrite to manufacture shadow stack PTEs
    https://git.kernel.org/riscv/c/444404ff99bf
  - [v26,09/28] riscv/mm: write protect and shadow stack
    https://git.kernel.org/riscv/c/5da46726825d
  - [v26,10/28] riscv/mm: Implement map_shadow_stack() syscall
    (no matching commit)
  - [v26,11/28] riscv/shstk: If needed allocate a new shadow stack on clone
    (no matching commit)
  - [v26,12/28] riscv: Implements arch agnostic shadow stack prctls
    https://git.kernel.org/riscv/c/46f2da262367
  - [v26,13/28] prctl: arch-agnostic prctl for indirect branch tracking
    https://git.kernel.org/riscv/c/5b23a2d70976
  - [v26,14/28] riscv: Implements arch agnostic indirect branch tracking prctls
    https://git.kernel.org/riscv/c/2b1bd48147c5
  - [v26,15/28] riscv/traps: Introduce software check exception and uprobe handling
    (no matching commit)
  - [v26,16/28] riscv: signal: abstract header saving for setup_sigcontext
    (no matching commit)
  - [v26,17/28] riscv/signal: save and restore of shadow stack for signal
    (no matching commit)
  - [v26,18/28] riscv/kernel: update __show_regs to print shadow stack register
    https://git.kernel.org/riscv/c/35d89b5390a9
  - [v26,19/28] riscv/ptrace: riscv cfi status and state via ptrace and in core files
    (no matching commit)
  - [v26,20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
    (no matching commit)
  - [v26,21/28] riscv: kernel command line option to opt out of user cfi
    (no matching commit)
  - [v26,22/28] riscv: enable kernel access to shadow stack memory via FWFT sbi call
    https://git.kernel.org/riscv/c/ef83c58ab12f
  - [v26,23/28] arch/riscv: compile vdso with landing pad and shadow stack note
    (no matching commit)
  - [v26,24/28] arch/riscv: dual vdso creation logic and select vdso based on hw
    https://git.kernel.org/riscv/c/fbe7823a03f1
  - [v26,25/28] riscv: create a config for shadow stack and landing pad instr support
    (no matching commit)
  - [v26,26/28] riscv: Documentation for landing pad / indirect branch tracking
    (no matching commit)
  - [v26,27/28] riscv: Documentation for shadow stack on riscv
    (no matching commit)
  - [v26,28/28] kselftest/riscv: kselftest for user mode cfi
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



