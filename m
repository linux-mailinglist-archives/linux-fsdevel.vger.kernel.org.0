Return-Path: <linux-fsdevel+bounces-44911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C1A6E4F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C4A3B50D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8D1F463C;
	Mon, 24 Mar 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk1H/y+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FE1F4626;
	Mon, 24 Mar 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850039; cv=none; b=CDuJrkiy104HRH5B8523ZLnNSUjrcbmDwEx7DCTWqJFPjS/cFMXYsVPsFu2j+n6ehgo2ZoECsbdp0DNKOtACQa0NCA3Ng2xZs/SC1XeCyn/JOL3TH23QBnNK7QrwWOOVLREWH7vE6rQ4WNClEP88qpM0ajorlJ38NYDqgIFR/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850039; c=relaxed/simple;
	bh=ENS05V8uJJcrRTIMOYPQ9i9XqNztSaNAUYOfL4yabQg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PNn0b4Cs+YNVPeZISrPxDNROUbhcvSxEro9+095KQHaCk6qVpjXKqknfVPLq011QQhReaUUWcqc6LpFuLkzQeYtCNGyv60GL1YmbAbint8v5+GAeGJBDLdbKIt2gdUflJk9Sm0BJHytsb06AnNYKCIx5i6RJXA3mzMNjAOJZRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk1H/y+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD643C4CEED;
	Mon, 24 Mar 2025 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850038;
	bh=ENS05V8uJJcrRTIMOYPQ9i9XqNztSaNAUYOfL4yabQg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Jk1H/y+8RxtP7UqkYCe0XF0hGB0onMXfKz+3HLYtIuYBkN67W4bj+PCwrune2Z/q6
	 U0+jfsGGRx/7OcB+8hPu9m2MdSsKaWH1+I41KQ5bgeTAKhzGlbokJgMHsN83sky3mh
	 fQdz1VKYi+eqPIf0ATV1UB+J/CsSI+N8EP1Qzua7uSHTgAg70Q/1bBNDkmRd7lXNxH
	 GRwDwXTgduhIMtzjRW5cBmjZdwUB7u6WlJCjv2p4CdWYlVeSB7d+7V0yJ1LuIffSC6
	 LfuCgmfhOFFskQhAxcRAQ0Z64FcbAFyImZSgL80Kc4xLttJ3aNaN38IqUNqaP3eHHA
	 fkHgYq1qEk1eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42E21380664F;
	Mon, 24 Mar 2025 21:01:16 +0000 (UTC)
Subject: Re: [GIT PULL] vfs pagesize
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-pagesize-6972cdf9bda9@brauner>
References: <20250322-vfs-pagesize-6972cdf9bda9@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-pagesize-6972cdf9bda9@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.pagesize
X-PR-Tracked-Commit-Id: a64e5a596067bddba87fcc2ce37e56c3fca831b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e41170cc5ef235a6949ea18edf1444e7f77968c3
Message-Id: <174285007522.4171303.18173503462480245327.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:15 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:16:07 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.pagesize

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e41170cc5ef235a6949ea18edf1444e7f77968c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

