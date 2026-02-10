Return-Path: <linux-fsdevel+bounces-76795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G50ENSBimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:54:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE235115CB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB382303AE4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA532ED22;
	Tue, 10 Feb 2026 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4M7wPdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95932E721;
	Tue, 10 Feb 2026 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684637; cv=none; b=a/wzL7cqLl1C4c0SdQXOX7NTRX9UY2jeeKtsCZXaYiySWHZYNR3VH7ZUw1xwtE2CPQcdkPymw6xH911aV7R/Y1/4M8rzQid2HaLEFSJYlGngw00R2Ykvn5O7HAiv1pGoieW622KvVyiGFZhCuYlQngwdn6Xqkid8WX019K2KIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684637; c=relaxed/simple;
	bh=roleWkLugL9rTs4c4mfLaYXlr2+78az21Wio9i2cR3E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tiwxhCG3V/E4JDLf038BcjIlMUH/x5VqkdmyC43g9bbtbWKJzfmBI1Yw9a1uPyIrdEeU9vwDZspP3TqQZvcwDxPS7LebCzAt0o9BAVri2hG6TYcZnmCUuibcj8O/d93UWhVrsq/fapl18I/4CI5hweHdB3vFM3kQjVJvKnoVTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4M7wPdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3344BC19423;
	Tue, 10 Feb 2026 00:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684637;
	bh=roleWkLugL9rTs4c4mfLaYXlr2+78az21Wio9i2cR3E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S4M7wPdcL8z9xP8WjUtsTyaNB577KZBxgcS7rL9jyTRYlrHmDF9frfNOK/NbXwcLw
	 87U9qetjD7WFhpFePY8el5sQacJcQisb1waU9hKciR3SRzZqrpQaVAYJCpp+rOYihT
	 vZmGI7xQMrjaM5K6IwXn5i68B/o1gZts7YFTyVfQGeCwcTX4I8cDl6bpdsm06cyi2p
	 9GK8qxcC7RH0K+m4+Rzq7owkRH13dUQAOlOeNZ9Dz2UrBIDF2W2zcKw/VvIbnq/pKw
	 fCs/EL8yHnY0qO2qLZjeXmWuEAUlPhPfk2GQcv1vYHOO0QXiUoiKLGZAc7hE/vKPpk
	 Y3/sadPZ8CYdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 27345380AA4B;
	Tue, 10 Feb 2026 00:50:34 +0000 (UTC)
Subject: Re: [GIT PULL] nilfs2 changes for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <651b71ac0e0015dc230e94368f07fca8098ec8a1.camel@dubeyko.com>
References: <651b71ac0e0015dc230e94368f07fca8098ec8a1.camel@dubeyko.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <651b71ac0e0015dc230e94368f07fca8098ec8a1.camel@dubeyko.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/nilfs2.git tags/nilfs2-v7.0-tag1
X-PR-Tracked-Commit-Id: 6fd8a09f48d6fee184207f4e15e939898a3947f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d10a88ce1651578c0948fbf26d7aaff298b486b2
Message-Id: <177068463302.3270491.18240000769178314995.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:33 +0000
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: torvalds@linux-foundation.org, linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Edward Adam Davis <eadavis@qq.com>, Randy Dunlap <rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,gmail.com,qq.com,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76795-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE235115CB3
X-Rspamd-Action: no action

The pull request you sent on Fri, 06 Feb 2026 15:11:56 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/nilfs2.git tags/nilfs2-v7.0-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d10a88ce1651578c0948fbf26d7aaff298b486b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

