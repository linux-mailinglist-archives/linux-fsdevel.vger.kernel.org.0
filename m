Return-Path: <linux-fsdevel+bounces-77320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AERAK0iWk2kd6wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 23:12:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E495147DD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 23:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 270EF30329A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 22:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A0A2E03EC;
	Mon, 16 Feb 2026 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAOQ8JU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C050A2DF12E;
	Mon, 16 Feb 2026 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771279907; cv=none; b=ZZRtfZ0SbwoPpMe46MG57YWCNOFfyjvptnqoNgs/1dr0nn0YS6im7JBuII9ip0bdE6tG9zy/EC9sNOWhhFarmyfW1QgeTkEy9cNXaP9eWcJFsTDdub5mAbgMZdCxTV1slLMTbtkV3ZjcwxXloZkZH102wRgGh+dP0UtF9UdeVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771279907; c=relaxed/simple;
	bh=FwTpZHQIUSXRpoozEJ7XQX8IPbEQMiWlyTCYhouCyvQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fvpuW6TYYHkBGvRCjNdtVAyNtabgvOPYISvkeRusAo1AJBiwyvZ5PZv6r8h/Vewa3x+O0Y0Ov4+zdVm6SyuVtkRVNwToav0A/58HJ/Y2eXJx358d6eGWPc7N1h+NYY0k5stWptwnD8eK7lN3ks/uiVtvfZ7mnZJDL4Ki2KqmVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAOQ8JU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8289CC116C6;
	Mon, 16 Feb 2026 22:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771279907;
	bh=FwTpZHQIUSXRpoozEJ7XQX8IPbEQMiWlyTCYhouCyvQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AAOQ8JU4TH4AtnDskuyVqY5i0PyTl9zkHq0eLdemtzqcdCnDK3+OtiGZvdedvhB7B
	 dcWCSs/tUXnC/GN//WWfy3GbtDfFLvHlE1SH+vhrJz638oQ4ezMUxCX3j0alihosK4
	 2ozeEyZGHf74EfToAIZZ7EYddsIm227rcBEHBnqUm3KyLSVQSUrOJsQ+FCm4HQjhVb
	 7joewSPLmClq1ZoTWFCxA+a96x84mRrMfT2sUvpdUOliet07OnovF118ZZYA/G9xMd
	 M4a9ZCJrGRaa2mfu+RnfA98JPIk+uxA93uOCoVGRH3wE5u0JkYO80h3S2j5L/N4zPJ
	 mh16i3maoZv8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AFAE39308C1;
	Mon, 16 Feb 2026 22:11:41 +0000 (UTC)
Subject: Re: [GIT PULL 14/12 for v7.0] vfs misc 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260216-vfs-misc-2-v70-fd637c6f249a@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260216-vfs-misc-2-v70-fd637c6f249a@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260216-vfs-misc-2-v70-fd637c6f249a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.misc.2
X-PR-Tracked-Commit-Id: dedfae78f00960d703badc500422d10e1f12b2bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45a43ac5acc90b8f4835eea92692f620e561a06b
Message-Id: <177127989965.4020762.3224981060051965154.pr-tracker-bot@kernel.org>
Date: Mon, 16 Feb 2026 22:11:39 +0000
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77320-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E495147DD9
X-Rspamd-Action: no action

The pull request you sent on Mon, 16 Feb 2026 13:55:40 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.misc.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45a43ac5acc90b8f4835eea92692f620e561a06b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

