Return-Path: <linux-fsdevel+bounces-7569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277A28278D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 21:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC05E1F23F94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713655C23;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5GAi00f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C05578F;
	Mon,  8 Jan 2024 20:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD713C433CA;
	Mon,  8 Jan 2024 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704744005;
	bh=FTaMWjH2ziijQfpqAzPrzrLsqIQmh4S90b3wZKRuKmE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A5GAi00fxel8r8EzL4f48S4SnMLXdWzcuw7q3zhPxjT/gDZAsxMsp/no7yme/YjN1
	 2yKE9Iai4DlJQlNQmmDDzNPYrbhxVBOL3p6a0v8KKDEqASObEGL+qX0MFIEJtNDjnL
	 LZJyygI/Y1+z+okV+nQTkem1rcGW0yTAoIX+1Y2QsDr1xxu1ycnM+xp7PY7RagRk2h
	 XVuGcqq3YCEY0fJc+KZVi74UyP1ltAUokYCF4UqNzckkFQYGiPAwkLfHqYNklCastb
	 6QPbGVhF4YhaoYvtIghq705rRdrzGFKmJ3Ht3YpJL94wzbLd2nVsdv10XOHGkjAgrW
	 PyPkwBoo7P8NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91F7BD8C9AA;
	Mon,  8 Jan 2024 20:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] vfs super updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240105-vfs-super-4092d802972c@brauner>
References: <20240105-vfs-super-4092d802972c@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240105-vfs-super-4092d802972c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.super
X-PR-Tracked-Commit-Id: 8ff363ade395e72dc639810b6f59849c743c363e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f6984e7301f4a37285cc5962f97c83c7c3b8239
Message-Id: <170474400559.2602.7791460775055924534.pr-tracker-bot@kernel.org>
Date: Mon, 08 Jan 2024 20:00:05 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Jan 2024 13:41:03 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.super

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f6984e7301f4a37285cc5962f97c83c7c3b8239

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

