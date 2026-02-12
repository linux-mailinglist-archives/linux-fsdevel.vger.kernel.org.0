Return-Path: <linux-fsdevel+bounces-77049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPynDVonjmlrAAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:17:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816FC130A29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860143102445
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6094622D4DC;
	Thu, 12 Feb 2026 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMmxmxWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA982877F7
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923665; cv=none; b=eIOjfGTt/0BtLB6JH94F+DBdFhz60jPesaN/MFjcCkImL65uGFe7pb9qUQmY5uHPAYkOzF8YoIgGELVlFUI/4EayEkHX+in0cpryXxbPUkGbLbOn0++/jbSJjMyelAxcHEp4mE6C083kDHeYRrB8VgA4nIYIVpSe++QPDhlTI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923665; c=relaxed/simple;
	bh=yKDi4meh4Vyiomgk7rSBLR/a3bnnHuQ/zbDI93ww/bw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qfyTDI7DQOQhYDRa5UABZ60gEIHRrgQrWS/8JexcUOO7g9mrVI+Run6GtdBr34TKyKJVON+HhKm8cEHaGw0GKbxeY5ZGXhnjfeYrvs8TLloLhiTgmqVNgpG/fCboxE/zV5ZQTZ9G8rVlqfflrpW+a2Zwe8Kd27z9WDt02gKel5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMmxmxWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79875C4CEF7;
	Thu, 12 Feb 2026 19:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770923665;
	bh=yKDi4meh4Vyiomgk7rSBLR/a3bnnHuQ/zbDI93ww/bw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bMmxmxWi/ri+wR2l2s7qxkb/VUTyVlt7Vtli62zg7TpAt4RoKkTB3ANunmMMLBWf1
	 qEagEh1Xso97EAZ7O4M4i4GUFzAMZmnh/OLdV0VteRUtyDWoXJom+AbRdx56bJcM0S
	 X86fdQkz3y3WQADjotZzvyZBts0a/BsVwZkDBjd3f2jDxQFayuI5dAz9kLKCu8uaSc
	 xaNGORoqXwU+I/hMcPGrhw7HfJCmgwbQ4IZImDOcez8jbfNH/l6M4AE9ggrarELPBh
	 ceAo8oW/VpNqwJDu3hRNHi5puB/KA+PpU1wfzgJBoQFmINEnMDRF6OIqNRdpdWyABe
	 84J6JjGkPlhuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AF3F3800346;
	Thu, 12 Feb 2026 19:14:21 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 6.20-rc1 (or 7.0-rc1?)
From: pr-tracker-bot@kernel.org
In-Reply-To: <ydxny54jcyo6e2gfnanvdyp3k56orif4gfedumhbf6s2ocges5@m6nvf4awu7vv>
References: <ydxny54jcyo6e2gfnanvdyp3k56orif4gfedumhbf6s2ocges5@m6nvf4awu7vv>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ydxny54jcyo6e2gfnanvdyp3k56orif4gfedumhbf6s2ocges5@m6nvf4awu7vv>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.20-rc1
X-PR-Tracked-Commit-Id: 74bd284537b3447c651588101c32a203e4fe1a32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8ed22870f5304a6ac64f694572cafc12801a9cf
Message-Id: <177092365963.1663336.928582449263803794.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 19:14:19 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77049-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 816FC130A29
X-Rspamd-Action: no action

The pull request you sent on Wed, 11 Feb 2026 12:50:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8ed22870f5304a6ac64f694572cafc12801a9cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

