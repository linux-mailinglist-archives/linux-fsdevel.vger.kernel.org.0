Return-Path: <linux-fsdevel+bounces-22796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192A791C445
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99C92831F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8AA1CB30C;
	Fri, 28 Jun 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCMlO6Bn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD251DDCE;
	Fri, 28 Jun 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594064; cv=none; b=Zfh+F9Z9XYvFy/rmVR/CswMqMRpyNXQXm03H8zirBJrJNWk/nvQDxU0bRO4vbYpbvvGMNj8tKZPpFOKCVyn5/9LsBlCy8vK4VV4kBNWLZSQ7NtzLaW++7RsOLqkxZgqcFWDPFdgYkbldvC20bwQW72R+ZWCEKSRXE4LE/IQh/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594064; c=relaxed/simple;
	bh=wXHfuanuHMpvurb0DrcuFo+uWGMY1WhV/XOuGzoiNCg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ad6LNasUNEhBiM1f6xQdQVLg863fIT9gNh+759aj6WYdJOiVXt+88IM6gX1dpEKQCPnMyoQiOBqVcCvM97MDNc+hq9MLLT6xHhTyA6flXiQcbiirOiCGSdHKZHvvRPCrj+EI1X/5lhmD8SwsSm4H1rp+vEQxDtg052RRZZcftHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCMlO6Bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F30E5C116B1;
	Fri, 28 Jun 2024 17:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594064;
	bh=wXHfuanuHMpvurb0DrcuFo+uWGMY1WhV/XOuGzoiNCg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QCMlO6Bn9YYKMfZf0SDflD2UzAJ2zOw115bPh8KdcUB1uiBUz+wePn04Rs+ceX6Oa
	 p8I2MkgXvDlNDH+nPqnZrOrUwX7NGspNKr00ISeK+xUAM6eeNEXvdw177LEDko2ZsC
	 tKKD/nfgjYxYem3GM4CXve2dPENaUz6eOi+kaFQGWzdB5oAG85UisSMex9AnLfqYr7
	 YwYOI5BkNFX6mYz/upk69SxDnvesHXqcF/cdfPQ+cuf+4BE3ETxD4KkjRtGe2BchwI
	 Ve7s9+Y6bdk516VSpJSsUmhoGbCYQzZnudFIbZBEZ/31srobpvH+D9ZPE8r8uFBbzQ
	 cNFZQMcWRgKGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7C90C433A2;
	Fri, 28 Jun 2024 17:01:03 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <2taurilom54hdpzwsk5qwfln3elficdoarykhakvmhaoneg455@iylhhiq7mauv>
References: <2taurilom54hdpzwsk5qwfln3elficdoarykhakvmhaoneg455@iylhhiq7mauv>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <2taurilom54hdpzwsk5qwfln3elficdoarykhakvmhaoneg455@iylhhiq7mauv>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-28
X-PR-Tracked-Commit-Id: 64cd7de998f393e73981e2aa4ee13e4e887f01ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd63a278acedc375603820abff11a5414af53769
Message-Id: <171959406393.14402.11930447649047525479.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 17:01:03 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Jun 2024 10:39:11 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd63a278acedc375603820abff11a5414af53769

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

