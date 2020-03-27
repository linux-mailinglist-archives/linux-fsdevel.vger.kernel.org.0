Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC83F195B87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgC0Qub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 12:50:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2590 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgC0Qua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585327830; x=1616863830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0x46aiJQVLk+zdk3MjudKqj10oWp8p31iapMZu1OrXo=;
  b=NYYADsZvCcaYC4rhoTn8tdXgJHDHEkfd+5OL7rLMMvN0ys3qeHQ5fd7W
   lMT6e9JZ+RtDKc1ipch4/QbGbjTgIyn5wFaQXNgwGRMEJTEx8qFdqUEbL
   RYwk10y2yc2xQpE45i1FaJPXfWvT9YszTaBhdoAjNtDuCihpoZglmNlcd
   xwWuld12u/pHKcR9P6ixmDgLIgybXSFZ2cZyeJw75xNuid7k5ClXXatQx
   AT6rK2qCudn0ZlPvbxAPwKp3707CKAMvPqOog+w0QO19F2nTX1VZunjor
   7+Anr5nZ6II5+6I+ATI4CUUcZzR2ARW8nMBGQN5LBQCykt2D//upS0+NY
   w==;
IronPort-SDR: CJx6oW1Pfgn98X7a7B/Mlb7/GiW3ZVZljN719Lijf7Yvj4gETDAKBH6DZMg7jNqG1LXlVQux4/
 k5P9VrUjIcj0elB/Ns86fQbOYbTx8nYnXfxc8V6IDlJf8F0DWUUV52EN1320ESJvGV/zenRvLK
 vHZKZFGaKz8g/vNueColLN+Duxkmfp3JYBBz2fY3LIeo1oEXWoZlSHNs3QToHlWv52d3THi5q2
 RfTEh/n44z+Ha3RpWIwDHkmm5CthQJdCVeXLVGShJhkf+k2hN+bPXVQkHBi9sFyqnJkE2LVRh3
 Uyc=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242210459"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 00:50:29 +0800
IronPort-SDR: GAdek01ATE5zK0UjkpeIQF98GtdH0L8XAOEmQIN+X21I4mNm4eDSEsYElwkCsteOMDZ2XWQuVx
 QAvU1Ej+6i5Ce/zercDgPHkvKbvUE9ARZhQO2oiQkaN/rZCzLSCRwyRQifoYY6GlMQZwLalb0h
 YCelhMckYlT2M/cuWmpjrj6FFSrLyYOnit6Rqnzg0M34yLbx+MZ/hnYdL6HNN+vKNSmrosTE6E
 IJ2q0As1/KFlJ1MVTN19NxIhnTQcHMsbD47mlwNnV9onqVxijJHArufhtk6PlgUkzZ5icSY2MT
 gIrL6HH24/HGbgAv26ANQWkE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:42:04 -0700
IronPort-SDR: z8Z4I65d35Nd6xBkrVn2qTPb0v5JRSPeDJ/yor4G4gQ4F9Tz5z6mzltvXnDjlOqtyf7kINcmqV
 BNFXq4sqlPcdvVUJ+ypbt21OgxbRW0I0G29KjsY+fUQFGjQmmL86hbnmvpGui1nFkcEttihn61
 eqCZMtb8BjK12xYu36va7Q9ZXhGIV6SE9TAE5rt/Apa5g2UEUtkkDzcaH2tmXuFSBqOeU89nae
 7vLg4KyPBkBGphbgbV7IsemRp0/Sn0G1kM/hrEEY8I9DHtVgazNFCSHDOWR+GM8S61tONJjxhT
 A6s=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2020 09:50:28 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 07/10] null_blk: Cleanup zoned device initialization
Date:   Sat, 28 Mar 2020 01:50:09 +0900
Message-Id: <20200327165012.34443-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
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

