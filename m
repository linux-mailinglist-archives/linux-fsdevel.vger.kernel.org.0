Return-Path: <linux-fsdevel+bounces-63406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A9CBB831D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20F063484EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89B127A93C;
	Fri,  3 Oct 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGSXpVTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E826B2D5;
	Fri,  3 Oct 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527077; cv=none; b=dHqd/Dp6SQoWfSNNS5WuPrr5Q6HTeLf+f2xBOeaMenH3znHpIr9C7zQgOFcNYH4EQ/PlsaF3QHOusTXhQW5fiyQZHIwu8bmV4Zacd4+MUas6smvh7izDfEKT8cVK7E2dpAbzG/rII4216Hc8Kwpc93YxCFV1riQMmI6q8gL/284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527077; c=relaxed/simple;
	bh=n8o82dyP4GM8eyAZaZBpoTld/aybbv5wwM06ltTBiZ8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MHeI+vuQy9LpFwzVvHqNz/OQjSGOwHtgd/KWRAWIdaxE1QBLKFGNNpb3UrZQYwafvyuPesEzwNu9GTQJuvGSXLm3MivugfOEyzJPAo2KMuZMWnCZCDsHgM0R+KFsywhNdp53CG2p7aqMvltiuEBgBj2ns1Z6HPGcLB8ckWhHTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGSXpVTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EB0C4CEFE;
	Fri,  3 Oct 2025 21:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527077;
	bh=n8o82dyP4GM8eyAZaZBpoTld/aybbv5wwM06ltTBiZ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jGSXpVTdg8jkbfzIL+EBNfeBq7DqKUmRbdtXwi4zQXS6p5CHFtfWT//fhG8jLehlc
	 LFUGiG1G04wIyleKAzsnyynEUdepFnH6qZ5idmk5l4x9HZQ7r9yYs3H2BlcFgLVsAv
	 2UFlGNLd41FDU24i2Y3ztwnSWtikmdxSNqVlIt4hLNlVj5wrg/dNz3fxv92f9hEXKg
	 BL5zngOflsWKiBWsKo9kUzL+dTduyVQr9h9X2W4yiVriNgJbxVcgG4NNhAYMpfi8jc
	 tOeQze1oIJF0Vw4cHXBM6x4+Xpj/jOQzEyF5kUxUp8a4NyE5PUPM3BNzqvJx4G0LSE
	 RhGrpJyct04NQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 99F8139D0CA0;
	Fri,  3 Oct 2025 21:31:09 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250930130833.4866-1-almaz.alexandrovich@paragon-software.com>
References: <20250930130833.4866-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250930130833.4866-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.18
X-PR-Tracked-Commit-Id: 7d460636b6402343ca150682f7bae896c4ff2a76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9b38767c607e0de219b66a2b1ba0cb37beaba08
Message-Id: <175952706827.82231.708668137387633081.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:31:08 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Sep 2025 15:08:33 +0200:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9b38767c607e0de219b66a2b1ba0cb37beaba08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

