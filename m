Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD652AD538
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbgKJLaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:30:23 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11943 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgKJL2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007694; x=1636543694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rJSa0nQ/eAUC9/dwO481wrXWUnETIiwkx7A2/nLOMmI=;
  b=DViLR0PkwaHELikkfM7vy75S/55eySENvcfsoERls6ZOXeUBSM2wI3Pw
   IMfSZz0sVCHSGyp9h0hCF7BZtI582MkSKlUAPZRoSyAzvHwlbGiEboc6t
   287AJ9jxrkCCc6FUZyakqpTSN4/Ord79s5iP8ifXKmfriW4WjQurM4GDz
   bkX+yxHe3oQIMz9R8qESpSpXPb9iFkTB+cc+7k8tVtgaxTIa+nRa76Ibh
   UQ1FybnZqLGKFfT769t/fU4VujF+86BJaXaojRbUV03Gt70rPbZ9pdg8i
   aBXklMverpt1TGnn4RYDQ6g/38UIa482wl7TWsgzzD18EG3rb2ab78fCH
   A==;
IronPort-SDR: 31pXfEFCMlUgat5ezLwZLhygCjn92S3KLnQAiXw4am/raLILZfdCoxceRSnPHnzwdknNmNh3fj
 x777IIxQjmFLYtGAvNZUzqHBaDmlOtZYljHLiFZgbqyuvlb7t5lE6Hgv0y6/Ru0Pluw9ljfUlN
 HbwzdXPJVn0azgYnNJ+kamohKltT1KgXBnXgvz6+HdLCfZ9DCKgqqXQnYwRIZM2MXLkv3fFLs9
 v5KvyxBWdBXuWANgiGDmxhSSfXzLqvu/t8L+bhPxegyrdAXYelTerAAtvcU2FRcVZarjUclLwS
 ljs=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376419"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:14 +0800
IronPort-SDR: NSChn9v+YFnUuB9iwUAsYK0EakV9UzBrgkQuBOn0N8ftUKFqaIWolVQdWVMXyiq0CJozk0rrNF
 wBNkjRu6jPah5fsn5owPPfiUwAuYiB0CjY7f3jQdWVHXoOMbuDwL9wsr3H8Zk6QFbF0iMQ8SJ2
 k5ZQ7p0iLNKBpQasYbkKYYQNLYB1gWXpvDze2fWHVBm6+2uy4VxNCaUkbAI8w9Y/o2bKSyBl6C
 fsvA4YH0bjIlspemZaW+4DvNFDU7PLVS3a/TZ9eEZQElxwG7LFyJ0HoR1dBmGbdXMnccRHXNfX
 ZIyBJSnMtNpdrqHfAMIMv0+l
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:15 -0800
IronPort-SDR: tn+WBtw5tj4Ec9fJzoAKpH2lt4z+ej16y6vjauHvz8PAxxpjPKkpoEdNqIxuSxg/9acLurJk2b
 xm3fPA/T9ZR9xrkrbDUxnF1+8m5teNcakzcnXfVK/FIdnGSfFlMR2klZm9TZ7exJ1rHomH6jgr
 /pwRxW1dBeS4puGVV1RDaitaCbTMFlUlI4V8Ts1anTHl2M9mRVVZ/M6hme1l2zWDyOzyxqAqrQ
 +0ubzrYcXoDpz2/EGTWLhC4/JTwzNZzfxIkGjueCZjRbD//ygznZhkeAPYYa3E6eCNQjeoOaS2
 RpA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:13 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 06/41] btrfs: introduce max_zone_append_size
Date:   Tue, 10 Nov 2020 20:26:09 +0900
Message-Id: <173cd5def63acdf094a3b83ce129696c26fd3a3c.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The zone append write command has a maximum IO size restriction it
accepts. This is because a zone append write command cannot be split, as
we ask the device to place the data into a specific target zone and the
device responds with the actual written location of the data.

Introduce max_zone_append_size to zone_info and fs_info to track the
value, so we can limit all I/O to a zoned block device that we want to
write using the zone append command to the device's limits.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h |  3 +++
 fs/btrfs/zoned.c | 17 +++++++++++++++--
 fs/btrfs/zoned.h |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 453f41ca024e..c70d3fcc62c2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -954,6 +954,9 @@ struct btrfs_fs_info {
 		u64 zoned;
 	};
 
+	/* Max size to emit ZONE_APPEND write command */
+	u64 max_zone_append_size;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1223d5b0e411..2897432eb43c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -48,6 +48,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
 	struct btrfs_zoned_device_info *zone_info = NULL;
 	struct block_device *bdev = device->bdev;
+	struct request_queue *queue = bdev_get_queue(bdev);
 	sector_t nr_sectors = bdev->bd_part->nr_sects;
 	sector_t sector = 0;
 	struct blk_zone *zones = NULL;
@@ -69,6 +70,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	ASSERT(is_power_of_2(zone_sectors));
 	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
+	zone_info->max_zone_append_size =
+		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;
 	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
@@ -188,6 +191,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 zoned_devices = 0;
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
+	u64 max_zone_append_size = 0;
 	const bool incompat_zoned = btrfs_is_zoned(fs_info);
 	int ret = 0;
 
@@ -201,10 +205,13 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		model = bdev_zoned_model(device->bdev);
 		if (model == BLK_ZONED_HM ||
 		    (model == BLK_ZONED_HA && incompat_zoned)) {
+			struct btrfs_zoned_device_info *zone_info =
+				device->zone_info;
+
 			zoned_devices++;
 			if (!zone_size) {
-				zone_size = device->zone_info->zone_size;
-			} else if (device->zone_info->zone_size != zone_size) {
+				zone_size = zone_info->zone_size;
+			} else if (zone_info->zone_size != zone_size) {
 				btrfs_err(fs_info,
 					  "zoned: unequal block device zone sizes: have %llu found %llu",
 					  device->zone_info->zone_size,
@@ -212,6 +219,11 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 				ret = -EINVAL;
 				goto out;
 			}
+			if (!max_zone_append_size ||
+			    (zone_info->max_zone_append_size &&
+			     zone_info->max_zone_append_size < max_zone_append_size))
+				max_zone_append_size =
+					zone_info->max_zone_append_size;
 		}
 		nr_devices++;
 	}
@@ -255,6 +267,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
+	fs_info->max_zone_append_size = max_zone_append_size;
 
 	btrfs_info(fs_info, "zoned mode enabled with zone size %llu",
 		   fs_info->zone_size);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index bcb1cb99a4f3..52aa6af5d8dc 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -13,6 +13,7 @@ struct btrfs_zoned_device_info {
 	 */
 	u64 zone_size;
 	u8  zone_size_shift;
+	u64 max_zone_append_size;
 	u32 nr_zones;
 	unsigned long *seq_zones;
 	unsigned long *empty_zones;
-- 
2.27.0

