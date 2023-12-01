Return-Path: <linux-fsdevel+bounces-4634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43826801689
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C4B20E6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8A3F8D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ULVDIzQn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA0110EA
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:14 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-db632fef2dcso894704276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468734; x=1702073534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtjXqMNlaBmyOOL3U1MQOg+Vp+iCizcCPJxYmixAVVo=;
        b=ULVDIzQnm1xISx4qtYwUFqFRvzy/Jc0l5nYH8TsJ9GUZ/vty3mSrLe49vtUr73O+4t
         kB3z5oyYTNudokJDn3SPalpfI4wY+IObZa0nq7hWkwlVoVRlKEzQ8Ttp8MHXxwIWxNYd
         EyRwvnXRA5yhsz6luvfPkbT67WdgBGAxyCBIcVdntS1s6OBRA67DU27Km2j0RIgUulUY
         jW7qRlk6QOvXXV5MbwvwFen2jRmCegyq+BKRb05Z1lCkki/88Xv6pdVyL3hKWyXwi43o
         EeMPGAwp30aDUPAeNtb9/GSO0udUJMpI6LyxJ+5tyQq3Vsvrt8Vlkyed3dnzajQyOLDt
         c3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468734; x=1702073534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtjXqMNlaBmyOOL3U1MQOg+Vp+iCizcCPJxYmixAVVo=;
        b=EU7frDLpc6UnYuR6DIqYJp1C9/qEYzLugshuq1lnxPoV1YKQydCxz6cav/1lyK5VXV
         OxN4DHdwya6zOTKuLIxWm7bnEjDjmFbZ2gCKKqG4eLzcWi45KZjMmjme3e2qfLKTqY9+
         HS25RXbbWT0oNfZ3PQllMFcX1JMQ7YOtaicuQJzdbdeTMbqgsXZ655ip9VSeSr6Wmf71
         Sv2E86KTQdJxQy8iwgW4FE3O3gOUMQxEVEIWvQhBqQ+cLoD3o9rTx55oP426qMh/w9ko
         VngaXzgqTVCGG1pzr7nhBdRlOZBs0q+cJuJqCk7asDFR6S7ZqFeqz3jXlPW90clyh0oC
         KQCw==
X-Gm-Message-State: AOJu0YyWxtAmtyYhNJq6mQGqfq2D/qrTyV5jq8FAgiH/fyyHSXQJvIoc
	7QXDVUtNpBUSdq5k9GJC4ogoOA==
X-Google-Smtp-Source: AGHT+IEZicVEWZ5ULFuSVCPD6sjRbm9yy+a3Ndhr8ZRjYiBZp0rEy5FDTsRc+GzCDmW5SeDAye6tKQ==
X-Received: by 2002:a25:8a91:0:b0:db4:b740:1cb9 with SMTP id h17-20020a258a91000000b00db4b7401cb9mr17766698ybl.16.1701468733585;
        Fri, 01 Dec 2023 14:12:13 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x202-20020a25ced3000000b00daf198ef6fbsm640908ybe.21.2023.12.01.14.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 14/46] btrfs: adapt readdir for encrypted and nokey names
Date: Fri,  1 Dec 2023 17:11:11 -0500
Message-ID: <f09d525c35e5dd1b7d257fd548055129c9777d86.1701468306.git.josef@toxicpanda.com>
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

Deleting an encrypted file must always be permitted, even if the user
does not have the appropriate key. Therefore, for listing an encrypted
directory, so-called 'nokey' names are provided, and these nokey names
must be sufficient to look up and delete the appropriate encrypted
files. See 'struct fscrypt_nokey_name' for more information on the
format of these names.

The first part of supporting nokey names is allowing lookups by nokey
name. Only a few entry points need to support these: deleting a
directory, file, or subvolume -- each of these call
fscrypt_setup_filename() with a '1' argument, indicating that the key is
not required and therefore a nokey name may be provided. If a nokey name
is provided, the fscrypt_name returned by fscrypt_setup_filename() will
not have its disk_name field populated, but will have various other
fields set.

This change alters the relevant codepaths to pass a complete
fscrypt_name anywhere that it might contain a nokey name. When it does
contain a nokey name, the first time the name is successfully matched to
a stored name populates the disk name field of the fscrypt_name,
allowing the caller to use the normal disk name codepaths afterward.
Otherwise, the matching functionality is in close analogue to the
function fscrypt_match_name().

