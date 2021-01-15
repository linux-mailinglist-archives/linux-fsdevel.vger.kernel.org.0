Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714042F732A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbhAOG56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:57:58 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41680 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693877; x=1642229877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cSwBuBrP4rQzE/FX2gEzi0+iwzn8RA934m8m4cZG1gE=;
  b=iLvuBOYy8Sf7h/Lm6pakMB3JtpbzzEkTW4AESOfHlwybYAjCgYOky3Nj
   RAAn0zGCpiER1y9fmb+mEVh+clO1ZiYVAK/90Wf5V2jqeFwSr6ztycEyu
   eJJEc7cIwQWWgNQz9THBMVnDjsw8vNvbuDhtaFjuTOjaNVWDmW7yCnTT/
   giZWEXeLcxznQ5dTdwsTMeoDpqr6aLyBN9qkgJuyD/tiV86YhDzBbGdEg
   cKHYjaEIToi2WH0I0bOUDM5uXv2sclLSb9ZoBdWpobV8s47IWe09xDEW5
   x1xm1WLmzulmHgr+ds/6sL+7xvG1Qd3BVOysC+cXDVQ09f3xAy7NnQAS1
   A==;
IronPort-SDR: C4y+zo6dukuNkBqHDOJuZuhsjmnTRl+qDHgT2pQonIACgIoFj2d2/Y+b3bHtpCGxufz3NY093L
 PNiHUprI3xbIpLV3DNgEwX8zi1/2gD9VBiBESAXTwZt0RjAauQb7tXI0xIss3J1nLv6+36eLYv
 hxtxw+W0BDeXg1P3HhJp/f6TN01XNut93ifY7oOv6xW1g8TvO6Dh4yq4W712xAHf0DLQdg1uug
 CYsR598InwFUICpQc1lb6CRwRx8WrKy/QU3f3MIVZhN0u0DVxaB9ox+wJeph/DxC/BqFFeFg0f
 PjI=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928224"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:27 +0800
IronPort-SDR: xcuzOuFwQZv6rhKOg/ewChVsKFu9qS/CbhUUMsySHTpzmSPnu24BKDl49k+AFtpjkw2vwUwb0+
 FneGCwHYDvQaKUS+2xB9+h5cBPRqQ7t1+Y2YJO68OC1HsSkdBPVlBl9ETkKTVKbRvgvNWRm53F
 PnVJLUVV+DFfZD3SsQLVVSy2+M+HzetXf8magYArNHxF7aoMCI72EK/mdCoixlO83/bgzNljaP
 YV03xACehEA+SOsrE8uKfe3jBxEEA1MhlnFXnKSIkDD/Eb7uHhRhryvlZeIcmAIVQYFtIA90N6
 E6pE6BO0LtXSOeGktVNM6FYD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:09 -0800
IronPort-SDR: KJS7VSDz+4NHaoBddcdn5HumjIU8H6BYC3X8Bx/jLTGTSS9Y509w/UiocfJog3ZF87kJe2C7fr
 zyPrDhzn+hRg8imEIbg8rFeYELuHYbsTLLJ0vwlnqYC+QI8cQLl6mjuqLhjBxW/xdUsuK2+mG6
 K8hRxK9sgvydg5abwcLIU3Pu2pyg2XehJbm46E4mGnuSjyyoqi9TX5+8JzlJuEr1ddo2gr2Q9c
 geqqHk4i4cHsa4uLfYi1n2f8SVprAFQLvV+YiN/jzI85gIs9rl7DugOvGtf6IPvRWuDIbYxreE
 S38=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:26 -0800
Received: (nullmailer pid 1916442 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v12 11/41] btrfs: load zone's allocation offset
Date:   Fri, 15 Jan 2021 15:53:15 +0900
Message-Id: <f8943f29adea11f8b6e2a2a17e054d2388693135.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zoned btrfs must allocate blocks at the zones' write pointer. The device's
write pointer position can be mapped to a logical address within a block
group. This commit adds "alloc_offset" to track the logical address.

This logical address is populated in btrfs_load_block_group_zone_info()
from write pointers of corresponding zones.

