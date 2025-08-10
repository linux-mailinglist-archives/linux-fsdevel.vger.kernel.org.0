Return-Path: <linux-fsdevel+bounces-57244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE63B1FC32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 23:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F313AC63C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9CA23D283;
	Sun, 10 Aug 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivL7QVkh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D8238D49;
	Sun, 10 Aug 2025 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860332; cv=none; b=nn9SGRfFrp+AS6HsbsEFyvh+5E0/TulqJRrYRL9nvhWFyrDOMrsBzy8iOIRLhbRKBBFpTf8YZL9L7+NQmf/olUWH8Gp3e8ASfZ/fZ01MxEJFFOan9BZUWuUmWcPCUrA8ggBGekReZJnUQr1xGwct716ngEs+DGZs0x2doSyxePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860332; c=relaxed/simple;
	bh=Nk+nlMj8RvGrT4DnRJpYaYLBYV46+pgSfSCrnwqmvis=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KH1hUKbDZX9Ve+0xJ1PIblcCdF4wMXCeDLwBXlRVHJhKr9+HKfNawvuIFhQgGM1B6opW/4xi/WUTXRD9xu5k+3azFRwSK46MPR7oZci43ag/QTEuWwQa4WdbE4qbG+a4CuGIC+1LD67nqaQragdchM1mxGWHyqXLvguUKCyhnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivL7QVkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDC6C4CEEB;
	Sun, 10 Aug 2025 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754860332;
	bh=Nk+nlMj8RvGrT4DnRJpYaYLBYV46+pgSfSCrnwqmvis=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ivL7QVkhykah8Omp/xFVgPDQSPoT8cIdd4Im4ynihPf2YbWyPmaNvPTw0HMhYUz/a
	 pbal64NXxrXhpFBa03AfI5GX9PNQZZ5idrrx+g3S9/abi0O35bASo20zdfJOSEz/7j
	 3TfcwH7JtDCjBLWvI8/J20EHVLISYGk425x8i6JKPo/4Y9mE/nNbM4k6np6jNUm1tA
	 cIr3bixLpGp6psNrTIIqq/DJAd3euWqY0AAOCYGfTeZwMGpEbdkAdH5DV4DGN4Wv89
	 dNWT3b5gLlN/kP/B5Dc7Uijo4Yw7caeoFU8JThW+R05PMi5Vde3d1h/ni+jDxcT5ya
	 U2QfoCm9jPNwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2039D0C2B;
	Sun, 10 Aug 2025 21:12:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/6] docs: Remove false positives from check-sysctl-docs
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175486034524.1221929.1694480113579330478.git-patchwork-notify@kernel.org>
Date: Sun, 10 Aug 2025 21:12:25 +0000
References: <20250701-jag-sysctldoc-v1-0-936912553f58@kernel.org>
In-Reply-To: <20250701-jag-sysctldoc-v1-0-936912553f58@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: linux-riscv@lists.infradead.org, kees@kernel.org, corbet@lwn.net,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Joel Granados <joel.granados@kernel.org>:

On Tue, 01 Jul 2025 10:56:41 +0200 you wrote:
> Removed false positives from check-sysctl-docs where there where
> ctl_tables that were implemented and had documentation but were being
> marked as undocumented or unimplemented.
> 
> Besides adjusting the patterns in the check-sysctl-docs script, I also
> corrected formatting in the kernel.rst and vm.rst doc files (no wording
> changes!)
> 
> [...]

Here is the summary with links:
  - [1/6] docs: nixify check-sysctl-docs
    https://git.kernel.org/riscv/c/89b491bcf2d1
  - [2/6] docs: Use skiplist when checking sysctl admin-guide
    https://git.kernel.org/riscv/c/be0aef10dca8
  - [3/6] docs: Add awk section for ucount sysctl entries
    https://git.kernel.org/riscv/c/e97a96baa527
  - [4/6] docs: Remove colon from ctltable title in vm.rst
    https://git.kernel.org/riscv/c/30ec9fde45b5
  - [5/6] docs: Replace spaces with tabs in check-sysctl-docs
    https://git.kernel.org/riscv/c/999aab7f5645
  - [6/6] docs: Downgrade arm64 & riscv from titles to comment
    https://git.kernel.org/riscv/c/ffc137c5c195

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



