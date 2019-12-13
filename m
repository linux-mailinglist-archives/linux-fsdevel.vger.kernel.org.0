Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAB11DCE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfLMELH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:07 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11907 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbfLMELH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210267; x=1607746267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G6sdGsoJ6mrUehm8dIo8WrICIe1NCMsYkOQULpp1omU=;
  b=EGCUViCzg+0iQYPdnJu6QZvWT9wego/Ta3v5K6SJFT5JfhUUaapRR2u5
   +oY9frmTkcTrRXnG4qfeUWI2aX4u+k/QMADfHqtKNA0tVWxAhtzSuiP8Q
   5DpNJbOtWTLNcGKkmuaXETUC4DQlPs30N+1uQJ+bi8Ezln2cBAOU341eo
   6Vx4sfKx9pu6uqwGzA83ZQfyOiklKYB704y/9bnw979WTa9L4FWXgkCry
   3UzDiIki3/btFdE36nAlcyyGGkKiuB/R2m7R7F08KiD8bmLm8HUHbc4OV
   DIjEY3g+e7A/y47MmdD047ZBjHjASlx/aYYM+HpOohJvOiDezBbvtMw1/
   g==;
IronPort-SDR: Nz/rG2TxpLXw6LTggDIrocAi0MhnaAcfC5wDWHoUEzLxkxDXsrWHl+Cu5vRTzHPbvyGrIwE/8c
 6Ej+4dkvoAtVuTDXyHbF6AFMwYHsTTtvbG4uTtLzeAei5+wrD6UIioci6V0oVmKbEt35KtBg/B
 6ASAND3gTBPW7amF1/kcQz7Do/YPratbCJ0kzPo1r/3t6pOT/3Rsk0WQy8GvBTtSSMN8f4tRHX
 Tog5ua8/BaFEf0gsA3pwbqCYbgJMEd5KZIkP+zcWCxMm1FJHYf+ODzlFAjWZBuEzMbC4J79aeP
 g8g=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860133"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:07 +0800
IronPort-SDR: G96FeQjX0vRuO9bGtXCqFNXRzy4MJDlHYOhETPwsSmg0nk+A/2kefNeJmaM2IXr3qPNEve/RrA
 OktXuhs2vp5ODYQd5K4unF16jDTdd9SBX0EQMzNxOgUBGrPOSk6Z2x65FZuYqHM3sGOM57Rz21
 yYK+K30Ohj0pU8gWASP6Ro+aH4hXTzKdktMULAu2x9yLUzuGaV1ZQhqBmTOQpwG5vtjHpeCkiB
 pJHOJM7NFyRHWQDOFYogC5R1FM44x1rWbe9lr+5dien1onyTdqw8ecFBjyI0/djhXjs68faniB
 zhOkFyJccTzV+Yz6EZFDal2z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:38 -0800
IronPort-SDR: OvWIrmrlRpFx4XIP3+DUB6muv8LplN0Wv5YtaP8Iv1QW8q/D6ZAFYZ9rZ23xBiUFY8d04frcRy
 VvDNJUOl+EJlHaITn9RDtSnRA1bFmvTKLF6YiPgHNJQ9MZRS3VrO9/NHW01VlcHztefRy5RfK/
 97ENmwvFrCRlL10/lOZkI62OR+4feM19g++6VOY7T2BIgZir/s2iq4LKPQTULyQMkUvXb+2iD2
 K0YcW7zlJSm4FUycsFkYkB38vz7qWRYZieeSyF9X5y9tXYCP0w3SfWw2hzlHEH2GScp1e4QPRe
 5ds=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:04 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 13/28] btrfs: reset zones of unused block groups
Date:   Fri, 13 Dec 2019 13:09:00 +0900
Message-Id: <20191213040915.3502922-14-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
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
 fs/btrfs/block-group.c |  8 ++++++--
 fs/btrfs/extent-tree.c | 17 ++++++++++++-----
 fs/btrfs/hmzoned.c     | 18 ++++++++++++++++++
 fs/btrfs/hmzoned.h     | 23 +++++++++++++++++++++++
 4 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b286359f3876..e78d34a4fb56 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1369,8 +1369,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3781a3778696..b41a45855bc4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1338,6 +1338,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+			struct btrfs_device *dev = stripe->dev;
+			u64 physical = stripe->physical;
+			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
 
@@ -1345,14 +1348,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
+
 			req_q = bdev_get_queue(stripe->dev->bdev);
-			if (!blk_queue_discard(req_q))
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
 			if (!ret) {
 				discarded_bytes += bytes;
 			} else if (ret != -EOPNOTSUPP) {
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 1a2a296e988a..0ca84d888e53 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -1117,3 +1117,21 @@ int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info)
 
 	return btrfs_commit_transaction(trans);
 }
+
+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
+			    u64 length, u64 *bytes)
+{
+	int ret;
+
+	ret = blkdev_reset_zones(device->bdev, physical >> SECTOR_SHIFT,
+				 length >> SECTOR_SHIFT, GFP_NOFS);
+	if (!ret) {
+		*bytes = length;
+		while (length) {
+			btrfs_dev_set_zone_empty(device, physical);
+			length -= device->zone_info->zone_size;
+		}
+	}
+
+	return ret;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 8ac758074afd..e1fa6a2f2557 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -43,6 +43,8 @@ bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
 int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info);
+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
+			    u64 length, u64 *bytes);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -103,6 +105,11 @@ static inline int btrfs_hmzoned_check_metadata_space(
 {
 	return 0;
 }
+static inline int btrfs_reset_device_zone(struct btrfs_device *device,
+					  u64 physical, u64 length, u64 *bytes)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -189,4 +196,20 @@ static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)
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
2.24.0

