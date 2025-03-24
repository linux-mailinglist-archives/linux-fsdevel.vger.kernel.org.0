Return-Path: <linux-fsdevel+bounces-44902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A78A6E4DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0793B24E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD81F03DC;
	Mon, 24 Mar 2025 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOVtjdlt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17EE1E5701;
	Mon, 24 Mar 2025 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850025; cv=none; b=TYbuGbsK2fUCbu/NHW917TY/Y2Sv/TzLLOXe/QT/eWVZ65EXbeQgW/uB0ZLCCmbsobqb9ga3WwUWtVQ1rlfGdMEtKa+7eGmA0zjK8ODfG6SL183sGcxlR1ozy9t2N2s9Y73P8/pwviQjDUiou5KlJ1lDjoJhRd7I0hKjS7OYTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850025; c=relaxed/simple;
	bh=zS7Otit+4m4EMxgfBekGUVV9VbLXp3U21OXrBS06UNU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dC3nAeEvDk11IVeXCW7HA8P21r++MLRmmlDvm69ORUEd2KvQAq9jBC8YWvEUb/qBjsOPfBKpfnfQEP8Llc/p4nczo7EFNHI1eethIJ2uNDobjEBa0R0gDA48k2G/oU8kpCPI9oAdFWmYzPEdowTz1uOkn4ohT0HGgmxuRR1J/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOVtjdlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F78C4CEE4;
	Mon, 24 Mar 2025 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850025;
	bh=zS7Otit+4m4EMxgfBekGUVV9VbLXp3U21OXrBS06UNU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oOVtjdltMWYU8NSsV8qCuHmOU5/v8uMStkXubuA3/RXXXw/zOG8sARfRfTLBTv+QY
	 d87HOpDMUIZ4lwp+LiXET7eAC/cg244tfMNYErIYExClxwusCYe6SpG1lI5uDAW6JH
	 dMfUYv3Lflt/GbHL5zIVCmFYQQ9nhQLxvTsOUMwvTl6ghD0mnp8S8taDw/0loSbLEV
	 2GqFitgaTXqL9Mq+c6ppZ3Ci/ltPTJ76DoKYo7Z8tMRVPT84mZuEmLQa5udRJULk9g
	 QR8sao86bWYb0mQpRNmZu+n0stus0eR6H2+C/WnkoPZRK+93n+goF3fkFwut9LrASK
	 CC2xn3TI6SrwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F93380664F;
	Mon, 24 Mar 2025 21:01:03 +0000 (UTC)
Subject: Re: [GIT PULL] vfs pipe
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-pipe-8ecf613e3047@brauner>
References: <20250322-vfs-pipe-8ecf613e3047@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-pipe-8ecf613e3047@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.pipe
X-PR-Tracked-Commit-Id: 3732d8f16531ddc591622bc64ce4d4c160c34bb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71ee2fde57c707ac8f221321f3e951288f00f04b
Message-Id: <174285006208.4171303.4890179175922069716.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:02 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:13:51 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.pipe

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71ee2fde57c707ac8f221321f3e951288f00f04b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

