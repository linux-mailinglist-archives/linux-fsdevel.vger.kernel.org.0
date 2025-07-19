Return-Path: <linux-fsdevel+bounces-55510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E515B0B151
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 20:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E37563644
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102322877D7;
	Sat, 19 Jul 2025 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1D+T2Cz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624161F956;
	Sat, 19 Jul 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949724; cv=none; b=YTA4pUzs+HX3h4BLOgcp3xZERWmVGU6EDBB40VcVL3n9AmaCjyNnFotj6eUcHZv1nJh4Zf9WAu4rao0Peqgzz2PmLrGdaaLPjuoy/AuljxM4E55MhBaBZCfEXuZOs5U+tLF8oIDN/35KrrVGzIR+6y665LltzSct6Fhd4bZYD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949724; c=relaxed/simple;
	bh=IYrHKg72lldkPeja1UrtpKiT0eU9aoC95HinR1kTQ6g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FTsyqVc1FaxWbbI9DVLAkao2qh10/1J0x/cBrliPW9m/A9BxLpcmapiWPUhPxUxxP8O6dK7VymL+OOmnFHELca83kA108gUb/awfd+EtZf8523v/ku3SwWX/PVAx7sJect5sXp1YfzhxXc4/RQIKaIcIn+cTmawhIFumokeMKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1D+T2Cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D98C4CEE3;
	Sat, 19 Jul 2025 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752949723;
	bh=IYrHKg72lldkPeja1UrtpKiT0eU9aoC95HinR1kTQ6g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s1D+T2Cz1DIL/TkTXaXP4ql0xuYrh6EdgQuWu+XLxEDUYpGEnSWRew1cSwgX3fl6T
	 8xgzHlXn0Hhk12ZQcUW+E6lCgFyC5QFcZ7aqc7E7BRBF5XETG+3szAbtkeg45ByMli
	 rbh+sS/iSfXFKc8cBZsTVFC83UBARNBvrlsxDOO+0AHAWVd3AgjAFsmo+iu2ZelZj/
	 3g0GffwHkhzT3WlKUnNMhQkW9m0lMoGtq6kid+SzRo8Soat8ttJogohffzzTmPmjS1
	 px8x98e5O9dqzODSTAVLwAqXxLvKwztJISGP+QtwCMP/7WNOruqdGS6tZttUI3jiaX
	 bcfvAp3NS5GfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F60383BAC1;
	Sat, 19 Jul 2025 18:29:04 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250719-vfs-fixes-6414760dc851@brauner>
References: <20250719-vfs-fixes-6414760dc851@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250719-vfs-fixes-6414760dc851@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc7.fixes
X-PR-Tracked-Commit-Id: a88cddaaa3bf7445357a79a5c351c6b6d6f95b7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c6aa1121e7a5cd296d7038dbdd619da8bee1cd5
Message-Id: <175294974304.3026904.12392553041916807121.pr-tracker-bot@kernel.org>
Date: Sat, 19 Jul 2025 18:29:03 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 19 Jul 2025 12:59:10 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c6aa1121e7a5cd296d7038dbdd619da8bee1cd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

