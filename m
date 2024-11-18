Return-Path: <linux-fsdevel+bounces-35128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7489D193F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997571F21B96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5102A1EB9E0;
	Mon, 18 Nov 2024 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4ZOYd6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054F1EABCF;
	Mon, 18 Nov 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959340; cv=none; b=hPlTtiSHAUXw49DC5L0l7fB7Hr1/xIZsC52YY4TSsd8r33LQcw0ZlqmDu2Rj4N4VrIic9KAZRyDxcQ6DkstOYsz/CjMQFOCfsuyWeoTjc7/ekO9YhhU6kuErwVAJYZ8R/K+O229SG6QkAHQ5EmRuwpW5TIvX56GNfBAXjSx1GzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959340; c=relaxed/simple;
	bh=WDRlWbcb5Npg/QlCd70btCRtPtX92+bDKeX4pUe74Fo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oIFjyTGLMrSFymGQb+zoFCMXpGo6fzgGTvCKgWH3gIo921BQzwZrU0YXWIBES7zDVsV64Oi9BSVwB+KpqHIqSeL1NUu4FcY96ALiI+cJtw+RE6LU8uzoYtYLZgrC+zpid3j1qxHUBJArdEEDTPA6P8m0iMSyc9b3omvOiBXau4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4ZOYd6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E3DC4CECC;
	Mon, 18 Nov 2024 19:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959340;
	bh=WDRlWbcb5Npg/QlCd70btCRtPtX92+bDKeX4pUe74Fo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P4ZOYd6i4Zo2e32cUcwkxp8eZHE3pR7UlA10CQp52nsroR98Dby8v2hBqH6wfBkTJ
	 Lcq7iV8LMe6aGjafJxCuiO8HTgvcnkMeDYaVTCdpsOvLDI8eJ8w9Wx60v//pvwm3dP
	 cg8OQb3bkbmvyiUOXgIyrRATPrmrbLiOwSKy4DiwTlAhKe7iQpPgFuEo3mwRFF3WcN
	 85mqASLRRg4fiagKqpXJbxWtOj55rhbSsnXUXlDBCU0D+HwZJtaduUY7igDRJ7+fBP
	 AtmTw0EfS0uSc3jAyzY9gLB2ndyn4eBLNC+yBr1foNRDBPS1Risx2mOUnxGrmCJXYH
	 3tEFFv6duIIbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F543809A80;
	Mon, 18 Nov 2024 19:49:13 +0000 (UTC)
Subject: Re: [GIT PULL] vfs file
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-file-f2297d7c58ee@brauner>
References: <20241115-vfs-file-f2297d7c58ee@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-file-f2297d7c58ee@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.file
X-PR-Tracked-Commit-Id: aab154a442f9ba2a08fc130dbc8d178a33e10345
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c797b11a88297b9b0010b2c6645b191bac2350c
Message-Id: <173195935181.4157972.11191310950628657624.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:11 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:02:02 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c797b11a88297b9b0010b2c6645b191bac2350c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

