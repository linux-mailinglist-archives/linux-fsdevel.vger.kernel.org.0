Return-Path: <linux-fsdevel+bounces-56216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932ADB144F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE71AA1686
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B3124C66F;
	Mon, 28 Jul 2025 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIvIc8qT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454F82459FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746054; cv=none; b=hvbKTUEO/LycZ69b+IM+E1u9SOj03yMtHt4N/JF3GLsVMQM81hkSnL9Retn03L1jUN+NtJzlwMcPvh6Gpxn+Dqo4z/AltO0m0p0yJ7xkwIpjNFKFDUHP6jXO+IvutVBoCc5a60Eps0ANvPwyZKpSYDCq1LRFTUQRY1Di1fgVQYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746054; c=relaxed/simple;
	bh=pLoHHoQIg6QY6717N1FA9UXmrEWZLF+ORHFFQ/NF+Q8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rZ4cwkI8bUA0XXU0HYJZuWka7XwsWOs6BrM7V8TyHmSA4w3ZuQjlHHS8LErRrEowX1DXbykSA/hkMm+TEre+BEQmqhJb9XElzYeyfBkgEqynbd6NGV/AZMTjYKXMUu6z2fdX6fnFuGrLTtkZuWQMTyzscTLdXQrDup7l96eifd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIvIc8qT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C6FC4CEE7;
	Mon, 28 Jul 2025 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746054;
	bh=pLoHHoQIg6QY6717N1FA9UXmrEWZLF+ORHFFQ/NF+Q8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lIvIc8qTtPTIWpfs+6Qoyo/IJOmXQ6vnCdQELVLnoNKlefIvEiKvDUvnfoSRfHdG3
	 DmHyL33FDymvZWGLU1foBDiFqcFu1mViKJyjefhs5/DpL3y07wU3nHHOHjf6RJTWKG
	 4US/m2JJ5lj5tLe/xySxITPmvi6/TgoKLPqkoDIbQnzgvJlcon6mqmy4BBUD88CcW8
	 lcECfIuVSx8kQTt0sx67Fn9gStlcfYgzy+hydDXvkt4Lk45Nu+X4V4SOb9WG1VWH03
	 zuSTpitDt4DVGKJwwSm51yKlgB/VGeLczRhgIzGUDXambi4z2qCYCugLIvyvJNnDju
	 xXVa9WeimvXDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB301383BF5F;
	Mon, 28 Jul 2025 23:41:11 +0000 (UTC)
Subject: Re: [git pull][6.17] vfs.git 8/9: CLASS(fd) followup
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250726080853.GG1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV> <20250726080853.GG1456602@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250726080853.GG1456602@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fd
X-PR-Tracked-Commit-Id: ce23f29e7dfb5320c9e32edb5f4737ad4b732abb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 953e117bf4aad7e1d01419d4bcc03ab93420387c
Message-Id: <175374607078.885311.7407553371424777794.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:10 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 09:08:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/953e117bf4aad7e1d01419d4bcc03ab93420387c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

