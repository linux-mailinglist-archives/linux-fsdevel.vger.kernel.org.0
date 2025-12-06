Return-Path: <linux-fsdevel+bounces-70922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9147CA9C8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 01:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E6A630180F6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 00:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59528314B8A;
	Sat,  6 Dec 2025 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7ZoYgVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF2314B6A;
	Sat,  6 Dec 2025 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980416; cv=none; b=irhffTW7F/sWZ+KjGAolrGzKG/Rt+TP+tKWD9jwtZh0dABrZjmJI/Ax88ZvuGB+Tt3vlpaaBVtqDN0dSmyGrADRcHrp2pDuWVgOICo9eqDOC0hDaIpMP2F1cEC2x6bVQrwjfMZLYvBBw6a2WcCSBjb2VGxygPsMB8VQncSUYb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980416; c=relaxed/simple;
	bh=lPKBVDJal5pPkGxKSDT61250M+dq6pG8esmw4iWvDwo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r+zxBO2BnD+iz6kQW+0iazxYYODQ4TirHirGCOVkJBgEPA9TsDhUBMxtPALcpyngEm9MsS0Jt6nTz9Q/Uji2uOgR1hZV4ZJLRCxNRw4V+4my7EmG+is0B1JG9r0dwUwd0eZh3sX93DAiTkatokq+NeSINfT0cGPEW1VKD5hustE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7ZoYgVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C891C16AAE;
	Sat,  6 Dec 2025 00:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764980416;
	bh=lPKBVDJal5pPkGxKSDT61250M+dq6pG8esmw4iWvDwo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T7ZoYgVtBIGp/UeeZ58Bg7f3BckdljKTmKmoYjplrBbbhBReOp5qoKE2QOfKasG+I
	 k+ZldkMRFit6EGDBLcpoNpSrmWzQmRqM1qM+hEbgwx+ajfBFgLtp853p4wB007tJQl
	 3CHZKr0bYAzXfI5KjTfQ7tTc14pPdAe7egSTvF+SD79+3bYb9JVaCpcRRTzej3ndvT
	 /2bDWIEglJ6Z9CLJxOwjo2bVDXXd7Veque1nxe8gYdLIBFG8qQbjozQdQ1TIZh9i7/
	 /SB5eTPPQiIflz1M6Lf8HT4+ygwnKBgdpOF8LGVpXTZWXmxBPSAoGG25F5r15+c+Tl
	 okUeVneadKmxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E5A633808200;
	Sat,  6 Dec 2025 00:17:14 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251205-vfs-fixes-23ea52006d69@brauner>
References: <20251205-vfs-fixes-23ea52006d69@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251205-vfs-fixes-23ea52006d69@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.fixes
X-PR-Tracked-Commit-Id: fe93446b5ebdaa89a8f97b15668c077921a65140
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b9d25b4d38035b7b2624afd6852dfe4684f0226
Message-Id: <176498023354.1869773.7626508994190156186.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 00:17:13 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Dec 2025 14:36:15 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b9d25b4d38035b7b2624afd6852dfe4684f0226

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

