Return-Path: <linux-fsdevel+bounces-70391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7306EC9959F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209403A3F22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27724286409;
	Mon,  1 Dec 2025 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2UUCuD4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91F2FF654;
	Mon,  1 Dec 2025 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627089; cv=none; b=Ydc9247TqjLbus025anWk5kT9O9En+no0cZcbjHtghc4yo/BerH1PZmhQSWjpjtZaLFIMSwjZVTXmOgfbiojrFi0DC7u+6tMOxSrfop9JU7BSIs2Uevy65w1dGZPRU0tm2Py9lcZmj0B//phNyTbXEbBIRJeGVLqVsjRhOK/BQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627089; c=relaxed/simple;
	bh=3zx4cYjnWAfQRPeZUqfxa42YNMdchtoJ4CNEt14iJm4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bs1g8aakYa8BiKq2kEgYBmh0vpnjj5pJnrbPtxM1SJW1o3PXaQp9K7fB7t5CWySpiRjEVgE7LDiUjM6TPOYD/lLSVSjAho6oQSAdRXThBfyiE13UMWFKhbl2CZc750GR6VUR5LNXIWyfw901YwOWGw7psTBDvoXI6KYtZg1lJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2UUCuD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C710C4CEF1;
	Mon,  1 Dec 2025 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627089;
	bh=3zx4cYjnWAfQRPeZUqfxa42YNMdchtoJ4CNEt14iJm4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=l2UUCuD4PkUXPTa15zSm0WwW7SNNncm8WP9DRbXCnbe84OEYhU3mgK3Razkhh9WIJ
	 1ZWULPS++jzdNr9d4pdA8YZYIGfS0B/jhrwwTYMYOMn/7eyHjFCb78lzgXEWra6rx+
	 mY31EPf026Mnsc89qDCUsvaSd2TWaq0SlU+cnpfQqAe1gEQcla+UFEVBzScFnVjyOi
	 ki3W+qmt8ywr4ERTY3AcLyYf0i9SE/86cOqln0wGnlMRMJ0OCn6OLdmz6r1pRN60Cg
	 Q9Tqgrra34mvzyjOqJ/6sAo4pmm3qa1y8m5IYOiAQMRbQSDGAD8ZzVePYsG//8gWwH
	 jWCbEc+HgfuGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78D2C381196A;
	Mon,  1 Dec 2025 22:08:30 +0000 (UTC)
Subject: Re: [GIT PULL 08/17 for v6.19] cred guards
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-kernel-cred-guards-v619-92c5a929779c@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-kernel-cred-guards-v619-92c5a929779c@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-kernel-cred-guards-v619-92c5a929779c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.19-rc1.cred
X-PR-Tracked-Commit-Id: c8e00cdc7425d5c60fd1ce6e7f71e5fb1b236991
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d18101a644e6ece450d5b0a93f21a71a21b6222
Message-Id: <176462690908.2567508.4385326307120226131.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 22:08:29 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:19 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.19-rc1.cred

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d18101a644e6ece450d5b0a93f21a71a21b6222

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

