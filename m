Return-Path: <linux-fsdevel+bounces-35939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B903B9D9EF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 22:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E603284DBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BFC1E008E;
	Tue, 26 Nov 2024 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dlx/yTO1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8AD1DFE34;
	Tue, 26 Nov 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657358; cv=none; b=j4bwW/sldRpph6r0tJjRiXNiyJ9UfnEr9KHAI+07zZkZmfm6uop+ppHEC881UKQPhkiN1W5ZPwd8PuPXVoRknaetOIA9J8bOLJWaciMi5ZXWEIPFbCTKBN2ECsrEImUvFFgLmwUgBuekChnNvtyK/YQ6Mj4EhGyC4sXsZNE0mmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657358; c=relaxed/simple;
	bh=hu1vq1TjRLLF51nyV6Ma2xdtJxoLNke0c6iStGfSsBs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iPAUDqYTk2VliFX8Uyv3e99zxWd7tBDuSgh4o5KVhjuDhgnqNYBTfF9Ix9c29YJzFQmIWAstT5DzcweWLrsfeQQ23gHowCN6SJlxlhxwp9F69Vo3Zl5thnq/ROk6M7pVcWsoELYeKYtui3WDh8So2SElcm6HMKyakKKJhVzsLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dlx/yTO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF25CC4CED7;
	Tue, 26 Nov 2024 21:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732657357;
	bh=hu1vq1TjRLLF51nyV6Ma2xdtJxoLNke0c6iStGfSsBs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Dlx/yTO1U4CepqRsUn0aLkcm8cgYjEsnfgTVaEbtRF8RQfpCN/2Ei7RRyZnt0G79R
	 TR6yeLzKDP+ZwBILn1xYV+NFXTJSaesuQlP6Zp1nBKPiQfQQ2DZWCm+ZJISn5B3sXk
	 s05ygLwYFgGeV/RW5GDetaTXYRC8b2F6HUQNUtZ6BAdafunj6r1FDUBddWoQLMO9y1
	 c8X5x+NvU3cX2kj1S13mChiGn9+yztDFJAIlzT6ErfURpHyMdTIRsHri8c6UCLP9Ae
	 f7wuViQOSBUmOOQnz2f7NOlEwSKBmJCfcRbzxmme5a6p1nDu1RD80qs7kl0yXKQAAl
	 OfOWD5UoA3CQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0DF3809A00;
	Tue, 26 Nov 2024 21:42:51 +0000 (UTC)
Subject: Re: [GIT PULL] vfs ecryptfs mount api
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241126-vfs-ecryptfs-f20bc3c7b06e@brauner>
References: <20241126-vfs-ecryptfs-f20bc3c7b06e@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241126-vfs-ecryptfs-f20bc3c7b06e@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.ecryptfs.mount.api
X-PR-Tracked-Commit-Id: 7ff3e945a35ac472c6783403eae1e7519d96f1cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6daf0882c63a9f9347a1268a042652fffaa99509
Message-Id: <173265737062.550402.17563711289488263463.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 21:42:50 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Nov 2024 12:26:04 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.ecryptfs.mount.api

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6daf0882c63a9f9347a1268a042652fffaa99509

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

