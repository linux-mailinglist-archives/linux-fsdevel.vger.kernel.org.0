Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C992F7322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbhAOG5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:57:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41699 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693849; x=1642229849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+sm/fN9W8fQlbkokpHeAJyDbUy6ZvDK+xuK+VUwTBA0=;
  b=TeIyyU93r1kARo04fflPwawdW4N/o+5s2PfDtU9I/g31vEe2cmLBtrcy
   tN+7FVaTqQp/CQ4SMg9IuAO/jjdTdT+1Jwj48WM1L5hs3XBplYpAqtqEL
   xvcUsymYbFkw35Osn96Ompsf8Pf1MT0d8dJuIMhrNc5SN3eYOui00y5aD
   4JGpWvHCGF9c556IuKcV9e8PokKIPmVC3dSsQ8VLezLcNqrl9K29ZykFu
   f6STl5gXyJ7t2DPVus0PpYQOrUuDw6Sixw93WZEPINKysqly9aYGOLDfw
   bnyJGBVlYgsJmYEPvwJAIs3D4EAl9z4DQqjci7e9UBAKciYqJp9L7jLm0
   g==;
IronPort-SDR: kxZ+lnk7gxkWp5RM/Z0f9inHXqEWK3uYU+BfpskStmhWdApkPaIMnUN/A6d9ZKvSkXOCE53UDi
 fmEzx5VDdWhHufigGpatPzkS0gD5qHsW3xfNabyvHzxkz+Vjv+1R697FmELxacx5KQTvTSnCJs
 mLPClhR3nNoaDTEXKRmJUav6cQX9bVQdyFtlGA9L28KfGT2xwJIjikl1qQP6M+BMXGdcxpsGVh
 efgC2OMrrVwMrUvHjnaXICv7FlXhPa4MXopJFwHh0t8noBOAXJHkO+SPKFOLOWqMs3VzLZBTTM
 Zw0=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928211"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:21 +0800
IronPort-SDR: dYqUbAChu9yXpnhhPd65RKTh0i3D2GoPT3yVNGEj6OyfvmtynXfhTMDTFxsExomoyFxgLTwYGS
 K89cEXTXePlEEOZQ5a3ntlDD+KC9SObjvhYNvn2F/AScQM9t0Yy9mEPr6Y3WYrZT48KnsDLXIo
 0HBd2CAeXTAvrWmWRyVm8/vNR11osoIsAFQax7V4Y6j1U85KdoDXx5unnrXapTs9wye3Il9URK
 D9c1dRwtaqUg4PKZALaqCSpxrHA2egcklNMeQcYM+cCj/ymfm4WutiKjQQ/Eps095dCMa6wW8/
 2/hRFD0kNMpPJszoFg2zf1LL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:03 -0800
IronPort-SDR: yAVdE8XbQlbDTyISudm+I4aKhRhJFH7RIbkfOZOe+shlY+Zkfx6bv81AHEJDPW61LAGEwuTRvM
 YqzNs4KHfkdGYHwQ8yg8voaD9l3ZUBYbDPgxtqrrUgsWuMqCjqY/WtJgupJAVVA5NiAwQqBsJw
 87yF0qYe8BBUcDPMHdLE8kk7u3eIZHzBo9tXJ3uZXhl0znbrRfNqpOn6nMoYCb+20lBeXNRaVc
 xR19guF8xYrqqMKS2HcDmp6q8p+b2wynLW7UdLIBJG7FKfmEWoRwxySOBZt0VhXJnZ/owpUju3
 qI4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:19 -0800
Received: (nullmailer pid 1916436 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v12 08/41] btrfs: emulated zoned mode on non-zoned devices
Date:   Fri, 15 Jan 2021 15:53:12 +0900
Message-Id: <20210115065502.1911839-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 139 +++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/zoned.h |  14 +++--
 2 files changed, 137 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 684dad749a8c..23ecf1cd3490 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -119,14 +119,48 @@ static inline u32 sb_zone_number(int shift, int mirror)
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
 	int ret;
 
+	ASSERT(btrfs_is_zoned(device->fs_info));
+
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
@@ -143,6 +177,49 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
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
@@ -169,6 +246,7 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
 
 int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
+	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_zoned_device_info *zone_info = NULL;
 	struct block_device *bdev = device->bdev;
 	struct request_queue *queue = bdev_get_queue(bdev);
@@ -177,9 +255,14 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
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
@@ -189,8 +272,20 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
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
@@ -296,12 +391,32 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 
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
 
@@ -348,7 +463,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
 	u64 max_zone_append_size = 0;
-	const bool incompat_zoned = btrfs_is_zoned(fs_info);
+	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
 	/* Count zoned devices */
@@ -360,8 +475,10 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 
 		model = bdev_zoned_model(device->bdev);
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

