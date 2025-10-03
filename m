Return-Path: <linux-fsdevel+bounces-63392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2DFBB7E70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8222D4A6483
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D62DF128;
	Fri,  3 Oct 2025 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrdA825R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9712DC77F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516915; cv=none; b=E5spMzoUvNMWu+hozzSyFPHrh5qfhrVgvX6d8deYwOJdMEt6/58fee/4rvwXO8u2iKoZY83iAigetuj126POy28EOL2fdl3INFl7GERqjlYllo7WCoFa+JHu2EzqD1UYhak1mdtppZ3yZcvizTxPXmiTwUhtHkqa0zikWCVpN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516915; c=relaxed/simple;
	bh=WszJK/GspzdF6p4BVtm2Lr5OmxzOcBWmY3aTvpT360Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FQvYkz6jRWn5+DVPrptuTG7uwkwfqJuQuzw2tSIk63fYbMLmwi0NqhINdtsBu5QjqmRfNYx3v72VytdYo7cBceC32dXsns+6EvwVX2YdzQAcA4ZZeP4ZyQtVpAzNiALVxPnlPEv7Hv/dz5UthV6vopwfTg9sL251GU2pPoV1Q+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrdA825R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B873C4CEF5;
	Fri,  3 Oct 2025 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759516915;
	bh=WszJK/GspzdF6p4BVtm2Lr5OmxzOcBWmY3aTvpT360Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CrdA825RWKUV50mwMVEPKo0u2nlfTxvcReeF2YOesEWNqLuv6sx+t8JJM5ykLHFjY
	 mzC+Z2o4OnXa+JGQfQBAFCYr0zSJfCDKi1xHl30P95kVBSUT4jcNP2tEoLMepvsReK
	 fOYv7CmYPVN8ujPm4O+OuuM/FginkRcdSKMslHnS+xfanEybx82bbLdO/kfJDkpe04
	 en9T4wvZWL4nvBomf2FG3M+Iejou34dTX2PV/dYxq/6z6erT6WukdQ5ooGZd2maU9s
	 ZGKoR2wCBVsiw6/3NBfxZ8ZcqFr6ybRWTvO2D/hqjKxSRIft/7Vg/zOSsHpFrDKY5h
	 sB9Z7pqSr4TAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB839D0C1A;
	Fri,  3 Oct 2025 18:41:47 +0000 (UTC)
Subject: Re: [git pull] pile 3: nfsctl
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251002060050.GI39973@ZenIV>
References: <20251002060050.GI39973@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251002060050.GI39973@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nfsctl
X-PR-Tracked-Commit-Id: 92003056e5d45f0f32a87f9f96d15902f2f21fbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 867e4513fe4ba7e7a7ff6a59a1fbbc7d54f443c7
Message-Id: <175951690652.32703.4446950242666508570.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 18:41:46 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Oct 2025 07:00:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nfsctl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/867e4513fe4ba7e7a7ff6a59a1fbbc7d54f443c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

