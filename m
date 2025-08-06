Return-Path: <linux-fsdevel+bounces-56858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B65B1CA6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787DD16F6DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E029CB54;
	Wed,  6 Aug 2025 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw1aN0hN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40C29C321;
	Wed,  6 Aug 2025 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500524; cv=none; b=J61ChRkXRSQLJrm2zywyN6Zuo9gEQSJtGc89u706MDVJ+iUv9Dtf99QYu4EYYS4BHODtYxImqTubuGW/9xg3bSArQo1jV7I1Y17hxhsc8iBORkFXMf5fbYhfBK1LthVaU2fQ8kN3/BJjIVGSXhbhzyVKLQeUtl9cWlL1wiGoaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500524; c=relaxed/simple;
	bh=iP1Vp96AUt0/1/dByJQwxu90FSDRv7L6wCxaXLDltks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Km4K+n98kPI++SjVqFSc6V3nvBj+ezUZqd+cbVCPoP+DLXVJPcn6eBCAOWI16pucOCIBIry0KlH9aDEHNn2s5jLXbnleUUnC0+IYX0PytqZs7Tz7v+KvRwdVQglxeR+gMBETeYTbHv9iPpb3P8Oep6fwYdmnk1KKrZFvWnlTJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vw1aN0hN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D63C4CEED;
	Wed,  6 Aug 2025 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500524;
	bh=iP1Vp96AUt0/1/dByJQwxu90FSDRv7L6wCxaXLDltks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vw1aN0hNtZowJgcCAWQjQrvy1CggQwRgv1AmfnF9BoNdbhKbl20bmLNFFEinlAXHV
	 +w4BhSV/iS5VpXCOXMfVC2oib1f4+cK4iU7lMkZEEuSYSsXQwhmIdfXIRMLMtdLxW6
	 1KnFFSB4y9bLqDKwrY6nypuQDbyPsoApw+aSreNqSOIMJO1YmARi/cvjsO8onAay8V
	 3XHxzDEvk/SD9mXgpLU2s2lQtZBsUaTRQ3dxYTNcVGbq6wDyDapPIA5HrbwYZl6fkH
	 NAa/SFX/I0dxSzNBYT1szqKceE/kuRjMhUic9aZIibRYVGurAM2E1C6y9jEaDfnJUq
	 YZcwSJ3tFPqFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C94383BF63;
	Wed,  6 Aug 2025 17:15:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450053775.2863135.11568399057706626223.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:37 +0000
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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
 zong.li@sifive.com, david@redhat.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Thu, 31 Jul 2025 16:19:10 -0700 you wrote:
> Basics and overview
> ===================
> 
> Software with larger attack surfaces (e.g. network facing apps like databases,
> browsers or apps relying on browser runtimes) suffer from memory corruption
> issues which can be utilized by attackers to bend control flow of the program
> to eventually gain control (by making their payload executable). Attackers are
> able to perform such attacks by leveraging call-sites which rely on indirect
> calls or return sites which rely on obtaining return address from stack memory.
> 
> [...]

Here is the summary with links:
  - [v19,01/27] mm: VM_SHADOW_STACK definition for riscv
    https://git.kernel.org/riscv/c/cbac1921f599
  - [v19,02/27] dt-bindings: riscv: zicfilp and zicfiss in dt-bindings (extensions.yaml)
    https://git.kernel.org/riscv/c/529ea23b9724
  - [v19,03/27] riscv: zicfiss / zicfilp enumeration
    https://git.kernel.org/riscv/c/2672fcca7d45
  - [v19,04/27] riscv: zicfiss / zicfilp extension csr and bit definitions
    https://git.kernel.org/riscv/c/9c6a894fd8b3
  - [v19,05/27] riscv: usercfi state for task and save/restore of CSR_SSP on trap entry/exit
    https://git.kernel.org/riscv/c/b01f6537153c
  - [v19,06/27] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
    https://git.kernel.org/riscv/c/c13b2d7c1365
  - [v19,07/27] riscv/mm: manufacture shadow stack pte
    https://git.kernel.org/riscv/c/68cd7334a8d2
  - [v19,08/27] riscv/mm: teach pte_mkwrite to manufacture shadow stack PTEs
    https://git.kernel.org/riscv/c/50c9b9607c89
  - [v19,09/27] riscv/mm: write protect and shadow stack
    https://git.kernel.org/riscv/c/cbcccac1eddc
  - [v19,10/27] riscv/mm: Implement map_shadow_stack() syscall
    https://git.kernel.org/riscv/c/26e35e774a64
  - [v19,11/27] riscv/shstk: If needed allocate a new shadow stack on clone
    https://git.kernel.org/riscv/c/9c72a71321a6
  - [v19,12/27] riscv: Implements arch agnostic shadow stack prctls
    https://git.kernel.org/riscv/c/52eff0ab5f8e
  - [v19,13/27] prctl: arch-agnostic prctl for indirect branch tracking
    https://git.kernel.org/riscv/c/157690650241
  - [v19,14/27] riscv: Implements arch agnostic indirect branch tracking prctls
    https://git.kernel.org/riscv/c/e97ca201e919
  - [v19,15/27] riscv/traps: Introduce software check exception and uprobe handling
    https://git.kernel.org/riscv/c/d88b76756b34
  - [v19,16/27] riscv: signal: abstract header saving for setup_sigcontext
    https://git.kernel.org/riscv/c/63e713f29efe
  - [v19,17/27] riscv/signal: save and restore of shadow stack for signal
    https://git.kernel.org/riscv/c/5b04bbd448a5
  - [v19,18/27] riscv/kernel: update __show_regs to print shadow stack register
    https://git.kernel.org/riscv/c/1400341403b3
  - [v19,19/27] riscv/ptrace: riscv cfi status and state via ptrace and in core files
    https://git.kernel.org/riscv/c/982c862820b8
  - [v19,20/27] riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
    https://git.kernel.org/riscv/c/07b1d75233e4
  - [v19,21/27] riscv: kernel command line option to opt out of user cfi
    https://git.kernel.org/riscv/c/2c268d3d21f9
  - [v19,22/27] riscv: enable kernel access to shadow stack memory via FWFT sbi call
    https://git.kernel.org/riscv/c/4ff7e8937f22
  - [v19,23/27] arch/riscv: compile vdso with landing pad and shadow stack note
    https://git.kernel.org/riscv/c/a82422297e63
  - [v19,24/27] riscv: create a config for shadow stack and landing pad instr support
    https://git.kernel.org/riscv/c/5bb36633ee56
  - [v19,25/27] riscv: Documentation for landing pad / indirect branch tracking
    https://git.kernel.org/riscv/c/9868b87525d9
  - [v19,26/27] riscv: Documentation for shadow stack on riscv
    https://git.kernel.org/riscv/c/a56a53730eb6
  - [v19,27/27] kselftest/riscv: kselftest for user mode cfi
    https://git.kernel.org/riscv/c/fd40e4a14f45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



