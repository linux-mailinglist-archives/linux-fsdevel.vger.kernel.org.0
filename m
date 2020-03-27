Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7A195B8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgC0Quf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 12:50:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2590 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgC0Quc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585327831; x=1616863831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hO0jQxdyY1ykEreRRj8II7pjB7WCTRWEQg4KbI4Pvtc=;
  b=Fvvg6Wq3LFdh1FVdar/um968xP5LWue7cGT4WU2Kpo0d1HT7D4J/prIu
   2X69zAeXiNWJup/tE8INcg+rLJfBYV0Sc8cc6WCZU0xqQjxi783YeTXyb
   ubHFrmNewDADxWqgEOOyTwky1zq27lIIzvVIjvCehFI/zN+IAb1KRDsuT
   7Qn4LE2bL0fXq2oxiUFenTmOamCLP4fkj3lomSyJeyQncCByuMmiNG9cP
   W1WrtRjpEqn41Wazu7aJspHbBSvB4/fI0d9p82d/2hCDEIk3+mKSCLWBB
   2Crburp1iqQ1yGwBgBYrYDeJaYgZa//sKs4+feQ4s1sTxgJ/IAn18fvD0
   Q==;
IronPort-SDR: 6ojcjvAcJP2ROpkA6X/49GYhpjXTvWlUF9BpcTqI1/q2Yy43LnV+7il6zDRBW1ckKK5h643/M7
 gzvNmfWK8l5HOxvdd8NJffiA9YmnEXwbQSU/QIi9IQxeSpHPmCR+7ZWTg7daWsfHezhRkidnsr
 VzcXf9hRpKJczRO6cQYXrDMyk/3ZnErxXP1XYHHvtRJ3nYPavHL1EKPC2PgimrIJz5ogU3gTCb
 EhKDnHDna4hg9jIIDS08/1nHnOm5BVFaRyvo72c3f5JsM8eoF8UXMCJ6NT2zdpbPNMIluUaqqt
 K6k=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242210464"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 00:50:31 +0800
IronPort-SDR: nImQ9MOv7Yf2kqrr8jY/Lkj4DMhgyz1/i02jveD5DFpfq9l1n4Bdt9s0CJD81EJTLJ7hkCJ3M4
 tG54qh2HVCdQKXKWIwT7TnjLQFZrlZ+2M4UAvnaiiPT/O2xegGb/h3CR7LcNg1/p76CjhAeJji
 IZmBpaPVGYVa2OY1ybyPmNjzHggAW1psCk4RKXIf06bdr0YaqovozrYvEC5BbTw2y6hoWITLS0
 fHN5wTgEycoeu2whLOQ6Bv3b/2hp7YJfBHPHnEV15eZaXMCIFarKgzciX6jGP0CanljY7+wurJ
 +jTixZ9w0ZhHcqWOHYodxecC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:42:06 -0700
IronPort-SDR: +9zzBPz4Bn4fJLPecXnXfgyKkwnWCJxaZlTi8TTgKmcTfEmrSgfRhKFxFwnn4Q7QWDyIgjQjSW
 YVQeNVeLA6P8CW6nNGEJoqVfHI6K5nkd4A2nJlvl+SWDKEQJE1icsKBK/v87qaNvIANdDAxltU
 +fzR9IWVZajbJhVLmqANQDnaD8M0efFX415jZKgb9BOYPnrMJcmte6MpI5ve4kEqQflkabm6ZA
 agsyo0xDG1gIykx/ElD3o2B3UeereFVaGOFhbsmvQz+KeHGUgv7PH1wcd/7EamMuSGTUo9neWX
 gbs=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2020 09:50:30 -0700
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
Subject: [PATCH v3 08/10] null_blk: Support REQ_OP_ZONE_APPEND
Date:   Sat, 28 Mar 2020 01:50:10 +0900
Message-Id: <20200327165012.34443-9-johannes.thumshirn@wdc.com>
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

Support REQ_OP_ZONE_APPEND requests for zone mode null_blk devices.
Use the internally tracked zone write pointer position as the actual
write position, which is returned using the command request __sector
field in the case of an mq device and using the command BIO sector in
the case of a BIO device. Since the write position is used for data copy
in the case of a memory backed device, reverse the order in which
null_handle_zoned() and null_handle_memory_backed() are called to ensure
that null_handle_memory_backed() sees the correct write position for
REQ_OP_ZONE_APPEND operations.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk_main.c  |  9 +++++---
 drivers/block/null_blk_zoned.c | 38 +++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 3e45e3640c12..5492f1e49eee 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1300,12 +1300,15 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 			goto out;
 	}
 
+	if (dev->zoned) {
+		cmd->error = null_handle_zoned(cmd, op, sector, nr_sectors);
+		if (cmd->error != BLK_STS_OK)
+			goto out;
+	}
+
 	if (dev->memory_backed)
 		cmd->error = null_handle_memory_backed(cmd, op);
 
-	if (!cmd->error && dev->zoned)
-		cmd->error = null_handle_zoned(cmd, op, sector, nr_sectors);
-
 out:
 	nullb_complete_cmd(cmd);
 	return BLK_STS_OK;
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 8259f3212a28..f20be7b91b9f 100644
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
@@ -148,7 +157,20 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
 	case BLK_ZONE_COND_CLOSED:
-		/* Writes must be at the write pointer position */
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
+		}
+
 		if (sector != zone->wp)
 			return BLK_STS_IOERR;
 
@@ -228,7 +250,9 @@ blk_status_t null_handle_zoned(struct nullb_cmd *cmd, enum req_opf op,
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

