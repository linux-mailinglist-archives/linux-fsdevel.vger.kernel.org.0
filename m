Return-Path: <linux-fsdevel+bounces-77192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HSFJLO3j2n4SwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 00:45:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CB813A0A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 00:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2192301C13E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4223294A10;
	Fri, 13 Feb 2026 23:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ6LJlyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CFB3EBF2A;
	Fri, 13 Feb 2026 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026348; cv=none; b=Dp8BtGEiCvl6je9vC7w68c1b/oc4U9vpnF4eqU6AdQWVrmlWXfmmgn2BLzVtbDO30YKiHxlnAK7cWYte1jbSOfzKsveJ8DdXCXVFvg8yrqrG2jCnz5D29Z4PYAWwsaxBX67KoI95iGxCGP10BWHda4q91hhsJlrWzLXneQ7JLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026348; c=relaxed/simple;
	bh=EWfaKJCaJC2GErydog5q9S65WnGr3OmrX5J6uwCpiPk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JMCR7mpFeV9giA2eyIEgYs0kvALAUyNtrkdzAyGApdq80NGEb3+XA3/Zyw1V6twUK3ebBWtkCUgyd6/v4qWpV+gIJX+DnswhHBYyIImm3DtFBHiut981Vbh9BregkCrYKaK+oeoUYFIh8JvSdvGp4XfTyAoRJDd8ZxqSYZC8uho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ6LJlyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9850FC116C6;
	Fri, 13 Feb 2026 23:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771026347;
	bh=EWfaKJCaJC2GErydog5q9S65WnGr3OmrX5J6uwCpiPk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GZ6LJlyZWLf4CDD5S/zkdrpwC2BXwCpeTxgo1tIB1sIcZco7UXK8Hdj4gaVXMxXwz
	 IyqXcv7lo9oeR//v00ELuNg66qlpw9bzGf7XqxUsNZMUy2EUCuPJfnzRQ1UU8fcLlH
	 XG3ptvUaXIezNwP1k8g2s9vlYWAy5TLqIVLvJpQllknBDZYAWaxwdcpzqzL9a8DSFM
	 vnZGWriKQS6uWTi8U36rK9OmdRe3GVAcGatiya2g+PIQbWFkJZLl68iGfdtr/ckr+d
	 tNCTSaRznDdLmk0AHz72k2L6ZggIyYEgpgkRpO+AMCQt8ZOgVU9i01qo8tS+bjd69S
	 YnCUoqkY9aHvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852673811A44;
	Fri, 13 Feb 2026 23:45:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH mm-hotfixes-stable] procfs: fix possible double mmput() in
 do_procmap_query()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177102634133.2575868.4556838261873713161.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 23:45:41 +0000
References: <20260210192738.3041609-1-andrii@kernel.org>
In-Reply-To: <20260210192738.3041609-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com,
 shakeel.butt@linux.dev, ruikai@pwno.io, tglx@kernel.org,
 syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-fsdevel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-77192-lists,linux-fsdevel=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,237b5b985b78c1da9600];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,pwno.io:email]
X-Rspamd-Queue-Id: 30CB813A0A6
X-Rspamd-Action: no action

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrew Morton <akpm@linux-foundation.org>:

On Tue, 10 Feb 2026 11:27:38 -0800 you wrote:
> When user provides incorrectly sized buffer for build ID for PROCMAP_QUERY we
> return with -ENAMETOOLONG error. After recent changes this condition happens
> later, after we unlocked mmap_lock/per-VMA lock and did mmput(), so original
> goto out is now wrong and will double-mmput() mm_struct. Fix by jumping
> further to clean up only vm_file and name_buf.
> 
> Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA lock")
> Reported-by: Ruikai Peng <ruikai@pwno.io>
> Reported-by: Thomas Gleixner <tglx@kernel.org>
> Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [mm-hotfixes-stable] procfs: fix possible double mmput() in do_procmap_query()
    https://git.kernel.org/bpf/bpf/c/61dc9f776705

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



