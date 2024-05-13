Return-Path: <linux-fsdevel+bounces-19390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EDA8C4797
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 21:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D82865AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 19:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977E97BB01;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaqV5qUK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B6762CD;
	Mon, 13 May 2024 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629081; cv=none; b=ZKuDtkM4PsRH9xbhHQLePDxDqnXgGGM9uZf1kPnDjoVmrbYsVWbu2U/cg9OX2P6JgJKvj7J6Ycy/129ppU3QEi3kDWsH7r5Z92PHmP5u3e5n1c6E1mHO7F+GaXhpQuXcsdBHoKu4ZGGrDXq4ECM75utEqm9jGYF65pHKe++/ABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629081; c=relaxed/simple;
	bh=vMr3q0qDmUu2DHuRbejlSr8KWtrL/KnwmauTLIDl76Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YRxO6Q9fADnw/0rP9/PjqlZSg/Kzt1Kj4+Ln1LE/eiKEWUbEUojp9LlggQqxY8wJx9LEAyZBc8TMBrQISuVtyhMTRXiaQxE8ATZqnpHwRbyD6Gu8QDxz1UfxFpsjDkx/RmihqxtWUUrFB/FyrILzKsK4wNknkgsHd9t72bp0+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaqV5qUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA915C2BD11;
	Mon, 13 May 2024 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715629080;
	bh=vMr3q0qDmUu2DHuRbejlSr8KWtrL/KnwmauTLIDl76Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YaqV5qUKeaHuuOlukCDEI1dNq9IctFXGnOQDBOAyYwObzTnrOdbOifpVYt6CaiSnh
	 UyGkukp/xqVzirBkaMOYzmQxODi5MaSZZEHd5JfZjBE8jBPa/7RxPS29ROERxUsE1v
	 dfLsoi2cg3NjssZa8MoueXF1efQ7ne2WqVyj15MFQErfUsMDVp3+8P386dWj0fLxJc
	 Wlyz9pKfrhfGZ8uw16b5pl4k1Xp8WHqi6NZdPZBLQg7P2l1C0UEFnQ+da0wgDPa0u3
	 2eLga6OXeSYsXqTWqs1wtfuavHUcpn1CkoJzyM4Q/siJmWwpbkHjeEYRO53tsm5ZCM
	 v2yvAKOkIsypw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD711C433F2;
	Mon, 13 May 2024 19:38:00 +0000 (UTC)
Subject: Re: [GIT PULL] vfs misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240510-vfs-misc-22ed27ba6cd7@brauner>
References: <20240510-vfs-misc-22ed27ba6cd7@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240510-vfs-misc-22ed27ba6cd7@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.misc
X-PR-Tracked-Commit-Id: da0e01cc7079124cb1e86a2c35dd90ba12897e1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b0aabcc9a35e729a6c7ce71e725fd63513b35de
Message-Id: <171562908083.8710.8897785147727962641.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 19:38:00 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 13:46:24 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b0aabcc9a35e729a6c7ce71e725fd63513b35de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