Functions where most callers are providing a fscrypt_str are duplicated
and adapted for a fscrypt_name, and functions where most callers are
providing a fscrypt_name are changed to so require at all callsites.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h   |   2 +-
 fs/btrfs/delayed-inode.c |  29 ++++++-
 fs/btrfs/delayed-inode.h |   6 +-
 fs/btrfs/dir-item.c      |  77 ++++++++++++++++---
 fs/btrfs/dir-item.h      |  11 ++-
 fs/btrfs/extent_io.c     |  38 ++++++++++
 fs/btrfs/extent_io.h     |   3 +
 fs/btrfs/fscrypt.c       |  34 +++++++++
 fs/btrfs/fscrypt.h       |  19 +++++
 fs/btrfs/inode.c         | 158 ++++++++++++++++++++++++++-------------
 fs/btrfs/root-tree.c     |   8 +-
 fs/btrfs/root-tree.h     |   2 +-
 fs/btrfs/tree-log.c      |   3 +-
 13 files changed, 317 insertions(+), 73 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 048eb211b54a..a6a5b3146777 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -430,7 +430,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
 int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_inode *dir, struct btrfs_inode *inode,
-		       const struct fscrypt_str *name);
+		       struct fscrypt_name *name);
 int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
 		   const struct fscrypt_str *name, int add_backref, u64 index);
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 91159dd7355b..0c36a0e06c12 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1765,7 +1765,9 @@ int btrfs_should_delete_dir_index(struct list_head *del_list,
 /*
  * Read dir info stored in the delayed tree.
  */
-int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
+int btrfs_readdir_delayed_dir_index(struct inode *inode,
+				    struct fscrypt_str *fstr,
+				    struct dir_context *ctx,
 				    struct list_head *ins_list)
 {
 	struct btrfs_dir_item *di;
@@ -1775,6 +1777,7 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 	int name_len;
 	int over = 0;
 	unsigned char d_type;
+	size_t fstr_len = fstr->len;
 
 	/*
 	 * Changing the data of the delayed item is impossible. So
@@ -1799,8 +1802,28 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 		d_type = fs_ftype_to_dtype(btrfs_dir_flags_to_ftype(di->type));
 		btrfs_disk_key_to_cpu(&location, &di->location);
 
-		over = !dir_emit(ctx, name, name_len,
-			       location.objectid, d_type);
+		if (di->type & BTRFS_FT_ENCRYPTED) {
+			int ret;
+			struct fscrypt_str iname = FSTR_INIT(name, name_len);
+
+			fstr->len = fstr_len;
+			/*
+			 * The hash is only used when the encryption key is not
+			 * available. But if we have delayed insertions, then we
+			 * must have the encryption key available or we wouldn't
+			 * have been able to create entries in the directory.
+			 * So, we don't calculate the hash.
+			 */
+			ret = fscrypt_fname_disk_to_usr(inode, 0, 0, &iname,
+							fstr);
+			if (ret)
+				return ret;
+			over = !dir_emit(ctx, fstr->name, fstr->len,
+					 location.objectid, d_type);
+		} else {
+			over = !dir_emit(ctx, name, name_len, location.objectid,
+					 d_type);
+		}
 
 		if (refcount_dec_and_test(&curr->refs))
 			kfree(curr);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 5cceb31bbd16..d369f6997df7 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -16,6 +16,8 @@
 #include <linux/refcount.h>
 #include "ctree.h"
 
+struct fscrypt_str;
+
 enum btrfs_delayed_item_type {
 	BTRFS_DELAYED_INSERTION_ITEM,
 	BTRFS_DELAYED_DELETION_ITEM
@@ -155,7 +157,9 @@ void btrfs_readdir_put_delayed_items(struct inode *inode,
 				     struct list_head *del_list);
 int btrfs_should_delete_dir_index(struct list_head *del_list,
 				  u64 index);
-int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
+int btrfs_readdir_delayed_dir_index(struct inode *inode,
+				    struct fscrypt_str *fstr,
+				    struct dir_context *ctx,
 				    struct list_head *ins_list);
 
 /* Used during directory logging. */
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 9c07d5c3e5ad..a64cfddff7f0 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -6,6 +6,7 @@
 #include "messages.h"
 #include "ctree.h"
 #include "disk-io.h"
+#include "fscrypt.h"
 #include "transaction.h"
 #include "accessors.h"
 #include "dir-item.h"
@@ -230,6 +231,47 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	return di;
 }
 
+/*
+ * Lookup for a directory item by fscrypt_name.
+ *
+ * @trans:	The transaction handle to use.
+ * @root:	The root of the target tree.
+ * @path:	Path to use for the search.
+ * @dir:	The inode number (objectid) of the directory.
+ * @name:	The fscrypt_name associated to the directory entry
+ * @mod:	Used to indicate if the tree search is meant for a read only
+ *		lookup or for a deletion lookup, so its value should be 0 or
+ *		-1, respectively.
+ *
+ * Returns: NULL if the dir item does not exists, an error pointer if an error
+ * happened, or a pointer to a dir item if a dir item exists for the given name.
+ */
+struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *trans,
+						   struct btrfs_root *root,
+						   struct btrfs_path *path, u64 dir,
+						   struct fscrypt_name *name, int mod)
+{
+	struct btrfs_key key;
+	struct btrfs_dir_item *di = NULL;
+	int ret = 0;
+
+	key.objectid = dir;
+	key.type = BTRFS_DIR_ITEM_KEY;
+	key.offset = btrfs_name_hash(name->disk_name.name, name->disk_name.len);
+	/* XXX get the right hash for no-key names */
+
+	ret = btrfs_search_slot(trans, root, &key, path, mod, -mod);
+	if (ret == 0)
+		di = btrfs_match_dir_item_fname(root->fs_info, path, name);
+
+	if (ret == -ENOENT || (di && IS_ERR(di) && PTR_ERR(di) == -ENOENT))
+		return NULL;
+	if (ret < 0)
+		di = ERR_PTR(ret);
+
+	return di;
+}
+
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 				   const struct fscrypt_str *name)
 {
@@ -287,9 +329,9 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 }
 
 /*
- * Lookup for a directory index item by name and index number.
+ * Lookup for a directory index item by fscrypt_name and index number.
  *
- * @trans:	The transaction handle to use. Can be NULL if @mod is 0.
+ * @trans:	The transaction handle to use.
  * @root:	The root of the target tree.
  * @path:	Path to use for the search.
  * @dir:	The inode number (objectid) of the directory.
@@ -327,7 +369,7 @@ btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 
 struct btrfs_dir_item *
 btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
-			    u64 dirid, const struct fscrypt_str *name)
+			    u64 dirid, struct fscrypt_name *name)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
@@ -340,9 +382,7 @@ btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_for_each_slot(root, &key, &key, path, ret) {
 		if (key.objectid != dirid || key.type != BTRFS_DIR_INDEX_KEY)
 			break;
-
-		di = btrfs_match_dir_item_name(root->fs_info, path,
-					       name->name, name->len);
+		di = btrfs_match_dir_item_fname(root->fs_info, path, name);
 		if (di)
 			return di;
 	}
@@ -378,9 +418,9 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
  * this walks through all the entries in a dir item and finds one
  * for a specific name.
  */
-struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
-						 struct btrfs_path *path,
-						 const char *name, int name_len)
+struct btrfs_dir_item *btrfs_match_dir_item_fname(struct btrfs_fs_info *fs_info,
+						  struct btrfs_path *path,
+						  struct fscrypt_name *name)
 {
 	struct btrfs_dir_item *dir_item;
 	unsigned long name_ptr;
@@ -399,8 +439,8 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 			btrfs_dir_data_len(leaf, dir_item);
 		name_ptr = (unsigned long)(dir_item + 1);
 
-		if (btrfs_dir_name_len(leaf, dir_item) == name_len &&
-		    memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0)
+		if (btrfs_fscrypt_match_name(name, leaf, name_ptr,
+					     btrfs_dir_name_len(leaf, dir_item)))
 			return dir_item;
 
 		cur += this_len;
@@ -410,6 +450,21 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 	return NULL;
 }
 
+/*
+ * helper function to look at the directory item pointed to by 'path'
+ * this walks through all the entries in a dir item and finds one
+ * for a specific name.
+ */
+struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
+						 struct btrfs_path *path,
+						 const char *name, int name_len)
+{
+	struct fscrypt_name fname = {
+		.disk_name = FSTR_INIT((char *) name, name_len)
+	};
+	return btrfs_match_dir_item_fname(fs_info, path, &fname);
+}
+
 /*
  * given a pointer into a directory item, delete it.  This
  * handles items that have more than one entry in them.
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index e40a226373d7..1d6ab8c3b879 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -6,6 +6,7 @@
 #include <linux/crc32c.h>
 
 struct fscrypt_str;
+struct fscrypt_name;
 
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 			  const struct fscrypt_str *name);
@@ -16,6 +17,11 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
 					     struct btrfs_path *path, u64 dir,
 					     const struct fscrypt_str *name, int mod);
+struct btrfs_dir_item *btrfs_lookup_dir_item_fname(
+	struct btrfs_trans_handle *trans,
+	struct btrfs_root *root,
+	struct btrfs_path *path, u64 dir,
+	struct fscrypt_name *name, int mod);
 struct btrfs_dir_item *btrfs_lookup_dir_index_item(
 			struct btrfs_trans_handle *trans,
 			struct btrfs_root *root,
@@ -23,7 +29,7 @@ struct btrfs_dir_item *btrfs_lookup_dir_index_item(
 			u64 index, const struct fscrypt_str *name, int mod);
 struct btrfs_dir_item *btrfs_search_dir_index_item(struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dirid,
-			    const struct fscrypt_str *name);
+			    struct fscrypt_name *name);
 int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct btrfs_path *path,
@@ -42,6 +48,9 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 						 struct btrfs_path *path,
 						 const char *name,
 						 int name_len);
+struct btrfs_dir_item *btrfs_match_dir_item_fname(struct btrfs_fs_info *fs_info,
+						  struct btrfs_path *path,
+						  struct fscrypt_name *name);
 
 static inline u64 btrfs_name_hash(const char *name, int len)
 {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f91a688abd3b..42544c0d9ee1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4159,6 +4159,44 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
 	}
 }
 
+/* Take a sha256 of a portion of an extent buffer. */
+void extent_buffer_sha256(const struct extent_buffer *eb,
+			  unsigned long start,
+			  unsigned long len, u8 *out)
+{
+	size_t cur;
+	size_t offset;
+	struct page *page;
+	char *kaddr;
+	unsigned long i = get_eb_page_index(start);
+	struct sha256_state sctx;
+
+	if (check_eb_range(eb, start, len))
+		return;
+
+	offset = get_eb_offset_in_page(eb, start);
+
+	/*
+	 * TODO: This should maybe be using the crypto API, not the fallback,
+	 * but fscrypt uses the fallback and this is only used in emulation of
+	 * fscrypt's buffer sha256 method.
+	 */
+	sha256_init(&sctx);
+	while (len > 0) {
+		page = eb->pages[i];
+		assert_eb_page_uptodate(eb, page);
+
+		cur = min(len, PAGE_SIZE - offset);
+		kaddr = page_address(page);
+		sha256_update(&sctx, (u8 *)(kaddr + offset), cur);
+
+		len -= cur;
+		offset = 0;
+		i++;
+	}
+	sha256_final(&sctx, out);
+}
+
 static void __write_extent_buffer(const struct extent_buffer *eb,
 				  const void *srcv, unsigned long start,
 				  unsigned long len, bool use_memmove)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 785b0d07d741..7d35e7344386 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -244,6 +244,9 @@ static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
 
 int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len);
