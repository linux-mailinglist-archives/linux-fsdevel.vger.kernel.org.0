Return-Path: <linux-fsdevel+bounces-35127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31C9D193C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3471F21A31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD11E7C19;
	Mon, 18 Nov 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5bH44r+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A971E6306;
	Mon, 18 Nov 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959339; cv=none; b=hukQ5dXSCsLjhl+Ag4Hogx8/CiabtdhvJVtb/wlkn4L5+aRDt6xmRBS0NWC3FUuo4DuhAlUbvssVDnRp49iRVtTvx6PFPZE9btrasOkeBWdiEmcB7cb9KaFumxunZUeWURGFsO96K4e6Hv6ReHF2WT8lEA4kA0yQaTp594FFzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959339; c=relaxed/simple;
	bh=HgWa42ZxMrzCSIb2brfaJKtHOT7+Z+iKSDeRb5ioT1w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HTzA1Ziu2Gw4patppFdGZ+acKa70fhEQvZqEmvaPItFjg0C3VmHTCKu3wj3v+/C0DUjJQuN7CT5AcXOhCHyJV43YNJuLDvvTmNUL3deoJVGPB9D4PNQjWc78kJDDEKJ632KR4EAT68zTZY2Y2e60ZaJfaZbSIzn9Dn8gD4l65Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5bH44r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B063C4CED6;
	Mon, 18 Nov 2024 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959339;
	bh=HgWa42ZxMrzCSIb2brfaJKtHOT7+Z+iKSDeRb5ioT1w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q5bH44r+rQ4nBeGjCHmV6vLJTFmGz9vRMWcwK8JR1Dvm6HQA1bb1s7zNab4Vt2emm
	 D64IspXuUkpyGrtdxxD7Gk+5DqgnYKxTnvOHsHeJn6VAIsh0tpeBOIrBunGeQEZWIA
	 D5h/d/9TKJlWbWoZFdfKqz8A69ruZbX4atfVeF1HWPQXNHOePVGBty642ubJ2OpF/M
	 1UbGN748PQqq/dws3CVVVLHhVmqNNetowcO/2aQvbu92RBDkBlt+jWFeGGvxIIkw7J
	 eSgU2Qitt/t36QWA7tqPp7t+Pe9WToLvIfy4hSIKGEVbKX7UZCgTQ+53l3xTzkhdtu
	 5UIys3V1G3wAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBBE3809A80;
	Mon, 18 Nov 2024 19:49:11 +0000 (UTC)
Subject: Re: [GIT PULL] vfs netfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-netfs-7df3b2479ea4@brauner>
References: <20241115-vfs-netfs-7df3b2479ea4@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-netfs-7df3b2479ea4@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.netfs
X-PR-Tracked-Commit-Id: a4b2923376be062a243ac38762212a38485cfab1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8dcf44fcad5ef5c1ff915628255c19cbe91f2588
Message-Id: <173195935033.4157972.8749979756552063791.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:10 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:00:21 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.netfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8dcf44fcad5ef5c1ff915628255c19cbe91f2588

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

