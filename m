Return-Path: <linux-fsdevel+bounces-365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8B7C9A06
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Oct 2023 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC99B20DD0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Oct 2023 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0681E57F;
	Sun, 15 Oct 2023 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4UZ+s/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1368DF4A
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 16:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2D7BC433D9;
	Sun, 15 Oct 2023 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697387063;
	bh=QrbqGmCq9GHG3xrko2d71kZwRVgf9KxpetShiGnwiuQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q4UZ+s/t5y40cphZpo5oFB55wSKJLfywlss6Wc0dbJjG2FjJiitRiqcBaUGYm7zm6
	 zqLRFLaAzqDbwoiewl/AxkZEarppkZOS4nOtFs+r10haOXCogNl1mfF3kIE5k5tZmq
	 N13REBXgRBRNMMKCAz4e+Z/IzCO/FDeFq9sD5sZPE8FZVlIyg21hN65JEAn3gOF7/7
	 c4H9ff+MOdwlycwuSy7Fte/RfRJx24qEXwz0WVfk+EVJOQzL9oMw0wt+wH3oKO2EJL
	 Y9HorZ9FQP9D6e1igRVWBv+DAZQZPGPlRnNsrsJEyafuHeSG8YRO/2B+NW3EiXX+Mw
	 Jut13E4SiqxiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B264DC395EC;
	Sun, 15 Oct 2023 16:24:23 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.6-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231015120117.2131546-1-amir73il@gmail.com>
References: <20231015120117.2131546-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231015120117.2131546-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.6-rc6
X-PR-Tracked-Commit-Id: beae836e9c61ee039e367a94b14f7fea08f0ad4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19fd4a91ddeec20f9971a06f6328558c392ad66a
Message-Id: <169738706372.6658.15776753018005949540.pr-tracker-bot@kernel.org>
Date: Sun, 15 Oct 2023 16:24:23 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Oct 2023 15:01:17 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19fd4a91ddeec20f9971a06f6328558c392ad66a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

