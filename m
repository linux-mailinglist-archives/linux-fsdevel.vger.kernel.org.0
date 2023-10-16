Return-Path: <linux-fsdevel+bounces-424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E427CAE7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BDFB20E49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719D30CFA;
	Mon, 16 Oct 2023 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQkdHUA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200E2377B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:15 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DBC83
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso1707196f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472551; x=1698077351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUJFT7MJP4mP8a0fOtIagKRjzwfNfHB+KwrNV0p9Ti0=;
        b=YQkdHUA1dvMm4KL1vGS0fRyMPeF63XBfCjuT3bK7B/4xGUrlTpN7tTBkDhVQD0bL4K
         KBctR1/UN8cBjxvGKiyK4NHvEx0Y45TXCCuo5eF9uh+D+f2pLLWNkLE6wzFvLkGPafJi
         6I/UnHprolruKn46tddihISLVUsHrlaLwUknYiPB4lCIPyIB1PwkNOLkEqxHJ/cHmaC1
         /QC4oLQsynVZUdKH6K6jAC7e1/nzn3FAykj4HxEaX2HrQFhtDoUhyTvkHRTF0q95ioAo
         TQDOkFrbx84hCqRVeeAfxgi0Sty0TB2fHAiEZQfovI5P3TV+oGqP7+SDvy4RSi+Je4wA
         MI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472551; x=1698077351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUJFT7MJP4mP8a0fOtIagKRjzwfNfHB+KwrNV0p9Ti0=;
        b=YliAoMlK/FxQmKWMpjvtGzWZuZyNwwz2s1lIFeW8k1xmsqvgzWsW5lrWXyj2ZuBL2+
         bXttSNDrbAfzYbYicxQrzJz4kNDZO5vt/C5rR22y5qc1UcaUZYZYfNlp5zCSsiJGmCNr
         lvSXx3KArJl64+ST/MfZCDwY58Pne/0ZnfwWlXSk2m3JuXkx/cvHwEeXVTLWWrDhqVcR
         yMa17vT0plUFuhAv0vYS+Sqv3jWtXdnr4sCDcco1R3H8AEReU6GKqYV3mW5LakvkuHkW
         fhlRoVHeJmq+sKrMLhxxHNYOvnMlmIUGxOj4oOIBX8Yj4wgQYN2yv9Syqfxjte+oLbng
         oldg==
X-Gm-Message-State: AOJu0Yx8lFRXvI7JlYMXHm6JpX0ajXtdpHR/hguRtdeVRsVIeNeVf8cR
	ecCp4AyeoDzMeWyAb47+87c=
X-Google-Smtp-Source: AGHT+IHtLmYaoQClCyjPkAuj9dVGfa7AbM7lRUoi1QoqYgo3ZMNmmsNadBPhNbyR++uHfM08063Xug==
X-Received: by 2002:a5d:6687:0:b0:32d:a243:a30e with SMTP id l7-20020a5d6687000000b0032da243a30emr5960052wru.1.1697472551122;
        Mon, 16 Oct 2023 09:09:11 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:10 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 02/12] fs: factor out backing_file_{read,write}_iter() helpers
Date: Mon, 16 Oct 2023 19:08:52 +0300
Message-Id: <20231016160902.2316986-3-amir73il@gmail.com>
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

Overlayfs submits files io to backing files on other filesystems.
Factor out some common helpers to perform io to backing files, into
fs/backing-file.c.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/r/CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/backing-file.c            | 203 +++++++++++++++++++++++++++++++++++
 fs/overlayfs/file.c          | 187 +++-----------------------------
 fs/overlayfs/overlayfs.h     |   8 +-
 fs/overlayfs/super.c         |  11 +-
 include/linux/backing-file.h |  15 +++
 5 files changed, 240 insertions(+), 184 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 04b33036f709..2969ea6295ce 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -2,6 +2,9 @@
 /*
  * Common helpers for stackable filesystems and backing files.
  *
+ * Forked from fs/overlayfs/file.c.
+ *
+ * Copyright (C) 2017 Red Hat, Inc.
  * Copyright (C) 2023 CTERA Networks.
  */
 
