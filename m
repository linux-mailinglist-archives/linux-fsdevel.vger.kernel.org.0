Return-Path: <linux-fsdevel+bounces-63044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA9BBAA753
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8CF1C6869
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FF2571A1;
	Mon, 29 Sep 2025 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcY55PrM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDED24111D;
	Mon, 29 Sep 2025 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174271; cv=none; b=QCYHzSXPCooq/rRWBt2nWXLdAYQhRB+shQ4I+c5SlwQTMaqCgrVG0yYw860y+1fHI8vI/e89Lw42oBi99GB6CfVmnBD33ujAQ49LSsaz7JK8FNFuIH/G3bcNPDoOBrVGjrKm3oHpwW2sSkvhUnqzr3FYr0RwviqCM4y9MQ4QkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174271; c=relaxed/simple;
	bh=0wZTg7Ehta70cr2uXbMp4oy8F+F/oLSPWp7xbZa6vhk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L0nyVkiwa4h6OC+1Mgi1QC7sq0hzhZs7OXoPTzjiWA3v34GriKG4PnTpqHEzWIIeB/Cav7CNC3rTy1CnFYDY0LxyllWd7AIzXL5bH2oLMK7ep4PbD99Yfk5N+T8bfvdERTyGxvkv713CiV8dLaWPjdIRvy7LdqyyGSCIBmMSidk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcY55PrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E025BC4CEF5;
	Mon, 29 Sep 2025 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174270;
	bh=0wZTg7Ehta70cr2uXbMp4oy8F+F/oLSPWp7xbZa6vhk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BcY55PrMAO/gsKXicyT+27w6EyXfv4GHRraOlHcEVm8m6Ua93PZGlq3oNxlgurs59
	 hArAaNl3lLe0GlSo5GhjJdYbjGWPXFIeUcsJhOkGhiP/Ox8REJXt8G1T/XZ+rbRGXR
	 kaIBvlzMlnBvDjmwvqLSYYLtADt2BWtIV4VYgDhSOA+vetjiEB327AVGhI4Jv1k7Ea
	 t2KXnCqh6wBc6NDyxGSjlbtfg9WqE1+af1lsQ7lfqLUszIDLlVs7HnIuTFI/vLFzXY
	 OAZMvWzO59A9jnNwL5jEcGDszS4h4rGvZjWnm34qFa1L392ZiIJuWjYplyDiHOmEFG
	 Bx53rnxWBMwMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0DC39D0C1A;
	Mon, 29 Sep 2025 19:31:05 +0000 (UTC)
Subject: Re: [GIT PULL 02/12 for v6.18] mount
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-mount-743c2ca07c6b@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-mount-743c2ca07c6b@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-mount-743c2ca07c6b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.mount
X-PR-Tracked-Commit-Id: 1e5f0fb41fccf5ecbb5506551790335c9578e320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a2a5b278fb8d4cdb3154b8e4a38352b945f96fd
Message-Id: <175917426433.1690083.9031480693092022386.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:04 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:18:56 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a2a5b278fb8d4cdb3154b8e4a38352b945f96fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

