Return-Path: <linux-fsdevel+bounces-76785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DmzD6qBimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:54:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C0C115C87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AC66308EBF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273022E093A;
	Tue, 10 Feb 2026 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4xjWRs8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9952DC76F;
	Tue, 10 Feb 2026 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684624; cv=none; b=SxLI1kFOKC5XvIFgsVL/USAYQU4XDj3UNXT/yKsNw5z3qp45EGPLTD2A26tovMhrktL+b7B9a4/w7+s7vHkoNTAKzG/5k7rWMOe1NorEfQ9UsOCY6nZas6yfFms09nAC4syYdju6230hT/qlNqELUkvxnwEANH/Wher7YbgkMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684624; c=relaxed/simple;
	bh=yFc5toQBSMEwbOutn1PC+Bb9ysBpsIeNdh+S1+I9Hq8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Hb1pFPWe8R5ntIi/BnSQYbPNTcKyxV8zhqhfReoRfcr8IHVZTl2fP/KGTzvrC0WY/JqTSpeJqdohhfqJA3GZcOV47Jfn4c9W81/rJV+WTZZYzhcO8K1T7uwecDfRZdQbFdiiFBmYMxEg9SZl/hfoLCZZrA2cvtXGybpzMSEQxqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4xjWRs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AC5C2BCB0;
	Tue, 10 Feb 2026 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684624;
	bh=yFc5toQBSMEwbOutn1PC+Bb9ysBpsIeNdh+S1+I9Hq8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c4xjWRs81gehCnCXqWdoXyb36cAGnWRBSRGoV/RLQKrRGC/NGdprL3H5cGKYwgWME
	 PHOoEAYM3C54GXSfLGLqAxq5w3mwj/9xSfs3nV04SmMuMGqeP7TqUo3p6YyT2zikZ7
	 UJBmgATpVN9oIY535fJM3a2csQI3W29wqbhHYxqqvrrYq+JhOG3dsEnjGf7aE82PSk
	 a8Nz5I3lQtV8nSZlGJMdzOulF9LvtNBdkdB7V61mHNAN4gsMgAk1kSSm4BzTsvR0Do
	 Gunue9r2jZtVi06u+MLwx57iB9dLnAETGaTnckGTeY51XGww/OirHQwF5UOe3i+jXD
	 ryVxZDwTMeMxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7462F380AA4C;
	Tue, 10 Feb 2026 00:50:21 +0000 (UTC)
Subject: Re: [GIT PULL 03/12 for v7.0] vfs nonblocking_timestamps
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-nonblocking_timestamps-v70-59f22fca9b3a@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-nonblocking_timestamps-v70-59f22fca9b3a@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-nonblocking_timestamps-v70-59f22fca9b3a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.nonblocking_timestamps
X-PR-Tracked-Commit-Id: 77ef2c3ff5916d358c436911ca6a961060709f04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74554251dfc9374ebf1a9dfc54d6745d56bb9265
Message-Id: <177068462042.3270491.4119627027000738477.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:20 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76785-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6C0C115C87
X-Rspamd-Action: no action

The pull request you sent on Fri,  6 Feb 2026 17:49:59 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.nonblocking_timestamps

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74554251dfc9374ebf1a9dfc54d6745d56bb9265

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

