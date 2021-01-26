Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2C304969
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbhAZF2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:28:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33033 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731906AbhAZCcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628365; x=1643164365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yhzRzcUFzBIUDc/7z/NWn55YH+KK3c88UuahRAjMiI8=;
  b=IIV7Syg20r8Ori8ncUJuG1UDupSo/SP1u6kYtnwNjCQdsdpSc7NToKj9
   lP1T+xf3ZUfDOp+GoY9e4Vj7RyrrafUIVBfUTEUfQEW2007+WUBcS8W3J
   a7JwDtVFJtX2jH2zMD55t4/WIuDMTJfcd62BoVCG0OlKFgms1Ipf+1pXW
   hy/RYh1f9TyoMmx1tkVIn7Km5g0hl2+oft1TxHbyf2BpwvM04aj6MiZDG
   0mXIKrN4M/YvIZz5RdD2qeddWGWOss3N+FOAB+fWklZXUmN00BYUDtXKo
   yDAZsFtVcvPChM7JE0xKc3gdCiK3MBgshaUjL5jwn8hcN7TV8f1NWFb0f
   Q==;
IronPort-SDR: 7QclYlWYiIG5o681VfTKvplssz+2zM6sAFbLamPfz9ER7gaMBxckWQs1sf8LUvXWWFEFE3YV+j
 0x3jKjiIvfFWMas1L706ewDkgFGiWe1PiDuvW3z4YaSVVuRO1PAqx8ofzgJ8jgMz+0AzkIysKj
 39x8dDRdK6zvoShs4Dk7VT9e79GH9pbz/EiCzy5oPzU0cnynjVVuEn0ftRsiRS12y+rajdBckA
 4LzDIYgOP8f9dMeDgCMe8yXMqXMKaSbQimY0/ymBtRZgHYYLj78kEIoLU3wXEmxpdsm6zqBWNA
 6Zk=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483531"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:20 +0800
IronPort-SDR: LSvggqn+dmNkJ6bqkb93zdRDX/DM7oc0B8dKkYpf43hQsTYO7n6xK2jGYXgKF2FIWxvtIwRHWm
 j8DWa1hqJJNUM2G4z9fCc+BxEehJgo/LXwPQZwdZy63efaQYYcRiPT0aI6yvg0GHRfRwXoW9j1
 OSf7Fs76qY+O4UUUF0cMDSajGDQWi7S4fpf0D72qGDgXeOis+507hvPP799f5L1kXd1+nRaTie
 Eh8Z6VfwEndoDiPjEYGJibkwddAB28q3ChVLi4ebdKijMRwdXUeMDvbj4FG6jOWk5sit5SeJBE
 ytvgmLstK4N6NBhGgY1E7e2R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:46 -0800
IronPort-SDR: 4d1jYEem91L68oScgvgBA/0L65oLor4mNLoFmS9GnChqzz3WrT7HpzX1kIW7TpGrGsv8d0cH7B
 TlfriHlMCqhOnourLo/x0gUf9StHKCuYarLmXptLIrId+FwHGsvMTSW+ToWp/i8xYCrNyHtUke
 2URh3frCEWV+3a8Mll7OAbc/pzOxNT0Uz6xnOWASTW4YlAauFjI7JslbhFnkHIvYnHYPHek7E8
 bPHJr8PPfFOGu0PgWxbSMN4F+xaO8TqTLl91FO4lBm8389r2fxyiLN99LZhO9kPedPF3KmB3B/
 WCU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:18 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v14 12/42] btrfs: calculate allocation offset for conventional zones
Date:   Tue, 26 Jan 2021 11:24:50 +0900
Message-Id: <583b2d2e286c482f9bcd53c71043a1be1a1c3cec.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
index 0140fafedb6a..349b2a09bdf1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1851,7 +1851,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 			goto error;
 	}
 
-	ret = btrfs_load_block_group_zone_info(cache);
+	ret = btrfs_load_block_group_zone_info(cache, false);
 	if (ret) {
 		btrfs_err(info, "zoned: failed to load zone info of bg %llu",
 			  cache->start);
@@ -2146,7 +2146,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
 		cache->needs_free_space = 1;
 
-	ret = btrfs_load_block_group_zone_info(cache);
+	ret = btrfs_load_block_group_zone_info(cache, true);
 	if (ret) {
 		btrfs_put_block_group(cache);
 		return ret;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 22c0665ee816..ca7aef252d33 100644
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
+	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
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

