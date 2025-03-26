Return-Path: <linux-fsdevel+bounces-45054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C180A70EB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 03:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C14188D6CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 02:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429BA74BE1;
	Wed, 26 Mar 2025 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwvIgFab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988EA199BC;
	Wed, 26 Mar 2025 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954686; cv=none; b=lDSgguNZM0BZ00TJZDxsOViIPngwmWaazOC9BEqG9YVkGurekgmAYuWGlpNlPNMX/dXsLTGs/52hahOT/Uw9p2y2sZv9ply4z0lTyI4H9OPTAcxwyJsTikPDB9zJOINvCil1frpZZXQjTuhZm4x4JTk7EXAzZi2jQO2rIHaStEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954686; c=relaxed/simple;
	bh=o21Y9pL3ABEdmVau5qRHQOMkjxBbyp3mU16TpWBO/G4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rzgbVDyJ57PbBuAPo2nDYhkfbQgnHUbuQK00jXk/JLafgSL5Fmwzx5WSUJH24O4pTJ4uwjybfguPZ48OWINHRN6V0MdtPD5fINBxUJ2JKB3CHIpQ10Tq+ne/rNqbDPvWWdV6yIOfSOcda/ar5qJFtHOv2CInd9QZjERb2hU8ezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwvIgFab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77370C4CEE4;
	Wed, 26 Mar 2025 02:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742954686;
	bh=o21Y9pL3ABEdmVau5qRHQOMkjxBbyp3mU16TpWBO/G4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NwvIgFablCN0VMLt2I+jkMGL12463Idg+lyEHfukvDx+hhxlwAoQyeJWc8RyLGZEK
	 VN94t5m61khL0Rhxwki5aN8TmfBeN0vLwZM6+0PgW0E8GI7XoJsnwD7PQWplw6fwNb
	 8iyceGnXjihGRLv93YmZGXm73PaPQ5TAWMTpK3pf5Y+UQkaq1dDUu7iaAnh4dUG2Wz
	 GNC6wuebZeo2YUztzWKwfiV+r+AcYsuCQWfZ/aHGwH8yXoPsaRjUSgsf8ATO3L96sm
	 XueoRqsv0xiRmz9EhpyriZxuj/c6LvfB9BcsP7v1N5Ie3Lai31/j/8Th1AKMdmwvLv
	 4O3sc2X/O503w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB49D380DBFD;
	Wed, 26 Mar 2025 02:05:23 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250323221923.GA9584@sol.localdomain>
References: <20250323221923.GA9584@sol.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250323221923.GA9584@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 13dc8eb90067f3aae45269214978e552400d5e28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a86c6d0b2ad12f6ce6560f735f4799cf1f631ab2
Message-Id: <174295472237.808498.16157260834863580812.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 02:05:22 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, David Howells <dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 15:19:23 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a86c6d0b2ad12f6ce6560f735f4799cf1f631ab2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

