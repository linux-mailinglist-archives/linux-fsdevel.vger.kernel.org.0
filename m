Return-Path: <linux-fsdevel+bounces-32944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0529B0ED6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570C31F21382
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E1215C46;
	Fri, 25 Oct 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYSh3TxA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91920EA5B;
	Fri, 25 Oct 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883922; cv=none; b=Pz/gvMg5FeTcZXfcSjSP8X0kD964+vAkRfRNxsi/MEXqcw/v5NmoQo6Xd/3Q/6caEeJxKmnHLge/SkDgbf60PNITiqbozOFPw5Ed34lKVDjP+qzrcFh0+pqeCwnxAW81IWmrWgeUgTcVef9tNXkkYe0Grvyzk5RYA3YJ6mNtbjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883922; c=relaxed/simple;
	bh=rPO+rpkNpPIXarZtqhDLSNugzDNd0QrD1f3cQx3bQtc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YKMriAb5cV0uwhoMkUv/UwENK8t/E4J8K/tALv/uEArfn0uyedMH3r8fszc/257llZv6na+hwvioVn9RTpWXSR/FAU9yEGNkBQO5ruscTGaoRu/WD40fcZHJWrPhm+4jCxs1KVkI4yu2DSdI5nwo3odsaF6K+iF9423iv15iK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYSh3TxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979E0C4CECC;
	Fri, 25 Oct 2024 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729883921;
	bh=rPO+rpkNpPIXarZtqhDLSNugzDNd0QrD1f3cQx3bQtc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uYSh3TxAsLXIfaspgKvbOgcTyupIJSXlzLSA8YejTot2EXyTBWbGjtMUYj3RpZKqM
	 z8O/1IAJi+zOn76AOjJDSQ2HGu3BY467K/clSH26jbfn6sgIpVud5ecIqS1n6FHEPu
	 OsOHB649NOXtxbjZEAPphiS526boNV76aHbVVPCzBv/OjM1U0UXDs+N+AMI2amwBnJ
	 dcT4TBrel6S+nM42mxVcx+Yd3xHKVTGLn85Q4WLWazoSNNooOQObkpN07Yc6KOUX5f
	 rnjhCOe9i0kbWdRWkhvLVP69yu0lIbMAIHk2jLf5Smik0brvyQoc0l0yjn709ZRoi3
	 XO+Ja0JEVsuRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF8053809A8A;
	Fri, 25 Oct 2024 19:18:49 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegsjHymOXg++KGrwMUWAP4e18aqWCMC2e83hLBy2AvYZyQ@mail.gmail.com>
References: <CAJfpegsjHymOXg++KGrwMUWAP4e18aqWCMC2e83hLBy2AvYZyQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegsjHymOXg++KGrwMUWAP4e18aqWCMC2e83hLBy2AvYZyQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.12-rc5
X-PR-Tracked-Commit-Id: d34a5575e6d2380cc375d2b4650d385a859e67bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81dcc79758cd0c0cfddf539bbdb6e7307053fc0d
Message-Id: <172988392843.3013963.1963777504036569634.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 19:18:48 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Oct 2024 17:30:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81dcc79758cd0c0cfddf539bbdb6e7307053fc0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

