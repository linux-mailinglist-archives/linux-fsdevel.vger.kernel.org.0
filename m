Return-Path: <linux-fsdevel+bounces-7764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3552782A5E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 03:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF05528A59B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE0623CD;
	Thu, 11 Jan 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbc+6d3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6658F20F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 02:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F916C433F1;
	Thu, 11 Jan 2024 02:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704939837;
	bh=iDW7UQWTggwWDGQ65y8NQ8Iodil9YqFODcwuyGwgsR4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xbc+6d3DOLakbb1I1xCarcARBz1AX+7gutVWAhYinqw2mofwzqEP9oEd5V/ZF0qZp
	 CmMmemnU5pK/icOR0dY4ek9QkQ9hbnw4r21rX9hOt9Keu9g2hLny9439U10vziG1jz
	 FUTS6DP6jDigsDxRE9ZE9jhF6/bJHTd30SQkIe/ZA+xfTvOTRqxu+dYQtxXyiFhvDI
	 ROkzqiIy5pIRs30v66wznXMMEuzevL5vRWoF+cin54qugU5v3bWQG/1c4zBFfncvW0
	 n7N4o4O4GATHHmk8aQKdf0I6QLZSrd76gavMq+jNUbIzkdutx3XhJJR0QNlwXHQGFA
	 tUV6QfhzLgHqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F9B0D8C96F;
	Thu, 11 Jan 2024 02:23:57 +0000 (UTC)
Subject: Re: [GIT PULL] unicode updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <87y1czr4g4.fsf@mailhost.krisman.be>
References: <87y1czr4g4.fsf@mailhost.krisman.be>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y1czr4g4.fsf@mailhost.krisman.be>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-6.8
X-PR-Tracked-Commit-Id: b837a816b36fae45f27d75d9bdeb1b5b9d16a53c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bd593bc743d3b959af157698064ece5fb56aee0
Message-Id: <170493983718.10151.12195042467335806818.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 02:23:57 +0000
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 08 Jan 2024 16:49:15 -0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bd593bc743d3b959af157698064ece5fb56aee0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

