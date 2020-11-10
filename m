Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130132AD4E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgKJL2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11940 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgKJL2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007691; x=1636543691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmfkIiYRRcMNCe21CPpoRyCIvOUVBrmuf8I7xRb7U/c=;
  b=rg1lguh5TPti1F7wsCMbKcwmioVzKt136jbR4ob05qD9TEM5DKO61KDy
   fWP4U8kq28qlcYh4WyWSCoSKuIovREBfIFQQZGQqH9QBXyZEbpUILPj0w
   vUxZk1UpQxaJOB3brrOO0f+GHIIAJAFgQoUSwK0w/a7FGFUtzVEEWNwh8
   4/m+3OW+95Dozw0qguXank4vJmC9Qc41uX4W1+FxNJmvgv2SNO9BWBjKw
   8qm46o1trBiIgaPuTSgTLDVu3B8quOURGR83FS4ozSYMaz9xWCOLqJgwt
   GRKmlSNCHXmiS0Yoe/S0+9FrDx+W9Jkr9gb52Rne7hYTPrW5D4MmoIlcS
   A==;
IronPort-SDR: +wcSj9+Nca+06XtHLzfuAWJPaVqbLI8qsR6/AS146BcCqsqK9GOKptn0ir0dQJDVHTVZZ6TSWQ
 fHitmnYkHfo3rRr0SejDwfQ8a+hFwKZPiIpaDSncmRixNdhqPsRjXqZ6xcT7SswaNz8/Xf1MFA
 tgjHk9EFdAb24zggvmQ6rZ0Q97K2yjxY5n8hf2esw7reVrt8uTg30/JB/sP+gzODxBuDpM8g5G
 NkTgCrMnxKWS5TO4ahHn0xWYRW7iYp0/ZawK7yGIVAhYAP+goakdkUxNGdHClkbUrU0KwkOI23
 vIo=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376414"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:11 +0800
IronPort-SDR: YwDpQsYa4y/V2Bp82pGEaCEg4evkdZnHhWP9XdRckXA44fHl+l/vWq8HFfO9lWXbF1iTjzm/u6
 59hN3NKERL9J957252f7suYLCI97kEbOLfoLMRM1OiNo2y9D9tg9lp+r1IKzxXCL6BiCX2MFpn
 Si1jrRLTUEc/JPlbYLrEx/ZzvCYFy5PsqBA3TlHuzPEH3zrMyc539QPidXFKW82lxZcMpP5tAr
 snuxxlGJpUzI/k6XseKPMWAfT4BGGJcks9w5n4jUzk6pSb6uVYsWPDamQwbQH+1z+Ln7EnKg1O
 AkpPdXwHXNJUB5OcYxDbqjAJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:11 -0800
IronPort-SDR: QCXKOXZQ80NT8cI1OHh32rbCiHPL2m9Vzx7wc/3m0jP1W1cxWJuJVKoQLOfgRusow85kJ6KdFw
 nVEQ3b5FSFeNf1BIExDSbpTMgKf9kT35W6q8wl10p7AqNayetu/DX1J6asECg9hYYBVg0qI+/1
 KIa4krs1IARLtFy7eUy+QzEKdkAPVpeqjFjN3xI72iK+hsyI6Mr0p3Eh0eSOUdRxoy9z+znLJS
 siFPDevK8owA4CKmNKpztcQjOql3V4+JHHhNbubRaCJEnIYJnxIqGCHqAAkpcI3sbvKx45YXRn
 6ok=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:09 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 04/41] btrfs: get zone information of zoned block devices
Date:   Tue, 10 Nov 2020 20:26:07 +0900
Message-Id: <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile      |   1 +
 fs/btrfs/dev-replace.c |   5 ++
 fs/btrfs/super.c       |   5 ++
 fs/btrfs/volumes.c     |  19 ++++-
 fs/btrfs/volumes.h     |   4 +
 fs/btrfs/zoned.c       | 182 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  91 +++++++++++++++++++++
 7 files changed, 305 insertions(+), 2 deletions(-)
 create mode 100644 fs/btrfs/zoned.c
 create mode 100644 fs/btrfs/zoned.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index e738f6206ea5..0497fdc37f90 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -16,6 +16,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
+btrfs-$(CONFIG_BLK_DEV_ZONED) += zoned.o
 
 btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/extent-buffer-tests.o tests/btrfs-tests.o \
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 20ce1970015f..6f6d77224c2b 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -21,6 +21,7 @@
 #include "rcu-string.h"
 #include "dev-replace.h"
 #include "sysfs.h"
+#include "zoned.h"
 
 /*
  * Device replace overview
@@ -291,6 +292,10 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_info->fs_devices;
 
+	ret = btrfs_get_dev_zone_info(device);
+	if (ret)
+		goto error;
+
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	list_add(&device->dev_list, &fs_info->fs_devices->devices);
 	fs_info->fs_devices->num_devices++;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8840a4fa81eb..ed55014fd1bd 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 			", ref-verify=on"
+#endif
+#ifdef CONFIG_BLK_DEV_ZONED
+			", zoned=yes"
+#else
+			", zoned=no"
 #endif
 			;
 	pr_info("Btrfs loaded, crc32c=%s%s\n", crc32c_impl(), options);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 58b9c419a2b6..e787bf89f761 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -31,6 +31,7 @@
 #include "space-info.h"
 #include "block-group.h"
 #include "discard.h"
+#include "zoned.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
@@ -374,6 +375,7 @@ void btrfs_free_device(struct btrfs_device *device)
 	rcu_string_free(device->name);
 	extent_io_tree_release(&device->alloc_state);
 	bio_put(device->flush_bio);
+	btrfs_destroy_dev_zone_info(device);
 	kfree(device);
 }
 
@@ -667,6 +669,11 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	device->mode = flags;
 
+	/* Get zone type information of zoned block devices */
+	ret = btrfs_get_dev_zone_info(device);
+	if (ret != 0)
+		goto error_free_page;
+
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
@@ -1143,6 +1150,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 		device->bdev = NULL;
 	}
 	clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
