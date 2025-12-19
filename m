Return-Path: <linux-fsdevel+bounces-71715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1969ECCEE90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 09:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76058301E991
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ED02E54BB;
	Fri, 19 Dec 2025 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo2kx7m/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACE2E2850;
	Fri, 19 Dec 2025 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131988; cv=none; b=g/uxQuY296wRtBOp60nKUBsQ7P7HIMt1ugYYQ8u4sxl/5kpb5WEUAcCK7wEV5qAQZXi8lzwlRxm2dKzWdTG0UbIp13u0ukKJhtIIjlXWPD6zIb5h7q3ts64CekMpyOIHg2vjCuvEtxiazGRvoquMDZyHW59g1VQZr/NYhZJoDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131988; c=relaxed/simple;
	bh=Da1igU9nJRPnZ5L4W+6oiwIrxZfJDMP73Owv2lIqQYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tQr9hDuI/YeNtl6JJCCANjSavhLeyU2qo1cUWnr8v1QOjZ64s7EwD7zPptPVO5IrYBJH7YeQn8TBMB8AEUbmu4Ka4kuSRy7/uL3D4SGQY3SKHOn8EMT2ePym24rjRCmoqtI2n7bfrIuBgUO6rVDf86yy9XwLSsxVyHgwB4WQ078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo2kx7m/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4893CC4CEF1;
	Fri, 19 Dec 2025 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766131987;
	bh=Da1igU9nJRPnZ5L4W+6oiwIrxZfJDMP73Owv2lIqQYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xo2kx7m/wag5DqzcA3vxDHxKhWOgdPOuJESlc1/0Bw4zijQRvGwcYF8sgefqxVOUH
	 Zw7Jq6c5KKya3qz84l3oCzhyv+f3Hl5QN6IR/gQco94/zBQsFWJdUZMRarmcE3Ll17
	 OQ7tjezH9QvsQp+tDWb38i+rSMT0jcobYPSBIFuOov4nLe+6ZCUeTdTun+6WS/hhTx
	 W5N1PVgKEmBDep/c+MpJ7ASaed7AYRm9hypU4jHMnojPqCCBuQmDlX2Msq21NunqfC
	 TPT3nmO8DeMmdKSb9GRyluaIuOy7isHD9uVzuPGv9qibqFkmE44JdEtsdo/sYFbVcX
	 QY19z9sJx1rpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78C73380AA50;
	Fri, 19 Dec 2025 08:09:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V14 0/6] riscv: mm: Add soft-dirty and uffd-wp support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176613179607.3684357.9882444672528861382.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 08:09:56 +0000
References: <20250918083731.1820327-1-zhangchunyan@iscas.ac.cn>
In-Reply-To: <20250918083731.1820327-1-zhangchunyan@iscas.ac.cn>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, krzk+dt@kernel.org,
 conor@kernel.org, debug@rivosinc.com, ved@rivosinc.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 akpm@linux-foundation.org, peterx@redhat.com, arnd@arndb.de,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 axelrasmussen@google.com, yuanchu@google.com, zhang.lyra@gmail.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Thu, 18 Sep 2025 16:37:25 +0800 you wrote:
> This patchset adds support for Svrsw60t59b [1] extension which is ratified now,
> also add soft dirty and userfaultfd write protect tracking for RISC-V.
> 
> The patches 1 and 2 add macros to allow architectures to define their own checks
> if the soft-dirty / uffd_wp PTE bits are available, in other words for RISC-V,
> the Svrsw60t59b extension is supported on which device the kernel is running.
> Also patch1-2 are removing "ifdef CONFIG_MEM_SOFT_DIRTY"
> "ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP" and
> "ifdef CONFIG_PTE_MARKER_UFFD_WP" in favor of checks which if not overridden by
> the architecture, no change in behavior is expected.
> 
> [...]

Here is the summary with links:
  - [V14,1/6] mm: softdirty: Add pgtable_supports_soft_dirty()
    (no matching commit)
  - [V14,2/6] mm: userfaultfd: Add pgtable_supports_uffd_wp()
    (no matching commit)
  - [V14,3/6] riscv: Add RISC-V Svrsw60t59b extension support
    https://git.kernel.org/riscv/c/59f6acb4be02
  - [V14,4/6] riscv: mm: Add soft-dirty page tracking support
    https://git.kernel.org/riscv/c/2a3ebad4db63
  - [V14,5/6] riscv: mm: Add userfaultfd write-protect support
    https://git.kernel.org/riscv/c/c64da3950cf4
  - [V14,6/6] dt-bindings: riscv: Add Svrsw60t59b extension description
    https://git.kernel.org/riscv/c/519912bdaee8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



