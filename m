Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B291124D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfLDI1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfLDI1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448063; x=1606984063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BQC5SDziotAtQ5ZdGIn/PmyZQkwRARnH7DzOfW/K3pg=;
  b=L2DQ43c+Bymef3SluMOVCs19Q8KZK+PxAak/xrIlfn9fQHf7ZdBTp6JO
   T1wRipfUyeLWQTx3w73unqt5R+m6ZAUvOBJG+Ol9Jai/bKaXrHIOVFKBt
   P9WsyCNxMuYWETQhx+BOFLrT+bS59vyLz+3VwMMgEMtZ/INJvxlZowyZf
   VFXpy/WWg1gqoovV3Vfl5nTKSeLiJ57NVh0EkWKZrJnEOwLxuwepSVN+N
   EOjWo7y7xUwCLRzuFOHoFvUdb4QJoWSaHv/Bno8b4h08TWRj6JtJdMhY0
   y51c/BOM1ukrJp9rnVNg4V4U7izwAUhuKJdxwJ9+UeHlfV29ryNBZSeBg
   w==;
IronPort-SDR: QIyUaZrhnimBVfn6HrJUWEZJT3i1QVOs0hnKAfFuyQNz9EI7NpOwMK9dzseE8Y8jXRKK42WF/R
 r0QfJK3ZnNrdgb9SNG0jhGl1I9rOozRKOokNqJ3HfdLeiqqyQ6aIhaH1xhov5fXs104KXKxPg+
 PBFLNOhxy/T5EhnLh1f4Y2NC7AKWK/LNntcn4eYn98OzrfzwWd+jUx4blvCHnIEpgm5601tMQh
 vc+TvKlwBqDZhnEo8mL5QHDJ7O3XB5du/uSKTJGsws91JV2YrmP/D5kjpZhsNMT55xlSfC/PeI
 Loc=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031743"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:27:42 +0800
IronPort-SDR: FVTXXrG6r8I04PlV0c3eayg4vBVBtYmxsTKtxFfV18l1B8L856PBjgUYQAnAhmW6iQwUePNNNW
 /EY7YScYF4lU/NlAv65/2BxwA2enY9DIC8dOm4PQArYVXkQvCC9O4ODwfjcAhy9xFBnRrELrt1
 BVoYLJ89BxL6i4Ipmt1umkS5s6zOnut5aN/e0FKu0++vNUqMS8aLu42l0yKCYzRvCxn7m76rML
 y7o4/Hgb0wOtTmqegyrU+UpuoCyLruLubsut0GanPIoqk/pjPe3zcUlJudM5Gtgu0OfKEqk4d6
 2ilEsB2QXskse0EWSudjRpC4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:28 -0800
IronPort-SDR: EvCtgiJKUZ1cMJrXrOsWN4lwHB45zGSWoofJMRq/oGxiC474aRa6vFBYK82Qj2e4v8nGjQVAvM
 Bt7bO/wXYZOojxTwJ/WDyYzNdSvjILz6iqQXPNtDvf005pnLGYm7alV1ypC+So1OmLonqKrylS
 6ApJ0UeimMl3mfrxKhg+2GhkZjX+OF+FlNDVCn4EZD+6bQ+wmc85SyQc9Of+nE0RL7hKnMI9SF
 B4VGW7EvdRPP6HiqCpBVVY665hC+kWsQ/anAvGCaKN9U29RB8TDbWIuCFRoKaSGbnJXgrc8A6S
 Ikg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:40 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 06/15] btrfs-progs: load and check zone information
Date:   Wed,  4 Dec 2019 17:25:04 +0900
Message-Id: <20191204082513.857320-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch checks if a device added to btrfs is a zoned block device. If it
is, load zones information and the zone size for the device.

For a btrfs volume composed of multiple zoned block devices, all devices
must have the same zone size.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-scan.c | 15 +++++++++++++++
 common/hmzoned.h     |  2 ++
 volumes.c            | 31 +++++++++++++++++++++++++++++++
 volumes.h            |  4 ++++
 4 files changed, 52 insertions(+)

diff --git a/common/device-scan.c b/common/device-scan.c
index 48dbd9e19715..548e1322bb70 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -29,6 +29,7 @@
 #include "kernel-lib/overflow.h"
 #include "common/path-utils.h"
 #include "common/device-scan.h"
+#include "common/hmzoned.h"
 #include "common/messages.h"
 #include "common/utils.h"
 #include "common-defs.h"
