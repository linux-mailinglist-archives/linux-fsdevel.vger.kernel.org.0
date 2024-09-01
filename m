Return-Path: <linux-fsdevel+bounces-28143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C651996746D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 05:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C06E1F21E1C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 03:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D752C6B6;
	Sun,  1 Sep 2024 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj2jABWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860491E517;
	Sun,  1 Sep 2024 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725161445; cv=none; b=Ad4SwRmcpS324sHcp6pMkeK+/wiOQ84IvcQbc+saXNqinbIvD0tjGwXCgGtoovy+xq3W62Kdh3gvKuAGMcADFZOYu3kvEPCPnfpTkwy/ZoEez38oYhvEmymzCIEQjxdzryzoqoNUnUiH+E8Ltx+Rriu8rkRZxKGgYydh1SUERXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725161445; c=relaxed/simple;
	bh=H6bUb3fvMza0409sdDpIXlZxSUknbYhHbk1x16WUAeA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aJYsx4oONW+rjlaZsJZ5KZ0BhNT+3VEgLLGzYMPKf5vrilQuA4HRlYhnBwx0OcabEXp63l72mspHu3EN0Q/h1XK7VP1tg57FHgMEKw0M6u5REzT7xtkHOZmcQtVLwix5VG9UZIuUMjgTK1yioOHrQXeZcZa9K6pxMOVa5ezv5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj2jABWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F28C4CEC7;
	Sun,  1 Sep 2024 03:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725161445;
	bh=H6bUb3fvMza0409sdDpIXlZxSUknbYhHbk1x16WUAeA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Dj2jABWBGck1uZZPgLaHL8X12nqH+JCETWjgh+fY3PGILhiMDGfDSPavUJfWwr8Xb
	 F8xhvRE1Q/bISCKr96K/vUuUA13j5jYTS9voNI0HQXSb3Q2DoVlduIJ7Rr5ftLukV5
	 vVkx/EO8BKBU7VxQE0Wd7sCACcTnFdgGgUOS/l6lCAiVBPeAwxZPNRCC42TuS6tLw0
	 HkRqyp8lwWAvgQLVgd5CnW74qkm/hwLT1IEHW482O3qkocN94S3PA6LJYR583HcjVv
	 2CQ2+Ia8AG7hLcOC+KXW2x/60QNY5o3ggGmUjg9Vhzil6i0wCetuhigKH1CTlHomCr
	 9n8UngusFvnWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E053809A80;
	Sun,  1 Sep 2024 03:30:47 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
References: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-21
X-PR-Tracked-Commit-Id: 3d3020c461936009dc58702e267ff67b0076cbf2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4c763129fbcc7da5d3134ea95f9577f25bc637d
Message-Id: <172516144577.2972343.6622153521853791516.pr-tracker-bot@kernel.org>
Date: Sun, 01 Sep 2024 03:30:45 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 31 Aug 2024 22:44:08 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4c763129fbcc7da5d3134ea95f9577f25bc637d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

