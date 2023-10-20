Return-Path: <linux-fsdevel+bounces-861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4467D17B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 23:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C6B1C20F91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 21:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE79249F3;
	Fri, 20 Oct 2023 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5DkKrab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364523744
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 21:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8BD3C433C7;
	Fri, 20 Oct 2023 21:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697836083;
	bh=7kblIBtvxrw0S6221nuAWciJ79PXAeL8tsBzTc+0txY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f5DkKrabbbHAyaAiPaSuzCGuZ3kOCzn2aszajMMQ5dJQpNAi/OAQXBFg4UZh5UqW1
	 +gUgcGOvbY81WM9kbU0dfc0M3rmfglLM+BIObdVzwnRnfUZTYUckVLQWWiiBp3Qd8F
	 /nH4jSFIHEHyU7IN7qpz5tJGMTBPHse3hL5UOcmBAFHhRbm8ugytKwQGSl6t1vhqp1
	 a3EwV7iywevVKhA7jZPJkOcpRN7wZdkT9ckoz5b93i0AhWuWGu7+UFFXOlz6w1Hyvs
	 m4zRnkRMfwyDms/bB0G2mo31OODqoYW3RWguCOK0wt+5XBbwl7Z0wuMj9/Oj14BUSC
	 8tvoyUqO4a2UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95918C595CB;
	Fri, 20 Oct 2023 21:08:03 +0000 (UTC)
Subject: Re: [GIT PULL] fanotify fix for 6.6-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231020181919.kavthbalswc7irnm@quack3>
References: <20231020181919.kavthbalswc7irnm@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231020181919.kavthbalswc7irnm@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.6-rc7
X-PR-Tracked-Commit-Id: 97ac489775f26acfd46a8a60c2f84ce7cc79fa4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e97fd29104fd9c6595788b670d04cc3c0e38b19
Message-Id: <169783608360.30992.3236043393718928168.pr-tracker-bot@kernel.org>
Date: Fri, 20 Oct 2023 21:08:03 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Oct 2023 20:19:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e97fd29104fd9c6595788b670d04cc3c0e38b19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

