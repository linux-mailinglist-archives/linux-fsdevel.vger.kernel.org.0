Return-Path: <linux-fsdevel+bounces-38474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F8A02FD8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946401632B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1511DF244;
	Mon,  6 Jan 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NewuOnMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7E78F4F;
	Mon,  6 Jan 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188787; cv=none; b=pA8q/vGem3QIdtTKd3s7uY8mH/HpFq91gi0EnxmIzwVsRQCe293SynysCNgnVKcnZyklSEZHI8W4/zLUrsyGhNy+a1QdLAL23uH0dcsI9tDaUseZDXZWweVJ3kJbox6CJPDDczEOOF/ZpWpbScOk+cis0doJsn5/ck4yjR/YLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188787; c=relaxed/simple;
	bh=AslY3wZ78B9Inc6AuPnpKlP2uRvDP7kPnwqfno6COvA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W3GAk5rkgSf5dH2yD04/wbvXioaEJUYWfsVmVib7o5Jlsy49tDca4n5Oa0B+zdUsdiRAWlLD14fPQIF43SbFQVdsg6oeQY7n1AWoMyNJEX+6WDHOm9hvetR5kj7J6BJNFrscw7o8RgJhwq3aI7tZYU0XyT+xYnkP+8hyh0K56KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NewuOnMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7859C4CED2;
	Mon,  6 Jan 2025 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736188786;
	bh=AslY3wZ78B9Inc6AuPnpKlP2uRvDP7kPnwqfno6COvA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NewuOnMV36pIFupH1zRm9w1QfPPX80/OcrCqeGBZIej6quMZOeZcQeyZw7NRx2riv
	 fSLWZnHtH7UklLeW7NciCGmrJj88HUTobnxyq1+DbL0Mk8216tBD8GK4C7gZaIla9r
	 bTTmFDEZ0e+bxLUEbCkGV7bPE48uK+A6lcYpB/yqysKZ+wXB8D8nemXg7cG/Bzs8fD
	 z4yaOxWlm6kuaaoCF0pAKvdo9nHz6Xd89+GycMpAg0LJuez2+25JBmHJhIKs86RKrp
	 qYDewrisXFwAlqzsO9fJXchesaiSUUoaI6RqfmfBRnSSyKVCMbf4yT5wmPQS4mn8gX
	 hCX2irryYdz1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 351D7380A97E;
	Mon,  6 Jan 2025 18:40:09 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250106-vfs-fixes-5a197ffbc262@brauner>
References: <20250106-vfs-fixes-5a197ffbc262@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250106-vfs-fixes-5a197ffbc262@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13-rc7.fixes
X-PR-Tracked-Commit-Id: 368fcc5d3f8bf645a630a44e65f5eb008aba7082
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbfd64d25c7af3b8695201ebc85efe90be28c5a3
Message-Id: <173618880778.3584486.12246878445845766527.pr-tracker-bot@kernel.org>
Date: Mon, 06 Jan 2025 18:40:07 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  6 Jan 2025 16:32:26 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbfd64d25c7af3b8695201ebc85efe90be28c5a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

