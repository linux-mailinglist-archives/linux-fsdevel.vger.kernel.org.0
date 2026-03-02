Return-Path: <linux-fsdevel+bounces-78893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J9oOSePpWmoDgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:22:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6196E1D9AF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C24B33072FE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9E3E0C77;
	Mon,  2 Mar 2026 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="nKDgCSEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061591E22E9
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457478; cv=none; b=tTVUcUO3LFpY8DXrYNoYluSXPam9u17+I/AIz/s4GtPqW1SPqem+Mc9SI1nA6JkaP5kDuRAH45XtkARxQgtYgPcyScYeUyUiDwIfGP/BSg+TGij9HZnYgj+IVgZT7qWJFNFhHQipSU9m9d3ysNFRh3HBQGcA/5GZJ0EQ0/EtzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457478; c=relaxed/simple;
	bh=HvN+5WSDnnaMmBob8vPdPAy1L1OeRTuABSQ4GCZi6gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDJlol/BsAG3SADcuToOicibVKug3QSL6zjZWDDj6DpynkyNiW30ug6EGEYqqxPE6YjMOckTp+0iRCMUbm+iUvQdsqUB104Xt7Piw6AXzJ68YudHKpIkj8RVEkBqwU2kxUVR42ukDXhGueyGAw7zvxRRr3ZnsGdQa1+P3gtSmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=nKDgCSEM; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 0fe854ce-163a-11f1-89dd-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0fe854ce-163a-11f1-89dd-00505699b430;
	Mon, 02 Mar 2026 14:16:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=UXOUq0SPuTwj8yiZauBk+IGzhYE4jhkwANNAtQNGrwo=;
	b=nKDgCSEMFuPHLhkvzBBa7QoiJn/nK64ml2iiskFgSL5fh+wFZ1trcdNR/IBkZuxJIAVl6fxNyxey5
	 wXRJL79zB56nl2hMQupfoAqAvFMgDd70PuKIT1suKsUy82J5/Nel9/h+qx4CM7Y6nyK1rhsaB2ZflS
	 WoMoqT6t9kQuFw6ucKuMkEo42oPdXomyQptkOZBq1Zd9BIfPP3u8dKHraI9n+tyFzJA06YTKnr/IWf
	 YXRAvcg99vfyyoP6ia+43+ve4a+hclWNF1LgKpapKLLfkcc2WUcIJQJBO0eq6tqm1uJVmevHwzMJ12
	 rTv0038+U2qg94UZXlEOyyuL2Aq8k4w==
X-KPN-MID: 33|oaSdtL18s0S3rmYtAKo3wUuP64Wro3UI8fc2nbCgSYkZFJ1PIcvm+PDGrnhJnIq
 Pe58mfy9QcxWMjNND2NoMh/s8ZHM67GgrW6A4SSxGsvA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6wtsfzs6BSedgfqbgXrjx0lfIjIgBkINRsDDAaq8ZaMu5vBQCwFuS51AkST6mq4
 FDgpvF0pSnSB6B4VrhqmHKA==
Received: from daedalus.home (unknown [178.225.116.246])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0c049981-163a-11f1-9c00-00505699d6e5;
	Mon, 02 Mar 2026 14:16:45 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkoolstra@xs4all.nl
Subject: [PATCH v2] vfs: add support for empty path to openat2(2)
Date: Mon,  2 Mar 2026 14:16:50 +0100
Message-ID: <20260302131650.3259153-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78893-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:mid,xs4all.nl:dkim,xs4all.nl:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6196E1D9AF0
X-Rspamd-Action: no action

To get an operable version of an O_PATH file descriptors, it is possible
to use openat(fd, ".", O_DIRECTORY) for directories, but other files
currently require going through open("/proc/<pid>/fd/<nr>") which
depends on a functioning procfs.

This patch adds the OPENAT2_EMPTY_PATH flag to openat2(2). If passed
LOOKUP_EMPTY is set at path resolve time.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/open.c                    | 9 ++++-----
 include/linux/fcntl.h        | 5 ++++-
 include/uapi/linux/openat2.h | 4 ++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 91f1139591ab..4f0a76dc8993 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1160,7 +1160,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
-#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
+#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | OPENAT2_EMPTY_PATH)
 
 inline struct open_how build_open_how(int flags, umode_t mode)
 {
@@ -1185,9 +1185,6 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
-	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPEN_FLAGS),
-			 "struct open_flags doesn't yet handle flags > 32 bits");
-
 	/*
 	 * Strip flags that aren't relevant in determining struct open_flags.
 	 */
@@ -1281,6 +1278,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_DIRECTORY;
 	if (!(flags & O_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
+	if (flags & OPENAT2_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
 
 	if (how->resolve & RESOLVE_NO_XDEV)
 		lookup_flags |= LOOKUP_NO_XDEV;
@@ -1362,7 +1361,7 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 	if (unlikely(err))
 		return err;
 
-	CLASS(filename, name)(filename);
+	CLASS(filename_flags, name)(filename, op.lookup_flags);
 	return FD_ADD(how->flags, do_file_open(dfd, name, &op));
 }
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..d1bb87ff70e3 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -7,10 +7,13 @@
 
 /* List of all valid flags for the open/openat flags argument: */
 #define VALID_OPEN_FLAGS \
+	 /* lower 32-bit flags */ \
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | \
+	 /* upper 32-bit flags (openat2(2) only) */ \
+	 OPENAT2_EMPTY_PATH)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index a5feb7604948..c34f32e6fa96 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -40,4 +40,8 @@ struct open_how {
 					return -EAGAIN if that's not
 					possible. */
 
+/* openat2(2) exclusive flags are defined in the upper 32 bits of
+   open_how->flags  */
+#define OPENAT2_EMPTY_PATH	0x100000000 /* (1ULL << 32) */
+
 #endif /* _UAPI_LINUX_OPENAT2_H */
-- 
2.53.0


