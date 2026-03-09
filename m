Return-Path: <linux-fsdevel+bounces-79758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK7ANUGgrmm2GwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 11:26:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74539237032
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 11:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC0D3045AB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176E238F946;
	Mon,  9 Mar 2026 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPoOdWvE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B00D27E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051960; cv=pass; b=P/6ZWKxZS568knSCvcq9lEzlEGZ/g8uCH/p85+RqOuBada6o5Qa2NdjjwRjAJfRXeXxPRQaIz2pMttesgm+o/1rDSqDBlf5QCf7rxP5iBgmTvjWzKYKw1YXuhFNtScwZDTcTnsYmgYIoaM717l4Udksq8RtsS8QXu64l05u8RKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051960; c=relaxed/simple;
	bh=XlET0r0ILlBLsgrzWfDF/IrYSTzOj8AjpzWUoFItNZ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RhGb+xizc2PE3/3MM3up9RCeVnF4QTB6PUBv8gWk/kVra8r0QE9ZkhIta9Vk2mqTrzSQc6hkuqerEDsQ4h18M79kh8KwD2rj8WdbwSty8MeEIW773DhLiSFfwF+ThsY1GmgXHiOFps2Woh5vlGiSeFwxuIx9Fgq8rwh2fSk9+sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPoOdWvE; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94dd0f3c4b7so6906651241.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 03:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773051958; cv=none;
        d=google.com; s=arc-20240605;
        b=S5DMicS+tHG9vBDTK2MehgxXxlA+skt6LN4b1Yu+dlq0ItBdcp7T21at1o9UxAWSej
         eE17dBgCFUbajzaLO+8kqBwiTizL+Dj4ymhzCksdjV/em5WA8PM2N0GHmON8pFRkXADW
         9Xrcwguh1eScQhc1PDa5QOTVyDDG7sBpouxoN2gjUUPEbIj2n+YzPMjH6Jnb68XZTht7
         eqlCjazx+78zqQPOUx57EuF77K/ZzxiOMkNhEyBR2uMCCCqkq3WbYyhE6WfcQzgCJD1X
         zTy3SNg1qlwal4TGRyefqii6OiXLoXaFFngYEo+7Pv9rnrdNyy74cvkM8SwrAfGHrvMK
         0iGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=XlET0r0ILlBLsgrzWfDF/IrYSTzOj8AjpzWUoFItNZ4=;
        fh=EEfMvoRKKHbT3B+mLvtNIE204EAehK6lIbEdPqF8DVY=;
        b=E3T5GgNvOatCSK5ADtJdv0/uhVXKMi+c3mmrZb1zodC20NUgyHmOySB4p/iiwCq3WU
         lWGjNiCJRm9mKXae9h6fBhFeHkIfD1eh8506I5qWwwKxTBoizl/PFw5djx9nY6hmdEzw
         YAVzTWf8wyeUZBLmLa9Rlhwudu14bqeaJ/2HBhURNwi5pLmTtPSzTqarQQzbhwA9PoY8
         qnZ+GbRzqxHTLy6DR5C/kqoarZj1D//zaiD3udwNp+YxX05ovpanZqkD4+LWYzwAedc0
         iAe9xIxQ25S+3o0OQHh+RKXmQE1/vJ8bzeLTKSvp0w79G4MLhAJLSHntcm3nLsqWDgYe
         5IGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773051958; x=1773656758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XlET0r0ILlBLsgrzWfDF/IrYSTzOj8AjpzWUoFItNZ4=;
        b=gPoOdWvE+tOihIBK8rPvHAABZ7ijtPJqQWtQgmsjFj2jVR7ewOUo3e8VIqMnrueKsO
         2t2zIA6G2CyJN9XvFuHeUyNKletIJ1jwMYDjf4U0Vvb1wKNgHQFgw8bQWC2m5HVRVhtl
         cmeOE8BnNqNxLNWQjEH7C4TcSMQoqXhZ7NtWe8b4xHSnLGynBbnmeHPF2ti4QQOKQJ24
         8EO6iYZxSVirJcXqEkHWZWJUNjEItmFxLic2NvgVy6YE0pxA5/GwL7zeeL6J+cIqjNgh
         +aYqSmTO+2R5pP6Z4Y7zWARfVBl9c0w1UTLx/uWJZko151g7XGTIc+pKZLmifdSjGgGw
         Mm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773051958; x=1773656758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlET0r0ILlBLsgrzWfDF/IrYSTzOj8AjpzWUoFItNZ4=;
        b=aFX7ghgtt0kjkqR7BBLqHoe4hrzECm8lVcUKOWu+A29S7GdlibO7iH0b/3se+4F4V0
         zZnvkKSb7gLFBps27jrN0zewLbsK3EIwq6a6hLNo7lSHCS6iKO/0TxgVxlDSwaTonPzs
         xqfZ2qjqtE/FJqg0VENxGuVL/DTx5iZXY5rDeMj9PIcX4jzYGobVyc0DAjLZdkB5K4D/
         C1IJK070hYB3foJ1ByhZA+zFnDK2GoetpRBLjd9Yz+8hZRpuwLdC2/fiEOzurXfKAC3B
         N3dabh6KajndcdopBoLd5dwFMRKrGey7FEAz83/hnz3+yy8x7hZxqYlYXZtDoLnfVWVZ
         wCRA==
