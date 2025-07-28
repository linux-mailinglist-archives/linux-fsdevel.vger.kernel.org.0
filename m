Return-Path: <linux-fsdevel+bounces-56204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B88B144E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBF816CD62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660F928641D;
	Mon, 28 Jul 2025 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeLu6GeE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0070285CAA;
	Mon, 28 Jul 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746038; cv=none; b=r0y15vo2JtzeGjIn1BZ3lbymLKQvlVuxWAnLdz5lRI1tE7+XWs0CIY8Jas6XVyToSRwnMbzQl3i0015op/xRUsaQbrmD4rnAp9RQPf+qmkGjxzekwuSROrbePmKsLbu/bsdMRXsalWNiOAxxtEuPt319bjFWWenSsS9Po45CTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746038; c=relaxed/simple;
	bh=XbaLvsTy4l5GWCTDvDp+/NwvuA6a6qECueWOGtJgfyE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fEb1tebNfJs5lSH+kzvuJYDZbBcpswSP0/eKzAkmkdZIITuAMISQ7hr6YCMeArTAgCIxM3m6pxbxBmSCZP4EUS9BBMnT1okX/kuZA6CnWlePM26Wi/lxpRqTOhXe3VAGu00KJOKkQkgHdJAr6uOvEoOmkdb0ocA7FvD2vvrUcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeLu6GeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4558C4CEF6;
	Mon, 28 Jul 2025 23:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746038;
	bh=XbaLvsTy4l5GWCTDvDp+/NwvuA6a6qECueWOGtJgfyE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HeLu6GeEF+1y3+ewuvEYORuVX7CR7riwHXysBEyyVSwjj0cG1yBlOPcC4vw2FlPjT
	 Mf5iJuPdH4/WRM2V2JUq4qGPjYPeVIktn2e9uBzgvkacg9sSo+42XF5B5/i3NyVkJL
	 dOZgXAxEb96uWLBtxISuTX7m17dIWCWYybFss2Bo3n0HT3iz+Sr45DNDZpH7HzXQ7R
	 AUWtsu/0sjf0l12Q99hxu7JYqhItlD5K5Q8hJTwTz2xHiGDwiGGLOVNSBu8q6D3Aak
	 nH53Qmxhp6T6e4k5WbZgGAF7G16n07MV51P/CBu0GVk+LoAInMaEL3/HF7RzxCLbO1
	 IZE+rh2nZxpqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C21383BF60;
	Mon, 28 Jul 2025 23:40:56 +0000 (UTC)
Subject: Re: [GIT PULL 03/14 for v6.17] overlayfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-overlayfs-45f27bf923ce@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-overlayfs-45f27bf923ce@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-overlayfs-45f27bf923ce@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.ovl
X-PR-Tracked-Commit-Id: 672820a070ea5e6ae114f6109726a4e18313a527
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 934600daa7bcce8ad6d5efe05cce4811c8d2f464
Message-Id: <175374605534.885311.8264791351669721402.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:55 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:24 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.ovl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/934600daa7bcce8ad6d5efe05cce4811c8d2f464

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

