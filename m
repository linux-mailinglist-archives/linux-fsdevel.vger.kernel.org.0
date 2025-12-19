Return-Path: <linux-fsdevel+bounces-71716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD21CCEE98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 09:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD00B3027C90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 08:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADF32E2679;
	Fri, 19 Dec 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3+Ld/gM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57172E54DE;
	Fri, 19 Dec 2025 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131988; cv=none; b=P0PPXogQRm+RskWbal+nuuYNbbpBr5l+i2KFw6hS1wW8BB/tXAE+XJm96P8zHd1jHlAME5jNiq7xjmzOKd7Z9ls/WnoP3/xzKCJe+KBSGQ8pcYlkFJL0ghrhv08uqdEych+jksgNKVWJtvtqefJqyROI/87qKMBN0iMpwcNX2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131988; c=relaxed/simple;
	bh=d8hfIZrr4/YXPj8cN2Cj2/92hRyCmo8T5+xN5aVcRQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jeqcSCVTePuNV1s8wTcbtGParyQvvuaebv9HxkU6d7RuT8gri7GcdUTOAMjui7KFQw8e/+OtolFHjQW3ll2mUYuD2OYVC6nn3Lv+sg8LM8VtMVy3G7fDo8LvL2mCznG+bORz0x+P+sDQzb4hOfTf5ChrbefW27LFXvGvb1gyj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3+Ld/gM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFBCC116D0;
	Fri, 19 Dec 2025 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766131988;
	bh=d8hfIZrr4/YXPj8cN2Cj2/92hRyCmo8T5+xN5aVcRQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k3+Ld/gMgJdQln6OYHiKMS1MJHb7f7DcLdsqE0tNLr1lddoHDAG2kbDRMYAqOiZC0
	 ljyJ/uW1xSSjlmHEnwdR5HTtwuKGqrR4nnfjNto4oUq0/ZKPv52jdgz3sMpSwa5INl
	 w2WrclITAvmoSbYgAq9UJ50/LqzbUQTrUKzDS3SutXXJ7ulB8ZC0ShLlpfH2KVddgi
	 GLh76tDdnwFtoBFaFbN0H/CeqSn35onbRnoNNuqJAshypHMNPP9j3HzDwHVFExFWW4
	 RiJBPscY5fyO/An3piZdVOGDZCVvtVPYlWtWiSB39EfTtQNoCI5TtJbo/Butp7rBWY
	 Vt7k192nPv08g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BAFFF380AA50;
	Fri, 19 Dec 2025 08:09:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V15 0/6] mm: Add soft-dirty and uffd-wp support for RISC-V
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176613179753.3684357.9232536876700383473.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 08:09:57 +0000
References: <20251113072806.795029-1-zhangchunyan@iscas.ac.cn>
In-Reply-To: <20251113072806.795029-1-zhangchunyan@iscas.ac.cn>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, robh@kernel.org,
 krzk+dt@kernel.org, viro@zeniv.linux.org.uk, linux-mm@kvack.org,
 peterx@redhat.com, arnd@arndb.de, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 axelrasmussen@google.com, yuanchu@google.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, devicetree@vger.kernel.org, conor@kernel.org,
 debug@rivosinc.com, ved@rivosinc.com, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
 zhang.lyra@gmail.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Thu, 13 Nov 2025 15:28:00 +0800 you wrote:
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
  - [V15,1/6] mm: softdirty: Add pgtable_supports_soft_dirty()
    (no matching commit)
  - [V15,2/6] mm: userfaultfd: Add pgtable_supports_uffd_wp()
    https://git.kernel.org/riscv/c/f59c0924d61a
  - [V15,3/6] riscv: Add RISC-V Svrsw60t59b extension support
    https://git.kernel.org/riscv/c/59f6acb4be02
  - [V15,4/6] riscv: mm: Add soft-dirty page tracking support
    https://git.kernel.org/riscv/c/2a3ebad4db63
  - [V15,5/6] riscv: mm: Add userfaultfd write-protect support
    https://git.kernel.org/riscv/c/c64da3950cf4
  - [V15,6/6] dt-bindings: riscv: Add Svrsw60t59b extension description
    https://git.kernel.org/riscv/c/519912bdaee8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



