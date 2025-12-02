Return-Path: <linux-fsdevel+bounces-70426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF856C99F58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 04:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EA724E2D0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 03:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D9A284672;
	Tue,  2 Dec 2025 03:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9jmz0YB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD49288CA3;
	Tue,  2 Dec 2025 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764645732; cv=none; b=YjckqsxG4KRWPOdTiteUKe5nXkPw9Fv46zYOPcegriJMl6epN5iNnYvl1HI5TszRKMSWcVenCbE248LPxP4xWQWJd+SBoPEO4Z+SK9fUFn+o3R6ectEHRWAM6Zx0dTDFQ2+9Yv3EHheAT3wfIQaCIOTW5H8fROFao6ka+X8rGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764645732; c=relaxed/simple;
	bh=KZ4wC9YJ8p08V1t6n/gHFU+8vtNQourSijuiEj0e/Ls=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Gr5doWifWy7/OrRv9dNr40APdzMIpX/ap/B5+9bXpxQlJEdBseCuAf5Z0XfYqh9WT//y8Ff7Ql7HcfzxCyMS9W+UVcAMM0t8wxN482N0P+pZP/cVyBtu6mZXNE27YClcDelTHwTow0XCBZUoXIoFa6xBlRwg2JvRHHz4QCDR7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9jmz0YB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC28C4CEF1;
	Tue,  2 Dec 2025 03:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764645732;
	bh=KZ4wC9YJ8p08V1t6n/gHFU+8vtNQourSijuiEj0e/Ls=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f9jmz0YBMRYAPB/7IUVAeAl/VJqvbATlSZsbVpeti20UB0a6bzxjqv+tE+CplImIo
	 Cii0jq3lAJPKOTU+5YNjG6fNAmujjqUX9S9BHGZ6Anj5MHTRoCsFLnN72BgcdXR1p9
	 8Fxy2eKOw0WpqE8IhjXBPpFx9xLVP/MmQUOsZaQ5EI+etXY53CLJATH+1hxS0y6GR6
	 IEToFJoRx7Xy02l63WObr6/ocvqGc1+hrSjuVwsKg2ozX4dKQZKe+ONnvfV7gWLSom
	 Nj1gBGvaTAdtJos47eFWQ6qedlq4UUI2oS2TWc5/5fojYLa6lj3aIjBsDb19GaFYk/
	 deHLUwJloH6zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28D83811971;
	Tue,  2 Dec 2025 03:19:12 +0000 (UTC)
Subject: Re: [GIT PULL 17/17 for v6.19] vfs fd prepare minimal
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-fd-prepare-minimal-v619-41df48e056e7@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-fd-prepare-minimal-v619-41df48e056e7@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-fd-prepare-minimal-v619-41df48e056e7@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.fd_prepare.fs
X-PR-Tracked-Commit-Id: 0512bf9701f339c8fee2cc82b6fc35f0a8f6be7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b5dd29869b1e63f7e5c37d7552e2dcf22de3c26
Message-Id: <176464555163.2656713.14202848277637051950.pr-tracker-bot@kernel.org>
Date: Tue, 02 Dec 2025 03:19:11 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:28 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.fd_prepare.fs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b5dd29869b1e63f7e5c37d7552e2dcf22de3c26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

