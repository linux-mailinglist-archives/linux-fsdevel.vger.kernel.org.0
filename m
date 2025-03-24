Return-Path: <linux-fsdevel+bounces-44909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9134A6E4EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBEE16C232
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B508635C;
	Mon, 24 Mar 2025 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm2YAIZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9301F4183;
	Mon, 24 Mar 2025 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850036; cv=none; b=puaP4xzIpuPL0i/l5xjStC63gUwNBiik7MaQL78ybl5aSjcB2vX6Do1OHHFbF8yFOJwGmFDfUQGaNYEziHufujXRFRd9ZdhLJJ66k3pMRRkCPfb3DNZpwyGhSe4WmubX2I02FuWOvPcWdtGaPfdMyC3Ki4U9fNzeVRIraJRaNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850036; c=relaxed/simple;
	bh=IgO8P5r9nhWkD4c3AugfJYxd7nRXLfKAqAKn4A7CQFc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UqeZDpLaZ6ujMC2NEFH8GbHkBjI1LBDtufpiHdfbo70qsJgMQDeckQIy2w5ikBxQK8Pu4IKgEGdLYX/kvEtw9/LtZah98qOggurbYMTP2tQUlw0KYBuiHg3b8CTDNpdLlwecx8HloC0lTpVd/fVOZ1F+P72I+ujLtwXgQrvJY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm2YAIZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DA1C4CEED;
	Mon, 24 Mar 2025 21:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850035;
	bh=IgO8P5r9nhWkD4c3AugfJYxd7nRXLfKAqAKn4A7CQFc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rm2YAIZvWov0EZ9qdobCPUHcB+/JFQKb7YQwAjtSPBY7mHR9No60lIR9xMVuk7iEO
	 jGTZreOBAVGE0kkaePLdt2eLnuhVxBpwO0rsSceEakJYa4cumgfPvqzu/SBVJJsEiW
	 7TdtRkMn2tnJwTRRFMeAkvQZLkR76HB8grNfofZMJCw4YXIWsN5TO0gprZ1TKam4IW
	 E4pbYstRHZxdfFVpZ3CkAhZaWO/fQ14qqPW8qM+EveFO+GjF85y4bXt5RsObQxrW9W
	 rw9LH4NZgD6yhALUJlyUzv1mq4ZOZFbl2HPnCKK0HgQ2GbCeWoABEn6wse32Ij+iON
	 Ots8gTCQGWrtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 707DD380664D;
	Mon, 24 Mar 2025 21:01:13 +0000 (UTC)
Subject: Re: [GIT PULL] vfs eventpoll
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-eventpoll-6e7927cfbe2c@brauner>
References: <20250322-vfs-eventpoll-6e7927cfbe2c@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-eventpoll-6e7927cfbe2c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.eventpoll
X-PR-Tracked-Commit-Id: 0511f4e6a16988e485a5e60727c89e2ca9f83f44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a79a09a0255b29317616e5a575a5951666fb2d35
Message-Id: <174285007222.4171303.1933959376308885326.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:12 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:15:44 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.eventpoll

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a79a09a0255b29317616e5a575a5951666fb2d35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

