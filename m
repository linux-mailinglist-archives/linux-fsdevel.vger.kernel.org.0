Return-Path: <linux-fsdevel+bounces-4632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B0801687
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C35A1C20AE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD093F8CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZM+UGWoy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C6DD6C
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:12 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5d3efc071e2so15433387b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468731; x=1702073531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0tWS38XcnmMR7VGAy0uVnMkYJ45EykUF4R6j1t1BIQ=;
        b=ZM+UGWoyA9aTDt6SGxzSez3f8+sgBYQBVomLEWfcalRIiSQgKEZ0Bya4i7/qewp3Bh
         XYo3xfAJWLyCC4MiN9GH492OHzjDTXecueFgtBntsZ3U8EDr1hJ/P5WifRH2KB0azNbl
         gT+S5PsFnCI5RIBZ6O9SUHNRNKAASqqpGfIos7FB6/dFs0azENE4v9+E8ekizWFQ3UTw
         A0GNv9/bJpO1+Fjxolzy17Uj1Y11hi17DH/nSXRcg7Jwv4wxGG103czc+TAjl1Mca/C6
         YQ4NedcgHolujm3L27GYoucXUWsWAg4uHRKaU9DrE6jvPcVlCd475HIch5Nqu3TWGeTe
         1NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468731; x=1702073531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0tWS38XcnmMR7VGAy0uVnMkYJ45EykUF4R6j1t1BIQ=;
        b=MQRNYPeW2qwuEXTmCC+3QIiMTZdcH34F7Eamaf/3SuNniTm0vfHa+59zlJBYbS4iPo
         7eX3B4wauZghY3jMig+pDFwhntcF7gbKjq2ezVUeTA5gmIl+PN/J0r5OPTqNvbW9MYOX
         rOOEFP5qwUZgfVCmgKAjtERA4FtsBjGjvVNS1+F9CYsnHv3ubUfS2ILdqJvk2sflxhJo
         nVJgfEw+I7kKcZvdkjQ6K4HAQvMtVP4tHs8MNu0kh+KPhuyDYrWV4U6gLHUpk6av6DUp
         6kM+fZ7UE/XheANI/THzdy8JVvw1aE68CCW29kFyR+pAcCiKug3qYKXOpUe+UXMUj5UZ
         iG3A==
X-Gm-Message-State: AOJu0YzVkFDmbpoxTAp85n6aSbokWMfFFM38ISfsgu+eApt8mA4Bih5q
	D5ZOLd5SkqkT3Gmp6Ckkr/EPJQ==
X-Google-Smtp-Source: AGHT+IHwfEvNLPEbU2jtltEpM9fV9zJKCYHiV7gxgUXId0lavqCc6LNACBO7YLgZ1SzpKXad81RQQA==
X-Received: by 2002:a81:af44:0:b0:5d7:1941:2c1f with SMTP id x4-20020a81af44000000b005d719412c1fmr173828ywj.76.1701468731203;
        Fri, 01 Dec 2023 14:12:11 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g187-20020a0dddc4000000b005d3555d7b9fsm1333347ywe.44.2023.12.01.14.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:10 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 12/46] btrfs: add inode encryption contexts
Date: Fri,  1 Dec 2023 17:11:09 -0500
Message-ID: <a8ca3ba1888f9d116be9d7fec921b6f4bfa881d6.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@osandov.com>

In order to store encryption information for directories, symlinks,
etc., fscrypt stores a context item with each encrypted non-regular
inode. fscrypt provides an arbitrary blob for the filesystem to store,
and it does not clearly fit into an existing structure, so this goes in
a new item type.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fscrypt.c              | 117 ++++++++++++++++++++++++++++++++
 fs/btrfs/fscrypt.h              |   2 +
 fs/btrfs/inode.c                |  19 ++++++
 fs/btrfs/ioctl.c                |   8 ++-
 include/uapi/linux/btrfs_tree.h |  10 +++
 5 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 48ab99dfe48d..0e4011d6b1cd 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -1,7 +1,124 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/iversion.h>
 #include "ctree.h"
+#include "accessors.h"
+#include "btrfs_inode.h"
+#include "disk-io.h"
+#include "fs.h"
 #include "fscrypt.h"
