Return-Path: <linux-fsdevel+bounces-34065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071669C2421
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3401C1C2400D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54651AA1D8;
	Fri,  8 Nov 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0qkFTOO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559D233D96;
	Fri,  8 Nov 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087522; cv=none; b=nzt5/TBGcWETl6IypFOZmQP0LMf1lnm0p15GojXgQnko5HL6kkFx98eg5Dq7Mtgu9cOsWWJVZnX1FWtHt9XfTvDbdPyhgvXkeIWgZahsDL+KQe3brhRCqIh6Jx3evLnIMiCyHrJZ+h/EaiMLxFUhLwZj5hvKHhOliXBzbGrQFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087522; c=relaxed/simple;
	bh=QYbAwwOvWw4gCdtMcXf2Y0kUjQfamd0tP6pBb6RhQIs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=laCAtCFEx0m+QW6VMSgD2KKLNEE9MatFLD8nj7aw7QrFKTDN8cFvUR/XPCb8yFi2s8HEf4FVbNWrJ171U+etNUVDllWaTfakxPQZV+yO7UzYygH0K7SXSAm3vSeNxtMDxukr+Ut9W6mBXwNB8HHu38rRkYryQC2tgmOLJAlJI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0qkFTOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CD3C4CECD;
	Fri,  8 Nov 2024 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731087522;
	bh=QYbAwwOvWw4gCdtMcXf2Y0kUjQfamd0tP6pBb6RhQIs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J0qkFTOOJ2OPukacJq5taZ9slZT7b4wSQTpXJx6MvYVuwQvi+5JyEfOkf3wDtRTSp
	 AfvuBT8O9ZK8vd72OD149tB9BkTM0pF4JQvJ6QsLdYqnDlk5JpN+nE2ma7nfah0ziX
	 68TluZJ0id1vEXhIzOXZQ0/4QPcJ5IBDlbjArTv0j9UuGdQ/sfrtmvO2CwamR6pgX5
	 C34icL8BdaMgfX+8nJSE9zMmJ2t5cUuN5oxs+qn2FfdgCZtkc6m/esp9sdkVCSxjxM
	 qWdjPR082+tCeDMZKTMVK7KmR4KNHlV20mWPRQKmNh2szIR57MrCf9knpLul3zjZJ2
	 pNuv44YK3jfmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE74A3809A80;
	Fri,  8 Nov 2024 17:38:52 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <voykwwyfpnpe54naeo67mbbltxodfqe5vzx7gk3rkwcj45e6vg@ak2ecjquamyn>
References: <voykwwyfpnpe54naeo67mbbltxodfqe5vzx7gk3rkwcj45e6vg@ak2ecjquamyn>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <voykwwyfpnpe54naeo67mbbltxodfqe5vzx7gk3rkwcj45e6vg@ak2ecjquamyn>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-11-07
X-PR-Tracked-Commit-Id: 8440da933127fc5330c3d1090cdd612fddbc40eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5f1b488000068107869ab2553ab16b568f487b1
Message-Id: <173108753143.2704280.17666034890708611007.pr-tracker-bot@kernel.org>
Date: Fri, 08 Nov 2024 17:38:51 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 7 Nov 2024 18:02:05 -0500:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-11-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5f1b488000068107869ab2553ab16b568f487b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

