Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5950595652
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfHTExZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbfHTExZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276804; x=1597812804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6wqBtM5vCnBfxci3OwPFbWOSVcPwW9ETDEy611DquL4=;
  b=M1XbDQ5UJ2SR7MJ/MQq5zP3c/mHThRpm6mRs6PyJTeMoTB4gjuzIXKDE
   CGnrv3rnd8SdFlBNZ/KQqPJDTwk5liWOjKml4kynsvt/AUpJme6N+TTST
   i2OhVj77lGhETCZPYsHAveVN9knnCn00pL0Q+KtEWHylfGX/HYGZiO5S7
   QV3W9Fns9stlefj9npfAy8jgWwLenQ/rP4Y4HWXFkNsge1YIBwTbIJBt6
   1Hs6ZiBiVc29aFoTubXB/N/Gna/yE50Ha5T2jlZ4DLQW6+AsiV4Skx90L
   GJqjyGr6Ehe5gpSv5jJTJcbCUffNSPqvKTTKlxn/EzJPM3fW/xN0kegbs
   w==;
IronPort-SDR: hYXu+b47PBKytIqWwi1Ho9OYDKpbEGJdMl5/aw11D5X8LNYGggcS7aeyJbOW1D6ov24Kc6H+AJ
 /kC1E7T4bhlZpOtg7LVQaAY5COLxyERECqxbNuF2b+1TWBwsgKNdV/aFDN65+2Yzwz1n0CCdZw
 9AbmvLetHty4JXS2KGYSaJYmk/a3eSHY8/uym+KKEswRE5hjNzdyIxDL1W+UfzWB7O/tUWC3LS
 zFu6tDs8B+9wDUa+LkW7I9oJTnUYTRQ+/f6d+V9+Yc+KJhkOZQMx1iv+GrivK1SO22o4Wex8mx
 2QM=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136314"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:24 +0800
IronPort-SDR: RXvp/CUKsTFaSXSRSy3mASo8npG1uB3zR92AohctyapfQWx0I56eqrB5pTAGxRMshcMGXLRh+L
 N7yfy9vWFl6eAd+1AKI055omsBiwixU82qvth8jxiYmQixHkcKhS7K6BpYkVU+7gBu8UJHNRzY
 Stlyg1zofD6G9n3LjT+1vCQrTnYSiWEeBPO5zQK4tm2RKa940BXbfrdbWCOuhlwIBC1exfmdGg
 hc4xPmHVIkDTQwh2TswzalgxMLjqCSnWKHvjtsSV2cY+0MAo0kPs0k5DXeqtu6A69+TBT3j4y7
 lngcAWUUS/EGN4uEQKZ2aeop
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:48 -0700
IronPort-SDR: I+fkYedZC88d6yxFs0d42SQhrxqFWEOgd2XYptylaI+iur4QTqgT5fSPps2gOh98eNnQD9iy1N
 ys1FAA0gVBW7CM3Our20Eq7s9xZ4amyi0vWiB1FX4kOdHDfSV7GG/ygsBMtgmE0dw7HVoaWanX
 lEm1SrW06ewgHeVSlS+Lodd8mnAKcpSWptsPyfSya8/VCVdKF4PaPjUupSvFwzBSFJDYCgHAbY
 2plRyAtyfhrrH1hvs9aw5FX2xNWp/SJMajvLj+xR6DkukKqceYkZIfNqFR/LwYRKKI/Pc8W62K
 7r4=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 11/15] btrfs-progs: do sequential allocation in HMZONED mode
Date:   Tue, 20 Aug 2019 13:52:54 +0900
Message-Id: <20190820045258.1571640-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/hmzoned.c | 212 +++++++++++++++++++++++++++++++++++++++++++++++
 common/hmzoned.h |   7 ++
 ctree.h          |  16 ++++
 extent-tree.c    |  15 ++++
 4 files changed, 250 insertions(+)