+#include "ioctl.h"
+#include "messages.h"
+#include "transaction.h"
+#include "xattr.h"
+
+static int btrfs_fscrypt_get_context(struct inode *inode, void *ctx, size_t len)
+{
+	struct btrfs_key key = {
+		.objectid = btrfs_ino(BTRFS_I(inode)),
+		.type = BTRFS_FSCRYPT_CTX_ITEM_KEY,
+		.offset = 0,
+	};
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	unsigned long ptr;
+	int ret;
+
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(NULL, BTRFS_I(inode)->root, &key, path, 0, 0);
+	if (ret) {
+		len = -ENOENT;
+		goto out;
+	}
+
+	leaf = path->nodes[0];
+	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
+	/* fscrypt provides max context length, but it could be less */
+	len = min_t(size_t, len, btrfs_item_size(leaf, path->slots[0]));
+	read_extent_buffer(leaf, ctx, ptr, len);
+
+out:
+	btrfs_free_path(path);
+	return len;
+}
+
+static int btrfs_fscrypt_set_context(struct inode *inode, const void *ctx,
+				     size_t len, void *fs_data)
+{
+	struct btrfs_trans_handle *trans = fs_data;
+	struct btrfs_key key = {
+		.objectid = btrfs_ino(BTRFS_I(inode)),
+		.type = BTRFS_FSCRYPT_CTX_ITEM_KEY,
+		.offset = 0,
+	};
+	struct btrfs_path *path = NULL;
+	struct extent_buffer *leaf;
+	unsigned long ptr;
+	int ret;
+
+	if (!trans)
+		trans = btrfs_start_transaction(BTRFS_I(inode)->root, 2);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	ret = btrfs_search_slot(trans, BTRFS_I(inode)->root, &key, path, 0, 1);
+	if (ret < 0)
+		goto out_err;
+
+	if (ret > 0) {
+		btrfs_release_path(path);
+		ret = btrfs_insert_empty_item(trans, BTRFS_I(inode)->root, path, &key, len);
+		if (ret)
+			goto out_err;
+	}
+
+	leaf = path->nodes[0];
+	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
+
+	len = min_t(size_t, len, btrfs_item_size(leaf, path->slots[0]));
+	write_extent_buffer(leaf, ctx, ptr, len);
+	btrfs_mark_buffer_dirty(trans, leaf);
+	btrfs_release_path(path);
+
+	if (fs_data)
+		return ret;
+
+	BTRFS_I(inode)->flags |= BTRFS_INODE_ENCRYPT;
+	btrfs_sync_inode_flags_to_i_flags(inode);
+	inode_inc_iversion(inode);
+	inode_set_ctime_current(inode);
+	ret = btrfs_update_inode(trans, BTRFS_I(inode));
+	if (ret)
+		goto out_abort;
+	btrfs_free_path(path);
+	btrfs_end_transaction(trans);
+	return 0;
+out_abort:
+	btrfs_abort_transaction(trans, ret);
+out_err:
+	if (!fs_data)
+		btrfs_end_transaction(trans);
+	btrfs_free_path(path);
+	return ret;
+}
+
+static bool btrfs_fscrypt_empty_dir(struct inode *inode)
+{
+	return inode->i_size == BTRFS_EMPTY_DIR_SIZE;
+}
 
 const struct fscrypt_operations btrfs_fscrypt_ops = {
+	.get_context = btrfs_fscrypt_get_context,
+	.set_context = btrfs_fscrypt_set_context,
+	.empty_dir = btrfs_fscrypt_empty_dir,
 };
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index 7f4e6888bd43..80adb7e56826 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -5,6 +5,8 @@
 
 #include <linux/fscrypt.h>
 
+#include "fs.h"
+
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
 
 #endif /* BTRFS_FSCRYPT_H */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d58003eb447d..cc52af10a520 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -62,6 +62,7 @@
 #include "defrag.h"
 #include "dir-item.h"
 #include "file-item.h"
+#include "fscrypt.h"
 #include "uuid-tree.h"
 #include "ioctl.h"
 #include "file.h"
@@ -6097,6 +6098,9 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
 	struct inode *inode = args->inode;
 	int ret;
 