X-Forwarded-Encrypted: i=1; AJvYcCWqGeaU7um6jb+dwd2bbkX9728ZX22hTdVS8kXjrqCuJbTrrheHeXI+/pRaP3QuWJUBKNBpui9Ty6kVkqDW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5KPf9FoeEeIZDBaImzSgXKkMYphgILmi2H+c0LydGav1MEt4n
	Gb0oCHT0yQ0GQdoJT7f/4oZ6PdZbFJq/7/zIcFEdBez5ihd67yJLhQWgUwIp4r4rWiWVFlHlk8D
	uHHfcsetH2zSXsoCI5gsi5qUzT4xeZDTRIP5eZ3o=
X-Gm-Gg: ATEYQzwEpT38sKoTa6EGCVZ44XVFBaeWA/ru0dESqNjprf7a9VWyd2WYxj2niSBKFhT
	IT+1U0OP53hCfdv2oA9yYcTPrzejl2L9n6pMca1qBdkToYXRg1gHXMO9bAzIw31SiEBe1a1NYjP
	eWxDiFsxGlPLvO7S85ltbnBJmt/gy3OkL5A04NuGN/Dn5t86T7A0q0Mtvt8AZO626H+rNQ9+nNw
	/q8COM9tVKcBWQalieAczengFWg3y4PjCAyB4ebAIUAR8aezalVDwiwg07h+4MV25+nPJWc2RXa
	BxHnOrfCSbb2BGwaxYVxRddxGxX++df9oliPVRU=
X-Received: by 2002:a05:6102:c53:b0:5f8:d3b4:9517 with SMTP id
 ada2fe7eead31-5ffe5b7c5bamr4246079137.0.1773051958273; Mon, 09 Mar 2026
 03:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Mon, 9 Mar 2026 18:25:47 +0800
X-Gm-Features: AaiRm51Qhy_lyxKIEOF8UxcBhhI3Jz4Lf5Xlrod6LxZXW0eAq0ycheVB_1aLj1Q
Message-ID: <CAOU40uAEtabRYb8xdqvbFkLYNVfbbjQp3q9J4gO-emTsgb_rtA@mail.gmail.com>
Subject: [BUG] WARNING: lib/ratelimit.c:LINE at ___ratelimit, CPU: kworker/u16:NUM/NUM
To: tytso@mit.edu
Cc: jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 74539237032
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79758-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangxianying546@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.887];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,pastebin.com:url]
X-Rspamd-Action: no action

Hello,

I encountered the following warning while testing Linux kernel
v7.0-rc2 with syzkaller.

The kernel reports a warning in lib/ratelimit.c triggered from the
quota release workqueue:

WARNING: lib/ratelimit.c at ___ratelimit

Workqueue: quota_events_unbound quota_release_workfn

Before the warning occurs, the filesystem reports several EXT4 errors
indicating that the file system metadata is already corrupted. In
particular, ext4 detects that allocated blocks overlap with filesystem
metadata and subsequently forces the filesystem to unmount. After
that, during the quota cleanup phase, the kernel reports a cycle in
the quota tree and attempts to release dquot structures through the
quota release workqueue.

The call chain indicates that the warning is triggered during the
quota cleanup path:

quota_release_workfn =E2=86=92 ext4_release_dquot =E2=86=92 dquot_release =
=E2=86=92
qtree_release_dquot =E2=86=92 qtree_delete_dquot =E2=86=92 remove_tree =E2=
=86=92 __quota_error
=E2=86=92 ___ratelimit

During this error reporting process, ___ratelimit() receives invalid
parameters (e.g., a negative interval), which triggers the warning
about an uninitialized or corrupted ratelimit_state structure.

From the observed behavior, the warning appears to be a secondary
symptom triggered while handling a corrupted filesystem and quota
tree. The initial corruption is detected by ext4 during block
allocation checks, and the subsequent quota cleanup path exposes the
ratelimit warning while reporting quota errors.

This can be reproduced on:

HEAD commit:

11439c4635edd669ae435eec308f4ab8a0804808

report: https://pastebin.com/raw/yJp9p1dM

console output : https://pastebin.com/raw/tyPquTTH

kernel config : https://pastebin.com/7hk2cU0G

C reproducer :https://pastebin.com/raw/Sh3a62JM

Let me know if you need more details or testing.

Best regards,

Xianying

