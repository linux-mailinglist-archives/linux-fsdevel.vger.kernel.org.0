Return-Path: <linux-fsdevel+bounces-44912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3FA6E4FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9E13B5B42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBCE1F4CB6;
	Mon, 24 Mar 2025 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osshgeEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842B1F4739;
	Mon, 24 Mar 2025 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850040; cv=none; b=DhNb4P4fkwGzIc7JeD5Aag6jixzROtNDfbyvAcRr0ybopU4f3UC/eYAUpYIu4kIPHDz4kJKF/rKGEmsF2kwlu7oSLJ+N8avxildPYKxwwVbwKZ1/91UBA6db9hTODv2KbLJys5qa/omYfaY8Y8ww6dqh9iP9KIQdlp4L1CtDQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850040; c=relaxed/simple;
	bh=ymTw28NcGj9rXJToMHbUd67dQp8mPLAHuxpZjgWGkfM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MMtb9vrhVzqxeHbyAA+6iC8xjAmcwtDWsANuiLJyLdu/KPs72eNC7owhpDo1K+CY6vDmvEc6JyzeehCQ+yIT2HfVAtqu+nZJUKgfS6O/4C+JZ4N27nehNAR/GIRP84w86CaV24qneBM307rK2euEmXJ4H7dqTgYblgUdvYzGrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osshgeEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5D4C4CEEE;
	Mon, 24 Mar 2025 21:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850040;
	bh=ymTw28NcGj9rXJToMHbUd67dQp8mPLAHuxpZjgWGkfM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=osshgeEf9AqhK+trIL/9UKqX+6wss4HigzWDDkR1mJ2C80g33rz4harVih4v65N76
	 WSUE2NwTDHloQDN7sy16ZeryznEMsuyrsgnJaa71DZ3ZPVTI5GvMqNznviuKM1ddj7
	 3QxVTqaimQ4Bx6bDZdc53So1QODxPt5CO+LRH8hb07tiJZOpXPSEbBfcno/EPjb+OS
	 uzOQSWNDT7oOd0L86RU5yyJ8UI5PfV+qFC6iH9V3AxytqY9xuDzgemUqkJIWToflcn
	 qGBzdH90OsP9cuD7cp4O/gpyXQ+2CfJ6F/f8KN3LYdCypes0OtYxbnOM896XduxZ99
	 NPksd29BAXhzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8498D380664F;
	Mon, 24 Mar 2025 21:01:17 +0000 (UTC)
Subject: Re: [GIT PULL] vfs namespace
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-namespace-09ebc48e2c4c@brauner>
References: <20250322-vfs-namespace-09ebc48e2c4c@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-namespace-09ebc48e2c4c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount.namespace
X-PR-Tracked-Commit-Id: 06b1ce966e3f8bfef261c111feb3d4b33ede0cd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 130e696aa68b0e0c13f790898529b2cc1a5f8f8e
Message-Id: <174285007649.4171303.14653851426854780332.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:16 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:16:21 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount.namespace

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/130e696aa68b0e0c13f790898529b2cc1a5f8f8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

