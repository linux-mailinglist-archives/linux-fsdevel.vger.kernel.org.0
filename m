Return-Path: <linux-fsdevel+bounces-35129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564169D1941
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F051F210D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9861EBA13;
	Mon, 18 Nov 2024 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3fMP9RK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937B1EB9F7;
	Mon, 18 Nov 2024 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959342; cv=none; b=ILIX82psbIzbvZjiyXcU/zo9jO52xFHtCQd8JXmjd8GKeGKAoLjJjIizvN3I/9AQodFP5psnC8M0hpvLPtj5F3O9mIrTxJV2btfHd8Wutqsg2gkZFZ4IjkOUrbmxjrV5faeHcM8xnXXEdgQ2DaNHl7nOMGRUeMuHYLFEbCv4wIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959342; c=relaxed/simple;
	bh=77/2tKFU1ZgLaV5d7uNgwywCIe48vnfSCn52oCMN/kA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=vEywLPbdU/K569v24Qz4TOevd2pEoUlw5xvBL+zxwGcVBr33wuJ+I4VGa1CLoYTN0AScLYKPu+OsL3YPt7obsvkZnKOJzHHAri/IfnKnoDq6KguOn4ZSReppfOPyKZLmdlkX32bz0krx6ewVIt737BH0AXJmf+f9wiTBFl+fHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3fMP9RK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150D6C4CECC;
	Mon, 18 Nov 2024 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959342;
	bh=77/2tKFU1ZgLaV5d7uNgwywCIe48vnfSCn52oCMN/kA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I3fMP9RK78V5sZPurAVg76Dhfkp/J4VxlQBB4CQpD8e6zi46alfrHReEnHvzGJ6fX
	 MuyxNfYYOUf1MinvLv1U1DM5emXNgVDu3Ivw5t4mGB0ftiLu+GaA0mxDD3lWfI9c8/
	 V+4gLfknxkdDK4/omyGhh/KHmDMXLq9h21jV8Lvk5g6ElTUXhc2obodwd2xvnEH8sS
	 6tY/Y6u0t+DHtaQjlzHwUgIR2n5l7W6rA3iOOhzxCsl6hCaP5prf3mlzwA4X0pHrSD
	 +pQZXojkOPXUIBikQd0lW1RdDTkIT01Ou/g0G71A0WrvspxTpNx6kEoHMMzpk/mIll
	 dj98lMzfwhiMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0A3809A80;
	Mon, 18 Nov 2024 19:49:14 +0000 (UTC)
Subject: Re: [GIT PULL] vfs overlayfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-ovl-7166080bd558@brauner>
References: <20241115-vfs-ovl-7166080bd558@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-ovl-7166080bd558@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.ovl
X-PR-Tracked-Commit-Id: d59dfd625a8bae3bfc527dd61f24750c4f87266c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a29835c9d0ba5365d64b56883692d0e8675fb615
Message-Id: <173195935334.4157972.11803615055124954615.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:13 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:03:18 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.ovl

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a29835c9d0ba5365d64b56883692d0e8675fb615

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

