Return-Path: <linux-fsdevel+bounces-76824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HW+ABLximmwOwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:49:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF82118618
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FCF33074A8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482E33E35F;
	Tue, 10 Feb 2026 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="rI8B7+yY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E47329E40;
	Tue, 10 Feb 2026 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713191; cv=none; b=u8CHoYQK1cJcF5UguQBnMnsHMfEw2m7w7zgd72Ay5w4yI7LDdUMlMk6zqQ8+80GS7spYU0e6P5ux/r4ioEPxdnUUu2mJ27ePojIT6MsLmxt2f73Y1CQ8+uGF02jeqg6tJhrMSFswzvoGnJyHfhZrAB3HapdaJIZ2arkTgk5Cis8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713191; c=relaxed/simple;
	bh=KG8tijsylarx7CIhbgNevEW7115AEbdRWCKAEmkegyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLfPkczJmnR83izWzlX0hghYdEyBvmG/OdlzPpHKgGwuMW7unwvZgnbDB7ILD3XuiWSv0IfZ3OWEYvHo5QlYsM7ZgHy+adjxd8K4+LKOMhkU14QwNOePB0T/1JkCi2jhtgw89txj/UF4EnKGi/RiFATJBovaWFWfDhYrCUuGaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=rI8B7+yY; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from fedora.fritz.box (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 98B88E05DB;
	Tue, 10 Feb 2026 09:46:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1770713180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DjvIUg1kuDCvHNRWBW3dRsoYRtdIFdkW0a8PofdtL4g=;
	b=rI8B7+yYYbSZ+dLxsRD681BordQ/cFThYg1xc9/4v25H+lgFa8VntcKqI+fQuli3l/j/S7
	l//HRrSv1bh4vbrxH7ENvxWsJH5rLhTyj0o8c9vWE2ZYZJ0e90LVQb79kejMuHYG1zPD8s
	V0lKDRX1HKGxT59gnKzziaTPLXdrUEZKWxj0Eh2dnTZm9DorocTvhQi5DlCo/IbBmh8F1K
	CvJqKtfwfcAkmZbTCDOnG9v95BKc1XEkGuI2S/gElKLC7Hv1fPMQevoKAet8ajE+k+oLnG
	v3PNxib0L5HE1r7JqJjGdKDUwgqWnoibsWhGS/TjUxWQKQs22T94cTnkLp0acw==
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Tue, 10 Feb 2026 09:46:18 +0100
Subject: [PATCH v5 3/3] fuse: add an implementation of open+getattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-fuse-compounds-upstream-v5-3-ea0585f62daa@ddn.com>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
In-Reply-To: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770713177; l=6724;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=ooas0wlSi3drdMEixNU7ad+moqNHFP2UUOOu9XNPpcY=;
 b=86C5G3ut1TZoKps1yzPkyJLBM5mlSnXjTmCfWxYSvLAEt+gElp0B//Aw9QZNXBp32EO7AkeJO
 zt5DGnm2f+VDixlFALn+ASIrjtSdTatzLwctF2qiKxuH2Ip9oZrf0ka
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[birthelmer.com,none];
	R_DKIM_ALLOW(-0.20)[birthelmer.com:s=uddkim-202310];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[szeredi.hu,ddn.com,gmail.com,igalia.com];
	TAGGED_FROM(0.00)[bounces-76824-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 8DF82118618
X-Rspamd-Action: no action

From: Horst Birthelmer <hbirthelmer@ddn.com>

The discussion about compound commands in fuse was
started over an argument to add a new operation that
will open a file and return its attributes in the same operation.

Here is a demonstration of that use case with compound commands.

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h |   7 +++-
 fs/fuse/inode.c  |   6 +++
 fs/fuse/ioctl.c  |   2 +-
 4 files changed, 108 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a408a9668abbb361e2c1e386ebab9dfcb0a7a573..73c6a214b29a11fd6341f704bea140b282bb8355 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -136,8 +136,71 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 	}
 }
 