@@ -46,3 +49,203 @@ struct file *backing_file_open(const struct path *user_path, int flags,
 	return f;
 }
 EXPORT_SYMBOL_GPL(backing_file_open);
+
+struct backing_aio {
+	struct kiocb iocb;
+	refcount_t ref;
+	struct kiocb *orig_iocb;
+	/* used for aio completion */
+	void (*end_write)(struct file *);
+	struct work_struct work;
+	long res;
+};
+
+static struct kmem_cache *backing_aio_cachep;
+
+#define BACKING_IOCB_MASK \
+	(IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND)
+
+static rwf_t iocb_to_rw_flags(int flags)
+{
+	return (__force rwf_t)(flags & BACKING_IOCB_MASK);
+}
+
+static void backing_aio_put(struct backing_aio *aio)
+{
+	if (refcount_dec_and_test(&aio->ref)) {
+		fput(aio->iocb.ki_filp);
+		kmem_cache_free(backing_aio_cachep, aio);
+	}
+}
+
+static void backing_aio_cleanup(struct backing_aio *aio, long res)
+{
+	struct kiocb *iocb = &aio->iocb;
+	struct kiocb *orig_iocb = aio->orig_iocb;
+
+	if (iocb->ki_flags & IOCB_WRITE) {
+		kiocb_end_write(iocb);
+		if (aio->end_write)
+			aio->end_write(orig_iocb->ki_filp);
+	}
+
+	orig_iocb->ki_pos = iocb->ki_pos;
+	backing_aio_put(aio);
+}
+
+static void backing_aio_rw_complete(struct kiocb *iocb, long res)
+{
+	struct backing_aio *aio = container_of(iocb, struct backing_aio, iocb);
+	struct kiocb *orig_iocb = aio->orig_iocb;
+
+	backing_aio_cleanup(aio, res);
+	orig_iocb->ki_complete(orig_iocb, res);
+}
+
+static void backing_aio_complete_work(struct work_struct *work)
+{
+	struct backing_aio *aio = container_of(work, struct backing_aio, work);
+
+	backing_aio_rw_complete(&aio->iocb, aio->res);
+}
+
+static void backing_aio_queue_completion(struct kiocb *iocb, long res)
+{
+	struct backing_aio *aio = container_of(iocb, struct backing_aio, iocb);
+
+	/*
+	 * Punt to a work queue to serialize updates of mtime/size.
+	 */
+	aio->res = res;
+	INIT_WORK(&aio->work, backing_aio_complete_work);
+	queue_work(file_inode(aio->orig_iocb->ki_filp)->i_sb->s_dio_done_wq,
+		   &aio->work);
+}
+
+static int backing_aio_init_wq(struct kiocb *iocb)
+{
+	struct super_block *sb = file_inode(iocb->ki_filp)->i_sb;
+
+	if (sb->s_dio_done_wq)
+		return 0;
+
+	return sb_init_dio_done_wq(sb);
+}
+
+
+ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
+			       struct kiocb *iocb, int flags,
+			       struct backing_file_ctx *ctx)
+{
+	struct backing_aio *aio = NULL;
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	if (iocb->ki_flags & IOCB_DIRECT &&
+	    !(file->f_mode & FMODE_CAN_ODIRECT))
+		return -EINVAL;
+
+	old_cred = override_creds(ctx->cred);
+	if (is_sync_kiocb(iocb)) {
+		rwf_t rwf = iocb_to_rw_flags(flags);
+
+		ret = vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
+	} else {
+		ret = -ENOMEM;
+		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
+		if (!aio)
+			goto out;
+
+		aio->orig_iocb = iocb;
+		kiocb_clone(&aio->iocb, iocb, get_file(file));
+		aio->iocb.ki_complete = backing_aio_rw_complete;
+		refcount_set(&aio->ref, 2);
+		ret = vfs_iocb_iter_read(file, &aio->iocb, iter);
+		backing_aio_put(aio);
+		if (ret != -EIOCBQUEUED)
+			backing_aio_cleanup(aio, ret);
+	}
+out:
+	revert_creds(old_cred);
+
+	if (ctx->accessed)
+		ctx->accessed(ctx->user_file);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_read_iter);
+
+ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
+				struct kiocb *iocb, int flags,
+				struct backing_file_ctx *ctx)
+{
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	if (iocb->ki_flags & IOCB_DIRECT &&
+	    !(file->f_mode & FMODE_CAN_ODIRECT))
+		return -EINVAL;
+
+	/*
+	 * Stacked filesystems don't support deferred completions, don't copy
+	 * this property in case it is set by the issuer.
+	 */
+	flags &= ~IOCB_DIO_CALLER_COMP;
+
+	old_cred = override_creds(ctx->cred);
+	if (is_sync_kiocb(iocb)) {
+		rwf_t rwf = iocb_to_rw_flags(flags);
+
+		file_start_write(file);
+		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
+		file_end_write(file);
+		if (ctx->end_write)
+			ctx->end_write(ctx->user_file);
+	} else {
+		struct backing_aio *aio;
+
+		ret = backing_aio_init_wq(iocb);
+		if (ret)
+			goto out;
+
+		ret = -ENOMEM;
+		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
+		if (!aio)
+			goto out;
+
+		aio->orig_iocb = iocb;
+		aio->end_write = ctx->end_write;
+		kiocb_clone(&aio->iocb, iocb, get_file(file));
+		aio->iocb.ki_flags = flags;
+		aio->iocb.ki_complete = backing_aio_queue_completion;
+		refcount_set(&aio->ref, 2);
+		kiocb_start_write(&aio->iocb);
+		ret = vfs_iocb_iter_write(file, &aio->iocb, iter);
+		backing_aio_put(aio);
+		if (ret != -EIOCBQUEUED)
+			backing_aio_cleanup(aio, ret);
+	}
+out:
+	revert_creds(old_cred);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_write_iter);
+
+static int __init backing_aio_init(void)
+{
+	backing_aio_cachep = kmem_cache_create("backing_aio",
+					       sizeof(struct backing_aio),
+					       0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!backing_aio_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
+fs_initcall(backing_aio_init);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 19d4d4768fc7..1376f2d308fe 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -16,19 +16,6 @@
 #include <linux/backing-file.h>
 #include "overlayfs.h"
 
-#include "../internal.h"	/* for sb_init_dio_done_wq */
-
-struct ovl_aio_req {
-	struct kiocb iocb;
-	refcount_t ref;
-	struct kiocb *orig_iocb;
-	/* used for aio completion */
-	struct work_struct work;
-	long res;
-};
-
-static struct kmem_cache *ovl_aio_request_cachep;
-
 static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 {
 	if (realinode != ovl_inode_upper(inode))
@@ -272,83 +259,16 @@ static void ovl_file_accessed(struct file *file)
 	touch_atime(&file->f_path);
 }
 
-#define OVL_IOCB_MASK \
-	(IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND)
-
-static rwf_t iocb_to_rw_flags(int flags)
-{
-	return (__force rwf_t)(flags & OVL_IOCB_MASK);
-}
-
-static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
-{
-	if (refcount_dec_and_test(&aio_req->ref)) {
-		fput(aio_req->iocb.ki_filp);
-		kmem_cache_free(ovl_aio_request_cachep, aio_req);
-	}
-}
-
-static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
-{
-	struct kiocb *iocb = &aio_req->iocb;
-	struct kiocb *orig_iocb = aio_req->orig_iocb;
-
-	if (iocb->ki_flags & IOCB_WRITE) {
-		kiocb_end_write(iocb);
-		ovl_file_modified(orig_iocb->ki_filp);
-	}
-
-	orig_iocb->ki_pos = iocb->ki_pos;
-	ovl_aio_put(aio_req);
-}
-
-static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
-{
-	struct ovl_aio_req *aio_req = container_of(iocb,
-						   struct ovl_aio_req, iocb);
-	struct kiocb *orig_iocb = aio_req->orig_iocb;
-
-	ovl_aio_cleanup_handler(aio_req);
-	orig_iocb->ki_complete(orig_iocb, res);
-}
-
-static void ovl_aio_complete_work(struct work_struct *work)
-{
-	struct ovl_aio_req *aio_req = container_of(work,
-						   struct ovl_aio_req, work);
-
-	ovl_aio_rw_complete(&aio_req->iocb, aio_req->res);
-}
-
-static void ovl_aio_queue_completion(struct kiocb *iocb, long res)
-{
-	struct ovl_aio_req *aio_req = container_of(iocb,
-						   struct ovl_aio_req, iocb);
-	struct kiocb *orig_iocb = aio_req->orig_iocb;
-
-	/*
-	 * Punt to a work queue to serialize updates of mtime/size.
-	 */
-	aio_req->res = res;
-	INIT_WORK(&aio_req->work, ovl_aio_complete_work);
-	queue_work(file_inode(orig_iocb->ki_filp)->i_sb->s_dio_done_wq,
-		   &aio_req->work);
-}
-
-static int ovl_init_aio_done_wq(struct super_block *sb)
-{
-	if (sb->s_dio_done_wq)
-		return 0;
-
-	return sb_init_dio_done_wq(sb);
-}
-
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct fd real;
-	const struct cred *old_cred;
 	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ovl_creds(file_inode(file)->i_sb),
+		.user_file = file,
+		.accessed = ovl_file_accessed,
+	};
 
 	if (!iov_iter_count(iter))
 		return 0;
@@ -357,37 +277,8 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (ret)
 		return ret;
 
-	ret = -EINVAL;
-	if (iocb->ki_flags & IOCB_DIRECT &&
-	    !(real.file->f_mode & FMODE_CAN_ODIRECT))
-		goto out_fdput;
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(iocb->ki_flags);
-
-		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos, rwf);
-	} else {
-		struct ovl_aio_req *aio_req;
-
-		ret = -ENOMEM;
-		aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
-		if (!aio_req)
-			goto out;
-
-		aio_req->orig_iocb = iocb;
-		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
-		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
-		refcount_set(&aio_req->ref, 2);
-		ret = vfs_iocb_iter_read(real.file, &aio_req->iocb, iter);
-		ovl_aio_put(aio_req);
-		if (ret != -EIOCBQUEUED)
-			ovl_aio_cleanup_handler(aio_req);
-	}
-out:
-	revert_creds(old_cred);
-	ovl_file_accessed(file);
-out_fdput:
+	ret = backing_file_read_iter(real.file, iter, iocb, iocb->ki_flags,
+				     &ctx);
 	fdput(real);
 
 	return ret;
