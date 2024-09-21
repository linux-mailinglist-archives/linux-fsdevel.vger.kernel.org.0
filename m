Return-Path: <linux-fsdevel+bounces-29776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192B297DB7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 04:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BB01C215EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 02:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A0224EF;
	Sat, 21 Sep 2024 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWPJ/ZHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150401C693;
	Sat, 21 Sep 2024 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726886206; cv=none; b=PnNpAGqsW4icZWBuyxjA03V1wL4YiGe7fpTWpodlgX8+aTPjfeUXHNr5eMPoYBZwDtoUZJ8GVGhfI7IJdW94tZjx9BFoMrdWZ/GYIVWzhmzQIiwWoI//Ve4xj9KWgn56nBNTcozR5w4luPLkkols4ACpbkB3YY1F/qDDeT7Nr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726886206; c=relaxed/simple;
	bh=RLiPbDYcGzDNjeU5OFk78Qj7Nelx1ZSOke5SLy8pfFI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gYMOow1+ZQay6nKeZ18Q3uAz8fkprcGXnbsDTt84y0PmOhAeaitUY3qtfGk6HhozUmnP5LQ6HFuT4vUWYS/+bn4wIbAFfBlgSmLBXYPJ+JNk34/zvIAY+pINY+/juR13B/c3URWmN9O9YiLWwZKjd+HmB4zbD0fvwwloxnepBFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWPJ/ZHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED15DC4CEC3;
	Sat, 21 Sep 2024 02:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726886206;
	bh=RLiPbDYcGzDNjeU5OFk78Qj7Nelx1ZSOke5SLy8pfFI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QWPJ/ZHyHuShkbUAAoqGgJP5PavFFg+3Z4oSqHN6cGbdiA4H8z5q+kPogWMC+qbEC
	 PikGyuavV6D9pFYcBrbRycHD4uvUxNA6GCfZYzJB7R6KunEbvfs+I69Ra9kJtp44eU
	 feg4TOg2BeXVemOiqdWa2Y6M6EQUGcuYRiihns44/D8XuTcCv5XHmvMxY8oztpRmZU
	 dT6JToWG3W9b9G4XGFYKMsOaMOjLy3Mj3HY4bRQcL6v1S7MU/W/7FWOHgF5eUi4jj4
	 NPcup1o6tzXxmPpP5CE1orq2B/lIGnB+vpIcKbuWPpMswFqYnxiJDBMz1eOlUSNc2V
	 t9qO/2YvnrQBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9A3806655;
	Sat, 21 Sep 2024 02:36:49 +0000 (UTC)
Subject: Re: [GIT PULL] vfs blocksize
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240913-vfs-blocksize-ab40822b2366@brauner>
References: <20240913-vfs-blocksize-ab40822b2366@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240913-vfs-blocksize-ab40822b2366@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.blocksize
X-PR-Tracked-Commit-Id: 71fdfcdd0dc8344ce6a7887b4675c7700efeffa6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 171754c3808214d4fd8843eab584599a429deb52
Message-Id: <172688620789.2370754.10456047862779862980.pr-tracker-bot@kernel.org>
Date: Sat, 21 Sep 2024 02:36:47 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Sep 2024 15:49:53 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.blocksize

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/171754c3808214d4fd8843eab584599a429deb52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

