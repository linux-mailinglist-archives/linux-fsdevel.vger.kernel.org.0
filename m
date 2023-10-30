Return-Path: <linux-fsdevel+bounces-1574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9BE7DC0F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D662816BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0C1BDD3;
	Mon, 30 Oct 2023 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjIyvG+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C21A72B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 952EEC433CA;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698696340;
	bh=ijZ8Z/+6e386OXGSMMnnmAuMhfYcaq6MlpsE5qSq7Hs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YjIyvG+PYumwNI8mn0Jk2yzVVk5fATP18zJndKbzB/NkdgTH5CvCp5xmKm65AxvjT
	 qR+zk4kWPHRoVcwq12rMSHHB1ZvcbzbfcmYWBSfkZK52JTVHOVzKz9tInfR1NBnuMb
	 VuRSK0hZabRbjl2wE5623+sed6OgRU0YXZ4KUPn+SZvKHxEJbavXV6pjGO/hytlg8x
	 iSTTvCRH2Esf2WAT/5mMcAL0+slKYvajghH415yTlT+/jNKbeOOrX+QuE7K/AmxBJr
	 XNaFSqZsSv/k2Ubr+/bZLpU1V735k898AhEuM4WfuYZfclpOVEGn4XSyRayd85E6vj
	 I6y7NLK/PYoRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AECCEAB08B;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] autofs updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-autofs-018bbf11ed67@brauner>
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-autofs-018bbf11ed67@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.autofs
X-PR-Tracked-Commit-Id: d3c50061765d4b5616dc97f5804fc18122598a9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d63d8b2294b228147bf58def506dde35e57daef
Message-Id: <169869634049.3440.11020096823125592426.pr-tracker-bot@kernel.org>
Date: Mon, 30 Oct 2023 20:05:40 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Oct 2023 16:33:41 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.autofs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d63d8b2294b228147bf58def506dde35e57daef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

