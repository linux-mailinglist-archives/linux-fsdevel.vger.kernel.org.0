Return-Path: <linux-fsdevel+bounces-19482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD70D8C5E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 02:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650091F22425
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 00:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BA779D8;
	Wed, 15 May 2024 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nESU6H60"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982163B8;
	Wed, 15 May 2024 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715734388; cv=none; b=GqTeJ3RyLG8PURlcllPCYBTxbrvviaFFU9k3LQBSO/TinnlQFow0bpU+XO3vZWxtxetfziA/AH0bZyal6SX0mSI4JilbwbiG4TN7y1X6iBRGBTfx9qp8k/9ulQsYl59y45L6DvpCMvzsq/vjH3qh0EzIxwsGZIE1enOxIL7+f3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715734388; c=relaxed/simple;
	bh=qKv7t3Of+NOnuJirON2reDUkkCntEy5G+MXtbfHCf2Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LYRGRNEptW3jvfZT95AZ0z7Q2mQrBNTVSqBJ2UDd6Mjhuv1AiWUW4GvIOGLz59f+R6ZKsSZTJa8dY4MUGCFzTWfM13N39Uhq4mPje0wLC93HUmHMOkIdkGU8c2tLoLfRTPGcfssgzjzIU9m5UP4Qkc+6raWmkdukLoWVelKs4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nESU6H60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49F4CC2BD10;
	Wed, 15 May 2024 00:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715734388;
	bh=qKv7t3Of+NOnuJirON2reDUkkCntEy5G+MXtbfHCf2Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nESU6H60QhnyHLJQKOcjW0FIkwhCTz3sHuSIMT5ZT9xFbcQklpMEpd74Y55q0SM9L
	 hLCe1UYvh3qq8jlijlmHFOYxus1kyx15rZw/BkN0GON+8RI5jUnoCty2yeE8JbPvKg
	 mRBZp+/qx/KO/7IAhlYy6baIXGUOoJ8vZK7eWP1qywVklslVcFbb+RgiC5NEwxXQcL
	 D0ojJ6KjvWFFu6dNeEWwhPROzdn4DPddhXeRrr/q0eTr2yWzuJXeEsiJC8MRCBuJ+O
	 gjj0B/W0A+4vgB2upPQXMLzW0sBstTkWqKnLdaLz6sz2f9kCiYOlg+RWiQvLe6MAB8
	 y+ISBhubHQyMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36FEAC3274D;
	Wed, 15 May 2024 00:53:08 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity update for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240514165757.GB2965@sol.localdomain>
References: <20240514165757.GB2965@sol.localdomain>
X-PR-Tracked-List-Id: <fsverity.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240514165757.GB2965@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: ee5814dddefbaa181cb247a75676dd5103775db1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b47c18232a85ae064ad923de402f0a21d46155e2
Message-Id: <171573438821.24206.7087305668109588116.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 00:53:08 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 May 2024 09:57:57 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b47c18232a85ae064ad923de402f0a21d46155e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

