Return-Path: <linux-fsdevel+bounces-71717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A832CCEF0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 09:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09CED30451BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 08:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0F2EB5A1;
	Fri, 19 Dec 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLiYOmvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CDC2DCBE3;
	Fri, 19 Dec 2025 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131998; cv=none; b=pYNXSEQK3kK3tjGnaVY1KM7xX0lu/8zGYGkOCxSSmkpbJCoj+vVtQennubij7EoN3CTmFF+ZAlhCnsJ3X5CmcBevQTVpPPrBDroTDpiLtB+LJJ63tE5bxa7v9RL6WgXNzF1TMDjdCzDYcCghZ5OZquwbUIOSx7+MN0KmkGvX01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131998; c=relaxed/simple;
	bh=ZpBHca7oN52iVgWXthIDFgDhI9A0INgKqTumn5Wu6+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dJeGGgzNQUVNh/nAgnGjw7DsCDIRsazEpdvz4La3SFfSw3t9wceLru/pwiXPHcoTiE9bYxodcTDBSXi2L95zUfFlpsg5OOYY3QoYiZ0Zp7fEzaSHtehumIHHuCy1BPGWcL9u1XcSjsbPPg5PclyF0lxWLtYepd75m+7m/mw4v2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLiYOmvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DA1C4CEF1;
	Fri, 19 Dec 2025 08:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766131998;
	bh=ZpBHca7oN52iVgWXthIDFgDhI9A0INgKqTumn5Wu6+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GLiYOmvPUPoGBBkA0Ts0/kjAyBBbJ5CVV866J5BiVEgPJj3OYjRgC+9kPctyKNkbY
	 OTmQcFlqulWRizG9DOeVMcBBx3TMpnVx8OsXdwOLS+oyRNZ43rplVORNJeOQQd5TCz
	 VpcmAphzU3UsvkI5L30JzY+yn/H0KfEWqpVte7ln/hSbjF1dNKhUJB0U1REatJzEyR
	 lb/rrla5Oq6RnkhwpZlVihV4NT0itGutxX9yV+3Mu7xreaNE+7eVmbadIEeUslLbKZ
	 K6SjjazHiexJwS8UcYibsLYI3osV5J/1Mf1cfAxG4KlgZXMP2+gQZEcu1CfsRsvhQs
	 DlwDgJSLvSrwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7872A380AA50;
	Fri, 19 Dec 2025 08:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch V5 00/12] uaccess: Provide and use scopes for user access
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176613180728.3684357.15978002339429469981.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 08:10:07 +0000
References: <20251027083700.573016505@linutronix.de>
In-Reply-To: <20251027083700.573016505@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 lkp@intel.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
 torvalds@linux-foundation.org, x86@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 linuxppc-dev@lists.ozlabs.org, pjw@kernel.org, palmer@dabbelt.com,
 hca@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 linux-s390@vger.kernel.org, mathieu.desnoyers@efficios.com,
 andrew.cooper3@citrix.com, david.laight.linux@gmail.com,
 Julia.Lawall@inria.fr, nicolas.palix@imag.fr, peterz@infradead.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Ingo Molnar <mingo@kernel.org>:

On Mon, 27 Oct 2025 09:43:40 +0100 (CET) you wrote:
> This is a follow up on the V4 feedback:
> 
>    https://lore.kernel.org/20251022102427.400699796@linutronix.de
> 
> Changes vs. V4:
> 
>   - Rename get/put_user_masked() to get/put_user_inline()
> 
> [...]

Here is the summary with links:
  - [V5,01/12] ARM: uaccess: Implement missing __get_user_asm_dword()
    https://git.kernel.org/riscv/c/44c5b6768e3a
  - [V5,02/12] uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
    (no matching commit)
  - [V5,03/12] x86/uaccess: Use unsafe wrappers for ASM GOTO
    https://git.kernel.org/riscv/c/14219398e3e1
  - [V5,04/12] powerpc/uaccess: Use unsafe wrappers for ASM GOTO
    https://git.kernel.org/riscv/c/5002dd53144f
  - [V5,05/12] riscv/uaccess: Use unsafe wrappers for ASM GOTO
    https://git.kernel.org/riscv/c/0988ea18c624
  - [V5,06/12] s390/uaccess: Use unsafe wrappers for ASM GOTO
    https://git.kernel.org/riscv/c/43cc54d8dbe6
  - [V5,07/12] uaccess: Provide scoped user access regions
    https://git.kernel.org/riscv/c/e497310b4ffb
  - [V5,08/12] uaccess: Provide put/get_user_inline()
    https://git.kernel.org/riscv/c/b2cfc0cd68b8
  - [V5,09/12,RFC] coccinelle: misc: Add scoped_masked_$MODE_access() checker script
    (no matching commit)
  - [V5,10/12] futex: Convert to get/put_user_inline()
    https://git.kernel.org/riscv/c/e4e28fd6986e
  - [V5,11/12] x86/futex: Convert to scoped user access
    https://git.kernel.org/riscv/c/e02718c9865c
  - [V5,12/12] select: Convert to scoped user access
    https://git.kernel.org/riscv/c/3ce17e690994

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



