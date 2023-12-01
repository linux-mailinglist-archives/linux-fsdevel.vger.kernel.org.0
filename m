Return-Path: <linux-fsdevel+bounces-4643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A323F8016A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C6B1F210B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887563F8D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IstI/onB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C69D6C
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:24 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d2d0661a8dso29237137b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468744; x=1702073544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECsbNqk7e25qCTyOZ0B1DCO4cPIk26VYu5GvEvu1st4=;
        b=IstI/onBSksKYzVf6Mj3UZSbQZwivm11DLpFp27eunKOdKXw2LjXDDYu+owILpl8Jj
         fCrLGxFa+1gY7kpE1B6Fkb3iA72e0uCxQjK05aCN1OA4hwvL89BFnzN5lAPCxkRrBeRo
         zj0vkciHwmMue0+SSIe0vsIhahhEEXXLb2fwwKoXO8o3dDP4KYn7y+66Iiz+OdNEkNbQ
         cnrfA1mS8lOnCsmscXoKaWAwhwQTR2yTzFusWNuCNGsL2r5Qsota8lKqD5TUoieVki9Q
         AA/pUW96wMh5JYkJX+m3OwntkWtg8WGdaLo68pu7UfL3WjQyJPhoSUHq14TfVK+F70ty
         FJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468744; x=1702073544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECsbNqk7e25qCTyOZ0B1DCO4cPIk26VYu5GvEvu1st4=;
        b=gIwklPdJfToHTKrNQD5OTR0U+00Ogz8jftg5vloCvn8B8E1+CMUq+Uc0Xx5kqgBo+H
         YXtDGGsO44pmXjBLKGzPZZuU0qe6WdGcqykMM/MJEvU3/VBg680Hi7qtlnecAypzi1ES
         RaSSO0q+jtEWnAHRvB+RWvoJ6GOdZ0kbRggUDDMwG9olpe4K3s9mdlnG40Aa/KpQIQli
         sAvCf7I4cmv6Z5qTISGCjqj3lD531fb5rI1QwUxrzeEgTTX0AN3BnsWyk2BRSvQxSG4m
         rIkJN17QH8Qjs8GmxmULmDhukjlKWYoqCf/Gu8FJ5b5zkw8jw1WJ+FdmQiBzG3EhXGgf
         qmzw==
X-Gm-Message-State: AOJu0Yw65qjjkVLophqFTJx7eNlOUdeU+9vAvqjkLgEKA3x9UP+0oTku
	BuTapmFnSVSJqCD/0BMtgn+Ucsqte2urbVqK2rdhEA==
X-Google-Smtp-Source: AGHT+IFXRlEIXJmhzgWxdWPuqeivMeWTmnJ0wTj3kE6YB5CkE+oqtHmV9ymTBgNEXAmD8a8vidqtvw==
X-Received: by 2002:a81:7845:0:b0:5d7:1940:b37a with SMTP id t66-20020a817845000000b005d71940b37amr168736ywc.70.1701468744098;
        Fri, 01 Dec 2023 14:12:24 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u189-20020a8179c6000000b005d34a381f59sm1359711ywc.102.2023.12.01.14.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:23 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 23/46] btrfs: plumb through setting the fscrypt_info for ordered extents
Date: Fri,  1 Dec 2023 17:11:20 -0500
Message-ID: <7c9457e4e001b42fbb3f190334e954124765e50b.1701468306.git.josef@toxicpanda.com>
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

We're going to be getting fscrypt_info from the extent maps, update the
helpers to take an fscrypt_info argument and use that to set the
encryption type on the ordered extent.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c        | 20 +++++++++++---------
 fs/btrfs/ordered-data.c | 32 ++++++++++++++++++++------------
 fs/btrfs/ordered-data.h |  9 +++++----
 3 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b1aea9f5f46..83d653376deb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1171,7 +1171,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, start,	/* file_offset */
