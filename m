Return-Path: <linux-fsdevel+bounces-56207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 165C1B144E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B7E1AA1671
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2375C28751E;
	Mon, 28 Jul 2025 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Drjybqbp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82784287504;
	Mon, 28 Jul 2025 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746042; cv=none; b=hvJP1bDVU46wEeFI1BaL4TpE8ClKUGiXI1dzJpNvrDLJDoD/X2Kpo668a3Xh8oVZaOitRMvo0zzskAI0S9jcBPmucos6L76OAh9ThZzYXaZDDLgMehayiQgttvLiUOpd2zUBnCQV4jGOjt8Hhqzq9mZgnpLHexhWx6rp52UvQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746042; c=relaxed/simple;
	bh=90sD+xX8zS7ZKoIXNL5VKOb7th+LAnqPQYFCvc2qwIE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tftJVCBtPxQnyGcHu5vw97km0RN5I98cs0ekHcuGrfghEB+ZxZ6fLzKbcb/Ra2THMGOq8FRdTsq47HjuRKr3G2BhUKCrSn00VGhukjl//sIrEBZouUHbjeRZItwBcv/xVZvv+Zrpdi8OQHF3dHafxH9sTWAxoLrD3AGz299UD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Drjybqbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671FBC4CEF7;
	Mon, 28 Jul 2025 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746042;
	bh=90sD+xX8zS7ZKoIXNL5VKOb7th+LAnqPQYFCvc2qwIE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DrjybqbpH/voTHbgebr11a8c+lBl++R5PmTWcmIvyIiVz5obBS6bkpRk0axspehqR
	 Gm6zFxsYe10VPR2utQ7A5Sb4Y+FLXr0Homs/adYvWe4TPLxcAlD/B/ou+V2rLBeFef
	 VRKXfrBfZNIsgd8OIYCjum6fJdu+fz/H/jxq6/i2RLk2ke+Lw7nTpBBwiHi3rmuKlW
	 R8b4NzhuEcU9XhfiewNRt89F1mq66txsdQPDkFanfIpGJ0JrFBcTl7uaPNrYVABID9
	 3NJ4/MfXPI+3cYK7aaWNs7Z/MGG1XyYKM33edJKXi4HmEifusRKMz6xvKVHYQuLMAO
	 AZ6v7bhbaWPJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 369B8383BF60;
	Mon, 28 Jul 2025 23:41:00 +0000 (UTC)
Subject: Re: [GIT PULL 13/14 for v6.17] vfs super
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-super-5977952856e4@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-super-5977952856e4@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-super-5977952856e4@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.super
X-PR-Tracked-Commit-Id: d9c37a4904ec21ef7d45880fe023c11341869c28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0965549d6f5f23e9250cd9c642f4ea5fd682eddb
Message-Id: <175374605914.885311.14022422764919100904.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:59 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:27 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.super

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0965549d6f5f23e9250cd9c642f4ea5fd682eddb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

