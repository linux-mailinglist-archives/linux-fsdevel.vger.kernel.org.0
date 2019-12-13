Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132F711DCDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbfLMELB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:01 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11896 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbfLMELA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210260; x=1607746260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N7smVG2PAlLI4UsK6ojVMXeCUPxTXRdgwd70Ll2x+No=;
  b=KSYOSsridr/EE0rOYCEMTQiOjAeltoeWIkpLi4K8Vt+P6HXQ9m1rOP1A
   ZaClMByeUtzjuVcu2RNM0xBrErStho+kQovsfDLty/bHOo999E0gWYnpL
   XyNCOOs+hBQFgYNrSLN/1t/cspocXY7UV4YPLK3AtO+wyliYMxNzBreMW
   bO+R5YcnB53BKGfoSjK3mzLZ/xj8lkwjQZEmvuTpsS8sTuxGGo6Vu+1lb
   58MsZZHckqRUUbHoIfj6wNtzm1kILziAEycalw5d1yOGdwVvwKqSxzIL3
   RHvk1eYan1hilFIWUQpbwCJjBXe4Ipz7V2flC67SuNb9IbWZlh7fPWJ/v
   Q==;
IronPort-SDR: 5kf4JAuzqyZoNzmcy1z6JyeVq7TPpo9WnLNDrpu/92ndKr9V9BsYZalmYL2WmmorMQUwQOUzUr
 od1IC0CvKudWLtlGLXSqWDBjwrmo0yhqYV+V58aF4RlSPOLd0OMa87p6WBzfOsb7x3oPetNH6f
 +N7Mhw0HUe8RCxoXT9VUDp7q8F4I6wn2lR+P+pMSPOULHyTwckBqb9CNSt2/ie3mKBBylB/RaL
 osB3J9NgxUXl3k7pGzFppQkyfveWXNlRIX82Ebr8JjjsZf25W0PohjxugGtAjdVfDdUAdD1KaE
 QMA=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860126"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:10:59 +0800
IronPort-SDR: qawupxtBt59ErM9H91mscodMuW8LLXow7mceFYvsJs1Q6QLzWXQ5uH2CfOOxpweU07QCwH0pmc
 2/DfKHzKAaDzjsmYwS5jwO/wnI1oyZUOZ+Jut4uwbZeA1tJJNQxc5RsvRkZ94LA6CaHjfRVitH
 gAbAq9r0xrVl2IXOrGHxnK254LneSk18qc/SfIWHIjSgiS5Z6CDsILzhjYyE1/4ZGbrIAfm4uh
 Uem5rlMnpNZfOBDu7S8GaIoY78oTv3bMy4CiMd211BOTr+wXSwsh1AFUTRhXnOOqTcb1YpC5en
 cQYZoqLiRnSquTHY55XbxXzq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:31 -0800
IronPort-SDR: 1pr7j1njEOGMgrFoAL1p4PZ/18PF83IsjHqWpAVsfvUbHRUr92EelTk9Npbqs8f6y55N1cNpQp
 G7sCDhC/oZPcF63F74vJ/2payZZUL3aH047uJGE1vca3IcI4d4BI95TkYYE14Rf5T3u5RcStNC
 BvJ4k/gM/c8Bpmvz+JyNxgWA5q41LUAQWs6zVrX1f6eQfdaUerctNw2IFAB0goIctBHK07OEKG
 h6gkXTpNRqWwM0F+TR8a6oOqvtES7nI5nCdrQtsCDNvWoLk81bslv9EuUPUnrHTUpXI8jCN0sn
 JXI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:10:57 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 10/28] btrfs: do sequential extent allocation in HMZONED mode
Date:   Fri, 13 Dec 2019 13:08:57 +0900
Message-Id: <20191213040915.3502922-11-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On HMZONED drives, writes must always be sequential and directed at a block
group zone write pointer position. Thus, block allocation in a block group
must also be done sequentially using an allocation pointer equal to the
block group zone write pointer plus the number of blocks allocated but not
yet written.

Sequential allocation function find_free_extent_zoned() bypass the checks
in find_free_extent() and increase the reserved byte counter by itself. It
is impossible to revert once allocated region in the sequential allocation,
since it might race with other allocations and leave an allocation hole,
which breaks the sequential write rule.

