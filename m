Return-Path: <linux-fsdevel+bounces-56198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CEDB144D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82262542D45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE927A130;
	Mon, 28 Jul 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMtnQkGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A319279DAE;
	Mon, 28 Jul 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746031; cv=none; b=EudYM9nkzQjtuEBI3WG2o9/+k0FbSwygPCvcV4qLcsr4D2rPGhPaTmYTH7d+HEwXmUaG0f5W5Qp8vZ3Zw2GEZoClyA00Iff1+EPbqkivbFAGGl61RKJOhsxTExwnUXfgLxqt0xI9dfEn8qrdWvbuZtmOxtmCaxtIjCkZfvrrzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746031; c=relaxed/simple;
	bh=ukCssmb9gZH/49TRT+O402YsRbESWfq4mHkWt1sHdLs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C4sTm67+V7+w3O26FLvYZP2hkWbwWtffoycpSTKrfhJd4RwnJAIVTjjdkC3JAUvZdSLjmQ2gui6xaumLvSkSg+I0YkLqLbkQwLVaai3f97wweJPNQb4cFWrRMYIhRIuskN52shB4HPdaMClmm1mTj1AUykYb300EXDIwNEYe8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMtnQkGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33FCC4CEF8;
	Mon, 28 Jul 2025 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746030;
	bh=ukCssmb9gZH/49TRT+O402YsRbESWfq4mHkWt1sHdLs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BMtnQkGf1L9jKyODDaCXKQbn92LCkv9KYJRhh4YH1Rp1aEKziIh769Xqco5ZDcuup
	 TTHIf14ROmCLGYLRjd8aDwxUxS71Y20jMWEPbXISnumrXMdVXp/YqL56t4XXRYhkQ7
	 qj0RT4pYDc9/Oj3KddGUloDo6kJlplAGArgtFA/jPaw4II+rOEdU4RpUTtF1gZ3LrT
	 AaWgRVXEd+8+Ad+pjfoyqR8YUm0PB3zE/OLGAse66LufOEWoFxQH9IP2Q2Lr4C6Q35
	 6KbbnmXwO+vEWr7GznOnYDsddMesQgqWoWffMbIxvTa4HfJN9s5nn8y7lnwfaXnvdM
	 SUOE5XWtXjdgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B260E383BF60;
	Mon, 28 Jul 2025 23:40:48 +0000 (UTC)
Subject: Re: [GIT PULL 12/14 for v6.17] vfs fileattr
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-fileattr-fcfc534aac44@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-fileattr-fcfc534aac44@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-fileattr-fcfc534aac44@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.fileattr
X-PR-Tracked-Commit-Id: e85931d1cd699307e6a3f1060cbe4c42748f3fff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57fcb7d930d8f00f383e995aeebdcd2b416a187a
Message-Id: <175374604763.885311.9524411507996659916.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:47 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:18 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.fileattr

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57fcb7d930d8f00f383e995aeebdcd2b416a187a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

