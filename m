Return-Path: <linux-fsdevel+bounces-35935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39949D9EA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 22:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A732843AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20C17C219;
	Tue, 26 Nov 2024 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8ESkmGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD661DEFFD;
	Tue, 26 Nov 2024 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655074; cv=none; b=QTwajQYMZM/zWGdEzceKlCtHqGjxlaY8W5yxveucfBR1BNbmmkuTiEZ6ZQHkJOxDxhw9Rs50PwdwSjHvYL2GOy1v/dbLhAda3kZrBhoxEjO+7CWlK3tlbl3Q6Gcwo+0TqaMp59odkssboLZgkFwP0h4VLPSbYwL+PkrMk5H2uYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655074; c=relaxed/simple;
	bh=EqS0xcyIMgS6Vl7+6XcBxQOAew51ToXj1pkDo72zqDQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dlvioy1SQ97nMzjwwIqpojDFQ7LypClccNxfX66ty04aeZUq0lfNXfpnq93xLU24+fSIwDPBuKa38McpBdE97CB0ojyDXHcUHAYviWqfJTtOBQ+kPyGRQh2jZAxxMf4yFhUVJqTtu8692RYuATZZXojXV2dEgb24evwMRl1d02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8ESkmGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FFDC4CECF;
	Tue, 26 Nov 2024 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732655074;
	bh=EqS0xcyIMgS6Vl7+6XcBxQOAew51ToXj1pkDo72zqDQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k8ESkmGUGe8HtNRtSrywaOyqiE/9o9//Pl7nGih2MswLVL7PSwxKMxpn8+dDX+g18
	 0erSqLpzlRSQtYNC8f+g8s44FVu1x5xKSnGI2t8g5/oy6+3qPFPGnBilY1X9vQHFzi
	 IlgRRsztv8CB//fcVbNg9+XiZYzddyW9lv0ygGCzfmzBDWeC0YYJhexmO8ZF1EeNWS
	 a0gHH7jPw9CQL0al/nd0ih6Qyqu1djFKHhNm5/4uBZdgATUu75hgrXlLDJ/1Zjg3f8
	 opay3ahQqIE/gyAAEvz3vJ4er/S9q+7dl+w9gV5DmEDa87/MD/rIj4PMeN19Q/jkSJ
	 ta/lWZoP1RwjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C873809A00;
	Tue, 26 Nov 2024 21:04:48 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegvCr7hBSqU8iqKUCZ3i5wUyiiyfbCtP_NO37OGMA2RVPw@mail.gmail.com>
References: <CAJfpegvCr7hBSqU8iqKUCZ3i5wUyiiyfbCtP_NO37OGMA2RVPw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegvCr7hBSqU8iqKUCZ3i5wUyiiyfbCtP_NO37OGMA2RVPw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.13
X-PR-Tracked-Commit-Id: d1dfb5f52ffc4a142d88da5c0ed0514f3602c4b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb527fc1f36e252cd1f62a26be4906949e7708ff
Message-Id: <173265508695.539328.6336454200186074462.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 21:04:46 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Nov 2024 16:05:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb527fc1f36e252cd1f62a26be4906949e7708ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

