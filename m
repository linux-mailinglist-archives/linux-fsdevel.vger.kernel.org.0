Return-Path: <linux-fsdevel+bounces-36381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8519E2C82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 20:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E2FB2A8C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2771FECB8;
	Tue,  3 Dec 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZJjSdZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6B1FCFF5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252786; cv=none; b=ddZoV03sPI74EbTNNBjoQ8/FIJAuJNsxbk0M7i7RZ9EfwsFtZJx+FPQzpzqGaeIJmFfF/FEpHWZohOcB9bOlj0Ii/JG/K6/UhoBoJ6mervBNO5518BnEpeFHnQSUIFDd0fyQ+q/ZtM+3RveZX30bRgFzH8kv2/EAi2oiPlJmpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252786; c=relaxed/simple;
	bh=rijHm9OZP4ggBudYA9ybZjXtnVk8wZHYbsRSpUPd8+4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ccBGIDHhs/OdeJLRJyJjhNHrzOv/pYLs298dS7liUhyjxsMX9EXDybumlpldngqUeP87gZ2EtympVgzhnkGqu/+Sw3Ie7y6mqe/iGofskWejPIyfLdqNR7Nl09J5aDSS3sFMUxcOcEIqHd6nSix2IkTQBp8uQcJEPTiukrv/6Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZJjSdZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FF9C4CECF;
	Tue,  3 Dec 2024 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733252785;
	bh=rijHm9OZP4ggBudYA9ybZjXtnVk8wZHYbsRSpUPd8+4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uZJjSdZsmjOa0lt+e/tkxNXe5KMxps/RiPLNHzHz6MfeOx4olZ5lyd3k9IgVGW1/t
	 E1cx+DCm+fdMm1F5y8mAFCsrK4WExqlbBDtTSsBD7O+27y0VpzQt+Yw62jnddf05h3
	 lAFN1mgCX6xZad1M+cwOPLYzypuE2nvP00FH/kXGROm2hOnimOppwr60p3QxBAg+iq
	 htGTMMJ5IhdoBc0qlsbxNAory5bJm2QSd15vhDZXF4Ya+8Cf5pvuzbx5wWutGiAshw
	 s6K09dnMKi/MGsrzXcX8a+GHioAe/ICAHPjMCyXvUMjMFmQ8+DS2IhsRZUqgK7ojot
	 LrABgIP5rYiUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714E43806656;
	Tue,  3 Dec 2024 19:06:41 +0000 (UTC)
Subject: Re: [GIT PULL] Quota and udf fixes for 6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241203124941.nstt3sjl7ohygkrb@quack3>
References: <20241203124941.nstt3sjl7ohygkrb@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241203124941.nstt3sjl7ohygkrb@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.13-rc2
X-PR-Tracked-Commit-Id: 6756af923e06aa33ad8894aaecbf9060953ba00f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d2469490912122b1e619c46b720d9cde047b2a7
Message-Id: <173325280016.214632.5195555088039744165.pr-tracker-bot@kernel.org>
Date: Tue, 03 Dec 2024 19:06:40 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 3 Dec 2024 13:49:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d2469490912122b1e619c46b720d9cde047b2a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

