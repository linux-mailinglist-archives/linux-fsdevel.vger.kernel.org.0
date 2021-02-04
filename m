Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0497430F0B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbhBDK1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:27:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54215 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbhBDK1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434449; x=1643970449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ENG3sQkqCF3XYpv8vzL6emuTctLGuWnbOyl1OJ3xoBk=;
  b=puw5LvwcZnqHkXgsCINGCuO0jJoM03mz6PeWIN9G5c7EQWcCSb2BmoTa
   /CBKxsQk/+TIUmpHLI7ZHGJOG9GPN0ajYGeRsa/L2cKxgwiRnxf5oyNCS
   A/SAWeLwVzVEzJQC/b5Nql4AUJx5ZzGiiNYd4xcK0ueSAQkbZKzwIFRly
   VIeK178q2hY9EO8VYN68ib4NSB5PxM/vdI6QUbpvELUM4k0DrbdUJvtXX
   OxVVivLOSDnGD/may+RAIwS9vyENIXOSES48sv0DSPLcjYLFH1qh3L3BI
   m0UxvFrT3eFLn+lALfTKOWjIK/Wot8aqUymiMJSyin4RzPvcD7GUFyeZJ
   w==;
IronPort-SDR: 7kekMcSSFrlsiRnz2AF3W96ezVXsFui8S4QdW6GDKcvz5ZHlej2k6j4t87y1iDs8ZRxwewBnWC
 RuaNosgTHP/4QNPV74TcWN7g25Uqd5Ze36Bliypn2x6VxaNwidafZIU3ytXQxIftSDxkap1Kk3
 zK/vEy9TMbNybYs9ImVM22wVMgT/zyxWKBQXYE0o9C3TCYcj83LluWw88BBQG13EuxbTqryX5d
 pfgZhY2UkG4XM/Os6ht+Nbsd6U1ZPtjNBiphytkiSnfrpj9GoJld4wlq75FLjXu2bw6B8p+8MG
 veY=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108021"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:27 +0800
IronPort-SDR: 9FxmCKAwNKTK0TTIJyS6cN9lqem02LKAkWejMXVqhTOh2nfyI0ATv1xxWK+F95oBXKsklsiYZE
 mCKR7M+lKF29INz3cN3Ycp5HLtWrMGR3BncZKW18cuOyabkzIrPl1corY3qx+c00/XZcuBhYIb
 HKfKg1ETvrs93t0Z/bTr10PyTnRrBt65P+SaxQgjU011+u6tXbsVAy8HawZiyeiHQ5qQ6SqlB8
 +X2nxOcN/EXqal1hEC/0Vd9Rv/2aMyNmY2P8A3jH5LZy/v1ZTCKDBbLZVFYkiF+mQBGa7o0bOA
 z/osJ5Ur8j4Ojx5Z1+RS4GVz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:30 -0800
IronPort-SDR: kbZImAqxxC3sdRuqBzAo61dhyFFATRgxyzLvm1RXTtYWvHKMjHZGhApvUEOwZiEeocRBqY39WU
 z0QXyOPVo7YSGW1pO0yqc7SQlaavuImpUIVcdfaDrt6b+blX9NeJR5a6WW1jH0X3cjPzTrKjUc
 ew/9QoSOFT46M/YyQSnHmUKAy9yHPH59o5ex91vM6ZFC2ZQc3leQCLTxnH5ahWU9Woic4OKIfn
 OdNYvmd1nPicnGgsjfGhZuXZXEpaT/N2MUu6V4ohhLp2UJ9yhGebn0YkmW5etWZm/Nne6P+okK
 kIE=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:26 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 23/42] btrfs: extend btrfs_rmap_block for specifying a device
Date:   Thu,  4 Feb 2021 19:22:02 +0900
Message-Id: <6b900f18c418206ed597abdcb0d7e9c8f47fdac0.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs_rmap_block currently reverse-maps the physical addresses on all
devices to the corresponding logical addresses.

Extend the function to match to a specified device. The old functionality
of querying all devices is left intact by specifying NULL as target
device.

A block_device instead of a btrfs_device is passed into btrfs_rmap_block,
as this function is intended to reverse-map the result of a bio, which
only has a block_device.

Also export the function for later use.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c            | 16 +++++++++++-----
 fs/btrfs/block-group.h            |  8 +++-----
 fs/btrfs/tests/extent-map-tests.c |  2 +-
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 70a0c0f8f99f..f5e9f560ce6d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1588,6 +1588,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
  *
  * @fs_info:       the filesystem
  * @chunk_start:   logical address of block group
+ * @bdev:	   physical device to resolve, can be NULL to indicate any device
  * @physical:	   physical address to map to logical addresses
  * @logical:	   return array of logical addresses which map to @physical
  * @naddrs:	   length of @logical
@@ -1597,9 +1598,9 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
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
@@ -1617,6 +1618,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	map = em->map_lookup;
 	data_stripe_length = em->orig_block_len;
 	io_stripe_size = map->stripe_len;
+	chunk_start = em->start;
 
 	/* For RAID5/6 adjust to a full IO stripe length */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -1631,14 +1633,18 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
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
@@ -1652,7 +1658,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		 * instead of map->stripe_len
 		 */
 
-		bytenr = chunk_start + stripe_nr * io_stripe_size;
+		bytenr = chunk_start + stripe_nr * io_stripe_size + offset;
 
 		/* Ensure we don't add duplicate addresses */
 		for (j = 0; j < nr; j++) {
@@ -1694,7 +1700,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = btrfs_rmap_block(fs_info, cache->start,
+		ret = btrfs_rmap_block(fs_info, cache->start, NULL,
 				       bytenr, &logical, &nr, &stripe_len);
 		if (ret)
 			return ret;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 0fd66febe115..d14ac03bb93d 100644
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
2.30.0

