Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B4D19D4D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbgDCKNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:14 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56746 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390520AbgDCKNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908792; x=1617444792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6HGr64038QxXgZLqzVn3A738Tu3C+gMz5NiM29UgamM=;
  b=duoBcMkWxHozvg1yDnxoP0sCTt9K8wwU9hsMH6p6IWgWdEPQ6XBoqbmU
   HEfbPHraxwgWuNK806YN4j/FuitThEhO3W+a2dMZI4Iv94yeCu0TqoNzd
   PYyyYBupLgrR4NO2evv6jUc7p4hUg90oqAVnuILmmXRW5IMujDITnzsAy
   rzd5isH08iI8ZLvRjCVmDFpF9JKIgO6h8du2VbS7RQAgGjEuruTtiWEjX
   MraX7pzsSn6M0mIMs0MFHKfXpg2z7pnfPwNeznzYoWmmi58xBvWa+CcQo
   DE1NFbZuttbBwq44x5qSBOkXEHKLnos++zIRnVeJu96SqZuhfeaIKJWoQ
   g==;
IronPort-SDR: 6VMUOJgikKBL02Wi3y5LDaGG6zXuLDmKG/YFm5TnWlG8edQY+b3uqxn7W8VEiavUAX2OIyzvIU
 hi89xWZdxXgxRAKmI0/SdaIJUBoqfFSjSAFTVEkgALEJHs/FmC8vFKLgzmGvXAuoRDUWbH2vsZ
 PcqVGLEUjO6ePHaLP9yp5GYP9RusG2gQQeq/ChtwO7OTNbBZWbIPhU7rGF4dP5hhqk+weEWRvB
 UBfHFjjXkII8r8nTCIGiHYWPtmjLHgOyvAj2VIDVLAlVBubKdljKNrXToOIFgV1GXTzruOpCBB
 Zwc=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135956042"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:13:12 +0800
IronPort-SDR: vADdhwGW3UcUroU6qGlMIUFGC7xTOJQk40VjA4LvQ4Gp30VgqxGV4tESOGVt2bJZubl03vpSlC
 BQxeO55kw/TGHpfXLB3hjlNqUOCMpRC2O6CVhZl2EyQdtuszLM1ZRj2bwJ91kGaXL41M9JZvT2
 +kZlpTEvnfdEQ1xehOyeYNKOuxOmWCLdtXYkFMnbIrrGMa+x3YafCICLIGFrUwdi4USx5vhJG7
 6tkll0PCm5HRpn5k24PrnExLo53BFLL5/Ah40Jcp2CE4KVMp1htBMm8svp6RP/LBvsU0sw3OSt
 IX3JcM6bdICz+388C/sj1LI2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:04:01 -0700
IronPort-SDR: jp933wNZ6r5GwPJZdOuCxpwABCoL1ONO1Khrwft9a4qhi89xO9y/EL52ryw2SvATUh2ajEB7vM
 bSqK/AMo5mkMSzdg1Y6z4of69suXkHmhfX22+kC2bWM0nXZ4Lw54ZsH2yjEwUyGS3W3eAb6Che
 4E2GqlC2Njw+bmLNG2DB39zwule+VPVsPY5GcKuDDFgKhhren2dO3x8MJ1pJmhQp+/DGguupP3
 knRDhCzgCO118I/eTwNB2uJHuuHIa35sxvyu/S2YB7RsT6Af52VkK6x4XZyjva5Q4bJnwBHTdY
 C/o=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:13:08 -0700
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
Subject: [PATCH v4 08/10] null_blk: Support REQ_OP_ZONE_APPEND
Date:   Fri,  3 Apr 2020 19:12:48 +0900
Message-Id: <20200403101250.33245-9-johannes.thumshirn@wdc.com>
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

Support REQ_OP_ZONE_APPEND requests for null_blk devices with zoned
mode enabled. Use the internally tracked zone write pointer position
as the actual write position and return it using the command request
__sector field in the case of an mq device and using the command BIO
sector in the case of a BIO device.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
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

