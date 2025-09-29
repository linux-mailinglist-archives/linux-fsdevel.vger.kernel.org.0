Return-Path: <linux-fsdevel+bounces-63049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72054BAA774
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320D4420DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331F228489B;
	Mon, 29 Sep 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHiLgX7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68B2609D0;
	Mon, 29 Sep 2025 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174278; cv=none; b=gFuQQuEINYi+KjXetnEdIJ6Q5+DPNvCFhISvKe18pZo2ws2SpaXsVOjWDCsWFDbhBfV3Ze0bA+sLcqQ8zVmlzAJOUqFBVGsnEm82tNeoHmu8d4+jpJrx7PEqWrk1YiAkIhh+oR5e/dkI9CsgTBO7O9EvUk9j+xR0X0GzeXvtH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174278; c=relaxed/simple;
	bh=kMFnZ3F41lI6JvxDuwDBobUEpV+SH5KXlNt5YqphTFI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WPsAymjVwxpBsv8t2tOrUHetkSB19kfpeW1Pug77VnhgbLZRyteDOieO/D0Ur52q8YAfb+5e0qmNYRA06NhJbnezCwIca3SiRpLfzx8M7PzNnHkQp/phmjL6eCxtwE0a/IqJybA6lI98MUFfJbbxARDUyLzkSvc2wYaypS0IZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHiLgX7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B98CC4CEF4;
	Mon, 29 Sep 2025 19:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174278;
	bh=kMFnZ3F41lI6JvxDuwDBobUEpV+SH5KXlNt5YqphTFI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sHiLgX7g2P8wXR5tMgUKw0JMBha13lkS2UOY5txobysNXy45eMzJK6dlvUvOveDZi
	 L3HJxycHqU18Ulik91ecB1Zsx0cnmIECEEwHOUPTvHZXmSbmzlO3d7+bBngD0p17Nj
	 bHNWv+/QFWykeivI4pmiMZoB6wUbtgA/gKXIG7vOZgmM7tyBreBE6R7tDTaNARIXm1
	 3BpDMxD2h3Xk0YbHID9QAcjMmtw/9hvIIy9vkMhQcVPQ82nunHcO/uDDE+jA4af4yx
	 aEilAHCVlxNgNFOkhDLPimef78RJ3E46SOI3kRbaOYAP2qGP63HTOwXf7+5o22WWoK
	 OR9/W2E4Phryg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4E39D0C1A;
	Mon, 29 Sep 2025 19:31:13 +0000 (UTC)
Subject: Re: [GIT PULL 06/12 for v6.18] rust
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-rust-48d4952276a5@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-rust-48d4952276a5@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-rust-48d4952276a5@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.rust
X-PR-Tracked-Commit-Id: c37adf34a5dc511e017b5a3bab15fe3171269e46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df897265c0c6fc4b758b07f3a756e96b6f2ab81f
Message-Id: <175917427180.1690083.9019943463445149817.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:11 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:19:00 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.rust

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df897265c0c6fc4b758b07f3a756e96b6f2ab81f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

