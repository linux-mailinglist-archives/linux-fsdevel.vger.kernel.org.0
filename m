Return-Path: <linux-fsdevel+bounces-56212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAC7B144F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BD87AF237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3660288C84;
	Mon, 28 Jul 2025 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDnF8n5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4E288C27
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746049; cv=none; b=I8YhdE7cote/a47GRWj6aA81oXZxCDrUZUYt41iSkuT2nPJyQU0YbwsEschjDuhQE+M3FOxkLujRYfo1tqwZ9LBQVyVyX0Uu6Arqgy+rD0klOOgC//OXUa2PFvaDln7iopVLDMZ5tt91kbXfd0nbGkfIOBOPRSbT7LeW/xRuKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746049; c=relaxed/simple;
	bh=Wo2aLZKzCZBA/7LG+ijEWmx2BVps7Qo9Qe1oeNRyaoM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=acOoiOu5w4yMWC4F94AflH6MpsxNFVkpnBWvJDgnO5EBdkdrmPwXeyMCYXmgeDEk/yGw07zFAPBwf4vu4yxuhB9j0XnDOVq70SYp2cowpNY8IWU7SFz+ZmiznzzwHg9BW5uOubYYsUx5rdampWUsOMhzhIRYiOgsMfUkuWdzIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDnF8n5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C0AC4CEF6;
	Mon, 28 Jul 2025 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746048;
	bh=Wo2aLZKzCZBA/7LG+ijEWmx2BVps7Qo9Qe1oeNRyaoM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oDnF8n5rxwxoMnBaCogjID3Ufq8/Yqft2OgXCRO5NC2P1iMXkgXYiFWJ+47Hlv2Bh
	 EHd+Kw/TKlF6hREKLaL4BD6P0V79Vx+VDI+i7jGcKOAoEqKK5lmL24To++pfEVpbpC
	 IhqD5lSSpdQRWumAaNz2c4m+XFQq6dGRC2vYoal+JpXXVon6Wq2ZpDM9UE/u+BR/p2
	 EcV40AId1C8jNaeT4RSgkB0OfA6em+4L1aHyyrS84EXMjT+KyoomIroz0tmxe0z5md
	 QRidmAo5GIqrILO6jMXH4CPAlAoUGVL0HAIivsv4HerffqWyKf6VLnxCr9JRvrRGvd
	 TwSyGLLDzm/LQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE46383BF60;
	Mon, 28 Jul 2025 23:41:06 +0000 (UTC)
Subject: Re: [git pull][6.17] vfs.git 4/9: asm/param.h pile
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250726080422.GC1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV> <20250726080422.GC1456602@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250726080422.GC1456602@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-headers_param
X-PR-Tracked-Commit-Id: 2560014ec150fd41b969ea6bcf8a985ae910eea5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 126e5754e942b1a007246561fc61b745747cedcd
Message-Id: <175374606566.885311.4895038285430709780.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:05 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 09:04:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-headers_param

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/126e5754e942b1a007246561fc61b745747cedcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

