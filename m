Return-Path: <linux-fsdevel+bounces-77050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKweFl4njmlrAAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:17:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E57A3130A30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 421743104EB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F1D292936;
	Thu, 12 Feb 2026 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ut8+L2gJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9937028134C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923667; cv=none; b=bbvqlEK3QssOz2x9vAy0A862mXgcIRC9rVnLQhpATdaYuoqzTQ8cIuGVMK1r8cbLBlpi1Rriyhc7CY74xcaRqLDpUpaPzqqJBUv4Kkb3ALhVs1xUdBBvKhSbVzOGDel5ot013bh+iQ/RVbL4nniEBGazD0qEjPjG+CVuMzlruCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923667; c=relaxed/simple;
	bh=SUjGGIOxsNZRpaLLXE51TCoZlWnwyzetnnEBKmN/OOY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mwbXqwOXYJLV/4ooPkcKQLGhO2W5Q9TBJi9BFd/sdW54XSKrCKFpQsb5RLSds1RkwlH0M+Uif7gjf4WGYxyfw0uFcoJ1lL5q5dI0lNZD1Ix7S0+f5BEQ9jeMvki7Up9t6rfn/bn4Ud3w4iBn9d+gIdgdVpOLcUpODBBVM4v3ikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut8+L2gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C69AC4CEF7;
	Thu, 12 Feb 2026 19:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770923667;
	bh=SUjGGIOxsNZRpaLLXE51TCoZlWnwyzetnnEBKmN/OOY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ut8+L2gJHQXlKdiJu61yi4RFPO42E3scEUdnsKB2CU4ybTTMPhGSNXjZZWIlsAjXJ
	 8CtShwafD4UJoVb75+4JMrFTR44H3sjajm2310mmVLGmsGPaD5KXvAY7YFptFFkFb9
	 exf5qNuXMYum9DNWluFEtTr65p7j1NPEy2vycn9tDA5ctXWKeuvMKMtHdXvMMbfEyU
	 M86j9s6tGxtuRqt7a3Avke803e/AyovRpD0KnMtbPzYIRQT8K55ywbFYQ6Bhb0QGNT
	 WRgil4HhF1/Co00U/0n1I72RQge/e1yRDuP+ak2IZC2zBPiJodmix/Dya5L1UkEbKR
	 DELhbFY3Jm8Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C20B43800346;
	Thu, 12 Feb 2026 19:14:22 +0000 (UTC)
Subject: Re: [GIT PULL] quota and isofs fixes for 6.20-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <xpx7drxgrtrzlcazrmqqepfdtognnodyucziepzakx4adm3aau@zwmaecmugo5h>
References: <xpx7drxgrtrzlcazrmqqepfdtognnodyucziepzakx4adm3aau@zwmaecmugo5h>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <xpx7drxgrtrzlcazrmqqepfdtognnodyucziepzakx4adm3aau@zwmaecmugo5h>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.20-rc1
X-PR-Tracked-Commit-Id: 18a777eee28938a70a7fb103e37ff4ba56e5b673
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 541c43310e85dbf35368b43b720c6724bc8ad8ec
Message-Id: <177092366139.1663336.811545620644633135.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 19:14:21 +0000
To: Jan Kara <jack@suse.cz>
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
	TAGGED_FROM(0.00)[bounces-77050-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: E57A3130A30
X-Rspamd-Action: no action

The pull request you sent on Wed, 11 Feb 2026 13:20:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/541c43310e85dbf35368b43b720c6724bc8ad8ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

