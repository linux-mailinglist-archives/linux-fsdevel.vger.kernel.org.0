Return-Path: <linux-fsdevel+bounces-7570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17B8278D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C434F2852A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5CA55E41;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+DL5iap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5255799;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB502C433CD;
	Mon,  8 Jan 2024 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704744005;
	bh=pIUCTsXKJMjHLfryl6VKX7two4mDDereukU9Gdr8pEU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j+DL5iapwmyGNjBadO98TrFgMjr612bTi8hK3txDhXzNq7fDYtxJWma7KRGcKUtp1
	 HtnokOQDP6IVynoAN2fmHe7o0048hfkFy0YNk3MIhXKd14qoEw8xtzzP6O8m9hs7Ub
	 DIN+e+T3nOz4kb/ZCH3MC8hfgr+wOb+opXnvppl+hTxmtnW5BljFPlPfm4aYqVRp9U
	 WEkzIsyEGFNVXMDzTUUmzMkhhoFB73fwAJoccybzKx1dhBS/29qaYrCadakQwWWc2V
	 cdY+d0/Spwg235/D6huKxNY/K8t6rbcmXJ0i7bD5/LZ8unVyrYqLoY/VahyKe6RQOC
	 M8Yg0wGf0w7Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBB95D8C9A5;
	Mon,  8 Jan 2024 20:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] vfs mount api updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240105-vfs-mount-5e94596bd1d1@brauner>
References: <20240105-vfs-mount-5e94596bd1d1@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240105-vfs-mount-5e94596bd1d1@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.mount
X-PR-Tracked-Commit-Id: 5bd3cf8cbc8a286308ef3f40656659d5abc89995
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c9440fea77440772542d6dbcb5c36182495c164
Message-Id: <170474400576.2602.7882507604401153304.pr-tracker-bot@kernel.org>
Date: Mon, 08 Jan 2024 20:00:05 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Jan 2024 13:46:53 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c9440fea77440772542d6dbcb5c36182495c164

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

