Return-Path: <linux-fsdevel+bounces-56221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68240B145A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 03:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC241AA2280
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3C1DE2A8;
	Tue, 29 Jul 2025 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO0HD63c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B81DC9A3;
	Tue, 29 Jul 2025 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751526; cv=none; b=qzH7FzXw/5EybjD+r5DWfhKID/Fl7iwQQZvVYCuR3Tsc6Jxx/5bdjrE4W7HfQEQITe1T+Y2fuOohZ2psWYXiJY4dU2XUWKl0yScY+ICg3n+OB7QzIlVgIPVNEfQGYO+VAIpf+TWqBaVrmzRukNzevuJ6fhX2jnJQOxmIB1Q5H4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751526; c=relaxed/simple;
	bh=gmUh9Sh0j0jgMr/SCvJje9JyCl+B9L8wg8DRgndPBHI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YNHH42MrSWvX82ToLtwB3Er/nvnYXcaVpwfuMC1NBlPRnL7kRy7G6i4TQSnRTlsp4cdlLKZLdjchATaQ31mGDdVx9L8JhXoy6xXGAkkQ6U3nWLkWD6FS0tVITw05cpyLEQeH8i/gczw9RQKmKHYYsLK1j4JoIej51QFLbYGRJuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO0HD63c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35342C4CEF8;
	Tue, 29 Jul 2025 01:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753751526;
	bh=gmUh9Sh0j0jgMr/SCvJje9JyCl+B9L8wg8DRgndPBHI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AO0HD63czUVCPA3q7bImGWndVQsPIMJNH87zW9b0ss3uxomjKNQuJRbgUSEImtm8e
	 iagTv9DzztMUAGzMtwpF+8q/G1fJFWDQ2wz+XHAGWRWLB9QM1o9ygyX2YqxoRvtfnt
	 357ibN5oFNb5QxjTETa7BTdW0W78JbsuYkR+Hz1/s53jaOUb9LcVsrMyTaQ5eql8uc
	 iYdkEPub+wfmezqyHMWO2JLfD3/Akm95Ed8HG4eZ+LN0S07YiAcAe3lTdP/fmEzKjt
	 T3f0nXWp2ge/gCHgFD6zxNxLZqao4uUi35FQFcocBohcfrvsEndCIF99Jx+SniZn50
	 6p7pCzVIGgkhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD14383BF5F;
	Tue, 29 Jul 2025 01:12:23 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250727234936.GE1261@sol>
References: <20250727234936.GE1261@sol>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250727234936.GE1261@sol>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: fa65058063cbaba6e519b5291a7e2e9e0fa24ae3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 283564a43383d6f26a55546fe9ae345b5fa95e66
Message-Id: <175375154263.918485.6243720015057369298.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 01:12:22 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 27 Jul 2025 16:49:36 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/283564a43383d6f26a55546fe9ae345b5fa95e66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

