Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF60D2AD537
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgKJLaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:30:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11959 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbgKJL2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007709; x=1636543709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ld+Szk5GqbI1Q/9gJOULtt8uYEuLrS7uKHMGKSXFv58=;
  b=nYViO/gEjeRIjvuJrB3iauJOlneJZjB/eg4Vi81HK+KWK1Br9wxxr8CD
   z8SQaYa9tnFW+TrwXnzQQmI87pGuFGoK0L6M3uqLeA5H2hQSVxsXBvQrJ
   ebNTGOtMxf/Pn77T8reM4dLPlPIWS5s88+dN7MveFnz3TFDtGdOAfH9So
   XeIhiK30uECIFdiqJwqe46bRBaM615Tmg3kqZhJEhxIfXWrggxnBEWxhx
   CABzeRzQQgt2jy9MVtAYmrHSa74/iPV6VXA5kgZBmTryuBe11NlKnVaak
   LPgO+bdDA/xI515SOvlqF69hCx6YzlnES0g2Xm/5pyZvod1trpaA9f+Pd
   g==;
IronPort-SDR: mKprWQqqCtysAAhJu6K3k9DHzDukLdj3f82goWmADJd/Q7VoaTwyoVuYl7llAdIASR+eu/ym9N
 NPe2sx7uSmmi+pkCSD79mbwGPEoqToDhuiKB+Og68vISWFuNnc2BXu16roIdA9XJRykJCpxjZx
 8AJDzPItyPSf3F4UwMxFc58YBOvTsyXj397r5BbYyOpM/oyta/OUSNHU4CWBx93o6c2Dz+hoqy
 kZjnySc6m7ULWz4a7daS/pYAXAY2TIR3Y3FioizXAhohRs4GrzNK85BieKI1gCbahiNmWv+vxm
 Gos=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376475"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:28 +0800
IronPort-SDR: jIR1CE1WAEHpds6idzsRvR2cCaQjoFWHucLnowLf1EBf7LRqly807sDXWcaZJstSUiCOh6StNI
 jwYMfh35wUvoyXzfATXyjCfKMAHQSNAUeXE7XWz3XVLVDdvf19ulZzHofiIDdVa/yA2n7SLBpU
 4e94ax2xV2bXDWaJi7BQSdCA7/BEO/2LmqJRodhnD6wEyVSFxy5xN7ReNch4b1svARoS/ZXUvb
 eWyEYhR79jqbHUj5CXlgmTxq6g3wPY0WJc5JpuJl0RZjObczyZmllHi8TpyZJqD8+A8qfPsPmd
 bPeLYZIIyvkH6fIdSXySj3DS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:29 -0800
IronPort-SDR: QPUmGq22G/Eke27GApuPWBiqdVaMeT2/yM1ujLqjftBgtXjfdN/Si8jeGJ2/MRqmQy+o1dtWeP
 cMQQe8nXy45KUGL4RMgvXhORXqdSzI5tVWM3BTQdYeqYRS4VQumi1Gw/LogSkq3YqzfybIiftp
 y01YUCwtyOlIJUfiK9HeBddB0VpEO86s+vALWcPElHUwzANKZ+PWyKREqYy8Pl0xy2IQ4b1+SX
 520fi4SYmHifza8KAY28GV3RapriBCMBaWiXMP1kkbV1ffeP3EyAub71N09o9juM3MSC1THGer
 eWY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:27 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 14/41] btrfs: load zone's alloction offset
Date:   Tue, 10 Nov 2020 20:26:17 +0900
Message-Id: <e05710f61375174d7a64e2c14575555c0b89a431.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
---
 fs/btrfs/block-group.c |  15 ++++
 fs/btrfs/block-group.h |   6 ++
 fs/btrfs/zoned.c       | 154 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |   7 ++
 4 files changed, 182 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6b4831824f51..ffc64dfbe09e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -15,6 +15,7 @@
 #include "delalloc-space.h"
 #include "discard.h"
 #include "raid56.h"
+#include "zoned.h"
 
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
@@ -1935,6 +1936,13 @@ static int read_one_block_group(struct btrfs_fs_info *info,
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
@@ -2161,6 +2169,13 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
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
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index adfd7583a17b..14e3043c9ce7 100644
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
index ed5de1c138d7..69d3412c4fef 100644
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
@@ -777,3 +783,151 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 
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
index ec2391c52d8b..e3338a2f1be9 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -40,6 +40,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes);
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
+int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -112,6 +113,12 @@ static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
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

