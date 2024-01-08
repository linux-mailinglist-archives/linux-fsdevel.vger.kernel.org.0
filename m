Return-Path: <linux-fsdevel+bounces-7571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77268278D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 21:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635ED2845B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71BC55E4A;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4Vh+GxB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916355C03;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C4AFC433CC;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704744006;
	bh=eWx8vY5Oe4zjPmp4YDGiuNfIOIrB4+BWoZ7PHiXn2+M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N4Vh+GxBOtIm3CS0toGaK909UCcnBTFWgqSofCbSvfT7Yi9o055XPi+Gpzih/TLSg
	 Tyvo9WAo1hf3QafoC3YfCFkzYPRkGUVJWECg+ogQEQ8AGetYy691VjAbJcpnG4y0Pb
	 BstKiFXY08gtArOEls2+nUyR8RfDNK7Miq1zN+m7GD4IehKX+Vfe3moBDERD1gX6DZ
	 PPiCEQoHvpnKl+urAuChmROn5Ip4Gts+/NVwk5PE5j2EUUVWz9+yvi0JjVVZwuijqU
	 nJly4ry68OcOhNIZt0vcX0OCebJwPqVWYJM0ihQUFUXt8wdTFWFlknxkmDAYoQCdqi
	 BgGa4aoTmvmOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3217D8C984;
	Mon,  8 Jan 2024 20:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] vfs rw updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240105-vfs-rw-9b5809292b57@brauner>
References: <20240105-vfs-rw-9b5809292b57@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240105-vfs-rw-9b5809292b57@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.rw
X-PR-Tracked-Commit-Id: c39e2ae3943d4ee278af4e1b1dcfd5946da1089b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb93c5ed457fe76597c14717eb994fc5aef22716
Message-Id: <170474400592.2602.11869253886155922778.pr-tracker-bot@kernel.org>
Date: Mon, 08 Jan 2024 20:00:05 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Jan 2024 13:49:30 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.rw

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb93c5ed457fe76597c14717eb994fc5aef22716

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

