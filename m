Return-Path: <linux-fsdevel+bounces-7752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5094E82A284
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 21:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E501B1F25258
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 20:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20255578D;
	Wed, 10 Jan 2024 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmaVmu1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F953E30;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A85AC433F1;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919126;
	bh=hHzuAduGO6gjn91qGKwDMAK7lMQW/p4PBz0T40Mzais=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SmaVmu1p2ktHo9TSF5pvLKkP1fWlaKUxBQRiU+5ieFoEWwGP5ggp0fULaf/fgR2GH
	 IceF1cm7tz5qn74of7+Kzaq0Q+kL28Fw+EYOcvtpO92U4MNM3bve2Xx4leROOWLdD7
	 tX9rR06C2yjwBwQ+WWQf5XQDnvhDlFstzW5p7LJUFYGCiMAK6EqM64XlPbz38h2iV/
	 YTiw231z0BaB6oRG+Ivu2zaGNck28UD1/nBhspeswww3+CDpIx+7KHVIsMYvlA6dNl
	 0/YDqkYUSjv+l3m5JQesOCPgmLQiG6s51WTHCrkUCoYKY8r9s/JZcW8hkZir9xteSg
	 jcE0CfSNQ7HMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87593D8C96F;
	Wed, 10 Jan 2024 20:38:46 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240110162900.174626-1-amir73il@gmail.com>
References: <20240110162900.174626-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240110162900.174626-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.8
X-PR-Tracked-Commit-Id: d17bb4620f90f81d8a8a45c3d025c679a1b5efcd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d925f60578ab3b13e2cfeb5e6e38cb83d51e032
Message-Id: <170491912655.22036.5771313721203670794.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:46 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 18:29:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d925f60578ab3b13e2cfeb5e6e38cb83d51e032

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

