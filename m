Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE630F0DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhBDKbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:31:22 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54276 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbhBDKaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434600; x=1643970600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=imiE5g7Lug2NvEDzj3o+lgjEqhIrDDS4EjlBgVWz1UA=;
  b=NLn5BW28u6y5VmanXC4WnREZ4UbcVgYND1b+3dUL0LM3+O8vtA60QDBV
   cyvedmxUP6/qqU6wfsz3IBkH5DXEZjroaxF0tG86UJqdfA+jF1HdokpIg
   Y4kKdWkhF3G4Jg4rpOaAfdOjvlVLQHc+Bt0wsDr6cqWWb0ubt6L/oKMaq
   4blDJbir2HRGgZ91SY6PiwJHUBtyA2TLOASLxamxCVHeINljt1UPe91bx
   afurW/cIeMHEXCPpeAohO2U2EpyKjrF77xuU9ge4AH87aCX/fzkVBylU9
   DPPTOM53DQ6rKu+12PfgJKms0hYdb7zLvDdSSZ46fUe0Z6fcqaCvoiT0v
   w==;
IronPort-SDR: msmxWjMpJj6No7S+WaeWDCzYLYTavzVQN5yGl+Rg+JVFgiVg+j6MrmJE7+djPotDzg13o07qYp
 r16SZ2MSRoexczso6Whh0zSLn4N9NgSIkW+i611TSm1cW7VNfmvasIM/0f28Hp4dNjkhSptBZX
 y1fzEqCYkQ23AtCJ/Tf1MXSZQYxp0hB9dv63iiqxzLcC/oyuPE7z1HgX+EfXviBmJ8pw92dzQg
 SxMohO6DghmrNlhjCM+g7jyJ4kTK371KjaitD5aGts4bX1EKCtyd98XT+rT8hL08fKx7nk6do8
 edI=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108055"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:41 +0800
IronPort-SDR: kSQ7EAeeh2V7QD/Ay/hKoZcVZkuPL7B8WwvJCMfhqX9tnEXED94R8pjW8xMiZLTphdU1wrvq4v
 YGxvziqsG+tWC27xILnLElUw4M90jNgqSLJ5lNxAtXxkv2cBURtpW9W5/88ntSTxEd6ZwFYWg8
 EAnK8fEGLQD9D0PG+1Jlu5lvzQnHuLU+eidP6eOOF2rfspiGNrzLsxzWFp/973dQMPdNw/meA3
 CrxfCCvTkm3KXrohsgAav+tJ7YkuQ5S1NYCudhvPlRJYva8QIHrrM332EVYaXJiCYvXNIB9KxH
 h0kFR5E+mHQFC5qUpFfimNQ9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:44 -0800
IronPort-SDR: sYeoEDIm68llx+Sj+ppjC5QzkMD/t3lUY7QeMtfUPcGiqHnmeWF53zMgm7XWLjYsnNJQCPo1ui
 XbMULy05Bjpbo0J8rEUQU3Hf5YenI2nhVjRQSBXNevFss2qdUZo506/I009AwVYHfwwpkttU9N
 sNp+cq29K/0sJPXX303QvEgZj0VrjslmoZL3an0h6KwCB1WWkk12vBZc7PhBkrqRrsXPz1XxPM
 yufPIxztB1RCncIIoIGSVZqn/MstwT75+GcpaJM9SJjKGkWLyvT4dLuNIIw5qUKnJRKsqkzY/u
 j5I=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:40 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 33/42] btrfs: zoned: implement cloning for zoned device-replace
Date:   Thu,  4 Feb 2021 19:22:12 +0900
Message-Id: <867cd9b7da207fa0be039e5e80502843cf3388dc.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is 2/4 patch to implement device-replace for zoned filesystems.

In zoned mode, a block group must be either copied (from the source device
to the destination device) or cloned (to the both device).

This commit implements the cloning part. If a block group targeted by an IO
is marked to copy, we should not clone the IO to the destination device,
because the block group is eventually copied by the replace process.

This commit also handles cloning of device reset.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 57 +++++++++++++++++++++++++++++++-----------
 fs/btrfs/volumes.c     | 31 +++++++++++++++++++++--
 fs/btrfs/zoned.c       |  9 +++++++
 3 files changed, 80 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a717366c9823..e2b2abc42295 100644
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
+	/* Zone reset on a zoned filesystem */
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
+		/* Send to replace target as well */
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
-			/* Zone reset on zoned filesystems */
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
index a4d47c6050f7..52ec6721ada2 100644
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
+	/* Non-ZONED mode does not use "to_copy" flag */
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
@@ -5988,6 +6008,13 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	if (op == BTRFS_MAP_WRITE) {
 		int index_where_to_add;
 
+		/*
+		 * A block group which have "to_copy" set will eventually
+		 * copied by dev-replace process. We can avoid cloning IO here.
+		 */
+		if (is_block_group_to_copy(dev_replace->srcdev->fs_info, logical))
+			return;
+
 		/*
 		 * duplicate the write operations while the dev replace
 		 * procedure is running. Since the copying of the old disk to
@@ -6376,8 +6403,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2803a3e5d022..72d9c8ba98a3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -11,6 +11,7 @@
 #include "disk-io.h"
 #include "block-group.h"
 #include "transaction.h"
+#include "dev-replace.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1036,6 +1037,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
+		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+		int dev_replace_is_ongoing = 0;
 
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
@@ -1062,6 +1065,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 */
 		btrfs_dev_clear_zone_empty(device, physical);
 
+		down_read(&dev_replace->rwsem);
+		dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
+		if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
+			btrfs_dev_clear_zone_empty(dev_replace->tgtdev, physical);
+		up_read(&dev_replace->rwsem);
+
 		/*
 		 * The group is mapped to a sequential zone. Get the zone write
 		 * pointer to determine the allocation offset within the zone.
-- 
2.30.0

