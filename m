Return-Path: <linux-fsdevel+bounces-14021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3561876A64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 19:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD903284E21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 18:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00295A7A7;
	Fri,  8 Mar 2024 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="BAIeDFA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D825916D;
	Fri,  8 Mar 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921018; cv=none; b=FbS3bg2FHzUF80C6NYyiDRtGoxpk17E1WRmmaqczZhX91BHoa+0WATEFfIeLVHMdX4oEMu+gJCnMhAFbOnRiuh8TIcLMn+ct/VL1daei6isKR6m6bDWpjIrt49Hq7T2RVaTGKKSPiNfk+sIa+nSacSiNoQ8CzIPtCe7TRFcEIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921018; c=relaxed/simple;
	bh=Ok/nnTe+/+xwLdjd+7wLl1FtDqtT6GVQPQmwMIQZK8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beAFqbSq5KebrwtUKSQTkXjsrqxX0na3BjIVwTlK/cntkFngKQMYvlVSGwZwd6WPlkaXrnzdRyD7o+dCNCNZf8ocKK+OShBKpzihFY6PmnJKAdSiznxhuvP7f6LS1t6kfsYY4ip2V01QQehPWyF/6J9T/NpOTnCn9B33q+8gDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=BAIeDFA1; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 38ABD82571;
	Fri,  8 Mar 2024 13:03:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1709921010; bh=Ok/nnTe+/+xwLdjd+7wLl1FtDqtT6GVQPQmwMIQZK8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAIeDFA1lMC6Z/F3pB/Vaoi/k1oPwKaB4QIfe3M0zOXmQK2Yq8YQ70NEMuUhIfO7b
	 EX6ZhAb8/fd919Mlwbh1K7WHlT4zNvfoz76iQqBxY3Jz2Dk9KwQ5g110OtTeB96vW1
	 lUB7Mro+RpsUwxY1kF8Xg6TgzqDeHtOPtmijeQetVvHHeFgc6RbXxJsiS0PevKT6W6
	 UPqs+L8B7ZqEYMhw5JAFwe/E2mS/+ngXXj6ob7yynTy7H1FYwBwbtw+d4Jcuu3HXNN
	 JGHr2bYv8El9D9Mcsxw8SUWuqDciK11k0b0FPXbKVy4+dpRu92fJp2kDyDR94LdbXo
	 pEs/GGDinRnIA==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: corbet@lwn.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	clm@meta.com,
	dsterba@suse.com,
	josef@toxicpanda.com
Cc: jbacik@toxicpanda.com,
	kernel-team@meta.com,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 3/3] btrfs: fiemap: return extent physical size
Date: Fri,  8 Mar 2024 13:03:20 -0500
Message-ID: <28089fc747eb8673ae147b7af38a3919bfa52144.1709918025.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1709918025.git.sweettea-kernel@dorminy.me>
References: <cover.1709918025.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that fiemap allows returning extent physical size, make btrfs return
the appropriate extent's actual disk size.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/extent_io.c | 63 +++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cdf662b9fb5b..4374c531e088 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2456,7 +2456,8 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 struct btrfs_fiemap_entry {
 	u64 offset;
 	u64 phys;
-	u64 len;
+	u64 log_len;
+	u64 phys_len;
 	u32 flags;
 };
 
@@ -2514,7 +2515,8 @@ struct fiemap_cache {
 	/* Fields for the cached extent (unsubmitted, not ready, extent). */
 	u64 offset;
 	u64 phys;
-	u64 len;
+	u64 log_len;
+	u64 phys_len;
 	u32 flags;
 	bool cached;
 };
@@ -2527,8 +2529,8 @@ static int flush_fiemap_cache(struct fiemap_extent_info *fieinfo,
 		int ret;
 
 		ret = fiemap_fill_next_extent(fieinfo, entry->offset,
-					      entry->phys, entry->len,
-					      entry->flags);
+					      entry->phys, entry->log_len,
+					      entry->phys_len, entry->flags);
 		/*
 		 * Ignore 1 (reached max entries) because we keep track of that
 		 * ourselves in emit_fiemap_extent().
@@ -2553,7 +2555,8 @@ static int flush_fiemap_cache(struct fiemap_extent_info *fieinfo,
  */
 static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 				struct fiemap_cache *cache,
