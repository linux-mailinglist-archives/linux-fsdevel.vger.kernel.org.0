Return-Path: <linux-fsdevel+bounces-7734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FF3829F51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3128AB212BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C594D13B;
	Wed, 10 Jan 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbtn+c6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95E4D10C
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 17:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2301BC43399;
	Wed, 10 Jan 2024 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704908254;
	bh=0f2CFKZYO9BrkwabzuayHheU5rEx0k1mfzh8LbuLRO8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qbtn+c6TyNBe7lIvsR9+H5sI0NefMRIrbCAfzlnVRfwM05BkT1jAIskjUElladkNd
	 CQeK6uHWQyNz7rkNj+RJcIKFjhKSWzuc/LSWkFrHqkdk1iAzmf2g4VvkUc3tNfY1U3
	 AApEXlusunYYaULCdtWEdLTrZABLERbdFFWqywkcbdvESZWm4d7fU+GpX/OQndCUjv
	 VbGFgkc32ir+gaysxphVgISgmmDcjMsW+LI5zrx1nDrj4h+sFDemp3FCEwQn38/69g
	 Gyb7cddtz0JqBYG3gUx/R0YEDd9r9s0kbIhRJ0XGG2ggt129XbhyPHHfhnz+Nz4qnZ
	 wVPUj6Eho0pqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D8BDDFC686;
	Wed, 10 Jan 2024 17:37:34 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108140746.viajl65blnibbyjf@quack3>
References: <20240108140746.viajl65blnibbyjf@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240108140746.viajl65blnibbyjf@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.8-rc1
X-PR-Tracked-Commit-Id: 30ad1938326bf9303ca38090339d948975a626f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32720aca900b226653c843bb4e06b8125312f214
Message-Id: <170490825405.14271.14877535471258650251.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 17:37:34 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 15:07:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32720aca900b226653c843bb4e06b8125312f214

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

