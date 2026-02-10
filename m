Return-Path: <linux-fsdevel+bounces-76783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO5ZBnWBimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:53:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9D115C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9152F3067B01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32701F1315;
	Tue, 10 Feb 2026 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQpffTr4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD32C3261;
	Tue, 10 Feb 2026 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684622; cv=none; b=b4rtd6003BCcgX/AszB/HXYVy2t/017MQAqFQtzl0LsAUBQ+fnuowP3HvGpFJXvm5XhIiJLlwiHhSgBBG03JRdltD+RM7zKrYbnx8H68b+lqfU9eCS0FxweBQ4lcXUfi2lr4O8Lu1qrNYZ9UoSZzzabTCWJ/eLZYry3CbOf1MF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684622; c=relaxed/simple;
	bh=Yf+TLFhwWkOh7lrpjuWLFqCgjrW296pwf/gNVipbJTs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dmYQ67UCqacWuqBwvF2SJDgOPWyyfbuZNGDH0qc1os+inxa09kZzGERxvhA93T0tioEEt4JMmFVLfXrCE7bU8z7Qvv5W4OzFzzBJRT9rdrG8serU0TqROsa0lae+KJXL1blLR1Nb07OXV8wwTJ8CCGdMdDRWJ+WnPi2ndRtrctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQpffTr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40285C2BCB2;
	Tue, 10 Feb 2026 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684622;
	bh=Yf+TLFhwWkOh7lrpjuWLFqCgjrW296pwf/gNVipbJTs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TQpffTr42weNbhzdrnGKl1Ho+ReolvUsPPbLMHRSJpcTsShvgtUZTRyDtZmqMQXUL
	 jKvnl7nAb3sgFMxzom+fSL67dcASK63xR9+eE8FRj2Z8dq2fzbmiZNjOpVRqTyQn4h
	 tKY0tGNPciXju7sffsBhy0/qJ2icGlantqDDNw03K6QjeL+Q2i4SGD5CIAQ7dimBXs
	 dpHQoFTKcyMNkb+qEAfFSau7NwL+uMrwW48fLa1gHIah1PRqi9ADBtXTQO84Wu+jk6
	 H9Mmoo4TPWXsrAHEF5qZlAxGrAtAPUi9EDh8YhlE/hPMZQOC8aW0FPm+e43zdMzPLU
	 goYUvSFUtuhbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3724C380AA4C;
	Tue, 10 Feb 2026 00:50:19 +0000 (UTC)
Subject: Re: [GIT PULL 01/12 for v7.0] vfs rust
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-rust-v70-e1fb02c09eaa@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-rust-v70-e1fb02c09eaa@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-rust-v70-e1fb02c09eaa@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.rust
X-PR-Tracked-Commit-Id: 5334fc280735dcf5882511a219a99b5759e14870
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b6c6bc6fab51684cc129f91211734f87db6b065
Message-Id: <177068461817.3270491.9364234107621190189.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:18 +0000
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76783-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 90F9D115C59
X-Rspamd-Action: no action

The pull request you sent on Fri,  6 Feb 2026 17:49:57 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.rust

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b6c6bc6fab51684cc129f91211734f87db6b065

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

