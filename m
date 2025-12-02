Return-Path: <linux-fsdevel+bounces-70424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C416C99F61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 04:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784D43A5B6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 03:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13B427F727;
	Tue,  2 Dec 2025 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMj9AyZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F934284672;
	Tue,  2 Dec 2025 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764645729; cv=none; b=Tk2FV8/kBD6/ZjRWfXgzkRskxQd9CwfXKXQBXqlSHi0bB3udvnPxguE7edYJQbC7ZgMiG8TTqgJpD1pMEBpRT6fTExHcmWRjREYQIEBkI4vpI1IoppB/UXWvNg+rU6a5CJVaDFqP+6sPzkym61FDnmjyWa934P+QvndG0nwYKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764645729; c=relaxed/simple;
	bh=pBL3mUgHdLzYzxGTzBE0TukJtDvRRtcXV4/ptNf3iKI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kg7yA1H3niBCGBRyMOAJzBvcL6cSBIgLT+C0abi8ix2Bt+iCDVN1gTpA7MrcvYKJ5zEmEOhf6zfmOgKUKdFfleytwS237RJErk9bWHZEA3Vh4tcdeNBMMvrUnro0Tc2+LjXUxCekHmmdNLgz91Dulaflc8nteldNSN01jcrX4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMj9AyZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E731CC4CEF1;
	Tue,  2 Dec 2025 03:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764645728;
	bh=pBL3mUgHdLzYzxGTzBE0TukJtDvRRtcXV4/ptNf3iKI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RMj9AyZsDNC7KciThD8ubp+PfC77XHUjUrhJ0+WFccj1xbmNnU69h8AdEK+Bn6rFV
	 OPjRt4VkW+pBTmBCY6lOV4Ou8T6kcRUc0B9sOBkn8s4UsZHznqvJeS/HwPZj5HsMww
	 CvdtCSMmjsSOLtLl3eUB8oYMcEiA6wRKyz/qbAmH2zreWDYax+MlUnxdfia11kU67f
	 Q72rnB8v2yddTIvN6D8oDlMghaX0UCPCtcnsyRyVfgjwqq6GTZc2wgD3n3sZtLFv3j
	 A1hPWZ7YZV852rI4WEm0HuLJ3qJT5N66AnUhE5YN42Kw9HzBTXm522AR54wowng8K1
	 N4Gu82siizQ3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F27F13811971;
	Tue,  2 Dec 2025 03:19:09 +0000 (UTC)
Subject: Re: [GIT PULL 15/17 for v6.19] autofs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-autofs-v619-9dc04a44c420@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-autofs-v619-9dc04a44c420@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-autofs-v619-9dc04a44c420@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.autofs
X-PR-Tracked-Commit-Id: 922a6f34c1756d2b0c35d9b2d915b8af19e85965
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffbf700df204dd25a48a19979a126e37f5dd1e6a
Message-Id: <176464554864.2656713.10370355675122535441.pr-tracker-bot@kernel.org>
Date: Tue, 02 Dec 2025 03:19:08 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:26 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.autofs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffbf700df204dd25a48a19979a126e37f5dd1e6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

