Return-Path: <linux-fsdevel+bounces-77048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHQbG1QnjmngAAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:17:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B292D130A22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 541933094A13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40328134C;
	Thu, 12 Feb 2026 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq9mmdTu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3E22D4DC
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923663; cv=none; b=k4YW0jVXwfcRp9Lu+s69SPAB2jNQDNQUsL4FjGLdpcLgoMJrx2TvqJde7yaarivgAmySagZQdHuculdTzG+rwLt8VzYzjoN0wmucWGWFUyyxu7RSfDxlWep6jYTucRQr5cn80DeB1swTBCmlS3NDjuT24zQ5fAD6kLe0BGYmJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923663; c=relaxed/simple;
	bh=BxyjoTvD0fVT9aIz7LDUWZZlPYNxj1fLbqrvTD49hxc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MDVIM5hGXzLMgo6xLoNFy2ID7gn+QiZbA2iTgQ5TN9pJiKZcxh/0mpdMsqQMR5PluP7+zCdoPNl/DroN9+8Aw3Ts/0F9zFbzAxFwTH3hND2KB+c6LT2PqGf3g47A6I9Aw+YpP3AKYuLOW1Y1TxShzxdpf4FlmJSg7bczP+oA+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq9mmdTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B403BC4CEF7;
	Thu, 12 Feb 2026 19:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770923663;
	bh=BxyjoTvD0fVT9aIz7LDUWZZlPYNxj1fLbqrvTD49hxc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oq9mmdTuBKWoVkj3A6XQQyFVXUSLF9bYtOmmBTqbasGG/XFjw5ywFMP/cMcdhF2dd
	 a/u+VvfAihJ1zGIKgq94daRR3URo32vxA4WRuEZr+qxCBSs4eT52RV9NuGACldvzJK
	 Qf5prz9nFRvSekdal6nUiKSyJ16dFk9G4BLYezHZLS1IpFkQsuE1xRVt/CI267o9U+
	 eLsXf0oR6zCBs7T3mq6s0JsECkqMM1fiDmslSW+zG5eeCGD/XwektvVcfExUYM2YNj
	 jyUMLJI40fr3MX1tAlYIyKiifBkcjW3p9hoByyqa4sGJ+KhVfdJxgLGbZpobenxSdE
	 Foir672WGw+UA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 481963800346;
	Thu, 12 Feb 2026 19:14:19 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs changes for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSS9BFayavpGQ=MWYR1HoUX=SSQ01JPYTRcJDVXbzsGAUw@mail.gmail.com>
References: <CAOg9mSS9BFayavpGQ=MWYR1HoUX=SSQ01JPYTRcJDVXbzsGAUw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSS9BFayavpGQ=MWYR1HoUX=SSQ01JPYTRcJDVXbzsGAUw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-7.0-ofs1
X-PR-Tracked-Commit-Id: 9e835108a9ae1c37aef52a6f8d53265f474904a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf559d9011140087abf84b34871849ee8e305bca
Message-Id: <177092365794.1663336.9217952458555668914.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 19:14:17 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77048-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B292D130A22
X-Rspamd-Action: no action

The pull request you sent on Tue, 10 Feb 2026 17:41:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-7.0-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf559d9011140087abf84b34871849ee8e305bca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

