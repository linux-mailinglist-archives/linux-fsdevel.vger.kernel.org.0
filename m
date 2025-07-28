Return-Path: <linux-fsdevel+bounces-56195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C65BB144D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054AE1AA0ECF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A126B77A;
	Mon, 28 Jul 2025 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEUDkQLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC38263F5F;
	Mon, 28 Jul 2025 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746027; cv=none; b=OCm3gmkEmKyzMhFLHJVFrPssSSiPeaqWsyu/QQazpjYjzKYeL+eDA09AhvwIqvBcpQffLyCFq0IWJSNIJS08+rySVN6v5vFpatvaQJHuaIq/Af7ukyyuh+WhLJCQX+kRPhpiogGLyXqwBvJAv85nBX7/OA2gAvvsG/BaV+siPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746027; c=relaxed/simple;
	bh=wKwI5YPIwCqD5La/1TIYe7LiS+MsyJOK9nfxpol3Nrw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rn6clBAvIuXMPiD0DCR4BL0ELXS5o80DofXMdtUFRYBBBOwZ4M/0FlZUjVllchgoF7NbJaLDFtDMqr3G0yNba3vT1yPt0DI7v5swRcvezFE6Dh86kPsrOUfj2hh/WE/ThXJtpZfp3+O6cMkvVdc+K9SR63y2xZa8xR+kBzzae8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEUDkQLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DB4C4CEF8;
	Mon, 28 Jul 2025 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746027;
	bh=wKwI5YPIwCqD5La/1TIYe7LiS+MsyJOK9nfxpol3Nrw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oEUDkQLSxSeLsnLIClDxgGZh8O1BdQO2DKt+taNUzAp1FuqKn49Y3xGeXOGZ20O9h
	 nyMR31s6NJLYJtcmim/BScNU1LaHf7nuX4R9csKd5IGZ5fhelOQkeTgcyuIeu2RgZa
	 MpThkjjOAXWtlqzkFY3K+/Btz489o89hbcAJeBVe/XRXox8OY1fpv9V/z0RwzsQuSJ
	 7knzzIB7W/o94avl37uF6EAGO3km5JQJxB7ASgkFiCxKzkTI7PsrQl92ZL86SGIDM/
	 bBG3AQ5k1tBPYEqb+UcjMR52xEmiJgwPBPlDaWRmgqvzXNvW+xPMu2nQ+/GBTEawAP
	 WDNRq0bCYx2Lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E766C383BF60;
	Mon, 28 Jul 2025 23:40:44 +0000 (UTC)
Subject: Re: [GIT PULL 09/14 for v6.17] vfs bpf
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-bpf-a1ee4bf91435@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-bpf-a1ee4bf91435@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-bpf-a1ee4bf91435@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.bpf
X-PR-Tracked-Commit-Id: 70619d40e8307b4b2ce1d08405e7b827c61ba4a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e7bc8335b1486e5b157e844c248925a763baf16
Message-Id: <175374604388.885311.2195957832105245600.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:43 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:15 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.bpf

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e7bc8335b1486e5b157e844c248925a763baf16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

