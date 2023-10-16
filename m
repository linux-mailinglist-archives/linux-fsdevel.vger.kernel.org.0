Return-Path: <linux-fsdevel+bounces-430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D497CAE83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275851F22532
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E430F92;
	Mon, 16 Oct 2023 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlVnupWW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854830CF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:24 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F877E6
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3296b49c546so3868020f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472561; x=1698077361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3c/aYEbNi5QyPBOFKfwFVgd23TeUdsW4f70sJIUoMo=;
        b=nlVnupWWcg186VQlCHa5qUBYppMyJ9sZhddWxmpMW6OVOVLl4kQNwlnaYVZTIIQ1lP
         YQXeZjrqifiESY0+A0zB/ox2vEivQ1H4FIugo6leKLtZHhX66ZeHHxrJs+lagCqp4y/L
         C2tpYFv8QGyFup7OeGmfFRYx7Oo/EVtYEN7VnssNtlXFE4IfbKGahfqIQ2uOIEDUCycT
         TkQcEkJSkgbJKrEA2Fdq9WCMoDfnEtfHlXUcq7KlqzMLIYlr87TuUpr2ufEh6IafF2J9
         OUFGdNnqaOXu2uOpvtN+YxxdgTxDlbiwDoNsryEQAgYrzkKuCjtmWM3fMd+0vVeDctFX
         VMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472561; x=1698077361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3c/aYEbNi5QyPBOFKfwFVgd23TeUdsW4f70sJIUoMo=;
        b=eqPopjSudnDqvQBjhZdmLrMsiN7wkEl0oNef7qpp/S5JP66XTZ0CY/Oa2gi3emVF2J
         qCu+azzH0nfzFIwLzmS5DEnCkQ3eG1krHG73bJfKoNhZRPjs9Mmm1LbQzcZqq1eZV2b3
         DXDJJIRWf5W5WiP730qC6Q3RkQk3ysUwoCckf62pLgiPSObyCq7L8Ebqu7UUCpDYTYm1
         5Vc0RUT372zh6dQRwY+mBgXbQHGjwpLBT9WdPvAHQrDDDjw6/q3STkTKgtNYh0Lgs8ny
         Qze9iVa4XasCkTKObAH5Oa9ks3aDp0fnQ9oE4/NUaGmgXanS+3zs85svNlsZhwKKVrpd
         wNPw==
X-Gm-Message-State: AOJu0YxYzv25IULvmYerSB3P9/pMfMLZZ49M1phUxdZNdLTm56Tm4fPZ
	JFjoo2XlVlMhie0NqQOVuSE=
X-Google-Smtp-Source: AGHT+IGfT77iqVViZ5YrmvFt6l2bXPtTE4p4nwRSX5rzdoAbnhSVReGFQmbc3tH2NwPA1OFPj3u2ug==
X-Received: by 2002:a5d:6489:0:b0:32d:a2a3:9533 with SMTP id o9-20020a5d6489000000b0032da2a39533mr8070871wri.59.1697472560655;
        Mon, 16 Oct 2023 09:09:20 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:20 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 08/12] fuse: implement ioctls to manage backing files
Date: Mon, 16 Oct 2023 19:08:58 +0300
Message-Id: <20231016160902.2316986-9-amir73il@gmail.com>
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

FUSE server calls the FUSE_DEV_IOC_BACKING_OPEN ioctl with a backing file
descriptor.  If the call succeeds, a backing file identifier is returned.

A later reply to OPEN request with the flag FOPEN_PASSTHROUGH will setup
passthrough of file operations on the open FUSE file to the backing file
associated with the id.  If there is no backing file associated with id,
FOPEN_PASSTHROUGH flag is ignored.

The FUSE server may call FUSE_DEV_IOC_BACKING_CLOSE ioctl to close the
backing file by its id.
If there is no backing file with that id, -ENOENT is returned.

This can be done at any time, but if an open reply with FOPEN_PASSTHROUGH
flag is still in progress, the open may or may not end up setting up the
passthrough to the backing file.

In any case, the backing file will be kept open by the FUSE driver until
the last fuse_file that was setup to passthrough to that backing file is
closed AND the FUSE_DEV_IOC_BACKING_CLOSE ioctl was called.

Setting up backing files requires a server with CAP_SYS_ADMIN privileges.
For the backing file to be successfully setup, the backing file must
implement both read_iter and write_iter file operations.

The limitation on the level of filesystem stacking allowed for the
backing file is enforced before setting up the backing file.

Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/dev.c             |  41 +++++++++
 fs/fuse/file.c            |   5 ++
 fs/fuse/fuse_i.h          |  34 +++++++
 fs/fuse/inode.c           |   5 ++
 fs/fuse/passthrough.c     | 185 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   9 ++
 6 files changed, 279 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index eba68b57bd7c..b680787bd66d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2283,6 +2283,41 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	return res;
 }
 
