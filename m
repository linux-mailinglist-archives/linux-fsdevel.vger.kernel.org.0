Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F204E2FFCAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhAVG1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:27:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51034 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbhAVG0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296793; x=1642832793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=//70rDfox0kCUW89riT7Fpn9gi3UCqIqusi9c1b7/Hk=;
  b=Uwjf78MxnZ5iMD6zA11XsQnKkcYMq7TSsrpDMnpYSuRPxtj0N2uNq/cX
   p0RGUiJWWPAOIrnHa1fidBCD5GfFJZtSPQB7Vh8ePRLJxiqdvXqdZs5Gm
   lTT9oelNblPQEEJrt//XnIzZk9n15BlP5o7UYz4s2F6gGPC+FxboCc3Py
   ooi/Vn/y6VZKm/27kLh6TGqWOPqa6GUaD/eoi+3nGeN45xwne2QB2ya67
   3WIuGVfDkVA6M0LwbmN1eUzAVMZ/7NIezClLcX9BCUc2T1NTCOmiAyy3B
   BtoOPmBPwM/PdDy1U1+o3hw1FRanhc/vq0MAYMfzTPlB68l83Wl3Ns/Tq
   Q==;
IronPort-SDR: AhvIUp/3jiFtKZw4xWcsCq8hoe3Oy68SYxzktN9WFqHc5hAyEzx3M1QaHVd5POEqFscJHFjSAy
 /hqIlQfmet4KJ6QlC12TCu1wDrJU0hOct7wgUYlbAI8pi30Us4Ze4WbRpsC02QLV4xbCWcodxa
 hepO3I44kmegaj+VqFQKaJaTkyWe8i41cTX7prdwglcUG2zSz287K/J5LsOK5lmiIPx/oa/FkJ
 fc0XuuV52NgzBd1v/9zGSdk2LUzqpKOZF5atJ/v+t2m4CQjSmnRzRLVKpUQW65WYYowoXkf7V7
 msY=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392016"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:00 +0800
IronPort-SDR: QJ0iqQ73yvnydUpk11Dm64hKi76uHdHnuWFWRmsh5QAGBLBDgrTZ5CjSj699tjOeFShi5HwmkG
 EF2RTxVi8zUWBcNC52sBq7V/100MtkWa1XxxMM8boja8SwQGiKXpKhhMRwWmNBviH4UFVB73M3
 jPvdfA3prV/n/D45xq1m19pAq5QFRXnO6wlM432Ll0OEbWsUZJffYXYd/wM5I2DXiXCGco/oIj
 m8kJNM7HOzRvpF0BESLLATyJAkEixYefpRspJpsRMjHhmapqiZrMy2X8m1CRvfoGQj5ejfBlgc
 ahLAAkQ0fHSovJRADI/plmuT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:32 -0800
IronPort-SDR: a8Ne05rkLySN2lKyBSnllGFHuaSgDwldUfUOcvN75pYKn75L4LLmgSM6cSRffiVJEjzKHADnYP
 g7UfQQe3SYhylvjU1PXeM0R5FbllyCAtMEu60A2BWFCrBTBFAB59FJz90O7tjqPVuMbAo8UUr6
 1yMyqMuBEhizbt0Jti9NyM0X+h0Ier/pTPfDfoWUj5mPVV5JzBXEvvS/1x0MdjPDKRGD8kkOnO
 K88vs93Nueo0WbBwxKtiAK1aQs36W+WcP9KjmiWr79UpRFuRLKZ9Il+VQNw1SxoBDEyJX5oWO+
 Zsg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:59 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 24/42] btrfs: extend btrfs_rmap_block for specifying a device
Date:   Fri, 22 Jan 2021 15:21:24 +0900
Message-Id: <b8dac38b531a81e7ea748db8ed4d492cc747d95e.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs_rmap_block currently reverse-maps the physical addresses on all
devices to the corresponding logical addresses.

This commit extends the function to match to a specified device. The old
functionality of querying all devices is left intact by specifying NULL as
target device.

