Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7CC85E50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbfHHJbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59627 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbfHHJbR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256676; x=1596792676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WG/9WLMgzFHO2fyfnPBieI1csnC0YJkjkIVhiXcCbNI=;
  b=BF7yuMu/359cAP9uC9OuwqV32/N6H+yNkkqfTZ9prTNiZN/4Ep4VpB5/
   Ttb0YswkvnlpYOeDr4e0hvXo/6CMLiqCtUHOM1aDg1B6OsLPw0kih9Jhk
   Gg28GlVmnuYPt26DM5vfdz6GY9b1RLKOocLlPvUbZQ5roNevJcKrYlZHH
   MRlZMklxbpeiA7PK8cuSA8UiXaQD9FdTS99cBt4KSwf2PdQsWCEAjHd/M
   XlfrK49LgwKLDwTl4fMy279exdgNyUgIzRbWzB5DO7wCBuYE8CubiOOKa
   i1mbv8p54UQOe995d1T55AMxkd7svYfqwqAfn0ps54FxSAc2TP7i3Be8a
   A==;
IronPort-SDR: bZ91BNb3RoKY6EjOd+nTFRogYgMDzQULkqhfuKfYIyZnVLEnKHuMmEVLEmsYqiXVJrBTB7DMJU
 9ex4mz2N3uaowLyeoiRE8FTpovKbtJygaXdZT8rRJ5ND5+c25sR+GVS9kIdEskGrQ3qHi8aBp4
 Qf7DV2YU9nT9if9XSaBlmy2XVhKb9+uPdavnlJ0sffp+A5tmKinCoNFdC0U4s3lmeA+FtiHqHU
 Qv7mPbmMu3vPxnyCe4BMJsrpZuWO1mlqfKPSgDk0rEs0Gx8YaeleV65p6OXWyr4wyJuBnWIdli
 w4A=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363294"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:16 +0800
IronPort-SDR: W2FSJXYpqL/vmIdvLoM9J7DFN1Dk/c0R0SRFpHoQkxjDQxJ7aVNwHK5qmZSYg0djDkhgBcjJZB
 X5dXrsfx36W188diY4HzklHgs2aJOvVex8yo5Y95n/rqEYl2rLsKKdwNIdVXUsxFTHMbRpduyp
 8btXk7izLsAKL+Ymp4gKPmHRmElH+FC5y2cALWM06XqiZ9EpsabtJVqayYqvL97JbdzXX5ztNr
 7Vj9FpxuPVDcdZBDpOOfwNQBTfKbXKRIfVvA2+NNoPPXNvbiDXDuZL1tWXogcgJyxjPaCEeBZs
 kEPHjYJHJ9F+SmLwExI25bz7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:00 -0700
IronPort-SDR: zIwsiSxGtbSsr5+L4sjFGAmkD1DIJnEyj7eCTteHEDt5rrIb+Je6fCw4f6Bn93I8z8pPKvlpPE
 IEpKex5DQYIQxfrTIjEp/gFlhcfMhmGEjN+5BkocLs+R4UHtwO40JlE71cQQlZ1evwQ6llwbMn
 FBA+eWwo6LBYbITR5WOZzytXynxzJgf1zw/4ZEmOzIJ1NXRtQ/GX2imMqxxrp1HMmniDHrEwgQ
 7o80tSD2jXzm5dHvRmZSt/P7sA3eLzfIDCX8sM9M1K8osWKODdz1lncAo0Zw7j44o6DtuNTOKr
 uzo=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:15 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 02/27] btrfs: Get zone information of zoned block devices
Date:   Thu,  8 Aug 2019 18:30:13 +0900
Message-Id: <20190808093038.4163421-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a zoned block device is found, get its zone information (number of zones
and zone size) using the new helper function btrfs_get_dev_zonetypes().  To
avoid costly run-time zone report commands to test the device zones type
during block allocation, attach the seq_zones bitmap to the device
structure to indicate if a zone is sequential or accept random writes. Also
it attaches the empty_zones bitmap to indicate if a zone is empty or not.

This patch also introduces the helper function btrfs_dev_is_sequential() to
test if the zone storing a block is a sequential write required zone and
btrfs_dev_is_empty_zone() to test if the zone is a empty zone.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/Makefile  |   2 +-
 fs/btrfs/hmzoned.c | 162 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h |  79 ++++++++++++++++++++++
 fs/btrfs/volumes.c |  18 ++++-
 fs/btrfs/volumes.h |   4 ++
 5 files changed, 262 insertions(+), 3 deletions(-)
 create mode 100644 fs/btrfs/hmzoned.c
 create mode 100644 fs/btrfs/hmzoned.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 76a843198bcb..8d93abb31074 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -11,7 +11,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