@@ -398,9 +289,13 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct fd real;
-	const struct cred *old_cred;
 	ssize_t ret;
 	int ifl = iocb->ki_flags;
+	struct backing_file_ctx ctx = {
+		.cred = ovl_creds(inode->i_sb),
+		.user_file = file,
+		.end_write = ovl_file_modified,
+	};
 
 	if (!iov_iter_count(iter))
 		return 0;
@@ -416,11 +311,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (ret)
 		goto out_unlock;
 
-	ret = -EINVAL;
-	if (iocb->ki_flags & IOCB_DIRECT &&
-	    !(real.file->f_mode & FMODE_CAN_ODIRECT))
-		goto out_fdput;
-
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
 		ifl &= ~(IOCB_DSYNC | IOCB_SYNC);
 
@@ -429,42 +319,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * this property in case it is set by the issuer.
 	 */
 	ifl &= ~IOCB_DIO_CALLER_COMP;
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(ifl);
-
-		file_start_write(real.file);
-		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos, rwf);
-		file_end_write(real.file);
-		/* Update size */
-		ovl_file_modified(file);
-	} else {
-		struct ovl_aio_req *aio_req;
-
-		ret = ovl_init_aio_done_wq(inode->i_sb);
-		if (ret)
-			goto out;
-
-		ret = -ENOMEM;
-		aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
-		if (!aio_req)
-			goto out;
-
-		aio_req->orig_iocb = iocb;
-		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
-		aio_req->iocb.ki_flags = ifl;
-		aio_req->iocb.ki_complete = ovl_aio_queue_completion;
-		refcount_set(&aio_req->ref, 2);
-		kiocb_start_write(&aio_req->iocb);
-		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
-		ovl_aio_put(aio_req);
-		if (ret != -EIOCBQUEUED)
-			ovl_aio_cleanup_handler(aio_req);
-	}
-out:
-	revert_creds(old_cred);
-out_fdput:
+	ret = backing_file_write_iter(real.file, iter, iocb, ifl, &ctx);
 	fdput(real);
 
 out_unlock:
