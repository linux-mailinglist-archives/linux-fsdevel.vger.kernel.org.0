Return-Path: <linux-fsdevel+bounces-33030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87BA9B1FC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA82D1C20A3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01FF17E00F;
	Sun, 27 Oct 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq5czcgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273BE17D355;
	Sun, 27 Oct 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730055401; cv=none; b=Gs7uHaHgBbAFFCEYpQBhKNe3qAxrP7RQ/xVkbRA4GcJiYU+ai8GdqHXa6wy82pQljFhwONg9jfcg9NPu/n3gvstxG0EfR2KmvfYP4a/0Pjo+5E54b5qiT84KNQSIb2zLB0hO4DMUMeA2G+sKXQZWZ88HdP/Ug5wGTSNwLs3aofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730055401; c=relaxed/simple;
	bh=g25Bw9eO/BilujowLVnRiN34rz2B0WRoSwTsMLKdxXk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s4sBD5AW1QJKGhwzjjtT6+zcZ9lYPrK7r1tpgWFYjRhPaUdKy5naK0WCehjKVPMVVRnwrGqvcNSLMpIZxlfL186zhNVedVBRR1UwE3JOa8iW5nzi0Avh45CywMzY/7uEXKyxNTq85PpAAs6cTDoZe2vu+sqPh/VEIq0LnAehseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq5czcgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DAFC4CEC3;
	Sun, 27 Oct 2024 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730055401;
	bh=g25Bw9eO/BilujowLVnRiN34rz2B0WRoSwTsMLKdxXk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Tq5czcgJA4WPB5PSoau4J7g5IP6O+O2OKKPTjpHg8XfoqEvfyMG0rX2hMg2NKfqLa
	 VcrRHIi8p+Q3aF2yvxSWr/AgY/SHsoSC/wERQDsLXc98m2bIaZgvnUb74kSFvNOC7w
	 J4i7yxnv3VgsCEEu+vuAomVFJTZ91A674O0743d5zavallEYv/sHfHyR31Zs0reozb
	 tlWZZ6lmv/yUk9pdnxhCcUTgPRBKnZjWij9vZUJ7Xrfw3coQ+VGHtgTtTjzWDjbAUi
	 x9C6UIc8DEjDdus9eohCcO+Wg2/IoLj08heIBELkM7OmWvx+R+kSOFIbXLaTdQyhlC
	 KQuBBXhDlw+eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EBD3809A8A;
	Sun, 27 Oct 2024 18:56:49 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <utvsskliarptudc7dl2c6vmgurm7kywhzdagm4zbdolo3rxmtd@bwqub7ivgmdk>
References: <utvsskliarptudc7dl2c6vmgurm7kywhzdagm4zbdolo3rxmtd@bwqub7ivgmdk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <utvsskliarptudc7dl2c6vmgurm7kywhzdagm4zbdolo3rxmtd@bwqub7ivgmdk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-5
X-PR-Tracked-Commit-Id: 4a201dcfa1ff0dcfe4348c40f3ad8bd68b97eb6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8b3be2617d677796e576cc64d4ad9de45dfaf14
Message-Id: <173005540808.3429718.2131394417056747419.pr-tracker-bot@kernel.org>
Date: Sun, 27 Oct 2024 18:56:48 +0000
To: Carlos Maiolino <cem@kernel.org>
Cc: torvalds@linux-foundation.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Oct 2024 09:25:00 +0200:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8b3be2617d677796e576cc64d4ad9de45dfaf14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

