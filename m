Return-Path: <linux-fsdevel+bounces-425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEA97CAE7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5331C20A5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FDC30D0A;
	Mon, 16 Oct 2023 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot0iHtWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1B30CE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:16 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA41B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so4228346f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472552; x=1698077352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1GVL753j0kWCcGaDbo+LaxJ3YjkbH9HnSX1kLHwrJg=;
        b=Ot0iHtWfzkEI96ovoiQgiKTLsAtIZArwqSPBZLZ/vMdFIEift+pTtxdEjpg8QfCvmw
         9KO5KrusBEvXre0spHE3yqTuyZmfGMkjeYpNNUa6ITBO1UIe3Q/v8JBpsD+aLx+JjnMr
         Zg5o27kOX01uTk/tia60dlIWglcUO/T7RN65nHbXtq+DnpvrsDBVuotbnssuS7u2j03t
         mIMo6YQplqpB/ExODuBKBfOZDqUld6udW4bAjelkf0adbqH1nKXYnbshdsOPDV9+KJOY
         olreYp0+V5cwDHdGLgSYOPn79zM/2sjxKLw9cBpFcdW4QAm2CnU4aqwmjmr1RGtnVYua
         /RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472552; x=1698077352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1GVL753j0kWCcGaDbo+LaxJ3YjkbH9HnSX1kLHwrJg=;
        b=IcetOZv8+ue4xcUPBhVP5cnkjuzO4eZGV/6jOhT7Evpq+xfc4ozixRRNaU+zkcFHHk
         nrleqCvG+jjkuC0k5qtTa7NMLeu6sWRUDlaybBubctNNrPX25QwWOc6skWcIiIqGNPZh
         BlziT/KMZyAQNayQ+X7JMLO4aKlv6IK5sy4CeuPFYhtR0MYWle0oJRF1sOEPed7GQQrw
         GsU+zZwSgh7kTLz381t8T9LdhNSFuWftqoy1w2xIeN/R9giP2ksOgh7N1U55CMNY94ig
         9XUtgswVacTcNcgQLDXcKYj8NKq5Jwj5j92y0DWWjelI+ZFdUR+Cq6pi58yeqzB3XWzv
         g7YQ==
X-Gm-Message-State: AOJu0YxPqF0xR8YR/2e8Y4eRtDA0/hJQC4lzGFzyK0J2t2IIyfYK7c23
	EeNVxGMAClTTVNOB4VYwJqo=
X-Google-Smtp-Source: AGHT+IERILeWeU4Rsr2CfaYqiUrxNwvpC6z8NlxCN14lfIDhqsTT4KRtHIZzMfAMf98KO1tfqb57UQ==
X-Received: by 2002:a05:6000:49:b0:32d:5cc0:2f0c with SMTP id k9-20020a056000004900b0032d5cc02f0cmr15615486wrx.40.1697472552557;
        Mon, 16 Oct 2023 09:09:12 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:12 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 03/12] fs: factor out backing_file_splice_{read,write}() helpers
Date: Mon, 16 Oct 2023 19:08:53 +0300
Message-Id: <20231016160902.2316986-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016160902.2316986-1-amir73il@gmail.com>
References: <20231016160902.2316986-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is not much in those helpers, but it makes sense to have them
logically next to the backing_file_{read,write}_iter() helpers as they
may grow more common logic in the future.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/backing-file.c            | 41 ++++++++++++++++++++++++++++++++++++
 fs/overlayfs/file.c          | 30 ++++++++++++--------------
 include/linux/backing-file.h |  8 +++++++
 3 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 2969ea6295ce..f32dd9012720 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -10,6 +10,7 @@
 
 #include <linux/fs.h>
 #include <linux/backing-file.h>
+#include <linux/splice.h>
 
 #include "internal.h"
 
@@ -238,6 +239,46 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(backing_file_write_iter);
 
+ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
+				 struct pipe_inode_info *pipe, size_t len,
+				 unsigned int flags,
+				 struct backing_file_ctx *ctx)
+{
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	old_cred = override_creds(ctx->cred);
+	ret = vfs_splice_read(in, ppos, pipe, len, flags);
+	revert_creds(old_cred);
+
+	if (ctx->accessed)
+		ctx->accessed(ctx->user_file);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_splice_read);
+
+ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
+				  struct file *out, loff_t *ppos, size_t len,
+				  unsigned int flags,
+				  struct backing_file_ctx *ctx)
+{
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	old_cred = override_creds(ctx->cred);
+	file_start_write(out);
+	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
+	file_end_write(out);
+	revert_creds(old_cred);
+
+	if (ctx->end_write)
+		ctx->end_write(ctx->user_file);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_splice_write);
+
 static int __init backing_aio_init(void)
 {
 	backing_aio_cachep = kmem_cache_create("backing_aio",
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 1376f2d308fe..6a7af440733b 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -9,7 +9,6 @@
 #include <linux/xattr.h>
 #include <linux/uio.h>
 #include <linux/uaccess.h>
-#include <linux/splice.h>
 #include <linux/security.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
@@ -332,20 +331,21 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 			       struct pipe_inode_info *pipe, size_t len,
 			       unsigned int flags)
 {
-	const struct cred *old_cred;
 	struct fd real;
 	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ovl_creds(file_inode(in)->i_sb),
+		.user_file = in,
+		.accessed = ovl_file_accessed,
+	};
 
 	ret = ovl_real_fdget(in, &real);
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(in)->i_sb);
-	ret = vfs_splice_read(real.file, ppos, pipe, len, flags);
-	revert_creds(old_cred);
-	ovl_file_accessed(in);
-
+	ret = backing_file_splice_read(real.file, ppos, pipe, len, flags, &ctx);
 	fdput(real);
+
 	return ret;
 }
 
@@ -361,9 +361,13 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	struct inode *inode = file_inode(out);
 	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ovl_creds(inode->i_sb),
+		.user_file = out,
+		.end_write = ovl_file_modified,
+	};
 
 	inode_lock(inode);
 	/* Update mode */
@@ -376,15 +380,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	if (ret)
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(inode->i_sb);
-	file_start_write(real.file);
-
-	ret = iter_file_splice_write(pipe, real.file, ppos, len, flags);
-
-	file_end_write(real.file);
-	/* Update size */
-	ovl_file_modified(out);
-	revert_creds(old_cred);
+	ret = backing_file_splice_write(pipe, real.file, ppos, len, flags, &ctx);
 	fdput(real);
 
 out_unlock:
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 0648d548a418..0546d5b1c9f5 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -28,5 +28,13 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 				struct kiocb *iocb, int flags,
 				struct backing_file_ctx *ctx);
+ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
+				 struct pipe_inode_info *pipe, size_t len,
+				 unsigned int flags,
+				 struct backing_file_ctx *ctx);
+ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
+				  struct file *out, loff_t *ppos, size_t len,
+				  unsigned int flags,
+				  struct backing_file_ctx *ctx);
 
 #endif /* _LINUX_BACKING_FILE_H */
-- 
2.34.1


