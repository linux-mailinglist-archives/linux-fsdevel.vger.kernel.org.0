Return-Path: <linux-fsdevel+bounces-76502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHafBx4phWkk9QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 00:34:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B3FF85D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 00:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2134300EFB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 23:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09BF33C536;
	Thu,  5 Feb 2026 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvdj/m7r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5533B6C4
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770334489; cv=none; b=hBvc9GTotBjPPJWIyvkr3eaKqCyT5Q9iDZ9vWYApc9CEgSKD4VzY0+qFWSgq+2cr1K2cpKV6pGFprd8fbVw3XTDKo+6zBtdtwtsooNNVdxi1iwAYqkSUK6pKPc9aNB+ppmrPGlzcNzEaD5GK3MiuQGWe7jGHIRG9EMS7aZILO/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770334489; c=relaxed/simple;
	bh=D6BWpgFwk9MKVgjRM2UJuBbXHagFe08SXtKvvAS3/0U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LNdck3mo28n29STILudjAEIg8+R9fNNisHoAA2CLsekZAaqEzg/H1K0KpQTOBS/gPT1Tc88Tcx7T2sU9Q7B1LI1ezu6IJCoFjztudyA5wy6TZbgvUHhsVay+MmtD8uy4zPx+BCuU4aNsSA+v3Jy1PIlbXILQ/DUHpsmL9Pvx0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvdj/m7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4952C4CEF7;
	Thu,  5 Feb 2026 23:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770334488;
	bh=D6BWpgFwk9MKVgjRM2UJuBbXHagFe08SXtKvvAS3/0U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rvdj/m7rGDsyc6x6ZQiC1OkcpVctynsnKJ66usd7GQ+dBzAvjkF06MJfENvXClMWN
	 1g6ck+ZPR/M4bqwwIu1Si4UxQIFlF4jAxAKxA6dnLIqnhmFpcfcmuyUa0WwDnB5d5b
	 0fySacARGtwRiaRILGlRnJWuXPUaZ+WVwunX+RPuvynz8d9SVnvPMd+PoS7FVWCv/M
	 vNEqj40yHy6sb7XcNoyMVR4wOUReOgyOOOwjsJBDudpkv6qb5BrGjx5gAl0XqG1l/R
	 o3/gIlcynjOqtznFk13MLJBO4psxTG/RKhefITKF6eE1o26eKMIf0lORsLQA46ld9+
	 Cgr3gDPrW2pxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C231B3808200;
	Thu,  5 Feb 2026 23:34:47 +0000 (UTC)
Subject: Re: [git pull] tree-in-dcache regression fixes (rust_binderfs and
 functionfs)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260205185915.GS3183987@ZenIV>
References: <20260205185915.GS3183987@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260205185915.GS3183987@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 2005aabe94eaab8608879d98afb901bc99bc3a31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49233c41cf8546b94d213a5dd877ef07e61b1f3f
Message-Id: <177033448651.607944.11307485102298460822.pr-tracker-bot@kernel.org>
Date: Thu, 05 Feb 2026 23:34:46 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76502-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org]
X-Rspamd-Queue-Id: 82B3FF85D4
X-Rspamd-Action: no action

The pull request you sent on Thu, 5 Feb 2026 18:59:15 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49233c41cf8546b94d213a5dd877ef07e61b1f3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

