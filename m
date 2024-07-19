Return-Path: <linux-fsdevel+bounces-23983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB719371C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 03:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CD028281C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 01:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CC6A94A;
	Fri, 19 Jul 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pderaj92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7C443D;
	Fri, 19 Jul 2024 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721351068; cv=none; b=MeID1BjsDHleLk/PJkiQEKxOfgUHV6J0t39lBd5Yz1xIP7V8k56vsyARPNTr3ep9kQVtn08qNa5GnzbN58/hCQWusMo2nSKbyAdRiGhCWE9qmkqnVysRuF18/Ld1KC4TPaCwXHa8f3//D1rpoB67+eKGyyB0wjOBCufQjPSIQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721351068; c=relaxed/simple;
	bh=jKuv+diL1NTbs2q6WCNwJF3q9JcXs3IYgljE25YwOd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YPQCsoZHfOZM3Peg3wptQjAAQABPXVeIQ5oXGHDiQMu4zsTe2rz+JAoSCfb00nZ2hApiqXYZalFqAIza3aHpPYDzqNCLuCvHcnB0X2thavM5VIBkg2v3psjXTYaK3OBCqOdlLJHfwt6SEc1CExEUnas7D516x9Tm1u/OUPAwrd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pderaj92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B8D1C4AF0A;
	Fri, 19 Jul 2024 01:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721351068;
	bh=jKuv+diL1NTbs2q6WCNwJF3q9JcXs3IYgljE25YwOd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Pderaj92abMi/1gqQGg06lp8sCY4yy17prEgAcfKgPU+YLOAoOImMqdcPDHKc5p2d
	 i2AkwgHNa3GZT4yfXmW1vC3I3B5WgzfC5yOZix2LJE9M7Rbkz2yAL50Qt2A0aak/kM
	 YC5k0ouA/vqDYiKs2MKQY7XEEMRvVxPuDiHbu6Ugn7ey8kUmDVjZDRMUK5mJomco0V
	 id4AcH53FK1uZLlhT4QLjmRTY7aqs6wwQgmSpWPRXg8zyKwhNHBBTpt7HITm004FNS
	 d7nFGXIW/ikwyboySYJS//rzxzdzuHWKFv16j4QOHQxBVIyaQ47A4PMT8JX6BxlQld
	 tXjJ5//UAjz5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEAEAC433E9;
	Fri, 19 Jul 2024 01:04:27 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240718-vfs-fixes-ea80df04af07@brauner>
References: <20240718-vfs-fixes-ea80df04af07@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240718-vfs-fixes-ea80df04af07@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc1.fixes
X-PR-Tracked-Commit-Id: 280e36f0d5b997173d014c07484c03a7f7750668
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dddebdece62ead1ac1112e6df375f56a1cb45f84
Message-Id: <172135106797.16878.8225116304914890358.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 01:04:27 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jul 2024 11:01:55 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc1.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dddebdece62ead1ac1112e6df375f56a1cb45f84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

