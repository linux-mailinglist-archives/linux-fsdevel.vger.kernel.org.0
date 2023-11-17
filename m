Return-Path: <linux-fsdevel+bounces-3110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0271C7EFB93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 23:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329DB1C2099E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FE847766;
	Fri, 17 Nov 2023 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAHGEl6I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05246529;
	Fri, 17 Nov 2023 22:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25AFCC433C7;
	Fri, 17 Nov 2023 22:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700261217;
	bh=LQEZbzImKyMI0l+a5jI9iXbjyONdjfJ5zmCC6p7z77I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nAHGEl6I5q8LirdQQJhDElIDUDCxrUcH0KA/Ja3iyPNCZzEBv6SwU0vnd8oShj9Qy
	 ntlPM68tM2yOBm2cn/hYnhMxoWR572mUS4uR2aE8Nen1ud9JRtqc+kkjuYe8Pt9Tpb
	 m8C+GrCmO7lTPlSOJGJU7KP50S3aRXlSJb1xDkReYYaNETBreAcgoGkRug5DzpMIjX
	 cKyQBkq1NrHSW1PgyOoI+WRl4rQrWaP0orxy6RfXD2r0hvY2z1NZoWONfIFe+pPedL
	 2QH4H5tEfAZG1GoFZkEGdW2pO4+Mqm9aVcoua7ud0exZjxae5H46WdZZzNUj9L7bEN
	 1FdQMhQN55a3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13128EA6300;
	Fri, 17 Nov 2023 22:46:57 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231117223325.no4eqblc5zqte5xg@moria.home.lan>
References: <20231117223325.no4eqblc5zqte5xg@moria.home.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231117223325.no4eqblc5zqte5xg@moria.home.lan>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-17
X-PR-Tracked-Commit-Id: ba276ce5865b5a22ee96c4c5664bfefd9c1bb593
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 791c8ab095f71327899023223940dd52257a4173
Message-Id: <170026121706.14371.7933584278902729663.pr-tracker-bot@kernel.org>
Date: Fri, 17 Nov 2023 22:46:57 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Nov 2023 17:33:25 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/791c8ab095f71327899023223940dd52257a4173

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

