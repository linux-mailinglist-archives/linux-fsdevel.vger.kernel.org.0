Return-Path: <linux-fsdevel+bounces-76791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGA1KXaBimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:53:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60694115C60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 713683020EB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111730AACA;
	Tue, 10 Feb 2026 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYeVojU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E331AABA;
	Tue, 10 Feb 2026 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684631; cv=none; b=j9bQVP7ZqztUrVDf5L9nUssA1prH0kQU16y24za+d7K4hVquIeGnhN1Qnldq25RbNTACiXNKDmOvI/cL43NIy+PBHAbkS6N5liS5BbIa1pheN/FoDHgO0Qj4ebhLxsrd/wseETnBKyFXpvyVCplr0nY8IEmC05tDfuufS/bquEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684631; c=relaxed/simple;
	bh=ViwLvSHEyUWo1ff6v8zU0ZhFEIZDPqEkwx0P0XxFEpQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iiVzbxQciXcrGojFXwEUmQbSrcE7eZPLJy75PIAi8fRGcdgjNqEDmHgwubuZRAPYxJ59P40W0/X9syHLJA9l1PdqXq9CQ4aQJLIkf7QjjgnGgqvXddrWSMN77uKSxCTzCeO3QiQWWg46Rl1GcvE9K9T3i7jtRh1AVQTRK3yVEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYeVojU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCFAC19423;
	Tue, 10 Feb 2026 00:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684631;
	bh=ViwLvSHEyUWo1ff6v8zU0ZhFEIZDPqEkwx0P0XxFEpQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZYeVojU6ZpgnA2w38KuXMFLMqWeUWg3xaj54Sv09AlO0rpdGSTkAHZTsx/LU0g0RA
	 VDmzuDTu6ws83HlQZySYCac7sxivVWFcJ5KhFlRgroZx96xrSS2UQeejV8aDlaUKl+
	 OiemC9F71xXzy45dQ+roe0lVIgQRQTEgW4oRbninyyO1VO8cQ66mP7In6zr8jIC8oj
	 B338iVRtI4q35flO94Cbt9rG1KodPm52mMUGSmy12ypTBDaBenSDUGK7V2ZII4iC2U
	 d8whG/R1PkSNousNG8gs+XeF+bWYi+acpp1FUj2rfD/QNT774vHzY8VCAxO8tqoZCv
	 4ldcIWGmuhJJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 553EA380AA4B;
	Tue, 10 Feb 2026 00:50:28 +0000 (UTC)
Subject: Re: [GIT PULL 09/12 for v7.0] vfs atomic_open
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-atomic_open-v70-7297c622297a@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-atomic_open-v70-7297c622297a@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-atomic_open-v70-7297c622297a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.atomic_open
X-PR-Tracked-Commit-Id: 6ea258d1f6895c61af212473b51477d39b8c99d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8113b3998d5c96aca885b967e6aa47e428ebc632
Message-Id: <177068462722.3270491.14558916523133337354.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:27 +0000
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
	TAGGED_FROM(0.00)[bounces-76791-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 60694115C60
X-Rspamd-Action: no action

The pull request you sent on Fri,  6 Feb 2026 17:50:05 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.atomic_open

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8113b3998d5c96aca885b967e6aa47e428ebc632

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

