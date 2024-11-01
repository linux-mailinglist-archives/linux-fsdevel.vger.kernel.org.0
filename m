Return-Path: <linux-fsdevel+bounces-33492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 598839B96CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CFA1F22105
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FC41D0BAD;
	Fri,  1 Nov 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDXQjVG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3AE1CB51D;
	Fri,  1 Nov 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483297; cv=none; b=RI/EmO4BjaO4utThWBhxgzWJg4FdrLiABk9Qew58cTKTyptpdcgivzcNtKvNl2SsBqIPAW9fJt/jIQtjGm39OVJ6YfOk/cm+AmXDp2hIYcn7a8N/In9GlRNs86yTQVnrJwXuIe1W1iIKoY9ONP21BDLz+52vKgkg+BEGVGmL0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483297; c=relaxed/simple;
	bh=4TnXP2NvB2+BRndKKl2EPQuavjO6CGzMfoN2w/5tbPU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e2I65kK8T6VrY51ap5lB985W7TVQ0teJ43oC4CRkLRWvENGJImT/EbVtBbQJZswAOThSQypiKD5qU5+1STT47xLZzRpYAdstjn3l29I9lyPyPwAICYlml9Cg/7EavpMwIig9fmSMjgXbH1zoJI/C0teU+y2OzkigoAnj6JGbr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDXQjVG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB867C4CECD;
	Fri,  1 Nov 2024 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730483296;
	bh=4TnXP2NvB2+BRndKKl2EPQuavjO6CGzMfoN2w/5tbPU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IDXQjVG9QwTd0NxxufVsv8n0RVg1uiSusTSTsGRvRVrFN81mZw5cOSNxW4XLbAFB1
	 hZu6UvtL+076OUJB/IPxEy+ivn2B2L2jTHPBp0w3DmG84cvKniu4YlYmG+ElQFIsjW
	 XfrIVJLbqKaOKPWFm/x3CImqmhUgd7Bv9IbZRU0EUbFN2KBPtah54tDMRg5Cgbkqhq
	 hSaLqPvo11snXk+0+kaASB1Wgbm0Zn3vpyCDH/LcbhcYVMl54udXMN7sIMagXZvBtp
	 2DEugJUgtIje1OOQ9cnC3Xw834ovFujjo5PR3wgzEN0EGfkVeml88JwEsTp9sUofP0
	 GExrou98CyUzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FF93AB8975;
	Fri,  1 Nov 2024 17:48:26 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241101-vfs-fixes-11d83463b3ce@brauner>
References: <20241101-vfs-fixes-11d83463b3ce@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241101-vfs-fixes-11d83463b3ce@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc6.fixes
X-PR-Tracked-Commit-Id: c749d9b7ebbc5716af7a95f7768634b30d9446ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d56239a82e3721d38ff5496f2411bf0cb57ece5c
Message-Id: <173048330482.2762608.9965739945739053177.pr-tracker-bot@kernel.org>
Date: Fri, 01 Nov 2024 17:48:24 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Nov 2024 13:43:21 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc6.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d56239a82e3721d38ff5496f2411bf0cb57ece5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

