Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2C5123D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 03:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLRC3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 21:29:48 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63595 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfLRC3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576636187; x=1608172187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=992rE7LptW46spdaUd/PnbqEXu3Ed2EvmEWa0bKV1xs=;
  b=bdjlQDIrBSZhB4CJtrBnP9OnyiMNFAxJCn9TBCgwk/+wBSDYj3N79T9k
   Fqcu/VmH7BGe6Wy9vjfDEoZtmB3mGQ8lgoEMoGmF7CFnXtRYc1z1walOa
   4LiRm+lhh1L3tbwXw/09ZvmBFQmsBEpp9afVF2MVkYUVipVVizVaTtlJK
   SAa4Sm5t3NljOYL8y/y/46KM1wh279hmK+fZpJrB1wVMnM6kLadY2JRtC
   wG/2b0KnV+dbQ49L/IWRDs9AijN2tQvq6sd6ExVl2GPAgS8lC6C3pLUYr
   4bW9oHmDPwO8Y9t8MExawPCoiqxgkB8zZQHdOabU1ThuEQnXyH76XznIZ
   g==;
IronPort-SDR: +xkkfOf0OBJLjtrYnzeodEJfJD3GinjQcfAVSRNAdoG2wMoRRk2A4WJFKAM+hKwDrvjfITLSQd
 sJYDo9pvALoZgjRB4vu21ch34LyrsGwAP5CZ820gzE1uj+fmsaEaQ4rkP/yGoGn5kjuVHfbBAD
 Fu4LcUVuVp9u3DwVGvk7JyjW0XBhZe+SzxlvtPpbik1JufTracw3YZFFaD7PlLmBrNe6lRaeUa
 Y3S/OTLwE9UQuWxRKYrirGMQzFns0sMc9IBvaqWcwFIZr0W/xe9fHZShIfJxVKRxsBI//RWbCe
 WzQ=
X-IronPort-AV: E=Sophos;i="5.69,327,1571673600"; 
   d="scan'208";a="125592072"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2019 10:29:46 +0800
IronPort-SDR: QzcJ0mq5NhzNsskKlNYu540VLSrPj5dJCGJWU6NTiGtPODLT0HT2uL0VsDddzduH+iW8VCIE2t
 oqntDfhy7QrHch7hcLk1Ge0NvjV8NjgBCx8/Q9YKuuar3+hjoBNN50DcFTLdya1l7SkoTrR2YT
 Laozi6DpSA1iUJi5keAAjVAH8uXxS1xDkOgw1NAvq3u//Xhr8uNrqaprHME+8rvcJ8W2LtYC9G
 zd1jO0YKZz4L29bbI75FnZ56JYJNyZJQITh5eGw928QC0wK7C7WFOJyhKploBnranZodBnKBrZ
 GnaWuwa0IL72mwu3/LP/i63N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 18:23:49 -0800
IronPort-SDR: 1ZZe0CTz2ZWcxA8+BtjtqieoeWRtm3ynNCYLlJarQ752NI4p825kGqo4zBwfi9br8tMIGMYcQS
 b6oMMKixng4DOs4QPVFWYhMX7OqKLvim5SBT8d8Vf7Gr0JCI+jiNe8VjXAg3PVklFwnww1wj38
 vIHXulc7j2jySUidVNc2DoYNqnZK+Xv8/zhdRC9QfqmVB+vCZrNnEAP251oP2P+dlny7gM7/+U
 dg9zRrLY+NcJIKGYPZYdDUtt9SjQ9ojn6amkplS+bAGuJg0yXNMMFCZ7KP8mnlT1Hh/V7amNY8
 Znc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 17 Dec 2019 18:29:45 -0800
Received: (nullmailer pid 195964 invoked by uid 1000);
        Wed, 18 Dec 2019 02:29:44 -0000
Date:   Wed, 18 Dec 2019 11:29:44 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 02/28] btrfs: Get zone information of zoned block
 devices
Message-ID: <20191218022944.b6jddneylfwwr6no@naota.dhcp.fujisawa.hgst.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-3-naohiro.aota@wdc.com>
 <d4cccf98-a01a-8d2f-40fe-e2f356a037a0@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d4cccf98-a01a-8d2f-40fe-e2f356a037a0@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 11:18:53AM -0500, Josef Bacik wrote:
