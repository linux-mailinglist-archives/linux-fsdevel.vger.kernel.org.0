Return-Path: <linux-fsdevel+bounces-29457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F7397A00E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1311F22C46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFAE15B96C;
	Mon, 16 Sep 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU8s9Q6S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD68158868;
	Mon, 16 Sep 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484994; cv=none; b=LLNpDyMkuukwDvB9socqqjWQcg2def/SjaGRXp9wIf8wCUyQ9njv3lv+js17fu4czSxPMWZQwcFTCl2UJcImu8HuaQcfITfEsOv1McCmUCT02tC++3Vt37bOlY5rWUD0TjhW6YN9BepWwUst6vDoo/XKFpJMmgIHRSF9l0kIMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484994; c=relaxed/simple;
	bh=1lhW+C7mMPNC/tmSv6mHtAEtBFLovd72N7wYqJZ+XuI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=khCnTESraMcAuwhRgDlu6PuQgmGEEa441YL1Soo/gCUyZxPRrFWU/jUSqfiCvU+ktOVlbMgkIVu68Tirsma9KlhfEj1y6s0Thdz3nbXPCAlu5nH7GdJa2xFSybZqXqOkvTg1Q99XKvVzqrjRFZ+4wpd2gSbLIG4K1F56KZXuwQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU8s9Q6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE060C4CEC4;
	Mon, 16 Sep 2024 11:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726484993;
	bh=1lhW+C7mMPNC/tmSv6mHtAEtBFLovd72N7wYqJZ+XuI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NU8s9Q6SvCc+py6mxl4Yu1J5sGpOgvAQQ1lEvw2hj9QiUivqlffDWguACBw2txAdy
	 PY6fqTY2t3a5bq/5x3C1VUhcW3kDKo2rad4e2LoBs4Qbs31Y/Xh7Ouh7IInWh4VUiy
	 YSERfv6lcH7Qa1xqdac7JbyF7BEZMh5A34aFJAj9kOVEJbIlN6aE9V2vSbC9U25A3h
	 2Z9HjT1QQbpxraHozSdYHx1a/vjMXaoWs7rSIUsr+YzBWnfj44stGAHCLJlFU7LMRa
	 kSAUV295/2BvqT9r6Yw0mKlSz7W28BdddWmoyKEQ5DQa41OSj5QTh0mEHv+uYBnH7r
	 DNQeEQuD0xNEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC5A3809A80;
	Mon, 16 Sep 2024 11:09:56 +0000 (UTC)
Subject: Re: [GIT PULL] vfs netfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240913-vfs-netfs-39ef6f974061@brauner>
References: <20240913-vfs-netfs-39ef6f974061@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240913-vfs-netfs-39ef6f974061@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.netfs
X-PR-Tracked-Commit-Id: 4b40d43d9f951d87ae8dc414c2ef5ae50303a266
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35219bc5c71f4197c8bd10297597de797c1eece5
Message-Id: <172648499536.3648068.5760539824850773698.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 11:09:55 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 18:56:36 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.netfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35219bc5c71f4197c8bd10297597de797c1eece5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

