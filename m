Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319942E04F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgLVDxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:53:11 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46487 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLVDxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609190; x=1640145190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0k58NK9bGJjpzxazJG5Jr6a+JRS4AIJhTmB88U7w6ms=;
  b=YOsGt7FETm8SuT+/iUxuaa2zPhr76j9wggMqmcdHDt5VX8TrEtNr+LEt
   MbZMfK/eBv8KNaQ+DISYNjLYmKUZ8YvUjoklmE64m/x+XhljlQmp6tgwR
   U0cuZC5ux18BFAtn8FiNIn2mG++MxesufqQ/MK9un43vRjkRUQ7880RiK
   rswpMh4GWN8YGloyQNqMp8xZk0lwwhs0U4yVYpVEeERQl8cubSLDiLUh5
   mcYgRVOTIhJGm26JK7bzg1aXGyoZfzCPbcx8i1DOVN+gjxqAI7ZGK15ar
   APMHAaDPW82iKLeVqAWAA0fbY+i5K5Ns1bzjcgHRqyXA30V/OIPzkox9O
   w==;
IronPort-SDR: pVXchcid6Dw63P5wKvzbHwizlscZwy69SaYUSLvgUvN4g+rk0PMyrD2jzmNnhHjPUmQdn5CfcO
 sYfcfOLDz70n5SkIwkQdTJJ1ElJY/VW7W8kaLu+UAXuaZq07yPUfqfg6WpF8BfGLrh4w+ww+Gz
 AvJHHM+qgVjIr7/8dTONBVIAYkk/dAyy/0zFr/ugZfPRZsR32IrEUl+bQte6VRCNylIFgD439y
 Sa2nRRa04uGFKyG/ymKvt23r/MR508/UEqYVCJPTXjT3iK5BdrW+NyTUxlyUTkjrc6zB4QD/kE
 W9o=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193763"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:43 +0800
IronPort-SDR: +i9vXJXmWlKhycv+j8h3hJLVhOn8wDs519uNmRMjXnTd9L/YwvTU5nEJqPnaIZBP4GM8uT28cK
 6YEbtGvtWuwLIj2QOQX0clMjQO2L7HZ77x0njm5+3uikLzU/UgAvDiAu5p5Uh/KTLp30WviuEN
 o1Yn/ZX6iBIe2xXkLq39e2c4Jko9zv3AzxFrvMLsqvihSj5zzb1iBkq0pNcGBWOz9Jadwp8mY8
 wnar9eZ971oi6XJFaP78wPITXz/DJQ+8EmWcyOr3+AfBtCePtz6dczS8f7XgFozZJe4xtdSu2n
 YZNUtjS39hrLYhMSTvrIEvsw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:54 -0800
IronPort-SDR: AQqJlV0cpDF33YTI6VGJcfEVU2Fs0dky76ODlmUP+ibDQxuZfyDXqDMDhsgyS9yM3O4nj0agTC
 z7B1bHSlWw7kZMjq+T8MW9+7jJrefYgyadvu2W3bi5i2N9MunPy6HY+0W5ZQUsiG7oLHxewT6K
 SQy4icpuWJ2AgDJ3p485/R0GjxjYDmMdnrF8XSeAceT/HBLTaM+OmiNEoGJOnNuYqyMDZMfZVG
 SWZffRZuQ1a7NlyTHGgm4kA8u6wnssUtE4bdGHN+YjqGkKmQ1Mcs65KtWIRckndWcoqOXi5JDd
 qoE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:42 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 12/40] btrfs: calculate allocation offset for conventional zones
Date:   Tue, 22 Dec 2020 12:49:05 +0900
Message-Id: <5101ed472a046b3fc691aeb90f84bb55790d4fc0.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
 fs/btrfs/zoned.c       | 93 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/zoned.h       |  4 +-
 3 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 8c029e45a573..9eb1e3aa5e0f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1867,7 +1867,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 			goto error;
 	}
 
-	ret = btrfs_load_block_group_zone_info(cache);
+	ret = btrfs_load_block_group_zone_info(cache, false);
 	if (ret) {
 		btrfs_err(info, "zoned: failed to load zone info of bg %llu",
 			  cache->start);
@@ -2150,7 +2150,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
 		cache->needs_free_space = 1;
 
-	ret = btrfs_load_block_group_zone_info(cache);
+	ret = btrfs_load_block_group_zone_info(cache, true);
 	if (ret) {
 		btrfs_put_block_group(cache);
 		return ret;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index adca89a5ebc1..ceb6d0d7d33b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -897,7 +897,62 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 	return 0;
 }
 
-int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
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
+	if (ret <= 0) {
+		ret = -EUCLEAN;
+		goto out;
+	}
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
@@ -911,6 +966,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	int i;
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
+	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
 	if (!btrfs_is_zoned(fs_info))
@@ -1013,11 +1069,30 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 
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
@@ -1039,6 +1114,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
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

