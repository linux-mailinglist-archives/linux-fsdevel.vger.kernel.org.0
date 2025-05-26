Return-Path: <linux-fsdevel+bounces-49863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB7AC43C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 20:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8826E3BBE2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023FA1DD9AD;
	Mon, 26 May 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atEDWYMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7033D76;
	Mon, 26 May 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284519; cv=none; b=n+rsxpRF/m/NsBE441rSww2NMPGgG7QS4pZv4ruC5r7u2Q7BxfO7a5Jc6HyoXNxrKrOePr7LhfR5r05j8YwlmkFZsMUL1SA9KF48hQYoK4daGr+esRnVyCIQ7vcg5uFZ+cYhnbYdnyLgNz/ZGCIplm5/LlaSMqNjGYEU3CkC4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284519; c=relaxed/simple;
	bh=YzNfgpd3EdD0yiLC9jRg3B5BXGnhs/pwmsa7imwrXrA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gfmpa9WwlFeDigbncHzpHvGiX+ET0gXR8z6rLt8AlWIFjAURrITRHhS4eu3Ig7lCeXtfon9AvjyFYSC72pse1MZV1kWADosWE5RDH1xjt6k/834Jg5COuMBFKj8YtMBp5L//j/YpXtflH1Sb2OV+IPPrVYdbK8yY9STC10XlXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atEDWYMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E650C4CEE7;
	Mon, 26 May 2025 18:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748284519;
	bh=YzNfgpd3EdD0yiLC9jRg3B5BXGnhs/pwmsa7imwrXrA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=atEDWYMNShUWJnwmbwaesVx2ifKlm3WQlZxm4xiHvDUswI2DSwbxjF54+O9iskJEl
	 F/UHEkGQkP1Fxur74bCt+8ZAGTV3W+FfNhWIrAUKM/QpVvI6g6w2+ZJZF3LRCGZqtA
	 /XNti+2gu/k8vCY/+/bqUoEME9ADquBRWG8e1iiQyRu0mI4bGL1rcU1uZ++dFbKUCu
	 9WFCVsKnxPa43tVC2Y3pjlrAQC+Ec/plypVHfXwAiGc0X6iHugL7O7zoOYhdmNtYaP
	 MNj7ouqghKSeoZ5oX4tjLSpg4e0BQ2lUJt+GR37ztSe0aBxwx5Oz8pT6vxUj3bu491
	 4zcHw8XBtZEPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2BA3805D8E;
	Mon, 26 May 2025 18:35:54 +0000 (UTC)
Subject: Re: [GIT PULL for v6.16] vfs lookup_{noperm,one}() cleanup
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250523-vfs-cleanups-f29f2bd1fce7@brauner>
References: <20250523-vfs-cleanups-f29f2bd1fce7@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250523-vfs-cleanups-f29f2bd1fce7@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.async.dir
X-PR-Tracked-Commit-Id: 4e5c53e03806359e68dde5e951e50cd1f4908405
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d5b940e1e14fcc20b5a3536647fe3c41b07d4f5
Message-Id: <174828455349.1005018.5284210430654494662.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 18:35:53 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:36:59 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.async.dir

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d5b940e1e14fcc20b5a3536647fe3c41b07d4f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

