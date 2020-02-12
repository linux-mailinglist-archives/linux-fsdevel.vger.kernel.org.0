Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D4D15A1BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgBLHVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:11 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBLHVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492072; x=1613028072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AuzFKI6hgcGOd7SGkTSu9C2SqC7HD/T06gRVqp8IFPY=;
  b=qUUdmmoOQQi0xa2xFpfSsJSw0sjOGiYV/ip8azMfIXrMWUQyl8Mns2RL
   RRLi6At65n4Dg8JRNMXXQnPH7KV/t5t3S40pLB5kbm3rap3bH//zGx16V
   FaaSEsMUyahKdyKHCunWF7ZMrck8mNmA6a+jQatU98RjaprkY03xPuv6U
   f9/HfWmLKNoAoqnEw6W/3ZaTTS6FEFE6cCzIBq2QabXU9ZJsyeIfi/ZvL
   n+8L/5ACnRluVUm8n+pCBShcLfIWsijRnWttMUeom6coXj+up/g+rYl/A
   urrhHE5kRjRjod+9Ota94A2mrI4cy4bUeM5cfwxOZb2W9W+qspWSL0/Wa
   A==;
IronPort-SDR: VIx20YpDFq3hz0F5rAQZE4WDO8K7sqzSAY4oGPwPXTdg/hHV6HXcmLXrXqWDIQFI4bdEQyNx8o
 fKK1CdNP5fxyJv/kGQSo0L1DSzTS4Uz0ZrF8pqnJTJgJFcfxbXvy8Vyb+z61D66ZLQL+6dcRJt
 uhHTQvuCXLDkVxjDkLHHmvr8wDez/4K/s0WivEZdFNdDOhlZdhooPCuNPqxeWcvhlhtcNGpity
 L5pLe0ER05uqE/rn54p8hRhLrM9V3+/1n6thRXX0dgHmQw2DVocWEddVcbfsAZauL4RAK2G3fV
 qec=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448909"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:12 +0800
IronPort-SDR: ZrzKco3eStSx3G72Zdq8hzysDRnKXZ4vXznnBspaeJh76+sneOI0wR9yJZ0WKSizLjHQpnrKny
 a0VYraJruix9OMXbiySi7Q3Ub/b+kktCrmOgZxj4AgkmefCI6z7eXnVGMjEYqsm1wGF6TBXpif
 N032b78aWgkCYPxfRekLzSrkIPUBhEakqnudftHA+SAPf0fdh6So6GtPwemLsqSkGGTb6SMxCW
 OwMqsiPr9S4lmGKzcVeQZmzC8GL504gjEm/dEvMUrhzPgRTan83djgHurexJVTCfDcp7SDOt5u
 PbbKOLtFd9Zm3ShA5NtF6iaS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:13:59 -0800
IronPort-SDR: f1i1mC+St05AyXq2WqAHuxQWpT5MJWTw9b5RY6G8S26cF61BOP0PmnKHaRASD9izUMIEOOcHak
 feBvCndMAZd8pjMqoAgAJcIsgXeQfA/vcorEB6taLchutOpmIIVNS8oULYsOG6KlWW5Kv1SgK3
 Qkvq6cJjNdeJtNCF93+aA4c0bvHZ640qUIuvswL7ykOYSwTpKwtLKP6V8Qp0Z5/QRHS5GHKS19
 5MBhkldJl+y5QRRWh1JFq00U5b3SlseKlvtvXt94G8NPzf9XmNIJDR8sZKaUOyMB5tfcyEyNGi
 Isk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:08 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 07/21] btrfs: factor out gather_device_info()
Date:   Wed, 12 Feb 2020 16:20:34 +0900
Message-Id: <20200212072048.629856-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out gather_device_info() from __btrfs_alloc_chunk(). This function
iterates over devices list and gather information about devices. This
commit also introduces "max_avail" and "dev_extent_min" to fold the same
calculation to one variable.

This commit has no functional changes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 119 +++++++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9181e3ab617d..2bd3ed830a28 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4896,59 +4896,25 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 	}
 }
 
