Return-Path: <linux-fsdevel+bounces-28108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F92967316
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 21:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21A528317B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81B0A50;
	Sat, 31 Aug 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX8ntLxy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122746444;
	Sat, 31 Aug 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725131630; cv=none; b=o0hf7SOCZRfQ7FfL+4nhz8R5VKfmXUx0Uei4wwGEadvYot7/zi2a06hsRd4BByAY95mLY8liWeDElRAE0lVJabrC1XCXYcVdUVDVL+UgtHw4Bir+MDL8aJtXjTqz1PFwbawJBc4UV1kWB2FK4k381uTNhNqBMAnBTzFcFTn7zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725131630; c=relaxed/simple;
	bh=bA+TgE6GyBiP6XdJSvLrt2aQ+sD+003B3wqwjCMMnZ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EhUlcrsXsY85/PqMizg+rxsTDozPqvix1GIXXGoFHfBItHHdXE5aLVuwhFVSS+5PbBemXvscwm5AHk5HOeq9ovH66Yh9KNJvwfhsZkRWiislZG0t4lKiJFMw1f/z/nrOMAOgQOAldrlYx0wfCkvU6e0KBQB2pchoiiqLJ6S+m1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX8ntLxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A699CC4CEC0;
	Sat, 31 Aug 2024 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725131629;
	bh=bA+TgE6GyBiP6XdJSvLrt2aQ+sD+003B3wqwjCMMnZ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HX8ntLxyZduYSEEk/jBcQ4aFOtTWO8WnPLqYoMjyrsT9d1iBAuwrA0CsPE/P1E14a
	 FJ1izrTKHnUZmSalDRClVkQ7UmiCujBcP5f8FL5cW6gbNAfsUtDLhTpBIT7kag+qQS
	 1hBWBUdazfl5I88v3Ab3qLzW0/KwShbJLm5TEePd2gT0V60HgWExtGOa8rDGpcTq7B
	 2PcjjQAXNsLVtgifCqa65E5DWe19XAqpN6l9S54E56RriNjbr3Bd5xLGJtlnOfsfqW
	 0bhk57j2npkjOzSEMG+xitfnI0l/P5BIuURirKd8VfCoX7TbTKQUo8CRUVazxvVuek
	 M/MfwdaEqMqzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7130E3809A80;
	Sat, 31 Aug 2024 19:13:51 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <87o758so6y.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87o758so6y.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o758so6y.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-fixes-4
X-PR-Tracked-Commit-Id: a24cae8fc1f13f6f6929351309f248fd2e9351ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0efdc097965bcf60d1db62f100ef544714714e88
Message-Id: <172513162993.2915779.10899559352924721295.pr-tracker-bot@kernel.org>
Date: Sat, 31 Aug 2024 19:13:49 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 31 Aug 2024 20:59:46 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0efdc097965bcf60d1db62f100ef544714714e88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

