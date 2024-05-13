Return-Path: <linux-fsdevel+bounces-19393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5268C47A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 21:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0282867AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9477E792;
	Mon, 13 May 2024 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8vkNDMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455B78C9A;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629081; cv=none; b=rW8j8ndVWPY0iZHPY3P/Jnlq1IZ37OB7JBzf4c/S5jOh/6/oNg+LFIF22YbwJgal/YRsGfq7iTeV2YW+FE9hCBA0mhsYngn1LkGFR4UaPAQxg5GeBxAVaOz7XVG+1tyHrygInQBBgA0tQXdukLttCXFszuI9iDJd7dhIG01WHo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629081; c=relaxed/simple;
	bh=NcE4Nd0uAiimxmylBb4e1zBo6KOSfe1ejzAkLShvFSg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P9rAjzHIPNHtEafbX1HUnkSHSHhdN357JOYzdcWOsshebRPhiwGQzO4phg2E9nGAAh+yN6u0aD1bWW0eEr36On0O11bV8+nqjghmqHDrLocLknrI8t0xjUzozPeYuFLfm3npjpIYJ7jP98QeOi63Uv3lRvaKbxwRUjlHzX+PBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8vkNDMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C1B9C4AF0E;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715629081;
	bh=NcE4Nd0uAiimxmylBb4e1zBo6KOSfe1ejzAkLShvFSg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f8vkNDMVf8e4/KvLJP2grjnkiuOt4S2r68YEGOiIciqBvCZU+3VGsdDuqYRWCDh0R
	 LEW9h5y92ihWoi+5ej9kDru8gxI4+N6EuB9BPGAgAS8iWjXNGs4FlHJ9B6cFebCmLJ
	 GtgNtuxKsS+9KfkkTZgHdb+1yncZpkyvLTKB5MkyAUujp5JKWrjminTXfHAx2gc2sz
	 mDd1vyB7MZbdXSO8zeze0IWYACfkLQzGWpD9Z7kJ0FPVHdYMkEnKMi2SPqL+tIiXNK
	 M6yU+gO5VDU9P1qhttZIYkr+Lp+IRBLSP0AkWvO6+IcpHzM+D/TnTAtAjo8bTcDH87
	 zZEvxvDdiFRLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43964C433F2;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
Subject: Re: [GIT PULL] vfs rw
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240510-vfs-rw-332f4a8e1772@brauner>
References: <20240510-vfs-rw-332f4a8e1772@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240510-vfs-rw-332f4a8e1772@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.rw
X-PR-Tracked-Commit-Id: 3a93daea2fb27fcefa85662654ba583a5d0c7231
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4e8d80292859809ea135e9f4c43bae47e4f58bc
Message-Id: <171562908127.8710.6703268997469345175.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 19:38:01 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 13:47:17 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.rw

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4e8d80292859809ea135e9f4c43bae47e4f58bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

