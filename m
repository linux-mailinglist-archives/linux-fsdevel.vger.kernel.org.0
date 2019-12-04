Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3587F1124DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLDI1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:54 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLDI1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448081; x=1606984081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P4gWUVdpCP7B3Ojc7ayMcAefVW58VKh9Ogz4kxt8SRE=;
  b=PvJgC2ih5iB5UWz9OP9F5zhR8YU2BsTDHh+Sv1x2y0f+lc8c7mKIKPHz
   3a37UYXbZW8LTX4DtzSqWnmEfvnXANnFXvJct5T3Qmj4ssjeGxlsVAYwu
   /BJKMIYdn6R1sHzFluk6jeZaJFFFmZ4Vtl5+NKcCAQtXJ/D6xxuYDeIwM
   gOTnX/BqXaWT10rVxE6SVCFRV1QcDr8RxgLPwnViOButiMtMiS7Fb7Yeo
   pq+U8R6avStofl6i83TlVJ9tN8kre3LxswPkm7ltSrhIbiDI76vC4KEbT
   EnFDKLGBvkdDOLMOR0Mrz5CT65KyFG5TevPhH/73A/fsaNN0Q2o86YewA
   Q==;
IronPort-SDR: EUbFeYqeAtgXAuXbh+RMDmRMlqoHOnH39x5DRyIRNnxrMQX3fDJrwIx5Ty6bSq7KFgJZ1z2hGz
 T3N31xMi65NUyyx+r9WJcXw/3++nQUG7ofOTsP+U7oJbZVqCBwYQjk4Wpxx7Uh+FbttwxgUdbV
 DQuVF2UpP/m53NORDS89HdCOk8AithvKY50AF74V0q5uGQl3g5b/BSUGNZAWnJkSWUXyfBMyOj
 iEKeejy5SJOEozHgakZgPezlOfpAX2UfSN0KNihGD9zUFnj3zFTahKnbQEUGokEGUabnLJRjRu
 eu8=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031760"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:28:00 +0800
IronPort-SDR: SBqEK48jJeMfO95+uRrIRYR7Ktj0ShvR1rcoQShhEvfFSQJ62epw27eKKTVgczhiJtL0Tvbggk
 LL1sPc4gvl0DveytIs/1ledr9vpy7ytPMumWQtqw7DrjxnHf4Kiw6QQCLFOpsGdW5D7gs5fnmT
 GpCBHMNoCfimWNUFoYVai97frCxh0YSvlwCjhFvNz1JKy+XewclyDhU2lLwdoz/djGlr+Vd6/f
 sPz3XKFuSV+2no0ioIuqbhdc300o0QccxVoFhEzQpJYgxaGQPnMx2Xb1Gl8gF2GLyhUim3mN6Y
 Lf2Sm+bIKZk7mubhDY+OOIqI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:41 -0800
IronPort-SDR: 73XmvTRJl3viCCwLMWJM1zqcwsc9PkkDGgRjergEG1wiYq6ZKWarItWFu23Ba+/TrVRIIC6fiK
 k26W13FIEW/94KSWJpTmnjPX5WfsS7HkRmupUTtGTtSinggT6XOhlVfee9mn+uNxnMzoNJ55Ik
 cVEt8WbmYgJPAcykjDN5wE2nhXtx25lStX8VcWp8JRWyRMPS5sA5m6VdhEadYjnwQU1dHTfnY6
 Ad++IC2EFEKr15IDpRqtwsf8emiX/FTTeec378O2UwoHZqsWHkz/7zWejTTBZWdo7sWQLfEiWN
 NZo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:52 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 11/15] btrfs-progs: do sequential allocation in HMZONED mode
Date:   Wed,  4 Dec 2019 17:25:09 +0900
Message-Id: <20191204082513.857320-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
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
 common/hmzoned.c | 406 +++++++++++++++++++++++++++++++++++++++++++++++
 common/hmzoned.h |   7 +
 ctree.h          |   6 +
 extent-tree.c    |  16 ++
 4 files changed, 435 insertions(+)

diff --git a/common/hmzoned.c b/common/hmzoned.c
index 2cbf2fc88cb0..f268f360d8f7 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -29,6 +29,11 @@
 
 #define BTRFS_REPORT_NR_ZONES	8192
 
+/* Invalid allocation pointer value for missing devices */
+#define WP_MISSING_DEV ((u64)-1)
+/* Pseudo write pointer value for conventional zone */
+#define WP_CONVENTIONAL ((u64)-2)
+
 enum btrfs_zoned_model zoned_model(const char *file)
 {
 	char model[32];
@@ -505,6 +510,407 @@ bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 	return true;
 }
 
