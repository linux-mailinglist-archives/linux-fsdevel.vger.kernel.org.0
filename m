Return-Path: <linux-fsdevel+bounces-70921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD4CA9D70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 02:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8933015ED2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 01:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC308314A6C;
	Sat,  6 Dec 2025 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkJc2PkH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C383148D5;
	Sat,  6 Dec 2025 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980414; cv=none; b=aRsrLHmwVZwZJTxO/3ZDFjvIe/OLCJXrhL11M1nKLyZFXE9DOQY8t4LCqYHhJoJQLV/mN64oV9lo9gMxTdiBPLW3bMiqyHAFdsKVG1WqvHI/NtsW+pZ9yrWe0f+ek/cIcRay52R/ARqHDPAsVBbdnCvESix1ghT3Z3489x5c/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980414; c=relaxed/simple;
	bh=kRz0Sc2nVdSuPQsG/c6cIaiwWgo+URykKDE/VqhZmvY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l6LiTck24daBvsYnuBk4LahwYVrdTq1F7oXCsnsvdB3TAWZ7U70gXqcQMU2AXzlnJA+kZ+7ujKqald1ZpDaZe3t1SRv4qAztl3F+n+m8DC0fkyRbggkQlMLLSyYQy0Iyl6lPm9o71bKRJAOBYkD0oMIe27m4VswQFTGf0iPhhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkJc2PkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361B8C116B1;
	Sat,  6 Dec 2025 00:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764980414;
	bh=kRz0Sc2nVdSuPQsG/c6cIaiwWgo+URykKDE/VqhZmvY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IkJc2PkHO5TVUzGsQZ//ca39KfIxjSI+/+Imk2sCp3Ho5pmxCqnpp1n0wYnipcajD
	 6tUsIZbmowwXBftQQT1BGSAp2C4VcPcyipnNpPbI3r05w7HJG6bE6CtgSdfGwS1vV4
	 5mrmPYU3Tw1FOR6xd1GTKX5B3pQycLdlirFFYIjoQhbPxUIyF8DSJOznXeLuHI3gR1
	 cc2qfX0djOgCr84lzEAQMGoPzFGQzEgU22bHDmJdAFTIx+ZbM9p1s6AUEOG4mbLSFL
	 fHHTE53ZJcFb6Fim2vi9gpAKDsA6gQreD6AnH4V8iDtsslCKH06a3XxkGHFC0+aib3
	 5/Xbn8oavbWmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D3DA03808200;
	Sat,  6 Dec 2025 00:17:12 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.19
X-PR-Tracked-Commit-Id: 8da059f2a497a2427150faae5adc3bb78e73b3e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b6b4321280ea1ea1e101fd39d8664195d18ecb0
Message-Id: <176498023146.1869773.11428184172341796390.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 00:17:11 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 4 Dec 2025 09:25:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b6b4321280ea1ea1e101fd39d8664195d18ecb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

