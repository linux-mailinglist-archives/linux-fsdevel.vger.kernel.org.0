Return-Path: <linux-fsdevel+bounces-28450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B117B96A7F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 22:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FEA1C241E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB65F1922D3;
	Tue,  3 Sep 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4mKeISm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557AC1DC75D;
	Tue,  3 Sep 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393720; cv=none; b=roi0vV+2+/Zck1Bd7EXiow3XFYMgP0enACna8499plHjfzYwYc35FloF7ijdJcZmJ785WmunyFrvUrF2MDpGUNeeWyDTYHXnn4DFRfeCrew8zjeOqS3e0dCnkfu01aJtMoADfy9TlvQugHNMtdaCa1TS4X2aL9+S32IKS54IPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393720; c=relaxed/simple;
	bh=BJ5+xHQzeNHlzZqnL/XxVnntzkbjsoxMI8UADE9W6EA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NzRbAMqkTk2QSgvGsw3gT+CzOP5AVuJuKTU8RREmOt8qX8TstZAJJHo1n3JkQF12r4UVR++P3XEfjisSDnkvJdeqYNs9efotuVRi/qkVQhnra5b7YNPorLYz3xoxWZzrTiK8OdBmy3YTjt7DxvjOSeOp0V48DdzHWS/xitBxIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4mKeISm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA03C4CEC4;
	Tue,  3 Sep 2024 20:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725393719;
	bh=BJ5+xHQzeNHlzZqnL/XxVnntzkbjsoxMI8UADE9W6EA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S4mKeISmcHFTl2ZrizBbsuS5gfAlfp1AldclHGgYLo+CfZHTM6l3Ce1iV33W8+nTd
	 p0yHgixZkwbDyWqq6QRPgZ0f/mm8VBi/EOasg3E/8EPkbY9XlONTlCQmI2mq+UopJ2
	 ZTVPUZelOl4fhCk+qwh70Z+POk/vEb5d1SjbAn4o4Z7r1DTT8a4LElrxrICMjvRZGm
	 +Fj+R1AcwUKYKS1p6Aw07yQJGcwaJW7vBfYHWRaOndDCBtP9Ho6UmNpbJVScB1DUxG
	 VyYUybhWDoG0ifYHAyu9ZJ7ku8ImxnlpFtdQRiEBCiJWuPgc8Zv2R86O1AiY8nhSeR
	 YQOfa2ozgtOzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C978C3805D82;
	Tue,  3 Sep 2024 20:02:01 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpeguT0XBxBCzBrJqS1LLCLmEahVT3FF0NZ1nkAKMRKWpyfw@mail.gmail.com>
References: <CAJfpeguT0XBxBCzBrJqS1LLCLmEahVT3FF0NZ1nkAKMRKWpyfw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpeguT0XBxBCzBrJqS1LLCLmEahVT3FF0NZ1nkAKMRKWpyfw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.11-rc7
X-PR-Tracked-Commit-Id: 3ab394b363c5fd14b231e335fb6746ddfb93aaaa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88fac17500f4ea49c7bac136cf1b27e7b9980075
Message-Id: <172539372059.424127.17267698860441437579.pr-tracker-bot@kernel.org>
Date: Tue, 03 Sep 2024 20:02:00 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 3 Sep 2024 12:38:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88fac17500f4ea49c7bac136cf1b27e7b9980075

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

