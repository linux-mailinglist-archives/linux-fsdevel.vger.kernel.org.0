Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37542FFCE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbhAVGdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:33:21 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51117 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbhAVGY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296698; x=1642832698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=01DZ4vIzYkv22PEbswG5Q7jsqyJ6aX2+IV8V3uDBB50=;
  b=lbt9Pir1nPrmXIbKiXiHrxetkiGvnWlP9Qu+NOBLq9oD4sHZ+gTII9tM
   OR2GV6xvpzdlTxyqCRWO+fQEpntFxOTykECFCeRbiQ9FcHFxMgYUaiiqw
   Cl6lxEK88zGitfA9vWDXj1UIFMkY6NMhN48AxML3DQfR1veNhVVPbxLo/
   rjMNOasGhNj8BbXOvEKbR2puoAjZUubH2wT6baLnWUSMQSATqmVN1kWpR
   4SwrlMzRtUsHzXttT/tyoQLm4AUh2SEIgX5XvQl0AiXPt9ZaLnEcFyOef
   pF6ZiZS/CvudR8+1qOOHBNVJA7DHgoFYhnw48FjaeC3OSz0sNjZeTBVbJ
   A==;
IronPort-SDR: VExd0gGU2Il+80uOZ2rRvSOMvf7gSubJlgqBRKM/aqE1GP7T/YqI8ZE8zxWmUz/8ShDPKCu/4c
 0wp5UEWCbH5Ik5gst0Ei17cjmoF42XYkmXg0qLDshF4dZ5NHEpYmFD5KTGqQkk3j1JmPNavbSq
 lLjLAQjirwvuohy2cUz1WnPLri6hBbTDqHhT1JkpjjZS/72N0slLM5CW2exwL0KkQiZpTFR/B0
 ad31dDokRkobVNF/bJ79qtctMVsJDNTO7lxqXaUyjT32VxwkKYXSvgPNMDROqq0SXJe16H9l+z
 ZWk=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391979"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:42 +0800
IronPort-SDR: 84+t+lYKjk+rR5SSCamsnPHJtFpP4AiB1xbOF1NqXV2qMib5ZqbWTYIB+lUIQexa5NfDPJ99Xz
 8gauBmyXL1MnaNJRUjZVs0Ia1Sho+N9P50iTMaurA3hsG6JcKEBnSRGfvMhIjVnnBZlLMZ4jdg
 kgYe7sJNtOJQVmpR1GCYfSaFAWIQ85rbLpdguXtyFOa861gMivabKG9a5FNCoQB40vZVTBFtKR
 KgySRlRIHH6r0ICCXPLpQbOiG9d9ny0bvKNHu/nCQc89C+qjePfMxa2RQhjSWjITzBawd/rtVt
 Hg4t/nZzYBnqmsTll5IUmYvJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:14 -0800
IronPort-SDR: O5Z9LqGarCZzG793qRCNlU5N7gjmN1Hl1gXMrMmv6bXhyYI4Aw608jS2oMQ19R+0QoFa8Y3l2C
 AlHf6Q36LRo6xKqInbf45QeIXIfBgjz+gQE2cAcKY+LZhF2+yp4Vf1C1ze+KUTprvFp3E/buL9
 9eO3fs1jpaAWIsdc6872QTLsmsx6jIlcKaKEzQ8NPnnVX2Lbr/dh42V6iOVVNb/6zhKWsjgbfZ
 /gntG/sT3SyqGWFeZEyWx+rPi2tCHudpYQrhyXWuyX/vqEWGaOfzfcpPSjhbUFRda2CPStLbly
 F5k=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:41 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v13 13/42] btrfs: track unusable bytes for zones
Date:   Fri, 22 Jan 2021 15:21:13 +0900
Message-Id: <b949ad399801a5c5c5a07cafcb259b6151e66e48.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In zoned btrfs a region that was once written then freed is not usable
until we reset the underlying zone. So we need to distinguish such
unusable space from usable free space.

Therefore we need to introduce the "zone_unusable" field  to the block
group structure, and "bytes_zone_unusable" to the space_info structure to
track the unusable space.

