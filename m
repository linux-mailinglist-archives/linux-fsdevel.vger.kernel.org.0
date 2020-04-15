Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9E1A97E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393878AbgDOJG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:06:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19515 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408237AbgDOJFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586941549; x=1618477549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EptpuszxKds2VZq8D512Jp2spjpDwJgzg8AZNAyDqGo=;
  b=b6EVcGfgb/oPGmahu3IG7qqRpyd/R9+EYXpPt5890a/7+Nd4L6Wn8wmY
   yuuBkzrUCVM7xSWxwn5DNRPRttJPTV/xFgGVxPeO22PJfXaEiUvj0pqTI
   0oW7DVSWs+c+/Bz2fJcJGxfh7x2/nqYw6HFTYm8n4f3zVQGr8FD4iX2Ej
   mlnP7T2jRfbC3M/HHvIlK+GWQE+8pSvEgRHj5bQm63SV59vweang3COZJ
   hrmq48aYjnnWr5hHQncqdwJGgNI3ni6Z+7i6TJ6p1Dg2j8R+KVOwjbbSo
   TIZDT+n2GrGSSgKhsI5LCMfszFpMAF7iR70PuFOSxckbF++7JAy5YXQiH
   w==;
IronPort-SDR: MrggPRi7VsMsaO0iZApmSj41Kjyj/zF+gEVkPIhutvAKSkmGuYVj8sOj3rx8lLHKvcV08UCgz+
 Wippdkcx2zK9IcYmM4gMAB89RjTTniH6zpTBbT+tp6WCdRwifLSTT0/2gMilA57lmAgM32+umN
 8e9h2bPEdq4BjCQIDm6H9i3EyTMB5dMwIVgrcE/9zeeIfLwAG/pRq6VbzBsLTFcxpNOqzp1rY6
 iDwLNWLmbBa6FVJIx8XmiHAmYKT2eDito5P79a8fZoHrTtgWbMbPUdKQy05F0BCyLkgUttTfGi
 Zuo=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="136802998"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:05:39 +0800
IronPort-SDR: lEHy18QdUcPh+fVDjXxf9VBrROI7j185P6qaKeGEyoPi97M8Qgc/3SRh3ObbOtUVPhF3cg18Q5
 P455MyOsb3lDMLD/O8aq8aqxKRkItTqbx6Vhw2rAX6LPwIC5Bs7zZmTtOyddecyZW1H8qOCKF+
 gwKbjljC5gkHPrRbSbLuROnah8AzRaxSteecsx6E6dTAyYpRYUxwa3aJmlJq5gDqXzF7MljJOv
 Fd+4bRUbgO0qvHg8RYOerk8r9mx2X5710jrC4H8WmDRS+FoTAJP3b/lVjMbN1rL78AYR8Ld7Ph
 Tj+ZS8IkmQU1r5DYLBozaTrU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:56:41 -0700
IronPort-SDR: VtfkjweSwgT8rqL2+Jh7CNDNoOPZsFbgK6Nl2RfMC06f2FDvW130FxVz5Ear9oLrOLLRTUxQw+
 ik/PfFwH5Qkz9kpU6bVZtyIlS+REzRU4up/OEG/Iop5SazkG0kNfEANC6CPorRz7uwSKSfRPfe
 VKi81nhd4raNf5orOL/1EId2fGbNAj6a7nUUyscZhT8gISsobpcUahyBTG2+QwkZgy1O+nuPvn
 y6UYMDERZ6iLoBr8ApBemgWJiMWVb4TltpyQof7J5FLNwOSE/iHSgyxMpftnggyCngnHioIB9Z
 UHs=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Apr 2020 02:05:37 -0700
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
Subject: [PATCH v6 09/11] null_blk: Support REQ_OP_ZONE_APPEND
Date:   Wed, 15 Apr 2020 18:05:11 +0900
Message-Id: <20200415090513.5133-10-johannes.thumshirn@wdc.com>
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
index 46641df2e58e..5c70e0c7e862 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -70,13 +70,22 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 int null_register_zoned_dev(struct nullb *nullb)
 {
+	struct nullb_device *dev = nullb->dev;
 	struct request_queue *q = nullb->q;
 
-	if (queue_is_mq(q))
-		return blk_revalidate_disk_zones(nullb->disk, NULL);
+	if (queue_is_mq(q)) {
+		int ret = blk_revalidate_disk_zones(nullb->disk, NULL);
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
@@ -138,7 +147,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 }
 
 static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
-		     unsigned int nr_sectors)
+				    unsigned int nr_sectors, bool append)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
@@ -158,9 +167,21 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
@@ -242,7 +263,9 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
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

