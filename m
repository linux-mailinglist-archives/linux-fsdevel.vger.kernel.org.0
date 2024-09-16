Return-Path: <linux-fsdevel+bounces-29458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D48197A036
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7E8B22129
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 11:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB503156F5F;
	Mon, 16 Sep 2024 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+xh/48q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F5156F39;
	Mon, 16 Sep 2024 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485956; cv=none; b=pI/STruwXMCUbIUFHNDRWpiEzzNGPHEAr17h3PnLp8GXUZMZwOwxrv9PXdAqvoMJdHj5NrZ3e1CyUIobYJsad6nccpxjihzv90zAR/zE8Jz/qyC9/7+yY+TeHg5tRGldrFImW3yNtquavJbS1OgWTTOxO4a72H4NSy5E0HtDLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485956; c=relaxed/simple;
	bh=+nFXJrILy7lIndkuTe7V43Lo3HO3IF7emPegZffq8i0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pk5tk2qfJ9bfsGOwZc1RqsGXADdnFxyswaLKN3bgQ6mh5ORRbslAxPens74Hbcuk36Pq/0ZBWl7HKt1PQiUKa9/2tFicyvHyboqq5sQXXT1euyyJgX2SW2mUKR+CI3lWIH0va2FPxnDqof9qcw4En/QD5rGVXhj7cwc6lUG6JAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+xh/48q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECF7C4CEC4;
	Mon, 16 Sep 2024 11:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726485956;
	bh=+nFXJrILy7lIndkuTe7V43Lo3HO3IF7emPegZffq8i0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B+xh/48q/L1cXwS4djzgKWekfQxgOSlWDz7jzfYaWovxA0xcKBtvArmG1JA0cVJK0
	 wXjD28UJZHBeyaufsxqTdPmLwCDE/A/YZ3hpqH0DMgW0+lSET0B2yQagiqCRt2m5KL
	 6QU8U9AvGPemk4sjctU4NJDuxYqUYfBtz0NgOP6a44FTdtCqcFm7HjobF8OKviWirU
	 UQty2pHew+lTQox1Dy28EGqPZsNtzhrVaMplU/+rK7fWqKZqtKTaNDNMRun6Bm0J90
	 TAv/0Zm4Dw3UgatbXamABQ77DxY5TplECSpFdNb4YHeBWYEEqCMY5f1N26es6nbNsL
	 jsxgak6cz00lA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA73809A80;
	Mon, 16 Sep 2024 11:25:59 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1726154348.git.dsterba@suse.com>
References: <cover.1726154348.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1726154348.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-6.12-tag
X-PR-Tracked-Commit-Id: bf751ad062b58d0750a5b9fb77d1400532a0ea44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: effdcd5275ed645f6e0f8e8ce690b97795722197
Message-Id: <172648595802.3656894.14747259121037257589.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 11:25:58 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 17:22:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-for-6.12-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/effdcd5275ed645f6e0f8e8ce690b97795722197

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

