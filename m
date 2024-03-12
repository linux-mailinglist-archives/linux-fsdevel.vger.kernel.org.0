Return-Path: <linux-fsdevel+bounces-14252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE114879E7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 23:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89922284108
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7851448C0;
	Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGdP3e/a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8F145348
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282250; cv=none; b=Ue10Y7zmvGNWWiHjYS5nZjffV3jzcmMTxyXvAOK26qfxVVw7frlZBBfpMT+hVlAzk4iqp6rc8IflzmqN3LiDfBd05kDFO2GEwKVCPuD8lIX1Z9iSzRv6kZlLvuAWOMLK1KBA3k2cltMiT7oXopaJBJeyKjsxR1W6o8IXjZuNBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282250; c=relaxed/simple;
	bh=9Lh6DtEc6u99R3haKr7ASJg2i6AvHEPkxH8BLyXLLrk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MygvKHHn9pwwBxJ27A8wRnrq3s624Py4aFF1w8bRoViisS8qnsGj3iIUOKRGkpv8rgrZ5f1LYDgRLIODw8SYaVCTZjhIoTHcaZpMSP3I4WP7s6IEzh2fGUkF2fvqe8lL6rgYETVyEanOJdVtkrLx6v1w0OvWSHVLxQrEnBxhjDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGdP3e/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFB26C433F1;
	Tue, 12 Mar 2024 22:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282249;
	bh=9Lh6DtEc6u99R3haKr7ASJg2i6AvHEPkxH8BLyXLLrk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZGdP3e/aKD9sElkVLWVB4H+5PedGJvJ2dqiWBqRpsw5O4ladX2IOrsH+CAfrfqlFl
	 UxGlCWW4UfCqJPbL/VV/Q/qUMaZAJPNdHGqNy1ATOvOrGmvoIj0GapboPiKn43ao64
	 Tkp1rDB0E7YYRrMyGHt54eI6YHneqKLFsRqflndXquPG/4izTB79qMyZH2W2s6SLzK
	 AS/+2zXr6YEWOEE/04Mm6Zl09/Xb3gbXZdQmmjaf9IjfhXqHc0N00N5OgQfoz1GXIU
	 4+P9Y1V/GkSz3WVG1MKvxgPIvoAfQvaCupi5z1cHGQQiJ8bmVij9RkJDf0hgg4hjT8
	 COHOUrq73fgrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7CB2D95057;
	Tue, 12 Mar 2024 22:24:09 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs changes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311000225.40819-1-dlemoal@kernel.org>
References: <20240311000225.40819-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311000225.40819-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.9-rc1
X-PR-Tracked-Commit-Id: 567e629fd296561aacd04547a603b163de3dabbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35d4aeea10558d12022d752b20be371aced557da
Message-Id: <171028224981.16151.12242606814833422182.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:09 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 09:02:25 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35d4aeea10558d12022d752b20be371aced557da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

