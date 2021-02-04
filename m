Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73D430F0A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhBDK0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:26:03 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54222 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbhBDKZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434341; x=1643970341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trJ2EGQlEiBqjqsTPQXLmbjJsHUH3vhP9lv2CW9qCIQ=;
  b=h8JH3CRUxlgqMfJRn1VsZNsWNBGWJz+JZksHuL9WKdp9qgVPOg8Opf2F
   rvoVVjvLiFiV8qv7cDYwY8nNpgAM/xiSlrmDQliJ7ZmXNlH5bfWHGUWpT
   8R4hanxoMorTZRjNomf17aZMO3C+uS3dS/dFmgdP0HHLAK4zWlhgDOI5F
   cuiqG/gDwcjJC3Cw2VydRSjzTxque50Df/zQtqsUVbl3ibgSqEW9EVCyp
   djNc/5sfOQqr+LgbgOyffmMt162DjOlYYDofdxInXiVxl0v8oj5ZTYZPT
   3b7NN8TF36tMGtJEsja9gvYDVB7tgYyG7ksXLsYIixryRa8jqKgRf6tcD
   Q==;
IronPort-SDR: 78news2EPghfgoEc1uJCN3pgO/htCI8NDNomxtqR7P0LGJnGfWnTgeSlPbLdbeKnZDbJpQDMRg
 9UFf1xQWeG4101cyzimFjPYdX51u3AwjNhKt+U7sGmcHNpk3qpiXOKggubS/TG34Fnqwf+o9vZ
 B53bK9ul0PVkfmzOVi//i12M1sTjn+yUvVzZM0DUgSws+IBAtVo9zlOVTjQXMq8vTMgr12abDJ
 ZF5SuWpC0TYUBb/GNx+Y26Fa5NXSNs/N/UwTrIY9TtNRsh115hGdZpqli6xm78wztKw1QMFKAo
 0SI=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107991"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:13 +0800
IronPort-SDR: ISITwNvU0uymYOAnzHwglUya1DyC8cCp9N4gmCMQy5mPL+hh43fKsamfQRNrgibJlk21ci/a5T
 dIaOfELa3EmLHrIBBevZDOHQa3dZIPooI3Z9OTnHGE2lELPyMDtKgtpuvljiZf3bLAizrjJtga
 10b9/SOa6UCJADz27pBOag/llK6+ka2rUzRLcNq6NnPVD09kvykojrFp7HUVagHO71nL1WCcHj
 Un7RLyvw7Lj9DIPG3f5kETQw2Ao/2JIx1QgBcmfOTeuWKUshzfF/4NzGtfcC2esdIWBhzi+R03
 jCDxolfkCXwdmZs0Kml3zLXj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:17 -0800
IronPort-SDR: cvNif6zSiZBYjxwfWvC4tnj5UG/DfI4AIiwD+nK3F+1k9CHAufMP/DV81KF1x6LvVc/8ZdIZ96
 wXxLKdCqHw7F91OCns+CyWPx8uTBjwWmTux0gWRKitxl/lE2LWNFmyaizpK17vbrCeu0Y8crUQ
 TXzj1jCraORc0j/V1h3a0tDhZzCTFXWxOB6I79lVvbQ6R0ZTtuGtjhjhSudHNG78MiIKu07dlP
 BXSSDlo251XXX9MYnXEYY1GKTLlux6LKGKL5nRw4ZGToUevcE+qFkpKFUinBuoLJIcAeL2nl7R
 XIQ=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:12 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 13/42] btrfs: zoned: track unusable bytes for zones
Date:   Thu,  4 Feb 2021 19:21:52 +0900
Message-Id: <6cec864c4cad33c0064e6d3623a96390899103ef.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In a zoned filesystem a once written then freed region is not usable
until the underlying zone has been reset. So we need to distinguish such
unusable space from usable free space.

Therefore we need to introduce the "zone_unusable" field to the block
group structure, and "bytes_zone_unusable" to the space_info structure
to track the unusable space.

