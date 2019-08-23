Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B09ACBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404391AbfHWKLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47768 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404360AbfHWKLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555096; x=1598091096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4odTqs4ZNtewzttV9LDeX2WybTMLAg/TmE0+WAUIiU4=;
  b=Os0CT8d5WQMzEaf6BqN4hjYXwSA1znJrcKVCeuacDS/4IiHu4FZWn6nJ
   RiE6mKR78lKwoVQgLJOMB4/MicN/mzIJl3gfImiED2AX0XtLBxC/m8Ior
   0LENYYin+mgSBYnBQxUL3KouCp2lX9kQudCBIP4/fcmGRb3H3ZJo13BTm
   8uK24zTFntHZDLIiR1RyJiy4hFdl4Yp2Ns4FupofUj9zrociD0X5DNM0G
   whWKOHejjiW/kAx7jqotnjtIMYYoXYNi9Wfd/syZpVbltBRGzMUC0Cuw7
   VioXRCs0GvQ3rLaw6cNY3ovRywNQbd9/uqugXMiPNhzTHBgBLp2qb4TM9
   Q==;
IronPort-SDR: V2VLEiMlpxd4y7fpBYU+kUsT2beS49JtdrZRSOMmRvPHSDYTIWTe/gH5Vddm7N/1UEHH/jNW5i
 1kMfsS3rzmTP6buk7I2mYyNm7/t85drtBzLKQgyQxDl4D1REDg/Vv/SEu3aq01wdKEbPbHBdYY
 UGDVbFBr4k+yoJ3V4zE9V7XodALGK+44mHmHWkbA77jZkCS8b3umDAx6MWDcUfNgwFZTQPFeGm
 rRFi/mHWy3skYPOVych1RDgcpZOKUw53TBHDuJD4wwjJ+mfYmJxiYZGqb4tV1NCaxmNO3Wlq2E
 2J8=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096249"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:36 +0800
IronPort-SDR: TqgGokU+hjSnuTGAZGx7mZ5narFABOyhz6IuucASdDzynhJiJwBGhCrl9XomcjOEXb3Ehi72Sn
 xurIyFsCnZ0h7YhP+oYKtAe3eSXpm0OVfF+YI3LSE/Iy6Cpnad1CGww6c4MXBD1i0lS6lM8kl8
 rPdqANuSuB3j6L1/iUkmy7Bl+/DCoWRowc9zQ9RBFOv78OyZE+NjN4m7r9Ksz5jnNtcOfxhnRB
 aGq3NRQI97mHlcp+1yA0emgFCPFcmLsWTpx1YhHu1zC0agI6/1Pxt/dt7wHPMJ3M/yV4zJE4QX
 YgImPnPgDs6GPOPKI3tbgOU4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:54 -0700
IronPort-SDR: RzmF+wCVaHIoL3gwNBEeyA5mzfSSzNMLObtJ5ILaJA+iGqjzX5ddkHxRV0ZGwDsQyksHtT+IZx
 fgrt1wtyD3d3a6vz8N20e59/NAfCHlluR1LW+b1OOa3uzd9RMiBhhPFtntBtOz6qMlbvCSVBtq
 UXOQsH4Csa3uRZ+38huM568wW/OQUuXe0dbEYNNfSvmFgsQ7qeu/WGCMn6E52zQQSYpdPRDozi
 OyV+UMFU8TAr+1ybbt83sKfLL8rl65FOhk6hmlgzTzIGV2FfHT4MFzA78CVHGu80Bhudz0A/a5
 s74=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 13/27] btrfs: reset zones of unused block groups
Date:   Fri, 23 Aug 2019 19:10:22 +0900
Message-Id: <20190823101036.796932-14-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For an HMZONED volume, a block group maps to a zone of the device. For
deleted unused block groups, the zone of the block group can be reset to
rewind the zone write pointer at the start of the zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 27 +++++++++++++++++++--------
 fs/btrfs/hmzoned.c     | 21 +++++++++++++++++++++
 fs/btrfs/hmzoned.h     | 18 ++++++++++++++++++
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0f845cfb2442..457252ac7782 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1937,6 +1937,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+			struct btrfs_device *dev = stripe->dev;
+			u64 physical = stripe->physical;
+			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
 
@@ -1944,19 +1947,23 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
+
 			req_q = bdev_get_queue(stripe->dev->bdev);
-			if (!blk_queue_discard(req_q))
+
+			/* zone reset in HMZONED mode */
+			if (btrfs_can_zone_reset(dev, physical, length))
+				ret = btrfs_reset_device_zone(dev, physical,
+							      length, &bytes);
+			else if (blk_queue_discard(req_q))
+				ret = btrfs_issue_discard(dev->bdev, physical,
+							  length, &bytes);
+			else
 				continue;
 
-			ret = btrfs_issue_discard(stripe->dev->bdev,
-						  stripe->physical,
-						  stripe->length,
-						  &bytes);
 			if (!ret)
 				discarded_bytes += bytes;
 			else if (ret != -EOPNOTSUPP)
 				break; /* Logic errors or -ENOMEM, or -EIO but I don't know how that could happen JDM */
-
 			/*
 			 * Just in case we get back EOPNOTSUPP for some reason,
 			 * just ignore the return value so we don't screw up
@@ -8976,8 +8983,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&block_group->lock);
 		spin_unlock(&space_info->lock);
 
-		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD);
+		/*
+		 * DISCARD can flip during remount. In HMZONED mode,
+		 * we need to reset sequential required zones.
+		 */
+		trimming = btrfs_test_opt(fs_info, DISCARD) ||
+				btrfs_fs_incompat(fs_info, HMZONED);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index b5fd3e280b65..3d7db7d480d4 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -593,3 +593,24 @@ int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info)
 
 	return btrfs_commit_transaction(trans);
 }
+
+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
+			    u64 length, u64 *bytes)
+{
+	int ret;
+
+	ret = blkdev_reset_zones(device->bdev,
+				 physical >> SECTOR_SHIFT,
+				 length >> SECTOR_SHIFT,
+				 GFP_NOFS);
+	if (!ret) {
+		*bytes = length;
+		while (length) {
+			set_bit(physical >> device->zone_info->zone_size_shift,
+				device->zone_info->empty_zones);
+			length -= device->zone_info->zone_size;
+		}
+	}
+
+	return ret;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index e95139d4c072..40b4151fc935 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -32,6 +32,8 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
 bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 				   u64 num_bytes);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group_cache *cache);
+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
+			    u64 length, u64 *bytes);
 int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -107,4 +109,20 @@ static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)
 	return ALIGN(pos, device->zone_info->zone_size);
 }
 
+static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
+					u64 physical, u64 length)
+{
+	u64 zone_size;
+
+	if (!btrfs_dev_is_sequential(device, physical))
+		return false;
+
+	zone_size = device->zone_info->zone_size;
+	if (!IS_ALIGNED(physical, zone_size) ||
+	    !IS_ALIGNED(length, zone_size))
+		return false;
+
+	return true;
+}
+
 #endif
-- 
2.23.0

