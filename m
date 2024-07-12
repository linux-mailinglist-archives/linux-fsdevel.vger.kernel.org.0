Return-Path: <linux-fsdevel+bounces-23621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B492FE3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 18:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723C81F24FC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD61176251;
	Fri, 12 Jul 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiLRUpq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E290217B031;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800351; cv=none; b=YR+VHI9HlaOb1tZPDbdVA266VmPybVLPHQaV0uzm8hwrDdybNK7qX3MKCy2nXiep4A7HNQ8nLeKAI+r2vSXXyyTynRcVU4T0DD8ym+mm6T8m1x2c4NPPRRMndZlSPoqIXi9GOb/t3t/+iRaCwgGi+gFNf72pK/Wztr0sYWn9LdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800351; c=relaxed/simple;
	bh=vRwwqMTq3lQQmi4rOeDxwucZUJwrwbgL/4BdZf/iumg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s0x+M+lMYCKrKYZA4uYy+vexrKZQcHiw9HgV4cq9uTGqiY2Z1C8qbX5wqeK5tz4w3Mni0m0iI42SYfg8IcxnPK0sw7zSVx3K6JNkGD/o4IRcqFio6Pb1QY3dKv0O00tiJ/PikMQdzXg54tFxFRp1PUDq1/QFwm+BsjiPLqRupVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiLRUpq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C648AC4AF07;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720800350;
	bh=vRwwqMTq3lQQmi4rOeDxwucZUJwrwbgL/4BdZf/iumg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QiLRUpq9l0CUIyt/qXfKCEVftmnQbWMtkyDzqVQR7xO9lzjoqFBVFxXTVOdWBHaqA
	 bhqs/pCQq5azn42drpuAjs8JWMu9NMlCnCdZ559OkjDk2ZnRkOeSBh8F9dbb1IuHHv
	 MdYuafmRhH5VzWl5KFSdUmbDdJdRmQ0m7vypKD/IvWd4UAUgDDLR0SucarIdQnvcc8
	 UPFRtCih8N/77j05bqN29F0Dt5wPrxpOjc67lCMTuw0QVO865Wtnu9Dk/tUTgVbT0Y
	 W0JcvmpWqw8New34bIgbxrtcHRo1Wkd9gAJFH0mqqU9nkwGXwtdeRVcadICKhymEq/
	 S1+eqZqz4bNBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDC04C43468;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.10-rc8, more
From: pr-tracker-bot@kernel.org
In-Reply-To: <ibddimatjnhtx5efnlbg7oyr6dkfjpes5nvwflfdtxilxiwy3f@o6z5qql3kjn5>
References: <ibddimatjnhtx5efnlbg7oyr6dkfjpes5nvwflfdtxilxiwy3f@o6z5qql3kjn5>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ibddimatjnhtx5efnlbg7oyr6dkfjpes5nvwflfdtxilxiwy3f@o6z5qql3kjn5>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-12
X-PR-Tracked-Commit-Id: 1841027c7de47527ed819a935b7aa340b9171eb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d4c85134b0f76f72f975029bfa149e566ac968f
Message-Id: <172080035077.10368.11849977804916945402.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jul 2024 16:05:50 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 11:11:54 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d4c85134b0f76f72f975029bfa149e566ac968f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