We pass block_device instead of btrfs_device to __btrfs_rmap_block. This
function is intended to reverse-map the result of bio, which only have
block_device.

This commit also exports the function for later use.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c            | 20 ++++++++++++++------
 fs/btrfs/block-group.h            |  8 +++-----
 fs/btrfs/tests/extent-map-tests.c |  2 +-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e05707f2d272..56fab3d490b0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1567,8 +1567,11 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 }
 
 /**
- * btrfs_rmap_block - Map a physical disk address to a list of logical addresses
+ * btrfs_rmap_block - Map a physical disk address to a list of logical
+ *                    addresses
  * @chunk_start:   logical address of block group
+ * @bdev:	   physical device to resolve. Can be NULL to indicate any
+ *                 device.
  * @physical:	   physical address to map to logical addresses
  * @logical:	   return array of logical addresses which map to @physical
  * @naddrs:	   length of @logical
@@ -1578,9 +1581,9 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
  * Used primarily to exclude those portions of a block group that contain super
  * block copies.
  */
-EXPORT_FOR_TESTS
 int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
-		     u64 physical, u64 **logical, int *naddrs, int *stripe_len)
+		     struct block_device *bdev, u64 physical, u64 **logical,
+		     int *naddrs, int *stripe_len)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -1598,6 +1601,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	map = em->map_lookup;
 	data_stripe_length = em->orig_block_len;
 	io_stripe_size = map->stripe_len;
+	chunk_start = em->start;
 
 	/* For RAID5/6 adjust to a full IO stripe length */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -1612,14 +1616,18 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	for (i = 0; i < map->num_stripes; i++) {
 		bool already_inserted = false;
 		u64 stripe_nr;
+		u64 offset;
 		int j;
 
 		if (!in_range(physical, map->stripes[i].physical,
 			      data_stripe_length))
 			continue;
 
+		if (bdev && map->stripes[i].dev->bdev != bdev)
+			continue;
+
 		stripe_nr = physical - map->stripes[i].physical;
-		stripe_nr = div64_u64(stripe_nr, map->stripe_len);
+		stripe_nr = div64_u64_rem(stripe_nr, map->stripe_len, &offset);
 
 		if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 			stripe_nr = stripe_nr * map->num_stripes + i;
@@ -1633,7 +1641,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		 * instead of map->stripe_len
 		 */
 
-		bytenr = chunk_start + stripe_nr * io_stripe_size;
+		bytenr = chunk_start + stripe_nr * io_stripe_size + offset;
 
 		/* Ensure we don't add duplicate addresses */
 		for (j = 0; j < nr; j++) {
@@ -1675,7 +1683,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = btrfs_rmap_block(fs_info, cache->start,
+		ret = btrfs_rmap_block(fs_info, cache->start, NULL,
 				       bytenr, &logical, &nr, &stripe_len);
 		if (ret)
 			return ret;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 0f3c62c561bc..9df00ada09f9 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -277,6 +277,9 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
 void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
 				struct btrfs_caching_control *caching_ctl);
+int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
+		       struct block_device *bdev, u64 physical, u64 **logical,
+		       int *naddrs, int *stripe_len);
 
 static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
@@ -303,9 +306,4 @@ static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
 void btrfs_freeze_block_group(struct btrfs_block_group *cache);
 void btrfs_unfreeze_block_group(struct btrfs_block_group *cache);
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
-		     u64 physical, u64 **logical, int *naddrs, int *stripe_len);
-#endif
-
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 57379e96ccc9..c0aefe6dee0b 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -507,7 +507,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 		goto out_free;
 	}
 
-	ret = btrfs_rmap_block(fs_info, em->start, btrfs_sb_offset(1),
+	ret = btrfs_rmap_block(fs_info, em->start, NULL, btrfs_sb_offset(1),
 			       &logical, &out_ndaddrs, &out_stripe_len);
 	if (ret || (out_ndaddrs == 0 && test->expected_mapped_addr)) {
 		test_err("didn't rmap anything but expected %d",
-- 
2.27.0