+	ordered = btrfs_alloc_ordered_extent(inode, NULL,
+				       start,			/* file_offset */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
 				       ins.objectid,		/* disk_bytenr */
@@ -1434,9 +1435,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 		free_extent_map(em);
 
-		ordered = btrfs_alloc_ordered_extent(inode, start, ram_size,
-					ram_size, ins.objectid, cur_alloc_size,
-					0, 1 << BTRFS_ORDERED_REGULAR,
+		ordered = btrfs_alloc_ordered_extent(inode, NULL,
+					start, ram_size, ram_size, ins.objectid,
+					cur_alloc_size, 0,
+					1 << BTRFS_ORDERED_REGULAR,
 					BTRFS_COMPRESS_NONE);
 		if (IS_ERR(ordered)) {
 			ret = PTR_ERR(ordered);
@@ -2167,7 +2169,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			free_extent_map(em);
 		}
 
-		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
+		ordered = btrfs_alloc_ordered_extent(inode, NULL, cur_offset,
 				nocow_args.num_bytes, nocow_args.num_bytes,
 				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
 				is_prealloc
@@ -7058,7 +7060,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		if (IS_ERR(em))
 			goto out;
 	}
-	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
+	ordered = btrfs_alloc_ordered_extent(inode, NULL, start, len, len,
 					     block_start, block_len, 0,
 					     (1 << type) |
 					     (1 << BTRFS_ORDERED_DIRECT),
@@ -10543,9 +10545,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	}
 	free_extent_map(em);
 
-	ordered = btrfs_alloc_ordered_extent(inode, start, num_bytes, ram_bytes,
-				       ins.objectid, ins.offset,
-				       encoded->unencoded_offset,
+	ordered = btrfs_alloc_ordered_extent(inode, NULL, start,
+				       num_bytes, ram_bytes, ins.objectid,
+				       ins.offset, encoded->unencoded_offset,
 				       (1 << BTRFS_ORDERED_ENCODED) |
 				       (1 << BTRFS_ORDERED_COMPRESSED),
 				       compression);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 27350dd50828..ee3138a6d11e 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -146,9 +146,11 @@ static inline struct rb_node *ordered_tree_search(struct btrfs_inode *inode,
 }
 
 static struct btrfs_ordered_extent *alloc_ordered_extent(
-			struct btrfs_inode *inode, u64 file_offset, u64 num_bytes,
-			u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
-			u64 offset, unsigned long flags, int compress_type)
+			struct btrfs_inode *inode,
+			struct fscrypt_extent_info *fscrypt_info,
+			u64 file_offset, u64 num_bytes, u64 ram_bytes,
+			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
+			unsigned long flags, int compress_type)
 {
 	struct btrfs_ordered_extent *entry;
 	int ret;
@@ -181,10 +183,12 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
-	entry->encryption_type = BTRFS_ENCRYPTION_NONE;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
 	entry->flags = flags;
+	entry->fscrypt_info = fscrypt_get_extent_info(fscrypt_info);
+	entry->encryption_type = entry->fscrypt_info ?
+		BTRFS_ENCRYPTION_FSCRYPT : BTRFS_ENCRYPTION_NONE;
 	refcount_set(&entry->refs, 1);
 	init_waitqueue_head(&entry->wait);
 	INIT_LIST_HEAD(&entry->list);
@@ -247,6 +251,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  * Add an ordered extent to the per-inode tree.
  *
  * @inode:           Inode that this extent is for.
+ * @fscrypt_info:    The fscrypt_extent_info for this extent, if necessary.
  * @file_offset:     Logical offset in file where the extent starts.
  * @num_bytes:       Logical length of extent in file.
  * @ram_bytes:       Full length of unencoded data.
@@ -263,17 +268,19 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  * Return: the new ordered extent or error pointer.
  */
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
-			struct btrfs_inode *inode, u64 file_offset,
-			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			u64 disk_num_bytes, u64 offset, unsigned long flags,
-			int compress_type)
+			struct btrfs_inode *inode,
+			struct fscrypt_extent_info *fscrypt_info,
+			u64 file_offset, u64 num_bytes, u64 ram_bytes,
+			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
+			unsigned long flags, int compress_type)
 {
 	struct btrfs_ordered_extent *entry;
 
 	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
 
-	entry = alloc_ordered_extent(inode, file_offset, num_bytes, ram_bytes,
-				     disk_bytenr, disk_num_bytes, offset, flags,
+	entry = alloc_ordered_extent(inode, fscrypt_info, file_offset,
+				     num_bytes, ram_bytes, disk_bytenr,
+				     disk_num_bytes, offset, flags,
 				     compress_type);
 	if (!IS_ERR(entry))
 		insert_ordered_extent(entry);
@@ -1166,8 +1173,9 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	if (WARN_ON_ONCE(ordered->disk_num_bytes != ordered->num_bytes))
 		return ERR_PTR(-EINVAL);
 
-	new = alloc_ordered_extent(inode, file_offset, len, len, disk_bytenr,
-				   len, 0, flags, ordered->compress_type);
+	new = alloc_ordered_extent(inode, ordered->fscrypt_info, file_offset,
+				   len, len, disk_bytenr, len, 0, flags,
+				   ordered->compress_type);
 	if (IS_ERR(new))
 		return new;
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 85ba9a381880..57ca8ce6eb6d 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -163,10 +163,11 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
 struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
-			struct btrfs_inode *inode, u64 file_offset,
-			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			u64 disk_num_bytes, u64 offset, unsigned long flags,
-			int compress_type);
+			struct btrfs_inode *inode,
+			struct fscrypt_extent_info *fscrypt_info,
+			u64 file_offset, u64 num_bytes, u64 ram_bytes,
+			u64 disk_bytenr, u64 disk_num_bytes, u64 offset,
+			unsigned long flags, int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
-- 
2.41.0


