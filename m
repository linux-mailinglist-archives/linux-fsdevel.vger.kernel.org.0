Return-Path: <linux-fsdevel+bounces-45714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB61A7B6D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C764F178F63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 04:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B516A395;
	Fri,  4 Apr 2025 04:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdrRvOJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371814B965
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 04:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743740227; cv=none; b=t3HsrI2dfFrBH9EdqQ3fBCPRoSGbwESbtLx3UYQLT7C06bqYivQJiFj4tF3GUpduIyAXNiC/9OQdRK1cfBT6Q57o5ODFrFByuXKVfU4Mfg9b8Fw0uCYqFKNzU1cZj+rQ4Djd9Za6huX2Z4JPl/UCorgl1o8/cyp+o0jt/OpWoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743740227; c=relaxed/simple;
	bh=4m0G7Imfj7e6XX07CV/uoAEicGRS1wA7h2mJ0grj1no=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hj65WY7IjuNMdMuICTq/nJUu9WbVLNYxzbOBRggDTFX8CVasc39VPEBjyUtzUvnwOQQNYv9qGl4+cFgLPzdyJ9yROqdNDxeDA49BdzWqbRteUnU9LOjC87x7CyQVqzZTnuWD1f+1M0FIUsHVezZBgVSjEYSA0XtkwTDnCs9feIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdrRvOJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786DBC4CEDD;
	Fri,  4 Apr 2025 04:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743740225;
	bh=4m0G7Imfj7e6XX07CV/uoAEicGRS1wA7h2mJ0grj1no=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DdrRvOJcPT9yCYCBrrN+gBdYLaq7cZlJ7u7cvdCQuhpamOvfHFbo6T9sfcgBOfq2q
	 +PoV9vWxqhBeaihdbCYtH5KSbHxJn8JLpgDZmQYxTQh76qesUKwfMihfWR3H6Bw0R2
	 zHA2sbpXe8zSXdevUhnT84+Go4hLz4QBQKryAfMjNXlLFswT13qVoG8SyoJmkcir5i
	 14SzvpMHGQcOOX2eYymEgefwkWJA0W0Ze489nD9bzxVQ7Qt+pmmZhLi6Vx06R8QpaK
	 nMS+wQnRUOfawUVVXQGJqvXEgrCqw987NsyZ+j4aIOPxRMzcvikUaYyjq8dL2W/Dey
	 LFaQs3Uw0F7xA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF953822D28;
	Fri,  4 Apr 2025 04:17:43 +0000 (UTC)
Subject: Re: [GIT PULL] fixes for bugs caught as part of tree-in-dcache work
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250404030627.GN2023217@ZenIV>
References: <20250404030627.GN2023217@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250404030627.GN2023217@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 00cdfdcfa0806202aea56b02cedbf87ef1e75df8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e48e99b6edf41c69c5528aa7ffb2daf3c59ee105
Message-Id: <174374026233.3116607.18106083659795895713.pr-tracker-bot@kernel.org>
Date: Fri, 04 Apr 2025 04:17:42 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Apr 2025 04:06:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e48e99b6edf41c69c5528aa7ffb2daf3c59ee105

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

