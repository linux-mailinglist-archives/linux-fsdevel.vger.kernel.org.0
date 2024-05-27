Return-Path: <linux-fsdevel+bounces-20247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E28D0633
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 17:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CA31C21A4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9873973479;
	Mon, 27 May 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj9OAe7A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106817E901;
	Mon, 27 May 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823808; cv=none; b=KPVPyLG9q6PQ36ZvQjDeO7s6ouIjcybPBjDX9Cg9zf67d6pZODbXChhDHEMBvsyEPNPnpk5p3FxOhD2RM6KeBmdhOrvvnV0rgZpgtxsRl7+KzY545mN3LnM8Xk50pxmUzjT/Q+Rna1VY7k0O4A+qm1jp5eSJPBeCTKyTKo1E1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823808; c=relaxed/simple;
	bh=av+0AkCMXX2n6oucQPkQP/tR3wmYObAftqkimVYfURg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sDmuVptahpOnaA4bB5Qz8LyMb6cCVaVeJT6EkI97nbKxKBDuYlXmaNyRvNsLfruteYZ8woseNGBe4vm4thEci8glmZP44KbN3gluVClGNChU1rtfUr9CZFAdoLk3zOonoKXSOqYAYsxTgZ3ZQW4LaOLha/emxHpAlMdPGoOhwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj9OAe7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 807EDC2BBFC;
	Mon, 27 May 2024 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716823807;
	bh=av+0AkCMXX2n6oucQPkQP/tR3wmYObAftqkimVYfURg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gj9OAe7AOnY3jHh8v0gD8c8Qgv7hfBi3ueO49IJYdxmsvsdgq2bbUTFd0Zoh8WzNM
	 NvfQuctOsyssaqSNLk9xz0xPQW6+MkbHcRMXh6Z/n8on4+SSpahjsJ/QUF7GBoj/MC
	 8M013Sk+bvFA9eprttjjHM4aZe0t/S4ZNgKQvFzFme3hS8/QvE26fwOgcENHuyKMvL
	 /L9cOtEPxEIHpq2Rtv1exSsuzVGc8QE4YZYLnoJwBzqLBdWQskz0TN6FvhAszk/P3A
	 Zbz4RVmxGpm7ISYgVTzIOOGMJ+rshQz8ocT6vcN+PKU7FOkCoHv4zPn0zm/mrI7/dp
	 ojL0P9vATXNjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62E21CF21F7;
	Mon, 27 May 2024 15:30:07 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240527-vfs-fixes-96860426ed27@brauner>
References: <20240527-vfs-fixes-96860426ed27@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240527-vfs-fixes-96860426ed27@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc2.fixes
X-PR-Tracked-Commit-Id: f89ea63f1c65d3e93b255f14f9d9e05df87955fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4c07ec89ef5299c7bebea6640ac82bc9f7e1c95
Message-Id: <171682380733.26768.727803727113502416.pr-tracker-bot@kernel.org>
Date: Mon, 27 May 2024 15:30:07 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 27 May 2024 13:55:56 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc2.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4c07ec89ef5299c7bebea6640ac82bc9f7e1c95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

