Return-Path: <linux-fsdevel+bounces-78601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGtkKSp+oGlgkQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:08:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6BA1ABC81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB6A23140D6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551673EFD0F;
	Thu, 26 Feb 2026 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="rznISr6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB0364955;
	Thu, 26 Feb 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124248; cv=none; b=L2FHKzjCFh3wIoNSe2AmKIjcxgcVNmsyxTkIndeM6ivvjYoMRzwUFnIzPaC38Is0U+NvRKGQ/di/P+sFN0C6/O2GU+LgoffyekFCGzrJFtj2zdA6SvNNnMH83fo2IY2D0sXqwBc1JNGL6xANlVnmesfmehKn7DasuhpyWtT5Fks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124248; c=relaxed/simple;
	bh=Wzo8W6GuKhl9trl7/UuvnQRqTZeOq9FOfR9/Ey+Sf6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUmIop3cLrvq84f0bmOQ1irkTd/ek3tcvsAEAxQXP+/8YpsqKQGrk8ZYO+dJnHihvaa4LgUjll2I7/JtUZhaLIBDIrsbIrnl8j+ai9JmdOIILiAw/zpXZcYuM2N2uPsI4EKY8z6JhROWSrX+kiAvycbHs0XIqrUXJWf8+WUzJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=rznISr6Z; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from fedora.fritz.box (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 4C816E0364;
	Thu, 26 Feb 2026 17:43:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1772124238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUv8gt5mgSFguSaafivJElSBGQrkctKXF01agrTnXwU=;
	b=rznISr6Zinc4+u8jBbEkPV7mkk74xRegmqz+8JD/uYC+JJbOCm8eM1Ttf3ro50qkzfdFKE
	64Bno29lHWMTHdLLsN0kymt5fewhYW5Fwbuo103lKRHq21ZvFRBSL1O7nRwvCBDwRNYtGY
	exmwKO/O5KUlCLTmS/WMy3tUcRbjv0tAVY1RFEzVSHwlLzUaRqvJEXU9SPQKAlJfp/nEoC
	UdQ8ycGzLst7x3o5SOF0H+hq2YKgPNOSTbWXiXcBpL6U1uUZlfgg0nSfDRZJwdtrHxcyyN
	R3q23Jo0oRbTR9e1NTN67P07b+UCZ1UEs66GFfmiWPm898jgnGrT9iAP1auo+g==
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Date: Thu, 26 Feb 2026 17:43:55 +0100
Subject: [PATCH v6 3/3] fuse: add an implementation of open+getattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
In-Reply-To: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772124235; l=5771;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=a/RBWGdWP//IlsEU/HBmKi3NpsJuJaZ2v6GDMv26sQE=;
 b=VwkcEOCotSgofOiok7Lax5jHbZWcNIHNNoHv5zEEmeNUYY1hXUiGUoPxSgfYsnUI0N+HxfFxQ
 RrMyXFLpASSAgCv2fDBoLyeeCqWPEgISCx5/35GTvV+7yUNoO0Y9JL7
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[birthelmer.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[birthelmer.com:s=uddkim-202310];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78601-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[szeredi.hu,ddn.com,gmail.com,igalia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birthelmer.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ddn.com:mid,ddn.com:email,birthelmer.com:dkim]
X-Rspamd-Queue-Id: 3D6BA1ABC81
X-Rspamd-Action: no action

From: Horst Birthelmer <hbirthelmer@ddn.com>

The discussion about compound commands in fuse was
started over an argument to add a new operation that
will open a file and return its attributes in the same operation.

Here is a demonstration of that use case with compound commands.

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
 fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h |   4 +-
 fs/fuse/ioctl.c  |   2 +-
 3 files changed, 99 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a408a9668abbb361e2c1e386ebab9dfcb0a7a573..daa95a640c311fc393241bdf727e00a2bc714f35 100644
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
+	compound = fuse_compound_alloc(fm, 2, FUSE_COMPOUND_SEPARABLE);
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
+	err = fuse_compound_add(compound, &open_args, NULL);
+	if (err)
+		goto out;
+
+	fuse_getattr_args_fill(&getattr_args, nodeid, &getattr_in, outattrp);
+
+	err = fuse_compound_add(compound, &getattr_args, NULL);
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
+	fuse_compound_free(compound);
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
+		if (inode) {
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
index ff8222b66c4f7b04c0671a980237a43871affd0a..40409a4ab016a061eea20afee76c8a7fe9c15adb 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1588,7 +1588,9 @@ void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
 
 /* file.c */
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir);
+								struct inode *inode,
+								unsigned int open_flags,
+								bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
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