+void extent_buffer_sha256(const struct extent_buffer *eb,
+			  unsigned long start,
+			  unsigned long len, u8 *out);
 void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 			unsigned long start,
 			unsigned long len);
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 0e4011d6b1cd..6a4e4f63a660 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -5,13 +5,47 @@
 #include "accessors.h"
 #include "btrfs_inode.h"
 #include "disk-io.h"
+#include "ioctl.h"
 #include "fs.h"
 #include "fscrypt.h"
 #include "ioctl.h"
 #include "messages.h"
+#include "root-tree.h"
 #include "transaction.h"
 #include "xattr.h"
 
+/*
+ * This function is extremely similar to fscrypt_match_name() but uses an
+ * extent_buffer.
+ */
+bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
+			      struct extent_buffer *leaf, unsigned long de_name,
+			      u32 de_name_len)
+{
+	const struct fscrypt_nokey_name *nokey_name =
+		(const struct fscrypt_nokey_name *)fname->crypto_buf.name;
+	u8 digest[SHA256_DIGEST_SIZE];
+
+	if (likely(fname->disk_name.name)) {
+		if (de_name_len != fname->disk_name.len)
+			return false;
+		return !memcmp_extent_buffer(leaf, fname->disk_name.name,
+					     de_name, de_name_len);
+	}
+
+	if (de_name_len <= sizeof(nokey_name->bytes))
+		return false;
+
+	if (memcmp_extent_buffer(leaf, nokey_name->bytes, de_name,
+				 sizeof(nokey_name->bytes)))
+		return false;
+
+	extent_buffer_sha256(leaf, de_name + sizeof(nokey_name->bytes),
+			     de_name_len - sizeof(nokey_name->bytes), digest);
+
+	return !memcmp(digest, nokey_name->sha256, sizeof(digest));
+}
+
 static int btrfs_fscrypt_get_context(struct inode *inode, void *ctx, size_t len)
 {
 	struct btrfs_key key = {
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index 80adb7e56826..1647bbbcd609 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -4,9 +4,28 @@
 #define BTRFS_FSCRYPT_H
 
 #include <linux/fscrypt.h>
+#include "extent_io.h"
 
 #include "fs.h"
 
+#ifdef CONFIG_FS_ENCRYPTION
+bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
+			      struct extent_buffer *leaf,
+			      unsigned long de_name, u32 de_name_len);
+
+#else
+static inline bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
+					    struct extent_buffer *leaf,
+					    unsigned long de_name,
+					    u32 de_name_len)
+{
+	if (de_name_len != fname_len(fname))
+		return false;
+	return !memcmp_extent_buffer(leaf, fname->disk_name.name, de_name,
+				     de_name_len);
+}
+#endif /* CONFIG_FS_ENCRYPTION */
+
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
 
 #endif /* BTRFS_FSCRYPT_H */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cc52af10a520..60d1e93c2567 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4053,7 +4053,7 @@ int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *dir,
 				struct btrfs_inode *inode,
