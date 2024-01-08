Return-Path: <linux-fsdevel+bounces-7572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE058278DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A111285503
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2263555E6E;
	Mon,  8 Jan 2024 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCkaKc4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1955C26;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B2F6C433B7;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704744006;
	bh=vrkgaHiOzpid8AV5b+ecg225KZ73edbtk84ftzrzZPg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eCkaKc4ciTN9TZKKpRLG4KZw9V2ZhqrFrdcL14BxUn1/3YTHrj/f+mtx8Ljb38DLu
	 FYuk8Tu5902xUYGC1D1jrr6m354iF9tvILsPM+lW3b+/LSd0wJ3X23ABCF8vJFAmZI
	 hwTG4TmJ4wMBfMxRlerzVlMXLIrkRRgMlWNP8XM92Lp2FRsZCMFi5zC+x0n1wr4qE4
	 /0Py73KI4hC4qER6PjjS84qIlLRNBFOUvJmTOpV2/yntlq1qGzAlGdNvBLujrGflp0
	 jHqR5JEpDd1/WapKN6rmjFFwVaXZmYrylNtkVN889gPlK1O56mO2UEstaYEGa81Jua
	 HSYW3ZpPuI7pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FFCDD8C979;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
Subject: Re: [GIT PULL] vfs iov updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240105-vfs-iov-52b480d953c4@brauner>
References: <20240105-vfs-iov-52b480d953c4@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240105-vfs-iov-52b480d953c4@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.iov_iter
X-PR-Tracked-Commit-Id: 9fd7874c0e5c89d7da0b4442271696ec0f8edcba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5db8752c3b81bd33a549f6f812bab81e3bb61b20
Message-Id: <170474400625.2602.6241879060523846940.pr-tracker-bot@kernel.org>
Date: Mon, 08 Jan 2024 20:00:06 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Jan 2024 13:52:04 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.iov_iter

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5db8752c3b81bd33a549f6f812bab81e3bb61b20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

