Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30EA191450
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgCXPZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39883 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCXPZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063519; x=1616599519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hO0jQxdyY1ykEreRRj8II7pjB7WCTRWEQg4KbI4Pvtc=;
  b=cWLriwVBfELFAkD141F5vNvkuNXWkBVFMkW3XMk3uEv0xpl/5DMnI63W
   8dl5W1bJTGVcqYVyEyzrj/stk6AAzNH1MpT0qYbriM+6jee6eCnwIkGx6
   iDgcfUAQcKCRkk4FcmDqVN6JZ3P3MO5pEUp5bDhwlq30UiWw2lI6BZbSY
   k6fa0d5moCviPX58KTFq0d09ROi35D5fJI4W4xubQSB2km3CGgxq9WQXz
   zv9w/D1AiVmvZg8/C6QwvpwPou6ZozX997+xyJAnZg8lIL3OxxKQ+iKIE
   w3XC+0x8hC2VmQ2emHmUXx2M+ydg1DFPkhm0k8MfN2c5QNM3HMTeliO/i
   Q==;
IronPort-SDR: WfnNw6PPIuvRd/mgKwb6yjpkhNbMHYR5GFzkrIznR+W7zOms4kTac1B296+Fb/RIlFWaCwdNhQ
 p57Z9vVMDzPCxNZ4GL6e1Qhfn/zemJjlp6qgFw4bCPzfsjQwXy2NK0MX2Y20l4gk2PuYd7ixKB
 x+sEzFsed2uQ4fs+utOuejHxOmQVkoA1Gc1DFZbq0XmF6pMTrlj/EkdIH3/fL5sVJCcR1sX+iG
 LDj6vI+Hb4XaMwymi8So+FtoWNOU+RYsaLKpj7y0SbS7d1slsirwQT1ThDAWF/DJWiINymTT3f
 ReE=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371576"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:19 +0800
IronPort-SDR: WWpjSMZZoWzzKZW0IQ+TCyDg2omaca46y5jjfP3lBl8OHffYlNCz4rhc5pTJDJnJ2rE9FT6fyW
 jpQ5hL/PFHP4y1PQqZp9GQQ/xdVH2tFmJ2cD+9qTrn5ptyzHT0IImV3ER70gEVngq+1LbpxgBU
 4VjVVU++qqi77Z47TZ42gO9vqpiTCFvTknd0PbgW4w+3jwgwwDDu0jlOKC+pXESw2sR4+9wzZE
 xz6xuKGaDfgQPY5IyJ7z6hWJ60LjEWJMJS31j1zHYeI7X2aT1lCnlny+m7cIy5FaZgBMJs8qtk
 HNnIyRKQCdJYUSaAIGw0NDWp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:16:59 -0700
IronPort-SDR: XCLj1ehrmkKP2P+4XHF3fFv62rWJGw/Ioa9KEigVv+fSruv/NJkWgvS/TMvhEndhDcM6OKSLnj
 dfqj/ChL54Fw5VDdc55NlLYXTgRo8JdPbiY/RoYNwkDozEbKZtvOQrExRuWANstC2LoDmmVuMu
 W8jFZI/SKAe6wDOlZH3smGWpEXQtfE7J49AF86bPJVlYeMsfGY6Hz8s8MdRVbzhTpBty+3oqZ8
 NEuur91ZHAvzDP8p5CUYxRUl0IbwqMjSTErWNOsgCQBSK7N9LcqUSmf2L9b8jLjDIuRxcRJyqa
 29w=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:17 -0700
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
Subject: [PATCH v2 09/11] null_blk: Support REQ_OP_ZONE_APPEND
Date:   Wed, 25 Mar 2020 00:24:52 +0900
Message-Id: <20200324152454.4954-10-johannes.thumshirn@wdc.com>
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

