Return-Path: <linux-fsdevel+bounces-30903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0398F494
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 18:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C311C2140A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A397C1A7270;
	Thu,  3 Oct 2024 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkTBrPLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8DA1A4F09;
	Thu,  3 Oct 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974397; cv=none; b=FK04Cs346YBiZj8o9lBO5iBh5weHLsZZS1d5An4nPOApYtl+Bb8Rp4LP4y4gRLyFoFyk97Ovx4E5MR8x3FBFAFzaX3h9ieuFVU2PqMTx144iqPW9UROXkxuEwAdnSFl95fqxBICT9hae6vsfyj1ctM3IMQSVQQV/2EzB6Z+kd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974397; c=relaxed/simple;
	bh=mL3pzegPU6Gqv8C9J4wj0ABlhDKjghNY1AW8T7wekhE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PdJf+ArGfOxkkvmrO4eVDQY8WwC42ytGIWlTt8eU6wwzb1B8zqkxz1ovUbGITY8QTaf1uBbcpgKRvKA9jN/RY14Kd+Urgg9DD5sF0fZ7QymGaSUnjK0+xclnpRX/hU+CzWHPO1yLyswXaKQlCytLz7VUa5IDhAadLtv2YNd5s0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkTBrPLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FCDC4CEC5;
	Thu,  3 Oct 2024 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727974396;
	bh=mL3pzegPU6Gqv8C9J4wj0ABlhDKjghNY1AW8T7wekhE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BkTBrPLGYcTNNK86dS724IghAn67i5LBhIl6UItywylW+rcrGWjdiUhqJvTjL8cFZ
	 7fne8UmYKR2do+z2kz/UBZeyE8gbGCgni0k3Ob5WXweuplNCzKl3inBw03Kd8NpEQ4
	 Jx82Brs0g/5fnd/bsglM9XUTg9x1GG1ke6anzUIc1hk4rOBFxMVhe+/m/alA7zfWjm
	 VKxfWIDxadFDlFmFCA/dpddjLhVlgQN9u+SBHJGtcfEmE9P07s6xeztFatmdWgOWbZ
	 FM6aLi7E1ejsJWyd5TdrwVC6Z0MiNVcfBFxyc0kiDjY77E4PdbJa2ibWNyPy23lyqr
	 55dwX+lZRvSqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EFB3803263;
	Thu,  3 Oct 2024 16:53:21 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241003-vfs-fixes-86b826e78b57@brauner>
References: <20241003-vfs-fixes-86b826e78b57@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241003-vfs-fixes-86b826e78b57@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc2.fixes.2
X-PR-Tracked-Commit-Id: a311a08a4237241fb5b9d219d3e33346de6e83e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20c2474fa515ea3ce39b92a37fc5d03cdfc509b8
Message-Id: <172797439984.1922078.2491473248751532400.pr-tracker-bot@kernel.org>
Date: Thu, 03 Oct 2024 16:53:19 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  3 Oct 2024 11:00:20 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12-rc2.fixes.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20c2474fa515ea3ce39b92a37fc5d03cdfc509b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

