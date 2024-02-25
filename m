Return-Path: <linux-fsdevel+bounces-12727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17240862C6C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 18:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AA61C20AFE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB6F1B800;
	Sun, 25 Feb 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1Tc6/0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB431AAA5
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883890; cv=none; b=htmYe81DF7Ruhv8SwIJwgGSFU0wUV5FAYnq9AiPzYaru2FvA+9qABjK+YVnzLvimFoFbmQDhKGu3/gJNSNg/AyVFPXVHlPVm2TMfCBMbkxuNe7uigMBra5ErgjM0kkjXtbmCaVQaU2UNB/6MzfwVx40gsy1NQhW7b9CNgqs2YiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883890; c=relaxed/simple;
	bh=f2wccudOq6Dn3le89jcettlTkriP9aJ1nxHNETB4VE8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=af//oyrJDL4F69pITwK53s0KKDQmoXOmIvyhsd17LMpkFGHiz40CMqPkdkdti/r14Ov2ZFZwSfAdEtlOICL5wL6rTant2l0CnWzThGwY1yTkLCHL6ifhLBSV9Y0taXqimAL9/JxuNG/0JDU998JzSabYS4a7WsU0hE8Y9TCvh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1Tc6/0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 106DDC43390;
	Sun, 25 Feb 2024 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708883890;
	bh=f2wccudOq6Dn3le89jcettlTkriP9aJ1nxHNETB4VE8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G1Tc6/0fJNoB7YhzYy2b6ldRf4/lAucrumLovi7dEj2VJZa67RuO07us/CkuMOjf9
	 HCemnDRR486fgz6jqvLqMKePJnKtvp7AqXy+vPSclqYZetT56d/XLb62xpVBiadnyN
	 tlHWTTHdRd723mBz4K9lVG1l+5dxTONZHJKgd67lPHbX6ovATiqEqbMJWSZ9a8LAsx
	 ggsx/8l/pSyFuj1I5NAXc9Uetn3uAnChBrgS+Qfcw29n4AQbsfB9swb62A+OdEYBeX
	 x4zuVY9pGBrCY058smghoz6vHdXp3XI4+oG98sbZmxXb0EXa46EYF0qa6Jn5l3QUzS
	 8qhGVNUkmBsMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9103D84BB9;
	Sun, 25 Feb 2024 17:58:09 +0000 (UTC)
Subject: Re: [git pull] rcu pathwalk fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdrpXmWQYzExV5m3@duke.home>
References: <ZdrpXmWQYzExV5m3@duke.home>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZdrpXmWQYzExV5m3@duke.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes.pathwalk-rcu-2
X-PR-Tracked-Commit-Id: 9fa8e282c2bfe93338e81a620a49f5903a745231
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66a97c2ec95359550987078648cf069bdd3e0f53
Message-Id: <170888388995.1439.11115354457629108460.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 17:58:09 +0000
To: Al Viro <viro@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Feb 2024 02:16:46 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes.pathwalk-rcu-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66a97c2ec95359550987078648cf069bdd3e0f53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

