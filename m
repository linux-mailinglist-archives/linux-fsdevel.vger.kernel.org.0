Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0815421F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgBFKo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:29 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgBFKo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985868; x=1612521868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iY+OOfKKbJaIT8owC4h3HQcN0w90XXaJ/L8j+ye0u8k=;
  b=AG3JQSiUDMD//Abnq269Kaa42U0nP3odSIFNCQljCwcHlcIsgqEccIA6
   BGhJ+gR8VmctUNg0YGqchNUXy8Tc3D/gJNvoJVfllJC3lU5wKRA9yZ9SS
   pP1Dfh7LIYUKr30HRyeOPQkDvXeWl7qo+vb4bgozphkXt1/gKwDfv7icb
   i0Z3PxcxmoNGG5Dbi/Yli4Yu2AmburS8RoufUelAFCOzZ70m9jLCUX85A
   NSEALxsim6OqqqzrCgMWU57Fd1dhA1Ljyl+femGGUGinoRPp7TOUwwzud
   DHDF9+KqL2lAuahw3fe5kG+sTF1ifCbEp7B2VhqZV3owPi8UThMF9rsv1
   Q==;
IronPort-SDR: CMxwk+9xLjZEm17QM0PeVzhPtv5KX2+XzBdc30SojpZhafgqYnCYCy6gQ93MgegNuOjvHbEmI9
 UsY8HHKV615gQhDWRCOf1MoUI8it1+IgfXM6zUqxuRKuB0ocKkkAHLV/UbUt7b3CnV9oDXjyyc
 gwYZJD/Ju8d81lz1/ReLC0iMkjtOhfGLlIe955y0SenW7Rp4MmPHAW/t+Z4Flm79js2E1UNFzB
 J+KD/jPlUiVHq/aBmncgaa9Necm1ATRSqkZFZLwMGNsQaMedYIA3nhFeMTTiMSKUznNoSKs85w
 gRs=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209508"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:28 +0800
IronPort-SDR: 0xlGFyKgHdAKJunSQP62cN4XgCy3aVTUtICVblwXSgvCIox7J6qgxc0OLkPULl1GKmSFnmMcGK
 162m9JOBdgYYsLRaTNpYasKnCMaAdo+/xxUMcdvpTbrgVKnPM0hTroq8Hvkvyf+PmZST1BiNiA
 xp0uE7iAutGG94z1Iokde79kOetTIRS9QDL33I2Gqw1YTcPesl5MxqbI52OUItNcvvscv5rEJI
 lpWo9B4LXGge+MQXw7Bx5J3ihF/F8HbqLHGunC0o85tmLomHZlj+QoQyZEoV7ns0QJ0xLE2IJ5
 +fVtJMgRxmtWbVGHKvvTrg8O
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:28 -0800
IronPort-SDR: ywebyAjcyDyhDEyXsKxN1dqx9IsM2kaZRDMIOpLNuD2v/CXEdF6cp4nBKA6ZsQoUAI7PiJ3RQF
 10NDA0FrDCfAEcnMQukQHNnf4PPfE8ECdC6rImWRGOmtZiPrbJn8Yk62z/wrXjKU9/vGnKD70D
 KVv5vUoAWnm+H6me4wIV7P86xju4Td3D1yv8wrOmFA4ZxxnF+3nRXx0rgTMD39vjFLhoGCmcVR
 mCW8wj6Xbll0enZksJGfweUMNaYNP0Or4sbeGDjaaaXfyYCW1AWLi7NkNRDrrSa/BWQ8MVFZhG
 5T8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:26 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 06/20] btrfs: factor out gather_device_info()
Date:   Thu,  6 Feb 2020 19:42:00 +0900
Message-Id: <20200206104214.400857-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
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
---
 fs/btrfs/volumes.c | 113 +++++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a5d6f0b5ca70..02bd86d126ff 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4895,56 +4895,25 @@ static void set_parameters(struct btrfs_fs_devices *fs_devices,
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
-	BUG_ON(!alloc_profile_is_valid(type, 0));
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
-	set_parameters(fs_devices, &ctl);
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
@@ -4965,21 +4934,20 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (total_avail == 0)
 			continue;
 
-		ret = find_free_dev_extent(device,
-				ctl.max_stripe_size * ctl.dev_stripes,
-					   &dev_offset, &max_avail);
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
-				BTRFS_STRIPE_LEN * ctl.dev_stripes);
+					    dev_extent_min);
 			continue;
 		}
 
@@ -4994,14 +4962,59 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
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
+	BUG_ON(!alloc_profile_is_valid(type, 0));
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
+	set_parameters(fs_devices, &ctl);
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

