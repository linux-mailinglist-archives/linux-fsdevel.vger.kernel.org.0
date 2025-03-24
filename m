Return-Path: <linux-fsdevel+bounces-44900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC42A6E4DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082457A7636
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF451EEA2C;
	Mon, 24 Mar 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2Hkzq7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A61EE7AA;
	Mon, 24 Mar 2025 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850023; cv=none; b=tgD8cg50BlLx9vxQZjKKNFvqI0n4AdTCo0owE6T1zW5mwrJfMWJJbcAdCQLLIkQkWF6fZuaDOe+J7dcBHcj2tFgQetk+XZkeFZyPHQgJVsOM7udU5cKdXqjUeFwZqDsEtp0IQbzNJwW2gyWWYnW6Y+pLsMLY7qJ9BqChbRv2Mdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850023; c=relaxed/simple;
	bh=e7airHi1LwNXLlHZijepjc+IwIZMmEOcNovKxqnuzsw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p5fXmtNKa3bkMKAdYGvAb58gfMoLbVxtlBaTjcZdT9C/AniK70bN9UQVTiEDBM2PpcYuZjM3kZvWi7c8UVmWkKuhUXBNNy6/PAfkk5hp+vPJrHO+yKisRWNVzDoDj8UdmiK8AnuhQIXGk3tCdjzQ42Cpu8DI18uzN438JONCVA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2Hkzq7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F82C4CEDD;
	Mon, 24 Mar 2025 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850023;
	bh=e7airHi1LwNXLlHZijepjc+IwIZMmEOcNovKxqnuzsw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D2Hkzq7WG7IIXk/wZwnOsF6jB1e+ZmMT0T9UrGcD8ohqPNvp77wLQyMtc5iqHzfFX
	 C9UKNE5KVHicUSn25Fv1LiR3haNvsO7IDGMoMK30hSVOEcOxfAsctQCXQph+fPNk3l
	 gcoiZO8Gg9/BSasa9HozhJyItgCy3hM2Gxihq2HBKJcTuAsNT8AxpB/3WYj/AGChQk
	 Gwlt3+fb9oOojVdaUL/1Kt0N/BCt9ydzanvWn8HnyDPpz+J3rApNa2MD35Yxfn2ZkL
	 SNHgjyhBII4C6Qp8ByZoMvgPi0eGMiNBc3e7/4yXN72STfXj4iGPANn7RThacKee1U
	 NVj6zFh1g28LA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E62380664D;
	Mon, 24 Mar 2025 21:01:00 +0000 (UTC)
Subject: Re: [GIT PULL] vfs mount
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-mount-b08c842965f4@brauner>
References: <20250322-vfs-mount-b08c842965f4@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-mount-b08c842965f4@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount
X-PR-Tracked-Commit-Id: e1ff7aa34dec7e650159fd7ca8ec6af7cc428d9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd101da676362aaa051b4f5d8a941bd308603041
Message-Id: <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:00:59 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:13:18 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd101da676362aaa051b4f5d8a941bd308603041

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

