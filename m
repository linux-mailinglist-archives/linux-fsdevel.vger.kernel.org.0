Return-Path: <linux-fsdevel+bounces-23876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB6B934339
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377DF1C2132E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629C224E8;
	Wed, 17 Jul 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7vZ68ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFC1CAA6
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248371; cv=none; b=eIZswylSuUeB5qfI+uivALlxLnY9zhE9lwVXyq7vHo/wxyOWLFUpw9Dn4hmuZWNgP4ERqN5URFRlFodBGEi5DL3+Vs0nW6PkKua/bYxZhMpJ5epEJqEjGD9z+Cd9TULneFYUXWvGvm7bWCHlxTjoqQji97u3O54IA67uWHdR2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248371; c=relaxed/simple;
	bh=4TmFsJpdicUy3zpKyysf7bDcUW+aNYRNAVuwhUsSeRc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hrTwRxbOyU+O949ZBJGZ5KxAD7jOnZHGgMPqlF6bP4e0af3kvPxxphc518VaCtpvADZtWMS8Y/fCpHAZN/8AqI6GlFKOVigWfG0zvni6+gv+Yntc9JOzm+TALZgGHP+WLqnkicLMBAVXhJ9AEDl6ZcK1Y0qZawXCl6z0r8QEGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7vZ68ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E757AC2BD10;
	Wed, 17 Jul 2024 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721248370;
	bh=4TmFsJpdicUy3zpKyysf7bDcUW+aNYRNAVuwhUsSeRc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M7vZ68ugQkU2mkj5XcTirxr4Dv3VWsQomb2BibhxjnJ5yPUQ9+GQY5IAW6EjSLhgG
	 mqU4KADMubigNpA6YurDEjijoyM6XbvxQSLZUQtwFm67ZZn53r5SNqzQmPZxXCl85N
	 MydMLuIQHWe5HmB8wcjSNMxkjoAN2IDXQh4EXxsizrIyBs93wJjnMMlOtNDborYm2/
	 VxJ/wMK/P6VgzsDDGy8Iu5pHc6qyv3U9uH1BSJSBCU6MsJwJ9eChi/OhQvELqR8zsp
	 dLD9xEHDZk4zV7aoJmoJewjbzT/UE4ek7tjeSDM8Yv6l5dyJJalOFcmTN9yHg/DDoF
	 arJdlcvl879kQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7970C4332D;
	Wed, 17 Jul 2024 20:32:50 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs changes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715225306.43445-1-dlemoal@kernel.org>
References: <20240715225306.43445-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715225306.43445-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.11-rc1
X-PR-Tracked-Commit-Id: df2f9708ff1f23afdf6804bb16199e1903550582
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01f851a0e87ed64db7081a472061650e96dfb798
Message-Id: <172124837087.22374.7979907338434427085.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:32:50 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 07:53:06 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01f851a0e87ed64db7081a472061650e96dfb798

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

