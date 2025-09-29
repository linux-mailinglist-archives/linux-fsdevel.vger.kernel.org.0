Return-Path: <linux-fsdevel+bounces-63053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E437BAA78C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8C31C6B7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4A32BE024;
	Mon, 29 Sep 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjnKpx0m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AC2BD037;
	Mon, 29 Sep 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174284; cv=none; b=OtV3S7ZR6jH1zItdSv37oQFnILc4WPcLGZPwp2dkFChOCAKs/Knj9yYVdOkVm0HpMmx+USK9B/lWtJ/I/+ZH1OUKR47K9b5UXrPhRENgqCJ4OG14yjDUn5k31/3W15MSH9vpDa2VMiD4T8IFLbuy/sl4M4k/pSQE7Lv3STnLGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174284; c=relaxed/simple;
	bh=qkz8t1RYHta6ZMRw8QhAA2InSpl249WyVfvJN+OfbxA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y69fW/B+BjO7/+a2afpnR526cfNl4GCh4i/ngjImEfrlf023EppwRV6ar4E8O9I5a4NmxQfHxR/jD/rv6VYk4LuAxXLVHbkYDK3Kt5bfGSlbKegoyDsLGrEgTkJOY2KoGRfeCbNi3MsVF5BwJZHDcSoWg3hu5WA6KRgyTb/lb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjnKpx0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663F1C4CEF4;
	Mon, 29 Sep 2025 19:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174284;
	bh=qkz8t1RYHta6ZMRw8QhAA2InSpl249WyVfvJN+OfbxA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FjnKpx0mCMstPGu6e7FTeKa2lCTlNV67zESdDX26yTpxwlyF7nho5Uiw5CK263yPD
	 ST6kQAnRoArIqVb/K/zjI6Oa4U9QVp1a6ZpACvBh16jWECYH063Arf7TOw9zC08ONK
	 erlF/hEvnUzteCpN/HnwFLSx1Cfdlu9JPD06vN5ZIRwW+2mQVPjhawdpuvUOZwYgt9
	 JkJ/clePKmZGRZotyRTT3NG/ZcTyFWz+ICo1ZIYoHKr9JT6p1G7INlvej/DoCw07Q7
	 1DrzNIyJtXoCS4kDkS/DS6QcJNzTEKtdhthfyLBZHfsYXN/DSloMDyk+fp3zxz/qiU
	 yZLicvuFlyRSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AE339D0C1A;
	Mon, 29 Sep 2025 19:31:19 +0000 (UTC)
Subject: Re: [GIT PULL 11/12 for v6.18] writeback
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-writeback-dc8e63496609@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-writeback-dc8e63496609@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-writeback-dc8e63496609@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.writeback
X-PR-Tracked-Commit-Id: 9426414f0d42f824892ecd4dccfebf8987084a41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 263e777ee3e00d628ac2660f68c82aeab14707b3
Message-Id: <175917427780.1690083.5952668965824670131.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:17 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:19:05 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.writeback

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/263e777ee3e00d628ac2660f68c82aeab14707b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

