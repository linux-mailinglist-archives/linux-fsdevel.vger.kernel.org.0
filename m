Return-Path: <linux-fsdevel+bounces-76397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A0OCRp9hGl/3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:20:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93548F1CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96D54301C92E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B173ACEF4;
	Thu,  5 Feb 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm8CwbA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DBC13C918;
	Thu,  5 Feb 2026 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290445; cv=none; b=T2lX+d5EWfG7IyysMmwBDVnu0j4WZF7Gu6RcWcN0A+66oZsB/PDUEf9NT984ebRtQTBks5qzuPm61T0dGoRtWUoW32fNatJnT0msdK3D0Za2RLAOLRUG4KCWFgCLvCGgS+Ix2t3SiqQnmWmJna3Ap778D2JNpavaahN4+FV0L8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290445; c=relaxed/simple;
	bh=MyHgiKqqdgS58w8lVs9R1fAHHVuBS+/jQyH2ESszHYc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OQ5Zqa95RwoZ26PG4UX9FBfYhYjAFrpI/owxzlOaL3Yj9f64bHoMTFgZW86h+tn2KGp9RUy5aP0dxqY53JuLvE7b+6HXRWnAGBxhkTK4jVBULipWDEEbmLJvjolCiJQb8hQCGG6h5LGX5qy9h7y/Kqv1QFwcNWtASXt3bs9b7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm8CwbA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AB6C4CEF7;
	Thu,  5 Feb 2026 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770290445;
	bh=MyHgiKqqdgS58w8lVs9R1fAHHVuBS+/jQyH2ESszHYc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cm8CwbA9ihWW65Cav7xbkH3vtwXJXAmuCIonHPx+Hd+9XLrTSWmIvg8Yy5ESK7QPK
	 N/FW41EwbwgA7RHos9JDYAAIMsVwOIII2d+i4Dj+bOLfH23kpPntpIJ3WqawFJUjJ/
	 p96Ner5mY+zpl/LnoTi+NtAGErYxlzIWHsrPYbl3UtsGN/SasHzXZaQt0n5z1swJtq
	 /Wv81cnY8DRZprH8UqJedEuAeL4yIWXCVFtfJHJfM1snEHkVG0bMa+8zxhmuykokUy
	 7lUlXHNazBlPvcsv0OwuRmiiJaQLwSb9Kt7XuARTz6dlw6jooL3riQtYU+1H35YF+U
	 ZOXKzkCgUlnQA==
Content-Type: multipart/mixed; boundary="===============6872421294398828182=="
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
In-Reply-To: <20260205104541.171034-1-alexander@mihalicyn.com>
References: <20260205104541.171034-1-alexander@mihalicyn.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
From: bot+bpf-ci@kernel.org
To: alexander@mihalicyn.com,ast@kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,jlayton@kernel.org,brauner@kernel.org,bpf@vger.kernel.org,linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,aleksandr.mikhalitsyn@futurfusion.io,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Feb 2026 11:20:44 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-fsdevel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76397-lists,linux-fsdevel=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 93548F1CD1
X-Rspamd-Action: no action

--===============6872421294398828182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 005ea3a2c..c350857b2 100644

[ ... ]

> @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type = {
>  	.init_fs_context = bpf_init_fs_context,
>  	.parameters	= bpf_fs_parameters,
>  	.kill_sb	= bpf_kill_super,
> -	.fs_flags	= FS_USERNS_MOUNT,
> +	.fs_flags	= FS_USERNS_DELEGATABLE,
>  };

FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the kernel
tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is defined
(at line 2268), not FS_USERNS_DELEGATABLE.

The commit message states this flag was "recently introduced", but it is not
present in this codebase. Will this cause a build failure due to an undefined
identifier?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21708956860

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard kernel contribution patterns with natural language and proper references, suggesting human authorship, though the undefined flag error could indicate incomplete context.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: The commit uses FS_USERNS_DELEGATABLE which is not defined in the kernel, causing a build failure that prevents kernel compilation.

--===============6872421294398828182==--