@@ -137,6 +138,19 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
+	ret = btrfs_get_zone_info(fd, path, fs_info->fs_devices->hmzoned,
+				  &device->zone_info);
+	if (ret)
+		goto out;
+	if (fs_info->fs_devices->hmzoned) {
+		if (device->zone_info->zone_size !=
+		    fs_info->fs_devices->zone_size) {
+			error("Device zone size differ");
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
 	disk_super = (struct btrfs_super_block *)buf;
 	dev_item = &disk_super->dev_item;
 
@@ -197,6 +211,7 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 	return 0;
 
 out:
+	free(device->zone_info);
 	free(device);
 	free(buf);
 	return ret;
diff --git a/common/hmzoned.h b/common/hmzoned.h
index 098952061bfb..d229b946e5ed 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -18,6 +18,8 @@
 #ifndef __BTRFS_HMZONED_H__
 #define __BTRFS_HMZONED_H__
 
+#include <stdbool.h>
+
 #ifdef BTRFS_ZONED
 #include <linux/blkzoned.h>
 #else
diff --git a/volumes.c b/volumes.c
index 8bfffa5586eb..d92052e19330 100644
--- a/volumes.c
+++ b/volumes.c
@@ -27,6 +27,7 @@
 #include "transaction.h"
 #include "print-tree.h"
 #include "volumes.h"
+#include "common/hmzoned.h"
 #include "common/utils.h"
 #include "kernel-lib/raid56.h"
 
@@ -214,6 +215,8 @@ static int device_list_add(const char *path,
 	u64 found_transid = btrfs_super_generation(disk_super);
 	bool metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+	bool hmzoned = btrfs_super_incompat_flags(disk_super) &
+		BTRFS_FEATURE_INCOMPAT_HMZONED;
 
 	if (metadata_uuid)
 		fs_devices = find_fsid(disk_super->fsid,
@@ -238,8 +241,18 @@ static int device_list_add(const char *path,
 		fs_devices->latest_devid = devid;
 		fs_devices->latest_trans = found_transid;
 		fs_devices->lowest_devid = (u64)-1;
+		fs_devices->hmzoned = hmzoned;
 		device = NULL;
 	} else {
+		if (fs_devices->hmzoned != hmzoned) {
+			if (hmzoned)
+				error(
+			"Cannot add HMZONED device to non-HMZONED file system");
+			else
+				error(
+			"Cannot add non-HMZONED device to HMZONED file system");
+			return -EINVAL;
+		}
 		device = find_device(fs_devices, devid,
 				       disk_super->dev_item.uuid);
 	}
@@ -335,6 +348,7 @@ again:
 		/* free the memory */
 		free(device->name);
 		free(device->label);
+		free(device->zone_info);
 		free(device);
 	}
 
@@ -373,6 +387,8 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices, int flags)
 	struct btrfs_device *device;
 	int ret;
 
+	fs_devices->zone_size = 0;
+
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		if (!device->name) {
 			printk("no name for device %llu, skip it now\n", device->devid);
@@ -396,6 +412,21 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices, int flags)
 		device->fd = fd;
 		if (flags & O_RDWR)
 			device->writeable = 1;
+
+		ret = btrfs_get_zone_info(fd, device->name, fs_devices->hmzoned,
+					  &device->zone_info);
+		if (ret != 0)
+			goto fail;
+		if (!device->zone_info)
+			continue;
+		if (!fs_devices->zone_size) {
+			fs_devices->zone_size = device->zone_info->zone_size;
+		} else if (device->zone_info->zone_size !=
+			   fs_devices->zone_size) {
+			error("Device zone size differ");
+			ret = -EINVAL;
+			goto fail;
+		}
 	}
 	return 0;
 fail:
diff --git a/volumes.h b/volumes.h
index 41574f21dd23..d52dbcba0410 100644
--- a/volumes.h
+++ b/volumes.h
@@ -28,6 +28,7 @@ struct btrfs_device {
 	struct list_head dev_list;
 	struct btrfs_root *dev_root;
 	struct btrfs_fs_devices *fs_devices;
+	struct btrfs_zoned_device_info *zone_info;
 
 	u64 total_ios;
 
@@ -87,6 +88,9 @@ struct btrfs_fs_devices {
 
 	int seeding;
 	struct btrfs_fs_devices *seed;
+
+	u64 zone_size;
+	bool hmzoned;
 };
 
 struct btrfs_bio_stripe {
-- 
2.24.0

