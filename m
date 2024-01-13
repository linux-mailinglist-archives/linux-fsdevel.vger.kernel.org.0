Return-Path: <linux-fsdevel+bounces-7900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57B382C90A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 03:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1DA286A28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 02:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1118E0F;
	Sat, 13 Jan 2024 02:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMKry3Ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C88918C27
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jan 2024 02:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E669C433C7;
	Sat, 13 Jan 2024 02:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705111771;
	bh=ZY7E9+5WNSkKOKkTKRffMq1ObHAwT77L9aUM/dq6czM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OMKry3NyTFwWJR8OCil+jkUxQItmSBy9m1PuBkLLg1XQHbqHXFHI6/tLhGE8JdnTO
	 j1qFRF/df4bKubWnvuCbhXy1t3k7lu/R+XjT8ZrbZLGHORVrdVpHFQ367JxWxju0V1
	 wRUrKJsjNCTqsN8JlcP3KgY2EqUcSMoEnSfUsL+Jvv/AyuNt/sJ1TvQdq1zie2f1Vk
	 mvZggd/n9bEDTlYEVXN5hol/cEfW9gJ+FP3geN+6EF3+XyH5e914DmnYH3JEnQm6BD
	 6N5cbtUDmG4dQpSIz+9RDYx+6npSG5w45N2QXGiuEzqsC4eTAMWETKaJhZymE/NGpv
	 RsMYxg6RuxV8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A362D8C96D;
	Sat, 13 Jan 2024 02:09:31 +0000 (UTC)
Subject: Re: [git pull] more simple_recursive_removal() conversions
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240112072537.GB1674809@ZenIV>
References: <20240112072537.GB1674809@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240112072537.GB1674809@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-simple_recursive_removal
X-PR-Tracked-Commit-Id: 88388cb0c9b0c4cc337e4241fe6f905c89bd7acf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1acc24b300bfa8b2f03daabbba67db600fd38e08
Message-Id: <170511177129.6595.3455784213985850297.pr-tracker-bot@kernel.org>
Date: Sat, 13 Jan 2024 02:09:31 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 07:25:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-simple_recursive_removal

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1acc24b300bfa8b2f03daabbba67db600fd38e08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

