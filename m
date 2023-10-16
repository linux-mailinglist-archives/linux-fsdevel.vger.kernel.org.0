Return-Path: <linux-fsdevel+bounces-434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D87CAE88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFC9B21016
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4557C30D05;
	Mon, 16 Oct 2023 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/1Q19xK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2630CE4
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:30 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E6EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4060b623e64so29482135e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472567; x=1698077367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbFQuHgrUmh+25seCzXFp+eZYiAQQf5C4eqUwMYkbAY=;
        b=e/1Q19xK6jAW8RmGx3IxmvsGaOoGl8nJ48mSMKiy7NcDOla+XYshxP0kgzGgZAe0A0
         MyGOdRgEBCrr5+d1TTAArBGMn+SNJcSKz3xakekVxTE4Ux3X6wJKockkHyxnFubIE5fa
         NIyLYMskH+cZiFcn39KJO46VLOTZiUDw/25uzh4lWCBl31jfMygAeTva3SDO29F1cOfv
         qH9ogt2g42XoTRILpNCq35VOe5DKVqI2OYA4xPo4o5ObphIiQ9Cex/mcgu0TBH7VqDDB
         A1EMhflmZEaRx36Z4BrRgJ90rI56HREvBwiT+HoegpoZwtWEZ4z1yljoWg51eqccq95e
         D1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472567; x=1698077367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbFQuHgrUmh+25seCzXFp+eZYiAQQf5C4eqUwMYkbAY=;
        b=n1T2b5XDBhoQyW6PBaqGnxykKUam5iTuyQRvYxXVib+FwE4AabeWaOWm5UwJBglipd
         Xc2+D+2BLlbK3H6IW60cUa8FO0Jgi6sMPzw2V1eg9OnFVKH1IwTW34nvlR0kOdyqh4rn
         OV9BkgaZDdR5Ntk+uZUCLh5mwGjeoJeb8i9eLWQsjRCmNkMb1/ydckEXulApxG21U4Yy
         Zk1LYgs51aYlNXs7Qy9iF8PxBowlncSP4WO82Phhv5BV4xpamAqsVmkYBCuWpaFdv2ux
         DXuol3mgsb5Xvcw+foRQUMhm9/4pa45N/EWazh8Tsox+HvLslyYy7lJkGKDoNsslkABW
         mjAg==
X-Gm-Message-State: AOJu0Yy4l7EXJrp9z56YwQ+/6gxFCVPKoco2E+15pBWfe2LS0zwoijaa
	M9c+/WmtTxV80lW7gJjqeEc=
X-Google-Smtp-Source: AGHT+IF9Y1vMn5PIQjkX+j5qeywVWpRd6BtOyAm6w7HkrDOrzHgmoEIHCBFngXjO6r9UPZLhEGslvw==
X-Received: by 2002:a05:600c:4745:b0:407:4701:f9e with SMTP id w5-20020a05600c474500b0040747010f9emr6294801wmo.17.1697472567087;
        Mon, 16 Oct 2023 09:09:27 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:26 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 12/12] fuse: implement passthrough for readdir
Date: Mon, 16 Oct 2023 19:09:02 +0300
Message-Id: <20231016160902.2316986-13-amir73il@gmail.com>
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

Same as for regular file read, when dir is open with FOPEN_PASSTHROUGH,
passthrough readdir to backing directory.

FOPEN_CACHE_DIR is ignored with passthrough readdir and it does not
populated children inode cache as READDIRPLUS does.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c        |  3 +++
 fs/fuse/fuse_i.h      |  1 +
 fs/fuse/passthrough.c | 25 ++++++++++++++++++++++++-
 fs/fuse/readdir.c     | 12 +++++++++++-
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bae1137426a9..a8ebd25765c6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -148,6 +148,9 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 			ff->fh = outargp->fh;
 			ff->open_flags = outargp->open_flags;
 
+			/* Readdir cache not used for passthrough */
+			if (ff->open_flags & FOPEN_PASSTHROUGH)
+				ff->open_flags &= ~FOPEN_CACHE_DIR;
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
 			return ERR_PTR(err);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6fee4c33678f..822226fe96bf 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1404,5 +1404,6 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 				      struct file *out, loff_t *ppos,
 				      size_t len, unsigned int flags);
 ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
+int fuse_passthrough_readdir(struct file *file, struct dir_context *ctx);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index a05280ceba83..828f26597b16 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -164,6 +164,28 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
 	return backing_file_mmap(backing_file, vma, &ctx);
 }
 
+int fuse_passthrough_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct fuse_file *ff = file->private_data;
+	struct inode *inode = file_inode(file);
+	struct file *backing_file = fuse_file_passthrough(ff);
+	const struct cred *old_cred;
+	bool locked;
+	int ret;
+
+	pr_debug("%s: backing_file=0x%p, pos=%lld\n", __func__,
+		 backing_file, ctx->pos);
+
+	locked = fuse_lock_inode(inode);
+	old_cred = override_creds(ff->cred);
+	ret = iterate_dir(backing_file, ctx);
+	revert_creds(old_cred);
+	fuse_file_accessed(file);
+	fuse_unlock_inode(inode, locked);
+
+	return ret;
+}
+
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
 	if (fb && refcount_inc_not_zero(&fb->count))
@@ -257,7 +279,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 		goto out;
 
 	res = -EOPNOTSUPP;
-	if (!file->f_op->read_iter || !file->f_op->write_iter)
+	if (!file->f_op->iterate_shared &&
+	    !(file->f_op->read_iter && file->f_op->write_iter))
 		goto out_fput;
 
 	backing_sb = file_inode(file)->i_sb;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 9e6d587b3e67..e59c072ca29c 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -327,7 +327,7 @@ static int parse_dirplusfile(char *buf, size_t nbytes, struct file *file,
 	return 0;
 }
 
-static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
+static int fuse_do_readdir(struct file *file, struct dir_context *ctx)
 {
 	int plus;
 	ssize_t res;
@@ -581,6 +581,16 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	return res == FOUND_SOME ? 0 : UNCACHED;
 }
 
+static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
+{
+	struct fuse_file *ff = file->private_data;
+
+	if (fuse_file_passthrough(ff))
+		return fuse_passthrough_readdir(file, ctx);
+	else
+		return fuse_do_readdir(file, ctx);
+}
+
 int fuse_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct fuse_file *ff = file->private_data;
-- 
2.34.1


