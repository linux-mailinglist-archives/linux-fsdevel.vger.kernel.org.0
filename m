Return-Path: <linux-fsdevel+bounces-429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9917CAE82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C131B20CE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5CB30F86;
	Mon, 16 Oct 2023 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpnvKiIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AEB30CEF
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:22 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1242CA2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4064867903cso53874985e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472559; x=1698077359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hnUYgEdGUkVPqRIFkEPbmb2FvrGZkoHbYZb+3CVx5Y=;
        b=OpnvKiIsYnp2vHv+wHTEp9cNfjWAtq+9DQrTH+GpglOKvG6bScfXX1ib7Ah/zud3ca
         LrAm1QrF0fcP5MJfmIyqveadK9McHs/IRZkblZsl7ubctP5+oRT0Su8v64tS2Ou3tggO
         vuGhlhWkN7TYe0QO6meAKP7ru1QFvL3GDB+XE1KkeSV3wo+uW56wGqq0xxD7sQwUoWqu
         9ybrfGUHoGDQfNXQ/KTsH8+0Zt08cejniJKzn5jVoqOwspCzgkaXVxWUo/MLAM1W/3CK
         SJF9TNOGd7R9vE0EoEI8LNKEOQ4wEzAssVN+EPusYzpKDl4nBpLHVy/88G7KzJC+pvGY
         OFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472559; x=1698077359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hnUYgEdGUkVPqRIFkEPbmb2FvrGZkoHbYZb+3CVx5Y=;
        b=bQW8l6VdRUsOEBBE89o4MVlsq/B8/bKrsS2xNBGm6cTn78JESzp8+9UJYfoocp9Nsh
         oaadUD7X+NU8cWlMEmln+D5qKNiba1dKVJUGZbRx8kWDsx5uuUtivDZWEcYaogn4MyJO
         RJMf05r4TYfxyU0gID5s6KEGwmeUTbLi+CKRW7nCM4bPJ+D8UoW6zQadS2r+LFKhZlv8
         1a2DASxEI0iPMc5+gaDlV7KRW+T+8rurTyZzWEDuNa/mKtVLXwC00+Gog7cgKwzelRlL
         RPQuP1e1eoshXc+G8fHkmtRch9BlH5RrkWOrxVn2/09uUgC00Crmo8TWyTleLUKLcz3e
         ry/Q==
X-Gm-Message-State: AOJu0YyZQcoN/J21pQ0znUdRBjy0BgHh626iZKCH+Lx0YkuNXWXmtCQy
	H3l4z0Npw9D54FYuIlYPQXc=
X-Google-Smtp-Source: AGHT+IEUsoRdVGfHx2Ktlb9W1++R/z8pX5WUA5zRGTwsGuhzKeG8fQ8JWFj5JLBK4xpZKp7nUintRg==
X-Received: by 2002:a5d:4d12:0:b0:316:efb9:101d with SMTP id z18-20020a5d4d12000000b00316efb9101dmr29475811wrt.25.1697472559076;
        Mon, 16 Oct 2023 09:09:19 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:18 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 07/12] fuse: pass optional backing_id in struct fuse_open_out
Date: Mon, 16 Oct 2023 19:08:57 +0300
Message-Id: <20231016160902.2316986-8-amir73il@gmail.com>
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

propagae fuse_open_out arguments up to fuse_finish_open() with optional
backing_id member.

