Return-Path: <linux-fsdevel+bounces-53052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A197AE94E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 06:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5107B306F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 04:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA3E2135D7;
	Thu, 26 Jun 2025 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJxHZ90l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDE186E2E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750911145; cv=none; b=JdnU0KAXOT8qOXeGtEozVTKFnbukv8D6+1HlUu7g60dP6IW/fhrmvLRmSkxrPsQhXnHykuliYsqjCqmLJ4FSdjWZblbAApUIjK8+DhIflkcZPf1SVyMDWdOT/YrWAxyu2R6R83rqjmjn7o2aZHjH/zkAz70eR1nVyOeO6roQNBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750911145; c=relaxed/simple;
	bh=BzcM2duRxMXnlYbKcSTCrCZ4JjBHkm62iKlwk9eAF1w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EGsfI6PSNWXd6cqEnoCsxJVssYqpZjvVjO/KPop8aHqDFvlyfCHiMqD9meWQ1W1xkirEkWLJAp3rCRRvdK9+qfiF+r4uOdFQwu+1D9vBCxeijJhgcVoztxt27LuLtEGRXKWnpCfhc62QbYTKksjkytx4FCt/QqTfp9ZtksRY3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJxHZ90l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14D4C4CEEB;
	Thu, 26 Jun 2025 04:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750911144;
	bh=BzcM2duRxMXnlYbKcSTCrCZ4JjBHkm62iKlwk9eAF1w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PJxHZ90lzhWFhn2xxpDU5qnAf4OWvEUfzZ4X1Mcy5DweWC+uIs4on/dwkUT35j4oc
	 jMdnBGZiblCeo6EVAY56+d3afhMQHtk1c1Nxpvb920mHUP+DGUJi1uIHpinB4guMiA
	 FIgYWACvrL3dlTYFzeVFyV7dNW2+OJpiE8wWi0F/vvNatLr70APFE989bYX42CCrZg
	 viQyx/WxEWW0tkruRrXTe8dvkSjNhqCHaWdaGyKb0RSD6dNheAj3Hsx8WFhKwiZofG
	 jB0ltBp+WBkyA5IdVwQR+m3NUD16Rz/qYVP9F4xeM5cbalZHUHtX6biKsbLeNNo5tF
	 5jVNqjBK362VQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5C3A40FCB;
	Thu, 26 Jun 2025 04:12:52 +0000 (UTC)
Subject: Re: [git pull] more mount fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250625221524.GT1880847@ZenIV>
References: <20250625221524.GT1880847@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250625221524.GT1880847@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 0748e553df0225754c316a92af3a77fdc057b358
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5c2a8b497d69fb01d2563e383615a4eb69c72bc
Message-Id: <175091117099.711106.11941663383789412734.pr-tracker-bot@kernel.org>
Date: Thu, 26 Jun 2025 04:12:50 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Jun 2025 23:15:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5c2a8b497d69fb01d2563e383615a4eb69c72bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

