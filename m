Return-Path: <linux-fsdevel+bounces-44914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B379A6E505
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D68188DC74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F941F5830;
	Mon, 24 Mar 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8NcXoQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA281F55FF;
	Mon, 24 Mar 2025 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850043; cv=none; b=h/67K3WUnofMeZq8u2s8r3TxxEUK0B4Tjl+W2yZ+IrpDGo7Eezyn4+YaXVCBAzuYPPg21CwgWS84yFqI7zHnp8OOFgUQScgb3/VaGSHGhT9SNHuJ5l/bUqSMZqCK58ecAIp/JTPAnbEmxwZPuxs50n5HC3WqYOlDUHBPEftHxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850043; c=relaxed/simple;
	bh=xixRqk8iKV4RfcE6Ixbp+IAhDiqY+700BRuerWJjgOc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CtfkttR2sjO49XuseFbQcvgKGkjALjyvV7dxo7X3tAhFBsfaSBw6lzpcu5q2Uf1+hJeHigd/vDz9gqXolR6XLAeOGRv8vd3t2K0HlV2ORlGCQHiALSbhkQeS7xQdvmaNz+kkGqwYXboyavw7373459btY5nJw1sm2iRp5sJk8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8NcXoQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B9AC4CEED;
	Mon, 24 Mar 2025 21:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850042;
	bh=xixRqk8iKV4RfcE6Ixbp+IAhDiqY+700BRuerWJjgOc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C8NcXoQyGe4D4HYt1vjTabNgGoyhNTlRqzF1qmhQOuTFCTof/2O/qBxGwFvk5wCXD
	 BOhNk9tiZSZszg/x6D3WwgYyoDqbooGg36DgyUDBK7zwOdOtO6M/YpEVIs0Sgnh2/G
	 gvqhbcjcDvn+zKWQBGlN94F1BWXMr3HLXPCR5LcompBt6hES8lH+8fpUf4p1CdKmHJ
	 AKWZnk0U8pcD5Er925xdY/wYfZ/Q5hPbT38f5FM3NWECwMRURkJGCApKeuR1mFCOFa
	 bHIFkP3mc+0gLCm3g9RGdlfqKa4hFuLkQCmMMX0CpAvpKFtBDI1hI/ck98jbboluLD
	 3EL0Md9BSij9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 49943380664F;
	Mon, 24 Mar 2025 21:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] vfs afs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-afs-1df149397a4e@brauner>
References: <20250322-vfs-afs-1df149397a4e@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-afs-1df149397a4e@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.afs
X-PR-Tracked-Commit-Id: 58a5937d50d800e15a8fc3ab9103583fc7b49ebf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9483c37e2d1c48e45d1416327122ff6010ec7f8d
Message-Id: <174285007909.4171303.12051505212428523299.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:19 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:16:49 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.afs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9483c37e2d1c48e45d1416327122ff6010ec7f8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

