Return-Path: <linux-fsdevel+bounces-77047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C76JbcmjmlrAAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:15:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5DA1309C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72F3B312D162
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C42D8372;
	Thu, 12 Feb 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOjCAWIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0127A92D;
	Thu, 12 Feb 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923617; cv=none; b=PQq9IyDvkhdPPbzcHrvUXWJc6QKcn5fsZ5jUe89vzosNr5oeFGrZHftN9LqdhbtwtfbL2Tso5A8sZEf7vgGvvhNp+mWDKmmvb77h40GSxKgmoB4WwJQaEcG7VP3CLOY8IOK+R6iwU11z0MIDXwxSE2APJI3kfRLKMdBxEctGID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923617; c=relaxed/simple;
	bh=KE7WXoqaHK0pd8xHApriiUxk5ihPrBnhvc/Ue8P7944=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zi0MXQTtGQ7xieeH8MsIbGYykLkxf5m1zIRfTcqWCe+TPOG1XK97D8SLEiY/cDdlFhkcQI9t9pXuC5HxWWzNiWuoyL1VfFbiwtfgn7IpVjkXGu2YJi82jB71Rxqee9M3pQ+4mGuqwTPVcPcWG5GwdYUF/zwo5SBVFVI0m7IjxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOjCAWIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DBEC4CEF7;
	Thu, 12 Feb 2026 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770923617;
	bh=KE7WXoqaHK0pd8xHApriiUxk5ihPrBnhvc/Ue8P7944=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JOjCAWIvw5RTi7LBcEc5cmb66qO0083PDYfMbBEkd2bfs3PZxs9Bxd4NqFezJFdC6
	 yaErujmvDgHyrAooB0QpwQNnLUcIKKx5p7N1AG5RCwzBuq9U1eaA7Y7+RVOY+7Sx2n
	 uPswMpSoc1HKiB4C5/1wOH3FZ259sUIa2Ar7upUA64LIz5ivT5Iz6Ma3efOw/im/tu
	 qgRM8SrQARK09+ZvuRmrAVYC9CaF6FBAHcBfHRtrQGGf7Fg51sMhn+2jvZSfnmvCBk
	 +HA17ETv4fuSSRGt1dpIMESC/f8H2yBRz+JJYLVhafGDm+mh2K+q7RroH3a3zdpJmM
	 l9Jw/cizAstWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851713800346;
	Thu, 12 Feb 2026 19:13:32 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] fsverity updates for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260212012652.GA8885@sol>
References: <20260212012652.GA8885@sol>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <20260212012652.GA8885@sol>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 433fbcac9ebe491b518b21c7305fba9a748c7d2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 997f9640c9238b991b6c8abf5420b37bbba5d867
Message-Id: <177092361114.1663336.16040403932894140877.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 19:13:31 +0000
To: Eric Biggers via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, fsverity@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@redhat.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77047-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD5DA1309C9
X-Rspamd-Action: no action

The pull request you sent on Wed, 11 Feb 2026 17:26:52 -0800:

> git://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/997f9640c9238b991b6c8abf5420b37bbba5d867

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

