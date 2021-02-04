Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399D830F090
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbhBDKZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:25:09 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54296 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbhBDKYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434290; x=1643970290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tFmga0zpE5h/qEWiiRiqzeAesgg2CotIY9FERMsEfS4=;
  b=IYQC8RycgeYL8t4GDiceIoiaiN01iuAIR66cvvCXggwnZhfxAWOefcPd
   Jd3RGs/h366mkmhi56m4IQ7lbdG/Dsr0xjvKsCduAdM/GAlShn+T/71KK
   OGN9vkCVYI4fAWTghqboOT7J+Ro7P5NtqwqchZqi+XXK7PcFbU25s4EIz
   6h04/BYpE7o6/oPCwcQOiYlMFpRADChTH0Xgj0Guv1Uwz8PBKbo9oyuw5
   We2R12nuIsZrxPysfQUPlLBu1dfB3cmz8eYFIefEXDrutwlkRAi3m5Ijd
   ITlJaN+taJ4Hys6iWlO9wAckz0eAmcTE9RMNAAAVLM6Q85rvGns7dtEP3
   Q==;
IronPort-SDR: CoAuhkSH/4aTyy3OHPvKuKqPqICm1+CrMwznAN2w8RWNA7kcJyI7hDj6e1HxPSCWnDHWCqAJaB
 TL+1jgN03VIzi0UgIrgVZcEizSfpPcIVC9R/Zsmje6qzil9mh9+EdQ6bJx9w2VvL3DVM5wK9F4
 H+oLNgDKqGEaQfiI0Z6x9r/tLca7sUUhMrPvtMGzG79oTzWrUAcn/y0hi0WjybfQ5xe38vd+xW
 0sKE9wBdwZUDNPHMJvTv2cSt83lOPitaWlAHqUGMMov53xCsRRPFoyDBGA+YIpMBcypk3Gct24
 oNs=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107966"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:06 +0800
IronPort-SDR: Uh+YGsmEqh5Wi5FmiJVpXJM57BLx75D0sKhH/v8NOb35m10gI+L7SOoB58QrpY4asyLPgPFaeA
 dI4K+pp7j6yloXpe4PJcxPL0z8GKxnxYe/PZGL0gkpVsSpzsXwWwskXt0S7xRUhNu2wrHewad1
 HXc3R51iAKK7ZVEBiVe/X3ClkwtHa3Qks+qgKN2vqW5KbbpVDvwdpWxauor+0SWemQXHa7Nur+
 xSV09N7BBz2cR0QhLekFtswsS1ilMcUI0XRMAIaUcy1KCJ9nTwMHhDKzd6rPKFNZVhCJiUi/vX
 FwlwkcigcX4jXukMiEmeeUM8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:09 -0800
IronPort-SDR: USCrpSqdYH1k8E9FaArJdQklps9USrfOZsXHCY0fGUeF0gtuK+HPQu+RrfIwqpJdPP1qHP10to
 tnnvTIFYDxVFt+aFDmHA3ccrkFMg2qvzQaSOpWvM0N8nWcPi4R3nad4lRkljOddOOq7FCBV/Kh
 5MsrM6Phqgi0f3pB+YZt16RaUiFUxAxXNUtxgmblmlq7aAwnNzM6qROGuJ5+of+aZPIOz2zuiJ
 NrfR5T5a5fzxSHF6YQWqRemCoOfN3b3gN6PTu9uJvFuCvvx8OyKdJqEvkeKM02HXnaU8j+jm7/
 nws=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:05 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v15 08/42] btrfs: zoned: allow zoned filesystems on non-zoned block devices
Date:   Thu,  4 Feb 2021 19:21:47 +0900
Message-Id: <98cbd6adf3ad2c27f3b422c750cada92a2ebce74.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Run a zoned filesystem on non-zoned devices. This is done by "slicing up"
the block device into static sized chunks and fake a conventional zone on
each of them. The emulated zone size is determined from the size of device
extent.

This is mainly aimed at testing parts of zoned filesystems, i.e. the zoned
chunk allocator, on regular block devices.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zoned.c | 150 +++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/zoned.h |  14 +++--
 2 files changed, 148 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c0840412ccb6..6699f626a86e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -119,6 +119,36 @@ static inline u32 sb_zone_number(int shift, int mirror)
 	return 0;
 }
 
+/*
+ * Emulate blkdev_report_zones() for a non-zoned device. It slices up the block
+ * device into static sized chunks and fake a conventional zone on each of
+ * them.
+ */
+static int emulate_report_zones(struct btrfs_device *device, u64 pos,
+				struct blk_zone *zones, unsigned int nr_zones)
+{
+	const sector_t zone_sectors = device->fs_info->zone_size >> SECTOR_SHIFT;
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
@@ -127,6 +157,12 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
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
@@ -143,6 +179,50 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	return 0;
 }
 
+/* The emulated zone size is determined from the size of device extent */
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
@@ -170,6 +250,7 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 
 int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
+	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_zoned_device_info *zone_info = NULL;
 	struct block_device *bdev = device->bdev;
 	struct request_queue *queue = bdev_get_queue(bdev);
@@ -178,9 +259,14 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	struct blk_zone *zones = NULL;
 	unsigned int i, nreported = 0, nr_zones;
 	unsigned int zone_sectors;
+	char *model, *emulated;
 	int ret;
 
-	if (!bdev_is_zoned(bdev))
+	/*
+	 * Cannot use btrfs_is_zoned here, since fs_info::zone_size might not
+	 * yet be set.
+	 */
+	if (!btrfs_fs_incompat(fs_info, ZONED))
 		return 0;
 
 	if (device->zone_info)
@@ -190,8 +276,20 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
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
@@ -297,20 +395,42 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 
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
+		btrfs_err_in_rcu(fs_info, "zoned: unsupported model %d on %s",
+				 bdev_zoned_model(bdev),
+				 rcu_str_deref(device->name));
+		ret = -EOPNOTSUPP;
+		goto out_free_zone_info;
+	}
+
+	btrfs_info_in_rcu(fs_info,
+		"%s block device %s, %u %szones of %llu bytes",
+		model, rcu_str_deref(device->name), zone_info->nr_zones,
+		emulated, zone_info->zone_size);
 
 	return 0;
 
 out:
 	kfree(zones);
+out_free_zone_info:
 	bitmap_free(zone_info->empty_zones);
 	bitmap_free(zone_info->seq_zones);
 	kfree(zone_info);
+	device->zone_info = NULL;
 
 	return ret;
 }
@@ -349,7 +469,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
 	u64 max_zone_append_size = 0;
-	const bool incompat_zoned = btrfs_is_zoned(fs_info);
+	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
 	/* Count zoned devices */
@@ -360,9 +480,17 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 			continue;
 
 		model = bdev_zoned_model(device->bdev);
+		/*
+		 * A Host-Managed zoned device must be used as a zoned device.
+		 * A Host-Aware zoned device and a non-zoned devices can be
+		 * treated as a zoned device, if ZONED flag is enabled in the
+		 * superblock.
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
index eb47b7ad9ab1..5e78786bb723 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -142,12 +142,16 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device, u64 p
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
+		 * We can allow a regular device on a zoned filesystem, because
+		 * we will emulate the zoned capabilities.
+		 */
+		if (!bdev_is_zoned(bdev))
+			return true;
+
+		return fs_info->zone_size ==
+			(bdev_zone_sectors(bdev) << SECTOR_SHIFT);
 	}
 
 	/* Do not allow Host Manged zoned device */
-- 
2.30.0

