Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1992FFC87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbhAVGYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:24:06 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51100 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbhAVGYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296642; x=1642832642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8PFG3Diie06Y2nM5+Pb7vgzC9jKX3Ev6iZz/zowzC8=;
  b=p6DyVdOBewDyYOsvxS1dP1D3bkVatYN+Vt95AdEzWm8MHLLj5EXfcSK0
   8tvxXP/g8aeNbZTz5fM2A7zjhgFF/oEUU8eKSm9f9wqzBs0kuH7JAL+oN
   CypJEUM9itPI1cnH+0HlCnjrLFg86wv6s7uAR6p0gmyJJ3Yqs05rLGEDL
   svm35XFcsjpbDCNKA7OqKBX6ex0pyXbmRwbc1KhL7eDli07SUMNWT3dkT
   YUp5eoaGwYCBpqLW6Lj3XjjcgpxMC+sNpZaFx2M947RPfIv1CCxFto4QX
   VXWGzfP+Wg6OkgL4xQdgoYhUWPIm1+4dsY25docMyPaTQCiRcVic2j+3L
   Q==;
IronPort-SDR: /VugOEtwZpT1qQlCR4AtQDu72sXUEeg1yKGm5tYSUW2gXm2Z/HwV7NW42rl3TpohZIDSq02rOQ
 RkALELQE1dTCZDWsTQ0Iguuc0Ah8S6XelPTu9fORT625VkmVxzfmJMz3qQFRmd/EoykgqN/VDA
 Bfgd8ww/vDZ4DG2JFgjR+3ANqEH8VJiqOUta/WOJNQB8VbIY81BxhebK4qkDNr9XpbOcdum71W
 SOjD4nfTfq1QjjkzzT+bsvP1BqnXgD1Fy5bH4gMjVC5c307lxlJIDUE+xPash5n6asY7XkYC0g
 cyM=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391930"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:26 +0800
IronPort-SDR: VgaYJaJj80H8TIsJGjdzUtAP/BNwExgAEc3J1jNFh6cmZCLsi37QTmhk9nJOH74Cu516h1awgA
 1zf05AhxebznRe2d0UFp7F/wHUmYlKQNjZzI7CUgcqRfTK51+uTaW3VuKFRVtz2VSBb1ZsTiDS
 4KhYBQq6UAppKO4KblbX8H1Z/tc8NeykDnAqE85PqQILW9GdPb7Gk8VFvJrkMag7uNKA4otoGm
 t7xUYaQs4c2mqyvt5sT7Jcpkve6T/GeQB76VfanwUuE/lkLCHS6sykoKaOZTyPicjWFCuLFvNK
 CPkF9GAZjau9Dw15LqxN7dey
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:04:57 -0800
IronPort-SDR: vGAsk6CPFqXXaa+ws/f/0hx7GaMoS+W56abJrEPNamrzQXHrUgngAdP0LUBOGpGqu+ijFVenpo
 K42ZBpOevmTelGMQZOhqXoTVWDduomA1/RDNx1JHmH8XmGADNd0smPGLp3Mz6VjsSCG35Xn9WA
 x4wQIaK6LyREpMC+a4zL1HwQoLQJdY98aZy4N9XJ0FfWhYC0G0Y91cCKRRwjqekct1ltlLEja9
 z5r+lkbFDyShndzjmjqovS7kk4b09/FetkSS+bVcBGs00Rhgp9vlqJbBHxHOrEf9colTVKOUYL
 aZ8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 03/42] btrfs: defer loading zone info after opening trees
Date:   Fri, 22 Jan 2021 15:21:03 +0900
Message-Id: <6863be2df7ec31c8a8266342c5b7e4bfb8c8a5b7.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index 5473bed6a7e8..39cbe10a81b6 100644
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
index badb972919eb..bb3f341f6a22 100644
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
index c38846659019..bcabdb2c97f1 100644
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

