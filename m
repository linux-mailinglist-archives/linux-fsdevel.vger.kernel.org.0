Return-Path: <linux-fsdevel+bounces-23872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E949A934321
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D831C215D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625B01849CC;
	Wed, 17 Jul 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOKIlTdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF91D182A56;
	Wed, 17 Jul 2024 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247507; cv=none; b=U15BxGgyz/YQPcVzf5gMI4Sd+RWjlPO65pu+6Ejh2DokiYAarY3Btaq1tFEucf4vjQXLN6XUcwwQPVh1Ryo4ydUDIHhx2GfCemaiRXsXccCtplWSMMdKcRY4NzGAc0UiMTyxWQ2wgYEYaYflcWk2zD/VYoBxMF/OX82xOpge8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247507; c=relaxed/simple;
	bh=PIYyH4YPkVMq39QvAiJaY4C0WJotWAyrOI7pJ8QZpns=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DG9bGsa5dFCIZP+vWZZyfdqYBOBQWemC4rcXgxU01YLNuCQlaGptU8/mxekukxEL1TDwpwXR7+yhimekyFvv+CN3synR2iy+wlfrnQ1Oz/6Ti2cs00qKr1gnmjbHQ/Pyqq7SFqxrIyYKy7qreqmBt3GQNqOIqriEyMCsHbiHZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOKIlTdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64BC7C2BD10;
	Wed, 17 Jul 2024 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247507;
	bh=PIYyH4YPkVMq39QvAiJaY4C0WJotWAyrOI7pJ8QZpns=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iOKIlTdcv9YkhMELFCArIKZzkW0LMwZDP0bIhx47X93HkwBlg2OPc6PD5js6Ygh71
	 PJH1xFPIoWhpJTCL71Bpvjj0OarpM/q4HeJXQPQehX6M2rjIeZKaTwZ3ovrxKdzLz/
	 Qp4SEAvSLOPJ7Ox3eQkSCfhX8bWL5346s4hVN6hRI1L0t++cCL548WlqmlY/QqI4YD
	 SR22DjPWtEgWS0M7W5BNGw/+VerbDv0ShhM6UFMym492vEzZRtGYiHU0ahq/4IomLG
	 /Vzu4/at5PyOPkW/KNKBn4nTpK0/v8wd+WxdF+H7szpW8XLAsoRduAtzzApJI1TdC3
	 ZYJLFCby/YCVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 585E6C4332D;
	Wed, 17 Jul 2024 20:18:27 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1721044972.git.dsterba@suse.com>
References: <cover.1721044972.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1721044972.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-6.11-tag
X-PR-Tracked-Commit-Id: 0aef1d41c61b52b21e1750e7b53447126ff257de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48f8bfd4810e5e2b5de40328aa007733ce3372e3
Message-Id: <172124750735.12217.11235252307845861224.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:27 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 14:08:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/affs-6.11-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48f8bfd4810e5e2b5de40328aa007733ce3372e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

