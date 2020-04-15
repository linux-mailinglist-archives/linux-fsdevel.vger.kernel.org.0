Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236A01A97D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393870AbgDOJFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:05:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19515 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393862AbgDOJFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586941535; x=1618477535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EZGgCaxhmOjWPMpG7WdR3trpTne96AwC+nAojHGYRdc=;
  b=KRMMq/dxdZHNjoV+OvXfNPfsghap6rqDGiCtVQP/CNkUbaoRXg3s+p3+
   c3+l2EGYQdGn2p/rESF1sA0AnkQcmeypXLHwmGD3nDd7ZUQWA0F5KyFlA
   jLHPbCI4SUNRFlt7uIURV8J3zamB6NK7MFT9JLo4P/OL+dh4WNd4+xzPe
   nWx9UPkuAxhdBvFScCb1l2jRUsdN5y4FLhdTLXE9qcw5+nyYGfXZ9+Lf8
   ZNsn0pJfnMcgfmqcm+JINa2oqwLv1bBvxoaQ9QRqDtq3HzugwEQi8/Wut
   xAA7eLHatEw9p7+1dObhVbb9BRan4E3rPeIeywTJyB9sWr9sevobgznGe
   w==;
IronPort-SDR: O/Yy1NarxNjJQ9Qj6AuvfCG//Mzof87BRHupzIRlNkzgj3UyWTlkEW1hiIuxvh2jx5N85hrDaH
 RdVtT91aLKGPHKadwyAB08ekJDmNgp0EW1HduDZXA6sQSLVQOgJo7+KI48843u88JC5ZxrQ+BR
 6El62SaF3yglZHNvSU4Smj7EIAV8Dp9zMb2HdxR3PAC/7DAlAuOD/x9A7a13ax7z49ggB7A+bR
 sq7rvqwRPhOBgK8rMqpwGnDw2fw55viSE27Lj3gLxkosOTa+oQxVEjVhe/elJHuEG9Jyp9jsvo
 aoE=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="136802987"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:05:33 +0800
IronPort-SDR: NHNLDTPTPM1js7NMbKRMP3yQ1bUdMJ8r82k2k8qGaUMZLycIl6ruqpbr+UYX8Fm4YFDMxtrK/L
 gaYcA3Jn3J6ccBTRSwM0G9zisIHFMvuia9F2NylhyaGsCcdEtJoHZvPcTzti73jC+nu9s4x/fW
 UrYBYosoRdhJBe6LDGbH+S2s7LLy02WvGASWNx7kCuj84pUVE4wAE/54rufESPCoR302+ouTpA
 iqfo8xta3S29uzaH9aoEOMHQBd0QYl9p2yWUeRQkevOj5b/tJ7WhC2XqvXI3IEkUhSvoqP4Fut
 17yBtPJ4/V3SnP9IKW6VnA4w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:56:35 -0700
IronPort-SDR: J4P2vw+hHRLrI+fFzRnvFTTG6uvGiNmHYnMX3PE5RUE7sANHkmvBqqbL7LkEClKL5NWaDGateo
 B3HmnnYSrQ98nJQgmxQXpdMMf2rSS+H0oddW9re7H1M9xxCXLbRBv3QWVurIM07/MU/lzzQ698
 VZ7B422+Vq1bvOMXbP+KHmxDmrRt1h7Som1UIC8CZ8EjLNBK515OO3zTpRq7njq1bfqLwLYmXn
 rDss1JxpAM1bSm1YTtaPD3f/16HUEz/5I588hEy6aHNIyoKd2tb4cpys7QMS33yZzablZlEfWY
 a8g=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Apr 2020 02:05:32 -0700
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
Subject: [PATCH v6 06/11] block: Modify revalidate zones
Date:   Wed, 15 Apr 2020 18:05:08 +0900
Message-Id: <20200415090513.5133-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

Modify the interface of blk_revalidate_disk_zones() to add an optional
driver callback function that a driver can use to extend processing
done during zone revalidation. The callback, if defined, is executed
with the device request queue frozen, after all zones have been
inspected.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c              | 8 +++++++-
 drivers/block/null_blk_zoned.c | 2 +-
 include/linux/blkdev.h         | 3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c822cfa7a102..2912e964d7b2 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -471,14 +471,18 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 /**
  * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps
  * @disk:	Target disk
+ * @driver_cb:	LLD callback
  *
  * Helper function for low-level device drivers to (re) allocate and initialize
  * a disk request queue zone bitmaps. This functions should normally be called
  * within the disk ->revalidate method for blk-mq based drivers.  For BIO based
  * drivers only q->nr_zones needs to be updated so that the sysfs exposed value
  * is correct.
+ * If the @driver_cb callback function is not NULL, the callback is executed
+ * with the device request queue frozen after all zones have been checked.
  */
-int blk_revalidate_disk_zones(struct gendisk *disk)
+int blk_revalidate_disk_zones(struct gendisk *disk,
+			      void (*driver_cb)(struct gendisk *disk))
 {
 	struct request_queue *q = disk->queue;
 	struct blk_revalidate_zone_args args = {
@@ -512,6 +516,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		q->nr_zones = args.nr_zones;
 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
 		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
+		if (driver_cb)
+			driver_cb(disk);
 		ret = 0;
 	} else {
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 9e4bcdad1a80..46641df2e58e 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -73,7 +73,7 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	if (queue_is_mq(q))
-		return blk_revalidate_disk_zones(nullb->disk);
+		return blk_revalidate_disk_zones(nullb->disk, NULL);
 
 	blk_queue_chunk_sectors(q, nullb->dev->zone_size_sects);
 	q->nr_zones = blkdev_nr_zones(nullb->disk);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0797d1e81802..62fe9f962478 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -362,7 +362,8 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);
 extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 			    sector_t sectors, sector_t nr_sectors,
 			    gfp_t gfp_mask);
-extern int blk_revalidate_disk_zones(struct gendisk *disk);
+int blk_revalidate_disk_zones(struct gendisk *disk,
+			      void (*driver_cb)(struct gendisk *disk));
 
 extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 				     unsigned int cmd, unsigned long arg);
-- 
2.24.1