-				const struct fscrypt_str *name,
+				struct fscrypt_name *name,
 				struct btrfs_rename_ctx *rename_ctx)
 {
 	struct btrfs_root *root = dir->root;
@@ -4071,7 +4071,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	di = btrfs_lookup_dir_item(trans, root, path, dir_ino, name, -1);
+	di = btrfs_lookup_dir_item_fname(trans, root, path, dir_ino, name, -1);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto err;
@@ -4099,11 +4099,14 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ret = btrfs_del_inode_ref(trans, root, name, ino, dir_ino, &index);
+	ret = btrfs_del_inode_ref(trans, root, &name->disk_name, ino, dir_ino,
+				  &index);
 	if (ret) {
+		/* This should print a base-64 encoded name if relevant? */
 		btrfs_info(fs_info,
 			"failed to delete reference to %.*s, inode %llu parent %llu",
-			name->len, name->name, ino, dir_ino);
+			name->disk_name.len, name->disk_name.name, ino,
+			dir_ino);
 		btrfs_abort_transaction(trans, ret);
 		goto err;
 	}
@@ -4124,8 +4127,10 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	 * operations on the log tree, increasing latency for applications.
 	 */
 	if (!rename_ctx) {
-		btrfs_del_inode_ref_in_log(trans, root, name, inode, dir_ino);
-		btrfs_del_dir_entries_in_log(trans, root, name, dir, index);
+		btrfs_del_inode_ref_in_log(trans, root, &name->disk_name,
+					   inode, dir_ino);
+		btrfs_del_dir_entries_in_log(trans, root, &name->disk_name,
+					     dir, index);
 	}
 
 	/*
@@ -4143,7 +4148,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
+	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->disk_name.len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
  	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
@@ -4154,7 +4159,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_inode *dir, struct btrfs_inode *inode,
-		       const struct fscrypt_str *name)
+		       struct fscrypt_name *name)
 {
 	int ret;
 
@@ -4205,7 +4210,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 				false);
 
 	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
-				 &fname.disk_name);
+				 &fname);
 	if (ret)
 		goto end_trans;
 
@@ -4242,8 +4247,6 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	/* This needs to handle no-key deletions later on */
-
 	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
 		objectid = inode->root->root_key.objectid;
 	} else if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
@@ -4260,8 +4263,8 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	di = btrfs_lookup_dir_item(trans, root, path, dir_ino,
-				   &fname.disk_name, -1);
+	di = btrfs_lookup_dir_item_fname(trans, root, path, dir_ino,
+					 &fname, -1);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto out;
@@ -4287,7 +4290,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	 * call btrfs_del_root_ref, and it _shouldn't_ fail.
 	 */
 	if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