+	btrfs_destroy_dev_zone_info(device);
 
 	device->fs_info = NULL;
 	atomic_set(&device->dev_stats_ccnt, 0);
@@ -2543,6 +2551,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
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
@@ -2559,8 +2575,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 					 fs_info->sectorsize);
 	device->disk_total_bytes = device->total_bytes;
 	device->commit_total_bytes = device->total_bytes;
-	device->fs_info = fs_info;
-	device->bdev = bdev;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 	device->mode = FMODE_EXCL;
@@ -2707,6 +2721,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		sb->s_flags |= SB_RDONLY;
 	if (trans)
 		btrfs_end_transaction(trans);
+	btrfs_destroy_dev_zone_info(device);
 error_free_device:
 	btrfs_free_device(device);
 error:
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bf27ac07d315..9c07b97a2260 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -51,6 +51,8 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 
+struct btrfs_zoned_device_info;
+
 struct btrfs_device {
 	struct list_head dev_list; /* device_list_mutex */
 	struct list_head dev_alloc_list; /* chunk mutex */
@@ -64,6 +66,8 @@ struct btrfs_device {
 
 	struct block_device *bdev;
 
+	struct btrfs_zoned_device_info *zone_info;
+
 	/* the mode sent to blkdev_get */
 	fmode_t mode;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
new file mode 100644
index 000000000000..b7ffe6670d3a
--- /dev/null
+++ b/fs/btrfs/zoned.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/slab.h>
+#include <linux/blkdev.h>
+#include "ctree.h"
+#include "volumes.h"
+#include "zoned.h"
+#include "rcu-string.h"
+
+/* Maximum number of zones to report per blkdev_report_zones() call */
+#define BTRFS_REPORT_NR_ZONES   4096
+
+static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
+			     void *data)
+{
+	struct blk_zone *zones = data;
+
+	memcpy(&zones[idx], zone, sizeof(*zone));
+
+	return 0;
+}
+
+static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
+			       struct blk_zone *zones, unsigned int *nr_zones)
+{
+	int ret;
+
+	if (!*nr_zones)
+		return 0;
+
+	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
+				  copy_zone_info_cb, zones);
+	if (ret < 0) {
+		btrfs_err_in_rcu(device->fs_info,
+				 "zoned: failed to read zone %llu on %s (devid %llu)",
+				 pos, rcu_str_deref(device->name),
+				 device->devid);
+		return ret;
+	}
+	*nr_zones = ret;
+	if (!ret)
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
+
+	if (!bdev_is_zoned(bdev))
+		return 0;
+
+	if (device->zone_info)
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
+	if (!IS_ALIGNED(nr_sectors, zone_sectors))
+		zone_info->nr_zones++;
+
+	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
+	if (!zone_info->seq_zones) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	zone_info->empty_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
+	if (!zone_info->empty_zones) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	zones = kcalloc(BTRFS_REPORT_NR_ZONES,
+			sizeof(struct blk_zone), GFP_KERNEL);
+	if (!zones) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Get zones type */
+	while (sector < nr_sectors) {
+		nr_zones = BTRFS_REPORT_NR_ZONES;
+		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
+					  &nr_zones);
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
+	kfree(zones);
+
+	device->zone_info = zone_info;
+
+	/*
+	 * This function is called from open_fs_devices(), which is before
+	 * we set the device->fs_info. So, we use pr_info instead of
+	 * btrfs_info to avoid printing confusing message like "BTRFS info
+	 * (device <unknown>) ..."
+	 */
+
+	rcu_read_lock();
+	if (device->fs_info)
+		btrfs_info(device->fs_info,
+			"host-%s zoned block device %s, %u zones of %llu bytes",
+			bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
+			rcu_str_deref(device->name), zone_info->nr_zones,
+			zone_info->zone_size);
+	else
+		pr_info("BTRFS info: host-%s zoned block device %s, %u zones of %llu bytes",
+			bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
+			rcu_str_deref(device->name), zone_info->nr_zones,
+			zone_info->zone_size);
+	rcu_read_unlock();
+
+	return 0;
+
+out:
+	kfree(zones);
+	bitmap_free(zone_info->empty_zones);
+	bitmap_free(zone_info->seq_zones);
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
+	bitmap_free(zone_info->seq_zones);
+	bitmap_free(zone_info->empty_zones);
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
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
new file mode 100644
index 000000000000..c9e69ff87ab9
--- /dev/null
+++ b/fs/btrfs/zoned.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_ZONED_H
+#define BTRFS_ZONED_H
+
+#include <linux/types.h>
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
+
+static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
+{
+	return 0;
+}
+
+static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }
+
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
-- 
2.27.0

