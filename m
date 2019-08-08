Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A654C85E60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbfHHJbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59650 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732335AbfHHJbc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256692; x=1596792692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xZFvSm/S7y0Hg3MXM5eZh/Xrj5XEJQmoUfsTowanRBM=;
  b=U9ogLjWPJuyqvJt7qGKmB90ssUdn8WR6YrMw5ado1M4ZPiI+bsHkYIeS
   hDe/ogw7j/M3t0CR0fdGjjleu8Kxwp/4WXUzPwvGflUHxvgFo3WV6ehAq
   cL/cfmce0PXAT7zjmc3GouqXQwBjjzgoBWNITuYp1rnAqLzfqhH4an/0y
   ObcSLsFgpoYVz4JbbhzzM3cZf6BNGM4yYUOIH+gUSJuhkGrk6QJP7a4vS
   +g0ESCF+Y+penIVVRKO4GeygNTZLczQDqbljU69EN3eMMAgCKZ4cwZ1xi
   zgPzIjFM5KXV/fnPbqGXzq+W94bohdYT0PP/ZMToOWMoNIzwleloPubSI
   A==;
IronPort-SDR: v9ZdxfqVXv9w2ZuAvNSt9DbQDGpk5JIFMVRBot97fNfNGaEMvNcYJ5GsI3SbBY7o+1D25cSsCD
 ZCWoIXKQ+Wbp5+A5aAUw9iyo3EK9HNSio+cpvnvajDPinyWWJ1UfjX8ysMrE02rmwf+CDpjYLO
 Q2+dtMEvCXG9vaa86H8EMXHua7Nj0r6CqIcmCMckshKjnbyGGqdx8iSTbL9naFO/8GwYyhSHID
 IfQan8Ku0NPLA3Z1uhlSXXd5OXWQQcZw1SH1zVpWZKfOcVbTK97RWhplbC+VAvfS2ab2Gj8ndO
 wV4=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363358"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:32 +0800
IronPort-SDR: 9jsZOam+a7GB2v4H2J3wrIgnqOD1oJtmz7BAynIQjUIC46MVi3a/xCtMIHrz2lTsHoJ40hCuDs
 83JiE2szNR53ylFg2V97TMvud3yL8kGjAyGcXbX3HnrhZ4yK0Q2wHXoVh9831/lNiDr90U0oVF
 wIkQXTefUZlu4qCDqVSe+xl8wRVM/wmVoGPhiKn962NfHMFuY5sJgSyPTugWLQtW2Vd79apjE0
 Rpj+/Wofggg2J+/9WcJ/V44ZkcFLF6tJvdkEyQ8yhy2Etiu/grYFyrFieihktBgYa6AhoFhTgf
 AcQGnj8oDgM1/xLE4/rS68sa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:16 -0700
IronPort-SDR: 84JgInKBy+5FMRQAbIQ7Hqyc7tdyvDennL+c53rPz+gaOEh2fvOfD+iPCWki+304ooCopJTwaf
 1CLpfGQKS4obcjgntOXGP3QiQLQYn74RrQtvaidtRORGstPs+I1GQqARj5hBbGbHtSPBG22IX5
 m0xk3hLo8hjpJJoy07iqCJrqpmr4CpcBDAvV5GVqjwbSHx6XH4pPn+oUrvJoo7XwVx83HUQP7/
 sXmZZt25iac7RJSz3qamihGemX40cK28TbqHFmw27mw40nN5WxIgx2iEQxiKQkYimeDl6rUaFX
 rU4=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:31 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 10/27] btrfs: do sequential extent allocation in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:21 +0900
Message-Id: <20190808093038.4163421-11-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
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

Sequential allocation function find_free_extent_seq() bypass the checks in
find_free_extent() and increase the reserved byte counter by itself. It is
impossible to revert once allocated region in the sequential allocation,
since it might race with other allocations and leave an allocation hole,
which breaks the sequential write rule.

Furthermore, this commit introduce two new variable to struct
btrfs_block_group_cache. "wp_broken" indicate that write pointer is broken
(e.g. not synced on a RAID1 block group) and mark that block group read
only. "zone_unusable" keeps track of the size of once allocated then freed
region in a block group. Such region is never usable until resetting
underlying zones.

