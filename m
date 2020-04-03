Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F25619D4C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390512AbgDCKNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56735 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908785; x=1617444785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VAexep2FtXqCN5SCJ3uHplSg+43mZm/ggMW4xnbE9g8=;
  b=Jq3JwJ4V9JjcNTQfXd6ou7+FsvCymMqx484oYn9ylAYMKpj6TmN6jbIs
   OKne1uSZrHTo3Kk4EYuhOk2YV7uioVOtEUuwX3rjnRdgpWiqcerJoWZgQ
   LYZfoPs+PUHzu4y4ddvfL8ueEmEE50p3Gg6NJcvWqfs2WzgraLjanj3r4
   /2V07uV3Y02KzWyJL+iRlMbuVVfylPfvB2y/c97ZGo/vkgxDMcm1qsRtY
   7m53Uotfrnbgy/n1pjA7XvRQvBErpMjL1heYBWK1ypmJ7mjitvtnt5p1j
   kZ3CoemymeEdTOdtFfHP9AH6ocqYC9jp+TfA/vnWpR2o06tmecP3NDeaf
   Q==;
IronPort-SDR: L+0WP4dTQWgOcJ3z3UbLdIvDI9qpzU1ektWoukpEpCwczr2RVft0oBC9/QWWmyfPVejhwtkz9V
 BcNisVwhFizgmUcZz8IL5ccVzVYw4kprlU+wxPGsUTl3G6FBr5gFjUxZcXXcpso2/IStasfBAK
 NQFs8eo4UDW37xARnJIZy9B7Bl/19BGdGgzp3EaTuHtElbFYDVRZ6Yt2/4LWjfGAcHFvkKX+ZG
 BZOSVtndmxfpN9+8QJLm5CKWtDyX5AgzoowZuXpA1N4i1iiCwQ72jyhvQBWjrbbiE5VTkAIHFJ
 AfA=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135956014"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:13:05 +0800
IronPort-SDR: WpsHcIdcCWmcCCptMqq1lNkzsd33scaESx3suL/ucADCHaGMNB6X1V+7vmrDOPa5io38majEA2
 TYsesjb89PWRoAFU+BQW9ziYPLy181++EMT+h3jjyj77SinbLw6WMOOgCJuPUtiZK/JYez+Mo8
 sn5PrTuOcpi54TRgUOV+IWvG/6/5VPJPFsie9t3XY3vWeR14D+BhVm1ZykjNwDZf5jVGnne+/I
 6Gy3YxAHlBRVmlGOox/zMXWl9bTBE/FLZ8/+UeQEIdT8K0imvr//JUgSXakB1PoIsjFEeOrurS
 rEhlqbEVAyy/2mnHTfHA/o+2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:03:54 -0700
IronPort-SDR: VxveQzL7EwNtk5KJYcriYhTgBDnz8Sb8ib0KspGo3d2uHAEptBYvkCEotB43bi/TkhBJsjTVcz
 CMYdZU8RjPpiMZ9FsZ/8Ubf32EEhc4zRdJrbyuGiuV34/UDjAIZnaalb0z/6fjdZQFLMV9E1Wf
 54rUYdVcdHY8vlhNjGefEsEsvhsf/l4WnjsxZRSa0TUW3RkSmgftR6k83yTU+39CWhOqTdGEZZ
 Hftl4MhCb8TK5gjTdKsTeVHs+27C1HRkAMukwtOS5RIJ+/XEiO8p5S/KUGTdViATVhydrJZZs6
 RMQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:13:02 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v4 04/10] block: Modify revalidate zones
Date:   Fri,  3 Apr 2020 19:12:44 +0900
Message-Id: <20200403101250.33245-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

