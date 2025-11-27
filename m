Return-Path: <linux-fsdevel+bounces-69986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D8FC8D599
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 09:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F26C4E4D19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51405320CC0;
	Thu, 27 Nov 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy3wn4pI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81527F727;
	Thu, 27 Nov 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232261; cv=none; b=DJe2MOpeiN1gcjuAL9VzIFqTkTNk9z1DzxuIksdSoChpmBhui7BqhuL8Ie4FPMDophBuF4wFNVndH+4obnx06wFQc98t8bS3Xuv7pPwEdETBUXNs2mpt8iJeYglWQqn/yCz9Vkl7Be5DjPJw4A4PmljkUMXFSl4RqnhC336ooaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232261; c=relaxed/simple;
	bh=Hw3rpyjIs5q2m80mOXGPqWY/yNyazFCdz/ULb4y5eE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MiLNRry6sAKj1bIxSZMgZ4eeUJKGzakNaDvioPEJurihRmohOz7obeeG2MCpsNV7odKkDv+J9dPhdCJA97gTMaJ0EerF2BRlNifCO5par3/uz77guq4+Lj1IBiQ+Mje/BJ7auuWI8wtKDhkEyY25esD7RyjGyuDl0962FA/BVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy3wn4pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04754C113D0;
	Thu, 27 Nov 2025 08:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764232261;
	bh=Hw3rpyjIs5q2m80mOXGPqWY/yNyazFCdz/ULb4y5eE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hy3wn4pIoJRjHnOpzYoslQqGho8xq0Z9RYYtBYN7+2U4rmY+LWmfVf7QjhnFLU0Mv
	 QEDP6WThf6o5Q53L7jnlkEhpeYY48FZgFAt4ZuoKkLd8wdchRSGHF/bEWGOnGHYBBT
	 FZ8xnt7DwDjwc8HuYv/UEioqMANa99L8z5klJ7kXO7QR9T1fKlc6GLVl08SqYFo5Lg
	 RaTsa2Z8ARaoDxgBAXOvRTYOfrpd22vE5+10ciSjeYr16NsDt0ap+IHbaB2YhBdfA5
	 1+WTRwoaMqCQwXUJPSdoVgujZPRxtohgp1aIb2iJZsXu+3yC16Y7s79nq8I1k8N+Fe
	 fXBu/eflyUvhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9D380CFC2;
	Thu, 27 Nov 2025 08:30:23 +0000 (UTC)
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
 <176423222224.2476283.17736612090314280039.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 08:30:22 +0000
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
    https://git.kernel.org/riscv/c/ae8460ac9db2
  - [v23,02/28] dt-bindings: riscv: zicfilp and zicfiss in dt-bindings (extensions.yaml)
    https://git.kernel.org/riscv/c/b32ccfc268db
  - [v23,03/28] riscv: zicfiss / zicfilp enumeration
    https://git.kernel.org/riscv/c/55a811a7f304
  - [v23,04/28] riscv: zicfiss / zicfilp extension csr and bit definitions
    https://git.kernel.org/riscv/c/92c96b16548e
  - [v23,05/28] riscv: usercfi state for task and save/restore of CSR_SSP on trap entry/exit
    https://git.kernel.org/riscv/c/7720cdd21962
  - [v23,06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
    https://git.kernel.org/riscv/c/e60eb198b13d
  - [v23,07/28] riscv/mm: manufacture shadow stack pte
    https://git.kernel.org/riscv/c/f8fcb7b5bf30
  - [v23,08/28] riscv/mm: teach pte_mkwrite to manufacture shadow stack PTEs
    https://git.kernel.org/riscv/c/0276a5ea1105
  - [v23,09/28] riscv/mm: write protect and shadow stack
    https://git.kernel.org/riscv/c/ae615676bc37
  - [v23,10/28] riscv/mm: Implement map_shadow_stack() syscall
    https://git.kernel.org/riscv/c/d291fd38f841
  - [v23,11/28] riscv/shstk: If needed allocate a new shadow stack on clone
    https://git.kernel.org/riscv/c/d209ea2fa4bb
  - [v23,12/28] riscv: Implements arch agnostic shadow stack prctls
    https://git.kernel.org/riscv/c/8b49f512abc2
  - [v23,13/28] prctl: arch-agnostic prctl for indirect branch tracking
    https://git.kernel.org/riscv/c/3363a8d1044e
  - [v23,14/28] riscv: Implements arch agnostic indirect branch tracking prctls
    https://git.kernel.org/riscv/c/0177891ccdb7
  - [v23,15/28] riscv/traps: Introduce software check exception and uprobe handling
    https://git.kernel.org/riscv/c/6f71171a7448
  - [v23,16/28] riscv: signal: abstract header saving for setup_sigcontext
    (no matching commit)
  - [v23,17/28] riscv/signal: save and restore of shadow stack for signal
    https://git.kernel.org/riscv/c/4f9da7ad3478
  - [v23,18/28] riscv/kernel: update __show_regs to print shadow stack register
    https://git.kernel.org/riscv/c/320c96a55d73
  - [v23,19/28] riscv/ptrace: riscv cfi status and state via ptrace and in core files
    https://git.kernel.org/riscv/c/7a39f89a817e
  - [v23,20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
    https://git.kernel.org/riscv/c/c09b490a9267
  - [v23,21/28] riscv: kernel command line option to opt out of user cfi
    https://git.kernel.org/riscv/c/6e0dc40ceb45
  - [v23,22/28] riscv: enable kernel access to shadow stack memory via FWFT sbi call
    https://git.kernel.org/riscv/c/dfd087078357
  - [v23,23/28] arch/riscv: compile vdso with landing pad and shadow stack note
    https://git.kernel.org/riscv/c/2cfe57e3bd9b
  - [v23,24/28] arch/riscv: dual vdso creation logic and select vdso based on hw
    https://git.kernel.org/riscv/c/418316aa61e8
  - [v23,25/28] riscv: create a config for shadow stack and landing pad instr support
    https://git.kernel.org/riscv/c/c5f5ce714457
  - [v23,26/28] riscv: Documentation for landing pad / indirect branch tracking
    https://git.kernel.org/riscv/c/73d0ccec35b8
  - [v23,27/28] riscv: Documentation for shadow stack on riscv
    https://git.kernel.org/riscv/c/6b8214c8cbd6
  - [v23,28/28] kselftest/riscv: kselftest for user mode cfi
    https://git.kernel.org/riscv/c/0f226cf6026f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



