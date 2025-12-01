Return-Path: <linux-fsdevel+bounces-70387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04035C99599
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39FFC4E42D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1650D2EBDD9;
	Mon,  1 Dec 2025 22:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9rKqA4b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA282E2850;
	Mon,  1 Dec 2025 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627083; cv=none; b=BLsKMhwZWvHiipjr6CwcuiHWAV8Zn3vj7PrZA0Jkkzeell85qlMifU0IJaVOA91sXToPEfdJ3XGfn3oLyqao46uXQP+vaKxoQ9ID9MKehoWtYvrmKXsnFcP7xqAeU5Hrq/LSlS/7ea+AbF9YWlSLfhnY1mVwL5GvCjrJxjQ1Rko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627083; c=relaxed/simple;
	bh=4g4/OXizgzvhEbHwuOgTQhDAlQwm2RBDeWZOw7kKPPI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RElJoSgO+SxTaLar8wY3kXecoUVO5y8NwySrAVeu29gQa813LjDT/S6bWDHnOMXRvTqoMo+jo+6NR9cVJVHbfIm7/Q+Mz0kjWZhwzAKtlcKvosE1M0mDnUt6ePuuGr2Ih62n2RiRIXh3a3fLNHcQh+18voRk/fWrDtxAuHNB2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9rKqA4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E68EC116C6;
	Mon,  1 Dec 2025 22:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627083;
	bh=4g4/OXizgzvhEbHwuOgTQhDAlQwm2RBDeWZOw7kKPPI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B9rKqA4bZz47NyiyT4G73KyC6QwavjDH5JFbwy4QDi9mEnKkwUYz+u6dqQvVb9xAd
	 TD1QJdUo1CiuCuP9uiPW1iuCLw+D1QLbIhK5x/gcdl2GPY4f5HscNsfVuAVxyXlrgF
	 ygy6J9Yy9TkxFKNP36KPiVYdYZ0EPSggdYB1nexe12RKSPXGvi8eUzD7JG1TYHzOg2
	 Ul/iaq81TY+fQK3m36w80M9s5Ld4XvjFMEUBva1sbVcg6RXZgDXV81yJHOCj8zfnXG
	 jDjMamhg0dPluePJfz6jw8T/pVXyVX8vKImYmSJkIoxM4QrMKcc53AbyG3vz6WWiCu
	 MBzCh7FWL7/tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7892D381196A;
	Mon,  1 Dec 2025 22:08:24 +0000 (UTC)
Subject: Re: [GIT PULL 03/17 for v6.19] vfs inode
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-inode-v619-730a38ce04b0@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-inode-v619-730a38ce04b0@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-inode-v619-730a38ce04b0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.inode
X-PR-Tracked-Commit-Id: ca0d620b0afae20a7bcd5182606eba6860b2dbf2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9368f0f9419cde028a6e58331065900ff089bc36
Message-Id: <176462690307.2567508.17081694375406552992.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 22:08:23 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:14 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.inode

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9368f0f9419cde028a6e58331065900ff089bc36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

