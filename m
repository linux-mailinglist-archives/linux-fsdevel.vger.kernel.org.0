Return-Path: <linux-fsdevel+bounces-600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F717CD8BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5701B213D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8F318C0D;
	Wed, 18 Oct 2023 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM9rKn0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA118B00
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 10:00:11 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A4AF7;
	Wed, 18 Oct 2023 03:00:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405361bb94eso71527805e9.0;
        Wed, 18 Oct 2023 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697623209; x=1698228009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYD+wgC503kgQ3p5MDhETIjO1ikl1uHN/Qh1ZpMvt48=;
        b=WM9rKn0souknudtDZASndqY2y3os/DxQq1IthOmIOzmotC2fOg7KqOZy/O/u7kL8wS
         59lTC41zZecL+EySrg2PSGZKyRSrSaFhHifjXBG5ojp6ob4Xi0Gg1q6+Sb53ukq3BnXs
         uu5EYCOKDcahbSAZSDXk7H6vt8z+DyWQINh2T76fb00cVBqjMfmN4L/9JszXgRoDp7eo
         B1UxVQ8I5lNaQjPksBWZxROPbIkxEESv7h5lpsQbcRsiDbyULJG4k9VV6TYA+2xIxCnl
         HIlekKqR/gKfCRD5KZf79qUEN/ZvvFWeMfeB+SIvUMTzIpHnuIUxEsgmkTI8RAM/K21s
         j64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697623209; x=1698228009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYD+wgC503kgQ3p5MDhETIjO1ikl1uHN/Qh1ZpMvt48=;
        b=l3WO8XdL6L8R9NpICgcVIS3CQBlnnC0Y46Naw6gXdbg2/a32taDKmbbUQNkNSE61G8
         Wc5FKOh9WSUaDmk1WszDNggkTrwbO75uTo8OGSFJoO7WpUHkykK8pK5L+RIpkot6bmRq
         qqGDWKlma5L7bvNpTHPfZcK1Db+sdchInrzRvsOKq5dxoC2o+II73ePzCqD2TrRSUgeC
         e0D4HkYOKIqjJkf+gofbaKUPl2dG/TstFlFIFitQDWKBI0j4eGluF0xZE20I4B8IK1vi
         xRbHH7vFuMN/REA5xOWT7ksx+hT/lOUjCKeSOjqRKjFW3QzBu7L4j2XJlMU4Ux78Za7P
         mNAQ==
X-Gm-Message-State: AOJu0Yx8+qOZ82qfWqgsaKcCfqZvzQSwSAw7YEZgGM3caqRW10iUAxX+
	vNaGFVVxwdlDUacpEDHcif8=
X-Google-Smtp-Source: AGHT+IGYCqCltyFIiCLKUIMDb2fa3mqH0MHEoGRiioyP/M10nwKZ7u5dZ8opR4dmIvF6Xr7jzf+D/Q==
X-Received: by 2002:a05:600c:1c88:b0:407:5a7d:45a8 with SMTP id k8-20020a05600c1c8800b004075a7d45a8mr3856101wms.31.1697623208368;
        Wed, 18 Oct 2023 03:00:08 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id y34-20020a05600c342200b004063977eccesm1222017wmp.42.2023.10.18.03.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:00:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] exportfs: add helpers to check if filesystem can encode/decode file handles
Date: Wed, 18 Oct 2023 12:59:57 +0300
Message-Id: <20231018100000.2453965-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018100000.2453965-1-amir73il@gmail.com>
References: <20231018100000.2453965-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The logic of whether filesystem can encode/decode file handles is open
coded in many places.