-		di = btrfs_search_dir_index_item(root, path, dir_ino, &fname.disk_name);
+		di = btrfs_search_dir_index_item(root, path, dir_ino, &fname);
 		if (IS_ERR_OR_NULL(di)) {
 			if (!di)
 				ret = -ENOENT;
@@ -4304,7 +4307,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	} else {
 		ret = btrfs_del_root_ref(trans, objectid,
 					 root->root_key.objectid, dir_ino,
-					 &index, &fname.disk_name);
+					 &index, &fname);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -4627,7 +4630,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 
 	/* now the directory is empty */
 	err = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
-				 &fname.disk_name);
+				 &fname);
 	if (!err) {
 		btrfs_i_size_write(BTRFS_I(inode), 0);
 		/*
@@ -5332,32 +5335,23 @@ void btrfs_evict_inode(struct inode *inode)
  * If no dir entries were found, returns -ENOENT.
  * If found a corrupted location in dir entry, returns -EUCLEAN.
  */
-static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
+static int btrfs_inode_by_name(struct btrfs_inode *dir,
+			       struct fscrypt_name *fname,
 			       struct btrfs_key *location, u8 *type)
 {
 	struct btrfs_dir_item *di;
 	struct btrfs_path *path;
 	struct btrfs_root *root = dir->root;
 	int ret = 0;
-	struct fscrypt_name fname;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 1, &fname);
-	if (ret < 0)
-		goto out;
-	/*
-	 * fscrypt_setup_filename() should never return a positive value, but
-	 * gcc on sparc/parisc thinks it can, so assert that doesn't happen.
-	 */
-	ASSERT(ret == 0);
-
 	/* This needs to handle no-key deletions later on */
 
-	di = btrfs_lookup_dir_item(NULL, root, path, btrfs_ino(dir),
-				   &fname.disk_name, 0);
+	di = btrfs_lookup_dir_item_fname(NULL, root, path, btrfs_ino(dir),
+				   fname, 0);
 	if (IS_ERR_OR_NULL(di)) {
 		ret = di ? PTR_ERR(di) : -ENOENT;
 		goto out;
@@ -5369,13 +5363,13 @@ static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
 		ret = -EUCLEAN;
 		btrfs_warn(root->fs_info,
 "%s gets something invalid in DIR_ITEM (name %s, directory ino %llu, location(%llu %u %llu))",
-			   __func__, fname.disk_name.name, btrfs_ino(dir),
-			   location->objectid, location->type, location->offset);
+			   __func__, fname->usr_fname->name,
+			   btrfs_ino(dir), location->objectid,
+			   location->type, location->offset);
 	}
 	if (!ret)
 		*type = btrfs_dir_ftype(path->nodes[0], di);
 out:
-	fscrypt_free_filename(&fname);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -5653,20 +5647,27 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *sub_root = root;
 	struct btrfs_key location;
+	struct fscrypt_name fname;
 	u8 di_type = 0;
 	int ret = 0;
 
 	if (dentry->d_name.len > BTRFS_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	ret = btrfs_inode_by_name(BTRFS_I(dir), dentry, &location, &di_type);
-	if (ret < 0)
+	ret = fscrypt_prepare_lookup(dir, dentry, &fname);
+	if (ret)
 		return ERR_PTR(ret);
 
+	ret = btrfs_inode_by_name(BTRFS_I(dir), &fname, &location, &di_type);
+	if (ret < 0) {
+		inode = ERR_PTR(ret);
+		goto cleanup;
+	}
+
 	if (location.type == BTRFS_INODE_ITEM_KEY) {
 		inode = btrfs_iget(dir->i_sb, location.objectid, root);
 		if (IS_ERR(inode))
-			return inode;
+			goto cleanup;
 
 		/* Do extra check against inode mode with di_type */
 		if (btrfs_inode_type(inode) != di_type) {
@@ -5675,9 +5676,10 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 				  inode->i_mode, btrfs_inode_type(inode),
 				  di_type);
 			iput(inode);
-			return ERR_PTR(-EUCLEAN);
+			inode = ERR_PTR(-EUCLEAN);
+			goto cleanup;
 		}
-		return inode;
+		goto cleanup;
 	}
 
 	ret = fixup_tree_root_location(fs_info, BTRFS_I(dir), dentry,
@@ -5692,7 +5694,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		btrfs_put_root(sub_root);
 
 		if (IS_ERR(inode))
-			return inode;
+			goto cleanup;
 
 		down_read(&fs_info->cleanup_work_sem);
 		if (!sb_rdonly(inode->i_sb))
@@ -5704,6 +5706,8 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		}
 	}
 
