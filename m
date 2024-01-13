Return-Path: <linux-fsdevel+bounces-7901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DB82C90B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 03:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728B8B23B08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A45D18EBE;
	Sat, 13 Jan 2024 02:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcCTRPRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C647418E01
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jan 2024 02:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D9A3C43390;
	Sat, 13 Jan 2024 02:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705111771;
	bh=zw1OiGa0pREZd9kkPH2jsuXFUQ4n9UVcF93oYS43Dhc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JcCTRPRiZK1Z5XTnU718q1HFpfXiOM6uO8LVzXpxF+8HbvpuhgIw9325AIN1NEqUv
	 /8e+oMEPhN7eJ50uuKqUE4b3a8/6ypJLd0NLl6B6u+F2J+nTuh91u2yH9888+QPXYV
	 5WibNvL+2hQ0oIsVswgBluRJCQqBb98GnWxklm2kzaGBknp0mF2hKhtHYufbWObChF
	 USY6k+JrWti7T0Ha5B3akUX1HMZyST8noQRirUBqN6qh/U8qcgBLtE9vlPT8BV6UAq
	 ELa74tZU4hqkYvv4HYHv3B07TXPWEaooAuLudPfQA3eiz3FvOjCUL8/DukDrrnxq7O
	 5oET44d3F+y9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C317DFC697;
	Sat, 13 Jan 2024 02:09:31 +0000 (UTC)
Subject: Re: [git pull] bcachefs locking fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240112072954.GC1674809@ZenIV>
References: <20240112072954.GC1674809@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240112072954.GC1674809@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-bcachefs-fix
X-PR-Tracked-Commit-Id: bbe6a7c899e7f265c5a6d01a178336a405e98ed6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f16ab99c2eba233bc97b9f9cc374f7a371fcc363
Message-Id: <170511177157.6595.9789050165366084230.pr-tracker-bot@kernel.org>
Date: Sat, 13 Jan 2024 02:09:31 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 07:29:54 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-bcachefs-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f16ab99c2eba233bc97b9f9cc374f7a371fcc363

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

