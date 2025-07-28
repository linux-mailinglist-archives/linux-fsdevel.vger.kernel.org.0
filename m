Return-Path: <linux-fsdevel+bounces-56205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC37BB144E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B2B7AB7F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03B287242;
	Mon, 28 Jul 2025 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4v1+FnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB42868AD;
	Mon, 28 Jul 2025 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746040; cv=none; b=prko3OimZ6K+99RpKyPvAJ122kylh0IXNCtWVXpCZM+7CHOVrHa4LremqTpg9KzV9Ok/vCuTH5h0PmGbLqzmRPGTzmNveZugHvC98go0RUnUGSnTxaQx2wmHa6xq63OTbqaQE1mhJGOVSH2oFFKj+iRiiJe6A4dMqpm59dUvHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746040; c=relaxed/simple;
	bh=w/BxmwLv4cPbyOGKzPIVykjUUaSYvwh1ofvEhI1r71Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ey5w7h7O6HcYXL6vVJXMQb0vbEzWR4n5ZZOebAaLh/mkO8wE10ydAltf3nByOhKqe7cyXLUC+0NnbNgjGCaD8UdGlc7dadWTvTgL8wBBTYKrcddTwPcP0lNzCyfEffuZ41eDgiUH5I0Ve9xgY/RsDBL2jpkJGfA2d7+ldGWU8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4v1+FnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE24FC4CEF8;
	Mon, 28 Jul 2025 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746039;
	bh=w/BxmwLv4cPbyOGKzPIVykjUUaSYvwh1ofvEhI1r71Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h4v1+FnV5gQ5XUb2XWHZEx7y/PJd3p7fx/r8HAiv27gszxnzvQHNUpbMASS/Wx7CH
	 O+smFsXaql5S+tdO7IWj54Lz0t7iSDs9/jex3J1P4akEeN8rc/5tBvDD9jZDk+ZUJ/
	 BNrkjkCXGQpp3IEoHxLiWkdstsyyyt71agKFEV+KovmpyPUF7YRn07/6A2jsqNX/YM
	 txj/ZFd3XqjZVMn5d8JmLlqfSg0su/Xxe7a/ybfte31fwxLahSAN7cHg87k6myKUUW
	 vqM7TYhqQetY7zKXPZSHRAm00Llj6Ua946sH052K/HV//GqS6PKM+9MaoLw2WwcDMd
	 NkPZBezGmxpYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE3383BF60;
	Mon, 28 Jul 2025 23:40:57 +0000 (UTC)
Subject: Re: [GIT PULL 08/14 for v6.17] vfs pidfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-pidfs-ef67d98fcc31@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-pidfs-ef67d98fcc31@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-pidfs-ef67d98fcc31@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.pidfs
X-PR-Tracked-Commit-Id: 1f531e35c146cca22dc6f4a1bc657098f146f358
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 672dcda246071e1940eab8bb5a03d04ea026f46e
Message-Id: <175374605664.885311.7604183476243161683.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:56 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:25 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.pidfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/672dcda246071e1940eab8bb5a03d04ea026f46e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