Pinned bytes are always reclaimed to the unusable space. But, when an
allocated region is returned before using e.g., the block group becomes
read-only between allocation time and reservation time, we can safely
return the region to the block group. For the situation, this commit
introduces "btrfs_add_free_space_unused". This behaves the same as
btrfs_add_free_space() on regular btrfs. On zoned btrfs, it rewinds the
allocation offset.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      | 39 ++++++++++++++-------
 fs/btrfs/block-group.h      |  1 +
 fs/btrfs/extent-tree.c      | 10 +++++-
 fs/btrfs/free-space-cache.c | 67 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  2 ++
 fs/btrfs/space-info.c       | 13 ++++---
 fs/btrfs/space-info.h       |  4 ++-
 fs/btrfs/sysfs.c            |  2 ++
 fs/btrfs/zoned.c            | 24 +++++++++++++
 fs/btrfs/zoned.h            |  3 ++
 10 files changed, 146 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7c210aa5f25f..487511e3f000 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1001,12 +1001,17 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		WARN_ON(block_group->space_info->total_bytes
 			< block_group->length);
 		WARN_ON(block_group->space_info->bytes_readonly
-			< block_group->length);
+			< block_group->length - block_group->zone_unusable);
+		WARN_ON(block_group->space_info->bytes_zone_unusable
+			< block_group->zone_unusable);
 		WARN_ON(block_group->space_info->disk_total
 			< block_group->length * factor);
 	}
 	block_group->space_info->total_bytes -= block_group->length;
-	block_group->space_info->bytes_readonly -= block_group->length;
+	block_group->space_info->bytes_readonly -=
+		(block_group->length - block_group->zone_unusable);
+	block_group->space_info->bytes_zone_unusable -=
+		block_group->zone_unusable;
 	block_group->space_info->disk_total -= block_group->length * factor;
 
 	spin_unlock(&block_group->space_info->lock);
@@ -1150,7 +1155,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	}
 
 	num_bytes = cache->length - cache->reserved - cache->pinned -
-		    cache->bytes_super - cache->used;
+		    cache->bytes_super - cache->zone_unusable - cache->used;
 
 	/*
 	 * Data never overcommits, even in mixed mode, so do just the straight
@@ -1863,12 +1868,20 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	}
 
 	/*
-	 * Check for two cases, either we are full, and therefore don't need
-	 * to bother with the caching work since we won't find any space, or we
-	 * are empty, and we can just add all the space in and be done with it.
-	 * This saves us _a_lot_ of time, particularly in the full case.
+	 * For zoned btrfs, space after the allocation offset is the only
+	 * free space for a block group. So, we don't need any caching
+	 * work. btrfs_calc_zone_unusable() will set the amount of free
+	 * space and zone_unusable space.
+	 *
+	 * For regular btrfs, check for two cases, either we are full, and
+	 * therefore don't need to bother with the caching work since we
+	 * won't find any space, or we are empty, and we can just add all
+	 * the space in and be done with it.  This saves us _a_lot_ of
+	 * time, particularly in the full case.
 	 */
-	if (cache->length == cache->used) {
+	if (btrfs_is_zoned(info)) {
+		btrfs_calc_zone_unusable(cache);
+	} else if (cache->length == cache->used) {
 		cache->last_byte_to_unpin = (u64)-1;
 		cache->cached = BTRFS_CACHE_FINISHED;
 		btrfs_free_excluded_extents(cache);
@@ -1887,7 +1900,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
 	btrfs_update_space_info(info, cache->flags, cache->length,
-				cache->used, cache->bytes_super, &space_info);
+				cache->used, cache->bytes_super,
+				cache->zone_unusable, &space_info);
 
 	cache->space_info = space_info;
 
@@ -1943,7 +1957,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 			break;
 		}
 		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
-					0, &space_info);
+					0, 0, &space_info);
 		bg->space_info = space_info;
 		link_block_group(bg);
 
@@ -2185,7 +2199,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
 	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, &cache->space_info);