+cleanup:
+	fscrypt_free_filename(&fname);
 	return inode;
 }
 
@@ -5892,18 +5896,32 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	LIST_HEAD(del_list);
 	int ret;
 	char *name_ptr;
-	int name_len;
+	u32 name_len;
 	int entries = 0;
 	int total_len = 0;
 	bool put = false;
 	struct btrfs_key location;
+	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
+	u32 fstr_len = 0;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
+	if (BTRFS_I(inode)->flags & BTRFS_INODE_ENCRYPT) {
+		ret = fscrypt_prepare_readdir(inode);
+		if (ret)
+			return ret;
+		ret = fscrypt_fname_alloc_buffer(BTRFS_NAME_LEN, &fstr);
+		if (ret)
+			return ret;
+		fstr_len = fstr.len;
+	}
+
 	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
+	if (!path) {
+		ret = -ENOMEM;
+		goto err_fstr;
+	}
 
 	addr = private->filldir_buf;
 	path->reada = READA_FORWARD;
@@ -5920,6 +5938,7 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 		struct dir_entry *entry;
 		struct extent_buffer *leaf = path->nodes[0];
 		u8 ftype;
+		u32 nokey_len;
 
 		if (found_key.objectid != key.objectid)
 			break;
@@ -5933,8 +5952,13 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 			continue;
 		di = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
 		name_len = btrfs_dir_name_len(leaf, di);