+static int fuse_compound_open_getattr(struct fuse_mount *fm, u64 nodeid,
+				      struct inode *inode, int flags, int opcode,
+				      struct fuse_file *ff,
+				      struct fuse_attr_out *outattrp,
+				      struct fuse_open_out *outopenp)
+{
+	struct fuse_conn *fc = fm->fc;
+	struct fuse_compound_req *compound;
+	struct fuse_args open_args = {};
+	struct fuse_args getattr_args = {};
+	struct fuse_open_in open_in = {};
+	struct fuse_getattr_in getattr_in = {};
+	int err;
+
+	compound = fuse_compound_alloc(fm, FUSE_COMPOUND_SEPARABLE);
+	if (!compound)
+		return -ENOMEM;
+
+	open_in.flags = flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
+	if (!fm->fc->atomic_o_trunc)
+		open_in.flags &= ~O_TRUNC;
+
+	if (fm->fc->handle_killpriv_v2 &&
+	    (open_in.flags & O_TRUNC) && !capable(CAP_FSETID))
+		open_in.open_flags |= FUSE_OPEN_KILL_SUIDGID;
+
+	fuse_open_args_fill(&open_args, nodeid, opcode, &open_in, outopenp);
+
+	err = fuse_compound_add(compound, &open_args);
+	if (err)
+		goto out;
+
+	fuse_getattr_args_fill(&getattr_args, nodeid, &getattr_in, outattrp);
+
+	err = fuse_compound_add(compound, &getattr_args);
+	if (err)
+		goto out;
+
+	err = fuse_compound_send(compound);
+	if (err)
+		goto out;
+
+	err = fuse_compound_get_error(compound, 0);
+	if (err)
+		goto out;
+
+	ff->fh = outopenp->fh;
+	ff->open_flags = outopenp->open_flags;
+
+	err = fuse_compound_get_error(compound, 1);
+	if (err)
+		goto out;
+
+	fuse_change_attributes(inode, &outattrp->attr, NULL,
+			       ATTR_TIMEOUT(outattrp),
+			       fuse_get_attr_version(fc));
+
+out:
+	kfree(compound);
+	return err;
+}
+
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir)
+				struct inode *inode,
+				unsigned int open_flags, bool isdir)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
@@ -163,23 +226,40 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	if (open) {
 		/* Store outarg for fuse_finish_open() */
 		struct fuse_open_out *outargp = &ff->args->open_outarg;
-		int err;
+		int err = -ENOSYS;
 
-		err = fuse_send_open(fm, nodeid, open_flags, opcode, outargp);
-		if (!err) {
-			ff->fh = outargp->fh;
-			ff->open_flags = outargp->open_flags;
-		} else if (err != -ENOSYS) {
-			fuse_file_free(ff);
-			return ERR_PTR(err);
-		} else {
-			if (isdir) {
+		if (inode && fc->compound_open_getattr) {
+			struct fuse_attr_out attr_outarg;
+
+			err = fuse_compound_open_getattr(fm, nodeid, inode,
+							 open_flags, opcode, ff,
+							 &attr_outarg, outargp);
+		}
+
+		if (err == -ENOSYS) {
+			err = fuse_send_open(fm, nodeid, open_flags, opcode,
+					     outargp);
+			if (!err) {
+				ff->fh = outargp->fh;
+				ff->open_flags = outargp->open_flags;
+			}
+		}
+
+		if (err) {
+			if (err != -ENOSYS) {
+				/* err is not ENOSYS */
+				fuse_file_free(ff);
+				return ERR_PTR(err);
+			} else {
 				/* No release needed */
 				kfree(ff->args);
 				ff->args = NULL;
-				fc->no_opendir = 1;
-			} else {
-				fc->no_open = 1;
+
+				/* we don't have open */
+				if (isdir)
+					fc->no_opendir = 1;
+				else
+					fc->no_open = 1;
 			}
 		}
 	}
@@ -195,11 +275,10 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir)
 {
-	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
+	struct fuse_file *ff = fuse_file_open(fm, nodeid, file_inode(file), file->f_flags, isdir);
 
 	if (!IS_ERR(ff))
 		file->private_data = ff;
-
 	return PTR_ERR_OR_ZERO(ff);
 }
 EXPORT_SYMBOL_GPL(fuse_do_open);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fba14f26b67888831fcba6e2ac73399f3c95d5ad..3184ef864cf0b7b8598251dbb9c814d772c04026 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -924,6 +924,9 @@ struct fuse_conn {
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
+	/* Does the filesystem support compound operations? */
+	unsigned int compound_open_getattr:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
@@ -1560,7 +1563,9 @@ void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
 
 /* file.c */
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir);
+								struct inode *inode,
+								unsigned int open_flags,
+								bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 819e50d666224a6201cfc7f450e0bd37bfe32810..a5fd721be96d2cb1f22d58d7451165d1b33f5a5a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -991,6 +991,12 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->blocked = 0;
 	fc->initialized = 0;
 	fc->connected = 1;
+
+	/* pretend fuse server supports compound operations
+	 * until it tells us otherwise.
+	 */
+	fc->compound_open_getattr = 1;
+
 	atomic64_set(&fc->attr_version, 1);
 	atomic64_set(&fc->evict_ctr, 1);
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fdc175e93f74743eb4d2e5a4bc688df1c62e64c4..07a02e47b2c3a68633d213675a8cc380a0cf31d8 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -494,7 +494,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) && !isdir)
 		return ERR_PTR(-ENOTTY);
 
-	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
+	return fuse_file_open(fm, get_node_id(inode), NULL, O_RDONLY, isdir);
 }
 
 static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)

-- 
2.53.0


