Return-Path: <linux-fsdevel+bounces-49867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97162AC43C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 20:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6102317A353
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8319E971;
	Mon, 26 May 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBnFpJ26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589DE242D69;
	Mon, 26 May 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284525; cv=none; b=f0tLv3MXt8dymx6cExnrLuqX996KfeU8CMd6ggAcnZOvaaGAHlXnrdG7T/PNDnnBPjaECRp+x5R1cqihueJm5fDnDYhp74MjK/TwoewHyMCU272QEoC9ks4kE5/x9l4JO/2G5SmtZBUUescOFBZHNNi/95L/66D+Ab7Ms3cNAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284525; c=relaxed/simple;
	bh=WiRVseoIFebDsOWsSa93U5N5iYcPYmygSoRHA7nNapE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YF1thHBI2kYdl2/yZqCNqHNGjeRV2mZ1dQ1dJNenA8BXfbzi54vFvRJBaCecH3KV1Uetw/jAWYlT08BbXqJV2qPhHbhthp+s+XW+xflkxjW222OkackXaMUCN1dYDSCDuWELnQAPCxXqzlgOBo56rLT35enmLSsicVMgUgXDhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBnFpJ26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36259C4CEE7;
	Mon, 26 May 2025 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748284525;
	bh=WiRVseoIFebDsOWsSa93U5N5iYcPYmygSoRHA7nNapE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aBnFpJ26Du90wFSQcTw6MUcbEU8ojfuYoKuzHLp+Wb3iWm2a7s/cScCnB/UUWjPIN
	 KLVKcmsWUVt1Ur3fFGlNxirfsk41beN34vd6isLd6n9vLGD0U+mDzMn1jjcHIi+RSr
	 GmYm5kHJigItRgB3LytcxFEXezAhLSCTGTnBK57HEqlGHSaZxXp0zkttglcfWqYAXS
	 HQRQXrP592CMVnrmX8eF3omTb60FhHXmd33LSj5CuWBzsof2GlU2EeELIKgDLc5e0g
	 l6IdlSVhOTYFuEdsfPSTXSWRYnfbY6WoY1Avoohnte7fe9bfw3HTcmhrymD7YHS+cv
	 ZtRxX62NpzE3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACCF3805D8E;
	Mon, 26 May 2025 18:36:00 +0000 (UTC)
Subject: Re: [GIT PULL for v6.16] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523-vfs-misc-bd367f758841@brauner>
References: <20250523-vfs-misc-bd367f758841@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523-vfs-misc-bd367f758841@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.misc
X-PR-Tracked-Commit-Id: 76145cb37ff0636fdf2a15320b2c2421915df32b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 181d8e399f50c0683b12d40432bb6e1ca5c58d37
Message-Id: <174828455960.1005018.6937004970156900749.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 18:35:59 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:40:22 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/181d8e399f50c0683b12d40432bb6e1ca5c58d37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