This commit also introduce "bytes_zone_unusable" to track such unusable
bytes in a space_info. Pinned bytes are always reclaimed to
"bytes_zone_unusable". They are not usable until resetting them first.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h            |  25 ++++
 fs/btrfs/extent-tree.c      | 179 +++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.c |  35 ++++++
 fs/btrfs/free-space-cache.h |   5 +
 fs/btrfs/hmzoned.c          | 231 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h          |   1 +
 fs/btrfs/space-info.c       |  13 +-
 fs/btrfs/space-info.h       |   4 +-
 fs/btrfs/sysfs.c            |   2 +
 9 files changed, 471 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a00ce8c4d678..3d31a1960c4d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -482,6 +482,20 @@ struct btrfs_full_stripe_locks_tree {
 	struct mutex lock;
 };
 
+/* Block group allocation types */
+enum btrfs_alloc_type {
+
+	/* Regular first fit allocation */
+	BTRFS_ALLOC_FIT		= 0,
+
+	/*
+	 * Sequential allocation: this is for HMZONED mode and
+	 * will result in ignoring free space before a block
+	 * group allocation offset.
+	 */
+	BTRFS_ALLOC_SEQ		= 1,
+};
+
 struct btrfs_block_group_cache {
 	struct btrfs_key key;
 	struct btrfs_block_group_item item;
@@ -521,6 +535,7 @@ struct btrfs_block_group_cache {
 	unsigned int iref:1;
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
+	unsigned int wp_broken:1;
 
 	int disk_cache_state;
 
@@ -594,6 +609,16 @@ struct btrfs_block_group_cache {
 
 	/* Record locked full stripes for RAID5/6 block group */
 	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
+
+	enum btrfs_alloc_type alloc_type;
+	u64 zone_unusable;
+	/*
+	 * Allocation offset for the block group to implement
+	 * sequential allocation. This is used only with HMZONED mode
+	 * enabled and if the block group resides on a sequential
+	 * zone.
+	 */
+	u64 alloc_offset;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3a36646dfaa8..d2aacffe14d6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -31,6 +31,8 @@
 #include "space-info.h"
 #include "block-rsv.h"
 #include "delalloc-space.h"
+#include "rcu-string.h"
+#include "hmzoned.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -543,6 +545,8 @@ static int cache_block_group(struct btrfs_block_group_cache *cache,
 	struct btrfs_caching_control *caching_ctl;
 	int ret = 0;
 
+	ASSERT(cache->alloc_type == BTRFS_ALLOC_FIT);
+
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
@@ -4429,6 +4433,20 @@ void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg)
 	wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));
 }
 
+static void __btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
+				       u64 ram_bytes, u64 num_bytes,
+				       int delalloc)
+{
+	struct btrfs_space_info *space_info = cache->space_info;
+
+	cache->reserved += num_bytes;
+	space_info->bytes_reserved += num_bytes;
+	btrfs_space_info_update_bytes_may_use(cache->fs_info, space_info,
+					      -ram_bytes);
+	if (delalloc)
+		cache->delalloc_bytes += num_bytes;
+}
+
 /**
  * btrfs_add_reserved_bytes - update the block_group and space info counters
  * @cache:	The cache we are manipulating
@@ -4447,18 +4465,16 @@ static int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
 	struct btrfs_space_info *space_info = cache->space_info;
 	int ret = 0;
 
+	/* should handled by find_free_extent_seq */
+	ASSERT(cache->alloc_type != BTRFS_ALLOC_SEQ);
+
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
-	if (cache->ro) {
+	if (cache->ro)
 		ret = -EAGAIN;
-	} else {
-		cache->reserved += num_bytes;
-		space_info->bytes_reserved += num_bytes;
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
@@ -4576,9 +4592,13 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			cache = btrfs_lookup_block_group(fs_info, start);
 			BUG_ON(!cache); /* Logic error */
 
-			cluster = fetch_cluster_info(fs_info,
-						     cache->space_info,
-						     &empty_cluster);
+			if (cache->alloc_type == BTRFS_ALLOC_FIT)
+				cluster = fetch_cluster_info(fs_info,
+							     cache->space_info,
+							     &empty_cluster);
+			else
+				cluster = NULL;
+
 			empty_cluster <<= 1;
 		}
 
