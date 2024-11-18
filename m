Return-Path: <linux-fsdevel+bounces-35123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245549D1933
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28A31F21275
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599FD1E765C;
	Mon, 18 Nov 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UadYPXRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92761E6DDD;
	Mon, 18 Nov 2024 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959333; cv=none; b=GNbYebliP8BlycSY1Y2we5MUWrwcKZoV56TQx+pjUPX2Mcqiy3AUDvWR21RFYNkDNIzZUEHvvFJzh+LmUh3Ka/OAQnlMG4pUjDQJc34d00LJwmrwweKRZiKJfLizW0EOV6T/W34lzXNrUbOu3KZX4i4Vjg0h8Tp4BpNTECadnrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959333; c=relaxed/simple;
	bh=pJdkkw7MNZuDBwHy9GDFuw9U5L4N1w1GziIFJqYshtg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lYJ5B2kKtOCYUoSkHWtXaSrcYxUY6PltxtVWIrpKZgtT4lproTGO76zyUA23a+P0tpT5NS+iNjO+P56m+815B/M5yMS5duUrJFDtV0XkExkVLrfiGj7NjAvk75K2sflXoki4f7Z+uKDx8n+gv2JHsdiRBqKeJnlgpwNwr76Wz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UadYPXRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649A1C4CECC;
	Mon, 18 Nov 2024 19:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959333;
	bh=pJdkkw7MNZuDBwHy9GDFuw9U5L4N1w1GziIFJqYshtg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UadYPXRpZhD8TADYpxiyoMket5Z4UiofhNoqGVL8sUAJ2gDtB/oRPgwdpkyfuU1Q4
	 Q8W6VBu7cY9663BZWv0NqzmBxihCUHt0mm14QJGXZ/hrgfOwpIcuKT4Agi+OT89kg9
	 jiqNxSfbtDZgJ6bxMZmI/X3U0lUXdCDSaE8pU5XJj7qh2+pD3f9rFPy2Nj7jOp9buk
	 OO2/w4XkUOQxLDqEyS0lfwlDF76cb0IhH2j3Ehp30qnbcqX08wF8GpN5EDKWnvm6Tr
	 ZiC3y3TButcYicREjuNpMomxdclI/WUVBJxXs/raQpE6xaQcJc69Xwqrjfrz6+wbV4
	 DoaHt5w/dm2cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC8B3809A80;
	Mon, 18 Nov 2024 19:49:05 +0000 (UTC)
Subject: Re: [GIT PULL] vfs mount api conversions
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-mount-api-6ab5111dc7c2@brauner>
References: <20241115-vfs-mount-api-6ab5111dc7c2@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-mount-api-6ab5111dc7c2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.mount.api
X-PR-Tracked-Commit-Id: 51ceeb1a8142537b9f65aeaac6c301560a948197
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4eb98b7760e8078dbc984ee08b02b5b4c3cff088
Message-Id: <173195934449.4157972.1695792106733879158.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:04 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 14:54:56 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.mount.api

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4eb98b7760e8078dbc984ee08b02b5b4c3cff088

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

