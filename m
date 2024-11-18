Return-Path: <linux-fsdevel+bounces-35126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF69D193A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3083283D1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632CD1E908E;
	Mon, 18 Nov 2024 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFhlIlDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1D1E906C;
	Mon, 18 Nov 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959337; cv=none; b=WcP6E/m15Wu16wqFyEkN8dRcRNMfTXFt/r/CWwyEY/KcOimUSu/N08OO9ILYfa1cCn6lpHmqGVdwlnnwRPdaX5eIoKJg7IdsvC2vT59IGq/vwU1z6Ww7pcwnyopmsPrYdSLuSdP2UXKe7LKS7HexYp57myO5jBYQYA9LFGGOAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959337; c=relaxed/simple;
	bh=VTLugdwYB43ti0hrGQ2L0StZkKLxd2jejRzPrpGiaG0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lU6Vrmxpjt/JtvYgQLFnC/foIgJR5Rt9gEUHl3vZW9feJ2Ze1F46pZ0oLa7JyL7xKCMj/MO/V4WYTD2XhVhpiYjWPLwBglAjyQrb7vrSmpfnNxgLn2Clo92e5UDG3Hfxj+zQH1nKaunC5Nue1qaNeAS5ZjR8e0DJiJLjfkYVhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFhlIlDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0EAC4CED8;
	Mon, 18 Nov 2024 19:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959337;
	bh=VTLugdwYB43ti0hrGQ2L0StZkKLxd2jejRzPrpGiaG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lFhlIlDAX57n6WickFGD+8JqjQHCZCmjodA/Ee+fJOd1eejMDnWbdpvDfCF5gBCv8
	 4moEnN0tWSFyuZHMUq5RdF1w1zRbqwt82C3NoKx89Q5jztSWU2ofOsuMmFkSNdDRK9
	 vrso4l5UnyG41WY/rJcvjzrqdbHzarZas41Ou3t0poe1930dRnQ0iUrz1Uww7jBT4b
	 h0N8Q1lYeRhxYu6kuCGILSmcwnpEb8wp+0t+34eZ1o21VqnqkuwgqtV5aTxjSjwEFJ
	 +zKZVfus8QuzOkzp6cRPgJtF07KkJD0TNjyOyTMF9x8IldUQA9LyPgyI6pnkhNH61o
	 kyR2qpyveJJ/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 300623809A80;
	Mon, 18 Nov 2024 19:49:10 +0000 (UTC)
Subject: Re: [GIT PULL] vfs pagecache
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-pagecache-a00177616c8d@brauner>
References: <20241115-vfs-pagecache-a00177616c8d@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-pagecache-a00177616c8d@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.pagecache
X-PR-Tracked-Commit-Id: c6bbfc7ce1567eb7928f22d92b6ad34d8e4ea22b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56be9aaf98d58bf69e2c948c183001d77e63fbbb
Message-Id: <173195934907.4157972.141546675105073552.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:09 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 14:58:59 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.pagecache

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56be9aaf98d58bf69e2c948c183001d77e63fbbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