@@ -4618,7 +4638,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		space_info->max_extent_size = 0;
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
-		if (cache->ro) {
+		if (cache->alloc_type == BTRFS_ALLOC_SEQ) {
+			/* need reset before reusing in ALLOC_SEQ BG */
+			space_info->bytes_zone_unusable += len;
+			readonly = true;
+		} else if (cache->ro) {
 			space_info->bytes_readonly += len;
 			readonly = true;
 		}
@@ -5464,6 +5488,60 @@ static int find_free_extent_unclustered(struct btrfs_block_group_cache *bg,
 	return 0;
 }
 
+/*
+ * Simple allocator for sequential only block group. It only allows
+ * sequential allocation. No need to play with trees. This function
+ * also reserve the bytes as in btrfs_add_reserved_bytes.
+ */
+
+static int find_free_extent_seq(struct btrfs_block_group_cache *cache,
+				struct find_free_extent_ctl *ffe_ctl)
+{
+	struct btrfs_space_info *space_info = cache->space_info;
+	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
+	u64 start = cache->key.objectid;
+	u64 num_bytes = ffe_ctl->num_bytes;
+	u64 avail;
+	int ret = 0;
+
+	/* Sanity check */
+	if (cache->alloc_type != BTRFS_ALLOC_SEQ)
+		return 1;
+
+	spin_lock(&space_info->lock);
+	spin_lock(&cache->lock);
+
+	if (cache->ro) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	spin_lock(&ctl->tree_lock);
+	avail = cache->key.offset - cache->alloc_offset;
+	if (avail < num_bytes) {
+		ffe_ctl->max_extent_size = avail;
+		spin_unlock(&ctl->tree_lock);
+		ret = 1;
+		goto out;
+	}
+
+	ffe_ctl->found_offset = start + cache->alloc_offset;
+	cache->alloc_offset += num_bytes;
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
@@ -5764,6 +5842,17 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
 			goto loop;
 
+		if (block_group->alloc_type == BTRFS_ALLOC_SEQ) {
+			ret = find_free_extent_seq(block_group, &ffe_ctl);
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
@@ -5819,6 +5908,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 					     num_bytes);
 			goto loop;
 		}
+nocheck:
 		btrfs_inc_block_group_reservations(block_group);
 
 		/* we are all good, lets return */
@@ -7370,7 +7460,8 @@ static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
 	}
 
 	num_bytes = cache->key.offset - cache->reserved - cache->pinned -
-		    cache->bytes_super - btrfs_block_group_used(&cache->item);
+		    cache->bytes_super - cache->zone_unusable -
+		    btrfs_block_group_used(&cache->item);
 	sinfo_used = btrfs_space_info_used(sinfo, true);
 
 	if (sinfo_used + num_bytes + min_allocable_bytes <=
@@ -7519,6 +7610,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
 	if (!--cache->ro) {
 		num_bytes = cache->key.offset - cache->reserved -
 			    cache->pinned - cache->bytes_super -
+			    cache->zone_unusable -
 			    btrfs_block_group_used(&cache->item);
 		sinfo->bytes_readonly -= num_bytes;
 		list_del_init(&cache->ro_list);
@@ -7989,6 +8081,7 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 	atomic_set(&cache->trimming, 0);
 	mutex_init(&cache->free_space_lock);
 	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
+	cache->alloc_type = BTRFS_ALLOC_FIT;
 
 	return cache;
 }
@@ -8061,6 +8154,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	int need_clear = 0;
 	u64 cache_gen;
 	u64 feature;
+	u64 unusable = 0;
 	int mixed;
 
 	feature = btrfs_super_incompat_flags(info->super_copy);
@@ -8130,6 +8224,14 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		key.objectid = found_key.objectid + found_key.offset;
 		btrfs_release_path(path);
 
+		ret = btrfs_load_block_group_zone_info(cache);
+		if (ret) {
+			btrfs_err(info, "failed to load zone info of bg %llu",
+				  cache->key.objectid);
+			btrfs_put_block_group(cache);
+			goto error;
+		}
+
 		/*
 		 * We need to exclude the super stripes now so that the space
 		 * info has super bytes accounted for, otherwise we'll think
@@ -8166,6 +8268,31 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 			free_excluded_extents(cache);
 		}
 
+		if (cache->alloc_type == BTRFS_ALLOC_SEQ) {
+			u64 free;
+
+			WARN_ON(cache->bytes_super != 0);
+			if (!cache->wp_broken) {
+				unusable = cache->alloc_offset -
+					btrfs_block_group_used(&cache->item);
+				free = cache->key.offset - cache->alloc_offset;
+			} else {
+				unusable = cache->key.offset -
+					btrfs_block_group_used(&cache->item);
+				free = 0;
+			}
+			/* we only need ->free_space in ALLOC_SEQ BGs */
+			cache->last_byte_to_unpin = (u64)-1;
+			cache->cached = BTRFS_CACHE_FINISHED;
+			cache->free_space_ctl->free_space = free;
+			cache->zone_unusable = unusable;
+			/*
+			 * Should not have any excluded extents. Just
+			 * in case, though.
+			 */
+			free_excluded_extents(cache);
+		}
+
 		ret = btrfs_add_block_group_cache(info, cache);
 		if (ret) {
 			btrfs_remove_free_space_cache(cache);
@@ -8176,7 +8303,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		trace_btrfs_add_block_group(info, cache, 0);
 		btrfs_update_space_info(info, cache->flags, found_key.offset,
 					btrfs_block_group_used(&cache->item),
-					cache->bytes_super, &space_info);
+					cache->bytes_super, unusable,
+					&space_info);
 
 		cache->space_info = space_info;
 
