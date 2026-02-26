Return-Path: <linux-fsdevel+bounces-78602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEY2IeaEoGkakgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:37:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 983A81AC93F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83B6932238B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76663426EAC;
	Thu, 26 Feb 2026 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="DWRS2aar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A736B04B;
	Thu, 26 Feb 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124249; cv=none; b=m513UhwYUpAnmr58cXJnibdKsiykYLo1mmpIKEhSWrTg13Z7Q79ECs1HvoQE53F5KWXONamITGmrWj27waEl/73AkdW3Pr+SYHh13pW6g3UmBxX6Ifzo+30jcWBDkczuO7LdaEhptgFYANPdjSeFRHtDBbofBbpj2j6XJO5ePgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124249; c=relaxed/simple;
	bh=0kzc9erjXODarwfpNMQnQ3iZ7a8L3MxgsLdlgnpU7Zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4lX6qdg13DpFafV8Jljsd6j5A0R7q07LA/rz8sEpulEjSPX2oKOqaIajffuhYiaIqZxZZa2wC5Plgrr9rUsNbDLOWqQOR/QK14s5VHjBvFJYw/L8OYO9BtfVxSLMTPi6BsF7hEy7wmXSfoBNz+A4egC11h+elC7LlCzZJyN0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=DWRS2aar; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from fedora.fritz.box (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id BE3BAE0360;
	Thu, 26 Feb 2026 17:43:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1772124238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGydO6FwFqLLphmOSbDH/70Uh6txyr6vYs0h8O6bVb4=;
	b=DWRS2aarxCP7nUIvSpxjjkPMTtrJwZ5L8DydvWWkF0t0luLakoY82ZWQ4HY1teetm4GQCp
	JRN7gKy2fO4c6PBG6QrGJUnY+IuWwfBjz0KZjQUHEcurpoUkhB/3VyhrT48ldmMF8e0agl
	1HddZcdwqtD1CYmauU6G4kHrRsxTw75eNwNDAMp6iO+eGvUZeMGp7HjyhAb/Bnl75ZgGbB
	Y3y6ORHf6ym60vdwk0JvSsvex0CtxyM0vQOSF0psXFMubJ5if6K8nSZEeHgJz/W8afZAS1
	ZByQqJW5NNKqiiDQawZ37Oszy2SBbzuGuEVSIaVhEHE8DmZhh9N9PdIA4seQVQ==
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Thu, 26 Feb 2026 17:43:54 +0100
Subject: [PATCH v6 2/3] fuse: create helper functions for filling in fuse
 args for open and getattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-fuse-compounds-upstream-v6-2-8585c5fcd2fc@ddn.com>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
In-Reply-To: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772124235; l=4228;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=fIrksBFbOfxzwmxEToaZUQ6D6sUY/NeffJ6fTnRgRhQ=;
 b=U7QVwGjdVV5qIwsDoRFOKdclptpzWtGK6qECtVOdXFZde0Vgzi2b95NZoOmTbqIdvlwZessfV
 VwZet4OemXwAQ5xQVEdVkJMx8Pc0SPZK4NwWPjvjGJ6GP4QLal35jT4
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[birthelmer.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[birthelmer.com:s=uddkim-202310];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78602-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[szeredi.hu,ddn.com,gmail.com,igalia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birthelmer.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ddn.com:mid,ddn.com:email,birthelmer.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 983A81AC93F
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
index 3927cb069236e9c52674301831c6d655397f24c5..e5ae033a15e85757a10a38b5e7d03dac86067c2a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1471,6 +1471,23 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
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
@@ -1492,14 +1509,7 @@ static int fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
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
index e46315aa428c9d0e704c62a0b80811172c5ec9c1..ff8222b66c4f7b04c0671a980237a43871affd0a 100644
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


