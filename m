Return-Path: <linux-fsdevel+bounces-45055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8DFA70EB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 03:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67D5188DB0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 02:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1AA1459F7;
	Wed, 26 Mar 2025 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6GXU2Pv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6554A13B7A3;
	Wed, 26 Mar 2025 02:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954688; cv=none; b=IqFIHaJlHQ4nTp7T8MbAt+7l+/jiWUaJ8ii6F86WyUXwvSqz6QLsZwdLrEihyzzNgfuKG9wuNBZqbrrgUIrlTTvw96M9WTSbmecQLekI7uqFpnygohzRBQ6n2O611MraCasXCMxdEq16rnJaR37geaEkg6LxiG7DB8BU0+dSz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954688; c=relaxed/simple;
	bh=MyRh1uk0zkYqjia+cRcp3YZkE48XqjiHosWZiJb9pjA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ofP0y76I7xGn9NWOmbvMSoR07lP4DnJzRGQvNtDo0M32AI8hykY/s2Lx2ZFk8PLigdv9GwB2ParVNnwNJfyd+PrEZuWXZHK/IKPOS5PG6XmmHPa7qWo8a6VDobE0zL/6+pk0NFG6nJfNrAC3ljBPhZBJ0aK/gT4I0lNKShxbA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6GXU2Pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DC1C4CEE4;
	Wed, 26 Mar 2025 02:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742954688;
	bh=MyRh1uk0zkYqjia+cRcp3YZkE48XqjiHosWZiJb9pjA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M6GXU2Pvxx0HjpM6VkMlSmqY6y2/Zo7KR+RnpQxQ8CIhwfy4s3xtSYQL4bzNhW3hj
	 Z6uQ8g0k3bOa3Qub9X6mH5fHNzcuOPuIIfhUIdBuL09AGFk4G98DEggaoMcS9boVsI
	 AUiYwOZkZmNBWVjWGyX5Ndyw84f8+thdcAxhmfKe0R2Yw6JaN0C5bAD4xz+KbhNQJW
	 0NE/xNgLfbNZ3GvAIEZPNQXe+nUY08QhT1KUNJj/bd+KtsSGSm4kwDTuhsW8QSPteV
	 lxFA+iydFwhSAOWDCLrCxa6JSAm6BXvOPP/mBZUmW2DWHBxqM8plRup7Q+HxPjQ34K
	 Hynp9QawFdiVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB7380DBFD;
	Wed, 26 Mar 2025 02:05:25 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity updates for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250323222011.GB9584@sol.localdomain>
References: <20250323222011.GB9584@sol.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250323222011.GB9584@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: a19bcde49998aac0a4ff99e9a84339adecffbfcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdab2977e47a2eac50e3a0ce23eb5eab110fd490
Message-Id: <174295472439.808498.1577000852354882678.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 02:05:24 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Allison Karlitskaya <allison.karlitskaya@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 15:20:11 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdab2977e47a2eac50e3a0ce23eb5eab110fd490

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

