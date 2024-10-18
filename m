Return-Path: <linux-fsdevel+bounces-32369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BB39A465F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 21:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF575B2310F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AA6205137;
	Fri, 18 Oct 2024 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmnTTa/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B8204944;
	Fri, 18 Oct 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278004; cv=none; b=XelvpSbpnK/X+7DK1kRo7adoXlJTqd/EzH+d+z6rx3F4RGvrjPdM1He+uZpLQFZPsgznU2M5qS2F1mFrp0AoZbITi5cWb64VG9D6M8H0LAFr43vU5nfv62HG5PtvnG+b0hGy/5UdDyBi6MXM/8aSLLtkKRqQYQms2ZT01FLXZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278004; c=relaxed/simple;
	bh=0thBz3IgpLEBRc1Rl6660hSu/MpE2cTtH/MPVJ2BV5U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W0N6UV2XC0i/4tWP6HtdRwhlsWCNAJzLXVRYjvZVdxhRLL5iHw6Czb/Sk9wJdYAlWFQdYqSVvfK/GwKB0mFPteXHm+FQOQ4glOlPMxMklajD/Cymeik77aewDUyftTNTOiTdAxuO9P77y9+kflRIdb4yhINGipH2qLEP8t3Qwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmnTTa/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A832DC4CEC3;
	Fri, 18 Oct 2024 19:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278004;
	bh=0thBz3IgpLEBRc1Rl6660hSu/MpE2cTtH/MPVJ2BV5U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UmnTTa/Rxum6wLp928IVxFBNbc+ROmtGP7OvS0f4MfgydALgsDt9lHsClZVbRQm3z
	 RjKY/EI1aYe6ZeQWUuDoPRTD5CXQAfDcCZkNn6VvMWPlpaIxD83+9yz3J9guBlkBma
	 Tc62xenxgVWXXnm00SrieDRQP5bXCz9OiwY3+W6pDnEadcbI+LBWK8SGwgilEZm0L0
	 hrwcA0VsHzeri1om6G4peB4j+SWaubBQThHnQFXjKgjOmK0mvNYd2GZ7Zw7KQXdEyl
	 c8sNS9W4ORzfa5+6Z6ltpNUT4CZIDmX1dNnjPdn54oojWgaeItxmRtvXv3/3zCWoJF
	 7RR37qj1kNMVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715F53805CC0;
	Fri, 18 Oct 2024 19:00:11 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <olhbmfxlvn7kdlc4vpxaa3phy3vq7nqgczudqjj2fr444h7cfp@xvy3zxck33v4>
References: <olhbmfxlvn7kdlc4vpxaa3phy3vq7nqgczudqjj2fr444h7cfp@xvy3zxck33v4>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <olhbmfxlvn7kdlc4vpxaa3phy3vq7nqgczudqjj2fr444h7cfp@xvy3zxck33v4>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-4
X-PR-Tracked-Commit-Id: f6f91d290c8b9da6e671bd15f306ad2d0e635a04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 568570fdf2b941115f0b1cf8d539255a1c707d9e
Message-Id: <172927801013.3206296.4148251118707737005.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 19:00:10 +0000
To: Carlos Maiolino <cem@kernel.org>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, brauner@kernel.org, hch@lst.de, djwong@kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Oct 2024 12:01:02 +0200:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/568570fdf2b941115f0b1cf8d539255a1c707d9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

