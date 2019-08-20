Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C0895647
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfHTExR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:17 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbfHTExQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276795; x=1597812795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=64YBSe+3BGLkturLsVCskGQwbaQ+oBED/ZGLxkC0Ldo=;
  b=mqt6ZBrAJVro5W0yGF5GXINOj5cNW7NpJQ71nHOkTWmWGUd8N7GmXfas
   Z3UTAiCJ6+Ip09Wv1sJkYIhFz3b8l1fQAAe92cLo/eF22NMfPuIT57CQk
   WGGIJRnzCaQsvna4/VRVoQAfRFUq3w7HahlWC0UX2SF8yrTkKHseo7xKk
   CqvysjRqFJSNPZjPOZ973zIYm48g50yuWbFuev3F2wcwUx1VbQ44z+HGS
   /5roHbVZ+y539ppo5JcRd+UtIozJ6BoztILaoiDzHrFnIxNe4BNOq9b3P
   uxXhClgva3SS6qOMEdh0nFdyjScpWF6M9Ye741qVw9eKM0HNOv7dmjJzs
   Q==;
IronPort-SDR: 8QpPO+3DLIbScJllHuCcuweQ+BPUFRdnLQM9Z68LTZ7SwEJugPKYyY2dzMcdkLumYsXGcaxDyi
 zzkVmn5VYxuROwu9sPEUKErY1CL6KTDr207UdtlLmeQ0VhXVCZ4d28QHWYg3204iMuQOrtUtxW
 M5aFJH0ycOTnJINTD0RFlMBCWnrQHANFRvaPdkS0V9IoVkWMuq8J5rjmEJR2Rqm5Sy4fvuD74+
 8WQclivfIFrKgvuxqgKsr9Ka9MjITrQaSZ8uv/XqZqAp3Gx7AMbFicab/RwQmVX+9WMHKeEXAA
 uxA=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136296"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:15 +0800
IronPort-SDR: VszuqIMEHJjThlmylJOZUo9+Xa57auHR0+RJxQ0oRjWcQlY/s9Qx12OkjqNEQ+bkJPE8bpVMg2
 a3p3v5T19HuWpkiNspeFSTVgXM61sHD51EK7wKH+LM/oR+Q/4tVCNIGQrSS9j0umU00dxhG1h6
 zWYrcAp05oVhGju/JbazRdTvq4hE/yfu41HBSO5RB17A0N42RvXE32fs6usfnTlYJNDYHeW2Z1
 av1bzyRgM/W/HSxmzPoD3ZHVLidJSvwLRlu8SylBwH6Gr67gW/fVtshkyU3lLcar3pjtuSO9gj
 3Ufkg/t9nzXRU4SBH2JKiEF6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:39 -0700
IronPort-SDR: J4M3QSho2ScOdD5lZ2G6LcRlaWzt53vL3f8ITj1x+5FXOSDbXjiO+Fxx3nUzAQpUo0fKzsl11n
 8BTPCdq5fTlVRmDnIbZkGwEQtEKOptDsujZBHjy1hvMFk1p1Q2pcA7JONW1DZyRzS725A1B5B1
 A4zSVc+11GFcAxeTJj+p6ww8Rg8Zc3Tbs868xsgCfWsdOkhTHpobknQ3ZD++LeR6au1svXyRfb
 XT/RbA7T5T3S4tC42LocOi6OkINsjxPSLY9SXDFUMcaGA8CuUdnyWrHJ8VAvQxjN4uYduutvJo
 XDc=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:12 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 06/15] btrfs-progs: load and check zone information
Date:   Tue, 20 Aug 2019 13:52:49 +0900
Message-Id: <20190820045258.1571640-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
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
 common/device-scan.c | 10 ++++++++++
 volumes.c            | 18 ++++++++++++++++++
 volumes.h            |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/common/device-scan.c b/common/device-scan.c
index 2c5ae225f710..5df77b9b68d7 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -135,6 +135,16 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
+	ret = btrfs_get_zone_info(fd, path, fs_info->fs_devices->hmzoned,
+				  &device->zone_info);
+	if (ret)
+		goto out;
+	if (device->zone_info.zone_size != fs_info->fs_devices->zone_size) {
+		error("Device zone size differ");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	disk_super = (struct btrfs_super_block *)buf;
 	dev_item = &disk_super->dev_item;
 
diff --git a/volumes.c b/volumes.c
index f99fddc7cf6f..a0ebed547faa 100644
--- a/volumes.c
+++ b/volumes.c
@@ -196,6 +196,8 @@ static int device_list_add(const char *path,
 	u64 found_transid = btrfs_super_generation(disk_super);
 	bool metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+	bool hmzoned = btrfs_super_incompat_flags(disk_super) &
+		BTRFS_FEATURE_INCOMPAT_HMZONED;
 
 	if (metadata_uuid)
 		fs_devices = find_fsid(disk_super->fsid,
@@ -285,6 +287,7 @@ static int device_list_add(const char *path,
 	if (fs_devices->lowest_devid > devid) {
 		fs_devices->lowest_devid = devid;
 	}
+	fs_devices->hmzoned = hmzoned;
 	*fs_devices_ret = fs_devices;
 	return 0;
 }
@@ -355,6 +358,8 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices, int flags)
 	struct btrfs_device *device;
 	int ret;
 
+	fs_devices->zone_size = 0;
+
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		if (!device->name) {
 			printk("no name for device %llu, skip it now\n", device->devid);
@@ -378,6 +383,19 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices, int flags)
 		device->fd = fd;
 		if (flags & O_RDWR)
 			device->writeable = 1;
+
+		ret = btrfs_get_zone_info(fd, device->name, fs_devices->hmzoned,
+					  &device->zone_info);
+		if (ret != 0)
+			goto fail;
+		if (!fs_devices->zone_size) {
+			fs_devices->zone_size = device->zone_info.zone_size;
+		} else if (device->zone_info.zone_size !=
+			   fs_devices->zone_size) {
+			error("Device zone size differ");
+			ret = -EINVAL;
+			goto fail;
+		}
 	}
 	return 0;
 fail:
diff --git a/volumes.h b/volumes.h
index 586588c871ab..edbb0f36aa75 100644
--- a/volumes.h
+++ b/volumes.h
@@ -22,12 +22,15 @@
 #include "kerncompat.h"
 #include "ctree.h"
 
+#include "common/hmzoned.h"
+
 #define BTRFS_STRIPE_LEN	SZ_64K
 
 struct btrfs_device {
 	struct list_head dev_list;
 	struct btrfs_root *dev_root;
 	struct btrfs_fs_devices *fs_devices;
+	struct btrfs_zone_info zone_info;
 
 	u64 total_ios;
 
@@ -87,6 +90,9 @@ struct btrfs_fs_devices {
 
 	int seeding;
 	struct btrfs_fs_devices *seed;
+
+	u64 zone_size;
+	bool hmzoned;
 };
 
 struct btrfs_bio_stripe {
-- 
2.23.0

