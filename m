Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF3B2A0707
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgJ3NxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:21 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21997 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgJ3NxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065987; x=1635601987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4AHs2QfXc+eeEQ2D+AK5M3qcbb+ElujE0f5Ey0Ppn2U=;
  b=ErxUOFdyZFVNa/GH+etmTtRZRJ95UKq8AS7y8sBEb71xjFWo4KbddiXb
   AhVDVv3BGqUQ9bjKMD9WP+2zhA/Jiqb3FmddMgjhgzo9rTt37TgBhEFfL
   ItNPbF/8iVwZscilKR+1/ip5yQnnaZ6e/s9XL2fS3zJLZQTMSWnuDyYon
   NcvgMM55sQHhpqcio1GHsn9qAnqkzHq8OiQEyZmCi2/8VvespX3SiQ8xL
   VRCIuRI4nYzZaxuhjnxaAFMxzbrpTnOfbPvTnraGwdtPyg7yTfbV5ZtSX
   HB+wcf/wIaBz7BSMsxjW+P1AT0qldcu1hgM1J6eAyitrn6pXucqR2Ueyr
   g==;
IronPort-SDR: SgeBzL5bb7HO3aHFsc74jvMufCpdefG1T63eVYiiknyQKpk4pTQKVg9E71HwaFpIlSaoBi+ix9
 AE8RYrjOuvi7XnpLK1jFiv4VbrvoH8Hwd9xc/d3EQzIlfnBBrkL7iuQSZfkrZgfIuFsB3DhU92
 c4i9htcnlQtKB9Hq2skow2jbsPaA4JOXurVHmE8UTGipR7i3bqg0RIHTm9majLfYB6c3d+0+Ey
 KMVBgmZfCiZ6d5oWz9nbXxxdL24iG9QiMFj99LenHhHglnwB5sk0cbEgnIgE3mp80LBdHFmWOF
 qyo=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806637"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:53:00 +0800
IronPort-SDR: c4UUGhBzsQLFGor5Tn2SfUb7GLmftSd1RTzxR3gciJsNVRswhVODbMPoMerLubM0IqcG+Uz7dD
 lIOUsGmcbcIpFmO24G7LW2r4sd8f5ubCG6yPygFiveBSbfm+mJxoU2ButETEm1HYBTY7xPEMGe
 bbLao1JCMSB1wYuwFQ/QGloowCVul7sOR6q/hbToHUPiZoCE4O9r04fegr+M0Rz2Cis96XEVo3
 0iJ3y9FpxxzNJZ04+Xv7IQQS1abNCYrCuMTilIMThwz1gnQqVEJJtYVJg791jcRPJZ6AJwECDa
 l7mK4F9L4v6MAvFPe1YZ/sq2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:14 -0700
IronPort-SDR: g5BmCTtPdq3rp+Kx4tOdBWPhUA4MUZh4FRMDLoAPcq3Jz1dmgleEAnhW2y68gm0ctGClInVrIs
 xilb8r22PZu/06qw7NZUYKxqsoE8ARsKma+ZV0nNEuAuOMbGVQMgTvvtJOrvpnmxcPskuxdBTx
 xDHP9BdqzLHGLxOya5TkvMSG1cK4l5gKGpwAorTEq/pfGJp0hPt0ToIlTemvxOou5ynMigkaLJ
 zzVilUy+sQ9CoQqsYe5q05lrFA2a4ppjn6wFQXGxmmnMALlUND0vY/88Cx2k3STdvKjkJv53d8
 GyA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:59 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 32/41] btrfs: implement cloning for ZONED device-replace
Date:   Fri, 30 Oct 2020 22:51:39 +0900
Message-Id: <a65d400de20403db088a8093073735cd1f783e22.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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
 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/volumes.c     | 33 +++++++++++++++++++++++++++++++--
 fs/btrfs/zoned.c       | 11 +++++++++++
 5 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index e86aff38aea4..848f8063dc1c 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -454,7 +454,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	u64 chunk_offset, length;
 
 	/* Do not use "to_copy" on non-ZONED for now */
-	if (!btrfs_fs_incompat(fs_info, ZONED))
+	if (!btrfs_is_zoned(fs_info))
 		return 0;
 
 	mutex_lock(&fs_info->chunk_mutex);
@@ -565,7 +565,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 	int i;
 
 	/* Do not use "to_copy" on non-ZONED for now */
-	if (!btrfs_fs_incompat(fs_info, ZONED))
+	if (!btrfs_is_zoned(fs_info))
 		return true;
 
 	spin_lock(&cache->lock);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 57454ef4c91e..1bb95d5aaed2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -35,6 +35,7 @@
 #include "discard.h"
 #include "rcu-string.h"
 #include "zoned.h"
+#include "dev-replace.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1336,6 +1337,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
+			struct btrfs_dev_replace *dev_replace =
+				&fs_info->dev_replace;
 
 			if (!stripe->dev->bdev) {
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
@@ -1344,15 +1347,28 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 			req_q = bdev_get_queue(stripe->dev->bdev);
 			/* zone reset in ZONED mode */
-			if (btrfs_can_zone_reset(dev, physical, length))
+			if (btrfs_can_zone_reset(dev, physical, length)) {
 				ret = btrfs_reset_device_zone(dev, physical,
 							      length, &bytes);
-			else if (blk_queue_discard(req_q))
+				if (ret)
+					goto next;
+				if (!btrfs_dev_replace_is_ongoing(
+					    dev_replace) ||
+				    dev != dev_replace->srcdev)
+					goto next;
+
+				discarded_bytes += bytes;
+				/* send to replace target as well */
+				ret = btrfs_reset_device_zone(
+					dev_replace->tgtdev,
+					physical, length, &bytes);
+			} else if (blk_queue_discard(req_q))
 				ret = btrfs_issue_discard(dev->bdev, physical,
 							  length, &bytes);
 			else
 				continue;
 
+next:
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
index 26669007d367..920292d0fca7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5964,9 +5964,29 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
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
@@ -5979,6 +5999,15 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
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
@@ -6374,8 +6403,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 15bc7d451348..f672465d1bb1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -11,6 +11,7 @@
 #include "disk-io.h"
 #include "block-group.h"
 #include "transaction.h"
+#include "dev-replace.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -890,6 +891,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
+		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+		int dev_replace_is_ongoing = 0;
 
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
@@ -916,6 +919,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
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

