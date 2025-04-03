Return-Path: <linux-fsdevel+bounces-45583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C9A79945
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E90A7A51DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 00:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105CEAFA;
	Thu,  3 Apr 2025 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SavP50nR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818FBA53;
	Thu,  3 Apr 2025 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743639063; cv=none; b=n298I6xbv+PI7OlzbC0bno0dBEMSCJl4RVtj/QJ7HxpcVbGj2vBG2H9NLNVPS6npMeHXlyb7ryywgR4Ml5WOB/65766J45+64K/g5h5Prz3Oy7/DZZRT6IzBbUzA6ZQqupc8+lgsHTG/npB0rsCE+t8067OwJJ2DjjgHKuDbSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743639063; c=relaxed/simple;
	bh=gyIo8y2WXy7a0iMwTpeP9krZMh0UTolb9PYI2BFwtWo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eTJGSsq3ajmW2HnyWX8kieC2keLncE4kubKNjWRa4mUXZaYbd1XzcujoKB7a5sUCQHRn7eTyM11y0K+sMKMNwlotrq3neK6Mb3Bozpl/RmPj9zKRVVSucrtoXi6F1LB4SxcsiGuHZZKX5wpYliBK4NVQ/VEQGzfqqsTxge7FTpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SavP50nR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55802C4CEDD;
	Thu,  3 Apr 2025 00:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743639062;
	bh=gyIo8y2WXy7a0iMwTpeP9krZMh0UTolb9PYI2BFwtWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SavP50nR/GmAaeEasEBaBdbM1YsJvQaYmP4K6LF8c1oGWvKj14dJfoXZ/hfRTb8zr
	 Txi9HjeCfMk+h2nnLBRloYzaDseVvnMrqNBEJs8ecTBVMLXqvZxsDKHCay4Uw6OAqT
	 yA87A9sgHwOjo0hq4f4kcCnOHdLraZTSkG6lXHsiN7YQBFyzIrWhPSKne9JlvDHorb
	 K9iBEYUz9fsSOH9m58HopFZvBCm147OZse6ufBPy4U8WB7Q/z2efrImKcWqT/M5BI+
	 Q4fvYzSJHe6KuhwrSHck0bTBrypEWExoJNLTOoIbKHlp/6IasYW1WC99xjwbKErOyp
	 oft2XNcZt5avA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C0B380CEE3;
	Thu,  3 Apr 2025 00:11:40 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegsQDTYsEWHMK9skpNzUO=GA_DR7zGHftyO2sZH5wjaZLA@mail.gmail.com>
References: <CAJfpegsQDTYsEWHMK9skpNzUO=GA_DR7zGHftyO2sZH5wjaZLA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegsQDTYsEWHMK9skpNzUO=GA_DR7zGHftyO2sZH5wjaZLA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.15
X-PR-Tracked-Commit-Id: 2d066800a4276340a97acc75c148892eb6f8781a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e17b5c71729d8ce936c83a579ed45f65efcb456
Message-Id: <174363909906.1725867.3959009844005157008.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 00:11:39 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 1 Apr 2025 13:02:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e17b5c71729d8ce936c83a579ed45f65efcb456

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