+static int emulate_write_pointer(struct btrfs_fs_info *fs_info,
+				 struct btrfs_block_group_cache *cache,
+				 u64 *offset_ret)
+{
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
+	search_key.objectid = cache->key.objectid + cache->key.offset;
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
+	if (found_key.objectid < cache->key.objectid) {
+		*offset_ret = 0;
+	} else if (found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
+		struct btrfs_key extent_item_key;
+
+		if (found_key.objectid != cache->key.objectid) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+
+		length = 0;
+
+		/* metadata may have METADATA_ITEM_KEY */
+		if (slot == 0) {
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
+		    extent_item_key.objectid == cache->key.objectid) {
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
+		if (!(found_key.objectid >= cache->key.objectid &&
+		       found_key.objectid + length <=
+		       cache->key.objectid + cache->key.offset)) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+		*offset_ret = found_key.objectid + length - cache->key.objectid;
+	} else {
+		ret = -ENOENT;
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
+	u64 full_stripes_cnt = stripe_nr / map->num_stripes;
+	u32 rest_stripes_cnt = stripe_nr % map->num_stripes;
+	u64 stripe_start, offset;
+	int data_stripes = map->num_stripes / map->sub_stripes;
+	int stripe_idx;
+	int i;
+
+	ASSERT(profile == BTRFS_BLOCK_GROUP_RAID0 ||
+	       profile == BTRFS_BLOCK_GROUP_RAID10);
+
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
+	int i, j;
+	u64 zone_size = fs_info->fs_devices->zone_size;
+	u64 *alloc_offsets = NULL;
+	u64 emulated_offset = 0;
+	u32 num_sequential = 0, num_conventional = 0;
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
+		if (device->fd == -1) {
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
+		 * The group is mapped to a sequential zone. Get the zone write
+		 * pointer to determine the allocation offset within the zone.
+		 */
+		WARN_ON(!IS_ALIGNED(physical, zone_size));
+		zone = device->zone_info->zones[physical / zone_size];
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
+	if (num_conventional > 0) {
+		ret = emulate_write_pointer(fs_info, cache, &emulated_offset);
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
+			error("write pointer mismatch: block group %llu",
+			      logical);
+			ret = -EIO;
+			goto out;
+		}
+		if (num_conventional && emulated_offset > cache->alloc_offset)
+			ret = -EIO;
+		break;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV) {
+				error(
+			"cannot recover write pointer: block group %llu",
+				      logical);
+				ret = -EIO;
+				goto out;
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
+					error(
+				"write pointer mismatch at %d: block group %llu",
+					      i, logical);
+					ret = -EIO;
+					goto out;
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
+					offset = alloc_offsets[base + j];
+				if (alloc_offsets[base + j] == offset)
+					continue;
+
+				error(
+				"write pointer mismatch: block group %llu",
+				      logical);
+				ret = -EIO;
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
+				error(
+			"cannot recover write pointer: block group %llu",
+				      logical);
+				ret = -EIO;
+				goto out;
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
+					error(
+				"write pointer mismatch: block group %llu",
+					      logical);
+					ret = -EIO;
+					goto out;
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
+		error("Unsupported profile %llu",
+		      map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	/* an extent is allocated after the write pointer */
+	if (num_conventional && emulated_offset > cache->alloc_offset)
+		ret = -EIO;
+
+	free(alloc_offsets);
+	return ret;
+}
+
 #endif
 
 int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
diff --git a/common/hmzoned.h b/common/hmzoned.h
index 3444e2c1b0f5..a6b16d0ed35a 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -70,6 +70,8 @@ static inline size_t sbwrite(int fd, void *buf, off_t offset)
 int btrfs_wipe_sb_zones(int fd, struct btrfs_zoned_device_info *zinfo);
 bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 				   u64 num_bytes);
+int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
+				     struct btrfs_block_group_cache *cache);
 #else
 static inline bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo,
 				      u64 bytenr)
@@ -105,6 +107,11 @@ static inline bool btrfs_check_allocatable_zones(struct btrfs_device *device,
 {
 	return true;
 }
+static inline int btrfs_load_block_group_zone_info(
+	struct btrfs_fs_info *fs_info, struct btrfs_block_group_cache *cache)
+{
+	return 0;
+}
 
 #endif /* BTRFS_ZONED */
 
diff --git a/ctree.h b/ctree.h
index 34fd7d00cabf..fe72bd8921b0 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1119,6 +1119,12 @@ struct btrfs_block_group_cache {
          */
         u32 bitmap_low_thresh;
 
+	/*
+	 * Allocation offset for the block group to implement
+	 * sequential allocation. This is used only with HMZONED mode
+	 * enabled.
+	 */
+	u64 alloc_offset;
 };
 
 struct btrfs_device;
diff --git a/extent-tree.c b/extent-tree.c
index 53be4f4c7369..89a8b935b602 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -30,6 +30,7 @@
 #include "volumes.h"
 #include "free-space-cache.h"
 #include "free-space-tree.h"
+#include "common/hmzoned.h"
 #include "common/utils.h"
 
 #define PENDING_EXTENT_INSERT 0
@@ -258,6 +259,14 @@ again:
 	if (cache->ro || !block_group_bits(cache, data))
 		goto new_group;
 
+	if (root->fs_info->fs_devices->hmzoned) {
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
@@ -2720,6 +2729,10 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	}
 	cache->space_info = space_info;
 
+	ret = btrfs_load_block_group_zone_info(fs_info, cache);
+	if (ret)
+		return ret;
+
 	set_extent_bits(block_group_cache, cache->key.objectid,
 			cache->key.objectid + cache->key.offset - 1,
 			bit | EXTENT_LOCKED);
@@ -2785,6 +2798,9 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	cache->key.objectid = chunk_offset;
 	cache->key.offset = size;
 
+	ret = btrfs_load_block_group_zone_info(fs_info, cache);
+	BUG_ON(ret);
+
 	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	cache->used = bytes_used;
 	cache->flags = type;
-- 
2.24.0

