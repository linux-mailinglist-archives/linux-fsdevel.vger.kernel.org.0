Return-Path: <linux-fsdevel+bounces-22185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ECF9134FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 18:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FFC1F22A7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BB3170837;
	Sat, 22 Jun 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqCIsvKq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CF716FF2D;
	Sat, 22 Jun 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719072606; cv=none; b=h5LsydWu1xNvgWKdSbg9/h5eyNZLbOmFblpBi/tRi54fnkFYTrsP/rHxsI4HFRRg8L/sWmhRyc5Gbgn3eWuIp/hK6ztf//V70Gyy6byNWHDQ4cn5m1cOSBqAhuVOMtH0i7+1y1qfOyeKjN8X5Ck/j8RjeiI8hRRB6bwMDcEZqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719072606; c=relaxed/simple;
	bh=SVXWBJJ7k9PvXMwnH22ryPi7eMbcdRNKrI14RkZ1FBs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cWYTmJnm6vgMySqkQqHKFbCcs2h8gv2WUDDu4roUP1j0jCLarzmfi6v+98JlBXjqDN1yrc3njOIlhA4ghYx3+LoyA2SmpIXtyvXvGVwZ+YKd1kRnpL6qs7Ndmw2YokTVR10PRd4akQKKPcf+oHM3swnBtBF56AU5/SYQQG+z8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqCIsvKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B32E7C3277B;
	Sat, 22 Jun 2024 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719072606;
	bh=SVXWBJJ7k9PvXMwnH22ryPi7eMbcdRNKrI14RkZ1FBs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pqCIsvKq8bIoQ73GNn+gY7GcHNHOGkyVmAFuDPeVfUGDa79cnf2UKmHc/CicqaDel
	 UbD2NN9mxc9R+Y+GdbtnO/vhWx6ZTVyiuGOZT63jAyb32wh98WEujKMPqev14kVCk/
	 1UcNutHnAToh8w3z6JwxM8tZVy+6GiDYh4oKxfM6C3PkwpsFXjFHKrBQ7oaCkahy33
	 DHt8c5mPaYy+RJfYc/77AHAF4lok5qmLsQIxJTWcweZ8SEh5/gCIrj06E9k7lj5KZj
	 Ng7393GyM4jgjy41xa//9Ta2hAhlI3hZjFMh9OhruhWcOAxOAq1SwBOCTTdJkmUpws
	 MArqneFavOe8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AEB2D328B9;
	Sat, 22 Jun 2024 16:10:06 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fix for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <87r0cpw104.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87r0cpw104.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87r0cpw104.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-4
X-PR-Tracked-Commit-Id: 348a1983cf4cf5099fc398438a968443af4c9f65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
Message-Id: <171907260662.30765.2165082552286692137.pr-tracker-bot@kernel.org>
Date: Sat, 22 Jun 2024 16:10:06 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Jun 2024 19:05:49 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/563a50672d8a86ec4b114a4a2f44d6e7ff855f5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

