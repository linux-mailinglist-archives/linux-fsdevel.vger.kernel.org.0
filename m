Return-Path: <linux-fsdevel+bounces-70425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E0C99F55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 04:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60D294E2A2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 03:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C428EA72;
	Tue,  2 Dec 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHkPjn50"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C28204F93;
	Tue,  2 Dec 2025 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764645730; cv=none; b=de/J/1UHMMGBEDk4CBCqTLjyshvstfc38jEaJOgZ5mjFWMxZdIpo2wjcgP7UxnB1mJzOexk1Yomr7JOHr6s+c7pYJGgiO4Oeqrr+X/qK8hu6Fk5h+t8da3tRty0cJTQtNkxA8Qn+VBjwv4LVU6uaeNVsTFPmfNoUGwxF+km4eEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764645730; c=relaxed/simple;
	bh=bI7XiIIgIvTPXitI2vEUdukCVW8JiCCqnrqvH140h0o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=theMugiXAegFRX48vxY8NU0fvdZjX6EH4NX98ezYOBe6G+6m0+mbOdQbsOG9ZVQwaZMYfqrpcDQqmydCeGxuQEj7qnh1JgaQNz+kC9CsCvRLaCE1f/jisD0Yo4mxFUwwE15uwuXbMGG1/D878evulcooBNVUDZ11/Q0IkIuHMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHkPjn50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C06C4CEF1;
	Tue,  2 Dec 2025 03:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764645730;
	bh=bI7XiIIgIvTPXitI2vEUdukCVW8JiCCqnrqvH140h0o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iHkPjn50ZuaLLBE/gP83VHKBKxlwLvxkQdTTUY+WSK405C+FzbZt4d2I/VMScZMJe
	 g1TZOBtHBwr0Bdb+kybm0xzofBl/0WAFG20o5rxfcy4wiSUBQ8+GUJVApTS3oRiaSH
	 SFN7+Fufqv6y2F1AO/f0l8iNGKbchapf01wM9XnEhS1Rt0qulkXtBKtmkFtEwUHYj5
	 3J540xNKF0e+wbVDr+rmdBhj7K3r1k8V4NC4pJAHLCJ+6W/f5/7TSppDGQ4t2o8BQ8
	 2CRr3nj24aPkvZLAaWMEt7roUY9PWhw6VwiHQKM+ZW0IArE15/M1dghZE0g9ljCjA2
	 /d5BacKwH+hxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786753811971;
	Tue,  2 Dec 2025 03:19:11 +0000 (UTC)
Subject: Re: [GIT PULL 14/17 for v6.19] overlayfs cred guards
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-ovl-cred-guards-v619-15a5d2f80226@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-ovl-cred-guards-v619-15a5d2f80226@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-ovl-cred-guards-v619-15a5d2f80226@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.ovl
X-PR-Tracked-Commit-Id: 2579e21be532457742d4100bbda1c2a5b81cbdef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0deeb803cd65c41c37ac106063c46c51d5d43ab
Message-Id: <176464555009.2656713.7954198886934031571.pr-tracker-bot@kernel.org>
Date: Tue, 02 Dec 2025 03:19:10 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:25 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.ovl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0deeb803cd65c41c37ac106063c46c51d5d43ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

