Return-Path: <linux-fsdevel+bounces-77874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GI4A+5ym2kizwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 22:19:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB1E17065B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 22:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D9C301494D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E4A35B621;
	Sun, 22 Feb 2026 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap9aAScC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB21D5146;
	Sun, 22 Feb 2026 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771795158; cv=none; b=KFaz+nxb+I7ksaBnZVgRLSy5I+Rt+ksajdxQfdPwSi5Sl7KxceUunzrQJ4FxxAgBeGvgpOJakfhzvvrck25BFs5235/CilyRVUtRTatGwoi3byJitzeJwHV8DWoxteYYOlrzALEbxF36hyP1AMutK8UXvSgOybY/81gl3Ji1JBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771795158; c=relaxed/simple;
	bh=afpqdyAmZQo051wBoQc670asvU5IJJ/hbFwXXRabVII=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tt/GGFgfum0I7XxDOwlh9SCenrauCC+qT6SsROy0ageQ60N/LToP7HQjf5ehipoiiqQF0pF6P7HzjHA0JyL0UDMY3df3Q9PIDJc7oDzAvPQUA4B/Qi7g/z1Q7hndo47H/D4aJ8xs+hPVuk2D04aoQfk5eGQ/Y9xkLNkLeyKHnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap9aAScC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3ADC116D0;
	Sun, 22 Feb 2026 21:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771795158;
	bh=afpqdyAmZQo051wBoQc670asvU5IJJ/hbFwXXRabVII=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ap9aAScCIeD94C8UFbwfKTip4hEM+lLce+5csLYi/S1ny/4nu+ZfcpJMgm0LLSqeU
	 UqEVC4qKeYzuV6vz+pq4lef5yFAjh4ObMhgnxKk/XA4r2kbWpJgCtSKI2GWCvgKMzp
	 IrxSFj4gD9m3B8rbcd2TMsekuyLjTQz1AtOIY7lQ3I989NA93ej8gkIQRxSgQJ+ENO
	 TnDCCQGTpexewaGaDbN0QbXHsxTCCLvnpBEqd3uhR5b3gxBytXlaUbUxW+5ORufZYW
	 4i7MyOq8M1xw4xXUBnxknD38L8JNK5e1hXx9Lu3gTrAnG90DBm9rEpMR9TmiVTMBA/
	 3DrFNsk1kiEKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 402283808200;
	Sun, 22 Feb 2026 21:19:26 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] fsverity fixes for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260222203843.GD37806@quark>
References: <20260222203843.GD37806@quark>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <20260222203843.GD37806@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 693680b9add63dbebb2505a553ff52f8c706c8c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbf33803618ad4f531f78fe15cf328fe6c7f9978
Message-Id: <177179516477.1502390.5255504502545822685.pr-tracker-bot@kernel.org>
Date: Sun, 22 Feb 2026 21:19:24 +0000
To: Eric Biggers via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77874-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AB1E17065B
X-Rspamd-Action: no action

The pull request you sent on Sun, 22 Feb 2026 12:38:43 -0800:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbf33803618ad4f531f78fe15cf328fe6c7f9978

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

