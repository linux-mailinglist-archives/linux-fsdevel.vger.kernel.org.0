Return-Path: <linux-fsdevel+bounces-17317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F48AB61E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 22:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9219B21DF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1412C197;
	Fri, 19 Apr 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKdIk/dO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423CC2BAE6;
	Fri, 19 Apr 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713559594; cv=none; b=obNExbEpTAs0XKGVBHZIkHMjXpPsf6Pv1Bv6VEEkXCHag0kKrN0id11qYYYQgxGiX/LRGT+KZdsapKkTrSgF+vMxqHyek3nU6hQGFgplNODWBBdiuHDfkHWhZbJFPCFfrb6dShAF+bS2fQexpCTMBtYxG9H5IXrErWGnRUh93Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713559594; c=relaxed/simple;
	bh=3sSWGnR89pyXPgXLVMho2jMDnauoRp1idi9Q++XkTkk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dpvGEw22F/L1jo6l7+DvLS9b/2rypBdSIj3c0bh4ykvZC672fiFEgp0Cpe0VZqalsNOpbfsi/YpXYlWG16BjNlqGBV7tKJqIxf2CquLjDpEYGbZIRgkHws97h1DKRsCHj2iTKvkWwZ8gDx2BLC7iZkuftKn4O3Acxb7PyZH6xqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKdIk/dO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7D41C072AA;
	Fri, 19 Apr 2024 20:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713559593;
	bh=3sSWGnR89pyXPgXLVMho2jMDnauoRp1idi9Q++XkTkk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iKdIk/dOiYwWCrUliW1fFZO+oVCnquy1G5RJRlvMKfQPRAyidEmrQid5k2Wr8llSp
	 YbovNemH2iiDyARYKQLeeT8P7EAFm+JXNQPqLmyLWMMxNARjHIRT/Tn6fDNiO5wt8M
	 goAKXqHwW2jHQZC4CcfkOzZDpKwW9xsmCohMdhQMAgfzEYrlftTjX0BHejNuy/t4tY
	 XUlyqO8g+CDg0bZHxWiMQMfw4Qkww6TTx42lsYkrNXr6mLiBiQ5XUWm5q0lmSh83+8
	 yjgGNLBirT5Xle5SJERJ+FTXNyEFnJSlDLWOvZT25Z5OvXTsE2/scrN2DJNNraWWGH
	 P/cjwCBZD1H5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E8E3C433E9;
	Fri, 19 Apr 2024 20:46:33 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegvMf45cm=VQa35HdjM6=y8SeMojw8snnOjifqYjKbtM_w@mail.gmail.com>
References: <CAJfpegvMf45cm=VQa35HdjM6=y8SeMojw8snnOjifqYjKbtM_w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegvMf45cm=VQa35HdjM6=y8SeMojw8snnOjifqYjKbtM_w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.9-rc5
X-PR-Tracked-Commit-Id: 09492cb45100cab909cabe164deb7cdc14e38634
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: daa757767db7870e916f8853e70dcb87268c5c26
Message-Id: <171355959364.22865.7615098525091006892.pr-tracker-bot@kernel.org>
Date: Fri, 19 Apr 2024 20:46:33 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Apr 2024 16:23:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/daa757767db7870e916f8853e70dcb87268c5c26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

