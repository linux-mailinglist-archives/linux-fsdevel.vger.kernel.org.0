Return-Path: <linux-fsdevel+bounces-48795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081AAB4A2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 05:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE777A2395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 03:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2191DED56;
	Tue, 13 May 2025 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egtg+2mB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89BDD529;
	Tue, 13 May 2025 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747107163; cv=none; b=JM4adJcU9V5iQ3LACqHQLuIjwComchRNC/MkO5A7Wv5D+xH6A1EpBPPo+MXdifXAkquliMLt5nk3sF6IismYVs/58RDSWrJBzLMfLzVTIHk2cbiu+xT46Z7FpkqpCmAyaAf+YcVf36aW4E6kjiwJckOM3OV7OQhuPguhFkVA7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747107163; c=relaxed/simple;
	bh=jf+c6CkllJsEeeSEs1uL0F5V7YOIJiyJsXTD+Kyc9QE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X2nUTxTzGAwP9Luzf3PSHv/oVSiK1PxRJLAm9FTMgp4xPHGhJG21WEiCWnwYJZQ9aNi0GsFEKQAD4BYtF6Ix3xpRO/3mRxUOSzzcaZKHewxwyuO+8g+FqKJGpK0rY76G9282hiBIo6Zjjp5oxX16Ra+c4lYr0pqcrHpm43egygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egtg+2mB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA2CC4CEE7;
	Tue, 13 May 2025 03:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747107162;
	bh=jf+c6CkllJsEeeSEs1uL0F5V7YOIJiyJsXTD+Kyc9QE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Egtg+2mB/Z/QXGCXKdLegwSV1HtaRmvSRrWhDN3TuNO1d8k4zjMsYOXmZIZCPySJ/
	 X9ckLlc3sPjk89Utlx+CppOg8NvDQXwd9do4xirJJOiHvfTS8oxMClHMnY+0w6bVdr
	 PJ0QP8rRyBKiafVJCs4Ex+GFzdPd34drCQ5XmVPwaoHRa5HreYJHnTOpBvCCnenfpt
	 dpBdjgqspcixg8KNNx5TT4WNi+F7k6G2wvhjX3cVZ6BDj/MGteO9s2xs7JdTHnvPbh
	 mytkEiKZoIZxyy/wlDAdPnRHweB2r2JYCdnA8mAGS0qFfDfXbDrt6Y69jytdIoUX3j
	 LLgYuIDiInNHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB039D6541;
	Tue, 13 May 2025 03:33:21 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250512-vfs-fixes-5cd1f86de6df@brauner>
References: <20250512-vfs-fixes-5cd1f86de6df@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250512-vfs-fixes-5cd1f86de6df@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc7.fixes
X-PR-Tracked-Commit-Id: 04679f3c27e132c1a2d3881de2f0c5d7128de7c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e238e49b18ee1bcbe4de952d06631dd3beada097
Message-Id: <174710719983.1163096.11611103812175966513.pr-tracker-bot@kernel.org>
Date: Tue, 13 May 2025 03:33:19 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 May 2025 13:01:54 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e238e49b18ee1bcbe4de952d06631dd3beada097

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