@@ -776,19 +631,3 @@ const struct file_operations ovl_file_operations = {
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
 };
-
-int __init ovl_aio_request_cache_init(void)
-{
-	ovl_aio_request_cachep = kmem_cache_create("ovl_aio_req",
-						   sizeof(struct ovl_aio_req),
-						   0, SLAB_HWCACHE_ALIGN, NULL);
-	if (!ovl_aio_request_cachep)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void ovl_aio_request_cache_destroy(void)
-{
-	kmem_cache_destroy(ovl_aio_request_cachep);
-}
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ca88b2636a57..509a57c85fae 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -417,6 +417,12 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+
+static inline const struct cred *ovl_creds(struct super_block *sb)
+{
+	return OVL_FS(sb)->creator_cred;
+}
+
 int ovl_can_decode_fh(struct super_block *sb);
 struct dentry *ovl_indexdir(struct super_block *sb);
 bool ovl_index_all(struct super_block *sb);
@@ -829,8 +835,6 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 
 /* file.c */
 extern const struct file_operations ovl_file_operations;
-int __init ovl_aio_request_cache_init(void);
-void ovl_aio_request_cache_destroy(void);
 int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa);
 int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *fa);
 int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 1a95ee237fa9..38ad0d3ca973 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1498,14 +1498,10 @@ static int __init ovl_init(void)
 	if (ovl_inode_cachep == NULL)
 		return -ENOMEM;
 
