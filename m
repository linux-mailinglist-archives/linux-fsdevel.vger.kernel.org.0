Return-Path: <linux-fsdevel+bounces-39722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173CFA172EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737B03AA485
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178441F12F2;
	Mon, 20 Jan 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv7In4zj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AB1F0E5E;
	Mon, 20 Jan 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399573; cv=none; b=UcxIG+awtVGd1fZuCZSatUsR0iWUNM6CLcwhRSjPRsyTUC9/lwIVuiQ+bt81saa3GAVaRldxiNEFkB9PFZmzKN4iiPgJUUhnXvRK00ejdBrIiniiiwN0IvMJlGNErnt0unzKXqbXKD9JxC+2jHX3e+jrD1u8CEE0dfG2r7eWe9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399573; c=relaxed/simple;
	bh=cqM45PgahvYBK2SVBqC3mDSBrBGk62NIN6SglXmikUM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UVjyOTgUeSfdj6/rJLiYjDTwCF8yjt1Uo6qNh/pZi/N6czvHJFbZcDIwxuYc2NVDz37903EGtssmy6uX/8787Yp3vlOIc3onuZzxl/UOyC/AAUhkJC5yEzhvjpQMPhDdBfHtDo52+4baW3NvdXBzb8dU6Rc+PgJyz+jQzPKxa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv7In4zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05B4C4CEDD;
	Mon, 20 Jan 2025 18:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737399573;
	bh=cqM45PgahvYBK2SVBqC3mDSBrBGk62NIN6SglXmikUM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iv7In4zjSgJYROqNIhFzshGmeObNOw1QqHqhsm8E5YeRsTdFpGofFUekFtgt0A4TS
	 zyAthipZ9lT3Qu/r72L9FOPijT2m+IcxHupFD5MlrbpRHvDDnKVTaLTJj6M5hHTLLs
	 0U1QoQYh/ks+aiZjXU0+ZIqPiH195lPIQVpel9QAv6sESaU0m9UcqJo4KsvW24aEM3
	 PQyUXag6Y0wBTlyfMoG6ksoy+SxkgHBTiaoDf40NxtI4Epm3jcjhB4ZYtkim40nZr2
	 Z0mX7th0qJDTjaEaLT0SzAP9py0JH5ZlxnD/JBxHk/HxtBukEh+sRcEqij+eaYu2E+
	 b9zLfzQc5GdDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFA380AA62;
	Mon, 20 Jan 2025 18:59:58 +0000 (UTC)
Subject: Re: [GIT PULL] pid namespace
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118-kernel-pid-ae69412addff@brauner>
References: <20250118-kernel-pid-ae69412addff@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118-kernel-pid-ae69412addff@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.14-rc1.pid
X-PR-Tracked-Commit-Id: c625aa276319f51e307ca10401baac4628bb25c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a89a6924b581884b1b54bcd3ea790b3668be2e0
Message-Id: <173739959681.3620259.215833916054401845.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 18:59:56 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 14:04:59 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.14-rc1.pid

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a89a6924b581884b1b54bcd3ea790b3668be2e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

