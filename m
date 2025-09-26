Return-Path: <linux-fsdevel+bounces-62918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04029BA51DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 22:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEEE740A44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 20:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66328689A;
	Fri, 26 Sep 2025 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhoGQF+Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF7285C9E;
	Fri, 26 Sep 2025 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919460; cv=none; b=bUaT7+RDWEpPIpuFL63dhvJ6wJVZGRZia9IgbAnnCT0hlOtcSsAeyHGdYNF+bSe1nJpJvNQArf5vcCaJ5D0DJcXRapS+fV8zy6bFy8RTTD1oJlk/P7S+nh0ftmEQ+y4D9QjPhEnwhddjQB6BfHBY6Uw0AU2bC9KJYD+WSrd9oSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919460; c=relaxed/simple;
	bh=8O2ujRjW782eMuwcsQpiSu7Taew/5u4fm+vOdwK0tok=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JEKTIMEY13CN2VRh/Uy7eG5CQzDZoDQL7lDoBPw8ZKWkwsMDyFVO8UX9Sfd8QcZyyijLV+6SmwJVYcLcg/8fBhpeCIcKa03ZuOyfFBhwEueOYuVggUY/U+p+ykhAerf4FuH0x0dsFf7LAj+xcgi4IWAk2dcOqJypPtyDxYMqMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhoGQF+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AC0C4CEF4;
	Fri, 26 Sep 2025 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919460;
	bh=8O2ujRjW782eMuwcsQpiSu7Taew/5u4fm+vOdwK0tok=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JhoGQF+Yp1hvyDHy+QxdUvsJOl76ZXIpsQ550C8H5mCU9eCw48TPiRNMUhFuMHEPU
	 f2whi5s/KgNWPSpAOU2lX703iHH93eRl9GeaySpW/JS136/Lo07ZuJjv6iEWTEQ3sd
	 YMczzAGcsLqARtIfxju1Vcf0KZ7zNN+n/9fs687RtGTZFj+liow+oYnD1KCVMvNvV4
	 l6z1OT7wEca88pA9emjiDaZJpyVJ0EUsDaz4+14NQld4vB2VCfm2Ahf4A9dhfB7CO8
	 wtsqpLFrjocB8lEipshWzel5wt0P5iurzm1uJ2ltll98T71pHKSd4U8BFJoPxzO2WJ
	 aLTPsIpnybfCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3FC39D0C3F;
	Fri, 26 Sep 2025 20:44:16 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-fixes-16a994dd1ae5@brauner>
References: <20250926-vfs-fixes-16a994dd1ae5@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-fixes-16a994dd1ae5@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc8.fixes
X-PR-Tracked-Commit-Id: 4d428dca252c858bfac691c31fa95d26cd008706
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8743676b12addb982f5d501e9f8def042ef9bdb
Message-Id: <175891945537.51956.13286351644737898547.pr-tracker-bot@kernel.org>
Date: Fri, 26 Sep 2025 20:44:15 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 12:39:22 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc8.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8743676b12addb982f5d501e9f8def042ef9bdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