+	if (fscrypt_is_nokey_name(args->dentry))
+		return -ENOKEY;
+
 	if (!args->orphan) {
 		ret = fscrypt_setup_filename(dir, &args->dentry->d_name, 0,
 					     &args->fname);
@@ -6132,6 +6136,9 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
 	if (dir->i_security)
 		(*trans_num_items)++;
 #endif
+	/* 1 to add fscrypt item */
+	if (args->encrypt)
+		(*trans_num_items)++;
 	if (args->orphan) {
 		/* 1 to add orphan item */
 		(*trans_num_items)++;
@@ -6317,6 +6324,11 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 	BTRFS_I(inode)->i_otime_sec = ts.tv_sec;
 	BTRFS_I(inode)->i_otime_nsec = ts.tv_nsec;
 
+	if (args->encrypt) {
+		BTRFS_I(inode)->flags |= BTRFS_INODE_ENCRYPT;
+		btrfs_sync_inode_flags_to_i_flags(inode);
+	}
+
 	/*
 	 * We're going to fill the inode item now, so at this point the inode
 	 * must be fully initialized.
@@ -6391,6 +6403,13 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			goto discard;
 		}
 	}
+	if (args->encrypt) {
+		ret = fscrypt_set_context(inode, trans);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto discard;
+		}
+	}
 
 	inode_tree_add(BTRFS_I(inode));
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dfe257e1845b..6acf898f693e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -156,6 +156,8 @@ static unsigned int btrfs_inode_flags_to_fsflags(struct btrfs_inode *binode)
 		iflags |= FS_DIRSYNC_FL;
 	if (flags & BTRFS_INODE_NODATACOW)
 		iflags |= FS_NOCOW_FL;
+	if (flags & BTRFS_INODE_ENCRYPT)
+		iflags |= FS_ENCRYPT_FL;
 	if (ro_flags & BTRFS_INODE_RO_VERITY)
 		iflags |= FS_VERITY_FL;
 
@@ -185,12 +187,14 @@ void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
 		new_fl |= S_NOATIME;
 	if (binode->flags & BTRFS_INODE_DIRSYNC)
 		new_fl |= S_DIRSYNC;
+	if (binode->flags & BTRFS_INODE_ENCRYPT)
+		new_fl |= S_ENCRYPTED;
 	if (binode->ro_flags & BTRFS_INODE_RO_VERITY)
 		new_fl |= S_VERITY;
 
 	set_mask_bits(&inode->i_flags,
 		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC |
-		      S_VERITY, new_fl);
+		      S_VERITY | S_ENCRYPTED, new_fl);
 }
 
 /*
@@ -203,7 +207,7 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
 		      FS_NOATIME_FL | FS_NODUMP_FL | \
 		      FS_SYNC_FL | FS_DIRSYNC_FL | \
 		      FS_NOCOMP_FL | FS_COMPR_FL |
-		      FS_NOCOW_FL))
+		      FS_NOCOW_FL | FS_ENCRYPT_FL))
 		return -EOPNOTSUPP;
 
 	/* COMPR and NOCOMP on new/old are valid */
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index d24e8e121507..08f561da33cd 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -164,6 +164,8 @@
 #define BTRFS_VERITY_DESC_ITEM_KEY	36
 #define BTRFS_VERITY_MERKLE_ITEM_KEY	37
 
+#define BTRFS_FSCRYPT_CTX_ITEM_KEY	41
+
 #define BTRFS_ORPHAN_ITEM_KEY		48
 /* reserve 2-15 close to the inode for later flexibility */
 
@@ -424,6 +426,7 @@ static inline __u8 btrfs_dir_flags_to_ftype(__u8 flags)
 #define BTRFS_INODE_NOATIME		(1U << 9)
 #define BTRFS_INODE_DIRSYNC		(1U << 10)
 #define BTRFS_INODE_COMPRESS		(1U << 11)
+#define BTRFS_INODE_ENCRYPT	(1U << 12)
 
 #define BTRFS_INODE_ROOT_ITEM_INIT	(1U << 31)
 
@@ -440,6 +443,7 @@ static inline __u8 btrfs_dir_flags_to_ftype(__u8 flags)
 	 BTRFS_INODE_NOATIME |						\
 	 BTRFS_INODE_DIRSYNC |						\
 	 BTRFS_INODE_COMPRESS |						\
+	 BTRFS_INODE_ENCRYPT |						\
 	 BTRFS_INODE_ROOT_ITEM_INIT)
 
 #define BTRFS_INODE_RO_VERITY		(1U << 0)
@@ -1069,6 +1073,12 @@ enum {
 	BTRFS_NR_FILE_EXTENT_TYPES = 3,
 };
 
+enum {
+	BTRFS_ENCRYPTION_NONE,
+	BTRFS_ENCRYPTION_FSCRYPT,
+	BTRFS_NR_ENCRYPTION_TYPES,
+};
+
 struct btrfs_file_extent_item {
 	/*
 	 * transaction id that created this extent
-- 
2.41.0


