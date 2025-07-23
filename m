Return-Path: <linux-fsdevel+bounces-55882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD0B0F7B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED085843F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68471922F6;
	Wed, 23 Jul 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3jTmzOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1849659
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286486; cv=none; b=AG68SajOMakoZnPHBGoXvVoCpgx8gen/LRSoKcZvwkUbI/gmueb8PFlcHpPId2O/ZLrysx0/BzJGTkogKVxUqO3XPBPU3BXqJ32BX3TD7IiAaGiBhRi1RbxINz3Ejle2RurlSuc/z5xRmHLQQxgL8H/fY4xPCGoLlC/MRtZkZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286486; c=relaxed/simple;
	bh=rXOfqnG75Nqip+zeb+C4YUb4tlROvGXJpo4QBnkXDOc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q5htHDcXPyenu8XAeeb2Z1VapMXQ3MKOVlYT7PDuHmfy66a+vtDSjccFQkuvg+vXK5GdGFDIn/5btVP3vclKUYGAz0rJHH4a9nR0c1RyI1cerIWJaK/XgxKIgf23rEkvicMFnrNHFWEjFt+4QHlUqKiPNkomGhsMfg/lnu8PooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3jTmzOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF764C4CEEF;
	Wed, 23 Jul 2025 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753286485;
	bh=rXOfqnG75Nqip+zeb+C4YUb4tlROvGXJpo4QBnkXDOc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A3jTmzOp1g1gJFOd0VIb76ADSnz68ljdwTdZuPHR3eF/GuqOFswYk6cMohq5nRzIL
	 SrN9cTlqPci8JL7HEyQHs7ZvV5wcIy2+YaSOnUHYf99tYa8dtC+mG6sGz2LQ4IY3Pj
	 tYYl52y5YwJp8D9dtqAlWfzXrhcrOddZfqKD5isKKcI4vRzo2N30EUOeiIesxgMKDD
	 ATAgoPoQhcdXOUJCKSKpGqRijp893JlUvNnM6sQ8dK9cb50G6xVUQmXrXLUX+GkoQO
	 7gEkS+K15dU1VU9+TLv0sFJjKHKnaboAxYP0MCkycEUWbFDYx0K1CiNtLJ/cA4FpYb
	 LflFOfqJ2Iq4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D82383BF4E;
	Wed, 23 Jul 2025 16:01:45 +0000 (UTC)
Subject: Re: [git pull] ufs regression fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250723154829.GP2580412@ZenIV>
References: <20250723154829.GP2580412@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250723154829.GP2580412@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ufs-fix
X-PR-Tracked-Commit-Id: e09a335a819133c0a9d6799adcf6d51837a7da2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01a412d06bc5786eb4e44a6c8f0f4659bd4c9864
Message-Id: <175328650378.1670556.9492035098381568593.pr-tracker-bot@kernel.org>
Date: Wed, 23 Jul 2025 16:01:43 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 23 Jul 2025 16:48:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ufs-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01a412d06bc5786eb4e44a6c8f0f4659bd4c9864

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

