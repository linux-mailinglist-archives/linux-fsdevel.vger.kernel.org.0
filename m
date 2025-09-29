Return-Path: <linux-fsdevel+bounces-63047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03627BAA768
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701027A5B03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275402773C6;
	Mon, 29 Sep 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0Ze4uRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1982609D0;
	Mon, 29 Sep 2025 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174275; cv=none; b=l0VbusGcVwWIzMU9sbTKEb2xOiQa4pP+ZC6qO0JHcjPqyEBrD3UuZczEPzAKzKRmS+qSESiFDEu8eovjEu+6r38VJK32mMT27KTiC07k6R6TAAx1cF0BArRDCj+bDgcvrrD9AJpDrqibsXyGF+3eznXWIwfrLNJKFZQgX32ycu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174275; c=relaxed/simple;
	bh=oNIQAYcvxKAi0PomEzjGHlkbYUX6koXVzu/Yi8KcbrI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OvE2mQGnfKc47G/zigy6xpGPTjibc09WfpKEUdUAyK8fcL9GTsR2o61ZPEOv8dTj/dvXYQt8+aNHL+ehL4Ck2SlA8RbV5xIZRFohQs29OscGwqous6q9isGKb8hr85JusWnmSsCeQwzTa/r4wJPAh029H/1YXbVhr2/l8gHOfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0Ze4uRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F24EC4CEF5;
	Mon, 29 Sep 2025 19:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174275;
	bh=oNIQAYcvxKAi0PomEzjGHlkbYUX6koXVzu/Yi8KcbrI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A0Ze4uRi5nDw9mjcnZ3Q1NxmU9cr+i7UWic6heKgdUzflk7T+7PjLjiOi/fiBUV83
	 lcLGWBz1JXvX4i/cWYKr26zkzYZaxblTNga79t98PVReuSo0xpqn5CfOlEzqqlhXAI
	 rkw9Hkgx7xrPG1H97M7DexLztlzxzaq3BXte7PH8rGyuHyHpMGEkHnblSghaPyO8SZ
	 cKwUjm+WeiwVOIva1CJOpRERpMIS6sEWkz1+VRaBovw5+Ol7Bhn2CuZSzca/fl9pEY
	 AQBBS+gxb2JCLxpyUSiwGN8AvWUCo3ZgpqMVFmN/QgLmwlqQtxZDee+Z6bgzCntRhK
	 rrFxEKu62u+HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F3F39D0C1A;
	Mon, 29 Sep 2025 19:31:10 +0000 (UTC)
Subject: Re: [GIT PULL 04/12 for v6.18] iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-iomap-47b585a955ab@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-iomap-47b585a955ab@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-iomap-47b585a955ab@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.iomap
X-PR-Tracked-Commit-Id: c59c965292f75e39cc4cfefb50d56d4b1900812e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 029a4eb589129450f2735df825f784dd7e8c4c63
Message-Id: <175917426880.1690083.16501708810831084591.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:08 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:18:58 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/029a4eb589129450f2735df825f784dd7e8c4c63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

