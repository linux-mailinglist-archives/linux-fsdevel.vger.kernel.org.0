Return-Path: <linux-fsdevel+bounces-76787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNThHNqBimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:54:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C02115CBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 235F2309FE43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FAC2EA73D;
	Tue, 10 Feb 2026 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnGWRTVr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47C2EC083;
	Tue, 10 Feb 2026 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684626; cv=none; b=VLIjk0Szua/O/QfAkQIEou7SKkAN0cDesQbf2yAlYSroyuEUZTC0BZQDXGt3/jIN72R+R98qOBY4mNwZ9n1PJgrpMgSvEpM28vooXKqX6ulIm5zo+v22UTUl4nLOAuvr153RigBgcPfxBb/8AkKdrcAOuUSjBvtj+Pw6CwYRfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684626; c=relaxed/simple;
	bh=sR8/vCdcYRwLAGMdHuzsHMFUVbWzoPCHfaNYVPQyMQM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ihbpNVvYjc6m0mrOdZFcO+8M8hh1g4GTd5AWGNO+4yO4nsb3uojD8yRIIGyFhGvAhgtFD/imcfTBEf2+xd90CTVduXXyGWp8RwXSP7gwDELB5TTcnqppb88aYtrtxrnXiSDqgTqb5Vu5zQiO866W5h7aXnUcOB/w4NHtYUBOL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnGWRTVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64A8C2BCAF;
	Tue, 10 Feb 2026 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684626;
	bh=sR8/vCdcYRwLAGMdHuzsHMFUVbWzoPCHfaNYVPQyMQM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NnGWRTVrIflBPR04L8lILHywt8I2fpEIBW1M1j+eYkJa4000CFRrZtqAoqKL2B/PJ
	 ALC1ODii3hkevv0O2a9FjCPDRfDSofMH/QTLDW/LgghDVwPO2rmr6UnZxGWWUmcGCA
	 9dUvg71k/LNasBYBVBuH63JXDcIShWHs6WETf1Co7rsuwZS4rptpU+6H53PARGXcK4
	 LOeXbtN9wzF6KInXm+FGYLWihLfbNGsR5P20eYOiafb+/KOhasQjQ8k8rBws4s7yls
	 UTbP4BiV6QXJ9gbLH6a0TAEiOL2X1KW/X7eop9l/zCDEFndgWPSAHvJv2ywYSj2skO
	 2vK4jRUcOTIfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BB86C380AA4B;
	Tue, 10 Feb 2026 00:50:23 +0000 (UTC)
Subject: Re: [GIT PULL 05/12 for v7.0] vfs fserror
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-fserror-v70-7d1adc65b98d@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-fserror-v70-7d1adc65b98d@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-fserror-v70-7d1adc65b98d@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.fserror
X-PR-Tracked-Commit-Id: 347b7042fb26beaae1ea46d0f6c47251fb52985f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a48373e7d35a89f6f9b39f0d0da9bf158af054ee
Message-Id: <177068462266.3270491.3044993638965126224.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:22 +0000
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
	TAGGED_FROM(0.00)[bounces-76787-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: E4C02115CBA
X-Rspamd-Action: no action

The pull request you sent on Fri,  6 Feb 2026 17:50:01 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.fserror

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a48373e7d35a89f6f9b39f0d0da9bf158af054ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

