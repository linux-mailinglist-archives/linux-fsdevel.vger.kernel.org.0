Return-Path: <linux-fsdevel+bounces-77319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MxULCWWk2kd6wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 23:11:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D66A147DCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 23:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6179F30160D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 22:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951212D5C95;
	Mon, 16 Feb 2026 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbpCd0MU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D82820AC;
	Mon, 16 Feb 2026 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771279906; cv=none; b=Dr2Ie93fId/aBEENMAXozXmJLxgmD6oXyWRUlins4DsRRsAhGL3MZSPlcY1G+mc0YcUV3ym+q9UAmr36kNksGdjb2VIP/3BoHSIvpdNep9O636PZfRJFFhGGALAt3siVmxsODym8F8kZVs1LTLVkuBcFZPQB7YjnBAlR1m+l4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771279906; c=relaxed/simple;
	bh=Qsdxj8Nz3F22sRGXzAEwUyvtYrOh4tTtkloV+mLB7Ec=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r89H9t+JvqDhXGCpWuKCzmt+n8WcEY2J4DmtH+IguMy7kSE7rd4z9+x7gc8XI4n1XYwls0bsuIx9bAJO+UnskvRvQCPtREt5iHPyrZUo2NifvpSR2EIom9JvhpzSUAjUPsV6lSl8QGRxxMgXWNU/bYTR4Cf8qFVg9a23FVBUKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbpCd0MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF3FC116C6;
	Mon, 16 Feb 2026 22:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771279905;
	bh=Qsdxj8Nz3F22sRGXzAEwUyvtYrOh4tTtkloV+mLB7Ec=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nbpCd0MUd4fB/4vsyhAQ9/iExroi4dMjfMKm9LyDyIPENMA5zz+zERSTbaF6B29X1
	 90ujg+xB9+O8RQvmOKB5Idanh9sdOPsIJppPHazmb94moKy0CN8v9RihkicuJnQ55p
	 +GksWfSMuWAKgl/6ObgzKM6ooV1vPF8pYqvkspVFKGqTvJUJLxLOODueG2kjq0Q8an
	 1HpmmvU9TtmYX1pPxLY3M+TLeIhwTLrMCJd/t86wnhYIPuRvN4TyN8CWyy0DILVOv7
	 T4f6Si5nkt3kpkIVwrLA3eRLF28smGPf6Oq3oU2/FjTifwCzumpkk+K1ONDCjZaPsG
	 q1SJ2W0scac4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4842539308C1;
	Mon, 16 Feb 2026 22:11:39 +0000 (UTC)
Subject: Re: [GIT PULL 13/12 for v7.0] kernel misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260216-kernel-misc-v70-899e4272dc4d@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260216-kernel-misc-v70-899e4272dc4d@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260216-kernel-misc-v70-899e4272dc4d@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.0-rc1.misc
X-PR-Tracked-Commit-Id: 3673dd3c7dc1f37baf0448164d323d7c7a44d1da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 543b9b63394ee67ecf5298fe42cbe65b21a16eac
Message-Id: <177127989790.4020762.5901747332520844290.pr-tracker-bot@kernel.org>
Date: Mon, 16 Feb 2026 22:11:37 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77319-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D66A147DCA
X-Rspamd-Action: no action

The pull request you sent on Mon, 16 Feb 2026 13:29:20 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.0-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/543b9b63394ee67ecf5298fe42cbe65b21a16eac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

