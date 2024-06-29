Return-Path: <linux-fsdevel+bounces-22813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C091CE1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 18:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3A81C20DB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43FC82889;
	Sat, 29 Jun 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDGK/5FB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25C1EB2C;
	Sat, 29 Jun 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719678662; cv=none; b=Q5k8mQeMUm2ticwfF8zPW2nBXsbZq0ayROxefwRuFEhp46ISnuOrh/9efIXsyH2AFc7wCD0B1QwoPrp+8HMqmoh5Lm5tSBMcGBvahnYe/KLho3JuHsH7dG5EN++02YWbiF11LHQ03lev4W3apoHEKlodutwIUIkHxpXqw2d1cyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719678662; c=relaxed/simple;
	bh=KqvoRw6McuYplQl+xWwA/O9yNyYsG2lmWyoa2c29pBA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BySeVrorkbgmZ/a3QO2vlTS/gCsUM+1cBSqdcQSWIHIhQxYltRVcQEEYkvasQJ4059alSKw3PLX54CTcCk385ZR34xP8+/LQ3GuTVjzNhVJgQ2MJbm22loY0/1n5Mv9OWVKy5o2qLgOHhSRHyktMQdXFsGOQzPyAOAwt0r9Xumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDGK/5FB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E872BC2BBFC;
	Sat, 29 Jun 2024 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719678661;
	bh=KqvoRw6McuYplQl+xWwA/O9yNyYsG2lmWyoa2c29pBA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jDGK/5FBwYlsg9n0pvMJ9ywW+x1QO1H1jQZgpy0+BBCloYAwlachGwA9u1ka8nWZF
	 NLvNAK9AMVS6fOwOrkNAY4+RyedX3XFQmrmWFV+aRMop6AQeDvJHWneUQvT55Aww0x
	 LaWPE9bmkOyHcZ8MeNSlplH4Y7x2sYHcoVtwr52gZpmMCAE1mdAj8NoxqLzyyeE5h3
	 kQVKQLv2bHiF5vjDOngmFzjJKdDVS36j6hCdeLMMmazWJoJc+fyAliS30WzDtwbk3o
	 Xr4OeZ4gZwiehEzI0IgnFg9Xt7vdiytIQpVqZ0bIE9yIHBaCiSVw5+OcOrijSYFu87
	 kkmBlDkGV1NfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6ACFC433A2;
	Sat, 29 Jun 2024 16:31:01 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <8734ov3jz8.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <8734ov3jz8.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8734ov3jz8.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-5
X-PR-Tracked-Commit-Id: 673cd885bbbfd873aa6983ce2363a813b7826425
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27b31deb900dfcec60820d8d3e48f6de9ae9a18e
Message-Id: <171967866186.13735.18073058379173068862.pr-tracker-bot@kernel.org>
Date: Sat, 29 Jun 2024 16:31:01 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 29 Jun 2024 19:40:16 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27b31deb900dfcec60820d8d3e48f6de9ae9a18e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

