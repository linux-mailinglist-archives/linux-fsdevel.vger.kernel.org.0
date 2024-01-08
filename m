Return-Path: <linux-fsdevel+bounces-7568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3D88278D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 21:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2AE284F45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 20:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C8F55C16;
	Mon,  8 Jan 2024 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXZAV2kR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91FC5576A;
	Mon,  8 Jan 2024 20:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91560C433C9;
	Mon,  8 Jan 2024 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704744005;
	bh=Q0exoKZQGWsKykvD5l19b1/xR0EVILigitglXuPY+2M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gXZAV2kR+KrNl//eZQqVNowdNMP0uhdDpN1BNEi8i4TYmUJKdw/uoOZihr8g8Demc
	 5Uu3OLRmkQnwxcIUO/f7R/G5k/ri6Yh13En7gZnmzt3/nwdoYQBEtczpnvPALZGDrx
	 5F8ZsXJxT1SOK3ucezoDb4yF57kxEYTKHfRUJbr8YqrlXR1Y9EV1zQLtTqYzPxGFuC
	 tXeqKWHRPvObDBQMM/cySieTWWzZaKL0Owo+IJAx4TYQ5mbmNA4XnYqA1LxaJBO47v
	 42rZ9xWjPMqENQpDWYZMbXfQsNWHOIQodUcbHCVLSc+8Iqmxsk+CrfVOKdGmYBRZQd
	 +snzYWBa6ho0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A7A3D8C9A5;
	Mon,  8 Jan 2024 20:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] vfs misc updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240105-vfs-misc-62acb84c5066@brauner>
References: <20240105-vfs-misc-62acb84c5066@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240105-vfs-misc-62acb84c5066@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.misc
X-PR-Tracked-Commit-Id: dd8f87f21dc3da2eaf46e7401173f935b90b13a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c604110e662a54568073a03176402b624e740310
Message-Id: <170474400540.2602.12939656056595543468.pr-tracker-bot@kernel.org>
Date: Mon, 08 Jan 2024 20:00:05 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Jan 2024 13:35:05 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c604110e662a54568073a03176402b624e740310

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

