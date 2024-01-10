Return-Path: <linux-fsdevel+bounces-7750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E2482A26F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 21:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2D51F2393E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 20:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050235025E;
	Wed, 10 Jan 2024 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uapCWLku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4094F603;
	Wed, 10 Jan 2024 20:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 341DEC433C7;
	Wed, 10 Jan 2024 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704919122;
	bh=VoBIQapusZ4NUreEbntc7ZhvKgj4PwK6SluWX86qojE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uapCWLkuRiRIyJGZsklMx2/2UUGdGsMtU2ypjC3vDi6dvXJasgC8G8bKPaF5qVXAM
	 uTRiFw7jFYoyg6fLfvbVCiH6i3L2CuXpNAopX/euGweA15sfiW+pDfzVGOa+tjivuQ
	 ErOb7d99SL39QlL/xNUyy+8zeJENVXiLkAYYLVYHZJqFghL0WG5lQSYIB/V6YTolvd
	 bZejodSaIgdAcgkJpTKlEZ8PTpbE06ZfX0taBUuOco2z7P0YHOGfB/pPswmQOlHDRd
	 iTwAmZLE1mBgXmE/5Xn+m9T4AF7x4ZtyzwxnCUIZ6I7rvVfZt9Gn1O1BSjhwdqPcp7
	 yqHQn8WaL1Spw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19644D8C96F;
	Wed, 10 Jan 2024 20:38:42 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240108224811.GA94550@sol.localdomain>
References: <20240108224811.GA94550@sol.localdomain>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240108224811.GA94550@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 2a0e85719892a1d63f8f287563e2c1778a77879e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17b9e388c619ea4f1eae97833cdcadfbfe041650
Message-Id: <170491912209.22036.13299280209691198905.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 20:38:42 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 14:48:11 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17b9e388c619ea4f1eae97833cdcadfbfe041650

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

