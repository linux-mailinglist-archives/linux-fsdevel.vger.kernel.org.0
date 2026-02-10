Return-Path: <linux-fsdevel+bounces-76793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLcOB52BimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:53:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5241115C7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C29F3028373
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3474E32B99C;
	Tue, 10 Feb 2026 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUpdafdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B332AACF;
	Tue, 10 Feb 2026 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684633; cv=none; b=nbCouSV+wacZeDi6PTMGGgo9GdEtN7yUgfptfbClbKNyWYQNSGUl2XJsXIl3OVXKTR0fkZclwvYFcS5+FlaEtf9/PrJ5VnXdmzfYxKNmxEXCfBDcNA4qNfLy3Ko+nphVHvY8jrJ19oiQreDJ98BJBIplNdJu/YfFYds4LqYNKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684633; c=relaxed/simple;
	bh=niI0AYg0aeJzaB0gep1jtrmKKspuNQV3tI47uMRl6ik=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qDd+lgLqe+9VAel8NQxBUmLdAbAQAKun1kZUlar2YdFzVa97y0baXqx4cD6to64MBH2ku5ChPpPjhYklX3RVfVo3Q6oNQ5N98YUbYawj0QKokT+q2DVIEgIUtIG/rIAOj49Q1YcaRZvNP0RkmuZ30wWTNyio7+GIH9HV1H986ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUpdafdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2A2C19425;
	Tue, 10 Feb 2026 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684633;
	bh=niI0AYg0aeJzaB0gep1jtrmKKspuNQV3tI47uMRl6ik=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eUpdafdpqYkHQ5OhLYLvfRtDPN/0rUnl5wIhNSEuonRRcM9M1cW1r5NF8wdpIs2EY
	 ljBuavlW5u5YSlkQY1qJz+KbE/9p2cUepBREX1ugaw/ZHY98OCpWt4pXn8KqCQwTn6
	 sODOeo55cpD2PlUxXqPNudcyhCQD1odhdify9qA/r65kbMS9Lvhvff5IETm7mNJEcD
	 gs0W4rq9svmtb7uawm+a9qLdis7MfNe2UFZppNOU8TXTI0urTMHSpEsANHtPQ3F0oO
	 ungi20CeBAArDwIQpYr5cMyFUmMn+0fby23kllF2dHXhltHqoL1ppkPwN978YQtSv6
	 0qgoMNZSoHZxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 94B7B380AA4B;
	Tue, 10 Feb 2026 00:50:30 +0000 (UTC)
Subject: Re: [GIT PULL 11/12 for v7.0] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-iomap-v70-71e0b356ce5c@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-iomap-v70-71e0b356ce5c@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-iomap-v70-71e0b356ce5c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.iomap
X-PR-Tracked-Commit-Id: aa35dd5cbc060bc3e28ad22b1d76eefa3f024030
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3304b3fedddfb1357c7f9e25526b5a7899ee1f13
Message-Id: <177068462954.3270491.4481700973028461252.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:29 +0000
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76793-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5241115C7E
X-Rspamd-Action: no action

The pull request you sent on Fri,  6 Feb 2026 17:50:07 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3304b3fedddfb1357c7f9e25526b5a7899ee1f13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