>On 12/12/19 11:08 PM, Naohiro Aota wrote:
>>If a zoned block device is found, get its zone information (number of zones
>>and zone size) using the new helper function btrfs_get_dev_zone_info().  To
>>avoid costly run-time zone report commands to test the device zones type
>>during block allocation, attach the seq_zones bitmap to the device
>>structure to indicate if a zone is sequential or accept random writes. Also
>>it attaches the empty_zones bitmap to indicate if a zone is empty or not.
>>
>>This patch also introduces the helper function btrfs_dev_is_sequential() to
>>test if the zone storing a block is a sequential write required zone and
>>btrfs_dev_is_empty_zone() to test if the zone is a empty zone.
>>
>>Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/Makefile  |   1 +
>>  fs/btrfs/hmzoned.c | 168 +++++++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/hmzoned.h |  92 +++++++++++++++++++++++++
>>  fs/btrfs/volumes.c |  18 ++++-
>>  fs/btrfs/volumes.h |   4 ++
>>  5 files changed, 281 insertions(+), 2 deletions(-)
>>  create mode 100644 fs/btrfs/hmzoned.c
>>  create mode 100644 fs/btrfs/hmzoned.h
>>
>>diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
>>index 82200dbca5ac..64aaeed397a4 100644
>>--- a/fs/btrfs/Makefile
>>+++ b/fs/btrfs/Makefile
>>@@ -16,6 +16,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
>>  btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
>>+btrfs-$(CONFIG_BLK_DEV_ZONED) += hmzoned.o
>>  btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
>>  	tests/extent-buffer-tests.o tests/btrfs-tests.o \
>>diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
>>new file mode 100644
>>index 000000000000..6a13763d2916
>>--- /dev/null
>>+++ b/fs/btrfs/hmzoned.c
>>@@ -0,0 +1,168 @@
>>+// SPDX-License-Identifier: GPL-2.0
>>+/*
>>+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
>>+ * Authors:
>>+ *	Naohiro Aota	<naohiro.aota@wdc.com>
>>+ *	Damien Le Moal	<damien.lemoal@wdc.com>
>>+ */
>>+
>>+#include <linux/slab.h>
>>+#include <linux/blkdev.h>
>>+#include "ctree.h"
>>+#include "volumes.h"
>>+#include "hmzoned.h"
>>+#include "rcu-string.h"
>>+
>>+/* Maximum number of zones to report per blkdev_report_zones() call */
>>+#define BTRFS_REPORT_NR_ZONES   4096
>>+
>>+static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>>+			       struct blk_zone *zones, unsigned int *nr_zones)
>>+{
>>+	int ret;
>>+
>>+	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, zones,
>>+				  nr_zones);
>>+	if (ret != 0) {
>>+		btrfs_err_in_rcu(device->fs_info,
>>+				 "get zone at %llu on %s failed %d", pos,
>>+				 rcu_str_deref(device->name), ret);
>>+		return ret;
>>+	}
>>+	if (!*nr_zones)
>>+		return -EIO;
>>+
>>+	return 0;
>>+}
>>+
>>+int btrfs_get_dev_zone_info(struct btrfs_device *device)
>>+{
>>+	struct btrfs_zoned_device_info *zone_info = NULL;
>>+	struct block_device *bdev = device->bdev;
>>+	sector_t nr_sectors = bdev->bd_part->nr_sects;
>>+	sector_t sector = 0;
>>+	struct blk_zone *zones = NULL;
>>+	unsigned int i, nreported = 0, nr_zones;
>>+	unsigned int zone_sectors;
>>+	int ret;
>>+	char devstr[sizeof(device->fs_info->sb->s_id) +
>>+		    sizeof(" (device )") - 1];
>>+
>>+	if (!bdev_is_zoned(bdev))
>>+		return 0;
>>+
>>+	zone_info = kzalloc(sizeof(*zone_info), GFP_KERNEL);
>>+	if (!zone_info)
>>+		return -ENOMEM;
>>+
>>+	zone_sectors = bdev_zone_sectors(bdev);
>>+	ASSERT(is_power_of_2(zone_sectors));
>>+	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
>>+	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
>>+	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
>>+	if (!IS_ALIGNED(nr_sectors, zone_sectors))
>>+		zone_info->nr_zones++;
>>+
>>+	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
>>+	if (!zone_info->seq_zones) {
>>+		ret = -ENOMEM;
>>+		goto free_zone_info;
>>+	}
>>+
>>+	zone_info->empty_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
>>+	if (!zone_info->empty_zones) {
>>+		ret = -ENOMEM;
>>+		goto free_seq_zones;
>>+	}
>>+
>>+	zones = kcalloc(BTRFS_REPORT_NR_ZONES,
>>+			sizeof(struct blk_zone), GFP_KERNEL);
>>+	if (!zones) {
>>+		ret = -ENOMEM;
>>+		goto free_empty_zones;
>>+	}
>>+
>>+	/* Get zones type */
>>+	while (sector < nr_sectors) {
>>+		nr_zones = BTRFS_REPORT_NR_ZONES;
>>+		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
>>+					  &nr_zones);
>>+		if (ret)
>>+			goto free_zones;
>>+
>>+		for (i = 0; i < nr_zones; i++) {
>>+			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
>>+				set_bit(nreported, zone_info->seq_zones);
>>+			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
>>+				set_bit(nreported, zone_info->empty_zones);
>>+			nreported++;
>>+		}
>>+		sector = zones[nr_zones - 1].start + zones[nr_zones - 1].len;
>>+	}
>>+
>>+	if (nreported != zone_info->nr_zones) {
>>+		btrfs_err_in_rcu(device->fs_info,
>>+				 "inconsistent number of zones on %s (%u / %u)",
>>+				 rcu_str_deref(device->name), nreported,
>>+				 zone_info->nr_zones);
>>+		ret = -EIO;
>>+		goto free_zones;
>>+	}
>>+
>>+	kfree(zones);
>>+
>>+	device->zone_info = zone_info;
>>+
>>+	devstr[0] = 0;
>>+	if (device->fs_info)
>>+		snprintf(devstr, sizeof(devstr), " (device %s)",
>>+			 device->fs_info->sb->s_id);
>>+
>>+	rcu_read_lock();
>>+	pr_info(
>>+"BTRFS info%s: host-%s zoned block device %s, %u zones of %llu sectors",
>>+		devstr,
>>+		bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
>>+		rcu_str_deref(device->name), zone_info->nr_zones,
>>+		zone_info->zone_size >> SECTOR_SHIFT);
>>+	rcu_read_unlock();
>>+
>>+	return 0;
>>+
>>+free_zones:
>>+	kfree(zones);
>>+free_empty_zones:
>>+	bitmap_free(zone_info->empty_zones);
>>+free_seq_zones:
>>+	bitmap_free(zone_info->seq_zones);
>>+free_zone_info:
>
>bitmap_free is just a kfree which handles NULL pointers properly, so 
>you only need one goto here for cleaning up the zone_info.  Once 
>that's fixed you can add
>
>Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
>Josef

Ah, then, I think I can simplify the code to use one "out" label and
kfree/bitmap_free both zones and zone_info.

Thanks,