-static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
-			       u64 start, u64 type)
+static int gather_device_info(struct btrfs_fs_devices *fs_devices,
+			      struct alloc_chunk_ctl *ctl,
+			      struct btrfs_device_info *devices_info)
 {
-	struct btrfs_fs_info *info = trans->fs_info;
-	struct btrfs_fs_devices *fs_devices = info->fs_devices;
+	struct btrfs_fs_info *info = fs_devices->fs_info;
 	struct btrfs_device *device;
-	struct map_lookup *map = NULL;
-	struct extent_map_tree *em_tree;
-	struct extent_map *em;
-	struct btrfs_device_info *devices_info = NULL;
-	struct alloc_chunk_ctl ctl;
 	u64 total_avail;
-	int data_stripes;	/* number of stripes that count for
-				   block group size */
+	u64 dev_extent_want = ctl->max_stripe_size * ctl->dev_stripes;
+	u64 dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 	int ret;
-	int ndevs;
-	int i;
-	int j;
-
-	if (!alloc_profile_is_valid(type, 0)) {
-		ASSERT(0);
-		return -EINVAL;
-	}
-
-	if (list_empty(&fs_devices->alloc_list)) {
-		if (btrfs_test_opt(info, ENOSPC_DEBUG))
-			btrfs_debug(info, "%s: no writable device", __func__);
-		return -ENOSPC;
-	}
-
-	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
-		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
-		BUG();
-	}
-
-	ctl.start = start;
-	ctl.type = type;
-	init_alloc_chunk_ctl(fs_devices, &ctl);
-
-	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
-			       GFP_NOFS);
-	if (!devices_info)
-		return -ENOMEM;
+	int ndevs = 0;
+	u64 max_avail;
+	u64 dev_offset;
 
 	/*
 	 * in the first pass through the devices list, we gather information
 	 * about the available holes on each device.
 	 */
-	ndevs = 0;
 	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
-		u64 max_avail;
-		u64 dev_offset;
-
 		if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 			WARN(1, KERN_ERR
 			       "BTRFS: read-only device in alloc_list\n");
@@ -4969,21 +4935,20 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (total_avail == 0)
 			continue;
 
-		ret = find_free_dev_extent(
-			device, ctl.max_stripe_size * ctl.dev_stripes,
-			&dev_offset, &max_avail);
+		ret = find_free_dev_extent(device, dev_extent_want, &dev_offset,
+					   &max_avail);
 		if (ret && ret != -ENOSPC)
-			goto error;
+			return ret;
 
 		if (ret == 0)
-			max_avail = ctl.max_stripe_size * ctl.dev_stripes;
+			max_avail = dev_extent_want;
 
-		if (max_avail < BTRFS_STRIPE_LEN * ctl.dev_stripes) {
+		if (max_avail < dev_extent_min) {
 			if (btrfs_test_opt(info, ENOSPC_DEBUG))
 				btrfs_debug(info,
-			"%s: devid %llu has no free space, have=%llu want=%u",
+			"%s: devid %llu has no free space, have=%llu want=%llu",
 					    __func__, device->devid, max_avail,
-					    BTRFS_STRIPE_LEN * ctl.dev_stripes);
+					    dev_extent_min);
 			continue;
 		}
 
@@ -4998,14 +4963,62 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		devices_info[ndevs].dev = device;
 		++ndevs;
 	}
-	ctl.ndevs = ndevs;
+	ctl->ndevs = ndevs;
 
 	/*
 	 * now sort the devices by hole size / available space
 	 */
-	sort(devices_info, ctl.ndevs, sizeof(struct btrfs_device_info),
+	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
+	return 0;
+}
+
+static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
+			       u64 start, u64 type)
+{
+	struct btrfs_fs_info *info = trans->fs_info;
+	struct btrfs_fs_devices *fs_devices = info->fs_devices;
+	struct map_lookup *map = NULL;
+	struct extent_map_tree *em_tree;
+	struct extent_map *em;
+	struct btrfs_device_info *devices_info = NULL;
+	struct alloc_chunk_ctl ctl;
+	int data_stripes;	/* number of stripes that count for
+				   block group size */
+	int ret;
+	int i;
+	int j;
+
+	if (!alloc_profile_is_valid(type, 0)) {
+		ASSERT(0);
+		return -EINVAL;
+	}
+
+	if (list_empty(&fs_devices->alloc_list)) {
+		if (btrfs_test_opt(info, ENOSPC_DEBUG))
+			btrfs_debug(info, "%s: no writable device", __func__);
+		return -ENOSPC;
+	}
+
+	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
+		BUG();
+	}
+
+	ctl.start = start;
+	ctl.type = type;
+	init_alloc_chunk_ctl(fs_devices, &ctl);
+
+	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
+			       GFP_NOFS);
+	if (!devices_info)
+		return -ENOMEM;
+
+	ret = gather_device_info(fs_devices, &ctl, devices_info);
+	if (ret < 0)
+		goto error;
+
 	/*
 	 * Round down to number of usable stripes, devs_increment can be any
 	 * number so we can't use round_down()
-- 
2.25.0

