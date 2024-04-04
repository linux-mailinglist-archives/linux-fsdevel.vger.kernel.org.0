Return-Path: <linux-fsdevel+bounces-16138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DDD8991AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 00:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157061F22A68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 22:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B58138499;
	Thu,  4 Apr 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axGga/hV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A271723;
	Thu,  4 Apr 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271485; cv=none; b=PLKo1Y+3JKaPyJeXxdFTaSTayzrLuM3SpGcWUhfvwKSRegt8qFeMhuoSLz80/ze9IE2fF/3y1wDP6fjn32Yp4j5Cvy/EuvLJl6IOzqiqKCpOiFg4mTHpuX5GSNqKPF76OWT7NZbHbpQ/hHmr3uKuRNjYjvbKAjDPWZHesFq0x3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271485; c=relaxed/simple;
	bh=9P1rM+pEx/DoNg6daSbtI6YIkycpWCZDfGcCVbalA44=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bRpA75k3Np+ak4b59pwrYCcNlFOGUmxJaJQ4lKsK1PhFjvlaEY9KmmtEFc8BDcXBFfXx0j7gj7YSWFydvlMv+jfaxxg33kn19xkHvVwsdmh8p9AQ8J9lqHqM5KJ5C+CMBlIqc9APjTi4GI6EbLPRnpGzcdSEE65bMfD/S5T5vLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axGga/hV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE4D5C433F1;
	Thu,  4 Apr 2024 22:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712271485;
	bh=9P1rM+pEx/DoNg6daSbtI6YIkycpWCZDfGcCVbalA44=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=axGga/hVj5muwdTZS/Jq+hFhfhQAJ6ZA147M21jPfkLr9QBru7bZQjLV1NWBUd5eq
	 QeCbnvJqjMUwDq/cqadYEy0c0L3IER2h6bd33tHw2XN/QpbJFZSTqt4ElF49FULO7/
	 tdo5uUMdKHXDX690/qz7g4T67vFRrnTPr4VwKZKsqtuvxlFkBLaXIq4bOj7ypX4lNr
	 ORRSZm9KVGx3PbjtQXADEj/SEs+QyVity0YJg5LVWEvvOas9g0Mb9e484kwL4US5H3
	 /qbNq2MyzGOKaWSbdkoufdPVSoOd6KBGPQdnHoYJFhg0zJuo16LLZkpJjSzuKQ51sJ
	 r6any5+3o9mkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE209D9A150;
	Thu,  4 Apr 2024 22:58:04 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs repair code for rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <nqkz5ed4k5vhhnmr5m32jydfgnon3hv7rj2vl6jywz6h44cjqp@olraxajp3avu>
References: <nqkz5ed4k5vhhnmr5m32jydfgnon3hv7rj2vl6jywz6h44cjqp@olraxajp3avu>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nqkz5ed4k5vhhnmr5m32jydfgnon3hv7rj2vl6jywz6h44cjqp@olraxajp3avu>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-03
X-PR-Tracked-Commit-Id: 09d4c2acbf4c864fef0f520bbcba256c9a19102e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec25bd8d981d910cdcc84914bf57e2cff9e7d63b
Message-Id: <171227148488.29192.10440081755784547472.pr-tracker-bot@kernel.org>
Date: Thu, 04 Apr 2024 22:58:04 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Apr 2024 15:22:53 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec25bd8d981d910cdcc84914bf57e2cff9e7d63b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