-				u64 offset, u64 phys, u64 len, u32 flags)
+				u64 offset, u64 phys, u64 log_len,
+				u64 phys_len, u32 flags)
 {
 	struct btrfs_fiemap_entry *entry;
 	u64 cache_end;
@@ -2596,7 +2599,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	 * or equals to what we have in cache->offset. We deal with this as
 	 * described below.
 	 */
-	cache_end = cache->offset + cache->len;
+	cache_end = cache->offset + cache->log_len;
 	if (cache_end > offset) {
 		if (offset == cache->offset) {
 			/*
@@ -2620,10 +2623,10 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 			 * where a previously found file extent item was split
 			 * due to an ordered extent completing.
 			 */
-			cache->len = offset - cache->offset;
+			cache->log_len = offset - cache->offset;
 			goto emit;
 		} else {
-			const u64 range_end = offset + len;
+			const u64 range_end = offset + log_len;
 
 			/*
 			 * The offset of the file extent item we have just found
@@ -2660,7 +2663,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 				phys += cache_end - offset;
 
 			offset = cache_end;
-			len = range_end - cache_end;
+			log_len = range_end - cache_end;
 			goto emit;
 		}
 	}
@@ -2670,15 +2673,17 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	 * 1) Their logical addresses are continuous
 	 *
 	 * 2) Their physical addresses are continuous
-	 *    So truly compressed (physical size smaller than logical size)
-	 *    extents won't get merged with each other
 	 *
 	 * 3) Share same flags
+	 *
+	 * 4) Not compressed
 	 */
-	if (cache->offset + cache->len  == offset &&
-	    cache->phys + cache->len == phys  &&
-	    cache->flags == flags) {
-		cache->len += len;
+	if (cache->offset + cache->log_len  == offset &&
+	    cache->phys + cache->log_len == phys  &&
+	    cache->flags == flags &&
+	    !(flags & FIEMAP_EXTENT_ENCODED)) {
+		cache->log_len += log_len;
+		cache->phys_len += phys_len;
 		return 0;
 	}
 
@@ -2695,7 +2700,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 		 * to miss it.
 		 */
 		entry = &cache->entries[cache->entries_size - 1];
-		cache->next_search_offset = entry->offset + entry->len;
+		cache->next_search_offset = entry->offset + entry->log_len;
 		cache->cached = false;
 
 		return BTRFS_FIEMAP_FLUSH_CACHE;
@@ -2704,7 +2709,8 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	entry = &cache->entries[cache->entries_pos];
 	entry->offset = cache->offset;
 	entry->phys = cache->phys;
-	entry->len = cache->len;
+	entry->log_len = cache->log_len;
+	entry->phys_len = cache->phys_len;
 	entry->flags = cache->flags;
 	cache->entries_pos++;
 	cache->extents_mapped++;
@@ -2717,7 +2723,8 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	cache->cached = true;
 	cache->offset = offset;
 	cache->phys = phys;
-	cache->len = len;
+	cache->log_len = log_len;
+	cache->phys_len = phys_len;
 	cache->flags = flags;
 
 	return 0;
@@ -2743,7 +2750,8 @@ static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
 		return 0;
 
 	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
-				      cache->len, cache->len, cache->flags);
+				      cache->log_len, cache->phys_len,
+				      cache->flags);
 	cache->cached = false;
 	if (ret > 0)
 		ret = 0;
@@ -2937,13 +2945,15 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 			}
 			ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
 						 disk_bytenr + extent_offset,
-						 prealloc_len, prealloc_flags);
+						 prealloc_len, prealloc_len,
+						 prealloc_flags);
 			if (ret)
 				return ret;
 			extent_offset += prealloc_len;
 		}
 
 		ret = emit_fiemap_extent(fieinfo, cache, delalloc_start, 0,
+					 delalloc_end + 1 - delalloc_start,
 					 delalloc_end + 1 - delalloc_start,
 					 FIEMAP_EXTENT_DELALLOC |
 					 FIEMAP_EXTENT_UNKNOWN);
@@ -2984,7 +2994,8 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 		}
 		ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
 					 disk_bytenr + extent_offset,
-					 prealloc_len, prealloc_flags);
+					 prealloc_len, prealloc_len,
+					 prealloc_flags);
 		if (ret)
 			return ret;
 	}
@@ -3130,6 +3141,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 extent_offset = 0;
 		u64 extent_gen;
 		u64 disk_bytenr = 0;
+		u64 disk_size = 0;
 		u64 flags = 0;
 		int extent_type;
 		u8 compression;
@@ -3192,7 +3204,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			flags |= FIEMAP_EXTENT_DATA_INLINE;
 			flags |= FIEMAP_EXTENT_NOT_ALIGNED;
 			ret = emit_fiemap_extent(fieinfo, &cache, key.offset, 0,
-						 extent_len, flags);
+						 extent_len, extent_len, flags);
 		} else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
 						  &delalloc_cached_state,
@@ -3207,6 +3219,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 						  backref_ctx, 0, 0, 0,
 						  key.offset, extent_end - 1);
 		} else {
+			disk_size = btrfs_file_extent_disk_num_bytes(leaf, ei);
 			/* We have a regular extent. */
 			if (fieinfo->fi_extents_max) {
 				ret = btrfs_is_data_extent_shared(inode,
@@ -3221,7 +3234,9 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 
 			ret = emit_fiemap_extent(fieinfo, &cache, key.offset,
 						 disk_bytenr + extent_offset,
-						 extent_len, flags);
+						 extent_len,
+						 disk_size - extent_offset,
+						 flags);
 		}
 
 		if (ret < 0) {
@@ -3259,7 +3274,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		prev_extent_end = range_end;
 	}
 
-	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
+	if (cache.cached && cache.offset + cache.log_len >= last_extent_end) {
 		const u64 i_size = i_size_read(&inode->vfs_inode);
 
 		if (prev_extent_end < i_size) {
-- 
2.44.0