@@ -8189,6 +8317,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 			ASSERT(list_empty(&cache->bg_list));
 			btrfs_mark_bg_unused(cache);
 		}
+
+		if (cache->wp_broken)
+			inc_block_group_ro(cache, 1);
 	}
 
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
@@ -8282,6 +8413,13 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
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
 		/*
@@ -8326,7 +8464,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
 	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, &cache->space_info);
+				cache->bytes_super, 0, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
@@ -8576,12 +8714,17 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		WARN_ON(block_group->space_info->total_bytes
 			< block_group->key.offset);
 		WARN_ON(block_group->space_info->bytes_readonly
-			< block_group->key.offset);
+			< block_group->key.offset - block_group->zone_unusable);
+		WARN_ON(block_group->space_info->bytes_zone_unusable
+			< block_group->zone_unusable);
 		WARN_ON(block_group->space_info->disk_total
 			< block_group->key.offset * factor);
 	}
 	block_group->space_info->total_bytes -= block_group->key.offset;
-	block_group->space_info->bytes_readonly -= block_group->key.offset;
+	block_group->space_info->bytes_readonly -=
+		(block_group->key.offset - block_group->zone_unusable);
+	block_group->space_info->bytes_zone_unusable -=
+		block_group->zone_unusable;
 	block_group->space_info->disk_total -= block_group->key.offset * factor;
 
 	spin_unlock(&block_group->space_info->lock);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 062be9dde4c6..2aeb3620645c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2326,8 +2326,11 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   u64 offset, u64 bytes)
 {
 	struct btrfs_free_space *info;
+	struct btrfs_block_group_cache *block_group = ctl->private;
 	int ret = 0;
 
+	ASSERT(!block_group || block_group->alloc_type != BTRFS_ALLOC_SEQ);
+
 	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
 	if (!info)
 		return -ENOMEM;
@@ -2376,6 +2379,30 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+int __btrfs_add_free_space_seq(struct btrfs_block_group_cache *block_group,
+			       u64 bytenr, u64 size)
+{
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	u64 offset = bytenr - block_group->key.objectid;
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
 int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
 			    u64 offset, u64 bytes)
 {
@@ -2384,6 +2411,8 @@ int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
 	int ret;
 	bool re_search = false;
 
+	ASSERT(block_group->alloc_type != BTRFS_ALLOC_SEQ);
+
 	spin_lock(&ctl->tree_lock);
 
 again:
@@ -2619,6 +2648,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 	u64 align_gap = 0;
 	u64 align_gap_len = 0;
 
+	ASSERT(block_group->alloc_type != BTRFS_ALLOC_SEQ);
+
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
 				block_group->full_stripe_len, max_extent_size);
@@ -2738,6 +2769,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_group,
 	struct rb_node *node;
 	u64 ret = 0;
 
+	ASSERT(block_group->alloc_type != BTRFS_ALLOC_SEQ);
+
 	spin_lock(&cluster->lock);
 	if (bytes > cluster->max_size)
 		goto out;
@@ -3384,6 +3417,8 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 {
 	int ret;
 
+	ASSERT(block_group->alloc_type != BTRFS_ALLOC_SEQ);
+
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 8760acb55ffd..d30667784f73 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -73,10 +73,15 @@ void btrfs_init_free_space_ctl(struct btrfs_block_group_cache *block_group);
 int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   struct btrfs_free_space_ctl *ctl,
 			   u64 bytenr, u64 size);
+int __btrfs_add_free_space_seq(struct btrfs_block_group_cache *block_group,
+			       u64 bytenr, u64 size);
 static inline int
 btrfs_add_free_space(struct btrfs_block_group_cache *block_group,
 		     u64 bytenr, u64 size)
 {
+	if (block_group->alloc_type == BTRFS_ALLOC_SEQ)
+		return __btrfs_add_free_space_seq(block_group, bytenr, size);
+
 	return __btrfs_add_free_space(block_group->fs_info,
 				      block_group->free_space_ctl,
 				      bytenr, size);
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 7d334b236cd3..89631f5f01f2 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -17,6 +17,9 @@
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
 
+/* Invalid allocation pointer value for missing devices */
+#define WP_MISSING_DEV ((u64)-1)
+
 static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 			       struct blk_zone **zones_ret,
 			       unsigned int *nr_zones, gfp_t gfp_mask)
