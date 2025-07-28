Return-Path: <linux-fsdevel+bounces-56211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42413B144EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219337AE211
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728F0288C26;
	Mon, 28 Jul 2025 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/2Z0xzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FBE288C27
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746047; cv=none; b=OUFKR+NJsyP/G22W4wcKZIbArerDW/RkLw3Wzm5uSs4Dni7ddI4v2VLZLJbEISKyQyftSNIFWwlRviO+ztGNKRPD6npGzOF6Le7bhVGhX1ZX9on5dbieW6YJmSn5sf3U42muwiI4BSs8CWc8mgHA1rESsECyP+zxE2vCpDz2tDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746047; c=relaxed/simple;
	bh=xFzB4wxFPlORoAMgNopSI2IaWU/qnvM7F9POje4zDdo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LPJpA1FN5Uc1AtS4PpQIg5m+c7BCBmWLCaGrHQagDCExznaS2yeXgZ/GypqeAXp9KodpV/OdqanuBaTtis7T5sNeF+d8L++DCYoZE6nYH+o2Zcs6tJJZg+Lyikw3QBpxTQjHxfVXUBgNPG52RuOuHx0P6rogjUh9WudATOiOZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/2Z0xzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74C4C4CEF6;
	Mon, 28 Jul 2025 23:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746047;
	bh=xFzB4wxFPlORoAMgNopSI2IaWU/qnvM7F9POje4zDdo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P/2Z0xzXwAKaz7Gb+u9Ce/4j68i5nP0H4jVP1be1MreBdDtZQGodDgZqzWwyYTcvL
	 ux67KayymuS8oBVDlWwM7Toqtz3K042Jc3h4kgYc2uTHsebrGQFihjZtPU91NUxcAU
	 9DZ8WqAU023R5SHJd5RDsXv3fJPuzVvUwqm/yW7evmn+bp56/q6y7X+fL6j0Fk5Tdm
	 5tD5N5WtdKqPXN77s2WIYkYC4seCUgAYM6jDy6VaFoyISvGGmGspR5LwY/yeBISa6c
	 vcFSU3Ewe+HdilQCAgRB5hpjS7l1atDaE8/VieLwcZcbsKxsWeNf03hLqYAksCvqhw
	 DDlPT5e32n12A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7AD42383BF60;
	Mon, 28 Jul 2025 23:41:05 +0000 (UTC)
Subject: Re: [git pull][6.17] vfs.git 3/9: rpc_pipefs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250726080326.GB1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV> <20250726080326.GB1456602@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250726080326.GB1456602@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-rpc_pipefs
X-PR-Tracked-Commit-Id: 350db61fbeb940502a16e74153ee5954d03622e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddf52f12ef500d9f2a5e325e0c86449f594abb25
Message-Id: <175374606438.885311.4707906452951843982.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:04 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 09:03:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-rpc_pipefs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddf52f12ef500d9f2a5e325e0c86449f594abb25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

