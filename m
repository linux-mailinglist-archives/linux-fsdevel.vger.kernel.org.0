Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267AC2E04F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgLVDxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:53:17 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46436 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgLVDxR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609197; x=1640145197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V4G3HrjXg2KOqy7Cr6RLwwbBYSzX5YEo1H5goIZEfIk=;
  b=N4efL5/vb9FdDlvd3rT3Sqn93/o1ryz9LJC8tZYK6MP8rqITCwu0zH2W
   gVs6nzlQcmYpeHiYL9DPl2P9sIVKfyP4X1Gl2jP5YoTYU0LLVepZ3pLCp
   ZtboNJAGzBcZaAHjDzGUZjKXUlVOJpCRf+DgR6cf1TaVefxs4UMLoFuuh
   /WzBddMt/qydZ266FcM//NGayukyGUFA3o7meDc0EKeMTL0uQvtS1yEvF
   sGz4d66Usxipxc1nHlPao0qZPemZgJ3S98EVYZOrin0F3tb4VH0Wij5RN
   kKhXjy30BAstt49KSfrKt8uygJhXSFGEIGfyHEkhvDmLsbXNNVTFDeUuP
   A==;
IronPort-SDR: zPHTWSIwHeK5D6/KmByrGzxV7SvPHUoQ6jgZ5gumFqZML15HBc6etv5n2pljna1bv0+v6FLp46
 sCFi6ZxgyERy8O7P9rK7CipW2dQV/U7XgBv8iwXcj8IVs5zkSjGnauM+UIuEs6pQ5/vZBnonDw
 n9kIVc6bhjk1HatCszTTJ8mGjhI3OX2IUrPgb0OdqeWHf3irtD+47PFvQnQ4ycwuvMjw7MohVi
 mgpanaa8YlaONAj4bobeSKPPLiTu4rNRXZSduNFXG284I0IXcOvnZrS/eG7ifwxHbj8HWF1X7/
 Pts=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193768"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:45 +0800
IronPort-SDR: JlAgvpKtNDH+mE9ZzJYQz0CmmmypmOTM1kBp8b0754oFCGgVIH9UcUrZg9/PeNgHglh55SitnO
 j4muoawzvYToDUT2jry3wITs3w3Y6CroMYpRX59fUTPn/IOL7TdmA6U2EvNOE9/Tehsv1YcIUi
 O6GhdwwReHWghjMdwqmgCDsLLIn0hW6A/2MIDgZvjQZSTE+LZRDdOK0rMPBmTICmvOfgZSfO34
 wzlrxvQZ0driab4Mr7496+rYvw7t6pwWeqGLljwqoG0REtM2XhteRBZIgUUTvbYtt8VTY2XH2t
 4Un8LEyT0nTeNnBfEpPSRTDO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:56 -0800
IronPort-SDR: t8rhPH/Be0ixWPVZ8CU1sV2ApDkWNxTnTQHY0cmhOOR2QsQZnTxJqQKD/u3Ls/IgEon6X1MW0T
 Gr1Dnc21cB88j0ndkBkIahC8fNq05wgCdCnosnyMwZdWVAtOnODXhbMa+Ux8oDu54UcFu0SQf2
 MsXA5qTegxjF0sD1iSh4QoFGmpXq40THLAKYjXtByEG2r01hfP/NIEfNkR6DPmaWYBniv0pfmW
 xCDOthg98k2KPw3Xd+HBdIac4xbllzR/r9R6b3ZB3m9ulNXGKDAfZy2GggH0rdgVVRzUo4brsk
 GhE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:44 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 13/40] btrfs: track unusable bytes for zones
Date:   Tue, 22 Dec 2020 12:49:06 +0900
Message-Id: <43075f585c6866abcf2b4e000f4481159b39d78a.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
 fs/btrfs/block-group.c      | 23 ++++++++++-----
 fs/btrfs/block-group.h      |  1 +
 fs/btrfs/extent-tree.c      | 10 ++++++-
 fs/btrfs/free-space-cache.c | 57 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  2 ++
 fs/btrfs/space-info.c       | 13 +++++----
 fs/btrfs/space-info.h       |  4 ++-
 fs/btrfs/sysfs.c            |  2 ++
 fs/btrfs/zoned.c            | 24 ++++++++++++++++
 fs/btrfs/zoned.h            |  3 ++
 10 files changed, 125 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9eb1e3aa5e0f..33c5c47ebbc3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1010,12 +1010,17 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
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
@@ -1159,7 +1164,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	}
 
 	num_bytes = cache->length - cache->reserved - cache->pinned -
-		    cache->bytes_super - cache->used;
+		    cache->bytes_super - cache->zone_unusable - cache->used;
 
 	/*
 	 * Data never overcommits, even in mixed mode, so do just the straight
@@ -1904,6 +1909,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		btrfs_free_excluded_extents(cache);
 	}
 
+	btrfs_calc_zone_unusable(cache);
+
 	ret = btrfs_add_block_group_cache(info, cache);
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
@@ -1911,7 +1918,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
 	btrfs_update_space_info(info, cache->flags, cache->length,
-				cache->used, cache->bytes_super, &space_info);
+				cache->used, cache->bytes_super,
+				cache->zone_unusable, &space_info);
 
 	cache->space_info = space_info;
 
@@ -1967,7 +1975,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 			break;
 		}
 		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
-					0, &space_info);
+					0, 0, &space_info);
 		bg->space_info = space_info;
 		link_block_group(bg);
 
@@ -2197,7 +2205,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
 	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, &cache->space_info);
+				cache->bytes_super, 0, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
@@ -2305,7 +2313,8 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
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
index d79b8369e6aa..043a2fe79270 100644
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
index fd6ddd6b8165..5a5c2c527dd5 100644
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
index 67e55c5479b8..025349c5c439 100644
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
index 4522a1c4cd08..cf7e766f7c58 100644
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
index ceb6d0d7d33b..02373a7433b8 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1127,3 +1127,27 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
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

