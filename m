Return-Path: <linux-fsdevel+bounces-56206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8871BB144E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F273E1AA171F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0E2874F0;
	Mon, 28 Jul 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDhlc5dD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869324A061;
	Mon, 28 Jul 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746041; cv=none; b=tgX/bAmlshe9YaTmxq+adn95J16Qm5bTR/LRoiNh1PbkA42yHTvBI+Rxtt4yA9fQieU+FaWSXpCLw6OoE67gAFxZl9N0ylQfh52Rd+m0K5aWA1TLuYVK0TmN9c6essI4NPkd5M+3gmX1OEj6WlD1QJ28dSxF1HqCHzWYwPSCEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746041; c=relaxed/simple;
	bh=27TfAy5ltf1yz6XGzikXgFj157o46+HAO9BqWTX+X/o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uT14rq7V/6B/ryOxxSq2ikJGDA+4BwieisbiFHIg8JBtQ0zcSIp0bvuUvFWnSEVAz0T+vnRaRCy5ckCDVrI9b3egG7oQarDU1tZysswsv9Lk8bYn6Ju6bIh3ZWcHyVethc7uV7iT1O9+UTGd9RCFKBaZdUWEoznoGrlYPgUE/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDhlc5dD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCC3C4CEF8;
	Mon, 28 Jul 2025 23:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746041;
	bh=27TfAy5ltf1yz6XGzikXgFj157o46+HAO9BqWTX+X/o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hDhlc5dD0jOoEzmN3Qxdq0BunHwKP+45KTXZ5tfYDU4RipNv1BFra8g3vYO+ByctH
	 Abc8rQpm0FOwZEEzCorIDu8bNz88BCQk3+UC4dwUX6ISEy9VTGwNVzB7u+G754WnL/
	 +4pCBxVquiLOH2L/ne/gVlz6obzPQIgi9by50uO5Uv0lLA5ovu82usBvJfilP4q8qI
	 xAPfgkM7uOFTPvJTG5HBIqWnEP/8pEQDZUpTFbYLQ2mT2nWZghzlF16FSAwbtRejGn
	 mkKgn4zkxY91MSJzShr99PnFGScdP+BLieqZCeUMoq4Q+iKp2pQhYe7jgxcha1CE1G
	 Us0P8DoTrCDpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEF28383BF60;
	Mon, 28 Jul 2025 23:40:58 +0000 (UTC)
Subject: Re: [GIT PULL 10/14 for v6.17] vfs rust
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-rust-e01200cf7428@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-rust-e01200cf7428@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-rust-e01200cf7428@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.rust
X-PR-Tracked-Commit-Id: 3ccc82e31d6a66600f14f6622a944f580b04da43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: add07519ea6b6c2ba2b7842225eb87e0f08f2b0f
Message-Id: <175374605788.885311.11371934066868500162.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:57 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:26 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.rust

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/add07519ea6b6c2ba2b7842225eb87e0f08f2b0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

