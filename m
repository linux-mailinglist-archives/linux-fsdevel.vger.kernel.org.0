Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7944E1A385D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgDIQyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:54:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24715 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgDIQyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586451246; x=1617987246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=af+TpmrNaP6opwMEPh6jKrw6Bxfh1IsevFX/PW8xfPo=;
  b=hsNvvNHTjsovPfvo3hCiHTDRiN58mmI6xa1IVm5PmsY0Y554GSsxLRrU
   a5bpZAE8A63a+Z2CL7HqCv1Hf5BgQQod3ZJPGroRykWzEcGkljgDxyom5
   xYe8tRCkjgDHTd7uDKTbJXEnlAAkSkzPuwreRNdE+iyQkJACtObkt7Y2J
   YqJ9W3q9X/v96+fPkoZrbFVx6ZkfW66lpPxNyYexojqpupDuhXYpuQgnj
   wYLN+JNE5JqZ/XvCgAkkm2DGdbBe5kechpWUL31G9myWqLrglEFZUUFeY
   NETVDO/IquJ+c5qmnHANam6rcD8KUe3iezov37kcvPz+zkGTYgaKjJH3f
   w==;
IronPort-SDR: SGoCgbltRKsC32MsHKc6VlUJLj78Itsn6c38gKapAqhtHleDBIGOauzn85VTdX1N+tFqeCLlIg
 Ux7unujbsuShrE2Q3XlfNbs8Qf3xT+bYca4cpry58Ft4PVHgeu96RCUTr0Rjc1jWMSdC73biqw
 yfUmy0bSPF5deEat8YbTMkFNxxtXLnQ5uLI5ivwS7R4ZVxY3tvB89VjBfKDF+2rsEIq1tnuGgb
 l7McOz2bftcKVu6JEqZJumHBeTnlwkvjq2aWhf0eo8Qr/Fir9JkVwxhXwTZm4dl9u46K1DF4Bk
 zK0=
X-IronPort-AV: E=Sophos;i="5.72,363,1580745600"; 
   d="scan'208";a="136423695"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 00:54:06 +0800
IronPort-SDR: 6+39GUFAAH12uu+VXz/DSKRR3pYUblPtY9sLWsQFyS4x1SEnemhNMyePwNzOwpFuGGAz5V6ylD
 +Klk3Qy/8VBRu0WM4l25VhIkH99UqoOeU2QWSUXbg6mXlDzuKVOIROsXDcFXfzQsdE4Nn1uHiK
 aHYxsEHIl00bDM6efb75oJehRyOsLhC8L2TU3XBGj7ZnQCC6nfhgWd3YbmS3RqR2mzvwQ+tW5B
 RlRR0JlmD5TaiXcFdGyIdHgUXXmp+9VcMAu5wmunTc9iE3jNP/l44b5WVGjBe+rw2iUGunvZj2
 2hpR0KVNVHAfyxY+DgiWBk1s
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 09:44:44 -0700
IronPort-SDR: +nAtLtmGjeh9fwyAgaXidtrGP5Yf+uR8XGp8p49fIAOKF4Eb9wD/Lo9d1wRe9y3VjHbY3umxIj
 9AokJG83wV4AWOdifM4Xs+33cX4OQK5WbX/N3olSaSWBf68bxD7uyHXK+pVBqNuxxvskWZ6ZLI
 C6n75DZRH5nz5dnGhIy9JlMdTe+d4WWSQOj904KsWpmOfUdcBKK3h9WQYMHOKJu2LSlbWGylmd
 mt4As2mJPRw3o9rzWz90IyI1cyQRYRqd94MHEfp2lE5MODhwFQW5XnqHjp6KN10NxSwusugQ+1
 GSk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2020 09:54:04 -0700
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
Subject: [PATCH v5 05/10] scsi: sd_zbc: factor out sanity checks for zoned commands
Date:   Fri, 10 Apr 2020 01:53:47 +0900
Message-Id: <20200409165352.2126-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
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

