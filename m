Return-Path: <linux-fsdevel+bounces-70188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE3C932DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 22:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02F1634D553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE042D47E6;
	Fri, 28 Nov 2025 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3vHbjgP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270226E6F6;
	Fri, 28 Nov 2025 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764364688; cv=none; b=N4D5pAQzJ9D/JH2JqJdGcNe5DTouSwrLx/WvHoVFXlxXXkFYqyynlU1QPam1S4NQ5W823TdXw3yTTPEOEEucYCabC7vDHyN/Ymc1jriKaesydJOW8NzmvFUKeeaL0Gcx30ce7RrmV70Erdd1Eg/CtOQZTvvFretASoVfFIfaHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764364688; c=relaxed/simple;
	bh=NKKmP17zokh2S7zB+HeKihPrIxeBNPNDfVvPxoiXWac=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qytTb+SmvzjXpkPzH6j9yDXRiDfeCpLDD2aOEBnpBTeMlAVFWX0azfkucyQPBJxRSEy+HupKCZldK/q4dgMqjNdOrAUoeE8C62SBfdIdvG/vSWLco/CDJBi25ctp15sc+FY7i/8KnlDB8A+noulkmbtvRvVC9qzh6OESy9kyvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3vHbjgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8241DC4CEF1;
	Fri, 28 Nov 2025 21:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764364688;
	bh=NKKmP17zokh2S7zB+HeKihPrIxeBNPNDfVvPxoiXWac=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T3vHbjgPMfADvPuqOgz9N82sFnIQSPACDeQM5nNvrE7hJA3IkXNLxxgJbJGnz+9P8
	 5rmmcv+Nvs4HU3mUu1dX8xZxTv4lUVDb4Rk6517zZW0b4dq1j6JIeGmTXr4u+ZP8sE
	 tIuqa1i5CbL+4ByVK0QmuKwMzraECsat3+0UsxY6NDPJg0HbV9Qa0+IE7PV/qPr0V2
	 gDuhMVxhZWD0RdXFUFxx8peVEQTEDMpnVxA1c0g0wEOCFSCZKH9fknSnxT/3P1JyfV
	 2QbpEgmm1i3L7jzXKKTpOjXu/OWtIsH73Xrn6l7Gr1aNCpDElcpViUUdfn6Fxrx/HO
	 Rlu8CsoMLy6dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787AD380692B;
	Fri, 28 Nov 2025 21:15:11 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-fixes-v618-8dea546e893b@brauner>
References: <20251128-vfs-fixes-v618-8dea546e893b@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-fixes-v618-8dea546e893b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc8.fixes
X-PR-Tracked-Commit-Id: d27c71257825dced46104eefe42e4d9964bd032e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3b17337b943949d0f3d12835d10d866210aeee8
Message-Id: <176436450994.799297.16918691864496783298.pr-tracker-bot@kernel.org>
Date: Fri, 28 Nov 2025 21:15:09 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:46:06 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc8.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3b17337b943949d0f3d12835d10d866210aeee8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

