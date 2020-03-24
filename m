Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814F0191445
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgCXPZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:12 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39883 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCXPZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063511; x=1616599511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/uhx75OfZ9BEuoe305IWDuoTT7irOcKi3CPWMDfrgcc=;
  b=e3+vhM+0lFs8gzgMBwp/Kd4xMjotiIlGnnurK3eF/y1S44MtcjW4C0cC
   xNFanWIvqgI9ngg8qEN9ryUY43VADDhPM/sJv5MwC2QIPZ/z0Rp/KBxen
   gw6WKJhRNA9ljxdEBZGVaEY+ovcAaS6ZFQ8rdu0jzt8cLY+OxW+g3CE/9
   GZRQoICrvJoOvcVSlL5L3VDY4u25baDeSJkWiI/rkxrqJJ5UsodEtZsLy
   0HMABLyuWzTh7CqbrJAWpCWmvEArOFJthZaFw3t1VteSk1WWQzcy30Kn5
   rpnxNW7GOT8FsGz12mGqrLJRkYt8/mDQFvrnY3Frn02QKHFyLlJ/KpJ6Y
   w==;
IronPort-SDR: KRFKLRzSa0ZQEMP2GV++apKLLxSy2JhVbw+jXYJMmtW6NTCBzOj+Xgy4wKJ275A0kKl2zJfojZ
 EDntc58nO09FFFW6/TRplc3GtoqEase6oLF5MCu70XmrFV/qhZe5RD4GBEyc932NydrWv0vyRE
 8qn6qLmWBKme6h4WIasNpLxnR31TBLIkg0VWZiAu6Kmh2A79nckQxv5r7ZeUhn4sVxEXQPml15
 Asd1I2vNXwz21naindKroRroPOETOHldltmlzSFd1RWq+t9PEf/lWf335xu1tWRKNFAaj2wAx8
 UDc=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371564"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:11 +0800
IronPort-SDR: qxy1CYSe68wxijLTso7nasLZXCTyFjW0tTYE4IYs9RXinR5NVASrqknz9zX3ZP02TB1RRLSpZV
 amprLuh3zJc3Hrmzjwe8PvXaz8xUYncyEILQ+xH6FJ8cFeuG6aumz2WxOdIGhd1Ota0Sodo4WF
 Kb+N/ya7IDrGkkdAF2qNyriy3Esr6NvjcS9iJSQyDIpNwt3Qr1DDVY+ESUcP87eAt0lCdf8wLF
 2CDyD7z4atDyEZJrT6rddLv6nubwPX5eC4qPkmC/WL22/uzwpJ6WW/Ezgf+sZgVZoLPoJkjdnI
 faSS5gDSeYp6ty2NHFbHP+pY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:16:51 -0700
IronPort-SDR: c3SHRY2PJhPw7GJjn2QCmBfhrJOUQRboEDgaa4UblPrPXmR4eWUsjiyGkNA5Nde7kU072kLAvQ
 ZKHZuu1//dI3M/imoojaFaZLMl/Ps9qJ0mbA+oGvut1D69++ke1XCe2lK1QRn+SySCorcpuOr6
 NaZZepvQGLQi2FsTX9nxXRmydZQLh4IShoV1YTOJZb1c68HU0E9rZ1vbKLynMKx41geaW5bn/L
 +AqQ2MvmwLMoMJX0QG6P/Kg4Aq11iuBaTtG5gwQoWP1Fs7STx84NF7cXrNLXhI5b6C3HYXDGcj
 RgA=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:09 -0700
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
Subject: [PATCH v2 05/11] block: Introduce zone write pointer offset caching
Date:   Wed, 25 Mar 2020 00:24:48 +0900
Message-Id: <20200324152454.4954-6-johannes.thumshirn@wdc.com>
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

Not all zoned block devices natively support the zone append command.
E.g. SCSI and ATA disks do not define this command. However, it is
possible to emulate this command at the LLD level using regular write
commands if the write pointer position of zones is known. Introducing
such emulation enables the use of zone append write for all zoned block
device types, therefore simplifying for instance the implementation of
file systems native zoned block device support by avoiding the need for
different write pathes depending on the device capabilities.

To allow devices without zone append command support to emulate its
behavior, introduce a zone write pointer cache attached to the device
request_queue, similarly to the zones bitmaps. To save memory, this
cache stores write pointer offsets relative to each zone start sector
as a 32bits value rather than the 64bits absolute sector position of
each zone write pointer position.

