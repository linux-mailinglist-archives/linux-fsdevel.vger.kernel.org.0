Return-Path: <linux-fsdevel+bounces-44915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CECFAA6E50B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC0618900E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC201F63F5;
	Mon, 24 Mar 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MphOwX6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD61F585C;
	Mon, 24 Mar 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850044; cv=none; b=jVdpvvqn0Ml8ChbpgfLlEJevE21u0ARHgqw5q4rDyDjCkXruePAfuS0PqFUnJ02gpqU+9A8PW8XZzglUPQmjbSCj0jz36+To3e60ar8c9suqtteNkij8etLmCIbsrITqt+DTn98j/Jg7T7BMi00bZL9C2dUonMCVLpCc9XjkUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850044; c=relaxed/simple;
	bh=HhQ9OIHsxnqCQyEM0g6MzAoq0ymeQpoVvZKwkCW7hro=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ANoiO35yz/ccDZyOKjzUUtO9EmQ9tlRlLxwMHMa4kmikAetdhMdONhENqfAOgnWibz0Vr4ZIcoPye8MBFVotaHtWi+Yd/YD0dmomMwEjW+HJ/Nm51xpRaxGpr9j15ijtjmq1uLzD55vjA3LIr5suzXJCwm12Wd2D0s8HtcNVHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MphOwX6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364CEC4CEE4;
	Mon, 24 Mar 2025 21:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850044;
	bh=HhQ9OIHsxnqCQyEM0g6MzAoq0ymeQpoVvZKwkCW7hro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MphOwX6ptCA8Ol34TOw04EN75SuRTPC2JyJjosSyX6O6dRIkvfqmlJpm2OnpUah6k
	 jdJYIntDjHNIVAewbxhxJupxJ2u4bp5/tjqif97zbSOAlQ9gHljAKHEm7qeSB999qt
	 dQgxmE9J6Ar4C+I3+QiEzbFA2rrWtFND3CBSbDhwIUtPM+oHWoZz/6Q2KBCeUIyldX
	 LoA5xtK2dM3Y8HbV999iYzDnGMEk8s0Ou3LGIpxLCJn9HS3sVqaz/4TRP6YxzLRHZz
	 2oX2ERVzJyr3akIiILQe8kEytyJNO5FEt/NgTNHqYxbGJMQAjoYd9WnqwIKEbSDK/d
	 tn7vwT4e5pzAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A9970380664F;
	Mon, 24 Mar 2025 21:01:21 +0000 (UTC)
Subject: Re: [GIT PULL] vfs initramfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-initramfs-ebb99cbb53cd@brauner>
References: <20250322-vfs-initramfs-ebb99cbb53cd@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-initramfs-ebb99cbb53cd@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.initramfs
X-PR-Tracked-Commit-Id: 0054b437c0ec5732851e37590c56d920319f58ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1c98301ece230bd874a27c957879fcc16ca1dbb
Message-Id: <174285008054.4171303.8604126120293798341.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:20 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:17:01 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.initramfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1c98301ece230bd874a27c957879fcc16ca1dbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