@@ -320,3 +323,231 @@ bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 
 	return find_next_bit(zinfo->seq_zones, end, begin) == end;
 }
+
+int btrfs_load_block_group_zone_info(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
+	struct extent_map *em;
+	struct map_lookup *map;
+	struct btrfs_device *device;
+	u64 logical = cache->key.objectid;
+	u64 length = cache->key.offset;
+	u64 physical = 0;
+	int ret, alloc_type;
+	int i, j;
+	u64 *alloc_offsets = NULL;
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
+	alloc_type = -1;
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
+		if (alloc_type == -1)
+			alloc_type = is_sequential ?
+					BTRFS_ALLOC_SEQ : BTRFS_ALLOC_FIT;
+
+		if ((is_sequential && alloc_type != BTRFS_ALLOC_SEQ) ||
+		    (!is_sequential && alloc_type == BTRFS_ALLOC_SEQ)) {
+			btrfs_err(fs_info, "found block group of mixed zone types");
+			ret = -EIO;
+			goto out;
+		}
+
+		if (!is_sequential)
+			continue;
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
+		ret = btrfs_get_dev_zone(device, physical, &zone, GFP_NOFS);
+		if (ret == -EIO || ret == -EOPNOTSUPP) {
+			ret = 0;
+			alloc_offsets[i] = WP_MISSING_DEV;
+			continue;
+		} else if (ret) {
+			goto out;
+		}
+
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
+	if (alloc_type == BTRFS_ALLOC_FIT)
+		goto out;
+
+	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case 0: /* single */
+	case BTRFS_BLOCK_GROUP_DUP:
+	case BTRFS_BLOCK_GROUP_RAID1:
+		cache->alloc_offset = WP_MISSING_DEV;
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV)
+				continue;
+			if (cache->alloc_offset == WP_MISSING_DEV)
+				cache->alloc_offset = alloc_offsets[i];
+			if (alloc_offsets[i] == cache->alloc_offset)
+				continue;
+
+			btrfs_err(fs_info,
+				  "write pointer mismatch: block group %llu",
+				  logical);
+			cache->wp_broken = 1;
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV) {
+				btrfs_err(fs_info,
+					  "cannot recover write pointer: block group %llu",
+					  logical);
+				cache->wp_broken = 1;
+				continue;
+			}
+
+			if (alloc_offsets[0] < alloc_offsets[i]) {
+				btrfs_err(fs_info,
+					  "write pointer mismatch: block group %llu",
+					  logical);
+				cache->wp_broken = 1;
+				continue;
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
+
+			for (j = 0; j < map->sub_stripes; j++) {
+				if (alloc_offsets[base + j] == WP_MISSING_DEV)
+					continue;
+				if (offset == WP_MISSING_DEV)
+					offset = alloc_offsets[base+j];
+				if (alloc_offsets[base + j] == offset)
+					continue;
+
+				btrfs_err(fs_info,
+					  "write pointer mismatch: block group %llu",
+					  logical);
+				cache->wp_broken = 1;
+			}
+			for (j = 0; j < map->sub_stripes; j++)
+				alloc_offsets[base + j] = offset;
+		}
+
+		/* Pass2: check write pointer of RAID1 level */
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes / map->sub_stripes; i++) {
+			int base = i * map->sub_stripes;
+
+			if (alloc_offsets[base] == WP_MISSING_DEV) {
+				btrfs_err(fs_info,
+					  "cannot recover write pointer: block group %llu",
+					  logical);
+				cache->wp_broken = 1;
+				continue;
+			}
+
+			if (alloc_offsets[0] < alloc_offsets[base]) {
+				btrfs_err(fs_info,
+					  "write pointer mismatch: block group %llu",
+					  logical);
+				cache->wp_broken = 1;
+				continue;
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
+	cache->alloc_type = alloc_type;
+	kfree(alloc_offsets);
+	free_extent_map(em);
+
+	return ret;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 396ece5f9410..399d9e9543aa 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -31,6 +31,7 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info);
 int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
 bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 				   u64 num_bytes);
