Return-Path: <linux-fsdevel+bounces-7751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DE182A273
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 21:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983DCB24BA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71C551C5B;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2B2CsUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B851038;
	Wed, 10 Jan 2024 20:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2E00C433A6;
	Wed, 10 Jan 2024 20:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919125;
	bh=SHf8q/0G+dg30/5iJvAdhFvGmKZrdwqr1RyWDcKi7Dg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q2B2CsUipdliRBNqHWs/zITBBItBPXmCp1BsWRlcu4K6bVPTnJ2PyeHXsp7QImapd
	 QER2gC5zxEjY58gMejHs0Jx56P9ljYeyw+Wb/xX334eeZcPbFyCdiZU+A+3tu/2A+H
	 R+dJp7tTewr+t6U5N2qr04fr6U4Us5TvVSi0UsOcqb3o9j2ji+b6SHs0mtEepa1JI9
	 m+Jd1c3/xaCHkMsm6GvRiaTyI+dgWZYoVhKSbJEjFvgGHVNWh8AsXuao46E7DR4P3g
	 6syE1kLxpjuUWjLOMxRVSTJRKE0yINi726NdeQuQqfnCMlBUzOTMAWgsV3KaGpDr1y
	 LVQi2+fDjVLEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF541D8C96F;
	Wed, 10 Jan 2024 20:38:44 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Improve probe handling, server rotation and RO volume callback handling
From: pr-tracker-bot@kernel.org
In-Reply-To: <1303899.1704471815@warthog.procyon.org.uk>
References: <1303899.1704471815@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1303899.1704471815@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fix-rotation-20240105
X-PR-Tracked-Commit-Id: abcbd3bfbbfe97a8912d0c929d4aa18f50d9bc52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c59ae1290741854b6cf597ef05bfa9bc811389f
Message-Id: <170491912490.22036.3595324183123140817.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:44 +0000
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>, Jeffrey Altman <jaltman@auristor.com>, Oleg Nesterov <oleg@redhat.com>, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Jan 2024 16:23:35 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fix-rotation-20240105

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c59ae1290741854b6cf597ef05bfa9bc811389f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

