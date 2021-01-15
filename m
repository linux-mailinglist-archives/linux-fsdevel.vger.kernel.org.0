Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A92C2F7359
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbhAOHAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 02:00:18 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41647 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbhAOHAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610694017; x=1642230017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WD9LT9tM0885Oy1NdHTkL0CRdbifJwUyVIslk7M6Ut4=;
  b=En5LAMKEoV6jw60/m1T+5CxEgJQx66P2mI/L+LfPH6AzWNgr89inBDeJ
   +VeBsEWs6/8fpKyZXhBv7K15RHKCK9N9bSXHxvv0sd2MggnJuleSj5OM3
   +o606/KF+R6LprRPwTWdudJ5Zo9WtvHMkGj5Ch4M3ZybWXur7I8DTdbox
   3QpaH5svkNDTD6nLlsptm5B2aZciCix/0hEVCOOIHoTn4SXQuB+jIzjkn
   9p2nYHmC586bCahdfq6G+D+V/HFOmlFlocZ0+TvhO49ygPydeIvKOvkcZ
   c6ZZOr9o3s89JzGiNtGALg/dtrmXagXfpYGxumea9H8CAFyfsluClwsAq
   Q==;
IronPort-SDR: MNnYmfAz3FrjbEj6wIYUGKqnh1gquXsqVVWQUhtm8HKThI196NBbe0nYxK76A70xM32p7g1+Zs
 nTnKVlg0uCbslVtBWkxDsF/dVknQVsDFqouuFbIh92nPwkvnhd9lWQKjvlIJutktSY0wyCJYjx
 P/FpXQW9fem/cuRxDO80qOcORFnYDupS4FUDn9R16ygJpIH1LwNKQPB7aRBunVYVbWhrYEQbtT
 /4emFnwJb82cCci2TBoAlRkZ1P3n3PNKajRVeyaTWoUGOY0DZcx8auQNip7m/COE921H5G5Duz
 59A=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928304"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:56:11 +0800
IronPort-SDR: uPlEvnzlthldBLsu+kG093uf38MWTj4utz4BoNHTgZUtxxnYc6wFCwZLNuO8mSTxcQTokPRPhm
 ug/N30hMIpRJnUULW0sw5cPFwKWK8oQsmFjNXaAyzc7eR8BAsxanLmMNni6sgPEBzfV1jrdAnj
 4/axSHrQVjpBxQB3LWB6xV7uKXAPwulqH2RhnqbTxVVu9MOTcMAfTLmz0fx11xyZlY5vG13Y+e
 iVl/F7NxTEP8edWdfPHIvTQkTdCrXdejD171wApab/SsTJDCxiQTeJj8Q+x/MgJZyoLagfd+Mw
 cXlQsFL3t9T855CyfBo/DYog
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:53 -0800
IronPort-SDR: BpYbzjXjaZYcmtD1tNFGYFR74mBCJi8ujW1lJ0V52ymJsn/sHsjIcOLtSKP3CqoFyS9FyS6efH
 4DeXw8b2QBE6BHQ3yk6CX1rqS3GvhB+IPZwuubTT+q78pzc2QOUPuinEK+sE/3JumD9h4H5MHP
 wIdZvftqHiivz+olWf1aFFl4ZxLgh7D/yQ0YxQdLozMy1uiAAZwBfPT58FYMn2qp3xVmXxzSmY
 yWEr0xKxyzezv5sff4OBi1jFAnS9VdtLzzX3OO3JIQfafuzDL+XAyKP8NLGpcmnYS7LmFMJv5J
 G4Y=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:56:10 -0800
Received: (nullmailer pid 1916486 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 33/41] btrfs: implement cloning for ZONED device-replace
Date:   Fri, 15 Jan 2021 15:53:37 +0900
Message-Id: <cc6e7035d0a0851b90749a26d0e6c5da7a1f0b8e.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is 2/4 patch to implement device-replace for ZONED mode.

On zoned mode, a block group must be either copied (from the source device
to the destination device) or cloned (to the both device).

This commit implements the cloning part. If a block group targeted by an IO
is marked to copy, we should not clone the IO to the destination device,
because the block group is eventually copied by the replace process.

This commit also handles cloning of device reset.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 57 +++++++++++++++++++++++++++++++-----------
 fs/btrfs/volumes.c     | 33 ++++++++++++++++++++++--
 fs/btrfs/zoned.c       | 11 ++++++++
 3 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ac24a79ce32a..23d77e3196ca 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -35,6 +35,7 @@
 #include "discard.h"
 #include "rcu-string.h"
 #include "zoned.h"