-		if ((total_len + sizeof(struct dir_entry) + name_len) >=
-		    PAGE_SIZE) {
+		nokey_len = DIV_ROUND_UP(name_len * 4, 3);
+		/*
+		 * If name is encrypted, and we don't have the key, we could
+		 * need up to 4/3rds the bytes to print it.
+		 */
+		if ((total_len + sizeof(struct dir_entry) + nokey_len)
+		    >= PAGE_SIZE) {
 			btrfs_release_path(path);
 			ret = btrfs_filldir(private->filldir_buf, entries, ctx);
 			if (ret)
@@ -5948,8 +5972,36 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 		ftype = btrfs_dir_flags_to_ftype(btrfs_dir_flags(leaf, di));
 		entry = addr;
 		name_ptr = (char *)(entry + 1);
-		read_extent_buffer(leaf, name_ptr,
-				   (unsigned long)(di + 1), name_len);
+		if (btrfs_dir_flags(leaf, di) & BTRFS_FT_ENCRYPTED) {
+			struct fscrypt_str oname = FSTR_INIT(name_ptr,
+							     nokey_len);
+			u32 hash = 0, minor_hash = 0;
+
+			read_extent_buffer(leaf, fstr.name,
+					   (unsigned long)(di + 1), name_len);
+			fstr.len = name_len;
+			/*
+			 * We're iterating through DIR_INDEX items, so we don't
+			 * have the DIR_ITEM hash handy. Only compute it if
+			 * we'll need it -- the nokey name stores it, so that
+			 * we can look up the appropriate item by nokey name
+			 * later on.
+			 */
+			if (!fscrypt_has_encryption_key(inode)) {
+				u64 name_hash = btrfs_name_hash(fstr.name,
+								fstr.len);
+				hash = name_hash;
+				minor_hash = name_hash >> 32;
+			}
+			ret = fscrypt_fname_disk_to_usr(inode, hash, minor_hash,
+							&fstr, &oname);
+			if (ret)
+				goto err;
+			name_len = oname.len;
+		} else {
+			read_extent_buffer(leaf, name_ptr,
+					   (unsigned long)(di + 1), name_len);
+		}
 		put_unaligned(name_len, &entry->name_len);
 		put_unaligned(fs_ftype_to_dtype(ftype), &entry->type);
 		btrfs_dir_item_key_to_cpu(leaf, di, &location);
@@ -5969,7 +6021,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	if (ret)
 		goto nopos;
 
-	ret = btrfs_readdir_delayed_dir_index(ctx, &ins_list);
+	fstr.len = fstr_len;
+	ret = btrfs_readdir_delayed_dir_index(inode, &fstr, ctx, &ins_list);
 	if (ret)
 		goto nopos;
 
@@ -6000,6 +6053,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	if (put)
 		btrfs_readdir_put_delayed_items(inode, &ins_list, &del_list);
 	btrfs_free_path(path);
+err_fstr:
+	fscrypt_fname_free_buffer(&fstr);
 	return ret;
 }
 
@@ -6458,6 +6513,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root = parent_inode->root;
 	u64 ino = btrfs_ino(inode);
 	u64 parent_ino = btrfs_ino(parent_inode);
+	struct fscrypt_name fname = { .disk_name = *name };
 
 	if (unlikely(ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		memcpy(&key, &inode->root->root_key, sizeof(key));
@@ -6513,7 +6569,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		int err;
 		err = btrfs_del_root_ref(trans, key.objectid,
 					 root->root_key.objectid, parent_ino,
-					 &local_index, name);
+					 &local_index, &fname);
 		if (err)
 			btrfs_abort_transaction(trans, err);
 	} else if (add_backref) {
@@ -8894,7 +8950,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	} else { /* src is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					   BTRFS_I(old_dentry->d_inode),
-					   old_name, &old_rename_ctx);
+					   &old_fname, &old_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, BTRFS_I(old_inode));
 	}
@@ -8909,7 +8965,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	} else { /* dest is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 					   BTRFS_I(new_dentry->d_inode),
-					   new_name, &new_rename_ctx);
+					   &new_fname, &new_rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, BTRFS_I(new_inode));
 	}
@@ -9154,7 +9210,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 	} else {
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					   BTRFS_I(d_inode(old_dentry)),
-					   &old_fname.disk_name, &rename_ctx);
+					   &old_fname, &rename_ctx);
 		if (!ret)
 			ret = btrfs_update_inode(trans, BTRFS_I(old_inode));
 	}
@@ -9172,7 +9228,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 		} else {
 			ret = btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 						 BTRFS_I(d_inode(new_dentry)),
-						 &new_fname.disk_name);
+						 &new_fname);
 		}
 		if (!ret && new_inode->i_nlink == 0)
 			ret = btrfs_orphan_add(trans,
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 603ad1459368..d131934123f5 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -10,6 +10,7 @@
 #include "messages.h"
 #include "transaction.h"
 #include "disk-io.h"
+#include "fscrypt.h"
 #include "print-tree.h"
 #include "qgroup.h"
 #include "space-info.h"
@@ -334,7 +335,7 @@ int btrfs_del_root(struct btrfs_trans_handle *trans,
 
 int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		       u64 ref_id, u64 dirid, u64 *sequence,
-		       const struct fscrypt_str *name)
+		       struct fscrypt_name *name)
 {
 	struct btrfs_root *tree_root = trans->fs_info->tree_root;
 	struct btrfs_path *path;
@@ -356,13 +357,14 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	if (ret < 0) {
 		goto out;
 	} else if (ret == 0) {
+		u32 name_len;
 		leaf = path->nodes[0];
 		ref = btrfs_item_ptr(leaf, path->slots[0],
 				     struct btrfs_root_ref);
 		ptr = (unsigned long)(ref + 1);
+		name_len = btrfs_root_ref_name_len(leaf, ref);
 		if ((btrfs_root_ref_dirid(leaf, ref) != dirid) ||
-		    (btrfs_root_ref_name_len(leaf, ref) != name->len) ||
-		    memcmp_extent_buffer(leaf, name->name, ptr, name->len)) {
+		    !btrfs_fscrypt_match_name(name, leaf, ptr, name_len)) {
 			ret = -ENOENT;
 			goto out;
 		}
diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
index 8b2c3859e464..5ba7b36cf826 100644
--- a/fs/btrfs/root-tree.h
+++ b/fs/btrfs/root-tree.h
@@ -15,7 +15,7 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		       const struct fscrypt_str *name);
 int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		       u64 ref_id, u64 dirid, u64 *sequence,
-		       const struct fscrypt_str *name);
+		       struct fscrypt_name *name);
 int btrfs_del_root(struct btrfs_trans_handle *trans, const struct btrfs_key *key);
 int btrfs_insert_root(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      const struct btrfs_key *key,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 00b6f0c71e1d..89d3dc769b15 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -901,9 +901,10 @@ static int unlink_inode_for_log_replay(struct btrfs_trans_handle *trans,
 				       struct btrfs_inode *inode,
 				       const struct fscrypt_str *name)
 {
+	struct fscrypt_name fname = { .disk_name = *name, };
 	int ret;
 
-	ret = btrfs_unlink_inode(trans, dir, inode, name);
+	ret = btrfs_unlink_inode(trans, dir, inode, &fname);
 	if (ret)
 		return ret;
 	/*
-- 
2.41.0


