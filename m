Return-Path: <linux-fsdevel+bounces-57564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91653B23805
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03633B3878
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B07629BD9A;
	Tue, 12 Aug 2025 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsGz5xuu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5A21A43B
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026280; cv=none; b=SNZ+0+eBgLYd5E7VM8JD/CiT6jporGlHbIRlf60YQAgsV54Uc+QN9IkdIwcSWYSP6ZX2WkxIsSgsFTqh3bYplBiCPTWhjA/6yAIGKuBX+tJ4GhZR2VfrVFzLxAInK94KVTAi4AHkitIjxqCH4U048H05/5Bwf6EdhtNTkRYLD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026280; c=relaxed/simple;
	bh=GxdCVM5BnQ2CM8G5GDeMqe3Sgl0Uv21M7k062rWSaS4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QPMqxR5Xqx4j7tnkI7PdAjm0QSWQhaPXoaSvfu014uA5H13dOUH7Vpjz5JslYbA2hxetq/hewanY4x38SoIIiyLZh372ZMenu8oc4epxsNMhHhX66iXa8J6TtNo0NyM6WOG2CokiD0ZgvlA6F2wKx92gilBHvLGWtD+rgnJXQZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsGz5xuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2B6C4CEF0;
	Tue, 12 Aug 2025 19:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755026280;
	bh=GxdCVM5BnQ2CM8G5GDeMqe3Sgl0Uv21M7k062rWSaS4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AsGz5xuu/BP5Xuf6djOliQ7up4eu+9gC3Ibrr5vZ/d3YH1BM1Bnikt8qsIbYKJ9te
	 LI4CRg4ZJp8IUKP/66pvyKKwPE6oXvhvAUCbJzie89iMKvy0JFk+/GgpWNfVe2o54h
	 GPwmQhxIZ2gTTk+sxYOQvO9UVCQU+yDA6gpYuTtCDwVQQmwYWttdalIzTAs6ELC+qJ
	 St3uqHUb+54OHetk+Ir4ifnbhnAMl9Tnfeb40CJOrKxrv+w0H00JFpfnmZT1PXHWBw
	 ZbzJoLksW5D6c7dCtmzcTMyYuZrq/rJ5CJ+IqRN8uBPjM3u+pOXC5/abAy2HrcaL9o
	 rX/Q23fFRaILQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7143F383BF51;
	Tue, 12 Aug 2025 19:18:13 +0000 (UTC)
Subject: Re: [git pull] fix for descriptor table misuse (habanalabs)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250812163316.GV222315@ZenIV>
References: <20250812163316.GV222315@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250812163316.GV222315@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 33927f3d0ecdcff06326d6e4edb6166aed42811c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8742b2d8935f476449ef37e263bc4da3295c7b58
Message-Id: <175502629205.2788504.3422137954551253095.pr-tracker-bot@kernel.org>
Date: Tue, 12 Aug 2025 19:18:12 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Aug 2025 17:33:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8742b2d8935f476449ef37e263bc4da3295c7b58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

