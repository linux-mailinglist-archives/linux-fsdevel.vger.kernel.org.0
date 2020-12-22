Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455E72E051F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgLVDzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:55:23 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46437 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVDzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609321; x=1640145321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xGB1YW/m/PVdyIFc8B0FP2nDC5s/aYIwrEWrqvmVyvg=;
  b=HggQw5UUtcywTjWtjblZii1oSxi5YCWwjdaN/xs47DcAKKz8zdkcx5e/
   Bsmv8g6U3S07Fk3iQ3SoT8WKXjlYkxHI/z39i2FYTcJ2f92IW67sseKb4
   ageuMi18BaNS42pKKFmrXzGlLip7pU84gLGT5CiRgtZsBHtqbMgUPMTAF
   l3R7lf9thzGth2pJ8UofEMIlKY1CiLtEO4jJJ6z6+wzbiQpMarvBnypDx
   dKUbOWwc0JZ/yuIL7dzg8cmXFGKe47VO5Zeruyj1EpyXBqHjvrTn0czlQ
   BEVTb5mTcqNgSZYFM5B/whhcmqNT/aR3aQbbaCkw1X2XagEahK41Q1tdE
   Q==;
IronPort-SDR: i3mLLEPEYHFWppZaltnKIU0ey5xIOgQW84AwvCVTf3V0EhPq8yAOUPaQOFyJWvEFbtDuCbOCE6
 rCz2vqAEa2so6I1pRni4GU5ZEiGMSO7A+zwGhO9W6FdgS32hScaRjCMxo7gDQNxh+IgD5ykFZp
 7Ai5IDfOEnu69l0EhzEQ0vVAfYzXXpzgNP1sBoJZOHX2uDxWxBVtbxnvkPGiK9tpBB517zuEcX
 S7v9Nw2rlRjgYssPgJekcK6nEh2LP6OS3X6CiNmzSXXxXw2v5uNsCOpwWN3qJHmEOhywT3RiD8
 sdk=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193851"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:16 +0800
IronPort-SDR: MBji+eZyNIo8QbAjx97ZBy1jB5om5uiH3Gp4iNV3svtnntoLKBZh/zLA3+0fCozdnvayzFeim2
 qaBZ8dBStsdqw7DNLPaCCPdcOECVm1HAJZeJDRV+qjK8L1+EwI4YjOmE8d2vfDGA3Xkn7ueFI3
 lYifJYeBvI9eJ2KUmk8MuJ2kozM1QrrGcpS1TUiboy3oAzQuelV5Uwvd2/1d0lBTlPPHzDRU0+
 RJmdTd2tjQ4BulZNYipkg50cjate9fvwZKWFf+v8R7jxuf85plhbfkyAbE2lRADBpOzV2L0Oh0
 2kwRlVnTpYbY8/qY+pf+yENo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:27 -0800
IronPort-SDR: KDyVcD8DroCz/IeAWqNnBYwg+uUPVF8+GZNuk2jcXuNqjx058ybALj2wOqwwsjGZQutscYr+7v
 4Rh6xRtkpUPIuHNI+bYiF4suuDOiCvamInJYmkTSNbTlYn4NrmmBm5jtpdwyQsdbyCtf2hbEYJ
 eK5K6vBTMebnzLorjfpec1hMnz5xTdCRGH0TzU7fz/I6/yLMBr8/wy7ho36NRyboPAaCj10SAE
 nURkyPeA9D5G8f01847GfPqiSeGF54d1RKqDf3YekFs73Sa1PdPIk5jQ9+c20zSUT3RPf+Q5w6
 Z7I=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:15 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 32/40] btrfs: implement cloning for ZONED device-replace
Date:   Tue, 22 Dec 2020 12:49:25 +0900
Message-Id: <25d52cf3e1e1fcc53625d1a6d925dfa46aedc547.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
index d2b86aa1fc72..f1cc8a421580 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5987,9 +5987,29 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
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
@@ -6002,6 +6022,15 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
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
@@ -6397,8 +6426,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 01f84b4c4224..7fc8c68f2981 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -11,6 +11,7 @@
 #include "disk-io.h"
 #include "block-group.h"
 #include "transaction.h"
+#include "dev-replace.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1004,6 +1005,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
+		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+		int dev_replace_is_ongoing = 0;
 
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
@@ -1030,6 +1033,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
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

