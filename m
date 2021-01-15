Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574A42F732C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbhAOG6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:58:00 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41681 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693879; x=1642229879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A++ufw9phHY3ZhkogXCWE4GuAvnx0fWMUujKI5le+QQ=;
  b=a6/hKzObcrue/dEU6tmlEzPODNwo6P8utXsPP0G4ZybOu/DYXTdcAOWt
   AU5eWYsrh5N+T2eTTobqxblA5vyyaNXdY/jC8dRO8CjAyPmoyHLRsbDFz
   Cd/Nzy4/QLjCsPbRvPhLgJ0wS9J58vPHPWqZQYvUAZ36qMRUs652g/WzN
   F+VXLEKZfAcNpTh3elWV/p9nvw0OyGy7Va1zlwMKqCzkbqIljF+ZGFoE0
   v1qUalI9lXGU/X3Eo651ufprcTZMIh5zGVjhRvEpOUeIJiw5e8TQq0NWp
   Zok3aEPRjTsE0hvh+giZR/LBkuSBfDc06Xixq0muF1xcEmi5MY44MfW8O
   g==;
IronPort-SDR: nFD2r6ZoeMn3hpffm9IonBAvgzgHIO+jq8eBl8YKgbfGksPOcsLebhahCrFGF4exGk1mVpEDMO
 bQO9TEcgQ8ecUv4YzqeX5n/1KvUBklJiu625kkuYpKyIfBwq13mBZT1jDJuJsYrui0u28hKyRc
 dQbinASbRIPBrk2nCusKbBImOMHogcbVCzCyzMFK7zQhyjRSAvuybo0YTyWPQyHV+UQHU0nGjV
 uuOfgBvnaXlFkx4WX1TfGfoRgJZGa2vjBCFayiMj/Lnxn3drgpwIXSQindAZNDJhCMnLOZS3G0
 Vmg=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928230"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:29 +0800
IronPort-SDR: D9tuy/CWn2cqfIQf2gZ15inp8mM38l/hAi9CQ8AJn6kdzrK0xi7p0AIHe0QTJbNWhrU8+bx20r
 6nBpBmNcta/8VVf37a4oLwkmkZNmrj6XwJk587IrAV+kP1M+J3jwawby64Qo1DfDARV0bIyiKY
 S06apLASiMxb6eqiGwbkvEv3ObjNMdFoOICWqQziR7u6KCYZmz2izM0Ec9wFk5gdPCuyr27sAZ
 je51EYXfVxmU02kiml5TbGICReMVZD6o15kxZ2T6Wb3tirEPTwfG2mF9sLHnjE/sXT2F84mIFd
 U62bZGcEnBWgkp23KG/PVBMy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:11 -0800
IronPort-SDR: drcCDu7N3d6ANmQfhzEPChauxyEPkEBp86pfdcumL0n77Y0bwyTxNyNLUKIkbUvkpB0cjgemaL
 +nOalM31Rmpw8Hz8f2fQ0VadJdoqYwC/dju3Jnzc6qgzFmNMAvc9vrJvFg25wk1qY3f20G137f
 5tYXrZC1cMIG3MzUd/EUtmuyojmXb0NPB6aAqGAuaRJWH0nyOzQ3aJgmyMQioAht7uxDvoi7Sf
 Qum/5KGEKz4XoTHXrcWHPytRt++wHmAvbvDyUBO2VyL8lZuuXOgH9qxx8rrpGCLBDWEo76edF9
 b0I=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:28 -0800
Received: (nullmailer pid 1916444 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v12 12/41] btrfs: calculate allocation offset for conventional zones
Date:   Fri, 15 Jan 2021 15:53:16 +0900
Message-Id: <c6e7103324d27c7f03d8af17c3aca6c2be02125b.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Conventional zones do not have a write pointer, so we cannot use it to
determine the allocation offset if a block group contains a conventional
zone.

But instead, we can consider the end of the last allocated extent in the
block group as an allocation offset.

