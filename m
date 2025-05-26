Return-Path: <linux-fsdevel+bounces-49869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6291AAC43CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 20:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E90F3A8D9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4924500E;
	Mon, 26 May 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCpBiYpm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C00244684;
	Mon, 26 May 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284528; cv=none; b=FZxgqfQZG2OcBTLaY/X4r9TVuegVSa83IivaV3qQjVk68MK2drgt0Yd8D7Aoi4yzC5OQc6Kmi9Dxu6G8xmN0o9M2GkHP6F5C+kPr//psS2YKnJvCTPPko2DQu1F8ntrg2WKd2YP86iAUV+KCLtFh9B+zKjJkBneNZPZsCDQ0a7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284528; c=relaxed/simple;
	bh=RlLHkrSJtXaQRqlb0aR5JSpWkDlpRmWV9uUGOm9J2JA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SZC0mXSgvG3WNFxeL2TVqaZYZhdStSkUdlWfczJG2uDcp00lLtwcpV4BcqXcxFlx/OmYfhskM1yeU7Jn5EO1M/Jhu4qK4Y049YVzZ08WBm5MMZLrjsNnPQWwjEXYxdalXisv4R+gYResh9CWHiP4YMjCmIuaacc3llxV9SJSYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCpBiYpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373C6C4CEE7;
	Mon, 26 May 2025 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748284528;
	bh=RlLHkrSJtXaQRqlb0aR5JSpWkDlpRmWV9uUGOm9J2JA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jCpBiYpmEVUX+UqPdvZbEOA97XIhf9PjvNn6hrYsYWy89O4OZxQwiEPvRKEWJdHzW
	 Gbg1cKkwAbdOeCcWo8iThfKzcNUBfTAaoIp3obuwCrtPKxQ7z+oYycOh/Gnjg1Lie+
	 YFCz3jRVSDjS2M5Cb0QyOu01AvBHwrY2NuxbOdFduIorRTJQ0y5i05Sf4nYW8hXFbb
	 96PlIzA92ZR9ek5ZMbfF8J3Y/+XCO5M98lKtHgMxqkjGWmJggKPK1XjsOB5JcF1juy
	 hNlbfy1dXyAycIeDllmyu53lv6MLfM1H5/s0+HkX1o9Zq7Ve68bt51JNiuBSa9SXMD
	 EAumd0vFVWv/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD0E3805D8E;
	Mon, 26 May 2025 18:36:03 +0000 (UTC)
Subject: Re: [GIT PULL for v6.16] vfs mount
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523-vfs-mount-419141f78092@brauner>
References: <20250523-vfs-mount-419141f78092@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523-vfs-mount-419141f78092@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.mount
X-PR-Tracked-Commit-Id: 2b3c61b87519ff5d52fd9d6eb2632975f4e18b04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ca3534623f41dd0398c9f1cbc47fb874653c7cf
Message-Id: <174828456261.1005018.18165150727258465231.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 18:36:02 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:41:15 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ca3534623f41dd0398c9f1cbc47fb874653c7cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

