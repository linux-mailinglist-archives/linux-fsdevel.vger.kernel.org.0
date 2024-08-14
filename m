Return-Path: <linux-fsdevel+bounces-25935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8862951FF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736EC1F262E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58501BA86C;
	Wed, 14 Aug 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqnpZ25d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C11B9B3F;
	Wed, 14 Aug 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652891; cv=none; b=uYCYI0UA3WZfg9404BgFOMlCqwVYOfF3uHOrP1ZryBVTwr8M57+RCIVffEo1iSGt3pDsh/KawcLoYqObW+VvubL6E5BZ2Bdd01wB0Dq0grti6GnyGE2pftLEXEUrQTNM5kmmydB73kp7Bwx+m76t0FqhX/Do/72FMf1rhRUVKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652891; c=relaxed/simple;
	bh=ff0GKgnheZ7X8mrtsVsnaQeU0+OljrJSRChWoTdDY4Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SCwKpPuTejJ7YutKk/egeBWC1DWckbt4pXpVOAPBGc0OKVQkxaOH5V2SG1IFTYA9iIpzYqiJSrXJmTBaA/je9l+NLoroiHARm3jMZV4ctaLq4RpbwhSgdltLr1F+6KjyVkfGglXwLMj7CGDM7XaT2BPEoXHDNijmx5Zmb1cwhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqnpZ25d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1FDC116B1;
	Wed, 14 Aug 2024 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723652889;
	bh=ff0GKgnheZ7X8mrtsVsnaQeU0+OljrJSRChWoTdDY4Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EqnpZ25d1w87Ai9A95TAxHKK2TpkzxjbHD55OV62uiu0K7cTnVYYxUVqeeG4IG1k1
	 1zeWQsRjjcQFZhV2s+qxGry1Zelhy3LNCNP50mz6iy98Kk16uJQvcNyNq3dq12/Dq4
	 VI9Xz2UeOgCzZ5bcAKcIa0BxNHokrxq5HoacZ9ZEpBAcNFRM2k6/HLd39/fAtOOEz2
	 ydsCapU08kJ/A1EZgY2doCjSqh7gWFmUMS6t2L053Kpd5Rgt8KJLTS0SR8ARdP8egQ
	 ZPHSsoa+JBgow4zu8eWM70Oj/c8SgJ0mF+LO1sRKbyyHUGIP5xA/vn1QiShAVMiLsJ
	 Khl5ncuLKBv5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0AC38232A8;
	Wed, 14 Aug 2024 16:28:09 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240814-vfs-fixes-93bdbd119998@brauner>
References: <20240814-vfs-fixes-93bdbd119998@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240814-vfs-fixes-93bdbd119998@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc4.fixes
X-PR-Tracked-Commit-Id: 810ee43d9cd245d138a2733d87a24858a23f577d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ac0f08f44b62e59a389c7ed87c89087d9fefe29
Message-Id: <172365288845.2319409.6409162802293482433.pr-tracker-bot@kernel.org>
Date: Wed, 14 Aug 2024 16:28:08 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 14 Aug 2024 15:29:46 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc4.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ac0f08f44b62e59a389c7ed87c89087d9fefe29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

