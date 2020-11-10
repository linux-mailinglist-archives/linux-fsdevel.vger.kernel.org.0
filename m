Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE82AD4EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgKJL2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11946 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgKJL2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007693; x=1636543693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EUE4mP/cNLBVW+C7fZHuHGi7rGC9yLUMBgyp+vYU9n4=;
  b=lrc3c2SGq2J1jS++rDshyBkUPjPDJI2T+ZzSRaVS0xJBFhnsThIfb/V6
   ZsFVH7UlVEX5Cmso9Y1uJgG8u0si5pK4J6UjxzMIP5INJeHHkV2ZXYXuq
   dIaMq+eztadfC9VEu1fWhNAg8/mYZh7QCdyBNKVbXkmTIj8kf5QO0jDZ2
   OQ/mczfhA2UqoUYkU2fU6sM0kxxqOLwgPwFr6JoUghU2pQmCX5gPnCrsj
   dr1x9tytv9Do8WhDLLjfAkJLeXVPMN+vhUi+YJhFHyZ19N1MGD87wB+/w
   gQdyJ3fpK+vIR/MEse4F8j18mHlqNX+RmA7NqCin0ncjH78Nqt1lWeoXs
   Q==;
IronPort-SDR: RhopRcQ1Sp2NHa0Wdn2fY/n/4CSDzYTF6dcryj1JHov+37mXa6/WUNWOAd8hgTBrV6qkZ6MwnZ
 WRGW/8R/DYcK9j2PiWtNfWpqw7qJueIwYQ923RjIlwsMofjfN0TF8hlVT3qRMGWYtj4fGpuvkQ
 LdsUwXjiTlSBT9OLIfKrPRFqFRkpovry0ZDU+hUb/To2MKGtI7qNhebbXpIfL8GEAUJkXQE9k5
 3/YinLJovUQGuI97I5W8vWiB4MCShm/NIo471iWY+/dVxTHmfYwwCmHSXRMKJ2qedConBiFTEq
 /cE=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376417"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:12 +0800
IronPort-SDR: BO4+psgAL28WnefEmOd9asBEATWMtUH6CLkx+OfPmY6+kW9CEo/GO/PrcKda8B5C5H8dMla3x5
 mhfcQuXPwR/HxeVce9wBNizuiBP2+Xgzk+Qsu40qN1TB8zG7L4j0STc0wrRKavB6m+/ykRTsgD
 z/9X1GgE1ErX3yabhAC9iulN9Y01C0Op+LUHmb804p8qvrLSTbgp4ldRsqC+hSAjB+UmzPqGlE
 ecwlDUDI7QNM8kWxQ9Kvty6X3JOO1pWc23E0wtn8emWcv3ICDAQBqAUowJLQptMDm1l6mCx3cx
 cy89U421fy7P4S2x+nEc3IH8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:13 -0800
IronPort-SDR: IYDyPkeoUEgIChjiqGpOUP7XriyRE6R2vxhpeD5nrn9FRfyXNIZkJFXrjx5qIGCo+zGUdKlv15
 1HXzhdFr6rFXzxPrRcv9OEV3df0zwX6CFMd9lem19LVxoHf09kaFe3mAQi7ntTalztBqJyFXiz
 tpCPQK0fj5Z7Pl21AbeNEZR1OH0+ohzawajdUU/688NU9pe/uBOoi+jGasSqt3m5jXjoNaB9vb
 kLKHNmP0Pj6gKw9QBXXyB8xFP4UsNZajdWiXw4w3orcT7umvF9U6k/NvCa7tXOsmXN+dCV63LN
 mdw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:11 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 05/41] btrfs: check and enable ZONED mode
Date:   Tue, 10 Nov 2020 20:26:08 +0900
Message-Id: <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit introduces the function btrfs_check_zoned_mode() to check if
ZONED flag is enabled on the file system and if the file system consists of
zoned devices with equal zone size.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 11 ++++++
 fs/btrfs/dev-replace.c |  7 ++++
 fs/btrfs/disk-io.c     | 11 ++++++
 fs/btrfs/super.c       |  1 +
 fs/btrfs/volumes.c     |  5 +++
 fs/btrfs/zoned.c       | 81 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       | 26 ++++++++++++++
 7 files changed, 142 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aac3d6f4e35b..453f41ca024e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -948,6 +948,12 @@ struct btrfs_fs_info {
 	/* Type of exclusive operation running */
 	unsigned long exclusive_operation;
 
+	/* Zone size when in ZONED mode */
+	union {
+		u64 zone_size;
+		u64 zoned;
+	};
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
@@ -3595,4 +3601,9 @@ static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
 }
 #endif
 
