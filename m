Return-Path: <linux-fsdevel+bounces-56200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57087B144D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380311AA0CD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A327FB34;
	Mon, 28 Jul 2025 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn/AFEfX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85A27FB06;
	Mon, 28 Jul 2025 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746033; cv=none; b=e7MBqne9R6Sak6jNhUK3xpyHsCbme9Ne7gYxUyqfXXlJZ2M5E5me69OsjLFYsImmpKSAoaigVvyKX+l1ij/o1XoCHTetWzOAddvwN8Jj3FpnFPUPmqgbk3pr91TSLKp9EYkaJyi2xH1Ms+j2aaQ8dKnZe+neUelpoR33trNvZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746033; c=relaxed/simple;
	bh=ZqLE7bvfoVPDhvpAEbsyuRCXUF1Uo+l9RI1TzIunYkA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i8xTPUb+P15YcXx9jwBa7V2QGpAhY165LujhFJrpfLDgqvqEqITO59aDZmyv89e1FhnUjRG8MZG9Sn5VjpTvJ+r0NIf40+RX0qCFnqHnw3WyEJ1bT7Zd1q+8TJJDTvDsOwfAsB315bQw2RndIneriZIG1JQuigMeeiP25WHA87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn/AFEfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA7EC4CEF7;
	Mon, 28 Jul 2025 23:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746033;
	bh=ZqLE7bvfoVPDhvpAEbsyuRCXUF1Uo+l9RI1TzIunYkA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qn/AFEfXOVE7KjiKF7qdfV07XL1XLJCmR7x4OnsV7vTamAg71xyZpsV20+jQFvl1t
	 r+AJ9QaceAcEIed66Bh1fAhM0QdAX2WO7UZrc+TfzS1DKaC/PfRlz4EQelar5d1+mH
	 FTRiYVEyJayFpQ1DsO778szYWqzrEi8rStQmen0lmyy1ZzWlIm3A1PfHp6Bz9FVgrd
	 HSgwEUVSYPCqdPBuAdLEQMf48utZimIwFPRmjzKYuDIOaqE6Q84S/NSnqFOcRrK3RE
	 EdcDxr80AwXQ9J9ArbQrozJWdKVB0DEdVMm2VhwVrT8dMeF9vskPWvAWiPl3kBBFBF
	 qOc+IxH7U5g9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5201D383BF60;
	Mon, 28 Jul 2025 23:40:51 +0000 (UTC)
Subject: Re: [GIT PULL 14/14 for v6.17] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-iomap-e5f67758f577@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-iomap-e5f67758f577@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-iomap-e5f67758f577@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.iomap
X-PR-Tracked-Commit-Id: d5212d819e02313f27c867e6d365e71f1fdaaca4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5d760d53ac2e36825fbbb8d1f54ad9ce6138f7b
Message-Id: <175374605013.885311.13839257310412304619.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:50 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:20 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5d760d53ac2e36825fbbb8d1f54ad9ce6138f7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

