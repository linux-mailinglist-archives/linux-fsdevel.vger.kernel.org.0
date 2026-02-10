Return-Path: <linux-fsdevel+bounces-76823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPC6JAXximmwOwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:49:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E7118611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 935A9306EE1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499533DECB;
	Tue, 10 Feb 2026 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="hXwJH3As"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DDA2857F1;
	Tue, 10 Feb 2026 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713190; cv=none; b=HX9pPdFGOtj+kDhMKjg3WKHYS0lv1VSgi5PYanwL6Smly1u4F3k5Vpq/F/3LBv34FhO4LRg5MAcjOIlbDXWxREiMrRRU4FCm1m+DNpjXHf8tq05Dw7Mv7KmEBNOFm+QH6SsiDCgtra3JcKTfcA8xY3zX5yyA9BdgxWj74AJ7xFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713190; c=relaxed/simple;
	bh=thEj7m81zXaFkuH8PMc/UfoL5Qw2HhqcWZT10qucOYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SqpGxpcUis+nkpvjvRIIPkqJ03y6Wx5vbe59daKOnxk0owwhU1JnZMhCuOvK+bldm5svX64PUI16eBu3wKWjPsNrFORmmFnAvA4Uf+kNsICWIMDicjanaw2xnTM2AqNhmcvDJpvp6ndrvISD1JJlumKsngaZqiusRWdRu8Gt/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=hXwJH3As; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from fedora.fritz.box (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id BED38E05EB;
	Tue, 10 Feb 2026 09:46:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1770713180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4P5Rx+c3QyJ6fROuBa6MvqRG4jtnnEBOUbCvXMfpDk=;
	b=hXwJH3AsUbWH3+LadTkcFUUE7ZF0DF3Y5+5V9Ge4Y5pCQmfhNLdYA3+3JHJdzxcnm29xYf
	l8KQj4l9ShzKnbX+sQJsX39wTL8ULtrya9aLW3bSYSmCCPp+lpWdTOpLn8G/aJamjvaOwS
	2d7JV13GODDl3TUVdoa/djX3ZtTtHmp72bsQcbps86C8wR6YhNC20ZJx3Xipco1DOAzcUn
	XJ2OwbNAPC+Xk64h5oSghM1KMjClv7QN7IIUP4C0u9AWR3VfkfSyoACEYjoiOaIIjSj38F
	gawId1PHjn0lPmEQuwCpG9InwZi1kvXEEeuVQkmbE+pNLEEA21Zd4ahVBF88IA==
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Tue, 10 Feb 2026 09:46:17 +0100
Subject: [PATCH v5 2/3] fuse: create helper functions for filling in fuse
 args for open and getattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-fuse-compounds-upstream-v5-2-ea0585f62daa@ddn.com>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
In-Reply-To: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770713177; l=4228;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=pMlEWlzZop3CWtcz586lgLhHwSNGfNcjXvt2p/x52L4=;
 b=d2Zz5T428GTTqNXniY15TQm3TG6lOMwjjp9azKbNHVF4Q2IBr8Iyx/fdiXgpb2i3LkR3aAzHk
 YmKfsIi0AlOBs3p9nJhpyCw2ktova3TVosUHM2aWNqljUoHLNSwKSZw
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[birthelmer.com,none];
	R_DKIM_ALLOW(-0.20)[birthelmer.com:s=uddkim-202310];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[szeredi.hu,ddn.com,gmail.com,igalia.com];
	TAGGED_FROM(0.00)[bounces-76823-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[birthelmer.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birthelmer.com:dkim,ddn.com:mid,ddn.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E04E7118611
X-Rspamd-Action: no action

From: Horst Birthelmer <hbirthelmer@ddn.com>

create fuse_getattr_args_fill() and fuse_open_args_fill() to fill in
the parameters for the open and getattr calls.

This is in preparation for implementing open+getattr and does not
represent any functional change.

Suggested-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/dir.c    | 26 ++++++++++++++++++--------
 fs/fuse/file.c   | 26 ++++++++++++++++++--------
 fs/fuse/fuse_i.h |  6 ++++++
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff225dc389016017753b09fadff9d1..33fa5fc97ff7f65db585ee1386156ef13cf330cf 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1472,6 +1472,23 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	return 0;
 }
 
+/*
+ * Helper function to initialize fuse_args for GETATTR operations
+ */
+void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
+			     struct fuse_getattr_in *inarg,
+			     struct fuse_attr_out *outarg)
+{
+	args->opcode = FUSE_GETATTR;
+	args->nodeid = nodeid;
+	args->in_numargs = 1;
+	args->in_args[0].size = sizeof(*inarg);
+	args->in_args[0].value = inarg;
+	args->out_numargs = 1;
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
+}
+
 static int fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
 			   struct kstat *stat, struct file *file)
 {
@@ -1493,14 +1510,7 @@ static int fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
 		inarg.getattr_flags |= FUSE_GETATTR_FH;
 		inarg.fh = ff->fh;
 	}
-	args.opcode = FUSE_GETATTR;
-	args.nodeid = get_node_id(inode);
-	args.in_numargs = 1;
-	args.in_args[0].size = sizeof(inarg);
-	args.in_args[0].value = &inarg;
-	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(outarg);
-	args.out_args[0].value = &outarg;
+	fuse_getattr_args_fill(&args, get_node_id(inode), &inarg, &outarg);
 	err = fuse_simple_request(fm, &args);
 	if (!err) {
 		if (fuse_invalid_attr(&outarg.attr) ||
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3b2a171e652f0c9dd1c9e37253d3d3e88caab148..a408a9668abbb361e2c1e386ebab9dfcb0a7a573 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -23,6 +23,23 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/iomap.h>
 
+/*
+ * Helper function to initialize fuse_args for OPEN/OPENDIR operations
+ */
+static void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
+			 struct fuse_open_in *inarg, struct fuse_open_out *outarg)
+{
+	args->opcode = opcode;
+	args->nodeid = nodeid;
+	args->in_numargs = 1;
+	args->in_args[0].size = sizeof(*inarg);
+	args->in_args[0].value = inarg;
+	args->out_numargs = 1;
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
+}
+
+
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
 			  struct fuse_open_out *outargp)
@@ -40,14 +57,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
 	}
 
-	args.opcode = opcode;
-	args.nodeid = nodeid;
-	args.in_numargs = 1;
-	args.in_args[0].size = sizeof(inarg);
-	args.in_args[0].value = &inarg;
-	args.out_numargs = 1;
-	args.out_args[0].size = sizeof(*outargp);
-	args.out_args[0].value = outargp;
+	fuse_open_args_fill(&args, nodeid, opcode, &inarg, outargp);
 
 	return fuse_simple_request(fm, &args);
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9ebcd96b6b309d75c86a9c716cbd88aaa55c57ef..fba14f26b67888831fcba6e2ac73399f3c95d5ad 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1179,6 +1179,12 @@ struct fuse_io_args {
 void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 			 size_t count, int opcode);
 
+/*
+ * Helper functions to initialize fuse_args for common operations
+ */
+void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
+			    struct fuse_getattr_in *inarg,
+			    struct fuse_attr_out *outarg);
 
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);

-- 
2.53.0


