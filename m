Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFF82E04ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgLVDwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:52:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46437 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLVDwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609157; x=1640145157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gjEXRn+1lfGV9vAJQVWu7z67FtdI/W78TJR3Uy2XVQM=;
  b=mcQ8TbNVSE0qKo5FhQF/kJv332/n1a7Ln04GKVfMq81CrPFim8as7i4z
   Y17rjHMq72/yGnBJxLRrDNTVIEGtzVeGwaIHpc7vLpGrFX7JVUqqXv+ps
   SCx90FWpNSjMHEo9RBZeQGXZqImedlCdTF+qwQzNennWMArHXf2FoovDo
   wYJiWD2OVyGGiRS5tWMiXMQxiH50wWdyMIH4ujmdk3JTcBa6XjE4sUiYX
   JpmbQV2EfjA+fDn7NlIcMjSdTR3Ro0PuHVaxUwP1YgXUtyauMeJspS+mz
   wseDuDd0vrpL4zLNS1junpzgq5HvhKICnaNyzGe2fiNkLjjJiPIiJvQBk
   g==;
IronPort-SDR: ycP7an68lcYOROTphqhzrmr+pZWqzij7uKrDhISNntnOZ5fHqqup2yirPGWQWaWwrtEcEO38DN
 +cGhCsuYIRG9wo2cwUts5KAN6gQhxol8BA30OYOOUntY1+MX5zi2BbUL45u43uu/TeLQA7SwV3
 MXmDkjD6uLleRR7bFJo5o7nTKcLpvXb2j27TLZhE5fsLT5p9NritEKb9zxIC+EwKPJA+53pvFX
 NIjiwmUuqYHjTZ3QKcDh9FDfoNSZ/0QGDqTM3diYJOaC16SEDlWmfIc3JKao6Qjyt2oyhp2f+H
 zaA=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193742"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:36 +0800
IronPort-SDR: c7fDFsS6xk53zAM4LIJ5PQLW4u17HwvIQjvd6hvFGScYcID/C7H4jTXYZM+NExYMINS+66+4yZ
 IIbdpFEi9rJqdrBVOOzcwHTopBbyaeYLVjMezGSG84ywiMlvkwlAwhhf8EQmt0kdzV/JmK75Cv
 +lazynqgYBDJZXFG4d/m2SzgKel9ePr8JKjW0DVh3iMsNPT2+KG5A82+JGvi7btUrd6dpQclSp
 kfFXRZq3S6LJIZWnGqiHleBvLfUtIIePbryRHfC1F+jAWseFD+aaK/lMXUBTXUAQtRotVEbL4b
 EOWVnrNOQ0PLlAE8SyJ/IwFY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:47 -0800
IronPort-SDR: AD5Is/l3hNGlDaob1pkVVwAvAQiI1Wg/oZZ2l9Lj0LgcTnGDJCSdOoHbgRPj9R7/uGEHWkH5HK
 xk8jD6se7kGf31MJA+STHrHiCoTZO4lZnyQOmhs46JlozVUbLU/due9WSq0N+WaKko6KBHzw40
 1HGPWax4l+tEq9CvLKrtVIbbsMnWcc5Z2i2BlGSWrf2KQvXZ6vnySbcOdhO0nrs9MoJy524BU5
 gzOhbqQIrjE0xsSMrcRe9fd5aYkBk+Ph2vPTZyvOfqtKBGk1jNzJ1HdqULud57ayhnnscNQPeI
 wCk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:35 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 08/40] btrfs: emulated zoned mode on non-zoned devices
Date:   Tue, 22 Dec 2020 12:49:01 +0900
Message-Id: <e2bcb873196a16b05d5757cd8087900d4f464347.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Emulate zoned btrfs mode on non-zoned devices. This is done by "slicing
up" the block-device into static sized chunks and fake a conventional zone
on each of them. The emulated zone size is determined from the size of
device extent.

This is mainly aimed at testing parts of the zoned mode, i.e. the zoned
chunk allocator, on regular block devices.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/dev-replace.c |   3 +
 fs/btrfs/volumes.c     |  14 +++++
 fs/btrfs/volumes.h     |   3 +
 fs/btrfs/zoned.c       | 121 +++++++++++++++++++++++++++++++++++++----
 fs/btrfs/zoned.h       |  14 +++--
 5 files changed, 139 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 324f646d6e5e..e77cb46bf15d 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -321,6 +321,9 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_info->fs_devices;
 
