Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6C4112456
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfLDITa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:30 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32750 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLDIT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447569; x=1606983569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wVGBNjAWlvWz3MwTcyINEyxuDIZ2trs71zRfftU9VzM=;
  b=a8VsCtO862DyIfOSn/sJv68HdVq6D6Ez28DS3yI7DOxfGT9TgW5yfz8t
   PmFjOHDW6jr6uwJJTLkc27+j7x05xE6tpfCZNlcrzum/ku/H4nA5nzOWv
   lvbBj5Bd/zwnV3gFxoNbv6+UJLl7/5LwUPnyHl+I0fsVpM8L5BFZ37BDN
   /2xOIW+OuFl2JLybykxUqCh4IYo9nHMoOevC5xrmZjLG0frlPSlNoQWTW
   68/vJ0X9knn8YuCN+hcYk99rTuPFsdzQ63uryMkaVDsFLLkxYf4uQbudO
   NZbg9dN7ZLm1SRWLmNOJ5YbgmpDVLT8Nh38v+OKF9g0TwvZCUDp6iBqv/
   Q==;
IronPort-SDR: j39S+1E09hMcCeMPEK+D1xX+DeRKCHK6aYOkJemL0kl0ixXa1GcjblnIarfxCGEWhHqyQozd3r
 Mtj+HI81V/V1NsxwqqfT03K53IF+OSzxcXamUbdbFw3Rwpt4V0uFcDB9fJxTK+JSRvfQIDhK2P
 hihJ/ijVLFRimkBfelTurwLCHqARMYUuJKcEJCj6huixMaTdGpAqfQXcZ2Uwq6+CUZ2hVZBaBA
 jnGZXSq8whNKzoI/ty6JgTYbJL1n/EMJD9xbmjEynRwpU/K9ZwBJTGVEMMl20Q1xEh4dxVFtoj
 Pb0=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355020"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:25 +0800
IronPort-SDR: RboGRRioxPVVAnESJ6FvQEat9lNjAiu3dk+HpI4Ku6W/xPwixLDV5xDu7hqN7MaVOlkm63h3yx
 gOAfSHYUCiG3e73+Xv0LxUGU4n+5/nQGM0fEsr9pgI2KoSXVGopxFsfu4fcjhmw1ExtK5xhlvj
 JSQJY9vZbx/xeupLmwHF+2z950HDjQErgrqPHT+eWgaiO99ny7/Zdt6XLXBIOzdA9jSv1SoNnf
 sv6Ahs2sgnqdKrcqXRW1s6oOImafYqD1GLsp5z5FXX1pUDkFNUVoYcv5kPdikibXSdpZM4HQ1U
 fGW0m6nhFNIUeL4BFNlpUxIN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:13:50 -0800
IronPort-SDR: GJCGumFBk1J/OG7pshExQOGdbCBiVyOC6QzT2ySKFCEO7MauiDVxdaZStvCKP7u16g0AVMCp1G
 jiRXFDjh3kVqHtzaKrmH+2m4j09JdP0Gv33dc7HAdb/Klr5MkM6s30W8buicOwMrcAKVzOAI45
 +0Q4EXIHkFgDu93oEEMs3WcDCmXGGFe9ot+fT3UnWkDC8SNNDIC45ttJ8eeElrm8gDVNAmJ/KM
 sK2MGfKLYB/SoKDbUSew3HZTINBCn+thxquiIgJvwZo5lcHXcyVKbQ0/DXTqSwcAZjyvcF2pJw
 0jU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 02/28] btrfs: Get zone information of zoned block devices
Date:   Wed,  4 Dec 2019 17:17:09 +0900
Message-Id: <20191204081735.852438-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a zoned block device is found, get its zone information (number of zones
and zone size) using the new helper function btrfs_get_dev_zone_info().  To
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
 fs/btrfs/Makefile  |   1 +
 fs/btrfs/hmzoned.c | 174 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h |  92 ++++++++++++++++++++++++
 fs/btrfs/volumes.c |  18 ++++-
 fs/btrfs/volumes.h |   4 ++
 5 files changed, 287 insertions(+), 2 deletions(-)
 create mode 100644 fs/btrfs/hmzoned.c
 create mode 100644 fs/btrfs/hmzoned.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 82200dbca5ac..64aaeed397a4 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -16,6 +16,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