Pinned bytes are always reclaimed to the unusable space. But, when an
allocated region is returned before using e.g., the block group becomes
read-only between allocation time and reservation time, we can safely
return the region to the block group. For the situation, this commit
introduces "btrfs_add_free_space_unused". This behaves the same as
btrfs_add_free_space() on regular filesystem. On zoned filesystems, it
rewinds the allocation offset.

Because the read-only bytes tracks free but unusable bytes when the block
group is read-only, we need to migrate the zone_unusable bytes to
read-only bytes when a block group is marked read-only.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      | 51 +++++++++++++++++++++-------
 fs/btrfs/block-group.h      |  1 +
 fs/btrfs/extent-tree.c      |  5 +++
 fs/btrfs/free-space-cache.c | 67 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  2 ++
 fs/btrfs/space-info.c       | 13 ++++---
 fs/btrfs/space-info.h       |  4 ++-
 fs/btrfs/sysfs.c            |  2 ++
 fs/btrfs/zoned.c            | 21 ++++++++++++
 fs/btrfs/zoned.h            |  3 ++
 10 files changed, 151 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6d10874189df..e4444d4dd4b5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1009,12 +1009,17 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
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
@@ -1158,7 +1163,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	}
 
 	num_bytes = cache->length - cache->reserved - cache->pinned -
-		    cache->bytes_super - cache->used;
+		    cache->bytes_super - cache->zone_unusable - cache->used;
 
 	/*
 	 * Data never overcommits, even in mixed mode, so do just the straight
@@ -1189,6 +1194,12 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 
 	if (!ret) {
 		sinfo->bytes_readonly += num_bytes;
+		if (btrfs_is_zoned(cache->fs_info)) {
+			/* Migrate zone_unusable bytes to readonly */
+			sinfo->bytes_readonly += cache->zone_unusable;
+			sinfo->bytes_zone_unusable -= cache->zone_unusable;
+			cache->zone_unusable = 0;
+		}
 		cache->ro++;
 		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
 	}
@@ -1876,12 +1887,20 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	}
 
 	/*
-	 * Check for two cases, either we are full, and therefore don't need
-	 * to bother with the caching work since we won't find any space, or we
-	 * are empty, and we can just add all the space in and be done with it.
-	 * This saves us _a_lot_ of time, particularly in the full case.
+	 * For zoned filesystem, space after the allocation offset is the only
+	 * free space for a block group. So, we don't need any caching work.
+	 * btrfs_calc_zone_unusable() will set the amount of free space and
+	 * zone_unusable space.
+	 *
+	 * For regular filesystem, check for two cases, either we are full, and
+	 * therefore don't need to bother with the caching work since we won't
+	 * find any space, or we are empty, and we can just add all the space
+	 * in and be done with it.  This saves us _a_lot_ of time, particularly
+	 * in the full case.
 	 */
-	if (cache->length == cache->used) {
+	if (btrfs_is_zoned(info)) {
+		btrfs_calc_zone_unusable(cache);
+	} else if (cache->length == cache->used) {
 		cache->last_byte_to_unpin = (u64)-1;
 		cache->cached = BTRFS_CACHE_FINISHED;
 		btrfs_free_excluded_extents(cache);
@@ -1900,7 +1919,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
 	btrfs_update_space_info(info, cache->flags, cache->length,
-				cache->used, cache->bytes_super, &space_info);
+				cache->used, cache->bytes_super,
+				cache->zone_unusable, &space_info);
 
 	cache->space_info = space_info;
 
@@ -1956,7 +1976,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 			break;
 		}
 		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
-					0, &space_info);
+					0, 0, &space_info);
 		bg->space_info = space_info;
 		link_block_group(bg);
 
@@ -2197,7 +2217,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
 	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, &cache->space_info);
