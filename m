Return-Path: <linux-fsdevel+bounces-49866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F812AC43C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 20:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4975217A305
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DEF24290B;
	Mon, 26 May 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUH9v+H0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6FB2417C5;
	Mon, 26 May 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284523; cv=none; b=SKCGPe2P6ncMcHTT9q819G8Ys0Rg/6TQH9LzmB8qmuR7nf2HhJY/2VFOH0x2bUrgerWrQtXquh3ybMIMQ8cGYW+WY726yeOs03VEy6+czqb4G225/i2vyIICyekwpxYzbx+wU09sINcXyEoFKcSVaw8Eq2eWH+RrYzzazP8eI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284523; c=relaxed/simple;
	bh=mQ+BnxY4qKJ88hJE4YgBlZx+wVezfmgKRuFfFnnS2RM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Oz+PxDpf4bH8Iowag5zv3IN8ZWNZ59uGlw6InAJH2RvUl6ObutY9z96e3FZjpZl53UEE59NhYpx7DOXYCW/xWpBgnGJLbUD7dzOUhn2CUIe7HX/rl0oBLNp8/6AzexWEgVohPncYqqm941+N7A9CsNVTLlkDtKfmaygYOdrXJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUH9v+H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B19C4CEF3;
	Mon, 26 May 2025 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748284523;
	bh=mQ+BnxY4qKJ88hJE4YgBlZx+wVezfmgKRuFfFnnS2RM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DUH9v+H09GIL/+yKUKBF8gkALtMTXQDcI5qXMrcqHtXYVvUO7ROZQ3szUsBNVk8rp
	 3W+MAsGvJhMUb8KSXvDlzO50EZklhiPiIv/aTlhjptnXUhE7/6aQJwIL6lRNkOUbRD
	 GwUnSpGE8m5qNPRx1HuQrQncbwAwdca4uESM1RnfG7cNtPwmt39YqQ0He1iEybl+So
	 BohKlyhVLXv9KJNodr0kWBLgYvODCZLfhQgo2XhFb5O5S2jU7Ay0fCDIp8JtjdAmE3
	 tL1fzEdGBg6XKD6taKEEDz7WaAm9bLsQKN4P7eFBJKuaVJK90QEVEGH0Ey9+5o/xbK
	 PQU3lYCeJfmWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B853805D8E;
	Mon, 26 May 2025 18:35:59 +0000 (UTC)
Subject: Re: [GIT PULL for v6.16] vfs freeze
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523-vfs-freeze-8e3934479cba@brauner>
References: <20250523-vfs-freeze-8e3934479cba@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523-vfs-freeze-8e3934479cba@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.super
X-PR-Tracked-Commit-Id: 1afe9e7da8c0ab3c17d4a469ed4c0607024cf0d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8dd53535f1e129b7d75c512dc271bff76461ab6b
Message-Id: <174828455811.1005018.18352938677641575264.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 18:35:58 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:40:00 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.super

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8dd53535f1e129b7d75c512dc271bff76461ab6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

