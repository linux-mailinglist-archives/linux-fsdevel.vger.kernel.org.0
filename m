Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BAB19144F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgCXPZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39883 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCXPZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063517; x=1616599517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0x46aiJQVLk+zdk3MjudKqj10oWp8p31iapMZu1OrXo=;
  b=CoiGN8lKREfURFg24MBDMHH1b1ko0JIgPK/NVYegxHNQ215zHc41d7Jy
   peFSgsJidO8HhN5TnxYJYoaMS1cSwpJ+3wFSi+I97LdTKorkySUDInIly
   qYR8cKK3NDLwGcAQ7GjPJ/hOSzRt/+id/uHF8q0rK8FM8iq9JUuuv9em4
   v4b1g9MAHNqUD2HjhCQNhyxwyMiBBaAnIMK1rgzWR5ABfP8C4Us+NVKzn
   VM5Cvl6ZztlhBZvrJcJlnA29BTVxtRL2MbztDliHKdn4pdS0YVyNCRxXR
   D8Eom21ujEtSh3TUt8mnYxe1MpvbRraRgs+tl7WfPZur8fnd2FyfEVhRa
   g==;
IronPort-SDR: G/M0yoI5fUTbTc6jX9f3vrz3mrJAWcCInzccTAS5SD4ydp6paU9X++uvPfLTCQ3+ahHSfdCdp4
 2z8xW0BhvyhvMe9mPC1sUTfyOygggVMhILEJ53rXkDfYjxz5OCix6CF5RGrSFsAH1mL9nI9HV/
 gycNEV94ueC2Zubq4If4SMLNLNeaa1eJOH9nrdMsO19gs3UmR5LJ2PaiYdLAkgSY4Oespaexbt
 01jXOfhhSVUMZcuZ15hfMxLqXbKMCnvZPOe/Utpkv0a7QB3olT+TEvgmZUKeMRv6IoO5jXen4H
 tH0=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371573"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:17 +0800
IronPort-SDR: OFdjeG/L2N6VIMrcSbNCquh+meUhMLeGl08r+8jnaR1mmV4+1mI1NlFLzKl+HJGHEgMO0zJmSj
 ubSKqUZ8u6u5gAwoGCtV1K8iibCIKCAKqwcrK/Sf3pM5St3WsV6Z28o75CCSA+/YVW4vILHrHR
 6vwraSdw+nL9nLVqFvl2VUbeAr5n1Mg3GTwyNAG7LFX9NISyg28Ln4W5V4fxzXJal9OzgZvW+f
 bdcplzN6OxQ9RQ8NaWk6SaDboFEWQ8KxgXhQa8JMK8nx0p2s0ykttq82XK/8b3Hp0foazObK7c
 LE7lnjHq6TasUjNZ+99VSD0N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:16:57 -0700
IronPort-SDR: tGwLEnSY2HwNg2JENZJxRSGxZDqUSupaAnmcpYuMPP0LOImzt0tckFXZry+8i9aO/bjIytgRMF
 xReVUv9osGlfJPZ1N3nLEO7BIPdLd/ZwCwfM4r7jMyp5Jpj/JSVXGTRRkZnLCnkEmVvB8zY6Yc
 /VrcAeW4WfsDe+jnkd9yjW4dgG/0y8chKQZ7g4RFPU7kCitUglGAPSjEOMqCnZk1dhg19l9iZF
 v0E08skxo5FB99/Aky2mY4Lxsmpbw3m4K84grDiImWtILa/1K5YCW0K26/SWl3adOLWBeJJdGg
 t0w=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:15 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 08/11] null_blk: Cleanup zoned device initialization
Date:   Wed, 25 Mar 2020 00:24:51 +0900
Message-Id: <20200324152454.4954-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

Move all zoned mode related code from null_blk_main.c to
null_blk_zoned.c, avoiding an ugly #ifdef in the process.
Rename null_zone_init() into null_init_zoned_dev(), null_zone_exit()
into null_free_zoned_dev() and add the new function
null_register_zoned_dev() to finalize the zoned dev setup before
add_disk().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk.h       | 14 ++++++++++----
 drivers/block/null_blk_main.c  | 26 ++++++--------------------
 drivers/block/null_blk_zoned.c | 21 +++++++++++++++++++--
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 62b660821dbc..2874463f1d42 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -86,8 +86,9 @@ struct nullb {
 };
 
 #ifdef CONFIG_BLK_DEV_ZONED