diff --git a/common/hmzoned.c b/common/hmzoned.c
index b1d9f5574d35..0e54144259b7 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -31,6 +31,9 @@
 
 #define BTRFS_REPORT_NR_ZONES	8192
 
+/* Invalid allocation pointer value for missing devices */
+#define WP_MISSING_DEV ((u64)-1)
+
 enum btrfs_zoned_model zoned_model(const char *file)
 {
 	char model[32];
@@ -346,3 +349,212 @@ bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 
 	return true;
 }
+
+int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
+				     struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_device *device;
+	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+	struct cache_extent *ce;
+	struct map_lookup *map;
+	u64 logical = cache->key.objectid;
+	u64 length = cache->key.offset;
+	u64 physical = 0;
+	int ret = 0;
+	int alloc_type;
+	int i, j;
+	u64 zone_size = fs_info->fs_devices->zone_size;
+	u64 *alloc_offsets = NULL;
+
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
+
+	/* Sanity check */
+	if (logical == BTRFS_BLOCK_RESERVED_1M_FOR_SUPER) {
+		if (length + SZ_1M != zone_size) {
+			error("unaligned initial system block group");
+			return -EIO;
+		}
+	} else if (!IS_ALIGNED(length, zone_size)) {
+		error("unaligned block group at %llu + %llu", logical, length);
+		return -EIO;
+	}
+
+	/* Get the chunk mapping */
+	ce = search_cache_extent(&map_tree->cache_tree, logical);
+	if (!ce) {
+		error("failed to find block group at %llu", logical);
+		return -ENOENT;
+	}
+	map = container_of(ce, struct map_lookup, ce);
+
+	/*
+	 * Get the zone type: if the group is mapped to a non-sequential zone,
+	 * there is no need for the allocation offset (fit allocation is OK).
+	 */
+	alloc_type = -1;
+	alloc_offsets = calloc(map->num_stripes, sizeof(*alloc_offsets));
+	if (!alloc_offsets) {
+		error("failed to allocate alloc_offsets");
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
+		is_sequential = btrfs_dev_is_sequential(device, physical);
+		if (alloc_type == -1)
+			alloc_type = is_sequential ?
+					BTRFS_ALLOC_SEQ : BTRFS_ALLOC_FIT;
+
+		if ((is_sequential && alloc_type != BTRFS_ALLOC_SEQ) ||
+		    (!is_sequential && alloc_type == BTRFS_ALLOC_SEQ)) {
+			error("found block group of mixed zone types");
+			ret = -EIO;
+			goto out;
+		}
+
+		if (!is_sequential)
+			continue;
+
+		/*
+		 * The group is mapped to a sequential zone. Get the zone write
+		 * pointer to determine the allocation offset within the zone.
+		 */
+		WARN_ON(!IS_ALIGNED(physical, zone_size));
+		zone = device->zone_info.zones[physical / zone_size];
+
+		switch (zone.cond) {
+		case BLK_ZONE_COND_OFFLINE:
+		case BLK_ZONE_COND_READONLY:
+			error("Offline/readonly zone %llu",
+			      physical / fs_info->fs_devices->zone_size);
+			ret = -EIO;
+			goto out;
+		case BLK_ZONE_COND_EMPTY:
+			alloc_offsets[i] = 0;
+			break;
+		case BLK_ZONE_COND_FULL:
+			alloc_offsets[i] = zone_size;
+			break;
+		default:
+			/* Partially used zone */
+			alloc_offsets[i] = ((zone.wp - zone.start) << 9);
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
+			error("write pointer mismatch: block group %llu",
+			      logical);
+			ret = -EIO;
+			goto out;
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV) {
+				error("cannot recover write pointer: block group %llu",
+				      logical);
+				ret = -EIO;
+				goto out;
+			}
+
+			if (alloc_offsets[0] < alloc_offsets[i]) {
+				error(
+				"write pointer mismatch: block group %llu",
+				      logical);
+				ret = -EIO;
+				goto out;
+
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
+				error(
+				"write pointer mismatch: block group %llu",
+				      logical);
+				ret = -EIO;
+				goto out;
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
+				error(
+			"cannot recover write pointer: block group %llu",
+				      logical);
+				ret = -EIO;
+				goto out;
+			}
+
+			if (alloc_offsets[0] < alloc_offsets[base]) {
+				error(
+				"write pointer mismatch: block group %llu",
+				      logical);
+				ret = -EIO;
+				goto out;
+			}
+
+			cache->alloc_offset += alloc_offsets[base];
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
+		/* RAID5/6 is not supported yet */
+	default:
+		error("Unsupported profile %llu",
+		      map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	cache->alloc_type = alloc_type;
+	free(alloc_offsets);
+	return ret;
+}
diff --git a/common/hmzoned.h b/common/hmzoned.h
index 93759291871f..dca7588f840b 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -61,6 +61,8 @@ bool zone_is_sequential(struct btrfs_zone_info *zinfo, u64 bytenr);
 int btrfs_discard_all_zones(int fd, struct btrfs_zone_info *zinfo);
 int zero_zone_blocks(int fd, struct btrfs_zone_info *zinfo, off_t start,
 		     size_t len);
+int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
+				     struct btrfs_block_group_cache *cache);
 #else
 static inline bool zone_is_sequential(struct btrfs_zone_info *zinfo,
 				      u64 bytenr)
