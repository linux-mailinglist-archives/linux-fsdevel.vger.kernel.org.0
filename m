Return-Path: <linux-fsdevel+bounces-56037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1A9B1210B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 17:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049294E72C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 15:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EAF2EF2BA;
	Fri, 25 Jul 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAvlVLi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1B2EF2A0;
	Fri, 25 Jul 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457928; cv=none; b=s2mqfuTwF9mm+qoRT48MSXtFYEU7aXQavveDDMWZ/fMbkr7NJTbJC5ARBj9ZeGWj+uMzMVGPCRYeDskIqurMxRtPPaVTbX7DMEK2KCD3yyk+SRamL4fZf/3ewE/2Wq0npd50h6EapT5g/M2VJgBaiPAfrHBs8WljQhDn0Hy4pP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457928; c=relaxed/simple;
	bh=RZkF1xI+0aRgRC8W8dW3hG49eqXMl9Wyk0RwZqJ1msE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XofoM2/UFDW5loMYI7c0PQMUOtGfTypGolR9nxEcoZJR25oiqS9eaxLB3QAZXanmkU4CRWU1n6SPedPC+eeM2lmGTtPL1fLjemfBc65LD2JpXvGHSqbg15oR7XvbIRKyo3dimxHbBRnQVA7pRnC0jnH2fcJ58gMuRUqa9mAs7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAvlVLi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E34CC4AF0B;
	Fri, 25 Jul 2025 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753457927;
	bh=RZkF1xI+0aRgRC8W8dW3hG49eqXMl9Wyk0RwZqJ1msE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AAvlVLi0fU3XW2PX0ZtP9NzCrlhk5TiaF6RdhHGCQxxs6JJ9t69yB2o+nYJjB7ANq
	 NICO47e8YaSDbGbqoFqz2SuhPNYVwJOehxp53JPHN8JX06rYkLh92kiLoIrvybnisc
	 73MbEqNpjFITZDOlKrrMfcdL0YVkp9AsHAH95qbYvmfe2q6KVJnDTWbeTFjH2hBGqC
	 LhS6Px0i2TMYcYFsekivLPjnpXLvUNH6JHFhkvCfNT1cFqTGymDrX2qqDCwra+ZWlB
	 yRz1tXf/D+SJ76yDxgh9VLnB04qv3qi6dQoYZqb6eQLlj/p1eenV75RuupOusuZgDT
	 Oo9hDKk2GKOww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D73383BF5B;
	Fri, 25 Jul 2025 15:39:06 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-fixes-067e349ed4dc@brauner>
References: <20250725-vfs-fixes-067e349ed4dc@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-fixes-067e349ed4dc@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc8.fixes
X-PR-Tracked-Commit-Id: 8b3c655fa2406b9853138142746a39b7615c54a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bb01220911d2dd6846573850937e89691f92e20
Message-Id: <175345794508.3175853.2567235272740772047.pr-tracker-bot@kernel.org>
Date: Fri, 25 Jul 2025 15:39:05 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 10:54:00 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc8.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bb01220911d2dd6846573850937e89691f92e20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