While it would be natural to have each LLD implement as needed zone
write pointer caching, the integration of this cache allocation and
initialization within blk_revalidate_disk_zones() greatly simplifies
the code and avoids potential races between the zone wp array size and
the device known number of zones in the case of changes detected during
device revalidation. Furthermore, initializing the zone wp array
together with the device queue zone bitmaps when
blk_revalidate_disk_zones() execute a full device zone report avoids
the need for an additional full device zone report execution in the LLD
revalidate method. This can significantly reduce the overhead of device
revalidation as larger capacity SMR drives result in very costly full
drive report zones processing. E.g., with a 20TB SMR disks and 256 MB
zones, more than 75000 zones need to be reported using multiple report
zone commands. The added delay of an additional full zone report is
significant and can be avoided with an initialization within
blk_revalidate_disk_zones().

By default, blk_revalidate_disk_zones() will not allocate and
initialize a drive zone wp array. The allocation and initialization of
this cache is done only if a device driver request it with the
QUEUE_FLAG_ZONE_WP_OFST queue flag. The allocation and initialization
of the cache is done in the same manner as for the zone bitmaps, within
the report zones callback function used by blk_revalidate_disk_zones().
In case of changes to the device zone configuration, the cache is
updated under a queue freeze to avoid any race between the device
driver use of the cache and the request queue update.

Freeing of this new cache is done together with the zone bitmaps from
the function blk_queue_free_zone_bitmaps(), renamed here to
blk_queue_free_zone_resources().

Maintaining the write pointer offset values is the responsibility of
the device LLD. The helper function blk_get_zone_wp_offset() is
provided to simplify this task.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-sysfs.c      |  2 +-
 block/blk-zoned.c      | 69 ++++++++++++++++++++++++++++++++++++++++--
 block/blk.h            |  4 +--
 include/linux/blkdev.h | 20 ++++++++----
 4 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 02643e149d5e..bd0c9b4c1c5b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -901,7 +901,7 @@ static void __blk_release_queue(struct work_struct *work)
 
 	blk_exit_queue(q);
 
-	blk_queue_free_zone_bitmaps(q);
+	blk_queue_free_zone_resources(q);
 
 	if (queue_is_mq(q))
 		blk_mq_release(q);
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index aefd21a5e6ff..c2172f502969 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -344,18 +344,65 @@ static inline unsigned long *blk_alloc_zone_bitmap(int node,
 			    GFP_NOIO, node);
 }
 
-void blk_queue_free_zone_bitmaps(struct request_queue *q)
+static inline unsigned int *blk_alloc_zone_wp_ofst(unsigned int nr_zones)
+{
+	return kvcalloc(nr_zones, sizeof(unsigned int), GFP_NOIO);
+}
+
+void blk_queue_free_zone_resources(struct request_queue *q)
 {
 	kfree(q->conv_zones_bitmap);
 	q->conv_zones_bitmap = NULL;
 	kfree(q->seq_zones_wlock);
 	q->seq_zones_wlock = NULL;
+	kvfree(q->seq_zones_wp_ofst);
+	q->seq_zones_wp_ofst = NULL;
 }
 
+/**
+ * blk_get_zone_wp_ofst - Calculate a zone write pointer offset position
+ * @zone:	Target zone
+ * @wp_ofst:	Calculated write pointer offset
+ *
+ * Helper function for low-level device drivers to obtain a zone write pointer
+ * position relative to the zone start sector (write pointer offset). The write
+ * pointer offset depends on the zone condition. If the zone has an invalid
+ * condition, -ENODEV is returned.
+ */
+int blk_get_zone_wp_offset(struct blk_zone *zone, unsigned int *wp_ofst)
+{
+	switch (zone->cond) {
+	case BLK_ZONE_COND_EMPTY:
+		*wp_ofst = 0;
+		return 0;
+	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_EXP_OPEN:
+	case BLK_ZONE_COND_CLOSED:
+		*wp_ofst = zone->wp - zone->start;
+		return 0;
+	case BLK_ZONE_COND_FULL:
+		*wp_ofst = zone->len;
+		return 0;
+	case BLK_ZONE_COND_NOT_WP:
+	case BLK_ZONE_COND_OFFLINE:
+	case BLK_ZONE_COND_READONLY:
+		/*
+		 * Conventional, offline and read-only zones do not have a valid
+		 * write pointer. Use 0 as a dummy value.
+		 */
+		*wp_ofst = 0;
+		return 0;
+	default:
+		return -ENODEV;
+	}
+}
+EXPORT_SYMBOL_GPL(blk_get_zone_wp_offset);
+
 struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
 	unsigned long	*conv_zones_bitmap;
 	unsigned long	*seq_zones_wlock;
+	unsigned int	*seq_zones_wp_ofst;
 	unsigned int	nr_zones;
 	sector_t	zone_sectors;
 	sector_t	sector;