Furthermore, this commit introduce two new variable to struct
btrfs_block_group. "wp_broken" indicate that write pointer is broken (e.g.
not synced on a RAID1 block group) and mark that block group read only.
"zone_unusable" keeps track of the size of once allocated then freed region
in a block group. Such region is never usable until resetting underlying
zones.

This commit also introduce "bytes_zone_unusable" to track such unusable
bytes in a space_info. Pinned bytes are always reclaimed to
"bytes_zone_unusable". They are not usable until resetting them first.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      |  74 ++++--
 fs/btrfs/block-group.h      |  11 +
 fs/btrfs/extent-tree.c      |  80 +++++-
 fs/btrfs/free-space-cache.c |  38 +++
 fs/btrfs/free-space-cache.h |   2 +
 fs/btrfs/hmzoned.c          | 467 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h          |   8 +
 fs/btrfs/space-info.c       |  13 +-
 fs/btrfs/space-info.h       |   4 +-
 fs/btrfs/sysfs.c            |   2 +
 10 files changed, 672 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index acfa0a9d3c5a..5c04422f6f5a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -14,6 +14,7 @@
 #include "sysfs.h"
 #include "tree-log.h"
 #include "delalloc-space.h"
+#include "hmzoned.h"
 
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
@@ -677,6 +678,9 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	struct btrfs_caching_control *caching_ctl;
 	int ret = 0;
 
+	if (btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
+
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
@@ -1048,12 +1052,15 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
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
 	block_group->space_info->disk_total -= block_group->length * factor;
 
 	spin_unlock(&block_group->space_info->lock);
@@ -1210,7 +1217,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	}
 
 	num_bytes = cache->length - cache->reserved - cache->pinned -
-		    cache->bytes_super - cache->used;
+		    cache->bytes_super - cache->zone_unusable - cache->used;
 	sinfo_used = btrfs_space_info_used(sinfo, true);
 
 	/*
@@ -1736,6 +1743,13 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 			goto error;
 	}
 
+	ret = btrfs_load_block_group_zone_info(cache);
+	if (ret) {
+		btrfs_err(info, "failed to load zone info of bg %llu",
+			  cache->start);
+		goto error;
+	}
+
 	/*
 	 * We need to exclude the super stripes now so that the space info has
 	 * super bytes accounted for, otherwise we'll think we have more space
@@ -1766,6 +1780,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		btrfs_free_excluded_extents(cache);
 	}
 
+	btrfs_calc_zone_unusable(cache);
+
 	ret = btrfs_add_block_group_cache(info, cache);
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
@@ -1773,7 +1789,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
 	btrfs_update_space_info(info, cache->flags, key->offset,
-				cache->used, cache->bytes_super, &space_info);
+				cache->used, cache->bytes_super,
+				cache->zone_unusable, &space_info);
 
 	cache->space_info = space_info;
 
@@ -1786,6 +1803,10 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		ASSERT(list_empty(&cache->bg_list));
 		btrfs_mark_bg_unused(cache);
 	}
+
+	if (cache->wp_broken)
+		inc_block_group_ro(cache, 1);
+
 	return 0;
 error:
 	btrfs_put_block_group(cache);
@@ -1924,6 +1945,13 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	cache->last_byte_to_unpin = (u64)-1;
 	cache->cached = BTRFS_CACHE_FINISHED;
 	cache->needs_free_space = 1;
+
+	ret = btrfs_load_block_group_zone_info(cache);
+	if (ret) {
+		btrfs_put_block_group(cache);
+		return ret;
+	}
+
 	ret = exclude_super_stripes(cache);
 	if (ret) {
 		/* We may have excluded something, so call this just in case */
@@ -1965,7 +1993,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
 	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, &cache->space_info);
+				cache->bytes_super, 0, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
@@ -2121,7 +2149,8 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 	spin_lock(&cache->lock);
 	if (!--cache->ro) {
 		num_bytes = cache->length - cache->reserved -
-			    cache->pinned - cache->bytes_super - cache->used;
+			    cache->pinned - cache->bytes_super -
+			    cache->zone_unusable - cache->used;
 		sinfo->bytes_readonly -= num_bytes;
 		list_del_init(&cache->ro_list);
 	}
