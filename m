Return-Path: <linux-fsdevel+bounces-76784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCi1AxCBimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:51:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52D115C16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DD1D3014FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDFB274B42;
	Tue, 10 Feb 2026 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAyWwNru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498427FB3A;
	Tue, 10 Feb 2026 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684623; cv=none; b=WgmjTMQP5oNKE9d2T5yhprm3UiQi4UwpJRJS3CqnJwtSQKZXAsf4P4cjv4H0Lbka8wPT8fc3dGvAIttY6TXKQlI1e3PE+dCxDqY05EBC9bjiSK61DuNL90zkC3gLjQXpLa0ATnkJRBZ9xdEkQw5lmRMCIbU9MEzT9DXF6S90FTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684623; c=relaxed/simple;
	bh=g/YTwNmMiw1gSVBD0XdnOTVooXrQgoo3AMtOvVBUoRQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oC6lIVy+zIcIP5Ow2wHWOjjBe/cNz7eKP69U+a7j6fQ2KfboOZOSf/eVacxnkp+q+Z89MkmXwbL3MMeze+abhY8D0Ryhtr+yVpanM7iQHFI10OfKkEC65hhF9mSDPW8thhQiER9mEjzI/irwSd8mjsHkQqrr9sa4hA2S16zVfGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAyWwNru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A9CC2BC87;
	Tue, 10 Feb 2026 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684623;
	bh=g/YTwNmMiw1gSVBD0XdnOTVooXrQgoo3AMtOvVBUoRQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DAyWwNrukzGkpwPqE+z/AWg4BndMJbMllFbhWPjZ8Dm04lQ/U0wsUVtqXOUbWYJph
	 pjpC4R3ZfvOxf8eNQGC9ahytWyfaBUBu/rvO62UbJfQJ/QKxUlx3M90UuqT9ybnevz
	 EjvL6au+eFPlfRSm54gqEH9L+ilSLXnkZVlPjdXcFG32ISuKfS75CaqENRG5PzQu7v
	 IkucL75KRf7b8Rno+uT0WBUFJVHgeEKVPOp7IJLuoJkbUFZr65VJTMlkLEuVqWz9xf
	 Y1wgGNQVupKrmKhxoORtA0jMV3CRDMABidODzdMEjkH8RFw+DWUCmNW6O/1T64MHud
	 5fq1B7yRytfmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5A827380AA4B;
	Tue, 10 Feb 2026 00:50:20 +0000 (UTC)
Subject: Re: [GIT PULL 02/12 for v7.0] vfs initrd
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-initrd-v70-5b2e335bdce0@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-initrd-v70-5b2e335bdce0@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-initrd-v70-5b2e335bdce0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.initrd
X-PR-Tracked-Commit-Id: ef12d0573a7f5e7a495e81d773ae5f3e98230cd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 996812c453cafa042f2e674738dbf8fa495661f3
Message-Id: <177068461927.3270491.5859564286073198478.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:19 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76784-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F52D115C16
X-Rspamd-Action: no action

The pull request you sent on Fri,  6 Feb 2026 17:49:58 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.initrd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/996812c453cafa042f2e674738dbf8fa495661f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