This will be used for setting up passthrough to backing file on open
reply with FOPEN_PASSTHROUGH flag and on zero backing_id.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/cuse.c            |  3 ++-
 fs/fuse/dir.c             |  2 +-
 fs/fuse/file.c            | 23 +++++++++++++----------
 fs/fuse/fuse_i.h          |  8 +++++---
 fs/fuse/ioctl.c           |  3 ++-
 include/uapi/linux/fuse.h |  2 +-
 6 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 91e89e68177e..050e97976e1f 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -115,6 +115,7 @@ static int cuse_open(struct inode *inode, struct file *file)
 {
 	dev_t devt = inode->i_cdev->dev;
 	struct cuse_conn *cc = NULL, *pos;
+	struct fuse_open_out outarg;
 	int rc;
 
 	/* look up and get the connection */
@@ -135,7 +136,7 @@ static int cuse_open(struct inode *inode, struct file *file)
 	 * Generic permission check is already done against the chrdev
 	 * file, proceed to open.
 	 */
-	rc = fuse_do_open(&cc->fm, 0, file, 0);
+	rc = fuse_do_open(&cc->fm, 0, file, 0, &outarg);
 	if (rc)
 		fuse_conn_put(&cc->fc);
 	return rc;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d707e6987da9..f2adcb30852d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -698,7 +698,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		fuse_sync_release(fi, ff, flags);
 	} else {
 		file->private_data = ff;
-		fuse_finish_open(inode, file);
+		fuse_finish_open(inode, file, &outopen);
 		if (fm->fc->atomic_o_trunc && trunc)
 			truncate_pagecache(inode, 0);
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..b0a6189f7662 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -126,7 +126,8 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 }
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir)
+				 unsigned int open_flags, bool isdir,
+				 struct fuse_open_out *outargp)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
@@ -140,13 +141,12 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	/* Default for no-open */
 	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
 	if (isdir ? !fc->no_opendir : !fc->no_open) {
-		struct fuse_open_out outarg;
 		int err;
 
-		err = fuse_send_open(fm, nodeid, open_flags, opcode, &outarg);
+		err = fuse_send_open(fm, nodeid, open_flags, opcode, outargp);
 		if (!err) {
-			ff->fh = outarg.fh;
-			ff->open_flags = outarg.open_flags;
+			ff->fh = outargp->fh;
+			ff->open_flags = outargp->open_flags;
 
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
@@ -168,9 +168,10 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 }
 
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
-		 bool isdir)
+		 bool isdir, struct fuse_open_out *outargp)
 {
-	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir);
+	struct fuse_file *ff = fuse_file_open(fm, nodeid, file->f_flags, isdir,
+					      outargp);
 
 	if (!IS_ERR(ff))
 		file->private_data = ff;
@@ -194,7 +195,8 @@ static void fuse_link_write_file(struct file *file)
 	spin_unlock(&fi->lock);
 }
 
-void fuse_finish_open(struct inode *inode, struct file *file)
+void fuse_finish_open(struct inode *inode, struct file *file,
+		      struct fuse_open_out *outargp)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -222,6 +224,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_conn *fc = fm->fc;
+	struct fuse_open_out outarg;
 	int err;
 	bool is_wb_truncate = (file->f_flags & O_TRUNC) &&
 			  fc->atomic_o_trunc &&
@@ -249,9 +252,9 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	if (is_wb_truncate || dax_truncate)
 		fuse_set_nowrite(inode);
 
-	err = fuse_do_open(fm, get_node_id(inode), file, isdir);
+	err = fuse_do_open(fm, get_node_id(inode), file, isdir, &outarg);
 	if (!err)
-		fuse_finish_open(inode, file);
+		fuse_finish_open(inode, file, &outarg);
 
 	if (is_wb_truncate || dax_truncate)
 		fuse_release_nowrite(inode);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5be51358542e..233344773d29 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1038,7 +1038,8 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
 
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm);
 void fuse_file_free(struct fuse_file *ff);
-void fuse_finish_open(struct inode *inode, struct file *file);
+void fuse_finish_open(struct inode *inode, struct file *file,
+		      struct fuse_open_out *outargp);
 
 void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 		       unsigned int flags);
@@ -1259,7 +1260,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 			     u64 child_nodeid, struct qstr *name, u32 flags);
 
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
-		 bool isdir);
+		 bool isdir, struct fuse_open_out *outargp);
 
 /**
  * fuse_direct_io() flags
@@ -1351,7 +1352,8 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 /* file.c */
 
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
-				 unsigned int open_flags, bool isdir);
+				 unsigned int open_flags, bool isdir,
+				 struct fuse_open_out *outargp);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 726640fa439e..3aeef75c4df3 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -423,6 +423,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	bool isdir = S_ISDIR(inode->i_mode);
+	struct fuse_open_out outarg;
 
 	if (!fuse_allow_current_process(fm->fc))
 		return ERR_PTR(-EACCES);
@@ -433,7 +434,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) && !isdir)
 		return ERR_PTR(-ENOTTY);
 
-	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
+	return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir, &outarg);
 }
 
 static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index acb42a76f7ff..0e273f372df4 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -766,7 +766,7 @@ struct fuse_create_in {
 struct fuse_open_out {
 	uint64_t	fh;
 	uint32_t	open_flags;
-	uint32_t	padding;
+	int32_t		backing_id;
 };
 
 struct fuse_release_in {
-- 
2.34.1