For new block group, we cannot calculate the allocation offset by
consulting the extent tree, because it can cause deadlock by taking extent
buffer lock after chunk mutex (which is already taken in
btrfs_make_block_group()). Since it is a new block group, we can simply set
the allocation offset to 0, anyway.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  4 +-
 fs/btrfs/zoned.c       | 99 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/zoned.h       |  4 +-
 3 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 13edbc959bac..4607577df484 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1852,7 +1852,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 			goto error;
 	}
 
-	ret = btrfs_load_block_group_zone_info(cache);
+	ret = btrfs_load_block_group_zone_info(cache, false);
 	if (ret) {
 		btrfs_err(info, "zoned: failed to load zone info of bg %llu",
 			  cache->start);
@@ -2147,7 +2147,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
 		cache->needs_free_space = 1;
 
-	ret = btrfs_load_block_group_zone_info(cache);
+	ret = btrfs_load_block_group_zone_info(cache, true);
 	if (ret) {
 		btrfs_put_block_group(cache);
 		return ret;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 78be99b3c090..e8e7bca81a30 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -930,7 +930,68 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 	return 0;
 }
 
-int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
+/*
+ * Calculate an allocation pointer from the extent allocation information
+ * for a block group consist of conventional zones. It is pointed to the
+ * end of the last allocated extent in the block group as an allocation
+ * offset.
+ */
+static int calculate_alloc_pointer(struct btrfs_block_group *cache,
+				   u64 *offset_ret)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	int ret;
+	u64 length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	key.objectid = cache->start + cache->length;
+	key.type = 0;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	/* We should not find the exact match */
+	if (!ret)
+		ret = -EUCLEAN;
+	if (ret < 0)
+		goto out;
+
+	ret = btrfs_previous_extent_item(root, path, cache->start);
+	if (ret) {
+		if (ret == 1) {
+			ret = 0;
+			*offset_ret = 0;
+		}
+		goto out;
+	}
+
+	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
+
+	if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
+		length = found_key.offset;
+	else
+		length = fs_info->nodesize;
+
+	if (!(found_key.objectid >= cache->start &&
+	       found_key.objectid + length <= cache->start + cache->length)) {
+		ret = -EUCLEAN;
+		goto out;
+	}
+	*offset_ret = found_key.objectid + length - cache->start;
+	ret = 0;
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
@@ -944,6 +1005,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	int i;
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
+	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
 	if (!btrfs_is_zoned(fs_info))
@@ -1042,11 +1104,30 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 
 	if (num_conventional > 0) {
 		/*
-		 * Since conventional zones do not have a write pointer, we
-		 * cannot determine alloc_offset from the pointer
+		 * Avoid calling calculate_alloc_pointer() for new BG. It
+		 * is no use for new BG. It must be always 0.
+		 *
+		 * Also, we have a lock chain of extent buffer lock ->
+		 * chunk mutex.  For new BG, this function is called from
+		 * btrfs_make_block_group() which is already taking the
+		 * chunk mutex. Thus, we cannot call
+		 * calculate_alloc_pointer() which takes extent buffer
+		 * locks to avoid deadlock.
 		 */
-		ret = -EINVAL;
-		goto out;
+		if (new) {
+			cache->alloc_offset = 0;
+			goto out;
+		}
+		ret = calculate_alloc_pointer(cache, &last_alloc);
+		if (ret || map->num_stripes == num_conventional) {
+			if (!ret)
+				cache->alloc_offset = last_alloc;
+			else
+				btrfs_err(fs_info,
+			"zoned: failed to determine allocation offset of bg %llu",
+					  cache->start);
+			goto out;
+		}
 	}
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
@@ -1068,6 +1149,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	}
 
 out:
+	/* An extent is allocated after the write pointer */
+	if (num_conventional && last_alloc > cache->alloc_offset) {
+		btrfs_err(fs_info,
+			  "zoned: got wrong write pointer in BG %llu: %llu > %llu",
+			  logical, last_alloc, cache->alloc_offset);
+		ret = -EIO;
+	}
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 491b98c97f48..b53403ba0b10 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -41,7 +41,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes);
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
-int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
+int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -119,7 +119,7 @@ static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
 }
 
 static inline int btrfs_load_block_group_zone_info(
-	struct btrfs_block_group *cache)
+	struct btrfs_block_group *cache, bool new)
 {
 	return 0;
 }
-- 
2.27.0

