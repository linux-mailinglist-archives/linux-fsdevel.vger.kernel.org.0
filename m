Return-Path: <linux-fsdevel+bounces-39738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A63AA17358
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0013A8085
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC91F0E2A;
	Mon, 20 Jan 2025 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tmt6F9lv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FE1F03F2;
	Mon, 20 Jan 2025 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402661; cv=none; b=kJWWaasUfu9kdw/xO3JgZS6LCiqs+xboC7fNDsMV5Hre2iAhUNSeBDJhqrHS1YgGjUIZeehIgw0PEG/wKWCz4qq4jJyTw25ZvgQTcD0lTLoSzhiKLqdfn2SWSr1tZfNaNO9W4RGHFhEgkXIF9FS53qXkORBCn1UOJRLwQT9wfv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402661; c=relaxed/simple;
	bh=OBmbk+yDWCGdhQkwj+kFZykqTGN0JgQo3Eyr044vShI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QGrfqJXbNR/CR/IUBZvHjK02mutqdU2d3bwqwnkLiMb/K8IYuHENi6tdthXv/4czsgYV7IWDbZ408zTn5m7Lbf2WcgY06EFzauBm189fdIaAE/GL0szWmOM2cKcUhKPYNcz64LQ/LcUkWhiBlKTn5ootMdV9VGSoFFsxvQj21i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tmt6F9lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7187C4CEE5;
	Mon, 20 Jan 2025 19:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737402660;
	bh=OBmbk+yDWCGdhQkwj+kFZykqTGN0JgQo3Eyr044vShI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Tmt6F9lvH7s9QNuGLeUe4br8pcNwxUs0zbwpNxbLpcVdn2P8PY3+w0PVtuBbkQT2W
	 vlIVX2DxwjrnrwMp7yxdcYpe0AMtJlPLU21T4OQENqvu6B6QU5kExTr6T4UL0Y9fHV
	 /8hAVL22YHWFPJoVXKAuZSzRnRWOjFtQxjluHnEOf445BuQYqqcLQf6SWjNWcKnFBN
	 rEYSxA4BEofPoodLC3QjYxV7jDDEZq4F47sY6QFUYRGN/ULbBXv1PvDkIUA+OrrkEH
	 lskGGfvoG2fcswd7UTVEVBoNiHGhn+1tawFxioxKKCZs6/LugqJeaoW81RZrVAhOLa
	 RkBvD22MMaIyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ECF380AA62;
	Mon, 20 Jan 2025 19:51:26 +0000 (UTC)
Subject: Re: [GIT PULL] afs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118-vfs-afs-c73684b81023@brauner>
References: <20250118-vfs-afs-c73684b81023@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118-vfs-afs-c73684b81023@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.afs
X-PR-Tracked-Commit-Id: e30458d690f35abb01de8b3cbc09285deb725d00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b971424b6e3cbea5c017061fedda6a5f74e142cd
Message-Id: <173740268479.3634157.1690153950228414088.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 19:51:24 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 14:10:47 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.afs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b971424b6e3cbea5c017061fedda6a5f74e142cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