+btrfs-$(CONFIG_BLK_DEV_ZONED) += hmzoned.o
 
 btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/extent-buffer-tests.o tests/btrfs-tests.o \
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
new file mode 100644
index 000000000000..e37335625f76
--- /dev/null
+++ b/fs/btrfs/hmzoned.c
@@ -0,0 +1,174 @@
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
+			       struct blk_zone *zones, unsigned int *nr_zones)
+{
+	int ret;
+
+	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, zones,
+				  nr_zones);
+	if (ret != 0) {
+		btrfs_err_in_rcu(device->fs_info,
+				 "get zone at %llu on %s failed %d", pos,
+				 rcu_str_deref(device->name), ret);
+		return ret;
+	}
+	if (!*nr_zones)
+		return -EIO;
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
+#define LEN (sizeof(device->fs_info->sb->s_id) + sizeof("(device )") - 1)
+	char devstr[LEN];
+	const int len = LEN;
+#undef LEN
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
+		goto free_zone_info;
+	}
+
+	zone_info->empty_zones = kcalloc(BITS_TO_LONGS(zone_info->nr_zones),
+					 sizeof(*zone_info->empty_zones),
+					 GFP_KERNEL);
+	if (!zone_info->empty_zones) {
+		ret = -ENOMEM;
+		goto free_seq_zones;
+	}
+
+	zones = kcalloc(BTRFS_REPORT_NR_ZONES,
+			sizeof(struct blk_zone), GFP_KERNEL);
+	if (!zones) {
+		ret = -ENOMEM;
+		goto free_empty_zones;
+	}
+
+	/* Get zones type */
+	while (sector < nr_sectors) {
+		nr_zones = BTRFS_REPORT_NR_ZONES;
+		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
+					  &nr_zones);
+		if (ret)
+			goto free_zones;
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
+		goto free_zones;
+	}
+
+	kfree(zones);
+
+	device->zone_info = zone_info;
+
+	devstr[0] = 0;
+	if (device->fs_info)
+		snprintf(devstr, len, " (device %s)",
+			 device->fs_info->sb->s_id);
+
+	rcu_read_lock();
+	pr_info(
+"BTRFS info%s: host-%s zoned block device %s, %u zones of %llu sectors",
+		devstr,
+		bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
+		rcu_str_deref(device->name), zone_info->nr_zones,
+		zone_info->zone_size >> SECTOR_SHIFT);
+	rcu_read_unlock();
+
+	return 0;
+
+free_zones:
+	kfree(zones);
+free_empty_zones:
+	kfree(zone_info->empty_zones);
+free_seq_zones:
+	kfree(zone_info->seq_zones);
+free_zone_info:
+	kfree(zone_info);
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
+		       struct blk_zone *zone)
+{
+	unsigned int nr_zones = 1;
+	int ret;
+
+	ret = btrfs_get_dev_zones(device, pos, zone, &nr_zones);
+	if (ret != 0 || !nr_zones)
+		return ret ? ret : -EIO;
+
+	return 0;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
new file mode 100644
index 000000000000..0f8006f39aaf
--- /dev/null
+++ b/fs/btrfs/hmzoned.h
@@ -0,0 +1,92 @@
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
+#ifdef CONFIG_BLK_DEV_ZONED
+int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+		       struct blk_zone *zone);
+int btrfs_get_dev_zone_info(struct btrfs_device *device);
+void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
+#else /* CONFIG_BLK_DEV_ZONED */
+static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+				     struct blk_zone *zone)
+{
+	return 0;
+}
+static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
+{
+	return 0;
+}
+static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }
+#endif
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
index d8e5560db285..18ea8dfce244 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -30,6 +30,7 @@
 #include "tree-checker.h"
 #include "space-info.h"
 #include "block-group.h"
+#include "hmzoned.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
@@ -366,6 +367,7 @@ void btrfs_free_device(struct btrfs_device *device)
 	rcu_string_free(device->name);
 	extent_io_tree_release(&device->alloc_state);
 	bio_put(device->flush_bio);
+	btrfs_destroy_dev_zone_info(device);
 	kfree(device);
 }
 
@@ -650,6 +652,11 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
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
@@ -2421,6 +2428,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
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
@@ -2437,8 +2452,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 					 fs_info->sectorsize);
 	device->disk_total_bytes = device->total_bytes;
 	device->commit_total_bytes = device->total_bytes;
-	device->fs_info = fs_info;
-	device->bdev = bdev;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 	device->mode = FMODE_EXCL;
@@ -2571,6 +2584,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		sb->s_flags |= SB_RDONLY;
 	if (trans)
 		btrfs_end_transaction(trans);
+	btrfs_destroy_dev_zone_info(device);
 error_free_device:
 	btrfs_free_device(device);
 error:
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fc1b564b9cfe..70cabe65f72a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -53,6 +53,8 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 
+struct btrfs_zoned_device_info;
+
 struct btrfs_device {
 	struct list_head dev_list; /* device_list_mutex */
 	struct list_head dev_alloc_list; /* chunk mutex */
@@ -66,6 +68,8 @@ struct btrfs_device {
 
 	struct block_device *bdev;
 
+	struct btrfs_zoned_device_info *zone_info;
+
 	/* the mode sent to blkdev_get */
 	fmode_t mode;
 
-- 
2.24.0