+int btrfs_load_block_group_zone_info(struct btrfs_block_group_cache *cache);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ab7b9ec4c240..4c6457bd1b9c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -15,6 +15,7 @@ u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
 	ASSERT(s_info);
 	return s_info->bytes_used + s_info->bytes_reserved +
 		s_info->bytes_pinned + s_info->bytes_readonly +
+		s_info->bytes_zone_unusable +
 		(may_use_included ? s_info->bytes_may_use : 0);
 }
 
@@ -133,7 +134,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info)
 {
 	struct btrfs_space_info *found;
@@ -149,6 +150,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 	found->bytes_used += bytes_used;
 	found->disk_used += bytes_used * factor;
 	found->bytes_readonly += bytes_readonly;
+	found->bytes_zone_unusable += bytes_zone_unusable;
 	if (total_bytes > 0)
 		found->full = 0;
 	btrfs_space_info_add_new_bytes(info, found,
@@ -372,10 +374,10 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		   info->total_bytes - btrfs_space_info_used(info, true),
 		   info->full ? "" : "not ");
 	btrfs_info(fs_info,
-		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu",
+		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
 		info->total_bytes, info->bytes_used, info->bytes_pinned,
 		info->bytes_reserved, info->bytes_may_use,
-		info->bytes_readonly);
+		info->bytes_readonly, info->bytes_zone_unusable);
 	spin_unlock(&info->lock);
 
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
@@ -392,10 +394,11 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	list_for_each_entry(cache, &info->block_groups[index], list) {
 		spin_lock(&cache->lock);
 		btrfs_info(fs_info,
-			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
+			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved zone_unusable %llu %s",
 			cache->key.objectid, cache->key.offset,
 			btrfs_block_group_used(&cache->item), cache->pinned,
-			cache->reserved, cache->ro ? "[readonly]" : "");
+			cache->reserved, cache->zone_unusable,
+			cache->ro ? "[readonly]" : "");
 		btrfs_dump_free_space(cache, bytes);
 		spin_unlock(&cache->lock);
 	}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index c2b54b8e1a14..b3837b2c41e4 100644
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
@@ -115,7 +117,7 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 					       u64 flags);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index ad708a9edd0b..37733ec8e437 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -349,6 +349,7 @@ SPACE_INFO_ATTR(bytes_pinned);
 SPACE_INFO_ATTR(bytes_reserved);
 SPACE_INFO_ATTR(bytes_may_use);
 SPACE_INFO_ATTR(bytes_readonly);
+SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR(space_info, total_bytes_pinned,
@@ -362,6 +363,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bytes_reserved),
 	BTRFS_ATTR_PTR(space_info, bytes_may_use),
 	BTRFS_ATTR_PTR(space_info, bytes_readonly),
+	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
-- 
2.22.0

