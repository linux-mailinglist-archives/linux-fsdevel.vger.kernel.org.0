Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA243034CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbhAZF2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:28:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33029 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbhAZC34 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628195; x=1643164195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jKNkW9XEzouK44pSW6LvjnQUz0h9XmFJeiwLvA02EHE=;
  b=VqhpNIiDMOFHeOenF0i5dfguqPBzayYzY+7R4oX3JfUHw6ISiSxenydm
   54SEdxZTWjhDnplc64z1Gna9OLD2v8AMLS0YL+ACPE/e3RuOyUmZxakMv
   uAO1LCOYavSYBOd07U9pZqvyMNLVN7pmv7eeaJWggL2qCqef6HSilNaPk
   0mGhvCCLFCxMIVLUyhe0+tW0/TcpQTnlmn/yVztDcAMqXuv+7JAxYfmtS
   fPy9P7B6UsGNLYBgbA9Ila+My7xUa/ug8hkB1qZFEL8EMbMwlQ6HYDV1g
   YbLqVBU5agcWa+lA+G84S21TTlGR0YN7UjyuHMbD7J9M2l89noRVM409V
   w==;
IronPort-SDR: a5ZtxcUbqS4h26SNSaQStjn9dO7Xu3DVZksfVMK+Fv4qiCwL+GNnswcI1V3RtVkn8EEkHambwz
 kgGOtxZjAYK4hcCprroMYS06fSxgXo8IU6gJdXnb4WGoSLSq4ZwiPknElrZ3xznrY+N4fG6TTM
 Q8y+aD9SLc1rFOMQcek/xqCFrjkjZoYwfAd6WRlBW0+qBJ6p8mFy12qLQFHBK2wfut8ikPiq5N
 UrxK4ndJWSbcGhObSmlu+cwAu0IIeH51WYgZ37JsnR9fRAuRy2IcwOwL1ohPpk2G+FLd9fd6Z9
 3NE=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483520"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:13 +0800
IronPort-SDR: gtv84v1IhAUSerLqjrPL2eyTbK59nEr9L9qPjU16pYGI67UV0eAFik3bRBiecx+v9HcwNufAZn
 H49HTY5U+QCAY27ZhzX4E1dAn2NrmrSSfBj4VtWph4AufCFKZFLj3kun3XsO4N6HxcE8tVvoY5
 meB32rJepqSGuV3/D40a1uRB9UbFCBChPXvSiG/cmRDCEchu8div2XH6HnxqT3vnTMSi60eBTM
 +M3Jqox598dqBFBp7C+kD0t6YRRRX8702KvTyix04DUsQ5VYMJoOoBxA8a+e3IbcmV0bQSqI/4
 yONOIGltGV0V9wFn7Z+T7HMM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:39 -0800
IronPort-SDR: 9DaBX38BzwfZzaVrmDmJOCFKKq1HG9U8KZWQHgIfsPOMqfgPojgNR3muFLksBF/jxFsPTO9rdE
 sRYb1A4wW9aB6Hj2kSEhqh9hXud9Qm7jHcge7pzPlm6C0WE+pCfNUq6VBJzPbP+j/wrSjGAYs5
 OlpmFNCS/SS4Hp27CINWYWCefD800jorP1JwogeV7NGBbGpdF23ZH6336cYTzcEPDfsB1+WnaP
 NwGOIPmYpDAdP+DlLYCQ8UKcJoNFjQsRNCM3i20vyrFnGPx14Kl6mHR6mKx3oL6NOF5pYyXTSR
 mt8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:11 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 08/42] btrfs: allow zoned mode on non-zoned block devices
Date:   Tue, 26 Jan 2021 11:24:46 +0900
Message-Id: <613da3120ca06ebf470352dbebcbdaa19bf57926.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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

