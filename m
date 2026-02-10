Return-Path: <linux-fsdevel+bounces-76796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLmSFA+DimmfLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:59:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F7A115DF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E05E3053646
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892A32FA28;
	Tue, 10 Feb 2026 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxalWT9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553F273D84;
	Tue, 10 Feb 2026 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684638; cv=none; b=NfCJtZ2BE72u7yy4prMTorIi9HAvyjggUXHy1eQAPaM9jK1+AFtEINrQxODRqYPDSODEImEacot0r3VAvO1/7vhd7LMM0RIAVR9CcvaAueYb07q4khDS0UHBeOz4aZLl750nvTAOS9PNNlqvsjaieTtsYLiDS7g+gjGvTo7ondc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684638; c=relaxed/simple;
	bh=yxLO5RnzXFJBfzH7+hA33tznVFThmhM6nOgm4pvmPZo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WnMte4b6VJ1/oNtWXvQ9GtDWIYB7VBFvChcsQ58r32Nb8XLFcyM7pX6OdKtXzaonLxrO/dzPHbrOTguVRgFjWYCsWRQOLoY/1cs8FtAbyPYgbpVjjqqcQEtvKHoLf7XtqFhV7ByKmqPpF4ARgGXW70E4ucfdaKzqVl8W3JoqMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxalWT9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5601DC116C6;
	Tue, 10 Feb 2026 00:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684638;
	bh=yxLO5RnzXFJBfzH7+hA33tznVFThmhM6nOgm4pvmPZo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JxalWT9SRvzfSQEaxe7uBVf4S1wjVeaiZDhXxNoGdODFceSYLqLfY3hZYqI585cMB
	 3nXQu0430ViEWhGvWDsDdU46/lfc5dh73pB1SHBp/08wJsRLU0WJUlAvxUuXQy+P8o
	 FZ/EzMcdOcx4tMS3JOqlE5tUKQOe9bgrPeni2qqRj75MhX4mzO0igOAH4pCiqfw+Kw
	 uyXB0luyofDNUGb4CQVlW3JS3sqnJg4ziRk/JACXwOTwsLKbFTwxvb+gA7txa0s2O3
	 GVbmWtdJekteGK2gb3AgKqAwh0FThtUHfbfiXhfQRlwnzOqiNPXQQFcJzuor8ovhjF
	 V+L1NJUWxz9eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 47F00380AA49;
	Tue, 10 Feb 2026 00:50:35 +0000 (UTC)
Subject: Re: [GIT PULL] hfs/hfsplus changes for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
References: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v7.0-tag1
X-PR-Tracked-Commit-Id: ebebb04baefdace1e0dc17f7779e5549063ca592
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fb7d86fbef0e294f4bb6bc46930c5789d332dc7
Message-Id: <177068463421.3270491.9596067086097043588.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:34 +0000
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, jkoolstra@xs4all.nl, mehdi.benhadjkhelifa@gmail.com, shardul.b@mpiricsoftware.com, penguin-kernel@I-love.SAKURA.ne.jp
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,physik.fu-berlin.de,vivo.com,xs4all.nl,gmail.com,mpiricsoftware.com,I-love.SAKURA.ne.jp];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76796-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1F7A115DF8
X-Rspamd-Action: no action

The pull request you sent on Fri, 06 Feb 2026 16:26:16 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git tags/hfs-v7.0-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fb7d86fbef0e294f4bb6bc46930c5789d332dc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

