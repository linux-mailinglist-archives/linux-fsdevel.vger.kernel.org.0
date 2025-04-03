Return-Path: <linux-fsdevel+bounces-45582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5BAA79943
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400E87A5117
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 00:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99155228;
	Thu,  3 Apr 2025 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIK9xDd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6741854;
	Thu,  3 Apr 2025 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743639061; cv=none; b=N8UYN3UVYbXrHNKnQbFx2m5kymo2cbItk5nnPiokVglv0ZhvjWJU3qAwH/NF7v8xvj3rg2c7WJZjhxNl2L0zM4mBMUFA8WRui/47OLoqRLl7p2z55A0SkD05SuTt+LmIWlLTQfcDFuxjKn21G+1wptZp5mWDvrRAhZg4/NhotUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743639061; c=relaxed/simple;
	bh=mp5TJF+PV1YLBlSX2zwO0xNrzgpSG5e6+GHpjzMkbdc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B8O4sPnSln+Znk3sAF+FUZSsezPFUjv5fj5S4JcRW8vf7X5dUtFnaYwepWF9hA0qOrX0gvtJgf9XPmWqAV6GmCo0O651fcPEBMmmwqPbSn4ZF4uccMrTK0XLdg4sRpFy4ZnmhyZNMfKDq/n9FyfHT6/E+elUVUXJKCALS4cdVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIK9xDd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96637C4CEDD;
	Thu,  3 Apr 2025 00:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743639060;
	bh=mp5TJF+PV1YLBlSX2zwO0xNrzgpSG5e6+GHpjzMkbdc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RIK9xDd5KOYeL+wlXVrzZZXv0sSopctikMf6EMuN5ZKeGO/UOyGSRcLMuxlyMb7Wa
	 /vfP4Sm36win/SBnn+lZJluUWSerUDdzhKweN6BBoGhLeKFYOtwJkaSs8iFuJCqp8R
	 J0GkxHyUMJYkNEf07vt3+bTQelLA/7pCIufCdmf6myN89LP7PdGrJGNPOuYnKPuDZz
	 C1laJCAX9ztWo6UPvdTfqfZfSCFFWTvS/NkWk1mJIn0byQUEC/4XNSb9xhhqE1Wq5f
	 9QxWXy/TFBvuSUdn18zKGt4ZTW2AvVrQ6tgA068ststzqw0TWiWJf9SiBUphtMnAjy
	 H6CpOVBsEpoQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04B380CEE3;
	Thu,  3 Apr 2025 00:11:38 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250401100822.40050-1-almaz.alexandrovich@paragon-software.com>
References: <20250401100822.40050-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250401100822.40050-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.15
X-PR-Tracked-Commit-Id: 8b12017c1b9582db8c5833cf08d610e8f810f4b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cc5543fad527878b311dcc361ec505f613da4e2
Message-Id: <174363909720.1725867.17593371004813058844.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 00:11:37 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 1 Apr 2025 13:08:22 +0300:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cc5543fad527878b311dcc361ec505f613da4e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

