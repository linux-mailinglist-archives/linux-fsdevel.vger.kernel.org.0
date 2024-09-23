Return-Path: <linux-fsdevel+bounces-29893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABDD97F117
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC37E1C21A16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D9E1A08AB;
	Mon, 23 Sep 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZk7f0SQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CEB1A0716
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118403; cv=none; b=jDwpdohJCP6IKC+KAftDTYsvzFUED8ulSiOvz2pROFjmgs7poMfwlOMe0DjtA9+J68+qYhqkGICZmDrpnQWVOf6M1SBylS28+s0Ix9KaN5KjhOzRp3Uq9SRo03DwYKzrBxm79hSFshxRcn8t3ynqk6Exd2WoEw1aUr1zIbVo1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118403; c=relaxed/simple;
	bh=d6O36/QOP27cxhzPNlz4runm4ST+4FUK/3HaZxXfhvA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tqmmNnmo0H3/ped9KcjJmGi605rXSz6HQxcobhFpMzvyhaRtTd7D/Y1WUB5Y9b2ON9nFGJhP9ELFNTmi9laILZeB/Org5RGOeUq83aVdqRcdVj+/2YQw80D9nIaXB9R+tcXCx4Eo+8VmkPvi/bvRqD6KwBrt/AFFhmVbyH24RM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZk7f0SQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D77C4CEC4;
	Mon, 23 Sep 2024 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118403;
	bh=d6O36/QOP27cxhzPNlz4runm4ST+4FUK/3HaZxXfhvA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OZk7f0SQh3C2z/eDGMbLe+JvOdB2j1nDpVse5AI/qu9Vud/wEHGFChqIQ4YfTJE5s
	 sXHBH6ipSl36+uBaZZZQHjZpxvYAgKHWpq1I2AgconMi0qhvK+j9vXGggMehTfJh09
	 BfUTr4UV0HSbY222WUqfn+zlzAvq4A9mVzSDj3+v5L+w2wlYop9oXjhia49tqgUVo7
	 deZL2WpIgcslJ/r4TNes5oDMj6MOFqRKi537iUBM0vz7ATkMPcv8zX98jTY3bPcGp4
	 2rY+KlKAS17zEQ4Den4bTcsmSzurtZQeldzCCU07CFLZX6qZiu5E+tkWIlBQdVrLOo
	 nTVjXt9vLe8ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4A3809A8F;
	Mon, 23 Sep 2024 19:06:46 +0000 (UTC)
Subject: Re: [git pull] struct fd layout changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923034731.GF3413968@ZenIV>
References: <20240923034731.GF3413968@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240923034731.GF3413968@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-stable-struct_fd
X-PR-Tracked-Commit-Id: de12c3391bce10504c0e7bd767516c74110cfce1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8ffbc365f703d74ecca8ca787318d05bbee2bf7
Message-Id: <172711840535.3454481.14371701643541728195.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 19:06:45 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 04:47:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-stable-struct_fd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8ffbc365f703d74ecca8ca787318d05bbee2bf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