+				cache->bytes_super, 0, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
@@ -2293,7 +2307,8 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 	spin_lock(&cache->lock);
 	if (!--cache->ro) {
 		num_bytes = cache->length - cache->reserved -
-			    cache->pinned - cache->bytes_super - cache->used;
+			    cache->pinned - cache->bytes_super -
+			    cache->zone_unusable - cache->used;
 		sinfo->bytes_readonly -= num_bytes;
 		list_del_init(&cache->ro_list);
 	}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 9d026ab1768d..0f3c62c561bc 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -189,6 +189,7 @@ struct btrfs_block_group {
 	 * allocation. This is used only with ZONED mode enabled.
 	 */
 	u64 alloc_offset;
+	u64 zone_unusable;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 30b1a630dc2f..071a521927e6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -34,6 +34,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "rcu-string.h"
+#include "zoned.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -2725,6 +2726,9 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_free_cluster *ret = NULL;
 
+	if (btrfs_is_zoned(fs_info))
+		return NULL;
+
 	*empty_cluster = 0;
 	if (btrfs_mixed_space_info(space_info))
 		return ret;
@@ -2808,7 +2812,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		space_info->max_extent_size = 0;
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
-		if (cache->ro) {
+		if (btrfs_is_zoned(fs_info)) {
+			/* Need reset before reusing in a zoned block group */
+			space_info->bytes_zone_unusable += len;
+			readonly = true;
+		} else if (cache->ro) {
 			space_info->bytes_readonly += len;
 			readonly = true;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index fd6ddd6b8165..8975a3a1ba49 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2465,6 +2465,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 	u64 filter_bytes = bytes;
 
+	ASSERT(!btrfs_is_zoned(fs_info));
+
 	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
 	if (!info)
 		return -ENOMEM;
@@ -2522,11 +2524,49 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
+					u64 bytenr, u64 size, bool used)
+{
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	u64 offset = bytenr - block_group->start;
+	u64 to_free, to_unusable;
+
+	spin_lock(&ctl->tree_lock);
+	if (!used)
+		to_free = size;
+	else if (offset >= block_group->alloc_offset)
+		to_free = size;
+	else if (offset + size <= block_group->alloc_offset)
+		to_free = 0;
+	else
+		to_free = offset + size - block_group->alloc_offset;
+	to_unusable = size - to_free;
+
+	ctl->free_space += to_free;
+	block_group->zone_unusable += to_unusable;
+	spin_unlock(&ctl->tree_lock);
+	if (!used) {
+		spin_lock(&block_group->lock);
+		block_group->alloc_offset -= size;
+		spin_unlock(&block_group->lock);
+	}
+
+	/* All the region is now unusable. Mark it as unused and reclaim */
+	if (block_group->zone_unusable == block_group->length)
+		btrfs_mark_bg_unused(block_group);
+
+	return 0;
+}
+
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size)
 {
 	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	if (btrfs_is_zoned(block_group->fs_info))
+		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
+						    true);
+
 	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC))
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
 
@@ -2535,6 +2575,16 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
 				      bytenr, size, trim_state);
 }
 
+int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
+				u64 bytenr, u64 size)
+{
+	if (btrfs_is_zoned(block_group->fs_info))
+		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
+						    false);
+
+	return btrfs_add_free_space(block_group, bytenr, size);
+}
+
 /*
  * This is a subtle distinction because when adding free space back in general,
  * we want it to be added as untrimmed for async. But in the case where we add
@@ -2545,6 +2595,10 @@ int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
 {
 	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	if (btrfs_is_zoned(block_group->fs_info))
+		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
+						    true);
+
 	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC) ||
 	    btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
@@ -2562,6 +2616,9 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 	int ret;
 	bool re_search = false;
 
+	if (btrfs_is_zoned(block_group->fs_info))
+		return 0;
+
 	spin_lock(&ctl->tree_lock);
 
 again:
@@ -2656,6 +2713,16 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 	struct rb_node *n;
 	int count = 0;
 
+	/*
+	 * Zoned btrfs does not use free space tree and cluster. Just print
+	 * out the free space after the allocation offset.
+	 */
+	if (btrfs_is_zoned(fs_info)) {
+		btrfs_info(fs_info, "free space %llu",
+			   block_group->length - block_group->alloc_offset);
+		return;
+	}
+
 	spin_lock(&ctl->tree_lock);
 	for (n = rb_first(&ctl->free_space_offset); n; n = rb_next(n)) {
 		info = rb_entry(n, struct btrfs_free_space, offset_index);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index ecb09a02d544..1f23088d43f9 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -107,6 +107,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   enum btrfs_trim_state trim_state);
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size);
+int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
+				u64 bytenr, u64 size);
 int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
 				       u64 bytenr, u64 size);
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 84fb94e78a8f..d006fca277ef 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -163,6 +163,7 @@ u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
 	ASSERT(s_info);
 	return s_info->bytes_used + s_info->bytes_reserved +
 		s_info->bytes_pinned + s_info->bytes_readonly +
