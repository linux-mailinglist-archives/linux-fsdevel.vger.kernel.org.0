Return-Path: <linux-fsdevel+bounces-68761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D456DC65A3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41B2D3663AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E63730E85C;
	Mon, 17 Nov 2025 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXHOj+0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC7309EE4;
	Mon, 17 Nov 2025 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401967; cv=none; b=IpjDPCdUnCKhQo3LaOc09mXaeQ7MQev1uBC1hliQOUGsAtVG1MCEsdTBrqmtPI/s/VhtR/7pJzT0DMQGRdBbb+q61hjo/8pGzerLWZsKtp20tyy4YJtXOVWWRuAq40/8XxcF5M+uJyJJ2p3A5IoDZuvT7mqut4FpbO6QqgSo5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401967; c=relaxed/simple;
	bh=JR3LVm77+fPVFPc75ledfQX7+wmi0hv5Ar5ieufRewk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YOm6ZYgy6oF3/sGuUyHz1Xk6HKAb7atphbZ5T8ofENKBneOmr1LlCwa2P+RY1jXstAj880EwRTgwvM1LuC/IIBosUAXOr6Kbx3nnKozOOeaN/1xPRLoq0+NZCN45aHKqVuc6IzpJOFmvrzWSqTT1gncIu9MkgkcB7JEh/Q+gewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXHOj+0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E53C2BCB0;
	Mon, 17 Nov 2025 17:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763401966;
	bh=JR3LVm77+fPVFPc75ledfQX7+wmi0hv5Ar5ieufRewk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AXHOj+0JfAFrd0NgJ78ALqEtOo9ma3gFQEuJ4BNDTt3x2Wb3L7a7g7TxGFxoXdVcf
	 QicUIgx6G3e6my94YFMZFBncIgWKxOtu7HysRSeyewOgTYdcT1qe1lsE3oRELxrHB+
	 fi7UrTDN9KOYfs69vwyiZ86vSKFpXMY3Eh5DoqnuKcCupaD1pXANBn4RqJi4M8yHaf
	 WhI5ZRm7byQRQxHxsjv/4UMrXEomK5VagKvG+VXVI/z9F+n21n5PU+CHt3rIxYdX0o
	 iXRXZPOoSzuXa5exxHDRmXDTv7A4tVvNv+gQRkHRzFvZtPwgeNtzU7xTR8YgXbgQj0
	 kLWwyENcjflOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4B3809A06;
	Mon, 17 Nov 2025 17:52:13 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251117-vfs-fixes-26f16ac8a672@brauner>
References: <20251117-vfs-fixes-26f16ac8a672@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251117-vfs-fixes-26f16ac8a672@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc7.fixes
X-PR-Tracked-Commit-Id: e9d50b78fdfe675b038ddaec7a139dbe3082174c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7c375b181600caf135cfd03eadbc45eb530f2cb
Message-Id: <176340193235.3421417.6752577447482852912.pr-tracker-bot@kernel.org>
Date: Mon, 17 Nov 2025 17:52:12 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Nov 2025 16:53:18 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7c375b181600caf135cfd03eadbc45eb530f2cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

