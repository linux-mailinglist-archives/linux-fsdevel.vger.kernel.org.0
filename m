Return-Path: <linux-fsdevel+bounces-8197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72591830DAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 21:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC32B2539B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 20:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D025541;
	Wed, 17 Jan 2024 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFWl+eRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE573250F6;
	Wed, 17 Jan 2024 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521828; cv=none; b=h2tDgAF78Rsbo50BzbD6yqX38b3B41TVYqmeiiiKv5BUCQfY0IpNSqAQy264iBJ5jt4zFqR3yX4/bbyjjBqXsNBvNr1vF5vOxaGUQc/owv7uG5EL9Yht0zdyWdSQ33dIOFS4sn2Zziru4eDWMZ9eUgfc7QDUz5Ceuf38bahGGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521828; c=relaxed/simple;
	bh=JrkjTcPpY4VZeV2oNPkjASuCWL5xrT2JJEPtpX8PLEg=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=gwzRnHYuOeACfNjjG89ZnMkn4+NjMrUDapHYcPmqGTn06ZbhikPvXKPRYnfugkY5gIEMNRRUq37f0Nnu7wh0me9VuA8qyZKQi1EFhTgEjhO+dE+b7HPeBEji55nHcbm72Nh/vkXCl7fyYdL82d7SYAvFAczV2fQWdmqLmQFjtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFWl+eRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88585C433A6;
	Wed, 17 Jan 2024 20:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521828;
	bh=JrkjTcPpY4VZeV2oNPkjASuCWL5xrT2JJEPtpX8PLEg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cFWl+eRtzwIFz+55LGIPxJpGKDsH3FyBo4AMQyoJj/+d8zJU4wlOtdcJqXej2V1uv
	 bvaTHVVcgemmqMD+uzaaOZcbLB4FRQSue4QfvmB5oZ4Tt/257jX94169zoWkDOV80T
	 dSm9ccwgNrK1t/nE9KMFpBeo6hbksUz5Sx7/XfTdKnk9+BTO7myeo+aJd5fkj4Ifh2
	 2IMZawO5gsyRfX+fiSSsxH6+NY1f2bdpWu2Z8htjN0AVVcHACxiSGcHrP8NFjqJQ61
	 LAes7EGDiSqsKLpqlr7R4gxkmjEs8TI1aOYbDuQhtGIKJ1r5i3l0jo4jeMzNUrB7ck
	 vGP7UUSIGfuag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B0FAD8C97B;
	Wed, 17 Jan 2024 20:03:48 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240113-vfs-fixes-23fdefd76783@brauner>
References: <20240113-vfs-fixes-23fdefd76783@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240113-vfs-fixes-23fdefd76783@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc1.fixes
X-PR-Tracked-Commit-Id: ba5afb9a84df2e6b26a1b6389b98849cd16ea757
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2459ce011f65487231c6340486d5acdaceac6a7
Message-Id: <170552182843.2985.6895467585895805713.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 20:03:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Jan 2024 13:31:03 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc1.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2459ce011f65487231c6340486d5acdaceac6a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

