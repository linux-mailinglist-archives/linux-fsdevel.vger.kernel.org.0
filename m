Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662402AD51C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbgKJL3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:38 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12030 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731969AbgKJL3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007752; x=1636543752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KFDG1OUyV9i/8yQHJIgy0JjLAUweQbuTxjRzb4n2poM=;
  b=j4dG2VukK4GG2R6vFwCtLKpA/nF4jfFt5F0Pw9wTdiqoiS5IIzH+9fMH
   14hcTnbrYFYnlJY6RoteXgHs/ai6m6+AKr0MINi+WEd8HuKhYa95qeYAD
   X+jpSaq9HmomIAfte3DBHFr525Nn/stl5Agm5I5v2sF+ECMBAgW4rURaW
   Pb0aMPgOmSjvERSCQTw0mDXZ5FtrupLV0agVqa3uxTP8F7g+ONiJ0g3AE
   UJagsmAVWbo4dYKSyAtZs7gmeKf7ZnoEwM6dwe0NeUG0bKlvG2AAj2zdg
   4U2ohTthB1w0AjH619ybTPnlD2pE4iGK3eT4re+1F57t6pwlZbd7Qh0gq
   w==;
IronPort-SDR: 2BO8ICZgp10ixN3NkLKkjUoxo5g1BUzHKErHqP5clxLfO/oKSbLOMJ98UoQmprQydV8geG30DI
 y2AJcJWxhwOwv2lH+/uk3FAFG6fp/TW55g3Eey5YT50NG1JZiUXBzwbLRCmJ8QobJbNFaPhY/G
 nesVoJyZWb9r0Xl3xKcLzyWJxRGbgMJG/h1boWgNVQhfjJIRTNhnWBDIE8smGJXA5oaEFOWYT3
 QbEcBFXpuvJAGvhshRO/S29oCLQoMi2AKymdbf6hYA/86qgXdGdrXKPjfZXG9Ce8dB83QH9Ks2
 AkA=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376661"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:57 +0800
IronPort-SDR: uOtf2OHI6gLdf+KYqAc5xss9dlLqFjAYRtcwDw/r0v18oltLCUmRU7pgcknIpmwLMIGwH4N/pJ
 fOSf7HcCha4FCIqOvq1P54k87rANDQsbegKRiehv5JBEDRF5xawDhSn4Dn2pwcVcV4hDyGEw/y
 VrW+Ru0RvB6+/gZqMpubWyc0PwgH9rv3qq+7ZZ9PAXrHQDRvK1mg9kU9KfVWo6K8H94Hdy35Wf
 g8CkfaDDEX5wWslhrNs7klJ7qy37xzNIZL5tQIYGlwxB0AO6g9GXeKTriUOcl5ydX0VMK575OR
 LdUiKDkyAq80tzVRn5eSwEC3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:58 -0800
IronPort-SDR: HthKYk3hKc2uaUqDB3QWtXV6rbou05ZT3CuFqfGRac8/vsc5xT+Lz0YxHfboOJDPgyIjos9dz0
 /vCvdHmrhC4lHNPsmrUuwItHa/8o2CcB8ZPW2BQxTg2pD0001fRDKUqywFfnsqAjlbaHioastV
 SBz5X3e0nWPwmEmXX6KiyGvuN7v6s2ja6usKWqyVWS+DxXF55jTR+AlZJUiK1zYBbTvS6S4hV3
 AYHiXdUblb73IGHwfGW71IhcbZQ9CsWCpMeu8tgw2+iAHIJWTqyhcJgYBS+su7Gp0gI5fhKWQM
 wWE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:56 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 32/41] btrfs: implement cloning for ZONED device-replace
Date:   Tue, 10 Nov 2020 20:26:35 +0900
Message-Id: <da5a7fb6227afcfc404570573d78054db84ce100.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/volumes.c     | 33 ++++++++++++++++++++++--
 fs/btrfs/zoned.c       | 11 ++++++++
 4 files changed, 85 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 99640dacf8e6..2ee21076b641 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -35,6 +35,7 @@
 #include "discard.h"
 #include "rcu-string.h"
 #include "zoned.h"
+#include "dev-replace.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1298,6 +1299,46 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
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
@@ -1331,28 +1372,14 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
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
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d0d7db3c8b0b..371bb6437cab 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3501,7 +3501,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			goto skip;
 
 
-		if (sctx->is_dev_replace && btrfs_fs_incompat(fs_info, ZONED)) {
+		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
 			spin_lock(&cache->lock);
 			if (!cache->to_copy) {
 				spin_unlock(&cache->lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c8187d704c89..434fc6f758cc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5969,9 +5969,29 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
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
@@ -5984,6 +6004,15 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
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
@@ -6379,8 +6408,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d345c07f5fdf..8bf5df03ceb8 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -11,6 +11,7 @@
 #include "disk-io.h"
 #include "block-group.h"
 #include "transaction.h"
+#include "dev-replace.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -891,6 +892,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
+		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+		int dev_replace_is_ongoing = 0;
 
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
@@ -917,6 +920,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
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