+	if (btrfs_is_zoned(fs_info) && bdev_zoned_model(bdev) == BLK_ZONED_NONE)
+		device->force_zoned = true;
+
 	ret = btrfs_get_dev_zone_info(device);
 	if (ret)
 		goto error;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7d92b11ea603..2cdb5fe3e423 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -669,6 +669,15 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	device->mode = flags;
 
+	/* Emulate zoned mode on regular device? */
+	if ((btrfs_super_incompat_flags(disk_super) &
+	     BTRFS_FEATURE_INCOMPAT_ZONED) &&
+	    bdev_zoned_model(device->bdev) == BLK_ZONED_NONE) {
+		btrfs_info(NULL,
+"zoned: incompat zoned flag detected on regular device, forcing zoned mode emulation");
+		device->force_zoned = true;
+	}
+
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
@@ -2562,6 +2571,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->fs_info = fs_info;
 	device->bdev = bdev;
 
+	/* Zoned mode is enabled. Emulate zoned device on a regular device. */
+	if (btrfs_is_zoned(fs_info) &&
+	    bdev_zoned_model(device->bdev) == BLK_ZONED_NONE)
+		device->force_zoned = true;
+
 	ret = btrfs_get_dev_zone_info(device);
 	if (ret)
 		goto error_free_device;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1997a4649a66..59d9d47f173d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -144,6 +144,9 @@ struct btrfs_device {
 	struct completion kobj_unregister;
 	/* For sysfs/FSID/devinfo/devid/ */
 	struct kobject devid_kobj;
+
+	/* Force zoned mode */
+	bool force_zoned;
 };
 
 /*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ae566a7da088..fc43a650cd79 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -119,6 +119,32 @@ static inline u32 sb_zone_number(int shift, int mirror)
 	return 0;
 }
 
+static int emulate_report_zones(struct btrfs_device *device, u64 pos,
+				struct blk_zone *zones, unsigned int nr_zones)
+{
+	const sector_t zone_sectors =
+		device->fs_info->zone_size >> SECTOR_SHIFT;
+	sector_t bdev_size = device->bdev->bd_part->nr_sects;
+	unsigned int i;
+
+	pos >>= SECTOR_SHIFT;
+	for (i = 0; i < nr_zones; i++) {
+		zones[i].start = i * zone_sectors + pos;
+		zones[i].len = zone_sectors;
+		zones[i].capacity = zone_sectors;
+		zones[i].wp = zones[i].start + zone_sectors;
+		zones[i].type = BLK_ZONE_TYPE_CONVENTIONAL;
+		zones[i].cond = BLK_ZONE_COND_NOT_WP;
+
+		if (zones[i].wp >= bdev_size) {
+			i++;
+			break;
+		}
+	}
+
+	return i;
+}
+
 static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 			       struct blk_zone *zones, unsigned int *nr_zones)
 {
@@ -127,6 +153,12 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	if (!*nr_zones)
 		return 0;
 
+	if (device->force_zoned) {
+		ret = emulate_report_zones(device, pos, zones, *nr_zones);
+		*nr_zones = ret;
+		return 0;
+	}
+
 	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
 				  copy_zone_info_cb, zones);
 	if (ret < 0) {
@@ -143,6 +175,49 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	return 0;
 }
 
+static int calculate_emulated_zone_size(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_path *path;
+	struct btrfs_root *root = fs_info->dev_root;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct btrfs_dev_extent *dext;
+	int ret = 0;
+
+	key.objectid = 1;
+	key.type = BTRFS_DEV_EXTENT_KEY;
+	key.offset = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+
+	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+		ret = btrfs_next_item(root, path);
+		if (ret < 0)
+			goto out;
+		/* No dev extents at all? Not good */
+		if (ret > 0) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+
+	leaf = path->nodes[0];
+	dext = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_extent);
+	fs_info->zone_size = btrfs_dev_extent_length(leaf, dext);
+	ret = 0;
+
+out:
+	btrfs_free_path(path);
+
+	return ret;
+}
+
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
@@ -158,6 +233,12 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 		if (!device->bdev)
 			continue;
 