+				cache->bytes_super, 0, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
@@ -2305,8 +2325,15 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 	spin_lock(&cache->lock);
 	if (!--cache->ro) {
 		num_bytes = cache->length - cache->reserved -
-			    cache->pinned - cache->bytes_super - cache->used;
+			    cache->pinned - cache->bytes_super -
+			    cache->zone_unusable - cache->used;
 		sinfo->bytes_readonly -= num_bytes;
+		if (btrfs_is_zoned(cache->fs_info)) {
+			/* Migrate zone_unusable bytes back */
+			cache->zone_unusable = cache->alloc_offset - cache->used;
+			sinfo->bytes_zone_unusable += cache->zone_unusable;
+			sinfo->bytes_readonly -= cache->zone_unusable;
+		}
 		list_del_init(&cache->ro_list);
 	}
 	spin_unlock(&cache->lock);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 224946fa9bed..0fd66febe115 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -189,6 +189,7 @@ struct btrfs_block_group {
 	 * allocation. This is used only on a zoned filesystem.
 	 */
 	u64 alloc_offset;
+	u64 zone_unusable;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5476ab84e544..5c61c3f136f7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -34,6 +34,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "rcu-string.h"
+#include "zoned.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -2740,6 +2741,10 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		if (cache->ro) {
 			space_info->bytes_readonly += len;
 			readonly = true;
+		} else if (btrfs_is_zoned(fs_info)) {
+			/* Need reset before reusing in a zoned block group */
+			space_info->bytes_zone_unusable += len;
+			readonly = true;
 		}
 		spin_unlock(&cache->lock);
 		if (!readonly && return_free_space &&
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6134e10a6e7f..b93ac31eca69 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2477,6 +2477,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 	u64 filter_bytes = bytes;
 
+	ASSERT(!btrfs_is_zoned(fs_info));
+
 	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
 	if (!info)
 		return -ENOMEM;
@@ -2534,11 +2536,49 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
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
 
@@ -2547,6 +2587,16 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
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
@@ -2557,6 +2607,10 @@ int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
 {
 	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	if (btrfs_is_zoned(block_group->fs_info))
+		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
+						    true);
+
 	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC) ||
 	    btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
@@ -2574,6 +2628,9 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 	int ret;
 	bool re_search = false;
 
+	if (btrfs_is_zoned(block_group->fs_info))
+		return 0;
+
 	spin_lock(&ctl->tree_lock);
 
 again:
@@ -2668,6 +2725,16 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group,
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
index bccd98141a6e..2da6177f4b0b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -169,6 +169,7 @@ u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
 	ASSERT(s_info);
 	return s_info->bytes_used + s_info->bytes_reserved +
 		s_info->bytes_pinned + s_info->bytes_readonly +
+		s_info->bytes_zone_unusable +
 		(may_use_included ? s_info->bytes_may_use : 0);
 }
 
@@ -264,7 +265,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info)
 {
 	struct btrfs_space_info *found;
@@ -280,6 +281,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 	found->bytes_used += bytes_used;
 	found->disk_used += bytes_used * factor;
 	found->bytes_readonly += bytes_readonly;
+	found->bytes_zone_unusable += bytes_zone_unusable;
 	if (total_bytes > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
@@ -429,10 +431,10 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
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
@@ -461,9 +463,10 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
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
index e237156ce888..b1a8ffb03b3e 100644
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
@@ -123,7 +125,7 @@ DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
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
index b892566a1c93..c5f9f4c6f20b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1160,3 +1160,24 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
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
+	/* We only need ->free_space in ALLOC_SEQ block groups */
+	cache->last_byte_to_unpin = (u64)-1;
+	cache->cached = BTRFS_CACHE_FINISHED;
+	cache->free_space_ctl->free_space = free;
+	cache->zone_unusable = unusable;
+
+	/* Should not have any excluded extents. Just in case, though */
+	btrfs_free_excluded_extents(cache);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index d27db3993e51..37304d1675e6 100644
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
@@ -123,6 +124,8 @@ static inline int btrfs_load_block_group_zone_info(
 	return 0;
 }
 
+static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.30.0

