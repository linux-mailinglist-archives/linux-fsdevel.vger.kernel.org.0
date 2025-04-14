Return-Path: <linux-fsdevel+bounces-46405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDA5A88A11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 19:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68028189A8A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36028B4F6;
	Mon, 14 Apr 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjFfVyxB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1AF289374;
	Mon, 14 Apr 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652463; cv=none; b=fAvFrJNXc/1SFYKwrIgVaOprztz+T6e56Xfynf8LTUN+dUEtw/KBsiQ0Pz7k7NCOdmFE4vqDxkix1xzU+SJK2s5m8wp3J8Mc8AGSs1zmDMkGT4ie7bbb0Uwfu1TKL2HPjDSTXHng4KhcKtRrTfAgusXKpEckMduW1ieHc8GQuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652463; c=relaxed/simple;
	bh=CUYe5DKKYp4Nrie0XBwdqr21NoFcqQ57+8C+95ZKQjA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B2EUmhvUYBP8mk3K/hrmHRzNqTjdSNe3wBEUpU1SNjRZ/4JS63e1BLg6SGQ63KLapKZu87+AYUt/JBqSv/w6/HORX0Hchm6YP2X9Ptwbty24ggH6ivN6KapobNx0azGhpcwPDexI35L0TdmxtNU1DaIHFxNsl2lWvt4G0b+7en4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjFfVyxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BB4C4CEEB;
	Mon, 14 Apr 2025 17:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744652463;
	bh=CUYe5DKKYp4Nrie0XBwdqr21NoFcqQ57+8C+95ZKQjA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AjFfVyxB0ZbRRvnta7/55haN1+QSRdR7B9GpCz4f9p9kfiif9+4AK2JqNpjJVvLra
	 IMNJvsj9ofRHwl7o1u8IaPyOf1cYPyg+A5ZRgpRtaoLBi/kvw1O/fppAxpfRiZgTYD
	 qrmfe/8UgGDeVtdew2fqt4G/MuC6Mks6Bb0aGiopqCg3THlfhZpV/nhVSO1eV121K8
	 5WflP1H+mmPSnzRftS57b5hMMzBVSK7ugUknBRQgsGQGFQAa9rfIDXwnpejB/x/EAU
	 t6JtikQWerlpktaD+UAu5eNAJoW8P8RDFg8yOIeluG+AXPOlZU6hoB6teu5hT15JeX
	 tT5OjPGRi1BkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D933822D1A;
	Mon, 14 Apr 2025 17:41:42 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250414-vfs-fixes-135f081cd64a@brauner>
References: <20250414-vfs-fixes-135f081cd64a@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250414-vfs-fixes-135f081cd64a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc3.fixes
X-PR-Tracked-Commit-Id: e2aef868a8c39f411eb7bcee3c42e165a21d5cd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3618002d007244be851fb5f314c6ddc61b8b860d
Message-Id: <174465250097.1985657.13457865497688992470.pr-tracker-bot@kernel.org>
Date: Mon, 14 Apr 2025 17:41:40 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 14 Apr 2025 12:44:19 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3618002d007244be851fb5f314c6ddc61b8b860d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

