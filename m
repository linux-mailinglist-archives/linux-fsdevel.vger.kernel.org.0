Return-Path: <linux-fsdevel+bounces-19835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B3A8CA349
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 22:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FAB2B21774
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 20:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2A13959A;
	Mon, 20 May 2024 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIRlE7li"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494D18059;
	Mon, 20 May 2024 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237006; cv=none; b=RkpvWQ4EvY0vJykWt85c16Vo6MKKCqHyppz4X9MBnOC9+yhn63sJ3INNpZVxwbeRfgPhpkKICPYWcqJgcIaMAlDvloEy3WOwbHxYjR1muMhngbiUK/Yfth1Z6+cYkHZ58mMsg93h5IDbcB/VmG2zDDghMOhNd87+n3/0Oel4hwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237006; c=relaxed/simple;
	bh=UePwph6L1JjRI0MymEGqPgW+3TEa/yu0yvkKEkY0ej0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=odkzP7OxhbHqXP3l30KySjvhfKzdugRXOF2fQ6w+/7UHdNXVXaHT751njlZqt6mMIYb6+9SSk1Mqh7PUdhF4w5zPJEQRDi7dDtD0j17uzgEVT5RpJc4+JAiZ9oUOGAro+xYqfurXyYPnFXsg2nVW8s9fg5OvM6m9EO7ntLco57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIRlE7li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39918C2BD10;
	Mon, 20 May 2024 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716237006;
	bh=UePwph6L1JjRI0MymEGqPgW+3TEa/yu0yvkKEkY0ej0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IIRlE7liLEn31zeyMcnirFhTE5HtrFLpNJ+LSP2kdzn1xs3TC4mDpW+A93GQLynGD
	 aUcaepnMRxEuI2B1rNY98r7DhNEtsv8v2cm4s6eZzVmBN70VdiSeF5U77whfqIV3OX
	 T1rnsBkkoOCvVrFuabKs9L2mEJmR0nzAN1+/NknQMm5u4nQILSUg8qZkPLRksYuN3W
	 mAx+k1Pby9Ugy0gLloDCJFm/9VaRk35Xxw2XxDbOWHUnWUQzDt6HZyPT8BmQ9dwRGf
	 PEIyVQ6PWb6HtbozZaqiYB5VDL2iXG13j8qWPcwiotYUbvgNrMgHEH5X6v6AuJ6xPO
	 SfIvawftkKWzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25112C54BDA;
	Mon, 20 May 2024 20:30:06 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <87h6esfr88.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87h6esfr88.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h6esfr88.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-merge-6
X-PR-Tracked-Commit-Id: 25576c5420e61dea4c2b52942460f2221b8e46e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 119d1b8a5d49138b151d3450ceb207dc439f7085
Message-Id: <171623700611.8142.11454315572627723344.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 20:30:06 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 20:43:54 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-merge-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/119d1b8a5d49138b151d3450ceb207dc439f7085

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

