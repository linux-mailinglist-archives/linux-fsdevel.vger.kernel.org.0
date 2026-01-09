Return-Path: <linux-fsdevel+bounces-73067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4389D0B66D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 17:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70989306EB93
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852363644A7;
	Fri,  9 Jan 2026 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QynM3L3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD02366542;
	Fri,  9 Jan 2026 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977018; cv=none; b=dCCxYKXsY9XzwFZXNRAW6Szh/C8Bze7WxnNifxoThs76z7Ro5V7NrH1mF9obEQmgCBn72IRwreXFJaNrq42OW6WHRELDl7ign0zkYL3LrGoTLHGNv5Yk1sRH42jJT94KPdWkp5B/g6mGHOvdCtzlpfYOwK2Znat13lWjjUwu9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977018; c=relaxed/simple;
	bh=VQSAVIj0TB1Vkbof/POXjeCLVeYxsyUNu+KGHjDjVp8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cTNDZYb3BhSi7KDBoq9Cw1r8358PhPMO/jettPj6jaBhE6pazoUVLpwhEksGJRUKyRm7w0TFP5V53EbiG5pmDO1maArNM9fkSGK9kAo8/w1km+lINpssTmUDZnWORXj5bX8FkjZKlesAYaKhTGOyH1/fbw8lqppJF6AvvTA1x04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QynM3L3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948AFC4CEF1;
	Fri,  9 Jan 2026 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767977018;
	bh=VQSAVIj0TB1Vkbof/POXjeCLVeYxsyUNu+KGHjDjVp8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QynM3L3WVOqR91uDiW0boDpg6tff6l+z39vIImWjjb/v7ylq72oW65Sglo1BhPgSh
	 05ap8xBzc+bdE7EwPhFVOm7Q0fEhFVB3saB03G4doBOHWNrWTId94Em82icoP1sAdd
	 XNPm2j4+1H6EZ3GamTwWe6jemFoG+TmZWTNP22hscgZBLQCh3VjfUHGixOlU5bWMEV
	 hHgwPDWGxnwZ1h1OJRa4ZCBE8Bdc6ldwn/3qvt1HTjeO+d3xKp4aeTMK4le8yoXZn4
	 Kn1oA6x6pPOOJnzYLXYNEaQpV4IFA5BVt0LcgI9iVjN1mAXegkQhh9NcMNwIMGgbCu
	 WM1qEJOvgRJZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B8E3AA9A96;
	Fri,  9 Jan 2026 16:40:15 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260109-vfs-fixes-221725170b4e@brauner>
References: <20260109-vfs-fixes-221725170b4e@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260109-vfs-fixes-221725170b4e@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc5.fixes
X-PR-Tracked-Commit-Id: 75ddaa4ddc86d31edb15e50152adf4ddee77a6ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bfe3e0da6e619dbf6157dfad896307ab6b9a58a
Message-Id: <176797681436.323012.640304372923352770.pr-tracker-bot@kernel.org>
Date: Fri, 09 Jan 2026 16:40:14 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Jan 2026 11:39:37 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc5.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bfe3e0da6e619dbf6157dfad896307ab6b9a58a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

