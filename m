Return-Path: <linux-fsdevel+bounces-70422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F2CC99F49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 04:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D25DB4E2708
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 03:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E74279DB6;
	Tue,  2 Dec 2025 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSvLcrcU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC30274B23;
	Tue,  2 Dec 2025 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764645726; cv=none; b=Mde8aS++fn/vvijj8CcHr1PHLutUikBr0JI1dEYwmJnxYFC3zA4JTkh+MeVgBZFkuhhrmqUX8RuFtztdIl69MklmbuJuax/7Z3IO+Qj/IGcyXwNoso9xlPSED8u4o3V33bGokxBNq2q2LFT9LNN0s+yYNf15t3SZXEgzPYITM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764645726; c=relaxed/simple;
	bh=uucrSsLTe+Ud9YZa4Apmxueb9Fgya2Ie7W8LoEVKGqs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aTI7x3W+zo43rAI/Je6Wle/phkhanG7apjv9CRw00XXPAEAy7xJPyV4t7ClQ0PHYbB+E/TUk4TWntUWep1Mzd16qThfhIB1pT845Mj7K9u5OH6SjGgVCyz6XCb/1XLbBgk60PRHDahsAAF4T4ghQQCgdG4r/IbfTLD0fMCFwBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSvLcrcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3239C4CEF1;
	Tue,  2 Dec 2025 03:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764645726;
	bh=uucrSsLTe+Ud9YZa4Apmxueb9Fgya2Ie7W8LoEVKGqs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iSvLcrcUlxagMaz3NpAva4xWnWcqIWffiORtfoXv6YNuESRujh7x7iJBKvQXzD/fu
	 rn18ihDhrm+B9rDGYrC3pnoMr7YOEsE4PDydyQzaInjyzKFJyPORsy9Wvco5UvKmnc
	 wcYYt2Frrsa2YT7QC7BacLC9gv5sZX5K0imxqXAHP1S7vrUUsV6s5yDcpSRU4glmSC
	 NN3XdPbSD8H2VlXFCUSPB8VoDoXpis595+EsU55kjphmGHw7dPu89XenMj0pTmJ07B
	 6FExO5I8G6i+oq4RGwd2INVESqQe7vNuZBWamD/maUCoaDj+JUfLK8FCylcb66tUfT
	 xMTTWRnGcs8eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2C5E3811971;
	Tue,  2 Dec 2025 03:19:06 +0000 (UTC)
Subject: Re: [GIT PULL 12/17 for v6.19] vfs directory delegations
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-directory-delegations-v619-07cf59ad4cf2@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-directory-delegations-v619-07cf59ad4cf2@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-directory-delegations-v619-07cf59ad4cf2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.directory.delegations
X-PR-Tracked-Commit-Id: 4be9e04ebf75a5c4478c1c6295e2122e5dc98f5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db74a7d02ae244ec0552d18f51054f9ae0d921ad
Message-Id: <176464554562.2656713.17232378868737941890.pr-tracker-bot@kernel.org>
Date: Tue, 02 Dec 2025 03:19:05 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:23 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.directory.delegations

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db74a7d02ae244ec0552d18f51054f9ae0d921ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