-	err = ovl_aio_request_cache_init();
-	if (!err) {
-		err = register_filesystem(&ovl_fs_type);
-		if (!err)
-			return 0;
+	err = register_filesystem(&ovl_fs_type);
+	if (!err)
+		return 0;
 
-		ovl_aio_request_cache_destroy();
-	}
 	kmem_cache_destroy(ovl_inode_cachep);
 
 	return err;
@@ -1521,7 +1517,6 @@ static void __exit ovl_exit(void)
 	 */
 	rcu_barrier();
 	kmem_cache_destroy(ovl_inode_cachep);
-	ovl_aio_request_cache_destroy();
 }
 
 module_init(ovl_init);
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 55c9e804f780..0648d548a418 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -9,9 +9,24 @@
 #define _LINUX_BACKING_FILE_H
 
 #include <linux/file.h>
+#include <linux/uio.h>
+#include <linux/fs.h>
+
+struct backing_file_ctx {
+	const struct cred *cred;
+	struct file *user_file;
+	void (*accessed)(struct file *);
+	void (*end_write)(struct file *);
+};
 
 struct file *backing_file_open(const struct path *user_path, int flags,
 			       const struct path *real_path,
 			       const struct cred *cred);
+ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
+			       struct kiocb *iocb, int flags,
+			       struct backing_file_ctx *ctx);
+ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
+				struct kiocb *iocb, int flags,
+				struct backing_file_ctx *ctx);
 
 #endif /* _LINUX_BACKING_FILE_H */
-- 
2.34.1


