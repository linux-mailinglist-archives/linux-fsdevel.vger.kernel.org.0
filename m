Return-Path: <linux-fsdevel+bounces-7851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85182BAA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 06:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73674B22AA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 05:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949335C902;
	Fri, 12 Jan 2024 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt5zAGcE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE795C8EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 05:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8A9FC433C7;
	Fri, 12 Jan 2024 05:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705036067;
	bh=RXRK9nxL5VOri9qpLiMKeAjhREs2+2x8JjbW/2NBYcY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gt5zAGcEgqcJqShca2Ss43+Knd5fyQSkUQ/xrePIlJdQPFH3CjYCTpUWFUDzld3/P
	 KRM2BTbSdS3X7R0KTfi9EwO4C7Yi2jxq+0g5CbDNovoyfnrZP+iFVai4B3eXKUqkRg
	 N1EL4+Q13bOXlDs0jLvswfH9nDR8Rm/3oawtKh2SS3LMQ4YbRr0NUjUg5TdTnH090P
	 ArUZjUKRoRR5kNhXxwZKT7jfh4HEEVEQp0dF+inVzuqmuabFUyoW/PScnriwPiXucy
	 Sfugm+D3UbAQXovv4r5c8hYjedDkZ1iSrOaYvmDCKetKJ7MMyxzTkUUaGeeWj8yofm
	 7C2aIC5I3AhZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7F74D8C972;
	Fri, 12 Jan 2024 05:07:47 +0000 (UTC)
Subject: Re: [git pull] dcache stuff
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240111102111.GX1674809@ZenIV>
References: <20240111102111.GX1674809@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240111102111.GX1674809@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache
X-PR-Tracked-Commit-Id: 1b6ae9f6e6c3e3c35aad0f11b116a81780b8aa03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 499aa1ca4eb6602df38afaecb88fc14edf50cdbb
Message-Id: <170503606781.7299.17924645431832176063.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 05:07:47 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jan 2024 10:21:11 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/499aa1ca4eb6602df38afaecb88fc14edf50cdbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

