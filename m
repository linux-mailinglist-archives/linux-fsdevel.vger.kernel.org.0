Return-Path: <linux-fsdevel+bounces-54034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD412AFA7DA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 23:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1873017AB62
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 21:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E7A1DF244;
	Sun,  6 Jul 2025 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDvuAxTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A11C5F10
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Jul 2025 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751836143; cv=none; b=lkAX5rkq9Naqs5PtbPQN9lsOnDeOMKOSqsuvDhn+NDulGlYdRUZq+sqZPkQERUvqAfEFUexGgC0uI/RPmpcwMKqxo1aTnFt/MPKMoYieguLczpPbCEfB/iP6/pl0IBDbnroINitNUL1UUhK7t2+ETxNCiAmUmhE1QSZraEbbjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751836143; c=relaxed/simple;
	bh=LML9qt0Oe1cKbHmY+CRzEt1P1CvDDFMq75OHxedzv9M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YJ8pD1d6yl7F8K9XMPMa8p9NLiYeg/LdwFOSKDJvUsYmL1RcrZVjLrVCQmRNHsNqIX7GYj9y45iTx6mLZap4roblODvKZ4cOYMad6R6SsmcCaJJ+o5S05i3tNaQvE9BKZGB5oyTY8z9nF3EGQgJ6p9Wdsw2QJkC+qCf7C70LVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDvuAxTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5630AC4CEED;
	Sun,  6 Jul 2025 21:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751836143;
	bh=LML9qt0Oe1cKbHmY+CRzEt1P1CvDDFMq75OHxedzv9M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hDvuAxTV2U3qvZhOf+GNbONw/TljKjuldG59p+KhvMfcJ6B2c0W5kzkElIn1tvsbM
	 pkKcNptMPnqPmh2/8FURKTNNwAQju94LOsCYB8HWHqfht6wo/2vCxqyZOadDPkB/5v
	 J6aMhDjookjunRG0IwmEDshejb1NYpJNvTfcwrkzH+BKscR2COAi18+VQwT6Rcur8h
	 enAeCGtM8BmMCFVJfS2PlJgo0dkIEE0/mQoZHnHKiUPFc9WbwBwRo4EpdPAxF70D0i
	 MgpcUuZdDDQOd4yhus77QJ8yWFAbL/h0NsRfEeiKVnqZM1VFxeev75+Fekr18ekr9a
	 +LUo8rwqFUnYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB21338111DD;
	Sun,  6 Jul 2025 21:09:27 +0000 (UTC)
Subject: Re: [git pull] proc_sys_compare() fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250706190649.GC1880847@ZenIV>
References: <20250706190649.GC1880847@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250706190649.GC1880847@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: b969f9614885c20f903e1d1f9445611daf161d6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bab5cac627b36a96ffc344274953558906418495
Message-Id: <175183616645.2729877.10705449086941539373.pr-tracker-bot@kernel.org>
Date: Sun, 06 Jul 2025 21:09:26 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 6 Jul 2025 20:06:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bab5cac627b36a96ffc344274953558906418495

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