+#include "dev-replace.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1300,6 +1301,46 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	return ret;
 }
 
+static int do_discard_extent(struct btrfs_bio_stripe *stripe, u64 *bytes)
+{
+	struct btrfs_device *dev = stripe->dev;
+	struct btrfs_fs_info *fs_info = dev->fs_info;
+	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+	u64 phys = stripe->physical;
+	u64 len = stripe->length;
+	u64 discarded = 0;
+	int ret = 0;
+
+	/* Zone reset in ZONED mode */
+	if (btrfs_can_zone_reset(dev, phys, len)) {
+		u64 src_disc;
+
+		ret = btrfs_reset_device_zone(dev, phys, len, &discarded);
+		if (ret)
+			goto out;
+
+		if (!btrfs_dev_replace_is_ongoing(dev_replace) ||
+		    dev != dev_replace->srcdev)
+			goto out;
+
+		src_disc = discarded;
+
+		/* send to replace target as well */
+		ret = btrfs_reset_device_zone(dev_replace->tgtdev, phys, len,
+					      &discarded);
+		discarded += src_disc;
+	} else if (blk_queue_discard(bdev_get_queue(stripe->dev->bdev))) {
+		ret = btrfs_issue_discard(dev->bdev, phys, len, &discarded);
+	} else {
+		ret = 0;
+		*bytes = 0;
+	}
+
+out:
+	*bytes = discarded;
+	return ret;
+}
+
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes)
 {
@@ -1333,28 +1374,14 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
-			struct btrfs_device *dev = stripe->dev;
-			u64 physical = stripe->physical;
-			u64 length = stripe->length;
 			u64 bytes;
-			struct request_queue *req_q;
 
 			if (!stripe->dev->bdev) {
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
 
-			req_q = bdev_get_queue(stripe->dev->bdev);
-			/* Zone reset in ZONED mode */
-			if (btrfs_can_zone_reset(dev, physical, length))
-				ret = btrfs_reset_device_zone(dev, physical,
-							      length, &bytes);
-			else if (blk_queue_discard(req_q))
-				ret = btrfs_issue_discard(dev->bdev, physical,
-							  length, &bytes);
-			else
-				continue;
-
+			ret = do_discard_extent(stripe, &bytes);
 			if (!ret) {
 				discarded_bytes += bytes;
 			} else if (ret != -EOPNOTSUPP) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c8c94e5081eb..f3ab7ff0769f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5973,9 +5973,29 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct btrfs_block_group *cache;
+	bool ret;
+
+	/* non-ZONED mode does not use "to_copy" flag */
+	if (!btrfs_is_zoned(fs_info))
+		return false;
+
+	cache = btrfs_lookup_block_group(fs_info, logical);
+
+	spin_lock(&cache->lock);
+	ret = cache->to_copy;
+	spin_unlock(&cache->lock);
+
+	btrfs_put_block_group(cache);
+	return ret;
+}
+
 static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 				      struct btrfs_bio **bbio_ret,
 				      struct btrfs_dev_replace *dev_replace,
+				      u64 logical,
 				      int *num_stripes_ret, int *max_errors_ret)
 {
 	struct btrfs_bio *bbio = *bbio_ret;
@@ -5988,6 +6008,15 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	if (op == BTRFS_MAP_WRITE) {
 		int index_where_to_add;
 
+		/*
+		 * a block group which have "to_copy" set will
+		 * eventually copied by dev-replace process. We can
+		 * avoid cloning IO here.
+		 */
+		if (is_block_group_to_copy(dev_replace->srcdev->fs_info,
+					   logical))
+			return;
+
 		/*
 		 * duplicate the write operations while the dev replace
 		 * procedure is running. Since the copying of the old disk to
@@ -6383,8 +6412,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d4edcc5edcfc..a50c441115ab 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -11,6 +11,7 @@
 #include "disk-io.h"
 #include "block-group.h"
 #include "transaction.h"
+#include "dev-replace.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1039,6 +1040,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
+		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+		int dev_replace_is_ongoing = 0;
 
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
@@ -1065,6 +1068,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 */
 		btrfs_dev_clear_zone_empty(device, physical);
 
+		down_read(&dev_replace->rwsem);
+		dev_replace_is_ongoing =
+			btrfs_dev_replace_is_ongoing(dev_replace);
+		if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
+			btrfs_dev_clear_zone_empty(dev_replace->tgtdev,
+						   physical);
+		up_read(&dev_replace->rwsem);
+
 		/*
 		 * The group is mapped to a sequential zone. Get the zone write
 		 * pointer to determine the allocation offset within the zone.
-- 
2.27.0

