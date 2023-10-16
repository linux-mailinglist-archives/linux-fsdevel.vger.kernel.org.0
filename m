Return-Path: <linux-fsdevel+bounces-431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B36A7CAE84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9872813E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F39230FA2;
	Mon, 16 Oct 2023 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqzDWtzJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCA330F8C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:25 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF43FEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4066692ad35so48331495e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472562; x=1698077362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJDe5WLVvsZ63N6ErbmeHHbZBCu1KT4kjg2Vfp3lFYg=;
        b=KqzDWtzJks59aNggaZivzDflRRQV14pIZL37INgsL2OI6YvulZOvxxYR74tIuaQLBX
         LsR8XWJ+LluWI6uwxnCmsAZVzQDO2AyA6p4WBtW4ivqaZdKEzU1wDNBCPF1iJSw0SJfb
         VtT2NynpCa3zBkuN/onsaSPK5ummYFU8KYHLVXsMy4gk8+s3m5fG4Mo+cf94w8zO/QOT
         ysXzqU5LmFHr7jf7b4FhTzGA9khlxgSQkl/vFgJXg3ypqNzGmPfVfVFBcYivWj5TorWp
         RH9dUcypXNcHzdKxmuGtRj/+EqH6+787RV4Sl5hzAYLKI0DisuxwD11jXnuH2BGB4BzW
         d1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472562; x=1698077362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJDe5WLVvsZ63N6ErbmeHHbZBCu1KT4kjg2Vfp3lFYg=;
        b=Vx3NqVsyvf1W7s//oWtHKXf8XJele9TyrurzXe3GN4CdFrZJ3yp6iASOXZxA+B9jq3
         2JBFgdPh33JDtoOgu0spmbnT8wCoASbse9BEnA+XbMHMrnXvPtHnwhPEW3mL8HwTSMdB
         bYf166e0l+EXXZFoM9Rr1asRFTE8f49NIyqZrAAOiOHt4EuGG7a8W+pRCKIIdXHFgo8h
         E/ioklb8eAI04BPKJNe/K+wcFCmjgXgjDIIHqYtxdr9GncijUzltPMtalDkPKyF9t3eL
         WtXCJ10W/K8bDXO7FFOj1fEsB/orFlWBJf1/9OKbDjcDBoorm+nzH6BkoDMPTJ+Qsc21
         KOcQ==
X-Gm-Message-State: AOJu0YzceX448xyqH8Chnt7fuH5n4LWCZRUa/HL7zEbJDJh2O9Qc7+xL
	gO1Z2PIOi3aFxet2MJZy9bxnfgFchRY=
X-Google-Smtp-Source: AGHT+IG2/rF4RTs63EWbvYXDwc51epsEU3kT3VE2qZnafh4sIbYDlQbmHHXop3PLo3rMJM9NPGM/3A==
X-Received: by 2002:adf:f103:0:b0:32d:9cd3:6a9d with SMTP id r3-20020adff103000000b0032d9cd36a9dmr7845679wro.25.1697472562150;
        Mon, 16 Oct 2023 09:09:22 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:21 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 09/12] fuse: implement read/write passthrough
Date: Mon, 16 Oct 2023 19:08:59 +0300
Message-Id: <20231016160902.2316986-10-amir73il@gmail.com>
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

Use the backing file read/write helpers to implement read/write
passthrough to a backing file.

Similar to update size/mtime at the end of fuse_perform_write(),
we need to bump the attr version when we update the inode size,
so extend the ->end_write() callback to report pos and number of
bytes written.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/backing-file.c            |  8 ++--
 fs/fuse/file.c               |  8 +++-
 fs/fuse/fuse_i.h             |  3 ++
 fs/fuse/passthrough.c        | 86 ++++++++++++++++++++++++++++++++++++
 fs/overlayfs/file.c          |  9 +++-
 include/linux/backing-file.h |  2 +-
 6 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 1601a32e8e6a..133373432b9c 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -57,7 +57,7 @@ struct backing_aio {
 	refcount_t ref;
 	struct kiocb *orig_iocb;
 	/* used for aio completion */
-	void (*end_write)(struct file *);
+	void (*end_write)(struct file *, loff_t, ssize_t);
 	struct work_struct work;
 	long res;
 };
@@ -88,7 +88,7 @@ static void backing_aio_cleanup(struct backing_aio *aio, long res)
 	if (iocb->ki_flags & IOCB_WRITE) {
 		kiocb_end_write(iocb);
 		if (aio->end_write)
-			aio->end_write(orig_iocb->ki_filp);
+			aio->end_write(orig_iocb->ki_filp, iocb->ki_pos, res);
 	}
 
 	orig_iocb->ki_pos = iocb->ki_pos;
