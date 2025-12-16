Return-Path: <linux-fsdevel+bounces-71450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0781BCC17D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 09:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD33308AEDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 08:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E3034B18A;
	Tue, 16 Dec 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+vvzMYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60B34AB16;
	Tue, 16 Dec 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872437; cv=none; b=EXi+E9U+G9yGH5+fUun3X/I1AZyKD11dLzKkk+d/gJSJNev38JGFSudI1URjwe1SZ5bpN7aeZdp0Ce2NrvfmkLQnwp8LuLkZsjrkjNKZA2MSx3WGjFwgmrSiVPC5crkRnjdaYhIdfl9dK8HcsJudVikaFLm407hkVF/LCWzGP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872437; c=relaxed/simple;
	bh=prl0xPcs9eTAp3WELwBowrKZC8N7y78AAhNo8WcVa7s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BOzuDEN86/ERugCScxI0CLvcwsdUMFwH8RvgsDS1/ybUWkCFTv8aIAd9jl2Qr4ZWX5cKhlPZ4aLl2uFwVj1KWeG+/YrMPSOAzuRv2PPD+ZSlvgj+Wk075/r4v4QK019vp3qMxlgLPkmv2MJjQl/oWOyaIWZeqsjj2K3JPP3AgIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+vvzMYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D98AC113D0;
	Tue, 16 Dec 2025 08:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872437;
	bh=prl0xPcs9eTAp3WELwBowrKZC8N7y78AAhNo8WcVa7s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b+vvzMYdPweUqzHvcvzItdi7UfxBYhBENSizk4F0/GcvLl96119F6dWS+yXrLe2da
	 iHR3lmkUN6aG3TZouXwDMaSwpeD7YpEN6a8iomyPD4dPu1Kf1iXbBQcl2ygcWqQJst
	 upuhy/gKAeF/stlKjjMkbDO9oYQb10ieuz9zXwwvv921yzr47dT3fEJiarCP+hQB4C
	 itjlqS7fPw1vK5QN8iXjeWnwvaHZiXMNN5bPJPfYj8sbVBRZMUHoEN0XJG6IZw7778
	 FM98+LJ9PTjGgYgFpUEcj//NxF4FH8hP0N531LvKH/nvG2PrajJP+7FrChvqG3Kl9N
	 OfNpT2+I+mICQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BC31380CECA;
	Tue, 16 Dec 2025 08:04:09 +0000 (UTC)
Subject: Re: [git pull] shmem rename fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251216060257.GP1712166@ZenIV>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
 <20251212050225.GD1712166@ZenIV>
 <20251212053452.GE1712166@ZenIV>
 <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
 <20251212063026.GF1712166@ZenIV>
 <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
 <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
 <20251213072241.GH1712166@ZenIV>
 <20251214032734.GL1712166@ZenIV> <20251216060257.GP1712166@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251216060257.GP1712166@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: e1b4c6a58304fd490124cc2b454d80edc786665c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40fbbd64bba6c6e7a72885d2f59b6a3be9991eeb
Message-Id: <176587224785.917451.17926462470930519580.pr-tracker-bot@kernel.org>
Date: Tue, 16 Dec 2025 08:04:07 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Chuck Lever <chuck.lever@oracle.com>, Hugh Dickins <hughd@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Dec 2025 06:02:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40fbbd64bba6c6e7a72885d2f59b6a3be9991eeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

