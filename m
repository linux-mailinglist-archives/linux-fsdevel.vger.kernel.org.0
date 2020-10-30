Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0282A06D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgJ3Nwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21974 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbgJ3Nwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065949; x=1635601949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4lXJv40Js6CZywmL+mY9WqZg+ls07sZV5lUWPt6av68=;
  b=YDF9EAzD11NJtusT3SBhamRvXthMR2dM3rHIcKpEG/cR2kmTqLZf6NvB
   XkEDHZLLR77q5FRl2pykWWSuCQU9diMh08yeKpLECe68+GUX+ZUgNP74n
   LwwcCnhdKqo2db9JOsPu1bj/p1d7toz7E+f3+Oldrhzp9iZpvZ+v4nLgd
   V0ci5xVEKpHSL6DynW5Tl5cnE0CFXD6qIlbKNqZ8yBkSYNSnXKKHbbmia
   Lg2YoQUTzw+YTY/vOM1Afw5PxmXJ7bF4OLzU2YxY6PRU/JlVjUwFmoS9O
   Tuj+krrdzw0uyP1GdC3JBtoZWl/sGi048FCJwF9yhJ/vDuxiETCXjT6C8
   g==;
IronPort-SDR: FyNClQtPW/YZjkQkeE7lTqFZcQdiNiJ0wPzA7luFOfERWwtIeRKoOMpsYJSMItwWjmrpyVGd6E
 P/2VQhr/exh/hqORaZGZs+V+0Z5sJaHxBPGdK6kWoRvGCViqJD3GqqxUy78a/jKZ2DbczydOZz
 Lg+XJaovic6ZWykymBm0XKfH+TGYSa1w42Xx+hGslarYmjJr6gJ5Qno03d3P1GtGoqBH0BU+7B
 bq7xEDLJVKdd8jaKn4SQ41RCeTj42A8+9uFJvuD0qbwNJuk0+lF0yuV0BlImIH52ZjeFr56sBz
 z84=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806585"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:29 +0800
IronPort-SDR: b4NwO3gUevv6r18gFAK5D1z0jMyCvAIzopyigk/SGcrJ/Ukwd9GXDYwprw5cjDZCJHwBxNnSu7
 dABps7jse1js4l6b6oD1bMmcYDAP1OQOhFlcrY2V+m3jA35KaFnDFSh5OtrVsdlySyZbamJADN
 zOw6SIaVV9ZKW7mZRbCCaQvVY4Tz1sTLZ1hJHXROikHxO9h4itkI4bVfw7gTfrD0Bl6uaZM9+L
 uHyv9yNNyqs7d7TEArUL1MsseKr8SlrCDECXV4DtdFdC+wuXjMtVB6OE88JkPKs8xnjR/9c6xQ
 VKbN/uwoGtLddsOd/FOm7ALm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:43 -0700
IronPort-SDR: 0QZF/sk+/ZaVc55OKKi7/mal2c9HOagu7TduW1ooqNxnq3vlZdbRULJh3HiWaghftMQ7Vgw9TU
 erVxgItRTbizOPO25mn74NTUM5783vkor2vZuSAdxUlTb8o0mjngTqG9HFXnuStlztovMUOWoV
 3sVdKtBntNnRFgGYMZE2MF7n4Fov9dsgSI90w/OuxW2qWOsQsP4kFm9oockq7Vj/MSZMCWAINa
 s6gAqLr0M0tlet9z7J2CqbjhIfwj2onIrdUjClpMybRQOGB1gxdVvODhYub2/nMpusR7AJpfI5
 P8o=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:28 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 06/41] btrfs: introduce max_zone_append_size
Date:   Fri, 30 Oct 2020 22:51:13 +0900
Message-Id: <066af35477cd9dd3a096128df4aef3b583e93f52.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The zone append write command has a maximum IO size restriction it
accepts. This is because a zone append write command cannot be split, as
we ask the device to place the data into a specific target zone and the
device responds with the actual written location of the data.

Introduce max_zone_append_size to zone_info and fs_info to track the
value, so we can limit all I/O to a zoned block device that we want to
write using the zone append command to the device's limits.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/zoned.c | 19 ++++++++++++++++---
 fs/btrfs/zoned.h |  1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 25fd4e97dd2a..383c83a1f5b5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -953,6 +953,8 @@ struct btrfs_fs_info {
 		u64 zone_size;
 		u64 zoned;
 	};
+	/* max size to emit ZONE_APPEND write command */
+	u64 max_zone_append_size;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e1cdff5af3a3..1b42e13b8227 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -47,6 +47,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
 	struct btrfs_zoned_device_info *zone_info = NULL;
 	struct block_device *bdev = device->bdev;
+	struct request_queue *q = bdev_get_queue(bdev);
 	sector_t nr_sectors = bdev->bd_part->nr_sects;
 	sector_t sector = 0;
 	struct blk_zone *zones = NULL;
@@ -70,6 +71,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	ASSERT(is_power_of_2(zone_sectors));
 	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
+	zone_info->max_zone_append_size =
+		(u64)queue_max_zone_append_sectors(q) << SECTOR_SHIFT;
 	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
@@ -182,7 +185,8 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 hmzoned_devices = 0;
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
-	int incompat_zoned = btrfs_is_zoned(fs_info);
+	u64 max_zone_append_size = 0;
+	bool incompat_zoned = btrfs_is_zoned(fs_info);
 	int ret = 0;
 
 	/* Count zoned devices */
@@ -195,15 +199,23 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		model = bdev_zoned_model(device->bdev);
 		if (model == BLK_ZONED_HM ||
 		    (model == BLK_ZONED_HA && incompat_zoned)) {
+			struct btrfs_zoned_device_info *zone_info =
+				device->zone_info;
+
 			hmzoned_devices++;
 			if (!zone_size) {
-				zone_size = device->zone_info->zone_size;
-			} else if (device->zone_info->zone_size != zone_size) {
+				zone_size = zone_info->zone_size;
+			} else if (zone_info->zone_size != zone_size) {
 				btrfs_err(fs_info,
 					  "Zoned block devices must have equal zone sizes");
 				ret = -EINVAL;
 				goto out;
 			}
+			if (!max_zone_append_size ||
+			    (zone_info->max_zone_append_size &&
+			     zone_info->max_zone_append_size < max_zone_append_size))
+				max_zone_append_size =
+					zone_info->max_zone_append_size;
 		}
 		nr_devices++;
 	}
@@ -246,6 +258,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
+	fs_info->max_zone_append_size = max_zone_append_size;
 
 	btrfs_info(fs_info, "ZONED mode enabled, zone size %llu B",
 		   fs_info->zone_size);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index c4c63c4294f2..a63f6177f9ee 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -12,6 +12,7 @@ struct btrfs_zoned_device_info {
 	 */
 	u64 zone_size;
 	u8  zone_size_shift;
+	u64 max_zone_append_size;
 	u32 nr_zones;
 	unsigned long *seq_zones;
 	unsigned long *empty_zones;
-- 
2.27.0