+static long fuse_dev_ioctl_backing_open(struct file *file,
+					struct fuse_backing_map __user *argp)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_backing_map map;
+
+	if (!fud)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&map, argp, sizeof(map)))
+		return -EFAULT;
+
+	return fuse_backing_open(fud->fc, &map);
+}
+
+static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+	int backing_id;
+
+	if (!fud)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		return -EOPNOTSUPP;
+
+	if (get_user(backing_id, argp))
+		return -EFAULT;
+
+	return fuse_backing_close(fud->fc, backing_id);
+}
+
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
@@ -2292,6 +2327,12 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_CLONE:
 		return fuse_dev_ioctl_clone(file, argp);
 
+	case FUSE_DEV_IOC_BACKING_OPEN:
+		return fuse_dev_ioctl_backing_open(file, argp);
+
+	case FUSE_DEV_IOC_BACKING_CLOSE:
+		return fuse_dev_ioctl_backing_close(file, argp);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b0a6189f7662..83a7b16d682d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -205,6 +205,8 @@ void fuse_finish_open(struct inode *inode, struct file *file,
 		stream_open(inode, file);
 	else if (ff->open_flags & FOPEN_NONSEEKABLE)
 		nonseekable_open(inode, file);
+	else if (ff->open_flags & FOPEN_PASSTHROUGH)
+		fuse_passthrough_open(file, outargp->backing_id);
 
 	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
 		struct fuse_inode *fi = get_fuse_inode(inode);
@@ -281,6 +283,9 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_release_args *ra = ff->release_args;
 
+	if (fuse_file_passthrough(ff))
+		fuse_passthrough_release(ff);
+
 	/* Inode is NULL on error path of fuse_create_open() */
 	if (likely(fi)) {
 		spin_lock(&fi->lock);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 233344773d29..cb1e2aadf1dc 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -66,6 +66,7 @@ struct fuse_forget_link {
 /** Container for data related to mapping to backing file */
 struct fuse_backing {
 	struct file *file;
+	struct cred *cred;
 
 	/** refcount */
 	refcount_t count;
@@ -238,6 +239,12 @@ struct fuse_file {
 	/** Wait queue head for poll */
 	wait_queue_head_t poll_wait;
 
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	/** Reference to backing file in passthrough mode */
+	struct file *passthrough;
+	const struct cred *cred;
+#endif
+
 	/** Has flock been performed on this file? */
 	bool flock:1;
 };
@@ -867,6 +874,11 @@ struct fuse_conn {
 
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
+
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	/** IDR for backing files ids */
+	struct idr backing_files_map;
+#endif
 };
 
 /*
@@ -1360,5 +1372,27 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 /* passthrough.c */
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
 void fuse_backing_put(struct fuse_backing *fb);
+void fuse_backing_files_init(struct fuse_conn *fc);
+void fuse_backing_files_free(struct fuse_conn *fc);
+int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
+int fuse_backing_close(struct fuse_conn *fc, int backing_id);
+
+void fuse_passthrough_setup(struct file *file, int backing_id);
+void fuse_passthrough_release(struct fuse_file *ff);
+
+static inline void fuse_passthrough_open(struct file *file, int backing_id)
+{
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) && backing_id)
+		fuse_passthrough_setup(file, backing_id);
+}
+
+static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
+{
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	return ff->passthrough;
+#else
+	return NULL;
+#endif
+}
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7e01eb5a04dc..09280bf6e727 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -875,6 +875,9 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
 
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		fuse_backing_files_init(fc);
+
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
 	fm->fc = fc;
@@ -1336,6 +1339,8 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
 void fuse_free_conn(struct fuse_conn *fc)
 {
 	WARN_ON(!list_empty(&fc->devices));
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		fuse_backing_files_free(fc);
 	kfree_rcu(fc, rcu);
 }
 EXPORT_SYMBOL_GPL(fuse_free_conn);
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index e8639c0a9ac6..2c8e68f1c90e 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -8,6 +8,7 @@
 #include "fuse_i.h"
 
 #include <linux/file.h>
+#include <linux/backing-file.h>
 
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
@@ -18,8 +19,11 @@ struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 
 static void fuse_backing_free(struct fuse_backing *fb)
 {
+	pr_debug("%s: fb=0x%p\n", __func__, fb);
+
 	if (fb->file)
 		fput(fb->file);
+	put_cred(fb->cred);
 	kfree_rcu(fb, rcu);
 }
 
@@ -28,3 +32,184 @@ void fuse_backing_put(struct fuse_backing *fb)
 	if (fb && refcount_dec_and_test(&fb->count))
 		fuse_backing_free(fb);
 }
+
+void fuse_backing_files_init(struct fuse_conn *fc)
+{
+	idr_init(&fc->backing_files_map);
+}
+
+static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
+{
+	int id;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&fc->lock);
+	id = idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMIC);
+	spin_unlock(&fc->lock);
+	idr_preload_end();
+
+	WARN_ON_ONCE(id == 0);
+	return id;
+}
+
+static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
+						   int id)
+{
+	struct fuse_backing *fb;
+
+	spin_lock(&fc->lock);
+	fb = idr_remove(&fc->backing_files_map, id);
+	spin_unlock(&fc->lock);
+
+	return fb;
+}
+
+static int fuse_backing_id_free(int id, void *p, void *data)
+{
+	struct fuse_backing *fb = p;
+
+	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
+	fuse_backing_free(fb);
+	return 0;
+}
+
+void fuse_backing_files_free(struct fuse_conn *fc)
+{
+	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
+	idr_destroy(&fc->backing_files_map);
+}
+
+int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
+{
+	struct file *file;
+	struct super_block *backing_sb;
+	struct fuse_backing *fb = NULL;
+	int res;
+
+	pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
+
+	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+	res = -EPERM;
+	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+		goto out;
+
+	res = -EINVAL;
+	if (map->flags)
+		goto out;
+
+	file = fget(map->fd);
+	res = -EBADF;
+	if (!file)
+		goto out;
+
+	res = -EOPNOTSUPP;
+	if (!file->f_op->read_iter || !file->f_op->write_iter)
+		goto out_fput;
+
+	backing_sb = file_inode(file)->i_sb;
+	res = -ELOOP;
+	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
+		goto out_fput;
+
+	fb = kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
+	res = -ENOMEM;
+	if (!fb)
+		goto out_fput;
+
+	fb->file = file;
+	fb->cred = prepare_creds();
+	refcount_set(&fb->count, 1);
+
+	res = fuse_backing_id_alloc(fc, fb);
+	if (res < 0) {
+		fuse_backing_free(fb);
+		fb = NULL;
+	}
+
+out:
+	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
+
+	return res;
+
+out_fput:
+	fput(file);
+	goto out;
+}
+
+int fuse_backing_close(struct fuse_conn *fc, int backing_id)
+{
+	struct fuse_backing *fb = NULL;
+	int err;
+
+	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
+
+	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+	err = -EPERM;
+	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+		goto out;
+
+	err = -EINVAL;
+	if (backing_id <= 0)
+		goto out;
+
+	err = -ENOENT;
+	fb = fuse_backing_id_remove(fc, backing_id);
+	if (!fb)
+		goto out;
+
+	fuse_backing_put(fb);
+	err = 0;
+out:
+	pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
+
+	return err;
+}
+
+/* Setup passthrough to a backing file */
+void fuse_passthrough_setup(struct file *file, int backing_id)
+{
+	struct fuse_file *ff = file->private_data;
+	struct fuse_conn *fc = ff->fm->fc;
+	struct fuse_backing *fb;
+	struct file *backing_file;
+	int err;
+
+	err = -EINVAL;
+	if (backing_id <= 0)
+		goto out;
+
+	rcu_read_lock();
+	fb = idr_find(&fc->backing_files_map, backing_id);
+	fb = fuse_backing_get(fb);
+	rcu_read_unlock();
+
+	err = -ENOENT;
+	if (!fb)
+		goto out;
+
+	/* Allocate backing file per fuse file to store fuse path */
+	backing_file = backing_file_open(&file->f_path, file->f_flags,
+					 &fb->file->f_path, fb->cred);
+	err = PTR_ERR(backing_file);
+	if (IS_ERR(backing_file))
+		goto out;
+
+	err = 0;
+	ff->passthrough = backing_file;
+	ff->cred = get_cred(fb->cred);
+out:
+	pr_debug("%s: backing_id=%d, fb=0x%p, backing_file=0x%p, err=%i\n", __func__,
+		 backing_id, fb, ff->passthrough, err);
+
+	fuse_backing_put(fb);
+	if (!ff->passthrough)
+		ff->open_flags &= ~FOPEN_PASSTHROUGH;
+}
+
+void fuse_passthrough_release(struct fuse_file *ff)
+{
+	fput(ff->passthrough);
+	ff->passthrough = NULL;
+	put_cred(ff->cred);
+	ff->cred = NULL;
+}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 0e273f372df4..eade89f7dc4d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1055,9 +1055,18 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+struct fuse_backing_map {
+	int32_t		fd;
+	uint32_t	flags;
+	uint64_t	padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
+					     struct fuse_backing_map)
+#define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.34.1


