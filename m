Return-Path: <linux-fsdevel+bounces-4651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976B78016B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93B41C20C0A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED43F8EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="B6vkk6T5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EEAD6C
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:38 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5d279bcce64so29651237b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468757; x=1702073557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYkeYf+z98OzU3pSQ70AVwvLkUld8GZ5RFcORDajeOI=;
        b=B6vkk6T5bmj1bYIivbpDyPeF+SJr0LSatZ4A0TMUds5j99QBWW1T/xuuQE4CHIN2Kp
         SozPTzhuHZQVkmVSjAwcgeuSVLVysZCqhwA+d0lwP57k94vu3AwPJG/NLnSfFujJqB5o
         ElaayOdBqvvOQ4qYTV+vc+9u1AgUK1rEP7UqRCqNQiDTOIMaNn8KXAOzvFTyUODS14qr
         pDUCqwLtf1wkfNJW2gFwcdVQQ6rg6Mp6hAj8mvRP/Bo7pCtNhEqdMMJfaTLeLniHkXt0
         AK0kuigsU2MLCvr+irdwifRyDeBGw/PRZXZqKTO2kn9iyAuXKMJYP679P9m9HGW74BKV
         EKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468757; x=1702073557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYkeYf+z98OzU3pSQ70AVwvLkUld8GZ5RFcORDajeOI=;
        b=Ai3ju5dGF46AuLkU2xia+qp+80R7fBB2eP0AfmBpIp4R362R1vNmVfUgZCe/98tDAB
         yD3scZRu3CcGmSxWphR0GTKnqwv7cG5P/XJSpoJgW8qMHVB9fwU2NVrN/kW16VOLA0+4
         MBaGwzPs8yAiu4vy/2kOese6Ud4VmCVZvixo8bbjdlB83+R5oIKr70fAliDN5V83ef8R
         25KSfMVOW0Io3GPncv0YmOKB9xbGBpcS3IY+yQYoc03tpYB0q++zMd+yBa9XhLATgAXi
         BoAplY07iMClAfrtBkjCapybx2VEzTg30zSUfAGXglJmMKXOy5+6Dxq5A+bcIfsnL3uq
         aHHQ==
X-Gm-Message-State: AOJu0Yzff2vmzJtwmZdIqfy2uXxdrJfIyXZ5OK0UyCrGUrnX6nFxyTBl
	OVrE3yXJI8ZIwTDvXhVr3t+GnRTMhFypD5fGU8EphDdf
X-Google-Smtp-Source: AGHT+IEysAuZwXEDSyvO+UfroclnBMf4w9zvcUAteXHwi2BHXrVms7eJxF2xPlOA6fzR4HwAjq+ohw==
X-Received: by 2002:a81:ae57:0:b0:5d7:1941:2c12 with SMTP id g23-20020a81ae57000000b005d719412c12mr209844ywk.63.1701468757411;
        Fri, 01 Dec 2023 14:12:37 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g82-20020a0ddd55000000b005ca265f0c68sm1002173ywe.42.2023.12.01.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 31/46] btrfs: implement the fscrypt extent encryption hooks
Date: Fri,  1 Dec 2023 17:11:28 -0500
Message-ID: <cc77308be0383729f6f3dad770c94a06eabba077.1701468306.git.josef@toxicpanda.com>
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

This patch implements the necessary hooks from fscrypt to support
per-extent encryption.  There's two main entry points

btrfs_fscrypt_load_extent_info
btrfs_fscrypt_save_extent_info

btrfs_fscrypt_load_extent_info gets called when we create the extent
maps from the file extent item at btrfs_get_extent() time.  We read the
extent context, and pass it into fscrypt to create the appropriate
fscrypt_extent_info structure.  This is then used on the bio's to make
sure the encryption is done properly.

btrfs_fscrypt_save_extent_info is used to generate the fscrypt context
from fscrypt and save it into the file extent item when we create a new
file extent item.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/defrag.c    | 10 ++++++++-
 fs/btrfs/file-item.c | 11 +++++++++-
 fs/btrfs/file-item.h |  5 ++++-
 fs/btrfs/file.c      |  9 ++++++++
 fs/btrfs/fscrypt.c   | 49 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fscrypt.h   | 31 ++++++++++++++++++++++++++++
 fs/btrfs/inode.c     | 22 +++++++++++++++++++-
 fs/btrfs/tree-log.c  | 10 +++++++++
 8 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 5244561e2016..f3b7438ddbc7 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -16,6 +16,7 @@
 #include "defrag.h"
 #include "file-item.h"
 #include "super.h"
+#include "fscrypt.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 
@@ -631,9 +632,12 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 	struct btrfs_path path = { 0 };
 	struct extent_map *em;
 	struct btrfs_key key;
+	struct btrfs_fscrypt_ctx ctx;
 	u64 ino = btrfs_ino(inode);
 	int ret;
 
