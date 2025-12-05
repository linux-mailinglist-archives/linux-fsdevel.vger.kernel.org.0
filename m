Return-Path: <linux-fsdevel+bounces-70914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43953CA9783
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 23:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C39B3302D6D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 22:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279512D7DCE;
	Fri,  5 Dec 2025 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQBVIf4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D22E8B81;
	Fri,  5 Dec 2025 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764972892; cv=none; b=Y+p86KlVZFBtCiN5dYr9ZRxThEEW1VBQSRsBydNVFjIBcPuhz6/skh2yl+HfSEOkld7P0FXPwUMevkmwnL5PO2W/VjNe3YAbjZtkRmAm4hWOSYNTEuYWSzAmpZeY6OJHC5IPwEIMTdu2CY3lbyxro0hB2ZLPY1wnctszEVZzoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764972892; c=relaxed/simple;
	bh=zG3vsTVUNDs4hl1Q+AiE5hXX1An+Cs4i4Bh9yUvl/fA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rGfQPWFHlfzSY1+x2gXpJPyEodiDEoQqrQj8RajQfh3jDQvlZH7AMs4t9HVnLTMVdb82d/UOVccnJQOWRp9McSJo0cmd3U/F4om9B9MshSODuAbH9Uw5EXtatMTCx+Uy7WasciEHt0eFRAG/vtVO0as0n4zf+eAmNS3dZ/IGDh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQBVIf4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AB4C16AAE;
	Fri,  5 Dec 2025 22:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764972892;
	bh=zG3vsTVUNDs4hl1Q+AiE5hXX1An+Cs4i4Bh9yUvl/fA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cQBVIf4yjJEhi+7fv5gC2LGNs9KfSSKTdcMVEYV1BWvrP7DRqZ9jJKzfF0ex2pk/6
	 g4V/VK8HhQSFAl8khi8ZutOkvpASgvwRd4oV7q6jHpf+Q69z5mv6I5HxvQzA5FqM0K
	 4QgoZm32IPBPu0SOw03wf6W3bSwwagIF3dEnx5Nf9n6yS2KsQQCryoegvuO9+7ygCC
	 G3kyyECha1S2N2vIZYLYdrC6vHGXHOwmcf7sdYGjV3fNHcP0dRddu8BSefwPWvCeB+
	 dCSXbxC+7J47jlGz3ivLma39bMpoK1Ighb+mWgdix8peSHp5n+Kxv4fClRqAWMFqLB
	 CQX0YgnaLpdUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0863A3AAA0DC;
	Fri,  5 Dec 2025 22:11:51 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <tqz52ig2b5jas3qqt6jqqek7uwyg64ny5qnwy6gclhgjcy4ltb@s7jiay5vyomg>
References: <tqz52ig2b5jas3qqt6jqqek7uwyg64ny5qnwy6gclhgjcy4ltb@s7jiay5vyomg>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <tqz52ig2b5jas3qqt6jqqek7uwyg64ny5qnwy6gclhgjcy4ltb@s7jiay5vyomg>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-6.19-rc1
X-PR-Tracked-Commit-Id: 564195c1a33c8fc631cd3d306e350b0e3d3e9555
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac20755937e037e586b1ca18a6717d31b1cbce93
Message-Id: <176497270984.1834065.9412427641995783546.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 22:11:49 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Dec 2025 14:27:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac20755937e037e586b1ca18a6717d31b1cbce93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

