Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDFF304984
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbhAZF1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:27:48 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38250 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbhAZC1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628062; x=1643164062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8PFG3Diie06Y2nM5+Pb7vgzC9jKX3Ev6iZz/zowzC8=;
  b=Ojhq2rt7TkWrMDZlqqbmLmydalhLLLzbrfm+cZC9GStIM/d7Ho1GzTtg
   5qocebYNhXDRHz10wsM5weH0SYnLlxQwph+hSTTRH2t7oPFr369ICgrVb
   ijvJmIfGUAjhd/NX0yYSuJ1633ZZ9cROllR8oh9+ZTRLpKRFkJlmZi18i
   7yaEnm+a0b0q/gA1ORacTp6UHercfvOReilVHqcpXSzuDXeXgdKzYM3ax
   dUv5pJLeA0sGDh34yfXfedzEuehV64Ki+SiL6/4pcUd4AXK7qT1VwC9TW
   SW3y95MqHeZ+9pMxNXN0NKro7nD02uFXGA73KBsJvaSTmGEqMz+ulSb+i
   g==;
IronPort-SDR: lsw/RpoY+Og1AYFDO2vQAIJ6x/UUa4N+WxcTmlqTIEWPKJ+Tnb4Ji26zVkiemhHL64rZEITy16
 z8E23cKpBjowUUL1gehIJNgw0yt80B9WK1sUaVzW1QrCwKTibbVNUUGU0HrwdvUmgUVU6LtoUq
 FylkgTiCYwftIjbkRkenU70YV5fELfVapAUHHuFjg/WNhFrbnhE/avSyFs8chTbTzkbTbLTGm7
 eyXcJLSpGZs+WvX2bzCsxemMT22quL+lP1UqL70+4pULqPrHN6xX20tiMrRURtag98gFZNV6GQ
 JCU=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483502"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:04 +0800
IronPort-SDR: Nq+72Ti/JXAMvJ+15nYOcpYgUgnWYT0rnJY4k9NJa1g9We/Dm9Np8kctCVhuaCkX8voegpLpIE
 uGxHCftCyH6ziZxF8zsDhHJVSCWGYQ3FFm5hiUhUNoD20Fe72qZY3wwfCEyFOhcW8rxiXwjEMb
 Hewjq/0OyrMGBHZxv1B7BcYANnXJABBXfKwyirYGhNXsdD24MwURTOOD2OimMAhp40LogRQkGu
 O+NaMjQFyHri6Kf73OsoFWmYVIkqlaVwdzBBZFUmfELz5CG5fuPx0e3UjSd5Jz4+3lxHAKHodA
 XYnl38rcKCHGDwx1rW1ok6IE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:31 -0800
IronPort-SDR: rDrtun07R3GdynqfAyO+viUrPAJg8nAlh2+MkkpTtcHGBggLcTHmw50M9T/gRRnbTF1wwOqIwo
 gw268IU1AURbVAxcmL8fuC+AFWB+lnR1R41dVJIdJx3T4WYpgUiV730GIhQz4f4+kY9qZA82hS
 r5Un9bE70NoebBbI6ep9FnGrGG/dsWGO8AwaDnC+V1e6z5yDiTbuRhYbywNt+j7IJn+bKAUZhj
 1xqhjGlpWYPyqHvlRlRBNeD3kOmc9ODgjpj+VAlEH6Yc2ISCiUL8+V76x4G+mMjL4i1u6rmdMZ
 LeQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:02 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 03/42] btrfs: defer loading zone info after opening trees
Date:   Tue, 26 Jan 2021 11:24:41 +0900
Message-Id: <d995c6d145d65b93fc1be56d5c5dfab869f50911.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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

