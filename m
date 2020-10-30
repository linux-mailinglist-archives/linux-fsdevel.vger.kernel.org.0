Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908F32A06D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgJ3Nwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21974 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgJ3Nw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065946; x=1635601946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c1fLKFaRdT0TB+so2lzvhaU0SiAmji8TO0m4uP/4XDI=;
  b=njApx0BeOt2UH4U9+IzOWXkcV2DM3r+YDTyQFhwtRJso2R6lHvPustix
   j4CuGp4a+8JjHuApCxX7yiZ2s83tdWZMB6SXDRlGe+zqeFY5iCd4ojG2e
   9wtvSMD1VuEH/xmFv+oq/ilxnvZNGxQqKGFumfeCQZlBkI6gBXx+O41aX
   gE+lREDK1iCXWHYH5ylKqOZFbw5yOvpGQ/f/QyJw21zhWFzBQEAmECe5b
   nyELGokmHw2uVtja4oAZI71i7UrrEOH249TsZKPPt4NS2vTftbPSNGPrB
   GC3vdcqOcykDvXS6XfzGaGkAF4oCWKI31sP26X6mje43VcRl8ZAUKzgi5
   A==;
IronPort-SDR: cqiOCJOVXtkgiWhfJImXepd9RnvtaM3nsVYHSL7iq9wf4gvRPCpjYSrpWZZGpqSG7bC11snHBW
 Gd8tmU5iIMKQ1B7ysviNSWm2K3rhSwlyM2i9KvcmEgtnuiqTemAFcnufyYA4fdGJPAD74LwvQc
 uo+0KVpWITi7eNMb/jGwSvue4/nmPZWpMb6byzzkgnBWN8BnqQjxtG1zXeTRrAuskwBbt0mexG
 dpsYN93aJa69Yo8doNlZO7vGkab6v/o5HpJjcpujDap3vTsX1MPYmUmurF8wlMDOTHvVOjf0I3
 PyM=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806579"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:26 +0800
IronPort-SDR: 9sL9eU0Bcl1aHXarFLm6bFN53rs568L+0ve3iNB2LxoK4v6gdiaR1SjBpCLYJTg+8eYo2qNGuB
 2CqlfjYqjOZB6Nhch9gTBHHSHgfDH8VPz8K2BD9/p9JJFltGbC88Q7nlyXnrQmSRQR/Ql730KW
 tdLprphQ7B5ySUCgJx9PmBhlEIxU9IkMf6drdncpzP4wdZYyd/ohJ6PqTDEARBCI+wbZ7OOBj7
 W9VORGp0EaBv7jjera+ybaPQRRHtCC9BfGaogtGA1lG+A3lFbj3gSFxSrTFS+bxV9yWWMXJotv
 kR0uE1g8pO6N3a9IaV2sCgXk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:40 -0700
IronPort-SDR: yxZTRp4GlqKmtDpQKhV/iq5wXugRNLgIu+NUcjEPRL5DjfdBTUldn0tv7ZpDVb4gBwnRhHpR8M
 Dbl7zVs29tNA9zASGvVTSgrIywHVXE9VCPmnBMWXqVDihqNVPrARU8PfIpjGbTZj5PhZs4jWUh
 uC1IpN0xv1s4yrgypZzujCcT8U9rei7v+VmKHazmI+CCnppnp8bN0reO4/8t8ZihpcQKLpbUG5
 aFe+n6wOZTZ4I9m/GCRYx2ZtQrYNpLxs55yk5z2SY4B+uHj1gf29vIlEzLuesJYmcI1FeGrE7T
 fjI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:25 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v9 04/41] btrfs: Get zone information of zoned block devices
Date:   Fri, 30 Oct 2020 22:51:11 +0900
Message-Id: <feca5ea7b6dc1a62eddbc00e01452b92523c8f36.1604065694.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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
 fs/btrfs/zoned.c       | 176 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  86 ++++++++++++++++++++
 7 files changed, 294 insertions(+), 2 deletions(-)
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
index 000000000000..5657d654bc44
--- /dev/null
+++ b/fs/btrfs/zoned.c
@@ -0,0 +1,176 @@
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
+				 "get zone at %llu on %s failed %d", pos,
+				 rcu_str_deref(device->name), ret);
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
+	char devstr[sizeof(device->fs_info->sb->s_id) +
+		    sizeof(" (device )") - 1];
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
+	devstr[0] = 0;
+	if (device->fs_info)
+		snprintf(devstr, sizeof(devstr), " (device %s)",
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
index 000000000000..483229e27908
--- /dev/null
+++ b/fs/btrfs/zoned.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_ZONED_H
+#define BTRFS_ZONED_H
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
-- 
2.27.0