@@ -2760,6 +2789,21 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+void __btrfs_add_reserved_bytes(struct btrfs_block_group *cache, u64 ram_bytes,
+				u64 num_bytes, int delalloc)
+{
+	struct btrfs_space_info *space_info = cache->space_info;
+
+	cache->reserved += num_bytes;
+	space_info->bytes_reserved += num_bytes;
+	trace_btrfs_space_reservation(cache->fs_info, "space_info",
+				      space_info->flags, num_bytes, 1);
+	btrfs_space_info_update_bytes_may_use(cache->fs_info, space_info,
+					      -ram_bytes);
+	if (delalloc)
+		cache->delalloc_bytes += num_bytes;
+}
+
 /**
  * btrfs_add_reserved_bytes - update the block_group and space info counters
  * @cache:	The cache we are manipulating
@@ -2778,20 +2822,16 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 	struct btrfs_space_info *space_info = cache->space_info;
 	int ret = 0;
 
+	/* should handled by find_free_extent_zoned */
+	ASSERT(!btrfs_fs_incompat(cache->fs_info, HMZONED));
+
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
-	if (cache->ro) {
+	if (cache->ro)
 		ret = -EAGAIN;
-	} else {
-		cache->reserved += num_bytes;
-		space_info->bytes_reserved += num_bytes;
-		trace_btrfs_space_reservation(cache->fs_info, "space_info",
-					      space_info->flags, num_bytes, 1);
-		btrfs_space_info_update_bytes_may_use(cache->fs_info,
-						      space_info, -ram_bytes);
-		if (delalloc)
-			cache->delalloc_bytes += num_bytes;
-	}
+	else
+		__btrfs_add_reserved_bytes(cache, ram_bytes, num_bytes,
+					   delalloc);
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 9b409676c4b2..347605654021 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -82,6 +82,7 @@ struct btrfs_block_group {
 	unsigned int iref:1;
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
+	unsigned int wp_broken:1;
 
 	int disk_cache_state;
 
@@ -156,6 +157,14 @@ struct btrfs_block_group {
 
 	/* Record locked full stripes for RAID5/6 block group */
 	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
+
+	u64 zone_unusable;
+	/*
+	 * Allocation offset for the block group to implement
+	 * sequential allocation. This is used only with HMZONED mode
+	 * enabled.
+	 */
+	u64 alloc_offset;
 };
 
 #ifdef CONFIG_BTRFS_DEBUG
@@ -216,6 +225,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 num_bytes, int alloc);
 int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 			     u64 ram_bytes, u64 num_bytes, int delalloc);
+void __btrfs_add_reserved_bytes(struct btrfs_block_group *cache, u64 ram_bytes,
+				u64 num_bytes, int delalloc);
 void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 			       u64 num_bytes, int delalloc);
 int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 153f71a5bba9..3781a3778696 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -32,6 +32,8 @@
 #include "block-rsv.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "rcu-string.h"
+#include "hmzoned.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -2824,9 +2826,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			cache = btrfs_lookup_block_group(fs_info, start);
 			BUG_ON(!cache); /* Logic error */
 
-			cluster = fetch_cluster_info(fs_info,
-						     cache->space_info,
-						     &empty_cluster);
+			if (!btrfs_fs_incompat(fs_info, HMZONED))
+				cluster = fetch_cluster_info(fs_info,
+							     cache->space_info,
+							     &empty_cluster);
+
 			empty_cluster <<= 1;
 		}
 
@@ -2863,7 +2867,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		space_info->max_extent_size = 0;
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
-		if (cache->ro) {
+		if (btrfs_fs_incompat(fs_info, HMZONED)) {
+			/* need reset before reusing in zoned Block Group */
+			space_info->bytes_zone_unusable += len;
+			readonly = true;
+		} else if (cache->ro) {
 			space_info->bytes_readonly += len;
 			readonly = true;
 		}
@@ -3657,6 +3665,57 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
 	return 0;
 }
 
