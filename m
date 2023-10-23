Return-Path: <linux-fsdevel+bounces-947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36D57D3E95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE682816C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E721362;
	Mon, 23 Oct 2023 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNW1aEBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A5A21357
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:08:13 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB11B4;
	Mon, 23 Oct 2023 11:08:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4084095722aso29380475e9.1;
        Mon, 23 Oct 2023 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698084490; x=1698689290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6xNZqtlO55OmTeQ1GA6gz7PMKPyVg1IpYME77qHA9U=;
        b=BNW1aEBUdSBrS5O+I5LKwVquImSZNLyfagjafCz78F9++vwjMG42kMbJnbakfOibEF
         5+8f7KUcpep4Ch9PQzf31bimsEKAx/7pDpK6GZRTxlh+9+k7jXr0invoMDbwbPxLHTA8
         HgCbAqnDY7t8S0HQYFrTlbkAkXdrfTZs2JYfTyVP/QBzIjYzCJ1/um4xzXK35a4eccXo
         EQOpNQZgZv+hnGZpkadnBlxaLaAW5cQQppsNxkUWxYA2ecbeqpsvc2XjUP1z9opy0mdi
         Nt06LPc8YY0cJdpUSeqL9Y1pvysWu1h45hahOIM8lTsTn6AYEkh4nGu9EpWgSNQagSFa
         eT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084490; x=1698689290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6xNZqtlO55OmTeQ1GA6gz7PMKPyVg1IpYME77qHA9U=;
        b=KYPcozWbUAaYpJ8Swb94Lz8FjCy9MlLaQIRI+Whn3gT+MUEzHyo0JZq6Vj32klFskm
         R+ZZ7xoatmQm8iVZjlkJvqFg7S/uGZIvQwWWVkwGjgW7OA0AaqNCIjB0a9pf8aAHgtvH
         R1oXE6DlZh7KIvF7bvRFsmgXOFB2JLesUyob9gGYkulRHuQEgXqkfYTNp7+Ye4A2dUAo
         4sJlI9vA7608R6oFMy1cLo7w4ARBkfafTRuP4K1NEn0lpP+9srmKo42jeNRDhTYm7n5+
         a7HZGo31Nun/wiBgJFDH3t9P+AH/MbVjYxdMPahFapinnbsJgow85l99CFj6PPs0KVCP
         8VuQ==
X-Gm-Message-State: AOJu0YyBuGw1fzHSyWbj5RmAVsEqYmVFZbjC2C5sNXopU7umKuFG1mEH
	YPNSULzwPEFEVTbqS5euzwu430WIdG4=
X-Google-Smtp-Source: AGHT+IGR/ninHBzSNGOzHiDRAXeBimTDLLxhg+detyxo222rZDsFu0eFzbPXGSFydTOgIXHTnI6+xw==
X-Received: by 2002:a05:600c:3d87:b0:405:40ec:415d with SMTP id bi7-20020a05600c3d8700b0040540ec415dmr7409911wmb.39.1698084489482;
        Mon, 23 Oct 2023 11:08:09 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id c39-20020a05600c4a2700b0040588d85b3asm14391492wmp.15.2023.10.23.11.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:08:09 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/4] exportfs: add helpers to check if filesystem can encode/decode file handles
Date: Mon, 23 Oct 2023 21:07:58 +0300
Message-Id: <20231023180801.2953446-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023180801.2953446-1-amir73il@gmail.com>
References: <20231023180801.2953446-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic of whether filesystem can encode/decode file handles is open
coded in many places.

In preparation to changing the logic, move the open coded logic into
inline helpers.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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
index 62fe0b679e58..0eb9622e8a9f 100644
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


