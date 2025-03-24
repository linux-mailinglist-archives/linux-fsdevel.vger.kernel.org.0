Return-Path: <linux-fsdevel+bounces-44905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD0A6E4E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2FB16D69A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146DB1F2BA1;
	Mon, 24 Mar 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbXK5r4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FB1F2360;
	Mon, 24 Mar 2025 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850030; cv=none; b=N/Rf/MjrnAckVGSJ5VoXCxhrCcXY976ND9a3Af+Hr3GK+KWCmhU1msDrzpXp6vTFm7ajxmc04Ireyo7bcGZO0jwaYNLNtWnUPWG3pDu7K0kZbCE3pguahZ+YSHQzX4jvpiie6lEeBDJtP1QS1iqQGsSkY/HgudWJQT/z2G+ZGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850030; c=relaxed/simple;
	bh=MWPcR17PCkaE+LOFDObRSyL6/fvQzYAVK3bGOQUE0zQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jorAkm7cZQDVGGOeRlGp2OF4zTJpcKAkpZ21hvCfDZwx18i2Fu92Xe1DSEcNEdLGhBsKJZJn1/TMOg/LAgVfO3LADEboPbSKTdCAztizSY0aLUjp8NjLORDxrKUpwvviev0s/WgO3rFc2+XgMe6m7xbajrTJxy+rEXwyqlSTVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbXK5r4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BE2C4CEE4;
	Mon, 24 Mar 2025 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850030;
	bh=MWPcR17PCkaE+LOFDObRSyL6/fvQzYAVK3bGOQUE0zQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sbXK5r4gXMAPmoxm8w4Uv61Kx2wbL1KviQHzdABLX7Y5MIXmmsq+aGtcYF3HbxdOK
	 It4VDBpabINm4EXxgf2Rr8IALRVBZs8DcB0zELPuO7sCY/HTsvQguHYzWG00FIKahV
	 I/onCB1X2xwCTURvcTC3/cx4Qhh39xSU/sUvKLT+jGnMEu5N7aEtRRDTaJD+xBZEVQ
	 ghJnvYNzAJ/neoqU4TKDywrm47Ck6aIyvzK+SyALLX1A4mUKSRX0+F5XOGajFHkuLo
	 ZDWPmSdhM0kLVXBUcK1SiAdfAjcu8hAqZRZFaD8lc5VuhceE5n7kdgSN2IH7n1CllB
	 6iPDtRCcsBRog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C72A2380664F;
	Mon, 24 Mar 2025 21:01:07 +0000 (UTC)
Subject: Re: [GIT PULL] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-iomap-a2f096e9d3fd@brauner>
References: <20250322-vfs-iomap-a2f096e9d3fd@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-iomap-a2f096e9d3fd@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.iomap
X-PR-Tracked-Commit-Id: c84042b32f275dee8e3f10cdd8973e2e879f1fc8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ec0d4ecdd8bda4d55c5ba7b11b1595df36e3179
Message-Id: <174285006658.4171303.16289207042436155749.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:06 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:14:48 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ec0d4ecdd8bda4d55c5ba7b11b1595df36e3179

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

