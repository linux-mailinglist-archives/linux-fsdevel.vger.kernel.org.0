Return-Path: <linux-fsdevel+bounces-7573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362FD8278DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 21:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D911C22F14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577855E77;
	Mon,  8 Jan 2024 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDF1f0sN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33F55E46;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 321F3C4339A;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704744006;
	bh=oTKaOJAl25bOrdtZUx8EW/HovyD3auTsQ6iUEbV4emE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QDF1f0sN29orhXNAYh+Gi2Ve1T6dP5RUAMunQmfA8L+q8lAfeoxXbmnNGF7WkyxIn
	 ue+Ybi/7eIhIHMWj06XjomhBMq/zRQdZFldgpE9zih6/koV0Rrcc1D46uwZHE4xEAi
	 0gPvLs9JYC2BMgtawAv6NxY2oLyHdaArFlbP01ahnk4EvLwn7EYFnoszkRjf40ozSU
	 Q1kuJbMg5B7MVQKoNaAUSITWjCHScBJp23U1ppZfcDn0X2h7ZHesEQwH5tBTaIuKV/
	 gkJDLaNvm+YUMdlOZ+w8p38tA0+iFCVAumSDUbabE1T0qhL4MBvsboYByvGQM+Zj72
	 UG2syCKxfApwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1291CD8C9AF;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
Subject: Re: [GIT PULL] vfs cachefiles updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240105-vfs-cachefiles-c2fe8c0b01b6@brauner>
References: <20240105-vfs-cachefiles-c2fe8c0b01b6@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240105-vfs-cachefiles-c2fe8c0b01b6@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.cachefiles
X-PR-Tracked-Commit-Id: e73fa11a356ca0905c3cc648eaacc6f0f2d2c8b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26458409a9b180ea6cc2cd7b67d6138984184669
Message-Id: <170474400607.2602.5002367859999915388.pr-tracker-bot@kernel.org>
Date: Mon, 08 Jan 2024 20:00:06 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Jan 2024 13:51:23 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.cachefiles

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26458409a9b180ea6cc2cd7b67d6138984184669

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

