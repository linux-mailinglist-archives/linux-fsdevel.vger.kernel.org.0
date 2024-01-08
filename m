Return-Path: <linux-fsdevel+bounces-7539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BF4826D76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949F128372E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C783640C07;
	Mon,  8 Jan 2024 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z7OPTZJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686540BE9
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DDC373F5AA
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715808;
	bh=Qlcho8chuufL9JmbPqtNzk4zs+rMss6COIQOi9IfnOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=Z7OPTZJqsSTCPqB11nkcuok0NL+getiF4kfHK53/PNFHn4Uv6aemMR2Mi8FRhBfce
	 OLeTmwjJvMdHJhOSD72VFNp7V5nSJGjB55xuSydr/h2o/reKMPLRVhzB4oTh1TbWhX
	 4xipx579TV4Pz8xvrVbGynKilJd/fqS3Erh+2EoylL417h74enGWvTvgHbxm4l9+tF
	 25pR/2l3JjaPAsxJ/fQH2W08XaKs7IBQfQ7VJQniQf48hg9hgufNKQbukv23+Um4mL
	 E9DTG1mmSEyejnSCJlgdRJSDVkwLX65eGa4BoydvwG6o4xG5h1v6wfFPfgobN1CoKy
	 kp8IKWpUGrfSg==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2cce9d6ec6bso14439191fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 04:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715808; x=1705320608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qlcho8chuufL9JmbPqtNzk4zs+rMss6COIQOi9IfnOw=;
        b=aoCmKQtsvHfNPCYHpI+rAbSkaLhUpPrfBXlG+BY8WqPkzriaypAmS8VrQDo9hYZDW7
         YSFbNGLcJJi1yjbcR+fCB8aR66pWQXvnLUAT195jFx3mn3IpzBDWqCiuK6+MfCZ2LFUK
         QXcnhApH38+lyUFiqPnZptKjx0Tu5NbcKRo/qC6wzvpjSt0EyTscanNYCNDn5qzctOvb
         J9b4DvfZunvza0uqseDoKB4xzXyCNPCJrDdjufTAU0a+JmuUZjNZIMkPIJc1KPTmmPHu
         NiBxLZ6lPJTscKtnT2R0dffOiYYAEZ0wKGSj7fnziqGVUn7mIgY8Du94ne8XZfGesuCG
         bOmw==
X-Gm-Message-State: AOJu0YzoEAsx3E/CRww3GY5OGRnlE6jkNsqGjYu1GhRUqZ7UDUYUUsxn
	OPy0VkPdhdeDSC7msZw3DgHtAL9GFBpEisHcssYUlgb/sjSR8B8wfZ1n3YfRYtqw6wD8wfax9EK
	VY2/3PPMV2Hd5CC2X6NYsDi/32DJq7yrzjSCORFmYNsSL0NW/2w==
X-Received: by 2002:a2e:3005:0:b0:2cc:8545:d6f9 with SMTP id w5-20020a2e3005000000b002cc8545d6f9mr1455627ljw.15.1704715808240;
        Mon, 08 Jan 2024 04:10:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6Cz/42DbzT+orPD/r3QKq1nu0ZTzoybNkUSmzDw8l2XlSCl2Tn0YWn6jBVA8XteZl0oCtPw==
X-Received: by 2002:a2e:3005:0:b0:2cc:8545:d6f9 with SMTP id w5-20020a2e3005000000b002cc8545d6f9mr1455623ljw.15.1704715808045;
        Mon, 08 Jan 2024 04:10:08 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:10:07 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/9] fs/fuse: support idmap for mkdir/mknod/symlink/create
Date: Mon,  8 Jan 2024 13:08:18 +0100
Message-Id: <20240108120824.122178-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have all the infrastructure in place, we just need
to pass an idmapping here.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e78ad4742aef..a0968f086b62 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -633,9 +633,9 @@ static void free_ext_value(struct fuse_args *args)
  * If the filesystem doesn't support this, then fall back to separate
  * 'mknod' + 'open' requests.
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
-			    struct file *file, unsigned int flags,
-			    umode_t mode, u32 opcode)
+static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
+			    struct dentry *entry, struct file *file,
+			    unsigned int flags, umode_t mode, u32 opcode)
 {
 	int err;
 	struct inode *inode;
@@ -690,7 +690,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(outopen);
 	args.out_args[1].value = &outopen;
 
-	err = get_create_ext(&nop_mnt_idmap, &args, dir, entry, mode);
+	err = get_create_ext(idmap, &args, dir, entry, mode);
 	if (err)
 		goto out_put_forget_req;
 
@@ -749,6 +749,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			    umode_t mode)
 {
 	int err;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct dentry *res = NULL;
 
@@ -773,7 +774,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
+	err = fuse_create_open(idmap, dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -784,7 +785,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return err;
 
 mknod:
-	err = fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
+	err = fuse_mknod(idmap, dir, entry, mode, 0);
 	if (err)
 		goto out_dput;
 no_open:
@@ -794,9 +795,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 /*
  * Code shared between mknod, mkdir, symlink and link
  */
-static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
-			    struct inode *dir, struct dentry *entry,
-			    umode_t mode)
+static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
+			    struct fuse_args *args, struct inode *dir,
+			    struct dentry *entry, umode_t mode)
 {
 	struct fuse_entry_out outarg;
 	struct inode *inode;
@@ -818,7 +819,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(&nop_mnt_idmap, args, dir, entry, mode);
+		err = get_create_ext(idmap, args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
@@ -884,13 +885,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fm, &args, dir, entry, mode);
+	return create_new_entry(idmap, fm, &args, dir, entry, mode);
 }
 
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *entry, umode_t mode, bool excl)
 {
-	return fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
+	return fuse_mknod(idmap, dir, entry, mode, 0);
 }
 
 static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
@@ -902,7 +903,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (fc->no_tmpfile)
 		return -EOPNOTSUPP;
 
-	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	err = fuse_create_open(idmap, dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
 		fc->no_tmpfile = 1;
 		err = -EOPNOTSUPP;
@@ -929,7 +930,7 @@ static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
 }
 
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
@@ -945,7 +946,7 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = entry->d_name.name;
 	args.in_args[1].size = len;
 	args.in_args[1].value = link;
-	return create_new_entry(fm, &args, dir, entry, S_IFLNK);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
 }
 
 void fuse_flush_time_update(struct inode *inode)
@@ -1139,7 +1140,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode);
+	err = create_new_entry(&nop_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
 	if (!err)
 		fuse_update_ctime_in_cache(inode);
 	else if (err == -EINTR)
-- 
2.34.1


