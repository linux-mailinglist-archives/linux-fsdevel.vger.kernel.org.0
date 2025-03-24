Return-Path: <linux-fsdevel+bounces-44918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF30A6E513
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0B2189888F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795E31F8BDF;
	Mon, 24 Mar 2025 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csw/MYLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537A1F8AD3;
	Mon, 24 Mar 2025 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850048; cv=none; b=e4avRBTSWHMS4VmLCMKJqPtYzMbSrQGvz8oeDX02Bxesm8fBHoPj1B8IqI9aN2nQvEu2qGUdxH8jt6RBNS1yO12725rwgMLMkZgsrFE2HBguo6kid2Hf15CNM/KlqwaaU5URCk1qptW5av1k1uDGvF0A9M2rPr9IzXaOJh7kbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850048; c=relaxed/simple;
	bh=TEdogaktixv5zYUnlJk1lSblehdgtPRAOGHbP4b9wos=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fufA4fyV8eh9Z1CQ2nJcSRNsfD/4rm98xcJc9g/ELBBE0CuC/qRX8qaZkq/E4oS4tTEvWKsa4ozQ6csLSZMrJslD6r61lzSE8Z+6eGSxPIHjXTUaZzL8kdAU0aKHuSybucIthH9No61GNq3kXMHVAFl4HFFTsy0giD+D28FEM7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csw/MYLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9542C4CEDD;
	Mon, 24 Mar 2025 21:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850048;
	bh=TEdogaktixv5zYUnlJk1lSblehdgtPRAOGHbP4b9wos=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=csw/MYLLUXIN+7hzAflVVK2vfGaNPaQT9lmiC/tkuukzchl0lLmoBQRoCFcVFEfHq
	 lI8QU9IBNiG2AgvMJ/vuTJ4Y3unsWXLrSXPCwx5wEDzEBCG5dNt1KrUedwrFq8sA55
	 bmW5jRTSnclqKxZr7v8CKUIng7ajWMvJLDKweMtvvTVelp+LUD68dolJ6y05ClN17D
	 1h+Bi7/51XmexNfWItfE6xqEq7rjDCYgQ5wGxytixO3ZWQD96o/lQtXLb5/7h++odx
	 ysvcpcS2UO0CWYMDDIM8YcvfvNdVSsVigsmRwwpoBsjNtoEBX9jM7rvXxTgcFAGgcT
	 SLK5Ou8Gzd1aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 30F29380664F;
	Mon, 24 Mar 2025 21:01:26 +0000 (UTC)
Subject: Re: [GIT PULL] vfs rust
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-rust-22efd627df4b@brauner>
References: <20250322-vfs-rust-22efd627df4b@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-rust-22efd627df4b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.rust
X-PR-Tracked-Commit-Id: 0b9817caac1d4d6bf7dc8f7f23ffd95a3f5bb43a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56e7a8b051512da8e7eb5c5a00dcc8e2065a89bb
Message-Id: <174285008501.4171303.10263644371664454187.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:25 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:17:35 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.rust

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56e7a8b051512da8e7eb5c5a00dcc8e2065a89bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

