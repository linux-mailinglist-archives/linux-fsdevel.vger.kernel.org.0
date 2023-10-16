Return-Path: <linux-fsdevel+bounces-426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A167CAE7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8071C20AD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696130D0D;
	Mon, 16 Oct 2023 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGqj1h/w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8292130D06
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:18 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741DAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40572aeb673so46196785e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472554; x=1698077354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUb7jMt3+90fOvXmi3BU9GENaGJW8LhkaaNhVF50Qy4=;
        b=bGqj1h/wBFsqUoP2rI8iVNdEAVpTTp3GpJZw79l6TbTI1MWKqWw0Jx10Y0r5nK2wa8
         y1D55GVHGJTEiDZLuLAB6wEBP5Bbx6SX5QLyckOV9SDq6bi4xFsrXPGqMQrbOlRdpu48
         pz4VvIyd/d/5WYIQKW0Wo3R+YUxbeou70IZ04BrhJHdULuBM+jBnDmSSp/5v9Kfc4QkZ
         tqi9V1e8Ra96v2RWI+YzRRw7S2jmQeyUsL9lalJuluiM/yNKJA4u9WE6n9pSKdh6P+JS
         Gru20nwC8wHUnxkt2jKy66HSkV+2377oeRiCR5mXfiKj8e9AnHgh1qASA5bJIaBUnRbJ
         y1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472554; x=1698077354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUb7jMt3+90fOvXmi3BU9GENaGJW8LhkaaNhVF50Qy4=;
        b=UBBbjIq6vOltTg2VJGPI4v4WvdlnOg9Tk2eVfiLZ9ZHToAPkNftHxKqERnxxzRTwmM
         QaWquR4M4rDVBA/noX2MmhBlFl1VIkmqG0Ie2RvoPwZat86DeQHqyZJcRUmLzFVKurOb
         7p22wd7aC3FDKlwO/DrzcXHVdMx5WS61+rgxikfbk/KyTol2b1SOwL+ET+gYQuk6vXz1
         GVY0KxksyGrcG63Wt/57OLpd87VBMZKCTDJ+mazbuVpANJDprvNF4NFl1xZ5WSQ8FWNK
         Uxk+gl/WzoYyYdJP1geyt07yV8DEpr9/IKITt9WKrb3DagHWFvRtzD0WVAk0O+ajyKx1
         hHbA==
X-Gm-Message-State: AOJu0YwG5g3Ew5sf5SBVHq6i+ntr2P3/fCPO+ciEmQ30rOs6ggWHO1zn
	N43rqJRPicxDsLFHgHvdRKw=
X-Google-Smtp-Source: AGHT+IGoPvp5R13iJ4kvLDrWskohRWqEdNQ50X3PuF8UbGTvnASt3KNhLdrAi76yZMES9TsC+6uSaQ==
X-Received: by 2002:a7b:cd85:0:b0:404:7670:90b8 with SMTP id y5-20020a7bcd85000000b00404767090b8mr31145930wmj.27.1697472554259;
        Mon, 16 Oct 2023 09:09:14 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:13 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 04/12] fs: factor out backing_file_mmap() helper
Date: Mon, 16 Oct 2023 19:08:54 +0300
Message-Id: <20231016160902.2316986-5-amir73il@gmail.com>
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

Assert that the file object is allocated in a backing_file container
so that file_user_path() could be used to display the user path and
not the backing file's path in /proc/<pid>/maps.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/backing-file.c            | 27 +++++++++++++++++++++++++++
 fs/overlayfs/file.c          | 23 ++++++-----------------
 include/linux/backing-file.h |  2 ++
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index f32dd9012720..1601a32e8e6a 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/backing-file.h>
 #include <linux/splice.h>
+#include <linux/mm.h>
 
 #include "internal.h"
 
@@ -279,6 +280,32 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 }
 EXPORT_SYMBOL_GPL(backing_file_splice_write);
 
+int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
+		      struct backing_file_ctx *ctx)
+{
+	const struct cred *old_cred;
+	int ret;
+
+	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
+	    WARN_ON_ONCE(ctx->user_file != vma->vm_file))
+		return -EIO;
+
+	if (!file->f_op->mmap)
+		return -ENODEV;
+
+	vma_set_file(vma, file);
+
+	old_cred = override_creds(ctx->cred);
+	ret = call_mmap(vma->vm_file, vma);
+	revert_creds(old_cred);
+
+	if (ctx->accessed)
+		ctx->accessed(ctx->user_file);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_mmap);
+
 static int __init backing_aio_init(void)
 {
 	backing_aio_cachep = kmem_cache_create("backing_aio",
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 6a7af440733b..034b8088c408 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -10,7 +10,6 @@
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
-#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/backing-file.h>
 #include "overlayfs.h"
@@ -418,23 +417,13 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct file *realfile = file->private_data;
-	const struct cred *old_cred;
-	int ret;
-
-	if (!realfile->f_op->mmap)
-		return -ENODEV;
-
-	if (WARN_ON(file != vma->vm_file))
-		return -EIO;
-
-	vma_set_file(vma, realfile);
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
-	ovl_file_accessed(file);
+	struct backing_file_ctx ctx = {
+		.cred = ovl_creds(file_inode(file)->i_sb),
+		.user_file = file,
+		.accessed = ovl_file_accessed,
+	};
 
-	return ret;
+	return backing_file_mmap(realfile, vma, &ctx);
 }
 
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 0546d5b1c9f5..3f1fe1774f1b 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -36,5 +36,7 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 				  struct file *out, loff_t *ppos, size_t len,
 				  unsigned int flags,
 				  struct backing_file_ctx *ctx);
+int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
+		      struct backing_file_ctx *ctx);
 
 #endif /* _LINUX_BACKING_FILE_H */
-- 
2.34.1


