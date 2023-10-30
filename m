Return-Path: <linux-fsdevel+bounces-1577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A917DC0F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03B21C20B74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A21BDF8;
	Mon, 30 Oct 2023 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuHRRVB/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C721A738
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDC3AC433CD;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698696340;
	bh=zKLNWdO7Thoc6gUedujTFEMI4L1tCn7DkndTWEOcYkw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nuHRRVB/HgxDvzq7C39k1uJ3+UX0NJpYn29J2rkgmK9wj5uKAPIS749PKlyZyQODF
	 63CfafaADJbDIxL0yti4hUl9kpMQwmqCdM3ZhfmXW+ahiV/BQ6T4Y7UrSfa6PodiXj
	 S9WGproJCOUrqe9hQZTw+wy50An2PbhUrnrAomIuCr2FpIVtlJ11nfrEd43T/2foA0
	 ZEsuQ+YJyUdQLLcBaejqUViIheuCXu7f3vmqlssxcuqIfdrMFgqPeNUDt8g8wVJ29r
	 89ElxQEduUYNz7xh1+D8VMRbNX8LWwZx6LppipkgKeIm+ymrLCz3025QN3t79NGM3j
	 vikbjR+cfEO0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC3A9EAB08B;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] vfs xattr updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-xattr-6eeea5632c93@brauner>
References: <20231027-vfs-xattr-6eeea5632c93@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-xattr-6eeea5632c93@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.xattr
X-PR-Tracked-Commit-Id: a640d888953cd18e8542283653c20160b601d69d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7352a6765cf5d95888b3952ac89efbb817b4c3cf
Message-Id: <169869634076.3440.4839441545054836819.pr-tracker-bot@kernel.org>
Date: Mon, 30 Oct 2023 20:05:40 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Oct 2023 16:44:00 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.xattr

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7352a6765cf5d95888b3952ac89efbb817b4c3cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

