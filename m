Return-Path: <linux-fsdevel+bounces-76804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHGRBrCbimmDMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 03:45:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7927C11664E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 03:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96B1B3038F48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 02:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCFF2E0914;
	Tue, 10 Feb 2026 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUbfboBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D12DC339
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 02:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770691403; cv=none; b=KHSKBloh7MyGGzILAMSUMxrGvq4v8ICU2RyVWf3HsBkYksm9uDX2sZUFazLBiQRfNxYsxxZ5PNmy9lgCez98YCVQ+WL8UxowQlr5bKbxgpbF6aa4FWaa8uNJo0ToqGjx917lg3gH5jQCWoktMCxzS/v0iSaUNtwBNWjVPxMRs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770691403; c=relaxed/simple;
	bh=brVPKgqsbCjEgUuxuDRSEBSdvRr84WB0YS7lhblefRk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Jvb9FLSHSG4VyM26p28E7XFrxhU773/4Vj6MfqNZiQCBUqGffTXtVzjGAkPNnWYG1k2kX//WrSygjXD7HYhdhHNW1oaBeZ/6WIuad5cqcl5XaOZDiN42R/KJxztqYxOLB45Q/jNzAefQdfMLdyEIBpcubJ/DwLGbUs7dXj7jazU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUbfboBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B84C116C6;
	Tue, 10 Feb 2026 02:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770691402;
	bh=brVPKgqsbCjEgUuxuDRSEBSdvRr84WB0YS7lhblefRk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dUbfboByW2OpXgTGQf6JBUFMYYinUq14Pp0WpbA/IGzffhdY5nUksVE013cKVeaJt
	 4j1hHlqYd4c932yG5fokS2uGmmaHROipxciSdEjYgWzMmGiWNasjuuImJg9FKDyP3L
	 Z6wfecTJbbubTJr7bhyDqyYOh4PYbxM+eUgzfvL2ZWY9hsJtEHSJwfzYOgqbFZwtxD
	 fXDcbfzc6WLTRNj33M0xjJTGzpIsaw7NtTrMnVyPW9fF/rlWoyEmPbLRVbL6hLRM8w
	 7S/xF0fejGF6KLDx5CPr0t7bEMRZ76Kbx0sht+l1Ancf+3FgqmdaOyN4Lu0EWXxXFS
	 oQFtLLC5mqhEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8549E380AA4F;
	Tue, 10 Feb 2026 02:43:19 +0000 (UTC)
Subject: Re: [git pull] struct filename series
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260209040518.GH3183987@ZenIV>
References: <20260209040518.GH3183987@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260209040518.GH3183987@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-filename
X-PR-Tracked-Commit-Id: 0787a93baa1aab9fd0cb8500105d11d3d3a58f7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26c9342bb761e463774a64fb6210b4f95f5bc035
Message-Id: <177069139809.3309876.1310561944271268926.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 02:43:18 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76804-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7927C11664E
X-Rspamd-Action: no action

The pull request you sent on Mon, 9 Feb 2026 04:05:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-filename

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26c9342bb761e463774a64fb6210b4f95f5bc035

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

