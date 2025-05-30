Return-Path: <linux-fsdevel+bounces-50248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09288AC980C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 01:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FEE7B0EC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 23:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861828B7DC;
	Fri, 30 May 2025 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uni57PNn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652BB2192FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646988; cv=none; b=IGSMWx5lTvbq4Zm1nCjome+qwyFNGQucfvkynoqAWFrZDsWMwPnX+ACGL6LG6Mf70qw45zgKEH5pTn6fFlJbFw1rYDzVFlngCaNHECTMbKPbIjUnlvqe4ZvUA0YefNpYRdGSPxraL8NJjfVx9gxc6sHv+FRQekHNN3mocjpHPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646988; c=relaxed/simple;
	bh=D7MKmMXURqWpUuZKdEwUIOhOdvvabDQ4ipdbm9LrjKg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FBW8tR21M19dqS8CYYyTVsVh08vX6LRqDOcwj5wcl116qt5x54vVk/bASwwWgTyvU6XcZcjv+fvTy4uRkRccpzUpZuxOEMuUfaRHLW3MJkFl8VLzqdWrBZdGRRzxgl5SnRkBrIWsOfzOlNcJ9q+dQqV9u74oBh4v/CC+GbrSp6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uni57PNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08D2C4CEF0;
	Fri, 30 May 2025 23:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748646987;
	bh=D7MKmMXURqWpUuZKdEwUIOhOdvvabDQ4ipdbm9LrjKg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Uni57PNnTvFEpa0prkS4I0qRvtYSdfQfsTV3oGqKv7wzxSeBNz/ORQ4ZmFjH26T6M
	 C+TGjBt6D0+Vq+3GPWASGjjri6j/p/70/8yq344j/NTbrS2YdYcYHHSa37H5Rco6jE
	 wspOR0UMk5UEPBsNPIZzRLuxbudc4HLBu1gzoQwegelE8+6rXIR77IGo6fOsSyCLcR
	 xdw5iap+L90KOqEwKu+lAu8kjgbY9o4la+fQ7rcuaSTlbMLaUhs11h+4JVviGPiFtZ
	 10Ro2CGKP9z1omHXk/AMTDyZXEHgfPSnwRuj2pZPSr571ewVPF6y/DWNOZmncg7bsP
	 tcQoVfjSGbjFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD139F1DF2;
	Fri, 30 May 2025 23:17:02 +0000 (UTC)
Subject: Re: [git pull] regression fix for mount propagation in detached trees
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250530190447.GA3574388@ZenIV>
References: <20250530190447.GA3574388@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250530190447.GA3574388@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 3b5260d12b1fe76b566fe182de8abc586b827ed0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a82ba839915926f8713183fd023c6d9357bae26c
Message-Id: <174864702081.4165071.9415352152664831718.pr-tracker-bot@kernel.org>
Date: Fri, 30 May 2025 23:17:00 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 May 2025 20:04:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a82ba839915926f8713183fd023c6d9357bae26c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

