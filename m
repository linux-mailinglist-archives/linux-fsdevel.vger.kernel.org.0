Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2919D4CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbgDCKNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56735 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390514AbgDCKNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908788; x=1617444788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=af+TpmrNaP6opwMEPh6jKrw6Bxfh1IsevFX/PW8xfPo=;
  b=Ny3IEzwiLNFiL5RkCfqCbGi/R/xtPLVTtRQWBzy0/ujmLG27GVkf1w3U
   WaPg7gj1liQ/gVmWICFs1eD8akfNNHLHI/m9sPVUgtUcuv4Hx5HqNp3Ah
   E6tEreB/OWFMjclbOiAaSZlYF70OZkjn6a3A5BotS76GBOjX7nVkyBhjs
   jQS3PzXGz5G8kjPq+u3f8sYlCCNz5tKcvf1p3qrkAzLEKIYwRwttIVFCy
   UBrMPa85brI9Dq3y+I/NHRfV1AQiIXcpm+LsvIh5nroPXKVSu71uZAzpL
   qeAbFX1ybL0PjLzHbWNg8nMoh7NPP8ZW+c/brRy2P0ihi0LRM/qPeq9Na
   A==;
IronPort-SDR: RGrTW+ddos814URNyM9ydqWtzQFCyBjrFHl/bBPfsEhfN5ewwXe6JgxAN0+pH+llvV22GRnowN
 p2n8HKsYDOLWfa49JQkRSvdmAKW4MmOVD9XD7/eE2bOTsSRhtNKMuU6ZShhiGDe2WZJjnYuIlQ
 jhyeypTJEVef3hl/upOjXNAOCR+POx5/MZAvNwIvQxrPkisGZZNF/lc3TwjjRF0U/FgZrB5402
 VKXyMx4ho19Oeb68ZnYFMNOe3Mz7hRd0a0PgKKdnmtQmuWkHPLj71dYjZizmNTw+kZ7sn3wkPh
 bSc=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135956020"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:13:07 +0800
IronPort-SDR: qe+Ll3qBR2goe2cO6oQINXjn2bjY2N5fK4U5fG/mhR0VIaRrAI12jhxwXoI8i7gYdWZLKXDyBb
 0s+esHLs/WKNH7uifoGOz1MZ+NUuUWsJTFy3Ly+zDTGKn6lYFDG7rSxgNjaKyNtsd7XixPQIzG
 PJPeda2ZiirAcZQBI90RZm23GDrIqM/PovuB3Gl6fTRTckTbVjuEfcpvnTZH6MliVAEqn7DJkL
 v7/uk78qcRBu2Efw2//QkL8oJNAtQCMecjchlSNEOM96aUP4c7IXAwFa1OTRWeW/9jgQeuCFO8
 lYQdo63Mf/auP1WS33ZsjuEN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:03:56 -0700
IronPort-SDR: YMuY9yGwMiyhWHJWU8qcIjate/KDbDsNC3XHMZ/NsMWDg6HBRTOaihcLw1qV1XlcA6VkfVLN+O
 Nqe4lTNlcdWX/4Qk8InyV0G1PU9makfmAK6jAGh8o32vkKXAD+/JiN60kMf8fVoqzMQo4oy7Dn
 S0Dl/10kBjgi1SMWs6wnR33IEeUQDuloSxKjqQseOG5Deh2putNiQsq+rr9+V3gi6dbT0d7oQb
 eOJjVOmKto/pYAsUOJ3XlDHUIDsIgU00sdX4kojIKe5bWwBEEO2QwuiZLi4RMcXNzsxVCKE49P
 2hY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:13:03 -0700
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
Subject: [PATCH v4 05/10] scsi: sd_zbc: factor out sanity checks for zoned commands
Date:   Fri,  3 Apr 2020 19:12:45 +0900
Message-Id: <20200403101250.33245-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
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

