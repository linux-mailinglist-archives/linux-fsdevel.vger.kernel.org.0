Return-Path: <linux-fsdevel+bounces-41266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AD6A2D06B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 23:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4315D3AC3A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 22:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA661BFE10;
	Fri,  7 Feb 2025 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2GijfG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2E8479;
	Fri,  7 Feb 2025 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967126; cv=none; b=pZIUiemfeRSmjBowUyr6y0HQ1exo9wF+RQ2baa0w9BBFUvp6hLNowE0YPaEQJF161ScNf3klplencr2hF8wZu0b4WZi8ESmI6GkQ9OjvZQHDULKn//YU612IX4Iyi27BqZ4OUSEObI3Z74Jks86ppQyWSnKN73mynJh5ArGiS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967126; c=relaxed/simple;
	bh=EmXGiKJEIoO+qHojiG3dKSYpWbKio0puEzSvAHBKCMA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IxlnevSQQjpHlaiIuyhmncpm8Vzpmom/ReInKGtqZNXvjp/I2O5L0As3yWKLeRy010T/0lhosieodH3u3iyvYptudQv9kf31Y+/Nnb14Lp7ObcoA0HxydPisV4Mq79UQt67FzJo0h9W6MfaduvJWgKV+iE4Gmn45+4K3zjVbM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2GijfG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CF7C4CED1;
	Fri,  7 Feb 2025 22:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738967126;
	bh=EmXGiKJEIoO+qHojiG3dKSYpWbKio0puEzSvAHBKCMA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F2GijfG8XATGwdf9Hx/k9DnJjWC8jFM1W03GOKvKiBtSBUic6TXIIEw1uDBBSrCQ2
	 Ex8nx5eVWcd6GebdVA8oMhR/fD6Bz+DxT7NS5ulHV/Y72REUnkhgJx8c6ZInNuSOLc
	 KPTqM/YeWhjVX6raKZkK/ffegDuWaajE13utJS3n6qRr1UIwJeABViPnqoWFziM78F
	 7RCou/ppH5dgpXwmTgPM3kEqyc/Obd5vhgBTqO8GopBiCfezx9cUmhM18kpDN0MfKi
	 nVw+az8UONlwHRLVfRFIa71pA3aeKbMhtA2xywS7mSgOk3SvidPP6WKeyhvEchw9K4
	 GMRBfEWj4/rQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC0380AAEB;
	Fri,  7 Feb 2025 22:25:55 +0000 (UTC)
Subject: Re: Re: [GIT PULL] bcachefs fixes for 6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <usxj7gse2c53ow2a3fxpoi3ygsvu6shpo3huvecih577iaq3a7@os7sfywxj2vw>
References: <z2eszznjel6knkkvckjxvkp5feo5jhnwvls3rtk7mbt47znvcr@kvo6dhimlghe>
 <6491ceb6-e48b-442b-ac61-7b2b65252d7a@gmail.com> <usxj7gse2c53ow2a3fxpoi3ygsvu6shpo3huvecih577iaq3a7@os7sfywxj2vw>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <usxj7gse2c53ow2a3fxpoi3ygsvu6shpo3huvecih577iaq3a7@os7sfywxj2vw>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-06.2
X-PR-Tracked-Commit-Id: 4be214c26936813b636eed2fac906f585ddbf0f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94b481f7671f412b571e4ee5e3b24f33a889812d
Message-Id: <173896715389.2405435.11154971440726329932.pr-tracker-bot@kernel.org>
Date: Fri, 07 Feb 2025 22:25:53 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 6 Feb 2025 22:41:47 -0500:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-06.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94b481f7671f412b571e4ee5e3b24f33a889812d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

