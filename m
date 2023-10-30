Return-Path: <linux-fsdevel+bounces-1578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0C87DC0F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C952B20ED4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C991C2B4;
	Mon, 30 Oct 2023 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKCusVtA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5021B264
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F032CC43395;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698696341;
	bh=2I3yR0Y3qNE8R4J2WTCcp23m8YYQIdsHI8jSUxokxDk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jKCusVtA8Rho5E+QUsOrN4VVlUByrY0B4ukogY1+QTa1xV4aB7XKkT1lJYxZNt+Dt
	 umicJGeZPhKPzPbL68NpOmxWx4TdAMExU9zzV05zOO7Hj60gLzbK2SPQQJr9Si37Mq
	 71YjvagvRMm7N83yYvXxUhvRvFNgFyBFFKUMs71kqTiBN7/Sy3Sz+KBX5U3RdGoAAi
	 eUGyt1TW7bnzBWsUZ5olD9EQtway9uiq2hGJdUs9x5lizHhDubLuHT0rbFbyBgkVyP
	 J7kmXCuVcPS+RtRqyagQac0RuaWvXXCjEQY9nsHXu8zW887wH/wHkhuzkq+UogcuGc
	 vcGOJwiOC+zng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9CA8E0008B;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] vfs super updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-super-aa4b9ecfd803@brauner>
References: <20231027-vfs-super-aa4b9ecfd803@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-super-aa4b9ecfd803@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.super
X-PR-Tracked-Commit-Id: 5aa9130acb98bacacc8bd9f1489a9269430d0eb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4e175f2c460fd54011117d835aa017d2d4a8c08
Message-Id: <169869634088.3440.14750284416642696918.pr-tracker-bot@kernel.org>
Date: Mon, 30 Oct 2023 20:05:40 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Oct 2023 16:02:33 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.super

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4e175f2c460fd54011117d835aa017d2d4a8c08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

