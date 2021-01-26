Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF268304922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbhAZFaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:08 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38278 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732307AbhAZClk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628900; x=1643164900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iP1cE4eZOYaWr5cCdgIrpkccxeO7yiD76ZwPTB6mNrg=;
  b=Kg+FaWnZtkVZvzdxKrgzfqcb2yy9EyTwwqTJpA5Qf7akXUhUDWn0QaRf
   i+IsNdWHkvtcb/YfxuKenxqCtr27PcCo2p5K+uZz0w8SpyqTI9Yig7o7v
   nNVldTaPxr95bmlp+Rw/meH37URm/2HIe4BCMWeSCoyMMfcK6Txnkfsjp
   TwzTdkHLxOg9uPWi+9cIhKG0PmoIWd0vUeBelWQD/sQiw7xBgmxOl38cB
   oTbER3dpBJUpaTL6sBxOmHCJxM2QTsc00YrMF2tLevPXiXft+MlSMcjr8
   Q3n7/A8hmUGLyzavjp9Ciz5zZqUWYk9LKfd0S+tzyQdk9vAC7grhG0kyP
   g==;
IronPort-SDR: ZNFzG21KYeW+F9+qA2FCDCrMLZR1R9DCIZtKkz9yXxT3G+375j8H39CCox2gFSwoMknXBIVZN0
 JclGvDaOQuwcrgG3Dk5ay3hy5RU2Y829MT+pETxOfCO4vjFeINE9Ui6aZjexGZn0BLgQyszUuH
 RWsiApDysriJ1LM0rTITi1bsdTHW+A+29fVh9BQMNtq4EgFT5xwpFQw7bIb2enzoX9M/uyaQ1g
 FLp5lLuMg+4JVfIFZYuiILRyMhs7ouWiKGQS+RmnBkau/SdgrGBqirM5QH8IJroQ5SSZPG8JGH
 muI=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483575"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:57 +0800
IronPort-SDR: L+sg9lv2lI7sQXorRJSO+khXO45gJ4bE5k5viMNNAlya4q3YeCW9pX3+Nxg2o+iAE0dU5iSPVX
 QBI6BfJou3pZTm09AUm2SNA5512xBjRJhWH5PEjexqwNS0af3Jay1E+444ZYePYBkYtMM+Xsad
 /US2XlyhdQi2YyAo0un+3pRoP06/J41pX4DfovciyTFbVAPAVGvy4GIOGV6s1O+5JWAD65/Ilq
 gL4ynxo5p2M6jgp2zkVdr3oFTlsE5x4t8ySnMItxc5xrm4uwxdkEzuRRkanmKSvJVffUEE7sWr
 K/L7mdRXdTsRY4cvFtG4LbP8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:23 -0800
IronPort-SDR: 5GHUf3J7OcdeRz4rA0T/cMUGE8J35f5KvAe0nLS0m6wx7C3tHx7JPW5AF0lkAmCQXoUo0tuvEY
 Y+NH25M6wjWeTbEimj3oHXTbhidYt99kzC0OPlNPSXiMC6exvMq8lPQZepe1DHAZn1Et+eckqo
 GHk5KuVJ7webKwGRrAm8N4+XBIqz6qbn45UALkHlBAjK1Ppd76m2YjNjhRDbf5QlL7nQNz2Xhx
 hOqeLhliQw/gcmqNECpxauWgN3LeSSwaPFavTh0j6SoWLB2hGIeGWltvdyaQW+6pMMmkm+XPeR
 HHE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:55 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 34/42] btrfs: implement cloning for ZONED device-replace
Date:   Tue, 26 Jan 2021 11:25:12 +0900
Message-Id: <cd20fb01dd17af208772006213a4a0c825d2b4a9.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
index 4c126e4ada27..f73f39bd68c0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -35,6 +35,7 @@
 #include "discard.h"
 #include "rcu-string.h"
 #include "zoned.h"
+#include "dev-replace.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1265,6 +1266,46 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
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
@@ -1298,28 +1339,14 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
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
index 4cb5e940356e..a99735dda515 100644
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
index 7cf7d74247c7..462a6337d460 100644
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

