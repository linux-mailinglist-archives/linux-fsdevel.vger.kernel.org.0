Return-Path: <linux-fsdevel+bounces-35130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685A9D1943
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9E3B23E59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE481EC017;
	Mon, 18 Nov 2024 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0C0Ct7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F11EBFFB;
	Mon, 18 Nov 2024 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959344; cv=none; b=movp03zQ67OdYf8dhSL/D8ThmRdC/lrLUyKQfWiMDtj8KmFDpmAsxuzYZV+j/8jocG0xvClMMU8RRG4q9GlwXVuz2tQd6fUeiFhPBph87XnsgPUUFhOEnirFcVeEkWI8OLnnUxUy4gRCRutjNfkUaBw1Fa/pF+9OQYDMn4akYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959344; c=relaxed/simple;
	bh=WJy6cyxzrsUxYeTPOZnO2alhGVLP3g7Ml3zHHDTiy9o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UVToiZKF/lVSDuX+od2HfZuF1q2wg9WK9Smk6q7xiH5JDh1OjOKBva5kMNa5cyGld8Zazg/qGwq5QJ6OgECHkrItE4Wz1ZFfH3/E+kXxC36D29vMmz3iXX0vrsIomIu8sJv4Z42imQPm7/1yVuRG5zrHkJ7zautQtxl3lMZUTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0C0Ct7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CFBC4CED1;
	Mon, 18 Nov 2024 19:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959343;
	bh=WJy6cyxzrsUxYeTPOZnO2alhGVLP3g7Ml3zHHDTiy9o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r0C0Ct7LgbWOmXEzy1d/V8FManxd/MueRX7Extj5k9vV+/BEKMfTrZgql1xjJFg+0
	 5yMYFFfEXG/44pM9F5zAa+HZVxbtLBcsuUalpvKVHvd9rvmah3zuGRp8ga1ahzB/S5
	 kSMiIs3+B5SxVad7FXxtLS2ZiAlukpy+DjSyl2p03ixdmOI5UbUOp6G3UEBDlOzEfq
	 /NmrDvxHE+8Bbqiqy+PUKK22TqtniHg1mkQJm3MX8WjGjvBM7PoLiKUMo1H1EkEWa8
	 rYq2UUOUQEfHVZARDbEIjmCCpvVNVhVgqCwQBXW8gl9ObOFzqmwr5haseiNkrPq5cV
	 Y5bP4Q83r6A7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339DA3809A80;
	Mon, 18 Nov 2024 19:49:16 +0000 (UTC)
Subject: Re: [GIT PULL] vfs pidfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-pidfs-841631f030e8@brauner>
References: <20241115-vfs-pidfs-841631f030e8@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-pidfs-841631f030e8@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.pidfs
X-PR-Tracked-Commit-Id: cdda1f26e74bac732eca537a69f19f6a37b641be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 909d3b571e5a77aef0949818de1efda129dcddbd
Message-Id: <173195935481.4157972.8093566269079588596.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:14 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:04:33 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.pidfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/909d3b571e5a77aef0949818de1efda129dcddbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