+/*
+ * Simple allocator for sequential only block group. It only allows
+ * sequential allocation. No need to play with trees. This function
+ * also reserve the bytes as in btrfs_add_reserved_bytes.
+ */
+
+static int find_free_extent_zoned(struct btrfs_block_group *cache,
+				  struct find_free_extent_ctl *ffe_ctl)
+{
+	struct btrfs_space_info *space_info = cache->space_info;
+	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
+	u64 start = cache->start;
+	u64 num_bytes = ffe_ctl->num_bytes;
+	u64 avail;
+	int ret = 0;
+
+	ASSERT(btrfs_fs_incompat(cache->fs_info, HMZONED));
+
+	spin_lock(&space_info->lock);
+	spin_lock(&cache->lock);
+
+	if (cache->ro) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	avail = cache->length - cache->alloc_offset;
+	if (avail < num_bytes) {
+		ffe_ctl->max_extent_size = avail;
+		ret = 1;
+		goto out;
+	}
+
+	ffe_ctl->found_offset = start + cache->alloc_offset;
+	cache->alloc_offset += num_bytes;
+	spin_lock(&ctl->tree_lock);
+	ctl->free_space -= num_bytes;
+	spin_unlock(&ctl->tree_lock);
+
+	ASSERT(IS_ALIGNED(ffe_ctl->found_offset,
+			  cache->fs_info->stripesize));
+	ffe_ctl->search_start = ffe_ctl->found_offset;
+	__btrfs_add_reserved_bytes(cache, ffe_ctl->ram_bytes, num_bytes,
+				   ffe_ctl->delalloc);
+
+out:
+	spin_unlock(&cache->lock);
+	spin_unlock(&space_info->lock);
+	return ret;
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -3803,6 +3862,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_group *block_group = NULL;
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
+	bool hmzoned = btrfs_fs_incompat(fs_info, HMZONED);
 	bool use_cluster = true;
 	bool full_search = false;
 
@@ -3965,6 +4025,17 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
 			goto loop;
 
+		if (hmzoned) {
+			ret = find_free_extent_zoned(block_group, &ffe_ctl);
+			if (ret)
+				goto loop;
+			/*
+			 * find_free_space_seq should ensure that
+			 * everything is OK and reserve the extent.
+			 */
+			goto nocheck;
+		}
+
 		/*
 		 * Ok we want to try and use the cluster allocator, so
 		 * lets look there
@@ -4020,6 +4091,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 					     num_bytes);
 			goto loop;
 		}
+nocheck:
 		btrfs_inc_block_group_reservations(block_group);
 
 		/* we are all good, lets return */
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3283da419200..e068325fcfc0 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2336,6 +2336,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	struct btrfs_free_space *info;
 	int ret = 0;
 
+	ASSERT(!btrfs_fs_incompat(fs_info, HMZONED));
+
 	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
 	if (!info)
 		return -ENOMEM;
@@ -2384,9 +2386,36 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+int __btrfs_add_free_space_seq(struct btrfs_block_group *block_group,
+			       u64 bytenr, u64 size)
+{
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	u64 offset = bytenr - block_group->start;
+	u64 to_free, to_unusable;
+
+	spin_lock(&ctl->tree_lock);
+	if (block_group->wp_broken)
+		to_free = 0;
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
+	return 0;
+}
+
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size)
 {
+	if (btrfs_fs_incompat(block_group->fs_info, HMZONED))
+		return __btrfs_add_free_space_seq(block_group, bytenr, size);
+
 	return __btrfs_add_free_space(block_group->fs_info,
 				      block_group->free_space_ctl,
 				      bytenr, size);
@@ -2400,6 +2429,9 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 	int ret;
 	bool re_search = false;
 
+	if (btrfs_fs_incompat(block_group->fs_info, HMZONED))
+		return 0;
+
 	spin_lock(&ctl->tree_lock);
 
 again:
@@ -2635,6 +2667,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 align_gap = 0;
 	u64 align_gap_len = 0;
 
+	ASSERT(!btrfs_fs_incompat(block_group->fs_info, HMZONED));
+
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
 				block_group->full_stripe_len, max_extent_size);
@@ -2754,6 +2788,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 	struct rb_node *node;
 	u64 ret = 0;
 
+	ASSERT(!btrfs_fs_incompat(block_group->fs_info, HMZONED));
+
 	spin_lock(&cluster->lock);
 	if (bytes > cluster->max_size)
 		goto out;
@@ -3401,6 +3437,8 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 {
 	int ret;
 
+	ASSERT(!btrfs_fs_incompat(block_group->fs_info, HMZONED));
+
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index ba9a23241101..0d3812bbb793 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -84,6 +84,8 @@ void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group);
 int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   struct btrfs_free_space_ctl *ctl,
 			   u64 bytenr, u64 size);