+static inline bool btrfs_is_zoned(struct btrfs_fs_info *fs_info)
+{
+	return fs_info->zoned != 0;
+}
+
 #endif
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 6f6d77224c2b..db87f1aa604b 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return PTR_ERR(bdev);
 	}
 
+	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
+		btrfs_err(fs_info,
+			  "dev-replace: zoned type of target device mismatch with filesystem");
+		ret = -EINVAL;
+		goto error;
+	}
+
 	sync_blockdev(bdev);
 
 	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 764001609a15..e76ac4da208d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -42,6 +42,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "space-info.h"
+#include "zoned.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -2976,6 +2977,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 		btrfs_info(fs_info, "has skinny extents");
 
+	fs_info->zoned = features & BTRFS_FEATURE_INCOMPAT_ZONED;
+
 	/*
 	 * flag our filesystem as having big metadata blocks if
 	 * they are bigger than the page size
@@ -3130,7 +3133,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	btrfs_free_extra_devids(fs_devices, 1);
 
+	ret = btrfs_check_zoned_mode(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to inititialize zoned mode: %d",
+			  ret);
+		goto fail_block_groups;
+	}
+
 	ret = btrfs_sysfs_add_fsid(fs_devices);
+
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
 				ret);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ed55014fd1bd..3312fe08168f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -44,6 +44,7 @@
 #include "backref.h"
 #include "space-info.h"
 #include "sysfs.h"
+#include "zoned.h"
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 #include "discard.h"
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e787bf89f761..10827892c086 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2518,6 +2518,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
+	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	if (fs_devices->seeding) {
 		seeding_dev = 1;
 		down_write(&sb->s_umount);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b7ffe6670d3a..1223d5b0e411 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -180,3 +180,84 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 
 	return 0;
 }
+
+int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 zoned_devices = 0;
+	u64 nr_devices = 0;
+	u64 zone_size = 0;
+	const bool incompat_zoned = btrfs_is_zoned(fs_info);
+	int ret = 0;
+
+	/* Count zoned devices */
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		enum blk_zoned_model model;
+
+		if (!device->bdev)
+			continue;
+
+		model = bdev_zoned_model(device->bdev);
+		if (model == BLK_ZONED_HM ||
+		    (model == BLK_ZONED_HA && incompat_zoned)) {
+			zoned_devices++;
+			if (!zone_size) {
+				zone_size = device->zone_info->zone_size;
+			} else if (device->zone_info->zone_size != zone_size) {
+				btrfs_err(fs_info,
+					  "zoned: unequal block device zone sizes: have %llu found %llu",
+					  device->zone_info->zone_size,
+					  zone_size);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+		nr_devices++;
+	}
+
+	if (!zoned_devices && !incompat_zoned)
+		goto out;
+
+	if (!zoned_devices && incompat_zoned) {
+		/* No zoned block device found on ZONED FS */
+		btrfs_err(fs_info,
+			  "zoned: no zoned devices found on a zoned filesystem");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (zoned_devices && !incompat_zoned) {
+		btrfs_err(fs_info,
+			  "zoned: mode not enabled but zoned device found");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (zoned_devices != nr_devices) {
+		btrfs_err(fs_info,
+			  "zoned: cannot mix zoned and regular devices");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in
+	 * __btrfs_alloc_chunk(). Since we want stripe_len == zone_size,
+	 * check the alignment here.
+	 */
+	if (!IS_ALIGNED(zone_size, BTRFS_STRIPE_LEN)) {
+		btrfs_err(fs_info,
+			  "zoned: zone size not aligned to stripe %u",
+			  BTRFS_STRIPE_LEN);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fs_info->zone_size = zone_size;
+
+	btrfs_info(fs_info, "zoned mode enabled with zone size %llu",
+		   fs_info->zone_size);
+out:
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index c9e69ff87ab9..bcb1cb99a4f3 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -4,6 +4,7 @@
 #define BTRFS_ZONED_H
 
 #include <linux/types.h>
+#include <linux/blkdev.h>
 
 struct btrfs_zoned_device_info {
 	/*
@@ -22,6 +23,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
+int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -36,6 +38,15 @@ static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
 
 static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }
 
+static inline int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	btrfs_err(fs_info, "Zoned block devices support is not enabled");
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -88,4 +99,19 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device,
 	btrfs_dev_set_empty_zone_bit(device, pos, false);
 }
 
+static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
+						struct block_device *bdev)
+{
+	u64 zone_size;
+
+	if (btrfs_is_zoned(fs_info)) {
+		zone_size = (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;
+		/* Do not allow non-zoned device */
+		return bdev_is_zoned(bdev) && fs_info->zone_size == zone_size;
+	}
+
+	/* Do not allow Host Manged zoned device */
+	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
+}
+
 #endif
-- 
2.27.0

