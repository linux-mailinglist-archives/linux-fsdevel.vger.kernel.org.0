Return-Path: <linux-fsdevel+bounces-9004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA883CD09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 21:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49BD1F22C52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7539313A272;
	Thu, 25 Jan 2024 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IELcUqpE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FED1386DF;
	Thu, 25 Jan 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212813; cv=none; b=tut/AvrtH+KqBoBCBiuTJnjZJPPyGTxW6Smzvhh6k4HBYJiUQoBDtCqRXmC01CXf6N7JTb0tfhcZrBBResznOnRMwpq1pIULBKNHJeEIMvcCGqpT8eaUAgECnSUk+gCXx/JsLVXogKah68hBSbmroiHoABihSNLdrEkbaeunmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212813; c=relaxed/simple;
	bh=95Rsq7lrf1CgkYaeKADxzoBQbsNcjbn6lbFoM6eS4hM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LZMSdfYnzcR1lrYKVNb3z6oO1lpXwSe/YzH//yJoi/ZuGAXhTdvJgKGIc1jo+VbOnNlKbuVT1ax8exsK07mkjpPZ6cSKQWMpJA/+uGqRv+0chMjmOhMo0RdH8jjJQPmVrZAn6ypiu5VwiFLutfXcDsJalYHw52YwEDSkg95TDDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IELcUqpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AB1FC43399;
	Thu, 25 Jan 2024 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706212813;
	bh=95Rsq7lrf1CgkYaeKADxzoBQbsNcjbn6lbFoM6eS4hM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IELcUqpEdB9hDvjYzvp4cUlyMe9mOHgeinJvWu+joa2RzYvmkIl/F8GAX6g7jFvPc
	 ChLMbJwDviG0uPbPzgyeYK89CIAeGR6DKt4M2VkLfQgHpfarqXGxovKR3japorGcXV
	 RifibIp9n5gWm84pD+z0pPdQPYmkk7neWMatSnN/7k5KzjShnL1YDDuxWo2+u/Yow2
	 O7dj4tkxOESZly+4MXRe2mbok33dhh9Dw5NVYSrZHM8lEtS8Wuv30swM3eBHmg63qQ
	 2QEWj4lN2DRhW5uLoF1ZFJC2XMpjKN2mdUkj7zwFsLW0xs8ssANUHf3R3gbKwEPc3k
	 8cgzgxIot8hzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85AA0D8C966;
	Thu, 25 Jan 2024 20:00:13 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240125112308.753888-1-amir73il@gmail.com>
References: <20240125112308.753888-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240125112308.753888-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.8-rc2
X-PR-Tracked-Commit-Id: 420332b94119cdc7db4477cc88484691cb92ae71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdc010200eb5e2cddf1c76c83386bdde8aad0899
Message-Id: <170621281354.19358.13513690322408630710.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jan 2024 20:00:13 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jan 2024 13:23:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdc010200eb5e2cddf1c76c83386bdde8aad0899

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