+		if (device->force_zoned && !fs_info->zone_size) {
+			ret = calculate_emulated_zone_size(fs_info);
+			if (ret)
+				break;
+		}
+
 		ret = btrfs_get_dev_zone_info(device);
 		if (ret)
 			break;
@@ -177,9 +258,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	struct blk_zone *zones = NULL;
 	unsigned int i, nreported = 0, nr_zones;
 	unsigned int zone_sectors;
+	const bool force_zoned = device->force_zoned;
+	char *model, *emulated;
 	int ret;
 
-	if (!bdev_is_zoned(bdev))
+	if (!bdev_is_zoned(bdev) && !force_zoned)
 		return 0;
 
 	if (device->zone_info)
@@ -189,8 +272,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	if (!zone_info)
 		return -ENOMEM;
 
+	if (force_zoned)
+		zone_sectors = device->fs_info->zone_size >> SECTOR_SHIFT;
+	else
+		zone_sectors = bdev_zone_sectors(bdev);
+
 	nr_sectors = bdev->bd_part->nr_sects;
-	zone_sectors = bdev_zone_sectors(bdev);
 	/* Check if it's power of 2 (see is_power_of_2) */
 	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
 	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
@@ -296,12 +383,22 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 
 	device->zone_info = zone_info;
 
-	/* device->fs_info is not safe to use for printing messages */
-	btrfs_info_in_rcu(NULL,
-			"host-%s zoned block device %s, %u zones of %llu bytes",
-			bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
-			rcu_str_deref(device->name), zone_info->nr_zones,
-			zone_info->zone_size);
+	if (bdev_zoned_model(bdev) == BLK_ZONED_HM) {
+		model = "host-managed zoned";
+		emulated = "";
+	} else if (bdev_zoned_model(bdev) == BLK_ZONED_HA) {
+		model = "host-aware zoned";
+		emulated = "";
+	} else if (bdev_zoned_model(bdev) == BLK_ZONED_NONE &&
+		 device->force_zoned) {
+		model = "regular";
+		emulated = "emulated ";
+	}
+
+	btrfs_info_in_rcu(device->fs_info,
+		"%s block device %s, %u %szones of %llu bytes",
+		model, rcu_str_deref(device->name), zone_info->nr_zones,
+		emulated, zone_info->zone_size);
 
 	return 0;
 
@@ -348,7 +445,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
 	u64 max_zone_append_size = 0;
-	const bool incompat_zoned = btrfs_is_zoned(fs_info);
+	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
 	/* Count zoned devices */
@@ -360,8 +457,10 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 
 		model = bdev_zoned_model(device->bdev);
 		if (model == BLK_ZONED_HM ||
-		    (model == BLK_ZONED_HA && incompat_zoned)) {
-			struct btrfs_zoned_device_info *zone_info;
+		    (model == BLK_ZONED_HA && incompat_zoned) ||
+		    device->force_zoned) {
+			struct btrfs_zoned_device_info *zone_info =
+				device->zone_info;
 
 			zone_info = device->zone_info;
 			zoned_devices++;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 5e0e7de84a82..058a57317c05 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -143,12 +143,16 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device, u64 p
 static inline bool btrfs_check_device_zone_type(const struct btrfs_fs_info *fs_info,
 						struct block_device *bdev)
 {
-	u64 zone_size;
-
 	if (btrfs_is_zoned(fs_info)) {
-		zone_size = bdev_zone_sectors(bdev) << SECTOR_SHIFT;
-		/* Do not allow non-zoned device */
-		return bdev_is_zoned(bdev) && fs_info->zone_size == zone_size;
+		/*
+		 * We can allow a regular device on a zoned btrfs, because
+		 * we will emulate zoned device on the regular device.
+		 */
+		if (!bdev_is_zoned(bdev))
+			return true;
+
+		return fs_info->zone_size ==
+			(bdev_zone_sectors(bdev) << SECTOR_SHIFT);
 	}
 
 	/* Do not allow Host Manged zoned device */
-- 
2.27.0

