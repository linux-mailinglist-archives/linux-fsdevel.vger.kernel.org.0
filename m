Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F670191449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgCXPZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39883 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCXPZN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063513; x=1616599513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wowatp8PN3iR/trDrof+MFQ0lADDim1HmYmnYYeViYA=;
  b=HSoefu5M/PB+17VnVxj/C7Nlfmq+pO6IiVtDyG8Bx/SFQGw6qdqm/+rR
   MANaN65vCV/pfkP+LrPS0qTk+5ZObA8glPOf+IaPqSbH+IKcy7F/bv1Yh
   VM4tCsTjIwuki1MDDZRw2EbIIpBjWGE2fHx4mTz8X4W2EdCXg+xfy06H+
   MpFSPTfwlnQls0jl8/+10wvf6CPJBlS8UCsOOvS92yR3IprTFbECLest8
   LhynKl+nKVXQ4F8gEBdvlzQP2SzMiBqKw1uzFJ9nPmxxCQJ56TZEk09Oy
   s5rPdn5L7/KsRjl6T2XOJ0kuKSbh2VEULQwCqWo6kka1Yr8h45qtlTkXR
   w==;
IronPort-SDR: ebDtFcIdoZOiZyZGbauG8hx9487PDIifKeFlU45aGTHtwnIxXPwTn45MGghnC8Uzsrsfy+YuQi
 jHd0n1SVOlIDo0nCFVYVDny84z79XaVFg5j7C136pcncxrEcE6HNXr2WAE/Jfwqpyqk7OnFJUE
 4cP3Dt5k7QwRfVLiP9vjbAQdoJxaeo4GGAf47iBhp+4PQp0O03xhF6nOU7V9DRTG7re5aJ5Qg1
 zGrftu+aNKgo2MH+0EPHww5jrbTLwP8LAZPdqsEtiBEFc97wYefpD8aDsDItuTXstILA3l/jpT
 Vgo=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371567"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:13 +0800
IronPort-SDR: ILThR9WHTspidE5Awl16Xv96F+dIpNdSs+xSAkqhJDIv2HEUMXXqHfHy1JGUIBLivQuZjNl8Ch
 ILdcY6CxrG2MPcTtYDxKfgRbkVXiAHtsHiyINR/w+5fyG0+3erqWTJomvFOeessFG11U4j06cP
 pXQWyghpoz/cfnpPuc8QRv2zajsI/R4yPJTheDKBMmBaNfW1zezdOfiH6CJIu7ErThus96aTys
 McogKaViQ92Fk57mdYrY2flPurYpW7ki0qWNL5q1MQ7fkXseoPixFE9NKT5kd2wpCrBvY1Y4jC
 IUZE5SYJAfJtjc46auzQZML6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:16:53 -0700
IronPort-SDR: 16a3S0cX1zSIb7q4kjWjGUJBDoXZzt/KMiMrpoWZ3c98zf9ofYgapgkTvA3gdeCztuv5GY4V9+
 ZblMnaP+4BtK52KappDlvydD/VZw5qbfxpNVuWGTpV47j0j2I6NDqM4R45gncBdLpD+6laJ49X
 GkbViFBkrpf5y+CgcC+l0AVj84TxcOeCh0nTL19cNsKKkhaXU3nqnzU1c5b6yk8H1IqFtyuYys
 rmVY1qnM0lGBINgP9/ZPzykrimIw6ner//kNL/Z8PeyH4t9NsFj/5Jrc6dzo76n115wub5E2jB
 PEM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:11 -0700
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 06/11] scsi: sd_zbc: factor out sanity checks for zoned commands
Date:   Wed, 25 Mar 2020 00:24:49 +0900
Message-Id: <20200324152454.4954-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor sanity checks for zoned commands from sd_zbc_setup_zone_mgmt_cmnd().

This will help with the introduction of an emulated ZONE_APPEND command.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/scsi/sd_zbc.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index f45c22b09726..ee156fbf3780 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -209,6 +209,26 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	return ret;
 }
 
+static blk_status_t sd_zbc_cmnd_checks(struct scsi_cmnd *cmd)
+{
+	struct request *rq = cmd->request;
+	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	sector_t sector = blk_rq_pos(rq);
+
+	if (!sd_is_zoned(sdkp))
+		/* Not a zoned device */
+		return BLK_STS_IOERR;
+
+	if (sdkp->device->changed)
+		return BLK_STS_IOERR;
+
+	if (sector & (sd_zbc_zone_sectors(sdkp) - 1))
+		/* Unaligned request */
+		return BLK_STS_IOERR;
+
+	return BLK_STS_OK;
+}
+
 /**
  * sd_zbc_setup_zone_mgmt_cmnd - Prepare a zone ZBC_OUT command. The operations
  *			can be RESET WRITE POINTER, OPEN, CLOSE or FINISH.
@@ -223,20 +243,14 @@ blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 					 unsigned char op, bool all)
 {
 	struct request *rq = cmd->request;
-	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	sector_t sector = blk_rq_pos(rq);
+	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	sector_t block = sectors_to_logical(sdkp->device, sector);
+	blk_status_t ret;
 
-	if (!sd_is_zoned(sdkp))
-		/* Not a zoned device */
-		return BLK_STS_IOERR;
-
-	if (sdkp->device->changed)
-		return BLK_STS_IOERR;
-
-	if (sector & (sd_zbc_zone_sectors(sdkp) - 1))
-		/* Unaligned request */
-		return BLK_STS_IOERR;
+	ret = sd_zbc_cmnd_checks(cmd);
+	if (ret != BLK_STS_OK)
+		return ret;
 
 	cmd->cmd_len = 16;
 	memset(cmd->cmnd, 0, cmd->cmd_len);
-- 
2.24.1

