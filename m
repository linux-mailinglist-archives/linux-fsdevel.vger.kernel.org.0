Return-Path: <linux-fsdevel+bounces-44913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF957A6E502
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0F83B6352
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3501F5434;
	Mon, 24 Mar 2025 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arErUfNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC11F4E5B;
	Mon, 24 Mar 2025 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850041; cv=none; b=iqPgLpzBWptgXNhrarQRuxu+f9P+tEw6tEzrCCF4bw1RdQA7fzY0KHpDoEb8vY9boqYXJcjIN7FhoqUAt5L1M1EvIEefuk9FJTmrMoEWW5fK/Oe8pCpbC0cjyGcUmI08SGPNjmcMPF8hawk19g4ddD87JRxZ6A0IhyI+bQ8NUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850041; c=relaxed/simple;
	bh=dxG+4vY+TPY0b3NyP1u5/DmWYKBS9eMNRkfIy4t30NE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jBtQoagzi7fjUK0EcNojVEPS9PIZHmZhwcXoBq/kYfIB6uBVpzSVu1WsAoVMKeri2jJ69J3r9tHi7bCURkkMoj02p+BVS+Hn9DNXChaQMXU0QpxxapaQMgULpaIwgo6KbZKjTwIeaNV8L2RNEZbajwZTbfZwtvSC75xDQOUTDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arErUfNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB45C4CEDD;
	Mon, 24 Mar 2025 21:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850041;
	bh=dxG+4vY+TPY0b3NyP1u5/DmWYKBS9eMNRkfIy4t30NE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=arErUfNo4ZciE7thqsPEBd10I9zi743HdiaWaXWgTjG3mBMPVG2iMj48UgR4Yq5++
	 ZOHdqnfssoSnmtxGO80V+WdbzI+/sjJJPtCNmoLQwnc42IJlWyM0mp6j6hjEiPZEqx
	 ukXMby/0dfhSUfqNe34BP62rajIF0BasosnvFXu3pd4ycBe4DutzQa2Z+iUY65tKDX
	 vNCHoXNc9LSKhu50gXzU/SALyMzpUxDga02R70daG45id9HNacZKTMhR2i2jZ0IOtM
	 ZhJk68oHWJqG4FLyy0zqFx5jTkZ5klJO7ZGPEg7mSwy1bMAZlj1JY3Vk1AnXucbIiL
	 g7fsa7GtA7BIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D481C380664F;
	Mon, 24 Mar 2025 21:01:18 +0000 (UTC)
Subject: Re: [GIT PULL] vfs ceph
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-ceph-81a373556110@brauner>
References: <20250322-vfs-ceph-81a373556110@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-ceph-81a373556110@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.ceph
X-PR-Tracked-Commit-Id: 59b59a943177e1a96d645a63d1ad824644fa848a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e63046adefc03800f1af76476701606bb148b49c
Message-Id: <174285007781.4171303.9165962459471555390.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:17 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:16:33 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.ceph

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e63046adefc03800f1af76476701606bb148b49c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

