Return-Path: <linux-fsdevel+bounces-5733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF06A80F645
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B11281F9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 19:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC57B81E34;
	Tue, 12 Dec 2023 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBBF/fBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC281E20
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA342C433C8;
	Tue, 12 Dec 2023 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702408417;
	bh=8/hLp1SyzouiwzvoUdUpcbUA5V2wQNYhhSq/i1K7OQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kBBF/fBhYfvZkyvTksY8zrF8wk/ifyboa+M16bue92o1goq71JJaq34IdT4dtscDF
	 w8H4wk74IaYxHcHcq4VnAzp94XRCJjPN6JN80i+YTnJmyJ2fdV8EY7ngwiJvrdIrsW
	 cCcOaxH9PunwaYKdAO4e4R2tia7JSaKEAneo05LxonbWPUBqSwrpJagoMEidOcFL/K
	 fY8RomOBlzcGF8OdbcZwmis+7cFISsVQZPfliAnCTgnFJvWe4x9lvF51b+3x5HRVv2
	 1/5r2RNiYsjsVpj1umIhU0aRPd4tsrnYGM0W6xAb+5h4/eKo86wa15ZMsx/kZWeR5w
	 OjvTKp3uQ0lFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8395DFC907;
	Tue, 12 Dec 2023 19:13:37 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpeguzG6EGi2FXspV-sQDrFkyf5umF6jHg3G=9XpWN95Bsug@mail.gmail.com>
References: <CAJfpeguzG6EGi2FXspV-sQDrFkyf5umF6jHg3G=9XpWN95Bsug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpeguzG6EGi2FXspV-sQDrFkyf5umF6jHg3G=9XpWN95Bsug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.7-rc6
X-PR-Tracked-Commit-Id: 3f29f1c336c0e8a4bec52f1e5217f88835553e5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaadbbaaff74ac9a7f84f412fbaac221a04896c1
Message-Id: <170240841774.26992.1629314593169004589.pr-tracker-bot@kernel.org>
Date: Tue, 12 Dec 2023 19:13:37 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Dec 2023 16:25:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaadbbaaff74ac9a7f84f412fbaac221a04896c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

