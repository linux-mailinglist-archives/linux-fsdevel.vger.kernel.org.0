Return-Path: <linux-fsdevel+bounces-70410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A37BC99960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E13B4E06CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 23:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275C2BE634;
	Mon,  1 Dec 2025 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9OdVpuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8554A2BE020;
	Mon,  1 Dec 2025 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764631555; cv=none; b=I6hQpz+A1nrZHvCeh16Fwi3Us6WdX0YjpN6B1L135yFwfV6UlnSk7PcgLmTsqchPJDIQWTf2i3gfhSaw6stQ2iw9Y9ZSHPZdkZ95Bf5M5nnOgpuLiglkQBtdoMXfcU0ho89ijzjEbPKMgsY+3auP0jAC1WA8ZD/2WGk0Nmd+8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764631555; c=relaxed/simple;
	bh=8HnQx6cAH17v7qd/4AwvgPxYuBp5VjFrOcY96tjuqL4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZWqxG6coZbpv6VQOn1IA6bedP3/e+1M2ECGK7FDIbymVmkFwDdJOfD7T4tDRr1UOByYQZFHyUkg5Z3zob5gYAVMh0/+tPvw4gvEUCsqGkufzRa2Q6BMVTBeMeVAZ3lT832rMrlcP83/kyOdOvuG/vaspjfnMiUIBP+uriAbWxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9OdVpuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A52BC4CEF1;
	Mon,  1 Dec 2025 23:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764631555;
	bh=8HnQx6cAH17v7qd/4AwvgPxYuBp5VjFrOcY96tjuqL4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C9OdVpuKQnpvWOjMgAAa2dU+rEbz8Cm5uQMzn2OHmEgjcDux78ije+C3A9nBGNtlA
	 2Lfc6L49RRPGHX+4Ba7W5VJK4N0/Rk4n4/aO6bASnLC8S53uUvjwsp8CDMu7V8nTUC
	 oHQT/i1DZkE0ZYiJYk1M03G42jhhMZWikWkYfz7rSM598p8NfQ0S1VsCidqWi8LQho
	 cF0TwU8IlqNnVmMmrgM+B0MyF+McY04eRmwAQ4RGPylV0ZRs8zv+1L2TP1MDKR594l
	 ongr39rhMBA+IxwmQJbdXn2mBo3+9HD0Mpc+vXO16W7/v+uZJtSzrkN/Qzpp6jgA9k
	 F9sI6Q8tbmEPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8CD381196B;
	Mon,  1 Dec 2025 23:22:54 +0000 (UTC)
Subject: Re: [GIT PULL 11/17 for v6.19] minix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-kernel-minix-v619-c288851ff1cb@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-kernel-minix-v619-c288851ff1cb@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-kernel-minix-v619-c288851ff1cb@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.minix
X-PR-Tracked-Commit-Id: 0d534518ce87317e884dbd1485111b0f1606a194
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4664fb427c8fd0080f40109f5e2b2090a6fb0c84
Message-Id: <176463137283.2594946.10279656749547797480.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 23:22:52 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:22 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.minix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4664fb427c8fd0080f40109f5e2b2090a6fb0c84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

