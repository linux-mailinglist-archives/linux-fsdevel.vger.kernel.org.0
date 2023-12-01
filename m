Return-Path: <linux-fsdevel+bounces-4641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EDA8016A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590B21F2108C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B1859E4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1ep0p1mj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F36D50
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:23 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db539ab8e02so1044701276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468742; x=1702073542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTK1Rkp+qKkPtMOondRTum0dicS58Ez8ls+Mvz2mZlQ=;
        b=1ep0p1mjJkVlhZX11vU5DY8ZCBp3LKKo0FqSd8WiWHs5kHowhMP7LLD4954IHuTAXW
         jbk1NeXR+TjqhIiEneMnV0V/w2I+4X8s/f/Gkc0g2OMmwMTR/dx3dQOf+DdtEU8tFOBd
         jtLPWc39dYs3lWnaH05/C9OsGQdvXXfzcgBTkqztB9qyRxr4CmJ6ZtUU/XshxQ3nbrsT
         mZofyFHth3P5tkjmTU+1LMfSYItvZN2fNyWiCby2WRq+Im2/Lp5f2QF2jqYxIT82rdyJ
         KbxmJgH0MMKlUdCFH7soZ5Do2pZt+K+N2lV7NjQzYnTRrRQWtzhHL7cYWk+yvDlWwrrB
         ysVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468742; x=1702073542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTK1Rkp+qKkPtMOondRTum0dicS58Ez8ls+Mvz2mZlQ=;
        b=o1ChDucuZIF4ePsclPTSlVomSWcDQ4WzvjurRx9xmveGSlp2zd8KpLoFl8zlncZzSn
         +omD89/ObyNBd9I7ZVOik1j8O8j4W2OpeXY7PcZ4NyBzeZodXTbXps0+2XMDdLrE2X8s
         YQnOj4to8QaxvPoWJmiP2+a0kkcWWyPgpESlU+FJW5b85l8nnwrIYG1LQy2T72o4rpHr
         ZLiDhG9S8D3sRlpL70FKnItQt4l3LR14rWctUxPSiJZpntEBFfze3G7RKQNsLf/nMwPh
         QntLFBagyt5diZ6apu6DOKzZRv2R/xCDscgq8k8KJu7VNGPYkdtGcs7sXH535Oh30Dxk
         KnZQ==
X-Gm-Message-State: AOJu0Yw/z+gp2AiqbxkQL6PFbCSJjQQ4Vb2O8WQMEj6ZB4A4EcdmSFV6
	th8oP83lowptYYAJOpOcpd5qwA8iYZSYDljFdiyOdw==
X-Google-Smtp-Source: AGHT+IHKmTurH/z9r6b/RFSMoEMbNd9b8W+3gOMRA7gV20MLjg3yfDEZdyHNaybPbj1oMwqJQQm+CA==
X-Received: by 2002:a25:bc1:0:b0:db7:b6fb:7446 with SMTP id 184-20020a250bc1000000b00db7b6fb7446mr244480ybl.9.1701468742178;
        Fri, 01 Dec 2023 14:12:22 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p5-20020a258185000000b00da086d6921fsm613029ybk.50.2023.12.01.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:21 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 21/46] btrfs: add fscrypt_info and encryption_type to extent_map
Date: Fri,  1 Dec 2023 17:11:18 -0500
Message-ID: <2bc7d813a291837430fca8f3656fb894665d2e14.1701468306.git.josef@toxicpanda.com>
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

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Each extent_map will end up with a pointer to its associated
fscrypt_info if any, which should have the same lifetime as the
extent_map. We are also going to need to track the encryption_type for
the file extent items.  Add the fscrypt_info to the extent_map, and the
subsequent code for transferring it in the split and merge cases, as
well as the code necessary to free them.  A future patch will add the
code to load them as appropriate.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_map.c | 39 +++++++++++++++++++++++++++++++++++----
 fs/btrfs/extent_map.h |  2 ++
 fs/btrfs/file-item.c  |  1 +
 fs/btrfs/inode.c      |  1 +
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 20d347fa6f8a..b87d26fe6785 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -59,6 +59,12 @@ struct extent_map *alloc_extent_map(void)
 	return em;
 }
 
