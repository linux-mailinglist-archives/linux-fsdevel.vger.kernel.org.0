Return-Path: <linux-fsdevel+bounces-7766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3644182A5E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 03:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2841F24F84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 02:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C65E4C8D;
	Thu, 11 Jan 2024 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnyNKhl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064C2256D;
	Thu, 11 Jan 2024 02:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77C2CC433C7;
	Thu, 11 Jan 2024 02:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704939837;
	bh=eZJl07MRk8eP/ymTpWsG7/tzxfdlAFMi/ZG+qNfKrW4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YnyNKhl8C5r0W9A0RqJyAbtfAycrstJhtF8/o8AK8FaykM712wKC1t5xKA5EIbjKc
	 JecwKpUNSHXVsB/QYKmUmhI6GLRQPBmi0sEAVsAtWM+7etpmZhBW/PrrzLNiLMGQBA
	 Y1RwBkNwXp2IUkkcj5UUQqc3rgnXa6ouZg1omJQt7Ydg577LT/PYUBf6Yp3vrz1raC
	 77AiQ/3CwlYvWabQmN7nSNDIZt9VUsus3iV+xDtSEheejuR+s6nCjzqyn21y6QP0zM
	 ec33CwyHbnIXgRw0QL5yIbwlahtNroZ3TtFxT6myMwAD164Pm2i2+2F53ohYKJEX2u
	 /Q5mdXZUg1TUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62EE2DFC686;
	Thu, 11 Jan 2024 02:23:57 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-10
X-PR-Tracked-Commit-Id: 169de41985f53320580f3d347534966ea83343ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 999a36b52b1b11b2ca0590756e4f8cf21f2d9182
Message-Id: <170493983740.10151.1674566747445994664.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 02:23:57 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jan 2024 14:36:30 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/999a36b52b1b11b2ca0590756e4f8cf21f2d9182

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