In preparation to changing the logic, move the open coded logic into
inline helpers.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/exportfs/expfs.c                |  8 ++------
 fs/fhandle.c                       |  6 +-----
 fs/nfsd/export.c                   |  3 +--
 fs/notify/fanotify/fanotify_user.c |  4 ++--
 fs/overlayfs/util.c                |  2 +-
 include/linux/exportfs.h           | 27 +++++++++++++++++++++++++++
 6 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index c20704aa21b3..9ee205df8fa7 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -396,11 +396,7 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 {
 	const struct export_operations *nop = inode->i_sb->s_export_op;
 
-	/*
-	 * If a decodeable file handle was requested, we need to make sure that
-	 * filesystem can decode file handles.
-	 */
-	if (nop && !(flags & EXPORT_FH_FID) && !nop->fh_to_dentry)
+	if (!exportfs_can_encode_fh(nop, flags))
 		return -EOPNOTSUPP;
 
 	if (nop && nop->encode_fh)
@@ -456,7 +452,7 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 	/*
 	 * Try to get any dentry for the given file handle from the filesystem.
 	 */
-	if (!nop || !nop->fh_to_dentry)
+	if (!exportfs_can_decode_fh(nop))
 		return ERR_PTR(-ESTALE);
 	result = nop->fh_to_dentry(mnt->mnt_sb, fid, fh_len, fileid_type);
 	if (IS_ERR_OR_NULL(result))
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 6ea8d35a9382..18b3ba8dc8ea 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -26,12 +26,8 @@ static long do_sys_name_to_handle(const struct path *path,
 	/*
 	 * We need to make sure whether the file system support decoding of
 	 * the file handle if decodeable file handle was requested.
-	 * Otherwise, even empty export_operations are sufficient to opt-in
-	 * to encoding FIDs.
 	 */
-	if (!path->dentry->d_sb->s_export_op ||
-	    (!(fh_flags & EXPORT_FH_FID) &&
-	     !path->dentry->d_sb->s_export_op->fh_to_dentry))
+	if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh_flags))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 11a0eaa2f914..dc99dfc1d411 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -421,8 +421,7 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
 		return -EINVAL;
 	}
 
-	if (!inode->i_sb->s_export_op ||
-	    !inode->i_sb->s_export_op->fh_to_dentry) {
+	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
 		dprintk("exp_export: export of invalid fs type.\n");
 		return -EINVAL;
 	}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 537c70beaad0..ce926eb9feea 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1595,7 +1595,7 @@ static int fanotify_test_fid(struct dentry *dentry, unsigned int flags)
 	 * file handles so user can use name_to_handle_at() to compare fids
 	 * reported with events to the file handle of watched objects.
 	 */
-	if (!nop)
+	if (!exportfs_can_encode_fid(nop))
 		return -EOPNOTSUPP;
 
 	/*
@@ -1603,7 +1603,7 @@ static int fanotify_test_fid(struct dentry *dentry, unsigned int flags)
 	 * supports decoding file handles, so user has a way to map back the
 	 * reported fids to filesystem objects.
 	 */
-	if (mark_type != FAN_MARK_INODE && !nop->fh_to_dentry)
+	if (mark_type != FAN_MARK_INODE && !exportfs_can_decode_fh(nop))
 		return -EOPNOTSUPP;
 
 	return 0;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 89e0d60d35b6..f0a712214ec2 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -55,7 +55,7 @@ int ovl_can_decode_fh(struct super_block *sb)
 	if (!capable(CAP_DAC_READ_SEARCH))
 		return 0;
 
-	if (!sb->s_export_op || !sb->s_export_op->fh_to_dentry)
+	if (!exportfs_can_decode_fh(sb->s_export_op))
 		return 0;
 
 	return sb->s_export_op->encode_fh ? -1 : FILEID_INO32_GEN;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 11fbd0ee1370..5b3c9f30b422 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -233,6 +233,33 @@ extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
 			      int *max_len, int flags);
 
+static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
+{
+	return nop;
+}
+
+static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
+{
+	return nop && nop->fh_to_dentry;
+}
+
+static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
+					  int fh_flags)
+{
+	/*
+	 * If a non-decodeable file handle was requested, we only need to make
+	 * sure that filesystem can encode file handles.
+	 */
+	if (fh_flags & EXPORT_FH_FID)
+		return exportfs_can_encode_fid(nop);
+
+	/*
+	 * If a decodeable file handle was requested, we need to make sure that
+	 * filesystem can also decode file handles.
+	 */
+	return exportfs_can_decode_fh(nop);
+}
+
 static inline int exportfs_encode_fid(struct inode *inode, struct fid *fid,
 				      int *max_len)
 {
-- 
2.34.1


