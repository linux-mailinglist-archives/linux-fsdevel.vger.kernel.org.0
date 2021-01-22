Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D92FFC92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAVGYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:24:52 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51138 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbhAVGY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296666; x=1642832666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IZc0+r8npoIstl8ljv31Fz95D/F869EXL1bGj1X3uSU=;
  b=HlQDvoZDPUA61b4uZ+YQpj/9iGTqUBlgl35ENRR45tHs4giFYMhYRgMq
   F/Vgbdvjms2+YsOIqAOIYZ+Tg1rcCB6F1YvW4S7FYFAZqxeEezjW6pQMM
   UYD41GDxubnW+b//0DK1F2w3/mqZJdDPC7aCxBoSBbCiP23hKYRGUBWK7
   jtiBVD2Ck1C8OGdyngN9IdZ00HL98c6qhwD/SFbeUFmm25lHYTpDiRb82
   tLJyfXBhUw+1Q7U8tCjoWVMDNKCfHGWsmaD3jmVagcQtl+4u+9tVZ1g8i
   8L5Js7lAceMNvjbclWvoNN+/ttvDJAJxyiumFln/Di7Nf7CzYB9HhmpST
   g==;
IronPort-SDR: Z08ArFfBs1bFCQsC13SOAD2ioctf//20scq0C1Ao7IFPKtakoL37sOb0xgrUtd1jFvsUchfc/z
 l0kJaRL8I36wex1OqRbtTvrxFCfOrnaDGYL2fFxFFNg2i381jHS9yOy9GEbz9zQYzYKYT3Ll90
 8UZ7buw2CMAR9lH+u+Kg/vJvw7FM3ZhPYJ7W5Oh2Fb/CPdIYfHZP/LKsOlB9aBoJ/5Wp2CkaZg
 vnzISRE6UNdJ1ajHQczE+uqfG4o5+o7YUOQ12DeWx8nFWulZJAuCAA7EtheSJsTKRz2fyUUOPN
 FSI=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391959"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:34 +0800
IronPort-SDR: UTcY3X+D9EVsthE3XLrvDLpj12LqHYcdZsa/Aq41VGl+utFSzUGppv9Y+yAlPMTDmOzNb/d/4I
 1R/K2uP7G3eOGyJExMX4/E4jnxNk34v8+pUC2RG3cbp3ErESGW/yobI+Vq0D+ltKEx3OuDcmlu
 ckoINWeaaJaR8fSFPd8qz4TC917bZUstAze8DWn5vCNtlBvuZwsrlvtERvQnNnxaByZTxyZ9hP
 yHqcLCfbuvvAQNWpEGSKqBYGayusUsIAsirv/+Y8YJr5pRdd5gRIae+SvKwEAs1JU9gvHnrnPo
 xDFY8OPVg/T2F2so776XVowh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:05 -0800
IronPort-SDR: rbAJHKlsOHdgiYrVPIbsH3pXI8KnSrNgFGHqMYUdNt2IKmaqsdSFBgt7oh5F3XaqZV4YcjIcgz
 EctqaRpjLQboQntrZWr4OCXvlakZT36uqFVkjG9eHskId2ZMl2QA+QZrIYqVwuoj6FqSy4laNB
 A7M45mPgDcH9DV907InKPcQjAqMRvhAq+U7MnJdZLRuOgdxJkjhS/hQiNNa5fALgyJ7SAYpN6B
 2Z8SY7W2wuhVnO7g8zoLJh34KhfRxUYzSfWM4E9MqHAsCtOTC254sLiFp20J8ApSZibnhwgprG
 1Lc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:32 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v13 08/42] btrfs: allow zoned mode on non-zoned block devices
Date:   Fri, 22 Jan 2021 15:21:08 +0900
Message-Id: <6764c8d232325868e47ded876af398053e674f50.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index 315cd5189781..f0af88d497c7 100644
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
+	sector_t bdev_size = bdev_nr_sectors(device->bdev);
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
 	nr_sectors = bdev_nr_sectors(bdev);
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

