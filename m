Return-Path: <linux-fsdevel+bounces-44901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4100A6E4DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DA27A682C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD61EF0B5;
	Mon, 24 Mar 2025 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct+0lhpV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BE1E2852;
	Mon, 24 Mar 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850025; cv=none; b=l9LpZYFL1MVBuhc3nTT0Ykqr+9yRzV1jgYhAfo6SVlF7BOe0W3pMQJI7+q5Lfv54WIfR7pogvYVpRKWls0d7D8sZg2OM/2T1rwKAwaB/rFUMRLIK+I4wDzTz54tBEyxjRnYlY/GdqUM/HrFnt7zpYHFOggUKnJNmGnUcbwjcQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850025; c=relaxed/simple;
	bh=u9Pfi8E5j32WgvAOSSlnqg43yQ5P6TlFfcmj/RXIkl0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ANYr3okGvkioAm3PNh4y3eJydCLaFk2snaORk5/XEc05qpMr1vt8hu6z57wuuQuOxGrp9CkybpxB2JvLuiLmT0s6JNHw6anZ/+xAXIVAdYEwttGPNmv3rI2Xm0h8GMy2L5gIgPhtpyj+VoIJDC9Vowd8uLOxPIxvKO0jG55oEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct+0lhpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FB8C4CEED;
	Mon, 24 Mar 2025 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850024;
	bh=u9Pfi8E5j32WgvAOSSlnqg43yQ5P6TlFfcmj/RXIkl0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ct+0lhpV6r7saBF0fo1dOI1JZLI9z8cnVoZfdVZspJhYh24Yb1CZjpRMzCS5d/UGe
	 NFU94I7a/Q3rhUe6Am0zGtyUtbfHQAaFaGmglNxgNSRbhVs4W+X0HAU+mN0p7mq+Xh
	 20PBh1B/MbNZ/WHjoOf9r65Uz2Ue3stkCMPc8GHOklS99rhOVmHKCpoD3AbhytwhwH
	 MkeG6ushkrxVDz6rp2yQU8T7Grck2IddSI0kf8GlX0hEJvMBMC5VKArIQIloXu6s+I
	 jshJVXRYUjSOeD4TMKXa9+qDTlCKljfomozlA8tmtesU2yX3e+R9pqqCbSBjLs0JpX
	 N+IiFVX5rpItA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CF3DC380664F;
	Mon, 24 Mar 2025 21:01:01 +0000 (UTC)
Subject: Re: [GIT PULL] vfs pidfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-pidfs-99964e3e4c66@brauner>
References: <20250322-vfs-pidfs-99964e3e4c66@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-pidfs-99964e3e4c66@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.pidfs
X-PR-Tracked-Commit-Id: d40dc30c7b7c80db2100b73ac26d39c362643a39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df00ded23a6b4df888237333b1f86067d24113b2
Message-Id: <174285006068.4171303.15453713717452142187.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:00 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:13:37 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.pidfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df00ded23a6b4df888237333b1f86067d24113b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

