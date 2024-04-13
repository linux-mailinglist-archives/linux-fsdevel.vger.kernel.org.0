Return-Path: <linux-fsdevel+bounces-16868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB28A3E19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 20:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529EC1C209FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 18:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8C535AC;
	Sat, 13 Apr 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc5xe6pm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493603FE55
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713032627; cv=none; b=EkwIqFNP6QxYENdfrpOOhr+tKw3tSCo58WZ3OBMAlRB1UMD5Qo6nVkd/De9pMUhm56jr1qVT3R1KeyLAzy5mKE7ysmPpwvJOdRUGRfYBtcovHfHtiIrsfeWiN7lspaV1uSwVKm3QsWaaesiiMjsht/F57Zxb+FBzKz2DxgonxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713032627; c=relaxed/simple;
	bh=LuU8gQdu5wINbHfemxWY7tRar+GQ0djoTfSCJR8G7hY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MmgNmMy3akIX037zkQTwjDr5m8t67+xCWBridcBXYZCT6EDfWbvlD76e6iBMvtgdzIirN4/QltyFmrMpHxuMR7AR/uBOMMTilhNofsXzZETNoYWFJ3iXia7GsNtF6KNU56w2PMopystvBVzBKXXxUZ5AldoC+Y0kWur2IgIOj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc5xe6pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C32F0C113CD;
	Sat, 13 Apr 2024 18:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713032626;
	bh=LuU8gQdu5wINbHfemxWY7tRar+GQ0djoTfSCJR8G7hY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bc5xe6pmTZhT2KQyXHxP1DaRcQ55hi813x5oEfbUDMdbnXTj3Dm2KBDhGzar2qsCt
	 tN45fl8gS4tBnLFxDqfJRKx3mB+ur2jlXAQfy3SLcnHO62wnp89dXhiAyjGKTCzXMp
	 cWw2yU70zM4XT74SOJ4OG729gzJjZLloRSKByNHRjptp6uix2Wj34pySB3VfnbqNev
	 pyCVKTtvNVWY/o5bg8SRTCzHV53WrtIRoFECokZ2FaFNVUqsU2Z7lwdb2nyzVruiXP
	 tD7o0Fn5aM9J7oKS41a7tWq5UFql6Iam1gqp9W9JWa6Dh6u3HTKnj9vqIlAdRNzsfk
	 6Qq/z2zPHaAYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1532C43140;
	Sat, 13 Apr 2024 18:23:46 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240413014104.1099579-1-dlemoal@kernel.org>
References: <20240413014104.1099579-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240413014104.1099579-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.9-rc4
X-PR-Tracked-Commit-Id: 60b703c71fa80de0c2e14af66e57e234019b7da2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76b0e9c42996e1883b1783afbe139ed78cf62860
Message-Id: <171303262671.6704.14120142662481280360.pr-tracker-bot@kernel.org>
Date: Sat, 13 Apr 2024 18:23:46 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Apr 2024 10:41:04 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76b0e9c42996e1883b1783afbe139ed78cf62860

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

