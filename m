Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5446E1A3862
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgDIQyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:54:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24729 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgDIQyL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586451251; x=1617987251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m2H27AoyUGGLJggOB8uvDrziXzXN6LJ8DBjwSQ16qmI=;
  b=Q20SdBk4jpmaIKPfX1ICGCnPCua9NTDTxNNECHSuWT36mUSjLMnSb79n
   l1Wc1VoUoqb98CcVT0pWPm261wka8hL4ubDaGu19ve6j2esMUIcgl4uns
   JYZu1YEvDP5zMMb6g+Y8t99RW9xCDsowvx/sA9re+NJuqhn9QmipaXhGy
   eNuRfouAripObrjM47e7rFAicNlAAH7EOzcQL1pZhVxDDO/rwDwTshsK1
   RV1hTR9MiozMrz+0kPcKS5SS57Ngd8+Q7hRfqXw3ssEzPJy10MXbc71/+
   s8c+aR7JIohRy2GY/TqTf5rhJkGSe6NAyCTGJJHlJ+LNnJE1QW7dprBw2
   g==;
IronPort-SDR: zM1fCOD9dnRO3UprufNMoahnReA4gLhdcuA5rMLAzH1pjuv500d6B1iEisuXuXJAQX2MEOcumx
 iGIr7AmvKA8+Y/uwjqZh1hSP5gLu+A3z2NtVJ/b2tm73dBcscbe3tf8IEVhykyHiZq/xbHSeOs
 3cXWuDF+eJMY8a6XH9g3SsX+H/RNAaiaZ/8gbmKj9nH1rfptzHa5bUkgEqAcZ44YJEY3GJPZLt
 us5HisYWRvigCHn7NnLt5ZvnO6b6GofIt9OI5C2vy38341qlqKlD20epwLM8MUOuClaBKRdvxo
 /IM=
X-IronPort-AV: E=Sophos;i="5.72,363,1580745600"; 
   d="scan'208";a="136423701"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 00:54:11 +0800
IronPort-SDR: qvZoN5aKpXNgvAdscjuduLUZcLFw+wJGZATcyKeex54xI5lcwyAmUDYIQ0r8Z21/R/y0UmhxFS
 q0hD+4SYj/JRQtWO7YrW41RGp4cdgWMPcqXChbv/nsfGa8gmbhq23TKOkYL5TE5N2xXo1J8eq8
 zpCfuuhOhJCN+nTBqZ9gItC7Za4YdHOO/r9l8wAJzXpG3hky2gRJmbMMiD4SyDjnRvDmTLOhlW
 EwAreL/ANcGI/+NOxdYg2UtwWO0YnnNeN6s2TXJOm+tdChXU5wvBuD0TF5w/K99Zh1wyhn6cd9
 G32nTfuzUv9nPS/gcyd2YtpT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 09:44:49 -0700
IronPort-SDR: 5pX8gF8H4vB3FMyhSxzOcaqEhHy3IdhGh1UbbO9QqTwt3KALxUz1DKq63lPwt7XIQP4IYCjjMM
 /ynGbEXHHteuX2TMbkdF3lee5PP6D5e2XSsYRUB+wn3i61HGjqmDbwuFqSeecxkZDpgtxi/T3h
 lkqg/NiaOcKr1eRmwbTmbsoZQinvTNYLE4fOlLB29lzY1vrw9dfq4rnk0DHoBpvKo5sNK/reYe
 GZl+iOVBIB+dIX0Zbnqj7uSTBHESFJ9TOkJPjMq3YrJyRsIlwCJwJ8fe0U4dH0AKI5smmirE2v
 mBo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2020 09:54:09 -0700
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
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 08/10] null_blk: Support REQ_OP_ZONE_APPEND
Date:   Fri, 10 Apr 2020 01:53:50 +0900
Message-Id: <20200409165352.2126-9-johannes.thumshirn@wdc.com>
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

Support REQ_OP_ZONE_APPEND requests for null_blk devices with zoned
mode enabled. Use the internally tracked zone write pointer position
as the actual write position and return it using the command request
__sector field in the case of an mq device and using the command BIO
sector in the case of a BIO device.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk_zoned.c | 39 +++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index c60b19432a2e..b664be0bbb5e 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -67,13 +67,22 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 int null_register_zoned_dev(struct nullb *nullb)
 {
+	struct nullb_device *dev = nullb->dev;
 	struct request_queue *q = nullb->q;
 
-	if (queue_is_mq(q))
-		return blk_revalidate_disk_zones(nullb->disk);
+	if (queue_is_mq(q)) {
+		int ret = blk_revalidate_disk_zones(nullb->disk);
+
+		if (ret)
+			return ret;
+	} else {
+		blk_queue_chunk_sectors(q, dev->zone_size_sects);
+		q->nr_zones = blkdev_nr_zones(nullb->disk);
+	}
 
-	blk_queue_chunk_sectors(q, nullb->dev->zone_size_sects);
-	q->nr_zones = blkdev_nr_zones(nullb->disk);
+	blk_queue_max_zone_append_sectors(q,
+			min_t(sector_t, q->limits.max_hw_sectors,
+			      dev->zone_size_sects));
 
 	return 0;
 }
@@ -133,7 +142,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 }
 
 static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-		     unsigned int nr_sectors)
+				    unsigned int nr_sectors, bool append)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
@@ -151,9 +160,21 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
 	case BLK_ZONE_COND_CLOSED:
-		/* Writes must be at the write pointer position */
-		if (sector != zone->wp)
+		/*
+		 * Regular writes must be at the write pointer position.
+		 * Zone append writes are automatically issued at the write
+		 * pointer and the position returned using the request or BIO
+		 * sector.
+		 */
+		if (append) {
+			sector = zone->wp;
+			if (cmd->bio)
+				cmd->bio->bi_iter.bi_sector = sector;
+			else
+				cmd->rq->__sector = sector;
+		} else if (sector != zone->wp) {
 			return BLK_STS_IOERR;
+		}
 
 		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
@@ -232,7 +253,9 @@ blk_status_t null_handle_zoned(struct nullb_cmd *cmd, enum req_opf op,
 {
 	switch (op) {
 	case REQ_OP_WRITE:
-		return null_zone_write(cmd, sector, nr_sectors);
+		return null_zone_write(cmd, sector, nr_sectors, false);
+	case REQ_OP_ZONE_APPEND:
+		return null_zone_write(cmd, sector, nr_sectors, true);
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_ZONE_OPEN:
-- 
2.24.1

