Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B7E2F731F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbhAOG51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:57:27 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41752 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693845; x=1642229845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Byrp/LbzSYs1xXDKYbLKlz6PUoB9ASc9IQVGmlw34ZI=;
  b=RO5ftpEjR1HN7x8HYaX5OhE6xMt04+i+5jrtYuLBpx44KYj5fEf/KYzm
   Sfk69371m2mjGSS/VxKbzLQJGU+VS2CJcwdKcOonuy8lBAXv9ajVe2qmr
   NTkfEtmDHrD46CDjBHtH1WTN0fSYH9y9vK2uSh+SNnm4TW2kXwaVI421Q
   VSb/fTqNo/VsmUkJb3K/yeKR4MgULEU3t7R/AITSmbEZgTCF8ckDEPFZG
   Rh5EjD8L0LAVaiGaLxtZf0ozFqQROCJackhyMFeLV5IjMuXDV/rr9L0p3
   RpSmL/U+iZTd4LNWFJNNlrcH0itHIQIWTtoCPlqVGL4PO3G0v444PGi4R
   A==;
IronPort-SDR: vhQDqloJbrDgYVL1NVjJzN8XOcltq0T7s8tHxN7921bYz8Llsnox7HIHoJZLa0kQ5QAHqtyTDG
 OQN5VNbu7NBFOaq3luUReS50KpAEHcqGI+riMFOPU1+bSGfVlg+VvcSKZlQkGh6+7Ea47DS9t4
 k4j72/ay6/FkZXYD1lFcfMrxCz2MAFH/yonsESiMa0J8ZdIo42NPN7ZQaq+7sosDCg5Fe6DeVh
 4RGTzN8j7k/Ca/0X7KQrAf1j4ZecrA2gwSV4GnKt1Ql2tQrFMPR/XmbVpXZDpFmVLLfKDu6HvU
 F6M=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928208"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:19 +0800
IronPort-SDR: 5J5uVGCifczXO2u901plnq7cxl1e/H1CakayXpYRV8ULevzhBjhkF8mfwMoG0L4hxe9xTZMeGu
 RI0km1GUIVt32ZnpSic5jDBe7CMZqI6ESDzKBoUyClAf87bsZoSV9tvYr/vvmjgBwEQ0ax40Cl
 RSY5TUDWotP3rHNJeddTzMdhdxlnR/HhjCLTJIhKh7XDn5TfPJouxxyW2yHITTmnecOoTUBw2d
 J190NEn/9d7KGRMHE9xbhr0zxKSwJ/zN1LycI1DRIJRMxrahUdTGk+5od86kUo8OJ8scqN1edM
 1l4DDksjsZtLwi9v8wN99tnk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:01 -0800
IronPort-SDR: aS3qfFUm1unC9zYPY7Dw+hGU8hkExSGWCzmOUrURlNJgg5Nj5wt9xe0tNpci4TkJe0hgmuWWoS
 ZoxJ8byx35sJdHzEYAaIrrqqGTfMtbTXgf2TIe60DTdcevn3EjGsZ1EVx1LE1xVETajNX226Vv
 nsSZndrPUF+rPYi0ELG95CpYZtmcZYsDpNDe98xT1T6LG8LfXt1DxXCxjOXmUrMgMcBD44n7Ez
 0F3cGq1AMs2KNHADSZ7Cs0K4OdG2px/yMnIicM5HFHF5OLuu+4SmNYvGgNcIEXKAvbLKKrl/XO
 FRA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:17 -0800
Received: (nullmailer pid 1916434 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v12 08/41] btrfs: allow zoned mode on non-zoned block devices
Date:   Fri, 15 Jan 2021 15:53:11 +0900
Message-Id: <b80a551167d92406924050e9ccbcd872f84fa857.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Run zoned btrfs mode on non-zoned devices. This is done by "slicing
up" the block-device into static sized chunks and fake a conventional zone
on each of them. The emulated zone size is determined from the size of
device extent.

This is mainly aimed at testing parts of the zoned mode, i.e. the zoned
chunk allocator, on regular block devices.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 149 +++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/zoned.h |  14 +++--
 2 files changed, 147 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 684dad749a8c..13b240e5db4e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -119,6 +119,37 @@ static inline u32 sb_zone_number(int shift, int mirror)
 	return 0;
 }
 