@@ -208,7 +208,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
 		file_end_write(file);
 		if (ctx->end_write)
-			ctx->end_write(ctx->user_file);
+			ctx->end_write(iocb->ki_filp, iocb->ki_pos, ret);
 	} else {
 		struct backing_aio *aio;
 
@@ -274,7 +274,7 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	revert_creds(old_cred);
 
 	if (ctx->end_write)
-		ctx->end_write(ctx->user_file);
+		ctx->end_write(ctx->user_file, ppos ? *ppos : 0, ret);
 
 	return ret;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 83a7b16d682d..17964486ba80 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1636,7 +1636,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (fuse_file_passthrough(ff))
+		return fuse_passthrough_read_iter(iocb, to);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_read_iter(iocb, to);
 	else
 		return fuse_direct_read_iter(iocb, to);
@@ -1654,7 +1656,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (fuse_file_passthrough(ff))
+		return fuse_passthrough_write_iter(iocb, from);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_write_iter(iocb, from);
 	else
 		return fuse_direct_write_iter(iocb, from);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cb1e2aadf1dc..0a43dc93e376 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1395,4 +1395,7 @@ static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
 #endif
 }
 
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *iter);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 2c8e68f1c90e..0224f63f8cdf 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -10,6 +10,92 @@
 #include <linux/file.h>
 #include <linux/backing-file.h>
 
+static void fuse_file_start_write(struct file *file, loff_t pos, size_t count)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (inode->i_size < pos + count)
+		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+}
+
+static void fuse_file_end_write(struct file *file, loff_t pos, ssize_t res)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	fuse_write_update_attr(inode, pos, res);
+	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+}
+
+static void fuse_file_accessed(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	struct inode *backing_inode = file_inode(backing_file);
+
+	/* Mimic atime update policy of backing inode, not the actual value */
+	if (!timespec64_equal(&backing_inode->i_atime, &inode->i_atime))
+		fuse_invalidate_atime(inode);
+}
+
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	size_t count = iov_iter_count(iter);
+	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ff->cred,
+		.user_file = file,
+		.accessed = fuse_file_accessed,
+	};
+
+
+	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu\n", __func__,
+		 backing_file, iocb->ki_pos, count);
+
+	if (!count)
+		return 0;
+
+	ret = backing_file_read_iter(backing_file, iter, iocb, iocb->ki_flags,
+				     &ctx);
+
+	return ret;
+}
+
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
+				    struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	size_t count = iov_iter_count(iter);
+	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ff->cred,
+		.user_file = file,
+		.end_write = fuse_file_end_write,
+	};
+
+	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu\n", __func__,
+		 backing_file, iocb->ki_pos, count);
+
+	if (!count)
+		return 0;
+
+	inode_lock(inode);
+	fuse_file_start_write(file, iocb->ki_pos, count);
+	ret = backing_file_write_iter(backing_file, iter, iocb, iocb->ki_flags,
+				      &ctx);
+	inode_unlock(inode);
+
+	return ret;
+}
+
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
 	if (fb && refcount_inc_not_zero(&fb->count))
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 034b8088c408..3659c7f340e5 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -232,6 +232,11 @@ static void ovl_file_modified(struct file *file)
 	ovl_copyattr(file_inode(file));
 }
 
+static void ovl_file_end_write(struct file *file, loff_t pos, ssize_t res)
+{
+	ovl_file_modified(file);
+}
+
 static void ovl_file_accessed(struct file *file)
 {
 	struct inode *inode, *upperinode;
@@ -292,7 +297,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(inode->i_sb),
 		.user_file = file,
-		.end_write = ovl_file_modified,
+		.end_write = ovl_file_end_write,
 	};
 
 	if (!iov_iter_count(iter))
@@ -365,7 +370,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(inode->i_sb),
 		.user_file = out,
-		.end_write = ovl_file_modified,
+		.end_write = ovl_file_end_write,
 	};
 
 	inode_lock(inode);
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 3f1fe1774f1b..98e0b6c30193 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -16,7 +16,7 @@ struct backing_file_ctx {
 	const struct cred *cred;
 	struct file *user_file;
 	void (*accessed)(struct file *);
-	void (*end_write)(struct file *);
+	void (*end_write)(struct file *, loff_t, ssize_t);
 };
 
 struct file *backing_file_open(const struct path *user_path, int flags,
-- 
2.34.1


