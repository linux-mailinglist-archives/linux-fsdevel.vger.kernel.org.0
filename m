Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A52F7346
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbhAOG7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:59:20 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41680 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbhAOG7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693958; x=1642229958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSZERuJD86LxlnqxkApvgrloFWpKf3y7EDgp8rxmJ8A=;
  b=DlyH8yR8lf7HGqOIgN6lrSRqi6S9r52QysyvxA6JcCLURU/VAPdBnyO8
   9vVd01qEb97eF0VfDqpnzE9ZmDlevPePYiJAElLKBxHKl1NACSDX7o26G
   FYtMPxXh8w5E1fDc/znp134ijLe5dKyLwQOoBG6IBsJ714YU7MmICowTl
   TydjbraQip2YIqlStgBdUpdjJpBriHjzha68A07/6byGDbwFpurp/o1YS
   MibY9DT/bPyzDPmh0IhAG8C20ubjNhVdN8avTS3fl3bp7EcsWPp4dt1vN
   CmAOcnFHutPZPdtjDEhsQiIRgDc2Lr/JOLiO/Xneb71faqJsRgJKHwxwl
   g==;
IronPort-SDR: sZOv0YF3r5/kI1ucJnO29kf1790rsA8iZI+tytWTxv/x02sldvin0hc9O0IgwdOMRou/TiWtDe
 Xr0Ae4mCuAeSmxtBsoyNzQrw/bP9eVjXejzxVt7wXtMxZxAF5kZ8Ul5uAyRK10Yir44qleisaR
 2WlfQGA5k4t6/K6OIRPlzM1mHVFJDUVQUX2LWDIED348od90oAbJ3OctH6Lnu/78Ar35CJs5gv
 XE3SNzQbX01p2nS7aoojqWBRs6cKTlS4vt2LxHzdilr80V+H2nImk+VAFM5mQNazd0m/rgj2cM
 sv4=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928273"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:51 +0800
IronPort-SDR: rY6qp9BKjni+4bZeKHhp6KGJBIEBVSaAdfqKdRHIojqBpDNH3OI365nZwTNRyHbsm8fC7E87Km
 mVDMvYThKxK9mu52WEAhHwHuX3m1ZxVbNDCecsfsvTPYxhptuqx0dtHcTwCZzE23dJa4KgOzU0
 vfn/HhC+cB1095TAwNYfBEoXK5ug1PPUYWhi/fD9ZCkiq+BjCsS8wgKKNzbbX8i3sTfz4FwhTo
 YYfgNX99p00T++lIX2Sw7OdDR54VsiPNSaczr+FRyi2dbJuHKD1COvG8m4VKk3Dnxiy+Ed5UtR
 iFBzVLMxkSyrnIesQeFfr3Kd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:33 -0800
IronPort-SDR: B13D6lOAcF86JWkGUQ4Zoq89UJYpLFKbFyBdXkWki42kYBRDKZt9RR24HaXNFkEfio7JnUSKHu
 Ae+HhOTJ7q4PAdIhtSEGj2ArDgnX371wcHUlgyFi8NlUSBW3V5ZWu8DzLmSIgXXZ4YSM5QsyHv
 X34ie5Yb1BgLuj4ArsdAgcjEVXndHx351bJfq4BIuuGrErAlCKskOjYN64hkoxsfuqXQOaFA0t
 OPuEuIx24QZpZ8XX11HudYytuZKZ0DBozR5wyGrHZlNVXiIxZtorAYoMo8xncRtp6TRJ3QInI9
 za0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:50 -0800
Received: (nullmailer pid 1916466 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 23/41] btrfs: extend btrfs_rmap_block for specifying a device
Date:   Fri, 15 Jan 2021 15:53:27 +0900
Message-Id: <02a9e2dd2d839fb694d5bfeb15fe6cc86a886f8a.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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
index f7c85cc81d1e..7083189884de 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1576,8 +1576,11 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
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
@@ -1587,9 +1590,9 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
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
@@ -1607,6 +1610,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	map = em->map_lookup;
 	data_stripe_length = em->orig_block_len;
 	io_stripe_size = map->stripe_len;
+	chunk_start = em->start;
 
 	/* For RAID5/6 adjust to a full IO stripe length */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -1621,14 +1625,18 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
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
@@ -1642,7 +1650,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		 * instead of map->stripe_len
 		 */
 
-		bytenr = chunk_start + stripe_nr * io_stripe_size;
+		bytenr = chunk_start + stripe_nr * io_stripe_size + offset;
 
 		/* Ensure we don't add duplicate addresses */
 		for (j = 0; j < nr; j++) {
@@ -1684,7 +1692,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 
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

