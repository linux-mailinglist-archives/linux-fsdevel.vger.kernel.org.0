Return-Path: <linux-fsdevel+bounces-35134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCFC9D194A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE149B23658
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0011EF938;
	Mon, 18 Nov 2024 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amY6PXNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDF91EF924;
	Mon, 18 Nov 2024 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959349; cv=none; b=STF00CHSQhgUn5gwxeGpNiHck4uLYTk1+IVjP8/kJYBpX5YW/Y1mjiuHQ/P2FjHpdoUi541gn/+2YRZYZTAbUrdpxs53bHd+vfqZOTOP1ojchnmONIV1TTiA4JEVifcXZxzcl1HgnBRKsAyEcog2jpl/o0XeKB2eRsd+ll1s77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959349; c=relaxed/simple;
	bh=oynhphxXJ5jGiyBOXsVidn0Qgab/zsVE8B7DtzW5c5I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f8Qp1FHBdphEEDacas/WudfpwRmsRBMQCSaHaQybgHmlktjvm0PDJjFQLbNoCCk4U9/4HAMXQ5Omvx35/2pYrdNS6S8P+9MyASCtJ59bPPJL1x1BqagCLA2HbKiZyMuP5epeoBgd7UZoTPQ7/A/XwbvtRJFwCz1k5GbjkilLZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amY6PXNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0A0C4CECC;
	Mon, 18 Nov 2024 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959349;
	bh=oynhphxXJ5jGiyBOXsVidn0Qgab/zsVE8B7DtzW5c5I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=amY6PXNTwhLoYVsAnQfGAK44x0mhztd4cyC567gOJZmIMeJank/JBfhbrt7wSNMXm
	 h4sHyuVjERjZ0LLh5OmG+mCTlRoCIrp9hxkNTUM0rlkAFn7zDoLCGlwDjqsoa1yjUv
	 BbpAt75T0FjblgoLuwnWo5NtkYzgFZs2h0dvX6lYjAW+TcEkArnYC/t/fsZrIC6L9+
	 KtaLJS4+Q8IR4jRz/8QCz9bR66NklU4s2YLxvOH8n//qK133FMInmZUNzpOrUqxbUB
	 FCrXYxwWyn8hKlVy1dNNG4V5il+/IBwMBbVH449B4htzSoaZMT7iSXh2iOFLpwcTgo
	 fKyGUg4abe/Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341413809A80;
	Mon, 18 Nov 2024 19:49:22 +0000 (UTC)
Subject: Re: [GIT PULL] vfs untorn writes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-untorn-writes-7229611aeacc@brauner>
References: <20241115-vfs-untorn-writes-7229611aeacc@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-untorn-writes-7229611aeacc@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.untorn.writes
X-PR-Tracked-Commit-Id: 54079430c5dbf041363ab39a0c254cd9e4f6aed5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 241c7ed4d4815cd7d9c52c8f97bf13181e32ca29
Message-Id: <173195936080.4157972.6109184415746933540.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:20 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:09:21 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.untorn.writes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/241c7ed4d4815cd7d9c52c8f97bf13181e32ca29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