For now, zoned btrfs only support the SINGLE profile. Supporting non-SINGLE
profile with zone append writing is not trivial. For example, in the DUP
profile, we send a zone append writing IO to two zones on a device. The
device reply with written LBAs for the IOs. If the offsets of the returned
addresses from the beginning of the zone are different, then it results in
different logical addresses.

We need fine-grained logical to physical mapping to support such separated
physical address issue. Since it should require additional metadata type,
disable non-SINGLE profiles for now.

This commit supports the case all the zones in a block group are
sequential. The next patch will handle the case having a conventional zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c |  15 +++++
 fs/btrfs/block-group.h |   6 ++
 fs/btrfs/zoned.c       | 150 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |   7 ++
 4 files changed, 178 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ff13f7554ee5..13edbc959bac 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -15,6 +15,7 @@
 #include "delalloc-space.h"
 #include "discard.h"
 #include "raid56.h"
+#include "zoned.h"
 
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
@@ -1851,6 +1852,13 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 			goto error;
 	}
 
+	ret = btrfs_load_block_group_zone_info(cache);
+	if (ret) {
+		btrfs_err(info, "zoned: failed to load zone info of bg %llu",
+			  cache->start);
+		goto error;
+	}
+
 	/*
 	 * We need to exclude the super stripes now so that the space info has
 	 * super bytes accounted for, otherwise we'll think we have more space
@@ -2138,6 +2146,13 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	cache->cached = BTRFS_CACHE_FINISHED;
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
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
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 8f74a96074f7..9d026ab1768d 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -183,6 +183,12 @@ struct btrfs_block_group {
 
 	/* Record locked full stripes for RAID5/6 block group */
 	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
+
+	/*
+	 * Allocation offset for the block group to implement sequential
+	 * allocation. This is used only with ZONED mode enabled.
+	 */
+	u64 alloc_offset;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ae5f49fe4fb4..78be99b3c090 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -3,14 +3,20 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
+#include <linux/sched/mm.h>
 #include "ctree.h"
 #include "volumes.h"
 #include "zoned.h"
 #include "rcu-string.h"
 #include "disk-io.h"
+#include "block-group.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
+/* Invalid allocation pointer value for missing devices */
+#define WP_MISSING_DEV ((u64)-1)
+/* Pseudo write pointer value for conventional zone */
+#define WP_CONVENTIONAL ((u64)-2)
 
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
@@ -923,3 +929,147 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 
 	return 0;
 }
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
+	int i;
+	unsigned int nofs_flag;
+	u64 *alloc_offsets = NULL;
+	u32 num_sequential = 0, num_conventional = 0;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	/* Sanity check */
+	if (!IS_ALIGNED(length, fs_info->zone_size)) {
+		btrfs_err(fs_info, "zoned: block group %llu len %llu unaligned to zone size %llu",
+			  logical, length, fs_info->zone_size);
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
+			btrfs_err(fs_info, "zoned: offline/readonly zone %llu on device %s (devid %llu)",
+				  physical >> device->zone_info->zone_size_shift,
+				  rcu_str_deref(device->name), device->devid);
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
+		/*
+		 * Since conventional zones do not have a write pointer, we
+		 * cannot determine alloc_offset from the pointer
+		 */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case 0: /* single */
+		cache->alloc_offset = alloc_offsets[0];
+		break;
+	case BTRFS_BLOCK_GROUP_DUP:
+	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID0:
+	case BTRFS_BLOCK_GROUP_RAID10:
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
+		/* non-SINGLE profiles are not supported yet */
+	default:
+		btrfs_err(fs_info, "zoned: profile %s not supported",
+			  btrfs_bg_type_to_raid_name(map->type));
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	kfree(alloc_offsets);
+	free_extent_map(em);
+
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index de5901f5ae66..491b98c97f48 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -41,6 +41,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes);
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
+int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -117,6 +118,12 @@ static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
 	return 0;
 }
 
+static inline int btrfs_load_block_group_zone_info(
+	struct btrfs_block_group *cache)
+{
+	return 0;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

