Return-Path: <linux-fsdevel+bounces-50936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2CAD13E2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 20:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4793C3AA6FC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E7E1D5AB7;
	Sun,  8 Jun 2025 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TS6l0sXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1C1A314D
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jun 2025 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749408777; cv=none; b=h6efNw43EGKiDEQBGC1f7KCcd+y/LRxyFnPAyjRzxOaa+n01KsNBs7msqsLzPZ8qiTMVu+yImVJGb+ugYaBpqy4yAghqbN4gn0t4lQNmN17/PkjjYB9kEj2EdJhLDr7b5cI66HIGmtHqHVmhLfkfltHaOLpyDO2qt/b2cn9mMnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749408777; c=relaxed/simple;
	bh=5xxfUWv2pYd0pUg/YpJmqlBzmk/b2kA6tD7WAbftdxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ag9CZW7ICANYucMEUF4kivL4bsvtGLop8MDSSLB20UVNsFB0McuMN88StqOHD3/EzmWjAae5nbIOYIPy1qt/mnSRv9pZ+xI9H/tj1IH7ykG73XjDm6XCeW8HsHawOafr8Z3JSlNbpNZutCWJPC4R2nHoNDua8XlWw8ksdt8jT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TS6l0sXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DDFC4CEEE;
	Sun,  8 Jun 2025 18:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749408777;
	bh=5xxfUWv2pYd0pUg/YpJmqlBzmk/b2kA6tD7WAbftdxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TS6l0sXpjCFEJyaicWx2KSZlIbCgl21KJG80Axy+rMfzMUIJgxgxqjlcd9sRYNywh
	 Wu3Ej1jttp4wlyt3ZeVrEWZKR4UaukZTyslAizTdNZ/FklyeCsuqtgKl7O7SxXs6Cd
	 IE0giARoqzbN8tr/aXEL58mHcMZW4qb+FrkLEkUyXop9DUK+5j0DKPhmFAxQibGe1k
	 JXn0AbNzMOilpcFyRaO9LajvJDw2NysglOGXIEMcA7lG2G2ebi5Hq73PxbhimNmcYz
	 V87bxXpWbE9oArwl/bVtG+uD0IHA6NahoIR3zdRwsi0QN9tTyRu9X0+akAZegosKqQ
	 R1K3YbxUvHSxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B75380AAE2;
	Sun,  8 Jun 2025 18:53:29 +0000 (UTC)
Subject: Re: [git pull] mount fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250608172409.GA299672@ZenIV>
References: <20250608172409.GA299672@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250608172409.GA299672@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 12f147ddd6de7382dad54812e65f3f08d05809fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35b574a6c2279fe47d13ffafb8389f1adc87a1d1
Message-Id: <174940880779.385950.5612221110759217903.pr-tracker-bot@kernel.org>
Date: Sun, 08 Jun 2025 18:53:27 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 8 Jun 2025 18:24:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35b574a6c2279fe47d13ffafb8389f1adc87a1d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

