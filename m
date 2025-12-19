Return-Path: <linux-fsdevel+bounces-71718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8A4CCEF0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 09:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77AE43075619
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AD22F5A22;
	Fri, 19 Dec 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrQ01xcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56CC2F25FB;
	Fri, 19 Dec 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132003; cv=none; b=fPdesRixe4dOn7jAPbAHFJTPl8QpywoxE1CvbX6dR0ezO7AJaBodM/VQxVWBZ6Ec4pwgsqbNrz0wWURI/TH8fQPGQn3j9pa9PJDiao+yjPX563ILSxRbRD+ytyYLR0OpfBScqIbrfyhMhrcLSOsGOV1ycOPAKBuQkuCvQUKx+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132003; c=relaxed/simple;
	bh=Nh4bNCxQArVNKStHwunAd0nAadgCxl/5Y0MhYvrhhA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JZeVJhGKF9HrsmMQu5dHDgvF/3VTBJCFGyFMvTyZajvr+giSEnUrN+mBzy8HtxSuL4yDxdHYOMl28PnBNU04PNKeYlZ0ILzgnXdKDpAUDknBDnKAge53FGMxmxGyVozUi7pngGxfrdHU9jzW8duxY0wrOHk+ctAGby8YknjxWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrQ01xcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B07DC116D0;
	Fri, 19 Dec 2025 08:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766132003;
	bh=Nh4bNCxQArVNKStHwunAd0nAadgCxl/5Y0MhYvrhhA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KrQ01xcrbwQWKQ0F78yn78ahzA97qwvNR9Pw+Q526pBm5+X6gDYIO9CNYymLeRk0E
	 ZeoqNVNLts2A+jqw1Ovp2vk6AC67N40g4CisyTOpmgLZDRQvLQIQ2pVjoUpj09ivIa
	 ZcimKcA+6epLIHHxV3HeX1HwAtuKRCpw0OvtH/glgC0VDYtkFi4iWqIV4yBFZ218s9
	 mL4+6Zqvfgf0isksNC3MpFvm5K/GsLNwiogk1x5iopcqLeLmW5vG9EJo7nunl8dFd3
	 zerwTiyf2THJDZXOCHtaB1n9UonvrcWmWLjKN7yFolOruk8m3r1hGw9jual2pfz+eG
	 kw8fQM72Fuiuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B12380AA50;
	Fri, 19 Dec 2025 08:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch V3 00/12] uaccess: Provide and use scopes for user masked
 access
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176613181252.3684357.901874888075051255.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 08:10:12 +0000
References: <20251017085938.150569636@linutronix.de>
In-Reply-To: <20251017085938.150569636@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 lkp@intel.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
 torvalds@linux-foundation.org, x86@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 linuxppc-dev@lists.ozlabs.org, pjw@kernel.org, palmer@dabbelt.com,
 hca@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 linux-s390@vger.kernel.org, mathieu.desnoyers@efficios.com,
 andrew.cooper3@citrix.com, Julia.Lawall@inria.fr, nicolas.palix@imag.fr,
 peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
 andrealmeid@igalia.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linux-fsdevel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Peter Zijlstra <peterz@infradead.org>:

On Fri, 17 Oct 2025 12:08:54 +0200 (CEST) you wrote:
> This is a follow up on the V2 feedback:
> 
>    https://lore.kernel.org/20250916163004.674341701@linutronix.de
> 
> The main concern over the V2 implementation was the requirement to have
> the code within the macro itself.
> 
> [...]

Here is the summary with links:
  - [V3,01/12] ARM: uaccess: Implement missing __get_user_asm_dword()
    (no matching commit)
  - [V3,02/12] uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
    (no matching commit)
  - [V3,03/12] x86/uaccess: Use unsafe wrappers for ASM GOTO
    (no matching commit)
  - [V3,04/12] powerpc/uaccess: Use unsafe wrappers for ASM GOTO
    (no matching commit)
  - [V3,05/12] riscv/uaccess: Use unsafe wrappers for ASM GOTO
    https://git.kernel.org/riscv/c/0988ea18c624
  - [V3,06/12] s390/uaccess: Use unsafe wrappers for ASM GOTO
    (no matching commit)
  - [V3,07/12] uaccess: Provide scoped masked user access regions
    (no matching commit)
  - [V3,08/12] uaccess: Provide put/get_user_masked()
    (no matching commit)
  - [V3,09/12,RFC] coccinelle: misc: Add scoped_masked_$MODE_access() checker script
    (no matching commit)
  - [V3,10/12] futex: Convert to scoped masked user access
    (no matching commit)
  - [V3,11/12] x86/futex: Convert to scoped masked user access
    (no matching commit)
  - [V3,12/12] select: Convert to scoped masked user access
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



