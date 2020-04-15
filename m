Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F91A97E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393887AbgDOJGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:06:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19517 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408233AbgDOJFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586941549; x=1618477549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=af+TpmrNaP6opwMEPh6jKrw6Bxfh1IsevFX/PW8xfPo=;
  b=C6qmKpZnQhnDmtSiaysJUc71lChwkaOfY64qVWUoxV+tV8KwGy+h7mbK
   ihmKvsJpV9WDMSz9XJXOSynomuoIngmfCu9bWz+eVdkorY0Kcom6/AYJb
   psnhtEkK27kzWAKfveUgvn1WR8AAfr1jHYsme1cPyfJj/2QNTYpVpx3FY
   GVM3y4COEm4hAhGIU/QDzXlgTDDFMMTXbqCpBAyZ8BYxd/OnYTCWVx/Tu
   tR4QFlV4i0u0+PPm1QtwkanDpv47gFSrx/YzDlSTawt9hzjZRIAzw0u/e
   Ul4Cb/K8KOLpPfTGD4WUn/I8bx9rtKaKsXWF7h8t7mfH8zRC7KFIqW3PJ
   Q==;
IronPort-SDR: WgLlcu/lgawOUmvV/VnmE0FJVWNMZL858hrP5WWZCapt2YavEpE6ja76a1GJd7yfNbrR5lqyrn
 D26J2AXJjlHNdrNGUrl2Y627d2GS+wYiuXrBmEEiF44fib5kLkx37X5vB77abbDPHBYkNA9cW+
 9HlPJ6hd4LZ03G4qOWc0uLoLDEqzzwcef0dWhgFKn/FyNu5JsHMTmyonHDDHI+hQ8u/Q41g9nX
 lc+xqOrYsgR37MiloqoSwvTU01HkBevbSx5zGSqMTsVrCplh9Y/uzUgTrcimW7ggC5k7LwkREt
 wx4=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="136802991"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:05:35 +0800
IronPort-SDR: WZtRsJtSBy5gsk782FdxKd9ZymcXAeXls45IZZNre/wCUrtgsXQMCcqkYlyA55eH0yjZO8Ahei
 XBwKXKab3EhxAGKjOf9Jqhswfr+H+AEe1MRqE5uCk5PYLf0z9vcP0CNc4VRhb7hMQwyZLyG4Vc
 pSkO2t9W87EwjtA/azUA4BKYM9wXpkrRDM6Lp8DiUwa8X23d3UVmznjZ1KOq1ao1HzVe8azA5M
 Pjd6lPdX1rE3VVlHRyRAVWk+VnyQJNFcvTfGJ91laHY+MJE2sgJoeeXOaevWbw8tZR0bYcn5ok
 Xp4Oec0RkcasoPi+sm1dwIaf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:56:37 -0700
IronPort-SDR: 25972+T8VhQ2ZGJbPcCsXluRRQ3BQC9YUkcuIJnAK8r7syvwfhITkDuVHf+6Q4TVN5lsiJfn7K
 xuduaUD13+2Sf+QZiL451i0OB9HD7bFtoGr3N6k1wuMH0vS8BUwo08jtiHAo3ZjeT43+JkHtfq
 m0R/xd4mwkZD2ncZzmTMD5WDaGsNhVpM5x06npqn99CZJVGoWifLy6pSd6llqf8ddvFqxitDme
 WfFlOKK8aZv7owojSPARP1cbPf5Ofq5EaA6l0QPJ881GYYaZcZDsVBkhyxyPzOkZrQOla+ErG1
 nhU=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Apr 2020 02:05:34 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 07/11] scsi: sd_zbc: factor out sanity checks for zoned commands
Date:   Wed, 15 Apr 2020 18:05:09 +0900
Message-Id: <20200415090513.5133-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor sanity checks for zoned commands from sd_zbc_setup_zone_mgmt_cmnd().

This will help with the introduction of an emulated ZONE_APPEND command.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