+	ctx.size = 0;
+
 	em = alloc_extent_map();
 	if (!em) {
 		ret = -ENOMEM;
@@ -728,7 +732,7 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 			goto next;
 
 		/* Now this extent covers @start, convert it to em */
-		btrfs_extent_item_to_extent_map(inode, &path, fi, em);
+		btrfs_extent_item_to_extent_map(inode, &path, fi, em, &ctx);
 		break;
 next:
 		ret = btrfs_next_item(root, &path);
@@ -738,6 +742,10 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 			goto not_found;
 	}
 	btrfs_release_path(&path);
+
+	ret = btrfs_fscrypt_load_extent_info(inode, em, &ctx);
+	if (ret)
+		goto err;
 	return em;
 
 not_found:
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 26f35c1baedc..35036fab58c4 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -21,6 +21,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "super.h"
+#include "fscrypt.h"
 
 #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
 				   sizeof(struct btrfs_item) * 2) / \
@@ -1264,7 +1265,8 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
-				     struct extent_map *em)
+				     struct extent_map *em,
+				     struct btrfs_fscrypt_ctx *ctx)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
@@ -1306,6 +1308,13 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
 		}
 		em->encryption_type = btrfs_file_extent_encryption(leaf, fi);
+		if (em->encryption_type != BTRFS_ENCRYPTION_NONE) {
+			ctx->size =
+				btrfs_file_extent_encryption_ctx_size(leaf, fi);
+			read_extent_buffer(leaf, ctx->ctx,
+				btrfs_file_extent_encryption_ctx_offset(fi),
+				ctx->size);
+		}
 	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
 		em->block_start = EXTENT_MAP_INLINE;
 		em->start = extent_start;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 04bd2d34efb1..bb79014024bd 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -5,6 +5,8 @@
 
 #include "accessors.h"
 
+struct btrfs_fscrypt_ctx;
+
 #define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
 		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
 
@@ -63,7 +65,8 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
-				     struct extent_map *em);
+				     struct extent_map *em,
+				     struct btrfs_fscrypt_ctx *ctx);
 int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 					u64 len);
 int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start, u64 len);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 87d07d7985ec..30d509259922 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -38,6 +38,7 @@
 #include "ioctl.h"
 #include "file.h"
 #include "super.h"
