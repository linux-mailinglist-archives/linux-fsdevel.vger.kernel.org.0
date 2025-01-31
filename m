Return-Path: <linux-fsdevel+bounces-40511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA72A2422D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 18:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B4A188539D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184A01F0E3B;
	Fri, 31 Jan 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7XbIy05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763091F236F;
	Fri, 31 Jan 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345507; cv=none; b=n39iWmiulbNsCrXonsnpnqoKG2/+dhAM848QkX7kNdQoLI9Sn1CLx56PQ7YtueLd6hra66x+Lk1EKYryJfeIoC9V5kJz1t4WEwCOt3q7rAtkM0q7s6VLL19QdONa3XrKCON6u6Kol3GIjQtOYVCrtKoiEZdHod/X62Q6CjMXDtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345507; c=relaxed/simple;
	bh=cmUZ2hBwl7dZ7HgUbDSDGzWVCLY2IFx6JqkZiIWqvLk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Q0u2lpwcWeNWJVU1TP2/BvMMKqdvxSeeH9NdH9uLvCjiumT5Ubk43CLRKxaYDCDP9o0c9wRh/KWiBZJggWWK4xfs9TiNNbmzUQNhI7qEoSuFEqn/e17z1VmC1YgOADw4UL7bLVPTR6A3LUftj0fQxbv4TDcwQsSaa/1idULyJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7XbIy05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA842C4CED1;
	Fri, 31 Jan 2025 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738345506;
	bh=cmUZ2hBwl7dZ7HgUbDSDGzWVCLY2IFx6JqkZiIWqvLk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m7XbIy05jb0Mj01fMh1J+ICmBcyKT2VFAUbrNcmOWc1RE8KxXHgCKLBw6ZCuX/z/n
	 JuK3F+TUPvgz4lbn11CnJ6BnbjSG0d7+yULSWDSx4IzvE+KRFni4DLcfRMyNzddMss
	 nTqCisEO13X3ZI5ihzge2yseVgfljv9F57w3+7i8aziPcyAJ+ncOPsUL9lpwVZCAkV
	 8Y969lDpRk/d9NoDkSw7jkWIqusd6nP+6ZOqz+ZQMPRMQBRRrCcGQdwnzb8zRtIvLG
	 XhPXfWKyTVmFjQGJywka1E+6ow+n1GkP3krr9ddwNTn/ekZdBd4vpSPKf3VTiLSRsy
	 cPsCTw8vpRyAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D18380AA7D;
	Fri, 31 Jan 2025 17:45:34 +0000 (UTC)
Subject: Re: [git pull] hostfs fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250131082437.GW1977892@ZenIV>
References: <20250131082437.GW1977892@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250131082437.GW1977892@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 60a6002432448bb3f291d80768ae98d62efc9c77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2fde87318f3d77314334b8bfe93846f36ae1708
Message-Id: <173834553265.1678494.16845888298890847205.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jan 2025 17:45:32 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Jan 2025 08:24:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2fde87318f3d77314334b8bfe93846f36ae1708

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