+		s_info->bytes_zone_unusable +
 		(may_use_included ? s_info->bytes_may_use : 0);
 }
 
@@ -257,7 +258,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info)
 {
 	struct btrfs_space_info *found;
@@ -273,6 +274,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 	found->bytes_used += bytes_used;
 	found->disk_used += bytes_used * factor;
 	found->bytes_readonly += bytes_readonly;
+	found->bytes_zone_unusable += bytes_zone_unusable;
 	if (total_bytes > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
@@ -422,10 +424,10 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		   info->total_bytes - btrfs_space_info_used(info, true),
 		   info->full ? "" : "not ");
 	btrfs_info(fs_info,
-		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu",
+		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
 		info->total_bytes, info->bytes_used, info->bytes_pinned,
 		info->bytes_reserved, info->bytes_may_use,
-		info->bytes_readonly);
+		info->bytes_readonly, info->bytes_zone_unusable);
 
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
@@ -454,9 +456,10 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	list_for_each_entry(cache, &info->block_groups[index], list) {
 		spin_lock(&cache->lock);
 		btrfs_info(fs_info,
-			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
+			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu zone_unusable %s",
 			cache->start, cache->length, cache->used, cache->pinned,
-			cache->reserved, cache->ro ? "[readonly]" : "");
+			cache->reserved, cache->zone_unusable,
+			cache->ro ? "[readonly]" : "");
 		spin_unlock(&cache->lock);
 		btrfs_dump_free_space(cache, bytes);
 	}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 5646393b928c..ee003ffba956 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -17,6 +17,8 @@ struct btrfs_space_info {
 	u64 bytes_may_use;	/* number of bytes that may be used for
 				   delalloc/allocations */
 	u64 bytes_readonly;	/* total bytes that are read only */
+	u64 bytes_zone_unusable;	/* total bytes that are unusable until
+					   resetting the device zone */
 
 	u64 max_extent_size;	/* This will hold the maximum extent size of
 				   the space info if we had an ENOSPC in the
@@ -119,7 +121,7 @@ DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 					       u64 flags);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 19b9fffa2c9c..6eb1c50fa98c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -666,6 +666,7 @@ SPACE_INFO_ATTR(bytes_pinned);
 SPACE_INFO_ATTR(bytes_reserved);
 SPACE_INFO_ATTR(bytes_may_use);
 SPACE_INFO_ATTR(bytes_readonly);
+SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR(space_info, total_bytes_pinned,
@@ -679,6 +680,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bytes_reserved),
 	BTRFS_ATTR_PTR(space_info, bytes_may_use),
 	BTRFS_ATTR_PTR(space_info, bytes_readonly),
+	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1b85a18d8573..c5100c982f41 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1162,3 +1162,27 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
 	return ret;
 }
+
+void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
+{
+	u64 unusable, free;
+
+	if (!btrfs_is_zoned(cache->fs_info))
+		return;
+
+	WARN_ON(cache->bytes_super != 0);
+	unusable = cache->alloc_offset - cache->used;
+	free = cache->length - cache->alloc_offset;
+
+	/* We only need ->free_space in ALLOC_SEQ BGs */
+	cache->last_byte_to_unpin = (u64)-1;
+	cache->cached = BTRFS_CACHE_FINISHED;
+	cache->free_space_ctl->free_space = free;
+	cache->zone_unusable = unusable;
+
+	/*
+	 * Should not have any excluded extents. Just
+	 * in case, though.
+	 */
+	btrfs_free_excluded_extents(cache);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index b53403ba0b10..0cc0b27e9437 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -42,6 +42,7 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes);
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new);
+void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -124,6 +125,8 @@ static inline int btrfs_load_block_group_zone_info(
 	return 0;
 }
 
+static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

