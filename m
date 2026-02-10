Return-Path: <linux-fsdevel+bounces-76786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHZDG8OBimlaLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:54:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D31EC115CA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7FEE30C1C61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1502E612E;
	Tue, 10 Feb 2026 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyhmipBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E7326ED35;
	Tue, 10 Feb 2026 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684625; cv=none; b=KUtebj5NScW5Xr3zRwQDz9iPdLmFCiW2Cn52vw6SiCfq+rc+nJGfofzzvg0r/Z64NgOjCB/IQ9N6yLCXyOjJgzt8PR9Rtg8xBTZ1gcz87Sn7Lc4sOhy5l9UKmO+SX3NfBL9VuNcJHjIWD7VIz2N6rIXIpaSD0QVNZnGI+bAj3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684625; c=relaxed/simple;
	bh=gGMRoKJarSYNV4mEAVkkrS94hdobjtCnsGloT6gaCOI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p2+Fm/HLv2HF1Znyhwdm++f65JsWk5Z68pvPfdQJ4cYEBMThU6B41fg8/+SIzm6M5Sob0TpDCIMjaCxJ9J9MpWtsVZPaXAINtJOl4xNYX4BiR8q/cTSylCQhgJMlFqD1njI8i3uW87US8NDGa4naCVbPgGW6hoWOt/SCVmcihQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyhmipBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFC3C19422;
	Tue, 10 Feb 2026 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684625;
	bh=gGMRoKJarSYNV4mEAVkkrS94hdobjtCnsGloT6gaCOI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qyhmipByUNMA8Zwc2S79JfLvxEYgBUAApmxUPMKtObku4SnM6yqB1GyUKdJlsOxdd
	 iH0dnJ1rW8yqeNjIp8Uh8GrjaLB8Eb0TWZCpASfCQghp651rw+7x3JuII2VmQKvpLU
	 3Ogud0Ovma8xXo897CatVxVGAYIuRAccrNWFmlAJAxKqFKg9O6fykWebhgvwS6cUgn
	 YrLq/DzUhtKWcSMZhedZgWdgUveC2Mza7b6pY+eFvq3jmE7NgBMzd4nBP5Qga7qz2b
	 R0UCHm53JrqkfrhEzyuTsca5+ttm3QNUcxxV9kNZrdr6gtaUcGHwH+dXSDir72VLHu
	 cTwYk9tyFa8Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 97282380AA4C;
	Tue, 10 Feb 2026 00:50:22 +0000 (UTC)
Subject: Re: [GIT PULL 04/12 for v7.0] vfs leases
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206-vfs-leases-v70-bff7da8bfd23@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner> <20260206-vfs-leases-v70-bff7da8bfd23@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206-vfs-leases-v70-bff7da8bfd23@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.leases
X-PR-Tracked-Commit-Id: 056a96e65f3e2a3293b99a336de92376407af5fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa2a0fcd4c7b9801be32482755a450a80a3c36a2
Message-Id: <177068462152.3270491.2176224474605991735.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:21 +0000
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
	TAGGED_FROM(0.00)[bounces-76786-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: D31EC115CA5
X-Rspamd-Action: no action

The pull request you sent on Fri,  6 Feb 2026 17:50:00 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.leases

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa2a0fcd4c7b9801be32482755a450a80a3c36a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

