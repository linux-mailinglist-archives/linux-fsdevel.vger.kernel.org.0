Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E232FFC97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbhAVGZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:25:34 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51034 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbhAVGY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296698; x=1642832698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+qBTdF9MvihTRbktJGAoJMSoHkaOlQlVntTFaARTchE=;
  b=bTEwPZByRtAyfbt45bfh2AmkzRYbTFrjzY6Fsj8o06VLdveySabUoku4
   yriODWpjtv7MRiyHVTFGFENSyuWkQUu7jgoPNa52fCn8FLkhpm6H6XAfr
   4zRBEG7yHGcxzGAc86tTGyfj9Ch9oIqbYOICroN5F3C80AiAEMcIAnNQn
   6LsFzJLWm94A+5Cadye1VGEDCw//OvaEiEjEKYr0Gs2O8cWVIfnV6gE82
   JLhhgUflWYCEVh5axbGk+SoyoC2L9N4NJUj67kC44Jzp9ypJ6VdCZXJ4U
   FcarWZZdRqLC1ul26wtdbhagQDk/CUWS9JnQSEJ8V9HEYzbD0EgU5mcec
   w==;
IronPort-SDR: /xRzccXQSr1ZV4BJYBjoOwxubXwm35CDAfdPCg60XoGQWk8twnrlDrieV3l3S9aikWV7Ji03xj
 zZKetpJq+ajmITe1lK8hA/O2kvwEDVTsJepy/gD+YHT6evLZE6YNlpLGgDUQNdszYAS/8IYWuf
 l+jry8Nzk3VlK/JSJLSchYj9QGF44rBchT/sbNvP8UNRUvvZz4cVLdvBctsPSaJ8ISdhvMjHyQ
 mYGcgDtvkP8hLICG97lZPN8qzmMH/6Tc31F76d2BObeWpTvCQH7geZSmzIYtx+HLVujSaM+0eC
 mW0=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391969"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:39 +0800
IronPort-SDR: Vt2QTiyVn20k04AEvzHi1+AHTGhk4BKKukdvuis3/degyr/tPG0xeKhi1t8xnA7yrRnA8pLg5Z
 IkbDkzmvfGMgG5yX11soUO5czgFZLjW6sl/uyqIOhV8fA0c6dESE817IM0J2KjGDpx3jqP0V7u
 5J1KlS3Ocf+G0I/fhihw2xXc6kUt5hAOoGpsQy1p3dC01+KsGv0AK1z1jxNjOwZqPiZO+t964J
 063ayM1JzO33STrRQNtohiRkuSTvDV+bfe/pfZ7tckv6CcTFfwq1qaUWL/Wq5FdtzcA6DV2sDh
 +zY3OV322se7mcMswRHYBm5i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:11 -0800
IronPort-SDR: czpqo/x23DhNW6frKeu3ixXjb+88WXQlonVhvxnKI93yF73s7OljAOUWf+ZbQfpbWD2BuzcJmz
 aRzuyAkZu/Dve68L4vnqa1E1pFAFTDv36z6oFZnNlpUh2TJxqk+MJR8XmaNboNHWvG/AKOfy8k
 DwHOXTB3RnxJzI9YWwXBFdho13a6gw0QPl2zYIRvc3Ib70Sz+AlMYq1IOKXZvRWMbJhP1b8jmj
 Mi7l7gm6FsF3/Avpc/2xgJzJv5ypjRGynpVUYJa5bMX5BokTT027tALrHGI1b5HP++Fmsz3zei
 O4g=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:37 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v13 11/42] btrfs: load zone's allocation offset
Date:   Fri, 22 Jan 2021 15:21:11 +0900
Message-Id: <18b4014ae7ff556ccc0d2287ea9e68c08dd84643.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index 60d843f341aa..1c5ed46d376c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -15,6 +15,7 @@
 #include "delalloc-space.h"
 #include "discard.h"
 #include "raid56.h"
+#include "zoned.h"
 
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
@@ -1842,6 +1843,13 @@ static int read_one_block_group(struct btrfs_fs_info *info,
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
@@ -2129,6 +2137,13 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
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
index e829fa2df8ac..22c0665ee816 100644
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

