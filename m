Return-Path: <linux-fsdevel+bounces-77477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB9cNin/lGlOJwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:52:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5F152092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E814307141E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10C537BE86;
	Tue, 17 Feb 2026 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWzHWy2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97537BE7C;
	Tue, 17 Feb 2026 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372255; cv=none; b=fRc5S+JhcZSJ3JinUxtUz32qaiZ3mVgtilH+iEXG5Je0fJWGMYtAmDzADnK6cT4JsRr/oOfZaAWyGlaFxpUFZNGQRRT/g7h1UV8cdZ3UGs3KlDYKWrf38VcdNXaTHsyKWXxW3Vgf/UqZXqvBMFLf0uLEZOiSk9UDmuLwo3rnwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372255; c=relaxed/simple;
	bh=5x1Hwus49KMQVvLqa5903dZ89LxuRyIbhORGQRSqDxQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cccCdcFQcjW5vVJtMCQ6x4jLCLe+9NKTM8OygK1eYoLDTHPLwU6e4iSyRgxgOqOEYSmHipJN+NQMJQTIXFGccY8DBUQxqa/9QxIZNJ+U1jZiYQc95rCreFq53dKaEnXGN11QF4ELij5diYcWg8kOK4DwCYlER3bZFhvAXFtFL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWzHWy2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8B5C4CEF7;
	Tue, 17 Feb 2026 23:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771372255;
	bh=5x1Hwus49KMQVvLqa5903dZ89LxuRyIbhORGQRSqDxQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XWzHWy2tZIPpidWnS+EnqDZ85JOpHSWLlS2JNEZ0GV7VC9MXm3/Hp/WwlPvWV9jl/
	 Dh+sI5KBcRHW74n5A4k20833BxuGd5C+lvdymDSZDNqzWZg4Ivxm/bon1LYoru2J9/
	 ybuIAuUAjTtFGtCaQkUrpv6UWtK5rEqzep4nifoYWB7cMUodw1jg6d0TblPSYxM9QV
	 JXr7H0fpDM6hoppf0QwdGOWmRMhc0T4nvcHDZ8LV26u3ow6cUV9zvgz/fpw0QlKiPj
	 IJd4wo2UhZ3s9I387zyPMx65+9fOVo1wjt3O/u2IpJHxTavgyPWtC74K5J7CnMieHa
	 ZgDNctcRUdwMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 480933806667;
	Tue, 17 Feb 2026 23:50:48 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: changes for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260217190630.19176-1-almaz.alexandrovich@paragon-software.com>
References: <20260217190630.19176-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260217190630.19176-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.0
X-PR-Tracked-Commit-Id: 10d7c95af043b45a85dc738c3271bf760ff3577e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75a452d31ba697fc986609dd4905294e07687992
Message-Id: <177137224705.738845.1474229967679540075.pr-tracker-bot@kernel.org>
Date: Tue, 17 Feb 2026 23:50:47 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77477-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DF5F152092
X-Rspamd-Action: no action

The pull request you sent on Tue, 17 Feb 2026 20:06:30 +0100:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75a452d31ba697fc986609dd4905294e07687992

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

