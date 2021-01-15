Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAEF2F7313
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbhAOG4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:56:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41699 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693808; x=1642229808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aXSuJwRCq0uscBpyggSda8v7fGwcH4DQGS83dCwzua8=;
  b=gpyl1YiY/GuN2mk33fC7qH/2+6eCBxpMrd+derbEXZz8yQgFo3wziX9b
   2Rnzy6w+BJAXW3Y5e9H3qX8jmUe6n/1Z6nB1nkNdiZCbWxGXcslYcFYI5
   ggjIficjLFMsqhqA2xFUU9j+Gv8+YISB5qwzdqXp7sDN2UXInRzUA/OLs
   A4GU6h2SjiZN40kK2ZkV7ULds9VkVCj1+wx7NlHR+QYn2fEjhXYURM8OH
   06HwdVPCIxizCo1agrRGjSKMP2nWzzFjWtBfE00jNC0l03ANDzi927msv
   4LAbbVzmFU7qGZ8HwW+3+xyN/BNW/bmxO5wSFppgH988e5yuIFEipPam8
   w==;
IronPort-SDR: rA3zN/Q1rRnkyz87pObJlPXlGX3KsBVjvlNlBxS4T/89J4MkQd2PxC3h7qTwDsVTZB+bElqPk1
 NLx8cyaQa1x8QAVfiePBK7Muw3qt6jn8JlovV0UR0qaNVYMiM8c9RMbo1shZMscPgtf13RcOWO
 skyA0lUlp9Xueb4CZFlMRvQ3/s9lwzK14CV+uuPAEKSh641gRplJboHzTH1BfKSELuOVeUO3VT
 A2wHStVt2r0nzmh2Vk947B+pAzilpPyw3K471EGbP2c8PewyTtDHpclqlEcB077ioHqN0XVKty
 p50=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928184"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:09 +0800
IronPort-SDR: vn+3Qx6k+eBbK5JLdTZrRWxo60HZYKNDkX4Rf4SWz2NT+fZ3EU87QRnU78uslxsyzF7lnWgG5Y
 Pnl4WbMkgbxWi9VekT0DlatpL9HEkVah5DigdNHIvbZFwOolWTRd0n5F8kQFxfkouLkUoQppL2
 bcY6GZMEMAxLvlc3smJ6t2Q8Jun/oPfzeEVgsQUY7S8KDGbGJ0HDx6e0drKZrs0ebdg8VAP5up
 18sKZThFPZ/OR3yM3YXxt+znp8BMtiDAN2Be75UQIewC88/BaGWfS2mtXDgZrLdAcU73aYjY6F
 yHE5Ue+1aQBxcJzUZ3JjUWw+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:39:52 -0800
IronPort-SDR: KrSOCqq5unLTwrd1eZeAX/v6KW/R6dhfHqCtqwAOwepTSIqVf6z/3xhnvHv5ADx/5sQYtKTIJG
 EP7FCnIvBTxudQ+JISO1SeAEZ1686JZSrXbpk8xD7OiQVL5HfMF+AGUY4z2yRaCqCKl/aiNvwk
 jbWlu1h/6YxyQFkVjAd6v78ZDAhndI9ywCQ3VwH5hSlJb49Agus9Pho57YnwtEy+bjQ4izxYp2
 dgZ27iPPV4qbwfspsZyZ8sRjST9vkX4e0GOgoCUz5UeTVlxl9RJq4jC2Ehi8fZrQLeECZrHK4p
 utU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:08 -0800
Received: (nullmailer pid 1916424 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 03/41] btrfs: defer loading zone info after opening trees
Date:   Fri, 15 Jan 2021 15:53:06 +0900
Message-Id: <b9dda9745b20e6a38a652f635967370e901e156b.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is preparation patch to implement zone emulation on a regular device.

To emulate zoned mode on a regular (non-zoned) device, we need to decide an
emulating zone size. Instead of making it compile-time static value, we'll
make it configurable at mkfs time. Since we have one zone == one device
extent restriction, we can determine the emulated zone size from the size
of a device extent. We can extend btrfs_get_dev_zone_info() to show a
regular device filled with conventional zones once the zone size is
decided.

The current call site of btrfs_get_dev_zone_info() during the mount process
is earlier than reading the trees, so we can't slice a regular device to
conventional zones. This patch defers the loading of zone info to
open_ctree() to load the emulated zone size from a device extent.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 13 +++++++++++++
 fs/btrfs/volumes.c |  4 ----
 fs/btrfs/zoned.c   | 24 ++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  7 +++++++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 948661554db4..e7b451d30ae2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3257,6 +3257,19 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (ret)
 		goto fail_tree_roots;
 
+	/*
+	 * Get zone type information of zoned block devices. This will also
+	 * handle emulation of the zoned mode for btrfs if a regular device has
+	 * the zoned incompat feature flag set.
+	 */
+	ret = btrfs_get_dev_zone_info_all_devices(fs_info);
+	if (ret) {
+		btrfs_err(fs_info,
+			  "failed to read device zone info: %d",
+			  ret);
+		goto fail_block_groups;
+	}
+
 	/*
 	 * If we have a uuid root and we're not being told to rescan we need to
 	 * check the generation here so we can set the
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2c0aa03b6437..7d92b11ea603 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -669,10 +669,6 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	device->mode = flags;
 
-	ret = btrfs_get_dev_zone_info(device);
-	if (ret != 0)
-		goto error_free_page;
-
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 155545180046..90b8d1d5369f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -143,6 +143,30 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	return 0;
 }
 
+int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	int ret = 0;
+
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return 0;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		/* We can skip reading of zone info for missing devices */
+		if (!device->bdev)
+			continue;
+
+		ret = btrfs_get_dev_zone_info(device);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	return ret;
+}
+
 int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
 	struct btrfs_zoned_device_info *zone_info = NULL;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 8abe2f83272b..5e0e7de84a82 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -25,6 +25,7 @@ struct btrfs_zoned_device_info {
 #ifdef CONFIG_BLK_DEV_ZONED
 int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
+int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info);
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
@@ -42,6 +43,12 @@ static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 	return 0;
 }
 
+static inline int btrfs_get_dev_zone_info_all_devices(
+	struct btrfs_fs_info *fs_info)
+{
+	return 0;
+}
+
 static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
 	return 0;
-- 
2.27.0

