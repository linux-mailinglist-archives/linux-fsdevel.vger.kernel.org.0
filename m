Return-Path: <linux-fsdevel+bounces-76792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LWFL06CimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:56:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA3115D1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2437530A92F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34432936F;
	Tue, 10 Feb 2026 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqkDOSB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED5322C66;
	Tue, 10 Feb 2026 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684632; cv=none; b=IPA7wusipLDbRCR2fSszyUOMb/4hkYQASFIv9NSmiRHI7mphyDHfwWqwu5UuioU4LiwLXcNs/pXIBHgLFSEGJJUxFkmwRZk7n8dJpQYZ83Diw+nXGt+ugEoR11mDj56JGs/7WiKZHxzZvnS9V+fHGaN/NS5QaquFUiFw7L2uzj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684632; c=relaxed/simple;
	bh=8fECPqGtv1+rm0Ub4nDz87OUglssOuDcJSLpklk17Wk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bnc5GpHc0b6yHuyk4PB/jT+GFau+umXPoCDbsfZUiFgJmQR56sRdqKgA4RBBJ1sCDTdLIHHFCKJmeOodiPS7g2Ki6kpFH3Kw91dDrbs8P9sYvO97DOuka8cavbLC7dTZk453NJGc7MRtiCRo7kL0bFuXS1A0U3wVN/1U59jkeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqkDOSB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83660C19422;
	Tue, 10 Feb 2026 00:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684632;
	bh=8fECPqGtv1+rm0Ub4nDz87OUglssOuDcJSLpklk17Wk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IqkDOSB4vmVJYe3FWG/wBCRR0c5WKC6RWxURsx1tIzGFYL3oyq+SSjd98eVgYvk0V
	 DZkLdN06hdq9dQL9egMUUg1fjv01C6d3GbpO/UyTmj1cQa58sKMHy2CqWw9qYd5Y6c
	 1MfYehl0uQC9lMo3A4pJH0sv9i2Tp2JiP2+nPrSvwVJ6BJCnBtGC2ZRWbRTQj7rTwP
	 bemJu4nKC3rQQ5Se7GwutKmA1fZnMTD4FAKCetqWxd+f3QqiZ357UBg5mYV8xLVqSo
	 5RLXtuawnHy3iAhlzelbciF9r5+eCMFW3sLEMC8iqrtsN9I04ghVEGKta72YC3QDl2
	 v/pUuEXAWJq+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786BA380AA4B;
	Tue, 10 Feb 2026 00:50:29 +0000 (UTC)
Subject: Re: [GIT PULL 10/12 for v7.0] vfs namespace
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-namespace-v70-f8476aa664c3@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-namespace-v70-f8476aa664c3@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-namespace-v70-f8476aa664c3@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.namespace
X-PR-Tracked-Commit-Id: 1bce1a664ac25d37a327c433a01bc347f0a81bd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 157d3d6efd5a58466d90be3a134f9667486fe6f9
Message-Id: <177068462840.3270491.1405573734512702562.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:28 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76792-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26BA3115D1B
X-Rspamd-Action: no action

The pull request you sent on Fri,  6 Feb 2026 17:50:06 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.namespace

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/157d3d6efd5a58466d90be3a134f9667486fe6f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

