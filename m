Return-Path: <linux-fsdevel+bounces-24490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7A293FB7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A506D1F22F5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6BF186E51;
	Mon, 29 Jul 2024 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxGffYre"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C31534EC;
	Mon, 29 Jul 2024 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271180; cv=none; b=WjsjJNi31QGI277pVjUFlFVzWQ+jiHBNt1M6Rmlip0DWXdcAP4FLfZl/gaKJiGiS3EhtHuIxFXiGPVZb+Hc0evaHRK+soOxk1gFh8wgSSe6reHji64dm+3pQ2Y2k4MPTvjg/qehf9VthXUKyHwdiTOzqErda1pAROSy5TUaeq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271180; c=relaxed/simple;
	bh=ACOFD4CnvNQvgxH3c3fJIkYLBWpRIGrdoWdi94w0LGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O9d+GNMMWs0eMqVpSe76P8lJ9WIHzvyAYEsVKRN4BTb3I2Tu90iQBbmcf+hCqGbx7BdwTkGwS2ZJADReQfE26HcRphM9LNyCDaOMHso+e+XbZ93CCtzbZFy2elwIe8GrHbChS7FJzSvP6vvcGDY/fX0R/kAUiLOAdvi1OuduckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxGffYre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5937C4AF0C;
	Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722271179;
	bh=ACOFD4CnvNQvgxH3c3fJIkYLBWpRIGrdoWdi94w0LGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MxGffYremrlYV7IoL+PFdzTVghbhUmYE24NoiOXwot130hJR092fMDPljyjOFHVdc
	 BwOk8pSOjwwKbEdqNqxYUxpql4UoUKiFJ2lsCDqaei8fiv2nLmq0phzDybvS4Ruc8d
	 z/XfJg+CKgAclYeW7CbbQLEE7gLL/hM0xFPcU/zrpTnoN8mAo4/WHGmlPe/dDySyr4
	 +P5sQueNRxv+PdBs1m2FMKXNsYAKLBJPpcrqn+AXFKcM9NOrWmX7bCZDnXiuc8wZZk
	 cgjYyQYbzjQhie1m/6w7FgPL23bO3WKyoer9qNey5Cb3pqkqUfzFfvK9OYAA6SDF3G
	 K/Q0xuxSAzaPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBA0BC43613;
	Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172227117976.3603.14526183264046270376.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 16:39:39 +0000
References: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
To: Joel Granados <j.granados@samsung.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux@weissschuh.net, mcgrof@kernel.org, kees@kernel.org, kuba@kernel.org,
 david@fromorbit.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org,
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com

Hello:

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Wed, 24 Jul 2024 23:00:14 +0200 you wrote:
> Linus
> 
> Constifying ctl_table structs will prevent the modification of
> proc_handler function pointers as they would reside in .rodata. To get
> there, the proc_handler arguments must first be const qualified which
> requires this (fairly large) treewide PR. Sending it in the tail end of
> of the merge window after a suggestion from Kees to avoid unneeded merge
> conflicts. It has been rebased on top of 7a3fad30fd8b4b5e370906b3c554f64026f56c2f.
> I can send it later if it makes more sense on your side; please tell me
> what you prefer.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] sysctl constification changes for v6.11-rc1
    https://git.kernel.org/riscv/c/f8a8b94d0698

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



