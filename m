Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2830F083
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhBDKYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:24:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54276 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhBDKYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434271; x=1643970271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=16Cyxz0AewxnSVyea76nd8i6lD1C3tgvgP+EVto14sQ=;
  b=GN02HbXTdhTmeHKkamwO04dKQI/FmALwtOveS0bSIS1BH3eyGNyIPAWS
   7SIKAC3tcisYoYqPCxDHLvuLQAOC0UPSj7mopFZOPzQ0FPcJJFhMUxVvw
   4KX7lx6+PSWWuY2KY0TsiTmN4hSOxx6DR+6jQSFjjICeHHyIdhGT1Hdhr
   izisqUg4qx9FxcJMAEMTckTBKRKFQaMMIpXVWIkYf+R9USmxIZJurqsYE
   sOetO4sTxUh9ClJHioNNaNbHfr0WSvjn+cTo+nb5PcwWEP15S7GgW5SWK
   WR72hxqKulzylQqryR+DQftyR65QZ5yMFCV8GOXBhE6dkumbRiuFnlB0w
   w==;
IronPort-SDR: X+2pVH0DNMWWkv5xe3H3vanlaPFZNw2XVmLNPCO/Ng4ZFwx2356TpU4pkiG6SOoDmOW2eMUQ8A
 Quzow44D5x4DzdFvA0AlAnhi2gvjP1na3FWfRkkRXrxaly44UdYMqkhILcy4acvhzcy7WQ/3OH
 wkltbjtQLeTctT1tAku5dXhF3RfGQ0uJFFaDFsig78nLWB+eROOOqOK/R+bUz3/sfYxp/0bUAX
 UHCokMhTFrUzPlFQrGXg7L6KpdgMxxp9Vw8hJENMJeeT/XRh7anMexuLQFophulrkWWY2aniCL
 bGg=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107949"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:22:58 +0800
IronPort-SDR: LpktwMOtvWI1mA3ziM0iACWr7HesnH1+HDkVXLyvDxIu1LBIDFl2a88AA6j3DOWjEso4hjmjcn
 k+bE6MQSWTXaxXoTgq/U8vtUY0gMjff95QZQReF57cal/iDmyE/MFaQWavyDdCXGGvuTtYN3AR
 xpq2hkIvOFsTPiYE1sMKgTQX0JGHr8hYNi45+8EE9P8TGrNqkkiIcunsUlJ11hMGVP/v3SQ0MJ
 x8vQ7ufpcup3qS+4OFuwGWsOU/89rXlhsC57X0vRijJ5mc4I6D0f2TCie04inApnka4Igfq1f2
 egOlbd2G6HXyZDeSZMXwA7jc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:02 -0800
IronPort-SDR: ld1Tx0eGtrkK4MrkO0Mb2kDmhBf+mKP9EmYoN5s/vIBIxoV2cbXGU9o6htFn4oI1JtaOpCsM/C
 7mTZ3IRmPAlAV3ybd8qVzp9p5iYxKvjthVumxmEE5osPb/kAy99sYQp6LRspNKudfbcTbGCteO
 TcX1MQsyIcDHcZftg3PFQHD4YKOpnkB5mGtQeka+GZw3E5RrOQVjMMGEGA9dvBEVOYTYZr5poX
 NwCOrFMtqWN7op3ePRVY5cbJ5rujfSKzwG/iTtOssNMdxoWNvgWaBNJdKRdUOgH5g5ZIsBZWDb
 trs=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:22:57 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 03/42] btrfs: zoned: defer loading zone info after opening trees
Date:   Thu,  4 Feb 2021 19:21:42 +0900
Message-Id: <214dd3a87be0f9bdb19a5be6fc8880cb832846d4.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparation patch to implement zone emulation on a regular
device.

To emulate a zoned filesystem on a regular (non-zoned) device, we need to
decide an emulated zone size. Instead of making it a compile-time static
value, we'll make it configurable at mkfs time. Since we have one zone ==
one device extent restriction, we can determine the emulated zone size
from the size of a device extent. We can extend btrfs_get_dev_zone_info()
to show a regular device filled with conventional zones once the zone size
is decided.

The current call site of btrfs_get_dev_zone_info() during the mount process
is earlier than loading the file system trees so that we don't know the
size of a device extent at this point. Thus we can't slice a regular device
to conventional zones.

This patch introduces btrfs_get_dev_zone_info_all_devices to load the zone
info for all the devices. And, it places this function in open_ctree()
after loading the trees.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 13 +++++++++++++
 fs/btrfs/volumes.c |  4 ----
 fs/btrfs/zoned.c   | 25 +++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  6 ++++++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 71fab77873a5..2b6a3df765cd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3333,6 +3333,19 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (ret)
 		goto fail_tree_roots;
 
+	/*
+	 * Get zone type information of zoned block devices. This will also
+	 * handle emulation of a zoned filesystem if a regular device has the
+	 * zoned incompat feature flag set.
+	 */
+	ret = btrfs_get_dev_zone_info_all_devices(fs_info);
+	if (ret) {
+		btrfs_err(fs_info,
+			  "zoned: failed to read device zone info: %d",
+			  ret);
+		goto fail_block_groups;
+	}
+
 	/*
 	 * If we have a uuid root and we're not being told to rescan we need to
 	 * check the generation here so we can set the
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3948f5b50d11..07cd4742c123 100644
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
index 41d27fefd306..0b1b1f38a196 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -143,6 +143,31 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	return 0;
 }
 
+int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	int ret = 0;
+
+	/* fs_info->zone_size might not set yet. Use the incomapt flag here. */
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
index 8abe2f83272b..eb47b7ad9ab1 100644
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
@@ -42,6 +43,11 @@ static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 	return 0;
 }
 
+static inline int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
+{
+	return 0;
+}
+
 static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
 	return 0;
-- 
2.30.0

