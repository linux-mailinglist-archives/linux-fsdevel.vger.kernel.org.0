Return-Path: <linux-fsdevel+bounces-1576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 160977DC0F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0FAB20DE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6541BDE9;
	Mon, 30 Oct 2023 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxAOYzIk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C921A736
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF7ABC433D9;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698696340;
	bh=1P62kfcP7S7n9/IVYnvnbjaTSf1XpA8/x0aok6sFJ3k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rxAOYzIkTvOwd3gnbMIjOHq3z9ARi6FMfsSvtBVyMUSPb69Dc8qtEMLPjQlMGm1Qt
	 QMJvQLie+gguigLteehBhIs+QD5XWaIX6zOX8rRX+pUa4oAY+rkjCX7Y7DRxU6uG2q
	 owUcCUPjpsAhweM8BzKWGFW5GRGUnSU9nPt/6H0AJtRwPKKHcv7vkpqzLZ148mx5vg
	 zz7DPh7h4kJWRdH6FdOKTDT4fWIiPobBZLCBIuhF699PnJrJYATseFn5UScs318aA1
	 4Y6Xm+9UHuZQbICTKKUZWQPzIK3SAueyNGPtC3V37gxjZRFwZL9ie0xeqvhwnicwHr
	 Ikm62OgVXvRtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBC50C4316B;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] vfs time updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-ctime-6271b23ced64@brauner>
References: <20231027-vfs-ctime-6271b23ced64@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-ctime-6271b23ced64@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.ctime
X-PR-Tracked-Commit-Id: 12cd44023651666bd44baa36a5c999698890debb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14ab6d425e80674b6a0145f05719b11e82e64824
Message-Id: <169869634083.3440.2926215966082490773.pr-tracker-bot@kernel.org>
Date: Mon, 30 Oct 2023 20:05:40 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Oct 2023 16:51:07 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.ctime

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14ab6d425e80674b6a0145f05719b11e82e64824

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

