Return-Path: <linux-fsdevel+bounces-29442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97766979C16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 09:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5551F23BAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 07:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE8146D7F;
	Mon, 16 Sep 2024 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE4SXW/4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A3145B10;
	Mon, 16 Sep 2024 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472079; cv=none; b=XLn3G/XOPV4GH/jbmcHsUwxHlkNNeU/Mg9KahBeS7YH9sSZpv1F61ZY79xd6Dh4sIbZOuWLSqlsOcWzWE53TzLbYfaB4YO3kOV9ZL8P2G67qQZXVLs4ktluYddrha8Zi0RWN6ninFz3i5HixOy7Uq3Pxp5LrEqKsUSBka6fq5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472079; c=relaxed/simple;
	bh=0ZpTcnhr9toquPyl1BGeznXUDQESv0hzPEjCBEDm3s4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dL/iNsY6/frAh2PGyJN7PVHE4pafC8C93K5ovsupTYmCUK+wjJmb4Cs4TV7Xs36erTeK38vZs8g3MW27GScBvGUwSXHNb5mjZ/jKabBVMdIQKzEBzra6DxrFutmoWLti0xTFwDwhvKkOOA0F+1NIUuA5ijyzKmPXNpbWuEwDko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE4SXW/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705FBC4CEC5;
	Mon, 16 Sep 2024 07:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726472079;
	bh=0ZpTcnhr9toquPyl1BGeznXUDQESv0hzPEjCBEDm3s4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dE4SXW/4oi7v3PwmqwD3SVXSYpLrjR5UdVaZqdRw6EDr1NpDYaEAU2gc32q9c3kng
	 mwOHBrWcU/Gj2Deybd+7yoXewx0jX52j/gfI/Y7L69ppereBYM3AsgbSP0liUiWXnx
	 KqLYW2oOj+3bnTYC7baAGAgMzWY0lg3mShRSYSKxKVMVOVx5jGYOAtNYXpYVh75lov
	 kf0UUHeTcE2RkC7MmK9sZjKxZsPu7jC/sqeF46mvsMP934AVyNGMnjLqHpTtcDgdzs
	 CCTT6jH4hBsyTfVs/hA2GBcDmGlC+DEGBcrdMgN2rJQGXH4qWQrFvLiI5iQN6R0uCR
	 9ZSwHXPr7cncQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B1E3809A80;
	Mon, 16 Sep 2024 07:34:42 +0000 (UTC)
Subject: Re: [GIT PULL] vfs file
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240913-vfs-file-53bf57c94647@brauner>
References: <20240913-vfs-file-53bf57c94647@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240913-vfs-file-53bf57c94647@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.file
X-PR-Tracked-Commit-Id: 24a988f75c8a5f16ef935c51039700e985767eb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3352633ce6b221d64bf40644d412d9670e7d56e3
Message-Id: <172647208082.3286942.4146959275537108258.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 07:34:40 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 16:43:10 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3352633ce6b221d64bf40644d412d9670e7d56e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

