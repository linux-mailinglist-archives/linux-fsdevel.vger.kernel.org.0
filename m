Return-Path: <linux-fsdevel+bounces-77476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLgcFvj+lGlOJwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:51:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C861315204E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33B7D305CD2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DB837B3F3;
	Tue, 17 Feb 2026 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTwADrEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84237AA91;
	Tue, 17 Feb 2026 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372252; cv=none; b=gccWRhxiaFDNIXO6eziO0PRkgJMxkNBNQ0mEBnz6MIM8Oj7FjFEy9axglPgiOnx3aayPHYCI5SLljCXvGCZPl6CYpi4NgJyNAj19ezM2qKyfj8TSZWtVHfHKcPmm5lPwrtycdkED/O4E9KfzcN6PmlCTFMW9UHLDPZsarQIQ3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372252; c=relaxed/simple;
	bh=OTgdjwplI4181Uh8AbS8iZznUuqozMfvOhXmGC0MR9s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zu7mcS3WksVTdGKuJSVjpFpfZz2s6H3wpMCAMqPFweYkm7Kkuf3nNsljso7Il1Xd5Xh0VORYziXXIX8k0TgFnxa48pz7Jue9PBuOS7UcNQG7svGjA4iNHg0IM86OE1hnnpqDvUrHo8qqrRmMJw18sgdyHFToMhPv6BeHLvFg88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTwADrEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186A7C19423;
	Tue, 17 Feb 2026 23:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771372252;
	bh=OTgdjwplI4181Uh8AbS8iZznUuqozMfvOhXmGC0MR9s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fTwADrEvSJZ8CVPjTqiSTWUObzg+E7YQrTO73/CgEX6czP+CRJ9fV3DRHYkgu2uex
	 1ewPIl9GPK2aeDVuLal+pSrZNsz9P59HkPvzA25Iuebc8uHsdduGM+e59iRAkEnGTO
	 rhZmNYF/a2L6vAOkyO0kXjaHn3o7rA44z1pLVqP5alDegvj9Z0Ia+snftM8PraiRsb
	 ZygU1wd4PsLJ/NBQPLqTZruXBrBP90qgz2th6qTSSqln2BRNovP2DFXdoxgdzgCyBG
	 HLOh7Gl0GT7Cm9Xsyv9ExXIv3JULBVlm/E1WTHKyTz4bjcoiRi7wQImNl8mQ+eBBBX
	 fX8WGQulhdP9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 17E85380AAF9;
	Tue, 17 Feb 2026 23:50:45 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs updates for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260217132524.681374-1-amir73il@gmail.com>
References: <20260217132524.681374-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260217132524.681374-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-7.0
X-PR-Tracked-Commit-Id: 869056dbbd636f8f256b695f39c102eb3ce2edd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ba83f0968f34543e57d4a4eddc0a9d0c8c88627
Message-Id: <177137224399.738845.14101605026061458596.pr-tracker-bot@kernel.org>
Date: Tue, 17 Feb 2026 23:50:43 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-77476-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C861315204E
X-Rspamd-Action: no action

The pull request you sent on Tue, 17 Feb 2026 15:25:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ba83f0968f34543e57d4a4eddc0a9d0c8c88627

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

