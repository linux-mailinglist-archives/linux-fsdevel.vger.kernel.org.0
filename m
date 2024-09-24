Return-Path: <linux-fsdevel+bounces-30013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F459984E1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 00:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E02B24566
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 22:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12117C9AB;
	Tue, 24 Sep 2024 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISUqBczQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5217C7BD;
	Tue, 24 Sep 2024 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218207; cv=none; b=G1UAdFJzyffw0GFzH8RsHKcOXIhuLjbJ8QXQTBe+QW0z9nvN2BVcvMGJ96uQUim3SsaexUfBJrIjkP6mZgG6ZWIdj+iWGIltDsB08THsDPVMV00YX0hIOXlqMvP+HPmlKve+h7sB/bBLuKJ15ZtNfon6kkiga67wqiRgGvzvX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218207; c=relaxed/simple;
	bh=5U7e/2nrmkkerYCmGLJOpnCINnJnIMI9qNCXQ4r6Gj0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mrenp6nqflKkSW/3LfiVEo8aN4X8kXKfrXlzwyWgopBmVFnwzzxlHdhrVkTvCqkhnunqu0siw0PZms42X6B84tWUM7sqIAO1xE9ywO8x7YAtymnTp5WusBfu3233ykFAQXhB5ywghyZRRGy2wEVqKkPqbWLBaQ6gUq7eXTYdUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISUqBczQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D617C4CECD;
	Tue, 24 Sep 2024 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727218207;
	bh=5U7e/2nrmkkerYCmGLJOpnCINnJnIMI9qNCXQ4r6Gj0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ISUqBczQX8PhiSCrxcl987GjIwiZnZj0GthkWliCnB/7L45d4Kg/LYoM5I7popEYz
	 lmaA367/bXg9vc7bGm9Ufvakd/CrJTEWhLlU3Mbh3CPrwntBIE8jvZzpKGIR/qI+th
	 v0bb9G5i/YZ2J7kjXbd14lZryhsZ2rDD5SsdwKEO90eAFa8q9JsoNSnb4MUHA3/hne
	 3h8pzpd4C9yQaHUp5qdDVxCSwPRkcxZ+DAeHNeznUbt8Z8mFKSGmawVOBejx4p4K7R
	 Yb+ps22VtZJAj1pxdbMjghGP+YkDKWCdibhphKaZZIbDLNFXUnVmOQveyih7LiAGaO
	 6QO9w13Vg/DzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03CB93806657;
	Tue, 24 Sep 2024 22:50:11 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegu_-v_qA62+VZQmi+HvfYZSaxjpKtUt0P=_PTpiugoNaQ@mail.gmail.com>
References: <CAJfpegu_-v_qA62+VZQmi+HvfYZSaxjpKtUt0P=_PTpiugoNaQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegu_-v_qA62+VZQmi+HvfYZSaxjpKtUt0P=_PTpiugoNaQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.12
X-PR-Tracked-Commit-Id: 2f3d8ff457982f4055fe8f7bf19d3821ba22c376
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7fccaa772718f6d2e798dece4a5210fe4c406ec
Message-Id: <172721820982.30034.428944273509734434.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 22:50:09 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Sep 2024 20:46:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7fccaa772718f6d2e798dece4a5210fe4c406ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