+#include "fscrypt.h"
 
 /* simple helper to fault in pages and copy.  This should go away
  * and be replaced with calls into generic code.
@@ -2276,6 +2277,14 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_file_extent_num_bytes(leaf, extent, replace_len);
 	if (extent_info->is_new_extent)
 		btrfs_set_file_extent_generation(leaf, extent, trans->transid);
+	if (extent_info->fscrypt_info) {
+		ret = btrfs_fscrypt_save_extent_info(inode, path,
+						     extent_info->fscrypt_info);
+		if (ret) {
+			btrfs_release_path(path);
+			return ret;
+		}
+	}
 	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 2d037b105b5f..7a7272cb83ec 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -214,7 +214,56 @@ static struct block_device **btrfs_fscrypt_get_devices(struct super_block *sb,
 	return devs;
 }
 
+int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
+				   struct extent_map *em,
+				   struct btrfs_fscrypt_ctx *ctx)
+{
+	struct fscrypt_extent_info *info;
+	unsigned long nofs_flag;
+
+	if (ctx->size == 0)
+		return 0;
+
+	nofs_flag = memalloc_nofs_save();
+	info = fscrypt_load_extent_info(&inode->vfs_inode, ctx->ctx, ctx->size);
+	memalloc_nofs_restore(nofs_flag);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+	em->fscrypt_info = info;
+	return 0;
+}
+
+int btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
+				   struct btrfs_path *path,
+				   struct fscrypt_extent_info *info)
+{
+	struct btrfs_file_extent_item *ei;
+	u8 ctx[BTRFS_MAX_EXTENT_CTX_SIZE];
+	ssize_t ctx_size;
+
+	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_extent_item);
+
+	ctx_size = fscrypt_set_extent_context(&inode->vfs_inode, info, ctx);
+	if (ctx_size < 0) {
+		btrfs_err_rl(inode->root->fs_info, "invalid encrypt context\n");
+		return (int)ctx_size;
+	}
+	write_extent_buffer(path->nodes[0], ctx,
+			    btrfs_file_extent_encryption_ctx_offset(ei),
+			    ctx_size);
+	btrfs_set_file_extent_encryption_ctx_size(path->nodes[0], ei, ctx_size);
+	return 0;
+}
+
+size_t btrfs_fscrypt_extent_context_size(struct btrfs_inode *inode)
+{
+	return sizeof(struct btrfs_encryption_info) +
+		fscrypt_extent_context_size(&inode->vfs_inode);
+}
+
 const struct fscrypt_operations btrfs_fscrypt_ops = {
+	.has_per_extent_encryption = 1,
 	.get_context = btrfs_fscrypt_get_context,
 	.set_context = btrfs_fscrypt_set_context,
 	.empty_dir = btrfs_fscrypt_empty_dir,
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index c08fd52c99b4..2882a4a9d978 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -8,6 +8,11 @@
 
 #include "fs.h"
 
+struct btrfs_fscrypt_ctx {
+	u8 ctx[BTRFS_MAX_EXTENT_CTX_SIZE];
+	size_t size;
+};
+
 #ifdef CONFIG_FS_ENCRYPTION
 int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
 				struct btrfs_dir_item *di,
@@ -16,8 +21,29 @@ int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
 bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
 			      struct extent_buffer *leaf,
 			      unsigned long de_name, u32 de_name_len);
+int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
+				   struct extent_map *em,
+				   struct btrfs_fscrypt_ctx *ctx);
+int btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
+				   struct btrfs_path *path,
+				   struct fscrypt_extent_info *fi);
+size_t btrfs_fscrypt_extent_context_size(struct btrfs_inode *inode);
 
 #else
+static inline int btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
+						 struct btrfs_path *path,
+						 struct fscrypt_extent_info *fi)
+{
+	return 0;
+}
+
+static inline int btrfs_fscrypt_load_extent_info(struct btrfs_inode *inode,
+						 struct extent_map *em,
+						 struct btrfs_fscrypt_ctx *ctx)
+{
+	return 0;
+}
+
 static inline int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
 					      struct btrfs_dir_item *di,
 					      struct fscrypt_str *qstr)
@@ -35,6 +61,11 @@ static inline bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
 	return !memcmp_extent_buffer(leaf, fname->disk_name.name, de_name,
 				     de_name_len);
 }
+
+static inline size_t btrfs_fscrypt_extent_context_size(struct btrfs_inode *inode)
+{
+	return 0;
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 231d9fe6ff8a..dc24f11016d9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2918,6 +2918,9 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	size_t fscrypt_context_size = 0;
 	int ret;
 
+	if (btrfs_stack_file_extent_encryption(stack_fi))
+		fscrypt_context_size = btrfs_fscrypt_extent_context_size(inode);
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -2956,6 +2959,12 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 			btrfs_item_ptr_offset(leaf, path->slots[0]),
 			sizeof(struct btrfs_file_extent_item));
 
+	if (fscrypt_context_size) {
+		ret = btrfs_fscrypt_save_extent_info(inode, path, fscrypt_info);
+		if (ret)
+			goto out;
+	}
+
 	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
@@ -6889,6 +6898,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	struct btrfs_key found_key;
 	struct extent_map *em = NULL;
 	struct extent_map_tree *em_tree = &inode->extent_tree;
+	struct btrfs_fscrypt_ctx ctx;
 
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
@@ -6902,6 +6912,9 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		else
 			goto out;
 	}
+
+	ctx.size = 0;
+
 	em = alloc_extent_map();
 	if (!em) {
 		ret = -ENOMEM;
@@ -7006,7 +7019,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto insert;
 	}
 
-	btrfs_extent_item_to_extent_map(inode, path, item, em);
+	btrfs_extent_item_to_extent_map(inode, path, item, em, &ctx);
 
 	if (extent_type == BTRFS_FILE_EXTENT_REG ||
 	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
@@ -7051,6 +7064,10 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto out;
 	}
 
+	ret = btrfs_fscrypt_load_extent_info(inode, em, &ctx);
+	if (ret)
+		goto out;
+
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
 	write_unlock(&em_tree->lock);
@@ -9749,6 +9766,9 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 		return trans;
 	}
 
+	if (fscrypt_info)
+		fscrypt_context_size = btrfs_fscrypt_extent_context_size(inode);
+
 	extent_info.disk_offset = start;
 	extent_info.disk_len = len;
 	extent_info.data_offset = 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 36cbc4d176c5..53c2c58d0002 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -30,6 +30,7 @@
 #include "file.h"
 #include "orphan.h"
 #include "tree-checker.h"
+#include "fscrypt.h"
 
 #define MAX_CONFLICT_INODES 10
 
@@ -4630,6 +4631,9 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	size_t fscrypt_context_size = 0;
 	u8 encryption = em->encryption_type;
 
+	if (encryption)
+		fscrypt_context_size = btrfs_fscrypt_extent_context_size(inode);
+
 	btrfs_set_stack_file_extent_generation(&fi, trans->transid);
 	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_PREALLOC);
@@ -4690,6 +4694,12 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	write_extent_buffer(leaf, &fi,
 			    btrfs_item_ptr_offset(leaf, path->slots[0]),
 			    sizeof(fi));
+	if (fscrypt_context_size) {
+		ret = btrfs_fscrypt_save_extent_info(inode, path,
+						     em->fscrypt_info);
+		if (ret)
+			return ret;
+	}
 	btrfs_mark_buffer_dirty(trans, leaf);
 
 	btrfs_release_path(path);
-- 
2.41.0