-	   block-rsv.o delalloc-space.o
+	   block-rsv.o delalloc-space.o hmzoned.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
new file mode 100644
index 000000000000..bfd04792dd62
--- /dev/null
+++ b/fs/btrfs/hmzoned.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ * Authors:
+ *	Naohiro Aota	<naohiro.aota@wdc.com>
+ *	Damien Le Moal	<damien.lemoal@wdc.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/blkdev.h>
+#include "ctree.h"
+#include "volumes.h"
+#include "hmzoned.h"
+#include "rcu-string.h"
+
+/* Maximum number of zones to report per blkdev_report_zones() call */
+#define BTRFS_REPORT_NR_ZONES   4096
+
+static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
+			       struct blk_zone **zones_ret,
+			       unsigned int *nr_zones, gfp_t gfp_mask)
+{
+	struct blk_zone *zones = *zones_ret;
+	int ret;
+
+	if (!zones) {
+		zones = kcalloc(*nr_zones, sizeof(struct blk_zone), GFP_KERNEL);
+		if (!zones)
+			return -ENOMEM;
+	}
+
+	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT,
+				  zones, nr_zones, gfp_mask);
+	if (ret != 0) {
+		btrfs_err_in_rcu(device->fs_info,
+				 "get zone at %llu on %s failed %d", pos,
+				 rcu_str_deref(device->name), ret);
+		return ret;
+	}
+	if (!*nr_zones)
+		return -EIO;
+
+	*zones_ret = zones;
+
+	return 0;
+}
+
+int btrfs_get_dev_zone_info(struct btrfs_device *device)
+{
+	struct btrfs_zoned_device_info *zone_info = NULL;
+	struct block_device *bdev = device->bdev;
+	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	sector_t sector = 0;
+	struct blk_zone *zones = NULL;
+	unsigned int i, nreported = 0, nr_zones;
+	unsigned int zone_sectors;
+	int ret;
+
+	if (!bdev_is_zoned(bdev))
+		return 0;
+
+	zone_info = kzalloc(sizeof(*zone_info), GFP_KERNEL);
+	if (!zone_info)
+		return -ENOMEM;
+
+	zone_sectors = bdev_zone_sectors(bdev);
+	ASSERT(is_power_of_2(zone_sectors));
+	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
+	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
+	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
+	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
+		zone_info->nr_zones++;
+
+	zone_info->seq_zones = kcalloc(BITS_TO_LONGS(zone_info->nr_zones),
+				       sizeof(*zone_info->seq_zones),
+				       GFP_KERNEL);
+	if (!zone_info->seq_zones) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	zone_info->empty_zones = kcalloc(BITS_TO_LONGS(zone_info->nr_zones),
+					 sizeof(*zone_info->empty_zones),
+					 GFP_KERNEL);
+	if (!zone_info->empty_zones) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Get zones type */
+	while (sector < nr_sectors) {
+		nr_zones = BTRFS_REPORT_NR_ZONES;
+		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT,
+					  &zones, &nr_zones, GFP_KERNEL);
+		if (ret)
+			goto out;
+
+		for (i = 0; i < nr_zones; i++) {
+			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
+				set_bit(nreported, zone_info->seq_zones);
+			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
+				set_bit(nreported, zone_info->empty_zones);
+			nreported++;
+		}
+		sector = zones[nr_zones - 1].start + zones[nr_zones - 1].len;
+	}
+
+	if (nreported != zone_info->nr_zones) {
+		btrfs_err_in_rcu(device->fs_info,
+				 "inconsistent number of zones on %s (%u / %u)",
+				 rcu_str_deref(device->name), nreported,
+				 zone_info->nr_zones);
+		ret = -EIO;
+		goto out;
+	}
+
+	device->zone_info = zone_info;
+
+	btrfs_info_in_rcu(
+		device->fs_info,
+		"host-%s zoned block device %s, %u zones of %llu sectors",
+		bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
+		rcu_str_deref(device->name), zone_info->nr_zones,
+		zone_info->zone_size >> SECTOR_SHIFT);
+
+out:
+	kfree(zones);
+
+	if (ret) {
+		kfree(zone_info->seq_zones);
+		kfree(zone_info->empty_zones);
+		kfree(zone_info);
+	}
+
+	return ret;
+}
+
+void btrfs_destroy_dev_zone_info(struct btrfs_device *device)
+{
+	struct btrfs_zoned_device_info *zone_info = device->zone_info;
+
+	if (!zone_info)
+		return;
+
+	kfree(zone_info->seq_zones);
+	kfree(zone_info->empty_zones);
+	kfree(zone_info);
+	device->zone_info = NULL;
+}
+
+int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+		       struct blk_zone *zone, gfp_t gfp_mask)
+{
+	unsigned int nr_zones = 1;
+	int ret;
+
+	ret = btrfs_get_dev_zones(device, pos, &zone, &nr_zones, gfp_mask);
+	if (ret != 0 || !nr_zones)
+		return ret ? ret : -EIO;
+
+	return 0;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
new file mode 100644
index 000000000000..ffc70842135e
--- /dev/null
+++ b/fs/btrfs/hmzoned.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ * Authors:
+ *	Naohiro Aota	<naohiro.aota@wdc.com>
+ *	Damien Le Moal	<damien.lemoal@wdc.com>
+ */
+
+#ifndef BTRFS_HMZONED_H
+#define BTRFS_HMZONED_H
+
+struct btrfs_zoned_device_info {
+	/*
+	 * Number of zones, zone size and types of zones if bdev is a
+	 * zoned block device.
+	 */
+	u64 zone_size;
+	u8  zone_size_shift;
+	u32 nr_zones;
+	unsigned long *seq_zones;
+	unsigned long *empty_zones;
+};
+
+int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+		       struct blk_zone *zone, gfp_t gfp_mask);
+int btrfs_get_dev_zone_info(struct btrfs_device *device);
+void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
+
+static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
+{
+	struct btrfs_zoned_device_info *zone_info = device->zone_info;
+
+	if (!zone_info)
+		return false;
+
+	return test_bit(pos >> zone_info->zone_size_shift,
+			zone_info->seq_zones);
+}
+
+static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
+{
+	struct btrfs_zoned_device_info *zone_info = device->zone_info;
+
+	if (!zone_info)
+		return true;
+
+	return test_bit(pos >> zone_info->zone_size_shift,
+			zone_info->empty_zones);
+}
+
+static inline void btrfs_dev_set_empty_zone_bit(struct btrfs_device *device,
+						u64 pos, bool set)
+{
+	struct btrfs_zoned_device_info *zone_info = device->zone_info;
+	unsigned int zno;
+
+	if (!zone_info)
+		return;
+
+	zno = pos >> zone_info->zone_size_shift;
+	if (set)
+		set_bit(zno, zone_info->empty_zones);
+	else
+		clear_bit(zno, zone_info->empty_zones);
+}
+
+static inline void btrfs_dev_set_zone_empty(struct btrfs_device *device,
+					    u64 pos)
+{
+	btrfs_dev_set_empty_zone_bit(device, pos, true);
+}
+
+static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device,
+					      u64 pos)
+{
+	btrfs_dev_set_empty_zone_bit(device, pos, false);
+}
+
+#endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d74b74ca07af..8e5a894e7bde 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -29,6 +29,7 @@
 #include "sysfs.h"
 #include "tree-checker.h"
 #include "space-info.h"
