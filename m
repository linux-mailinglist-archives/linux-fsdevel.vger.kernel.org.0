Return-Path: <linux-fsdevel+bounces-14153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D687875D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 19:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12FC1F21F77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086B354FB1;
	Mon, 11 Mar 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SILPrcf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142742067;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182028; cv=none; b=VNyzCDhIiheuig6fSpKp/BNw1ls0hQmbQabqWOOp16vCoolb/Ncl81JR20hQyaA8gv2ui9VF8r3l9rG8taaAF+IzF6xEhvaT8DVid0lE4I3X6tXh1MpyCLa1sR+bVQV61YnkR023NJspmViKrcWbI1oW/31eW5g7zHqm1XuOKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182028; c=relaxed/simple;
	bh=H6wrrRtSK7MnPyzO256nR73apioiAiIYAxAxYc2+IJI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YbLo9Dx5DYZofoUbBtwZUvxOVR/4SiYAdnk4IAlXqCB2d+ZJ5ACrQwv4T0xnDW2TLY4/zEprfzxe5jk2++QQBpNO7GxsMWgOHYg0bFqSAAkKcCQUfybuqkegCWFFrF00jOMSTYnNEcGYzbMEPQ5eCupSUNmICF32IwmRVhQ83dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SILPrcf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41CE2C433B2;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182028;
	bh=H6wrrRtSK7MnPyzO256nR73apioiAiIYAxAxYc2+IJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SILPrcf2EWBcMPmqurPCDEfvI99DmthEJ/PKQrwyOqsYvTr9+EMqCL+prbP3lLO02
	 fYArevGNahqlVGV5DftBeYAcV6y5f5Jm3PBVfVFD5px8zXDBePMJu0eG3GPxPBUqR4
	 Q8m6Axs20aEwOG+3r71++6N1C1kzi2INaYQb7lB28YKEyXBaxUWIzr/W9/iwJy9h4a
	 EZVIo5jjLfO14mmMyvsLX5+jOZCm/93/StuVvBRmeG8573xSDF5fkvymafc8PVVYu3
	 gVulwFKlzD4BgyRgbjTG7HVa9qx/A/IGz+JqVxRuA5auY1wKfyDR/kfXupSp7xZAY5
	 Yh6yIoCcDFf2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E5F6D95058;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Subject: Re: [GIT PULL] vfs ntfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240308-vfs-ntfs-ede727d2a142@brauner>
References: <20240308-vfs-ntfs-ede727d2a142@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240308-vfs-ntfs-ede727d2a142@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.ntfs
X-PR-Tracked-Commit-Id: 06b8db3a7dde43cc7c412517c93c85d13a4557f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77417942e49017ff6d0b3d57b8974ab1d63d592c
Message-Id: <171018202818.4685.14317511272565759390.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 18:33:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  8 Mar 2024 11:10:21 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.ntfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77417942e49017ff6d0b3d57b8974ab1d63d592c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

