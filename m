Return-Path: <linux-fsdevel+bounces-14156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9335878763
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 19:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AEC1F21B68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC256440;
	Mon, 11 Mar 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arvCDeH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8F54BE0;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182028; cv=none; b=bDtAToiyl1ev4pQCO1yov70SCs7CuvembhQuT4JHMOaqhXEIUvIN+ulIHGfys1iHlRcR5kjZZHvjH4RZ5hE7DH8aNMe55w3AmZBAttk2w2HM3ZS2Ul+QstTIH51mhed8tsntMhWHTJZAQ5KVOLrQN9ljznBj0heyWwhd8bPB8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182028; c=relaxed/simple;
	bh=oWm8WtvJhbcRWkNrqSzCc5vFg/dBtDkW2aZtaoAoGPE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nsWQ7EYzV5x7eYqsKjY+S0HDg7lgATQM8aoELMzcFwN+UcRL2JvmYFqrS+5biNB9R1+Cyas6cX/wPsyJBw1eAGrCHOmZLZ/wnp0GhcOfpZ+9OtDBjsMJggz2CsNFTFjTs33ycTCHi/UZoySJPWd16GkUeuApGwmrcEQhV0u4eQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arvCDeH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9894EC43390;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182028;
	bh=oWm8WtvJhbcRWkNrqSzCc5vFg/dBtDkW2aZtaoAoGPE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=arvCDeH1GUKYgF4VMUMkULBZlvRsljHgdvZCkgB8DaOJGth5Hk/v+mw+L2kM9TDFL
	 aNHgNIOJ0Oi3ySuRkViuOrTPXv2pCy64kkCP8qI1UuLOQeKo83GOMOjPRmOk9iLlNn
	 Qsi7l+lZLhrNkjYYVo4hN2AtkhZ74lfLIEJmBOjgta0UsmT4KJ+bACQgcn6u1QT7fg
	 QzGpvXS+l4ykgL+B0uH3zsH5EXIwgEve/hAu9RaKKkHio5kc/azQG6B5cUpgwPKv6i
	 hduXKzIHBsIIByVKXMO6eOOgyoRtyPq1eSJd5c2bJpfNxjEa3Jkk+dndcKdRaFzR2a
	 zLQDsyDZPm0/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88271D95059;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Subject: Re: [GIT PULL] vfs filelock
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240308-vfs-filelock-5711cd242ea9@brauner>
References: <20240308-vfs-filelock-5711cd242ea9@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240308-vfs-filelock-5711cd242ea9@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.file
X-PR-Tracked-Commit-Id: 14786d949a3b8cf00cc32456363b7db22894a0e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c750012e8f30d26930ae13e815635258aee92b3
Message-Id: <171018202855.4685.11242508422499154498.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 18:33:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Mar 2024 11:15:17 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c750012e8f30d26930ae13e815635258aee92b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