+/*
+ * Emulate blkdev_report_zones() for a non-zoned device. It slice up
+ * the block device into static sized chunks and fake a conventional zone
+ * on each of them.
+ */
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
@@ -127,6 +158,12 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	if (!*nr_zones)
 		return 0;
 
+	if (!bdev_is_zoned(device->bdev)) {
+		ret = emulate_report_zones(device, pos, zones, *nr_zones);
+		*nr_zones = ret;
+		return 0;
+	}
+
 	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
 				  copy_zone_info_cb, zones);
 	if (ret < 0) {
@@ -143,6 +180,50 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	return 0;
 }
 
+/* The emulated zone size is determined from the size of device extent. */
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
@@ -169,6 +250,7 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 
 int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
+	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_zoned_device_info *zone_info = NULL;
 	struct block_device *bdev = device->bdev;
 	struct request_queue *queue = bdev_get_queue(bdev);
@@ -177,9 +259,14 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	struct blk_zone *zones = NULL;
 	unsigned int i, nreported = 0, nr_zones;
 	unsigned int zone_sectors;
+	char *model, *emulated;
 	int ret;
 
-	if (!bdev_is_zoned(bdev))
+	/*
+	 * Cannot use btrfs_is_zoned here, since fs_info->zone_size might
+	 * not be set yet.
+	 */
+	if (!btrfs_fs_incompat(fs_info, ZONED))
 		return 0;
 
 	if (device->zone_info)
@@ -189,8 +276,20 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	if (!zone_info)
 		return -ENOMEM;
 
+	if (!bdev_is_zoned(bdev)) {
+		if (!fs_info->zone_size) {
+			ret = calculate_emulated_zone_size(fs_info);
+			if (ret)
+				goto out;
+		}
+
+		ASSERT(fs_info->zone_size);
+		zone_sectors = fs_info->zone_size >> SECTOR_SHIFT;
+	} else {
+		zone_sectors = bdev_zone_sectors(bdev);
+	}
+
 	nr_sectors = bdev->bd_part->nr_sects;
-	zone_sectors = bdev_zone_sectors(bdev);
 	/* Check if it's power of 2 (see is_power_of_2) */
 	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
 	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
@@ -296,12 +395,32 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 
 	device->zone_info = zone_info;
 
-	/* device->fs_info is not safe to use for printing messages */
-	btrfs_info_in_rcu(NULL,
-			"host-%s zoned block device %s, %u zones of %llu bytes",
-			bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
-			rcu_str_deref(device->name), zone_info->nr_zones,
-			zone_info->zone_size);
+	switch (bdev_zoned_model(bdev)) {
+	case BLK_ZONED_HM:
+		model = "host-managed zoned";
+		emulated = "";
+		break;
+	case BLK_ZONED_HA:
+		model = "host-aware zoned";
+		emulated = "";
+		break;
+	case BLK_ZONED_NONE:
+		model = "regular";
+		emulated = "emulated ";
+		break;
+	default:
+		/* Just in case */
+		btrfs_err_in_rcu(fs_info, "Unsupported zoned model %d on %s",
+				 bdev_zoned_model(bdev),
+				 rcu_str_deref(device->name));
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	btrfs_info_in_rcu(fs_info,
+		"%s block device %s, %u %szones of %llu bytes",
+		model, rcu_str_deref(device->name), zone_info->nr_zones,
+		emulated, zone_info->zone_size);
 
 	return 0;
 
@@ -348,7 +467,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
 	u64 max_zone_append_size = 0;
-	const bool incompat_zoned = btrfs_is_zoned(fs_info);
+	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
 	/* Count zoned devices */
@@ -359,9 +478,17 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 			continue;
 
 		model = bdev_zoned_model(device->bdev);
+		/*
+		 * A Host-Managed zoned device msut be used as a zoned
+		 * device. A Host-Aware zoned device and a non-zoned devices
+		 * can be treated as a zoned device, if ZONED flag is
+		 * enabled in the superblock.
+		 */
 		if (model == BLK_ZONED_HM ||
-		    (model == BLK_ZONED_HA && incompat_zoned)) {
-			struct btrfs_zoned_device_info *zone_info;
+		    (model == BLK_ZONED_HA && incompat_zoned) ||
+		    (model == BLK_ZONED_NONE && incompat_zoned)) {
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