Modify the interface of blk_revalidate_disk_zones() to add an optional
revalidation callback function that a driver can use to extend checks
and processing done during zone revalidation. The callback, if defined,
is executed once for each zone inspected and a final time after all
zones are inspected. blk_revalidate_disk_zones() is renamed as
__blk_revalidate_disk_zones() and blk_revalidate_disk_zones()
implemented as an inline function calling __blk_revalidate_disk_zones()
without no revalidation callback specified, resulting in an unchanged
behavior for all callers of blk_revalidate_disk_zones().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c      | 38 +++++++++++++++++++++++++++-----------
 include/linux/blkdev.h | 11 ++++++++++-
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 00b025b8b7c0..a5fed0fa1504 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -353,12 +353,14 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q)
 }
 
 struct blk_revalidate_zone_args {
-	struct gendisk	*disk;
-	unsigned long	*conv_zones_bitmap;
-	unsigned long	*seq_zones_wlock;
-	unsigned int	nr_zones;
-	sector_t	zone_sectors;
-	sector_t	sector;
+	struct gendisk		*disk;
+	revalidate_zones_cb	revalidate_cb;
+	void 			*revalidate_data;
+	unsigned long		*conv_zones_bitmap;
+	unsigned long		*seq_zones_wlock;
+	unsigned int		nr_zones;
+	sector_t		zone_sectors;
+	sector_t		sector;
 };
 
 /*
@@ -432,25 +434,37 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
+	if (args->revalidate_cb)
+		args->revalidate_cb(zone, idx, args->revalidate_data);
+
 	args->sector += zone->len;
 	return 0;
 }
 
 /**
- * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
- * @disk:	Target disk
+ * __blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
+ * @disk:		Target disk
+ * @revalidate_cb:	LLD callback
+ * @revalidate_data:	LLD callback argument
  *
  * Helper function for low-level device drivers to (re) allocate and initialize
  * a disk request queue zone bitmaps. This functions should normally be called
  * within the disk ->revalidate method for blk-mq based drivers.  For BIO based
  * drivers only q->nr_zones needs to be updated so that the sysfs exposed value
  * is correct.
+ * If driver @revalidate_cb callback function is not NULL, the callback will be
+ * executed for each zone inspected as well as a final time to apply changes
+ * under with the device request queue frozen.
  */
-int blk_revalidate_disk_zones(struct gendisk *disk)
+int __blk_revalidate_disk_zones(struct gendisk *disk,
+				revalidate_zones_cb revalidate_cb,
+				void *revalidate_data)
 {
 	struct request_queue *q = disk->queue;
 	struct blk_revalidate_zone_args args = {
-		.disk		= disk,
+		.disk			= disk,
+		.revalidate_cb		= revalidate_cb,
+		.revalidate_data	= revalidate_data,
 	};
 	unsigned int noio_flag;
 	int ret;
@@ -480,6 +494,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		q->nr_zones = args.nr_zones;
 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
 		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
+		if (revalidate_cb)
+			revalidate_cb(NULL, 0, revalidate_data);
 		ret = 0;
 	} else {
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
@@ -491,4 +507,4 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	kfree(args.conv_zones_bitmap);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
+EXPORT_SYMBOL_GPL(__blk_revalidate_disk_zones);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e591b22ace03..49f41562b3f9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -353,6 +353,9 @@ struct queue_limits {
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 			       void *data);
 
+typedef void (*revalidate_zones_cb)(struct blk_zone *zone, unsigned int idx,
+				    void *data);
+
 #ifdef CONFIG_BLK_DEV_ZONED
 
 #define BLK_ALL_ZONES  ((unsigned int)-1)
@@ -362,7 +365,13 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);
 extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 			    sector_t sectors, sector_t nr_sectors,
 			    gfp_t gfp_mask);
-extern int blk_revalidate_disk_zones(struct gendisk *disk);
+int __blk_revalidate_disk_zones(struct gendisk *disk,
+				revalidate_zones_cb revalidate_cb,
+				void *revalidate_data);
+static inline int blk_revalidate_disk_zones(struct gendisk *disk)
+{
+	return __blk_revalidate_disk_zones(disk, NULL, NULL);
+}
 
 extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 				     unsigned int cmd, unsigned long arg);
-- 
2.24.1

