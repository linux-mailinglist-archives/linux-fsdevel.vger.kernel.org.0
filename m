Return-Path: <linux-fsdevel+bounces-79429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHEVJHxlqGl3uQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 18:01:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5D9204C3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 18:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2511130E989B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A09133C53D;
	Wed,  4 Mar 2026 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsH69YDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAC35BDC4;
	Wed,  4 Mar 2026 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642843; cv=none; b=g9rZHfwiexijJ7F0W8JQABRBxCY7ReG9cvpv+vlnveTrxYJhZqudR3IvUvE1v7my6FzIu/2kvj0J3deiKu3Ln+0KN3b6sRkvzcfqcYpjgG3I71aCPKdydXV4yrwOy3IwnYu7NOWrX7SkErNxQ1k6rl6K042rBqYiVwHCPFs7RWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642843; c=relaxed/simple;
	bh=WRDoyQpHH9JpRQSQSi5i+YPi+rG+f0UQFqJEUnT/Wfc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=couBPyCuRRkkPQpDIVUKgY7ueAkXQEOaEszVwpre3470+4IrpulDlejkHIbY76Wb3Mrky4pm/ixoB9dOiRRBQB5rnYkxml8AtE7IXp3QfhihO+0bKNcz0Y16VOKVYFFUgp3wTmgIQCQ2NwMJo3Elhl2rFj4ON68aBzEc2xNnuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsH69YDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B306BC4CEF7;
	Wed,  4 Mar 2026 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772642842;
	bh=WRDoyQpHH9JpRQSQSi5i+YPi+rG+f0UQFqJEUnT/Wfc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TsH69YDgv88ADvDOWoAF4cCDV+z7u3I8uEDvia3U80AoBm2S8puBHWPs4FE9Yf3iT
	 MGmcIWCz2zg4hIcVyOCr5dFFLUMktq5OZoZ4/SWWtjzfn9Z8hwl+9Qn114AhuGUzax
	 FxuXAS6TlL4Ph5IGqnKaYHJRw2vUREtKCuue+UDbrn9tY6nBweYYet/nf7wqKbnPYR
	 fRNZCBtlH74D+rXRweUdqJWDXg3WeXaekcM3mSnT+zON9DlTvANNnPfIR1Z6d2s4+v
	 2hGAQmSDxmyZztPoTe+3BhSwzT0ezKjePU7pkNpoWfaenL0NwZt656/VGVOzXGSx4X
	 1nmber4cya6Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0BF3808200;
	Wed,  4 Mar 2026 16:47:24 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl fixes for v7.00-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <nya2yy22oifvepb4g7q3kukfq7f3s5zoab4yb7ahkcn6t7qdfv@eknh6exiog26>
References: <nya2yy22oifvepb4g7q3kukfq7f3s5zoab4yb7ahkcn6t7qdfv@eknh6exiog26>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nya2yy22oifvepb4g7q3kukfq7f3s5zoab4yb7ahkcn6t7qdfv@eknh6exiog26>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.00-fixes-rc3
X-PR-Tracked-Commit-Id: 6932256d3a3764f3a5e06e2cb8603be45b6a9fef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecc64d2dc9ff9738d2a896beb68e02c2feaf9a02
Message-Id: <177264284305.2299690.16606045481899931620.pr-tracker-bot@kernel.org>
Date: Wed, 04 Mar 2026 16:47:23 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, Colm Harrington <colm.harrington@oracle.com>, Gerd Rausch <gerd.rausch@oracle.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 0D5D9204C3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79429-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The pull request you sent on Wed, 4 Mar 2026 14:48:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.00-fixes-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecc64d2dc9ff9738d2a896beb68e02c2feaf9a02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

