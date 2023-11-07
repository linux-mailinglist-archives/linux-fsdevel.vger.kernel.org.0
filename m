Return-Path: <linux-fsdevel+bounces-2309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129BC7E49E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445331C20CCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B331834CE8;
	Tue,  7 Nov 2023 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEBC6PQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5DF3714E
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 20:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FA95C433C9;
	Tue,  7 Nov 2023 20:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699389255;
	bh=vj5rxOVBf12tK5DfuAsYccz98MDtN54VS7UQnR88b0Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mEBC6PQbkoxkc5EbZTQfX7Pp+5DMjwlodl320hLggIPJv5s+VK+wi0E10kNhjloaj
	 65XiOjntkB55SVQbvWf+DQWCmaDF/M3hWV1/CqiJfKLWNNKMkGLSuZYD8BBlBGn5SL
	 +JmtbbSukXwNuDNbHeQkUnNhErqDakXm82JGzvTfaM6MBEUq5jw3E2NM9Pb7j+mDHt
	 8vXGNCPyxmOoCKpd3ypnUMM1of3brHwOjYOrNxewjgC62TlMnVMfoxH2WZd0tT4BZe
	 dQg4cWt8ORkKNOPNXg6vi/FcXXlq+lb4Te2IIpH7EK1ssHjATSaOE7R7/3+snMD5rf
	 MXlLH2AUefz3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C23CC395FC;
	Tue,  7 Nov 2023 20:34:15 +0000 (UTC)
Subject: Re: [GIT PULL] vfs iomap updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231107-vfs-iomap-60b485c2b4fb@brauner>
References: <20231107-vfs-iomap-60b485c2b4fb@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231107-vfs-iomap-60b485c2b4fb@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.iomap
X-PR-Tracked-Commit-Id: 64bc7eee421fafc5d491d65bff74f46430fe61af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 062cca8915cad56aabb11206a4a5082856167fc0
Message-Id: <169938925537.27832.4252131599876978630.pr-tracker-bot@kernel.org>
Date: Tue, 07 Nov 2023 20:34:15 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  7 Nov 2023 11:18:34 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/062cca8915cad56aabb11206a4a5082856167fc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

