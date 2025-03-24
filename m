Return-Path: <linux-fsdevel+bounces-44908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307E6A6E4F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7153AF081
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5651E9907;
	Mon, 24 Mar 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btQ2hkD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881481F3FC1;
	Mon, 24 Mar 2025 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850034; cv=none; b=BmVOv669WX7of8KQENmLx2S7/HiC+BxQWqlCdq7PcNzpNFZRjseC9Frm6tJueHz5VfSdcaSLQ+MXjvBpEGEPoIy7yIU85EvcgCqnhTCRimTDigM1Dhl27NviYrAGDnkXEB7miDKnPInva+r7KEJlLFJS0JDc+s+CYTDlP5dFNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850034; c=relaxed/simple;
	bh=dqBzRH66S0a9nUfPgkEKXhRaUQ8XB8g3J9rpPP/K9OE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iAzIgexCKtLjoARCAniwtxre42YjejWOBfrYARRPdsLU0+ArUuU4wahGHKAzRS9fu1odeptj3YpxLMf6z6mg/FvyRsKE9ay0PZ9YcRK8i6fWEfBQhRj4Mixe6w5f2weNptAvW9a0tbLcEqSCFixC9tXaywcnu0x1orw1jYU/yvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btQ2hkD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFF6C4CEE4;
	Mon, 24 Mar 2025 21:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850034;
	bh=dqBzRH66S0a9nUfPgkEKXhRaUQ8XB8g3J9rpPP/K9OE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=btQ2hkD08sEsLdV3rBtPC3iebpuYBisdrjadLk+GASzQ+A3OkNdW2/6Sf1jIyTXBz
	 pr8zwK6LbzF95yzLOHzeZpXXvtMegPJn+/XAstxJfZHTUi3orxgEeMvqPgG4gSFB1A
	 UgOnKQaejv1RWovbGvJc5DToyo7nu4y/hH9hteeDut1tgf2qM0TqHv9X7C/0gFa2w5
	 YdWJ5jXAKzYF6IQJBrSb4zL8San6JfcsckVtWzLyjWTAFG1z9xgRQw0tOrbcKNzlW6
	 eR2X9o7nh82sWcASelQMO8o63OLguQ1qS7QoGblTYhfa1dOJCeapxIBJlKXkafXyer
	 eX/VHRGotBrHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBF33380664F;
	Mon, 24 Mar 2025 21:01:11 +0000 (UTC)
Subject: Re: [GIT PULL] vfs nsfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-nsfs-76eda2ef1600@brauner>
References: <20250322-vfs-nsfs-76eda2ef1600@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-nsfs-76eda2ef1600@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.nsfs
X-PR-Tracked-Commit-Id: 58c6cbd97cd51738cb231940c00519dd2b7ace2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74adf9e3538423256fe197bd235daa2b73c3af2c
Message-Id: <174285007085.4171303.15303641136566914153.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:10 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:15:32 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.nsfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74adf9e3538423256fe197bd235daa2b73c3af2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