@@ -76,6 +78,11 @@ static int zero_zone_blocks(int fd, struct btrfs_zone_info *zinfo, off_t start,
 {
 	return -EOPNOTSUPP;
 }
+static inline int btrfs_load_block_group_zone_info(
+	struct btrfs_fs_info *fs_info, struct btrfs_block_group_cache *cache)
+{
+	return 0;
+}
 #endif /* BTRFS_ZONED */
 
 #endif /* __BTRFS_HMZONED_H__ */
diff --git a/ctree.h b/ctree.h
index a56e18119069..d38708b8a6c5 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1087,6 +1087,20 @@ struct btrfs_space_info {
 	struct list_head list;
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
 	struct cache_extent cache;
 	struct btrfs_key key;
@@ -1109,6 +1123,8 @@ struct btrfs_block_group_cache {
          */
         u32 bitmap_low_thresh;
 
+	enum btrfs_alloc_type alloc_type;
+	u64 alloc_offset;
 };
 
 struct btrfs_device;
diff --git a/extent-tree.c b/extent-tree.c
index 932af2c644bd..35fddfbd9acc 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -251,6 +251,14 @@ again:
 	if (cache->ro || !block_group_bits(cache, data))
 		goto new_group;
 
+	if (cache->alloc_type == BTRFS_ALLOC_SEQ) {
+		if (cache->key.offset - cache->alloc_offset < num)
+			goto new_group;
+		*start_ret = cache->key.objectid + cache->alloc_offset;
+		cache->alloc_offset += num;
+		return 0;
+	}
+
 	while(1) {
 		ret = find_first_extent_bit(&root->fs_info->free_space_cache,
 					    last, &start, &end, EXTENT_DIRTY);
@@ -2724,6 +2732,10 @@ int btrfs_read_block_groups(struct btrfs_root *root)
 		BUG_ON(ret);
 		cache->space_info = space_info;
 
+		ret = btrfs_load_block_group_zone_info(info, cache);
+		if (ret)
+			goto error;
+
 		/* use EXTENT_LOCKED to prevent merging */
 		set_extent_bits(block_group_cache, found_key.objectid,
 				found_key.objectid + found_key.offset - 1,
@@ -2753,6 +2765,9 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	cache->key.objectid = chunk_offset;
 	cache->key.offset = size;
 
+	ret = btrfs_load_block_group_zone_info(fs_info, cache);
+	BUG_ON(ret);
+
 	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	btrfs_set_block_group_used(&cache->item, bytes_used);
 	btrfs_set_block_group_chunk_objectid(&cache->item,
-- 
2.23.0

