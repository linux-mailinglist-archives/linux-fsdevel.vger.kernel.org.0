Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A4211246D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLDITx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfLDITw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447592; x=1606983592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZOJWDCO29Lzs1E0Bi4IJaDaHtj6nm3ML/WZWkr7HtVk=;
  b=Fa5Rsuf8WQOyn/48MjrocOuPxWXLumrQ0iEchUB/0JkE32hFrjWsm+zT
   eBtbUqIyZcawQ7IuiWDe/FLDd6FuY23A3rUBWhoVLx3QK2wVAfzV3s/Es
   rnbOrayL3Csp9m9AWuEkZxy7BWBoHcRxqt+Icr83XJpbdCba4jibUy5de
   OwMzCqJkCXEQrcbCel395976R0Cei4n+jAjiLYyC2N6tHEeY2WNKUl0Pu
   TTx6b3olu3iTSJFfVXnmIhc7wztGPKU5n89UhlRRXXRghOPDkxHn3+kM0
   L3WS63PgRdC+RwdNHbChWAQio48TFVJDud/jc0rOJ7F2VAfDkwubLApSA
   g==;
IronPort-SDR: 35JrSpGblRX9M3RDKAYZ6WSXi7OT5vJrtYdtc8cZBK2aja34O27SpoNyQKLS4PEqQe0mUB73Gt
 JW8LAeJ+AwrNFFzKuAwpIoKfCF2j7j5DJjFu+0qiTf4UqFEJKJHwbL1Tv+amO8z0F3kgyZpRGR
 Ot2T8LmxCp6g++OchGbniSEKKERbYoFiH4QB67IWxqDPAPNJe0Gx0pkxFGx243IxYqQ0+EljYV
 HO07wtPgHvtv7Jwuja7wBWnicS0+2FsNkwWbx6q3p1rWIpZAQD/6kon/dMHx7QNHkn64107lQ/
 RCQ=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355078"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:52 +0800
IronPort-SDR: TWwM2B2Uc0xYWgl2o+73CWv7z0j63BThL29Mg2iXHMzHyK4O/tGQrF51a/TTmX3moJp7bf8SHT
 Jfk5OWp15GR6jZ4T6gQO35pRdrh3apj5Hu6npZiWbvWEzOLz7RTXv2DrGne0OFW1xNkuvY8tLf
 qpyXzkbyWBb0mueyMQKRg1BbR781Pu7WziC54WjUloBIlzOA6qowLeIWNiFdBrZMDyW2TPGvi1
 s2Sdh36wxPtWqOM4gQHPzlkLu/H7hXc/1OIQTxOfOoKkrGuFKfVVmPAVHSXx/OzNdcdaWrRxZ9
 mu8aDb9KnQQ2Kc3XUZaV1I0K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:17 -0800
IronPort-SDR: xQ5Hl5FHDUGJN9LAfs/mtaSfZm7Mz4F63ZflWdzoBHT4W/33Bfo8CVnFRjLdi8LNy6VUm3Ka+2
 lZ0M+LG/GTbtubs8pFtb42NJWQTp3rhP24NE5xg1c2ic1Cq8As/ObNMJk7xDRfe8g7GHDGnJaM
 zg5V6b4oU8NFwZoNSgSD3rbTuR3wcFN9tzE+OX/MO2rCeOAzq3B9SePslwv2OeEi0xhIyYTI/M
 uXxvdMZeMiqo/Mx9zFV9E6Jc2NRkOwshuAPS/whU6N7e6lJTzWk48LdgBG2EJF2Qe7dYPckxRi
 ZqE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:48 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 13/28] btrfs: reset zones of unused block groups
Date:   Wed,  4 Dec 2019 17:17:20 +0900
Message-Id: <20191204081735.852438-14-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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
index 4fd96fd43897..0eb4f578c54a 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -1120,3 +1120,21 @@ int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info)
 
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

