Return-Path: <linux-fsdevel+bounces-7850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3AA82BAA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 06:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BCE7B22D7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 05:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F905C8FB;
	Fri, 12 Jan 2024 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="litp+w+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7535C8EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 05:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6033C43390;
	Fri, 12 Jan 2024 05:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705036067;
	bh=GPtswn32J05tOcfaqd2gtpI6HcCgPa6mPCHzNNdxbuQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=litp+w+wmKFK0x2noMSmNt1PyzRkJtr3BF/ZW5H/zFMAqxXEZXxQADVTp9XT456PN
	 2PYPytUNlpH5kuP1aUG7H6WWUH/CNPTvUDJkm/Wu5BDj87XX+stp/ICxlBgH1/kK3c
	 a4YWwmQ8M1HT7dnW50ibIeWSTIQPgGFJt0xa/ui2Z7ienA9ZVCC4dbGrmNqgJUmj2y
	 yRhRrJe5VA27Pe7O+n3HlOAv35jaIw65Z+AvSOukkqUIMNAOSgCVZDJ1fEmOnL6U5I
	 zofFEuqe/7+1gotgpwOd79hrA6bVAJKi7PPTYOkrK0G+pGke+tOpn81WWOtzNRZXRf
	 bgRij6EWqZ5Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95766DFC697;
	Fri, 12 Jan 2024 05:07:47 +0000 (UTC)
Subject: Re: [git pull] rename fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240111101720.GW1674809@ZenIV>
References: <20240111101720.GW1674809@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240111101720.GW1674809@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-rename
X-PR-Tracked-Commit-Id: a8b0026847b8c43445c921ad2c85521c92eb175f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf4e7080aeed29354cb156a8eb5d221ab2b6a8cc
Message-Id: <170503606760.7299.1936405260319651936.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 05:07:47 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 10:17:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-rename

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf4e7080aeed29354cb156a8eb5d221ab2b6a8cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

