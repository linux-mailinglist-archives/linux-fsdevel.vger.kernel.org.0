Return-Path: <linux-fsdevel+bounces-23593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2531992EF9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 21:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B69B20F0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721CD16F0EB;
	Thu, 11 Jul 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWjem0uW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64016EC16;
	Thu, 11 Jul 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725874; cv=none; b=bNdMxJXIGXMBG+ZOsetJ+3z7oP0cqxgfpUSd0D+5iJNwziI2fEP1CgnrRgLnKt2VChG+UzUj0SmszAiVR9wx6ejKyh0j3tZEyMhhKq+evYECDCRhAoIfPjU52nMQ2ptyk70rd8IT5kryxayAw+k1cLE0BYsQG6iP6ntUElPjSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725874; c=relaxed/simple;
	bh=bzgOAFY9rwobGziTJJNn3OKOrEvs6CMz4J1t7fZTe14=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Atr78XmubGUNahSBRPkQ7WmMPXKenjQbwrJCYWsktOXkcVyfgJNdYAR/jU3Va6ldNH6fSWFcml3LHw0m+XUY+w+nCKTR8wtvgsNuPmmp32FZwuEPAf+We4KIAidD+kRtG5W76j/DQBLmKivNpmmWnVtq6P473HI8cpW8bLm6yXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWjem0uW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0D4FC4AF07;
	Thu, 11 Jul 2024 19:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720725874;
	bh=bzgOAFY9rwobGziTJJNn3OKOrEvs6CMz4J1t7fZTe14=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DWjem0uWB2ihuB+UQPiVWkbpmEgwL7pTKs0B78o6vWMRaXvIR6vQLHj3cdrd781+0
	 i7wkIweBUYmKdqY7pF+5l0E1qRNuAuCLuP0UuEkSZKiovhhpw0LEJqTo8V6T8oZTWx
	 tYr33X23AJ9aqXC4jyvgsVQcX8mBH5hdTnQ14cIbgCVpmfrWsV1a8IWhEQV8ALs68q
	 000wBer+mtPSkPy0FYtWagLpghC0NUsMra6ala8WkdOjlXV5hbtVyd2969wjWVUWWQ
	 GQaD+HoCo0GUHyBX5eNtytJyUgvoJhNGXADM66Ypau9WX7MAK+o4wZgYhzUwIjeQV0
	 SEziirz7tBosA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1052C433E9;
	Thu, 11 Jul 2024 19:24:34 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240711-vfs-fixes-b2bdd616763d@brauner>
References: <20240711-vfs-fixes-b2bdd616763d@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240711-vfs-fixes-b2bdd616763d@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc8.fixes
X-PR-Tracked-Commit-Id: 3d1bec293378700dddc087d4d862306702276c23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83ab4b461eb7bdf90984eb56d4954dbe11e926d4
Message-Id: <172072587465.27993.7351808094340929181.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jul 2024 19:24:34 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jul 2024 07:09:27 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc8.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83ab4b461eb7bdf90984eb56d4954dbe11e926d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