+int __btrfs_add_free_space_seq(struct btrfs_block_group *block_group,
+			       u64 bytenr, u64 size);
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size);
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 6263c8aee082..b067fa84b9a1 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -8,14 +8,21 @@
 
 #include <linux/slab.h>
 #include <linux/blkdev.h>
+#include <linux/sched/mm.h>
 #include "ctree.h"
 #include "volumes.h"
 #include "hmzoned.h"
 #include "rcu-string.h"
 #include "disk-io.h"
+#include "block-group.h"
+#include "locking.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
+/* Invalid allocation pointer value for missing devices */
+#define WP_MISSING_DEV ((u64)-1)
+/* Pseudo write pointer value for conventional zone */
+#define WP_CONVENTIONAL ((u64)-2)
 
 static int sb_write_pointer(struct blk_zone *zone, u64 *wp_ret);
 
@@ -605,3 +612,463 @@ bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 
 	return find_next_bit(zinfo->seq_zones, end, begin) == end;
 }
+
+void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
+{
+	u64 unusable, free;
+
+	if (!btrfs_fs_incompat(cache->fs_info, HMZONED))
+		return;
+
+	WARN_ON(cache->bytes_super != 0);
+	if (!cache->wp_broken) {
+		unusable = cache->alloc_offset - cache->used;
+		free = cache->length - cache->alloc_offset;
+	} else {
+		unusable = cache->length - cache->used;
+		free = 0;
+	}
+	/* we only need ->free_space in ALLOC_SEQ BGs */
+	cache->last_byte_to_unpin = (u64)-1;
+	cache->cached = BTRFS_CACHE_FINISHED;
+	cache->free_space_ctl->free_space = free;
+	cache->zone_unusable = unusable;
+	/*
+	 * Should not have any excluded extents. Just
+	 * in case, though.
+	 */
+	btrfs_free_excluded_extents(cache);
+}
+
+static int emulate_write_pointer(struct btrfs_block_group *cache,
+				 u64 *offset_ret)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	struct btrfs_key search_key;
+	struct btrfs_key found_key;
+	int slot;
+	int ret;
+	u64 length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	search_key.objectid = cache->start + cache->length;
+	search_key.type = 0;
+	search_key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	ASSERT(ret != 0);
+	slot = path->slots[0];
+	leaf = path->nodes[0];
+	ASSERT(slot != 0);
+	slot--;
+	btrfs_item_key_to_cpu(leaf, &found_key, slot);
+
+	if (found_key.objectid < cache->start) {
+		*offset_ret = 0;
+	} else if (found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
+		struct btrfs_key extent_item_key;
+
+		if (found_key.objectid != cache->start) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+
+		length = 0;
+
+		/* metadata may have METADATA_ITEM_KEY */
+		if (slot == 0) {
+			btrfs_set_path_blocking(path);
+			ret = btrfs_prev_leaf(root, path);
+			if (ret < 0)
+				goto out;
+			if (ret == 0) {
+				slot = btrfs_header_nritems(leaf) - 1;
+				btrfs_item_key_to_cpu(leaf, &extent_item_key,
+						      slot);
+			}
+		} else {
+			btrfs_item_key_to_cpu(leaf, &extent_item_key, slot - 1);
+			ret = 0;
+		}
+
+		if (ret == 0 &&
+		    extent_item_key.objectid == cache->start) {
+			if (extent_item_key.type == BTRFS_METADATA_ITEM_KEY)
+				length = fs_info->nodesize;
+			else if (extent_item_key.type == BTRFS_EXTENT_ITEM_KEY)
+				length = extent_item_key.offset;
+			else {
+				ret = -EUCLEAN;
+				goto out;
+			}
+		}
+
+		*offset_ret = length;
+	} else if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||
+		   found_key.type == BTRFS_METADATA_ITEM_KEY) {
+
+		if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
+			length = found_key.offset;
+		else
+			length = fs_info->nodesize;
+
+		if (!(found_key.objectid >= cache->start &&
+		       found_key.objectid + length <=
+		       cache->start + cache->length)) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+		*offset_ret = found_key.objectid + length - cache->start;
+	} else {
+		ret = -EUCLEAN;
+		goto out;
+	}
+	ret = 0;
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+static u64 offset_in_dev_extent(struct map_lookup *map, u64 *alloc_offsets,
+				u64 logical, int idx)
+{
+	u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
+	u64 stripe_nr = logical / map->stripe_len;
+	u64 full_stripes_cnt;
+	u32 rest_stripes_cnt;
+	u64 stripe_start, offset;
+	int data_stripes = map->num_stripes / map->sub_stripes;
+	int stripe_idx;
+	int i;
+
+	ASSERT(profile == BTRFS_BLOCK_GROUP_RAID0 ||
+	       profile == BTRFS_BLOCK_GROUP_RAID10);
+
+	full_stripes_cnt = div_u64_rem(stripe_nr, data_stripes,
+				       &rest_stripes_cnt);
+	stripe_idx = idx / map->sub_stripes;
+
+	if (stripe_idx < rest_stripes_cnt)
+		return map->stripe_len * (full_stripes_cnt + 1);
+
+	for (i = idx + map->sub_stripes; i < map->num_stripes;
+	     i += map->sub_stripes) {
+		if (alloc_offsets[i] != WP_CONVENTIONAL &&
+		    alloc_offsets[i] > map->stripe_len * full_stripes_cnt)
+			return map->stripe_len * (full_stripes_cnt + 1);
+	}
+
+	stripe_start = (full_stripes_cnt * data_stripes + stripe_idx) *
+		map->stripe_len;
+	if (stripe_start >= logical)
+		return full_stripes_cnt * map->stripe_len;
+	offset = min_t(u64, logical - stripe_start, map->stripe_len);
+
+	return full_stripes_cnt * map->stripe_len + offset;
+}
+
+int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
+	struct extent_map *em;
+	struct map_lookup *map;
+	struct btrfs_device *device;
+	u64 logical = cache->start;
+	u64 length = cache->length;
+	u64 physical = 0;
+	int ret;
+	int i, j;
+	unsigned int nofs_flag;
+	u64 *alloc_offsets = NULL;
+	u64 emulated_offset = 0;
+	u32 num_sequential = 0, num_conventional = 0;
+
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
+
+	/* Sanity check */
+	if (!IS_ALIGNED(length, fs_info->zone_size)) {
+		btrfs_err(fs_info, "unaligned block group at %llu + %llu",
+			  logical, length);
+		return -EIO;
+	}
+
+	/* Get the chunk mapping */
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, logical, length);
+	read_unlock(&em_tree->lock);
+
+	if (!em)
+		return -EINVAL;
+
+	map = em->map_lookup;
+
+	/*
+	 * Get the zone type: if the group is mapped to a non-sequential zone,
+	 * there is no need for the allocation offset (fit allocation is OK).
+	 */
+	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets),
+				GFP_NOFS);
+	if (!alloc_offsets) {
+		free_extent_map(em);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < map->num_stripes; i++) {
+		bool is_sequential;
+		struct blk_zone zone;
+
+		device = map->stripes[i].dev;
+		physical = map->stripes[i].physical;
+
+		if (device->bdev == NULL) {
+			alloc_offsets[i] = WP_MISSING_DEV;
+			continue;
+		}
+
+		is_sequential = btrfs_dev_is_sequential(device, physical);
+		if (is_sequential)
+			num_sequential++;
+		else
+			num_conventional++;
+
+		if (!is_sequential) {
+			alloc_offsets[i] = WP_CONVENTIONAL;
+			continue;
+		}
+
+		/*
+		 * This zone will be used for allocation, so mark this
+		 * zone non-empty.
+		 */
+		btrfs_dev_clear_zone_empty(device, physical);
+
+		/*
+		 * The group is mapped to a sequential zone. Get the zone write
+		 * pointer to determine the allocation offset within the zone.
+		 */
+		WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));
+		nofs_flag = memalloc_nofs_save();
+		ret = btrfs_get_dev_zone(device, physical, &zone);
+		memalloc_nofs_restore(nofs_flag);
+		if (ret == -EIO || ret == -EOPNOTSUPP) {
+			ret = 0;
+			alloc_offsets[i] = WP_MISSING_DEV;
+			continue;
+		} else if (ret) {
+			goto out;
+		}
+
+		switch (zone.cond) {
+		case BLK_ZONE_COND_OFFLINE:
+		case BLK_ZONE_COND_READONLY:
+			btrfs_err(
+				fs_info, "Offline/readonly zone %llu",
+				physical >> device->zone_info->zone_size_shift);
+			alloc_offsets[i] = WP_MISSING_DEV;
+			break;
+		case BLK_ZONE_COND_EMPTY:
+			alloc_offsets[i] = 0;
+			break;
+		case BLK_ZONE_COND_FULL:
+			alloc_offsets[i] = fs_info->zone_size;
+			break;
+		default:
+			/* Partially used zone */
+			alloc_offsets[i] =
+				((zone.wp - zone.start) << SECTOR_SHIFT);
+			break;
+		}
+	}
+
+	if (num_conventional > 0) {
+		ret = emulate_write_pointer(cache, &emulated_offset);
+		if (ret || map->num_stripes == num_conventional) {
+			if (!ret)
+				cache->alloc_offset = emulated_offset;
+			goto out;
+		}
+	}
+
+	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case 0: /* single */
+	case BTRFS_BLOCK_GROUP_DUP:
+	case BTRFS_BLOCK_GROUP_RAID1:
+		cache->alloc_offset = WP_MISSING_DEV;
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV ||
+			    alloc_offsets[i] == WP_CONVENTIONAL)
+				continue;
+			if (cache->alloc_offset == WP_MISSING_DEV)
+				cache->alloc_offset = alloc_offsets[i];
+			if (alloc_offsets[i] == cache->alloc_offset)
+				continue;
+
+			cache->wp_broken = 1;
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV) {
+				cache->wp_broken = 1;
+				continue;
+			}
+
+			if (alloc_offsets[i] == WP_CONVENTIONAL)
+				alloc_offsets[i] =
+					offset_in_dev_extent(map, alloc_offsets,
+							     emulated_offset,
+							     i);
+
+			/* sanity check */
+			if (i > 0) {
+				if ((alloc_offsets[i] % BTRFS_STRIPE_LEN != 0 &&
+				     alloc_offsets[i - 1] %
+					     BTRFS_STRIPE_LEN != 0) ||
+				    (alloc_offsets[i - 1] < alloc_offsets[i]) ||
+				    (alloc_offsets[i - 1] - alloc_offsets[i] >
+						BTRFS_STRIPE_LEN)) {
+					cache->wp_broken = 1;
+					continue;
+				}
+			}
+
+			cache->alloc_offset += alloc_offsets[i];
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID10:
+		/*
+		 * Pass1: check write pointer of RAID1 level: each pointer
+		 * should be equal.
+		 */
+		for (i = 0; i < map->num_stripes / map->sub_stripes; i++) {
+			int base = i * map->sub_stripes;
+			u64 offset = WP_MISSING_DEV;
+			int fill = 0, num_conventional = 0;
+
+			for (j = 0; j < map->sub_stripes; j++) {
+				if (alloc_offsets[base+j] == WP_MISSING_DEV) {
+					fill++;
+					continue;
+				}
+				if (alloc_offsets[base+j] == WP_CONVENTIONAL) {
+					fill++;
+					num_conventional++;
+					continue;
+				}
+				if (offset == WP_MISSING_DEV)
+					offset = alloc_offsets[base+j];
+				if (alloc_offsets[base + j] == offset)
+					continue;
+
+				cache->wp_broken = 1;
+				goto out;
+			}
+			if (!fill)
+				continue;
+			/* this RAID0 stripe is free on conventional zones */
+			if (num_conventional == map->sub_stripes)
+				offset = WP_CONVENTIONAL;
+			/* fill WP_MISSING_DEV or WP_CONVENTIONAL */
+			for (j = 0; j < map->sub_stripes; j++)
+				alloc_offsets[base + j] = offset;
+		}
+
+		/* Pass2: check write pointer of RAID0 level */
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes / map->sub_stripes; i++) {
+			int base = i * map->sub_stripes;
+
+			if (alloc_offsets[base] == WP_MISSING_DEV) {
+				cache->wp_broken = 1;
+				continue;
+			}
+
+			if (alloc_offsets[base] == WP_CONVENTIONAL)
+				alloc_offsets[base] =
+					offset_in_dev_extent(map, alloc_offsets,
+							     emulated_offset,
+							     base);
+
+			/* sanity check */
+			if (i > 0) {
+				int prev = base - map->sub_stripes;
+
+				if ((alloc_offsets[base] %
+					     BTRFS_STRIPE_LEN != 0 &&
+				     alloc_offsets[prev] %
+					     BTRFS_STRIPE_LEN != 0) ||
+				    (alloc_offsets[prev] <
+					     alloc_offsets[base]) ||
+				    (alloc_offsets[prev] - alloc_offsets[base] >
+						BTRFS_STRIPE_LEN)) {
+					cache->wp_broken = 1;
+					continue;
+				}
+			}
+
+			cache->alloc_offset += alloc_offsets[base];
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
+		/* RAID5/6 is not supported yet */
+	default:
+		btrfs_err(fs_info, "Unsupported profile on HMZONED %llu",
+			map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	/* an extent is allocated after the write pointer */
+	if (num_conventional && emulated_offset > cache->alloc_offset) {
+		btrfs_err(fs_info,
+			  "got wrong write pointer in BG %llu: %llu > %llu",
+			  logical, emulated_offset, cache->alloc_offset);
+		cache->wp_broken = 1;
+		ret = -EIO;
+	}
+
+	if (cache->wp_broken) {
+		char buf[128] = {'\0'};
+
+		btrfs_describe_block_groups(cache->flags, buf, sizeof(buf));
+		btrfs_err(fs_info, "broken write pointer: block group %llu %s",
+			  logical, buf);
+		for (i = 0; i < map->num_stripes; i++) {
+			char *note;
+
+			device = map->stripes[i].dev;
+			physical = map->stripes[i].physical;
+
+			if (device->bdev == NULL)
+				note = " (missing)";
+			else if (!btrfs_dev_is_sequential(device, physical))
+				note = " (conventional)";
+			else
+				note = "";
+
+			btrfs_err_in_rcu(fs_info,
+		"stripe %d dev %s physical %llu write_pointer[i] = %llu%s",
+					 i, rcu_str_deref(device->name),
+					 physical, alloc_offsets[i], note);
+		}
+	}
+
+	kfree(alloc_offsets);
+	free_extent_map(em);
+
+	return ret;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index d54b4ae8cf8b..4ed985d027cc 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -40,6 +40,8 @@ int btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
 int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
 bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 				   u64 num_bytes);
+void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
+int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -89,6 +91,12 @@ static inline bool btrfs_check_allocatable_zones(struct btrfs_device *device,
 {
 	return true;
 }
+static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
+static inline int btrfs_load_block_group_zone_info(
+	struct btrfs_block_group *cache)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f09aa6ee9113..322036e49831 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -16,6 +16,7 @@ u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
 	ASSERT(s_info);
 	return s_info->bytes_used + s_info->bytes_reserved +
 		s_info->bytes_pinned + s_info->bytes_readonly +
+		s_info->bytes_zone_unusable +
 		(may_use_included ? s_info->bytes_may_use : 0);
 }
 
@@ -112,7 +113,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info)
 {
 	struct btrfs_space_info *found;
@@ -128,6 +129,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 	found->bytes_used += bytes_used;
 	found->disk_used += bytes_used * factor;
 	found->bytes_readonly += bytes_readonly;
+	found->bytes_zone_unusable += bytes_zone_unusable;
 	if (total_bytes > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
@@ -267,10 +269,10 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
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
@@ -299,9 +301,10 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	list_for_each_entry(cache, &info->block_groups[index], list) {
 		spin_lock(&cache->lock);
 		btrfs_info(fs_info,
-			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
+			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu zone_unusable %s",
 			cache->start, cache->length, cache->used, cache->pinned,
-			cache->reserved, cache->ro ? "[readonly]" : "");
+			cache->reserved, cache->zone_unusable,
+			cache->ro ? "[readonly]" : "");
 		btrfs_dump_free_space(cache, bytes);
 		spin_unlock(&cache->lock);
 	}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 1a349e3f9cc1..a1a5f6c2611b 100644
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
@@ -111,7 +113,7 @@ DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 					       u64 flags);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 230c7ad90e22..c479708537fc 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -458,6 +458,7 @@ SPACE_INFO_ATTR(bytes_pinned);
 SPACE_INFO_ATTR(bytes_reserved);
 SPACE_INFO_ATTR(bytes_may_use);
 SPACE_INFO_ATTR(bytes_readonly);
+SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR(space_info, total_bytes_pinned,
@@ -471,6 +472,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bytes_reserved),
 	BTRFS_ATTR_PTR(space_info, bytes_may_use),
 	BTRFS_ATTR_PTR(space_info, bytes_readonly),
+	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
-- 
2.24.0