+#include "hmzoned.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
@@ -342,6 +343,7 @@ void btrfs_free_device(struct btrfs_device *device)
 	rcu_string_free(device->name);
 	extent_io_tree_release(&device->alloc_state);
 	bio_put(device->flush_bio);
+	btrfs_destroy_dev_zone_info(device);
 	kfree(device);
 }
 
@@ -847,6 +849,11 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	device->mode = flags;
 
+	/* Get zone type information of zoned block devices */
+	ret = btrfs_get_dev_zone_info(device);
+	if (ret != 0)
+		goto error_brelse;
+
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
@@ -2598,6 +2605,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	}
 	rcu_assign_pointer(device->name, name);
 
+	device->fs_info = fs_info;
+	device->bdev = bdev;
+
+	/* Get zone type information of zoned block devices */
+	ret = btrfs_get_dev_zone_info(device);
+	if (ret)
+		goto error_free_device;
+
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -2614,8 +2629,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 					 fs_info->sectorsize);
 	device->disk_total_bytes = device->total_bytes;
 	device->commit_total_bytes = device->total_bytes;
-	device->fs_info = fs_info;
-	device->bdev = bdev;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 	device->mode = FMODE_EXCL;
@@ -2756,6 +2769,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		sb->s_flags |= SB_RDONLY;
 	if (trans)
 		btrfs_end_transaction(trans);
+	btrfs_destroy_dev_zone_info(device);
 error_free_device:
 	btrfs_free_device(device);
 error:
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7f6aa1816409..5da1f354db93 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -57,6 +57,8 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 
+struct btrfs_zoned_device_info;
+
 struct btrfs_device {
 	struct list_head dev_list; /* device_list_mutex */
 	struct list_head dev_alloc_list; /* chunk mutex */
@@ -77,6 +79,8 @@ struct btrfs_device {
 
 	struct block_device *bdev;
 
+	struct btrfs_zoned_device_info *zone_info;
+
 	/* the mode sent to blkdev_get */
 	fmode_t mode;
 
-- 
2.22.0