+static void __free_extent_map(struct extent_map *em)
+{
+	fscrypt_put_extent_info(em->fscrypt_info);
+	kmem_cache_free(extent_map_cache, em);
+}
+
 /*
  * Drop the reference out on @em by one and free the structure if the reference
  * count hits zero.
@@ -70,7 +76,7 @@ void free_extent_map(struct extent_map *em)
 	if (refcount_dec_and_test(&em->refs)) {
 		WARN_ON(extent_map_in_tree(em));
 		WARN_ON(!list_empty(&em->list));
-		kmem_cache_free(extent_map_cache, em);
+		__free_extent_map(em);
 	}
 }
 
@@ -96,12 +102,24 @@ void free_extent_map_safe(struct extent_map_tree *tree,
 	if (!em)
 		return;
 
-	if (refcount_dec_and_test(&em->refs)) {
-		WARN_ON(extent_map_in_tree(em));
-		WARN_ON(!list_empty(&em->list));
+	if (!refcount_dec_and_test(&em->refs))
+		return;
+
+	WARN_ON(extent_map_in_tree(em));
+	WARN_ON(!list_empty(&em->list));
+
+	/*
+	 * We could take a lock freeing the fscrypt_info, so add this to the
+	 * list of freed_extents to be freed later.
+	 */
+	if (em->fscrypt_info) {
 		list_add_tail(&em->free_list, &tree->freed_extents);
 		set_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags);
+		return;
 	}
+
+	/* Nothing scary here, just free the object. */
+	__free_extent_map(em);
 }
 
 /*
@@ -274,6 +292,12 @@ static int mergable_maps(struct extent_map *prev, struct extent_map *next)
 	if (!list_empty(&prev->list) || !list_empty(&next->list))
 		return 0;
 
+	/*
+	 * Don't merge adjacent encrypted maps.
+	 */
+	if (prev->fscrypt_info || next->fscrypt_info)
+		return 0;
+
 	ASSERT(next->block_start != EXTENT_MAP_DELALLOC &&
 	       prev->block_start != EXTENT_MAP_DELALLOC);
 
@@ -840,6 +864,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->generation = gen;
 			split->flags = flags;
 			split->compress_type = em->compress_type;
+			split->fscrypt_info =
+				fscrypt_get_extent_info(em->fscrypt_info);
 			replace_extent_mapping(em_tree, em, split, modified);
 			free_extent_map(split);
 			split = split2;
@@ -881,6 +907,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				split->orig_block_len = 0;
 			}
 
+			split->fscrypt_info =
+				fscrypt_get_extent_info(em->fscrypt_info);
 			if (extent_map_in_tree(em)) {
 				replace_extent_mapping(em_tree, em, split,
 						       modified);
@@ -1043,6 +1071,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->flags = flags;
 	split_pre->compress_type = em->compress_type;
 	split_pre->generation = em->generation;
+	split_pre->fscrypt_info = fscrypt_get_extent_info(em->fscrypt_info);
 
 	replace_extent_mapping(em_tree, em, split_pre, 1);
 
@@ -1062,6 +1091,8 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->flags = flags;
 	split_mid->compress_type = em->compress_type;
 	split_mid->generation = em->generation;
+	split_mid->fscrypt_info = fscrypt_get_extent_info(em->fscrypt_info);
+
 	add_extent_mapping(em_tree, split_mid, 1);
 
 	/* Once for us */
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index fb8905f88f7c..e1075cadfd94 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -48,8 +48,10 @@ struct extent_map {
 	 */
 	u64 generation;
 	unsigned long flags;
+	struct fscrypt_extent_info *fscrypt_info;
 	refcount_t refs;
 	unsigned int compress_type;
+	unsigned int encryption_type;
 	struct list_head list;
 	struct list_head free_list;
 };
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 45cae356e89b..26f35c1baedc 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1305,6 +1305,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 			if (type == BTRFS_FILE_EXTENT_PREALLOC)
 				set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
 		}
+		em->encryption_type = btrfs_file_extent_encryption(leaf, fi);
 	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
 		em->block_start = EXTENT_MAP_INLINE;
 		em->start = extent_start;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f894f5b5e786..5b1aea9f5f46 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7373,6 +7373,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
 		em->compress_type = compress_type;
 	}
+	em->encryption_type = BTRFS_ENCRYPTION_NONE;
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
-- 
2.41.0


