Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D76FA1A385A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgDIQyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:54:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24715 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgDIQyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586451244; x=1617987244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tmksEDboe4ywDTGLgmwOeM5+BOGLe3IzaNWoQ4/NHho=;
  b=TLKgEHIKGUdVzU4YSTG8Wk2dK/A1QXgkux0ulsnL7p/p8LM3aAtbOxDp
   OlbnOhnsjTsZASeb5Q5iQWdofCMY+xFitNVqSx1bfpeNn+L22arqV+ltx
   8QaX+mAbpqt+mFc7i5BJZnQgRi+ScOejf7CO3YMulzuMllc23vG9qknNX
   z6sz3Eap2755wFTAXwKblrAMV+bUuQTrNjz/uZeA/IIMszDU9l3pz4fFV
   2lwDt+O0DJe5Uvz9yXYX57RUehASRXjF52mIWAeUz8l+6eJ+BRSw6tOZW
   w4GoQFv+Y7V08fYB3490Q8c5qQZ22ppYmuMceedTzXV6DReIh6RKuZyrd
   Q==;
IronPort-SDR: TZirsWmHGCcuCGDoj5OFR35AafJS0vZWlN8UIBYrZcrE6qvw1ccRDz3+hYzTyFYFzuO4tojN8h
 SR2Rc8hQFlVyhG1vC8kuVfWSy4pK9Sgp9jD/NK+Mv2VlDTPwWsZ/eNwF698ZgBKdkkcFejUoT0
 /xw446VHCP563S3Hvw4BOw8ZgpR0X7yMzvIJynyYfisrzTHXrZ7oW/4gqeHIErXDdotCfnwjPQ
 XhJODxQBCSFe67Bfj0WARUJ18hy1m9ReH+pCORhSuO4L5Ajp74t5y5w5xuT6xOYzMW07SXkEg1
 uu0=
X-IronPort-AV: E=Sophos;i="5.72,363,1580745600"; 
   d="scan'208";a="136423690"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 00:54:04 +0800
IronPort-SDR: K1jl0uT5hGMULBkUXY0Bqc54GOh6aw0sDkjwFqhvh8vmfj/M0cYhzuHLcEfNXSYZKWydflEfmw
 T11mQejKrFWROuUjzlQ1U3WqCOgsvvEq+6SIiwb8s6cJsseChhqcffmvFWe4Qi6BE5M8g9WXzn
 NMf/ABKKqWgTfnhgXaigl4bdGgZ8+w/5yhsN3AOBpVHVDEyV7W/LOQg5AnMqUP/T8MYRopr2/j
 SeTb4PR9lDuK9lV3/x06v4s8ncWIJsdbT8MOWu9Je74/galm7LlDfEMbjcEOPbBHC69GLP6rmM
 hlU9Q9CVdM6ByLZQsBJmwZD5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 09:44:42 -0700
IronPort-SDR: Ha6lzkHwhM0BaEUUAY089ZiFimgoH32MQnUX2l0jeICoxR7PEgWC8iwb6ifLxOOwH8qg/NT/Wu
 TwYLYqviTFepIoCReTuO8YT7CugOPDF1OpfMfrJFe2oTKOI07OzMkwXz3JuNIhhvJUOFD4+qNV
 6SPhLur+hLiN/NwVCjbtrXdVhrysBR1PeRnfMRqPoR395zIrQjwS4Rs7DT30jcWnYGeUiVI6B7
 zePw/hjeHDIodPE6w6MXG1hYvU17ymAlW6+WUyImkhAMk1nbka3nogRcY38JudBgA8gKmZrNnS
 8ss=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2020 09:54:02 -0700
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
Subject: [PATCH v5 04/10] block: Modify revalidate zones
Date:   Fri, 10 Apr 2020 01:53:46 +0900
Message-Id: <20200409165352.2126-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

Modify the interface of blk_revalidate_disk_zones() to add an optional
revalidation callback function that a driver can use to extend checks and
processing done during zone revalidation. The callback, if defined, is
executed time after all zones are inspected and with the queue frozen.
blk_revalidate_disk_zones() is renamed as __blk_revalidate_disk_zones()
and blk_revalidate_disk_zones() implemented as an inline function calling
__blk_revalidate_disk_zones() without no revalidation callback specified,
resulting in an unchanged behavior for all callers of
blk_revalidate_disk_zones().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c      | 19 ++++++++++++++-----
 include/linux/blkdev.h | 10 +++++++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 00b025b8b7c0..6c37fec6859b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -437,20 +437,27 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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
+ * If the @revalidate_cb callback function is not NULL, the callback will be
+ * executed with the device request queue frozen after all zones have been
+ * checked.
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
 	};
 	unsigned int noio_flag;
 	int ret;
@@ -480,6 +487,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		q->nr_zones = args.nr_zones;
 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
 		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
+		if (revalidate_cb)
+			revalidate_cb(disk, revalidate_data);
 		ret = 0;
 	} else {
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
@@ -491,4 +500,4 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	kfree(args.conv_zones_bitmap);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
+EXPORT_SYMBOL_GPL(__blk_revalidate_disk_zones);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e591b22ace03..a730cacda0f7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -353,6 +353,8 @@ struct queue_limits {
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 			       void *data);
 
+typedef void (*revalidate_zones_cb)(struct gendisk *disk, void *data);
+
 #ifdef CONFIG_BLK_DEV_ZONED
 
 #define BLK_ALL_ZONES  ((unsigned int)-1)
@@ -362,7 +364,13 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);
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