@@ -371,6 +418,7 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	struct gendisk *disk = args->disk;
 	struct request_queue *q = disk->queue;
 	sector_t capacity = get_capacity(disk);
+	int ret;
 
 	/*
 	 * All zones must have the same size, with the exception on an eventual
@@ -406,6 +454,13 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
+	if (blk_queue_zone_wp_ofst(q) && !args->seq_zones_wp_ofst) {
+		args->seq_zones_wp_ofst =
+			blk_alloc_zone_wp_ofst(args->nr_zones);
+		if (!args->seq_zones_wp_ofst)
+			return -ENOMEM;
+	}
+
 	/* Check zone type */
 	switch (zone->type) {
 	case BLK_ZONE_TYPE_CONVENTIONAL:
@@ -432,6 +487,14 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
+	if (args->seq_zones_wp_ofst) {
+		/* Initialize the zone write pointer offset */
+		ret = blk_get_zone_wp_offset(zone,
+					&args->seq_zones_wp_ofst[idx]);
+		if (ret)
+			return ret;
+	}
+
 	args->sector += zone->len;
 	return 0;
 }
@@ -480,15 +543,17 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		q->nr_zones = args.nr_zones;
 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
 		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
+		swap(q->seq_zones_wp_ofst, args.seq_zones_wp_ofst);
 		ret = 0;
 	} else {
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
-		blk_queue_free_zone_bitmaps(q);
+		blk_queue_free_zone_resources(q);
 	}
 	blk_mq_unfreeze_queue(q);
 
 	kfree(args.seq_zones_wlock);
 	kfree(args.conv_zones_bitmap);
+	kvfree(args.seq_zones_wp_ofst);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
diff --git a/block/blk.h b/block/blk.h
index 670337b7cfa0..8e6f4db1c7d2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -349,9 +349,9 @@ static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-void blk_queue_free_zone_bitmaps(struct request_queue *q);
+void blk_queue_free_zone_resources(struct request_queue *q);
 #else
-static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
+static inline void blk_queue_free_zone_resources(struct request_queue *q) {}
 #endif
 
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e591b22ace03..950d3476918c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -363,6 +363,7 @@ extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 			    sector_t sectors, sector_t nr_sectors,
 			    gfp_t gfp_mask);
 extern int blk_revalidate_disk_zones(struct gendisk *disk);
+int blk_get_zone_wp_offset(struct blk_zone *zone, unsigned int *wp_ofst);
 
 extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 				     unsigned int cmd, unsigned long arg);
@@ -499,14 +500,17 @@ struct request_queue {
 	/*
 	 * Zoned block device information for request dispatch control.
 	 * nr_zones is the total number of zones of the device. This is always
-	 * 0 for regular block devices. conv_zones_bitmap is a bitmap of nr_zones
-	 * bits which indicates if a zone is conventional (bit set) or
+	 * 0 for regular block devices. conv_zones_bitmap is a bitmap of
+	 * nr_zones bits which indicates if a zone is conventional (bit set) or
 	 * sequential (bit clear). seq_zones_wlock is a bitmap of nr_zones
 	 * bits which indicates if a zone is write locked, that is, if a write
-	 * request targeting the zone was dispatched. All three fields are
-	 * initialized by the low level device driver (e.g. scsi/sd.c).
-	 * Stacking drivers (device mappers) may or may not initialize
-	 * these fields.
+	 * request targeting the zone was dispatched. seq_zones_wp_ofst is an
+	 * array of nr_zones write pointer values relative to the zone start
+	 * sector. This is only initialized for LLDs needing zone append write
+	 * command emulation with regular write. All fields are initialized by
+	 * the blk_revalidate_disk_zones() function when called by the low
+	 * level device driver (e.g. scsi/sd.c). Stacking drivers (device
+	 * mappers) may or may not initialize these fields.
 	 *
 	 * Reads of this information must be protected with blk_queue_enter() /
 	 * blk_queue_exit(). Modifying this information is only allowed while
@@ -516,6 +520,7 @@ struct request_queue {
 	unsigned int		nr_zones;
 	unsigned long		*conv_zones_bitmap;
 	unsigned long		*seq_zones_wlock;
+	unsigned int		*seq_zones_wp_ofst;
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 	/*
@@ -613,6 +618,7 @@ struct request_queue {
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
+#define QUEUE_FLAG_ZONE_WP_OFST	28	/* queue needs zone wp offsets */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
@@ -647,6 +653,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #else
 #define blk_queue_rq_alloc_time(q)	false
 #endif
+#define blk_queue_zone_wp_ofst(q)	\
+	test_bit(QUEUE_FLAG_ZONE_WP_OFST, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.24.1

