Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD26F2E050D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgLVDyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:54:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46466 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgLVDyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609255; x=1640145255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ryrJqolQuBLyluqSpEAB6tG7QL/h6xLkGT2xVe2fUc=;
  b=l6DgOCab5kJdXgE2sgs86scCy4bfVGf/4mQQFD/mLWgQ0l+9i38GU0zr
   Gk7CgG2ps8qa5w19XbeXFnhFNlgGPQPCO2Snk1JjtTf+q6DOjNAdbXzWK
   6tkauvjluOQeU8MSmRFS19RuygCiAqNLPLS9TTBuFjAfs8ONcfMrdF3uf
   MnYHjIv7xlaBINQNzgmRuXj15skeijfVEKm4sflkqsmifE1xMWbWVfTiY
   vnXAmUJsKz0qx570iRDoYGWJ9EbS3Yj94dwtbXJSNINaEvxSkfHyxBv58
   CeA32sSWlY7D0yqvt6riUs6krkkVXTbQkvq31qd1yG9Od+AMRY+NfBrMu
   w==;
IronPort-SDR: HhCQrK3FxXMWgIMZ2rxOUuZ0pdIh/cRc0ovgIGAMSLCb96A4a5zNX9o4hRLDo3U/kBFje+RcbM
 4Di26m0Vc6WQJdfH0GdxnPCDuqNrlQ1NGdYMw8eqBNI2+JYOhzcwRiC74HMc7Lk/lywVAlzxF6
 lTLNoBxxdxtPcI0V06yiOr8x+CYcIltGi4zYhEiMjLLv2ZEddFmf34BdD6iqL2CRXn1VF+zp5X
 M9s+ey9aGxLEeA1ysw/oLmx9DN+X5n4CPQSlXGoJgpB+Cjep10U6gQDJCTPyAMrw0k3AI3fuGy
 fiA=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193809"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:01 +0800
IronPort-SDR: ACkJkvOrRPW04yEHbav+RityWtnmYeo9461LrJr0nKFhux2Ip40y2BYKv9cHbTURCk9/PWBoxO
 0llJyE4VGQBXsaxqyJaacF3SeMu4HP7H8gcshFpT/2Njkwu33q5FiadQuUssIrY1Iy+LCZldW3
 UpUwwz9Z/epFBq/9Re2CUJxEl/4sZOa0QzKFiCFpszDkhThJEaJJOjOMJHpwNWaYKWtW20zxXo
 walf/qoLW5TqixaoiGI/TelvKld5QzADM5wAvl/nUAE5tjUSVvdG90QrPZZFjJn/pvYG/s7RFc
 FEZZcjqCnQ+6j503dYJpZxbI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:12 -0800
IronPort-SDR: HibHF9LM71QsXr9g0/lYv7Kzz+b3ClhYiVBC5iDlN59ZjtQVY8U0G3p2f512nWKhq1Gz91SCp0
 xyz4QuXlGmgkiVT1/GF/HjckJd2dprydAN1qEBN0gQKLALZDU+7cB4RmCZRjFDXlL4E8Spkrcx
 iT3ivxRz9Xb9WKETT22p8PMfuZ4Kf1ATsRYh1P3fr2fkSii9Yv12Jwx3xS1B+tDkp65g54oDVq
 zxbh062fz/cyyjgtJa8lr4iMR/Plu2tfkyCx0V/U0vwuT1BI8OAjCrwhTbDW9Ek+Vjx7QgIeDf
 +MY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:00 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 23/40] btrfs: extend btrfs_rmap_block for specifying a device
Date:   Tue, 22 Dec 2020 12:49:16 +0900
Message-Id: <62d40762a5bbcc27377d15ac76e5f5f874acbc1a.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c            | 20 ++++++++++++++------
 fs/btrfs/block-group.h            |  8 +++-----
 fs/btrfs/tests/extent-map-tests.c |  2 +-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9bc6a05c8e38..5b477617021f 100644
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