-int null_zone_init(struct nullb_device *dev);
-void null_zone_exit(struct nullb_device *dev);
+int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q);
+int null_register_zoned_dev(struct nullb *nullb);
+void null_free_zoned_dev(struct nullb_device *dev);
 int null_report_zones(struct gendisk *disk, sector_t sector,
 		      unsigned int nr_zones, report_zones_cb cb, void *data);
 blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
@@ -96,12 +97,17 @@ blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
 size_t null_zone_valid_read_len(struct nullb *nullb,
 				sector_t sector, unsigned int len);
 #else
-static inline int null_zone_init(struct nullb_device *dev)
+static inline int null_init_zoned_dev(struct nullb_device *dev,
+				      struct request_queue *q)
 {
 	pr_err("CONFIG_BLK_DEV_ZONED not enabled\n");
 	return -EINVAL;
 }
-static inline void null_zone_exit(struct nullb_device *dev) {}
+static inline int null_register_zoned_dev(struct nullb *nullb)
+{
+	return -ENODEV;
+}
+static inline void null_free_zoned_dev(struct nullb_device *dev) {}
 static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
 					     enum req_opf op, sector_t sector,
 					     sector_t nr_sectors)
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index e9d66cc0d6b9..3e45e3640c12 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -580,7 +580,7 @@ static void null_free_dev(struct nullb_device *dev)
 	if (!dev)
 		return;
 
-	null_zone_exit(dev);
+	null_free_zoned_dev(dev);
 	badblocks_exit(&dev->badblocks);
 	kfree(dev);
 }
@@ -1605,19 +1605,11 @@ static int null_gendisk_register(struct nullb *nullb)
 	disk->queue		= nullb->q;
 	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
-#ifdef CONFIG_BLK_DEV_ZONED
 	if (nullb->dev->zoned) {
-		if (queue_is_mq(nullb->q)) {
-			int ret = blk_revalidate_disk_zones(disk);
-			if (ret)
-				return ret;
-		} else {
-			blk_queue_chunk_sectors(nullb->q,
-					nullb->dev->zone_size_sects);
-			nullb->q->nr_zones = blkdev_nr_zones(disk);
-		}
+		int ret = null_register_zoned_dev(nullb);
+		if (ret)
+			return ret;
 	}
-#endif
 
 	add_disk(disk);
 	return 0;
@@ -1795,14 +1787,9 @@ static int null_add_dev(struct nullb_device *dev)
 	}
 
 	if (dev->zoned) {
-		rv = null_zone_init(dev);
+		rv = null_init_zoned_dev(dev, nullb->q);
 		if (rv)
 			goto out_cleanup_blk_queue;
-
-		nullb->q->limits.zoned = BLK_ZONED_HM;
-		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, nullb->q);
-		blk_queue_required_elevator_features(nullb->q,
-						ELEVATOR_F_ZBD_SEQ_WRITE);
 	}
 
 	nullb->q->queuedata = nullb;
@@ -1831,8 +1818,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 	return 0;
 out_cleanup_zone:
-	if (dev->zoned)
-		null_zone_exit(dev);
+	null_free_zoned_dev(dev);
 out_cleanup_blk_queue:
 	blk_cleanup_queue(nullb->q);
 out_cleanup_tags:
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index ed34785dd64b..8259f3212a28 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -10,7 +10,7 @@ static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 	return sect >> ilog2(dev->zone_size_sects);
 }
 
-int null_zone_init(struct nullb_device *dev)
+int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 {
 	sector_t dev_size = (sector_t)dev->size * 1024 * 1024;
 	sector_t sector = 0;
@@ -58,10 +58,27 @@ int null_zone_init(struct nullb_device *dev)
 		sector += dev->zone_size_sects;
 	}
 
+	q->limits.zoned = BLK_ZONED_HM;
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
+
+	return 0;
+}
+
+int null_register_zoned_dev(struct nullb *nullb)
+{
+	struct request_queue *q = nullb->q;
+
+	if (queue_is_mq(q))
+		return blk_revalidate_disk_zones(nullb->disk);
+
+	blk_queue_chunk_sectors(q, nullb->dev->zone_size_sects);
+	q->nr_zones = blkdev_nr_zones(nullb->disk);
+
 	return 0;
 }
 
-void null_zone_exit(struct nullb_device *dev)
+void null_free_zoned_dev(struct nullb_device *dev)
 {
 	kvfree(dev->zones);
 }
-- 
2.24.1

