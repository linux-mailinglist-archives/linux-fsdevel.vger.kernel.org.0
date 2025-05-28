Return-Path: <linux-fsdevel+bounces-49995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF331AC71B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 21:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81FA9E5849
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F052213254;
	Wed, 28 May 2025 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB3EfWyd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6DA21FF44
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461523; cv=none; b=F7+Fy6qk0tuwxYozUGza5vFvBF2UsP+PEOH+NzdLbb3j5De8+sEbz74XCiNqEGXM3pIO/yivJkXse7mK7Xv6AzI3h10Od3diDm4eyaRC3nJJT01KgwRAaG2XZY1Y/3wxEYR3wrAlLJyfjn8VHaaPCXdCnOS9nx+WkhfdBytR/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461523; c=relaxed/simple;
	bh=WyFLZShqe9WwmPYaHtjorTI6svizO5lNXZ4Ptn2dcRA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sVoPl7VFPfYYo0ZfoOfe4BdjZqLirFGV2hT1XI/LR4nLFmSaznHPBt0Tc/mBonUUbU+BHaANkF4Ohf5yQNj6KIpe2YzPDVZ0E568uRicT0Vq/bz3lOU2v+Wl3EzY+10apOFbNnm3Gk/vFJ/05rzC7f4Cw3/hA11x/Ore20/bFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB3EfWyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07303C4CEE3;
	Wed, 28 May 2025 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748461523;
	bh=WyFLZShqe9WwmPYaHtjorTI6svizO5lNXZ4Ptn2dcRA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CB3EfWydJ47FMNdCvFaPpBWjUnV7ToSO/jaCIklRN3quMraIAESxCTu35Th66wjO1
	 i+2pQCukv37XZccuqD+EaU+72+Ru81VUyEn9F97Bs2xZgkFKn/OOPHFpaCOzoPWgaa
	 oX3NPX7OLQQi+naL0hjChuzrgKrfOkrQWzIHEWmkB1CQi6y2fJzWlbIf/Kz969V7mH
	 GzWe7sKaTjVjIiUozf4F/LMGcuU+bLTC89hxpqjTUaqMH5825bFdDtR+MqbD432FgH
	 DJM9j/7iR0kL5FAqJ26frPj+9ar5hFDsF7DCx/MBAd2reP2vaK56N4WI1AG/Ag0pX8
	 CoG3i3ZrnkV/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E153822D1A;
	Wed, 28 May 2025 19:45:58 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs pull request for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSSpgg2sKS18K3qZym+sKDY+xvwHP0S-V6T6GNgUUWJBbQ@mail.gmail.com>
References: <CAOg9mSSpgg2sKS18K3qZym+sKDY+xvwHP0S-V6T6GNgUUWJBbQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSSpgg2sKS18K3qZym+sKDY+xvwHP0S-V6T6GNgUUWJBbQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.16-ofs1
X-PR-Tracked-Commit-Id: 4dc784e92d4fcf22ae785ee5a7918458f11b06c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b04f9f88936c7b1113b4a74e4b3e6b46858a4c9a
Message-Id: <174846155682.2536722.6333420060754717382.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 19:45:56 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 11:15:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.16-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b04f9f88936c7b1113b4a74e4b3e6b46858a4c9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

