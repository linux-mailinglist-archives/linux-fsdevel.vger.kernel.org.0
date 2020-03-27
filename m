Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98408195B81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 17:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgC0Qu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 12:50:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2581 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgC0Qu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585327826; x=1616863826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wowatp8PN3iR/trDrof+MFQ0lADDim1HmYmnYYeViYA=;
  b=b27fdLCKdbftEGSE7apzg4ahjDrge8nc5GRXhqF9/BAqo89XAWEip/3Q
   wjTK9dwVMCFU/qzfD/FAZRQHk7cCiycaL8Hf7X/432xIAhQXIeTZ+Agri
   Kj5AOHH6p+8fEMDJfZOYoQUfj/w6NaoChRG+VcfN9JPcyJB+P3BCc2S07
   Et8t8IxlunU529oERmgz13zeG0Oeu09iIWwGoe9a6XbWGbHqJxqdiy05u
   6OtXJvskTFvOiXzMtWujYI9p7d0yfvqtqXrVW7wNsed1H7852nhUcb3ck
   3rejKpDXpGAST83vSrjG8NKxciz0NhYOYg+aexsgEuMt9pg5SejpD8Wlw
   w==;
IronPort-SDR: cpBqsye8KM4YoFbuHe9CwXxYe33K2fUuEP7vxdCeVl3QFJESdjexLGHU7KVOfkGlygDJ+yWSX6
 4XdSAJKj729ax6g8IMzpOAD0Kr8+AeieE+ulfTw1b4vHXA+0M0UkfHSoI4L4PNZhyrhsdPmHMy
 93/aJZkLl9Ic7mMFKTtuHVL3OGAZJXClVykBf2xoo5JGIWITeGkENclLXjl/q5O3EbhJ49GahF
 +HFE0qOpO1NLF2y26/XpyvB9KL0FPUoEWpCBdWbZNELAPthv+DVGhZeyTZDnbbeUDdc64QX+au
 vLw=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242210449"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 00:50:25 +0800
IronPort-SDR: ZEkr6wKZLR8qjVY90YdNgB5JYUPEJDVyaZ8M1fkaHnj56u0FbarAYHw8FHpcJR4qCyCGkxI1BZ
 rV711V4P6zvkZ/cVV6s/me8C/PKS6wu9FYTuUZdwilNuiWr7ibwSpIW/Q88MHTr8u6sn6RBKIC
 +0SXYfU7Cby73M7Ml//kN6P/62m8q+oAOZsHIARPjhFxqytA43EHLc2JI+lEVHmA8tgE5IjROl
 qwyZhLuuiCvuYpHpOkjcevHrPRg535jh6NfJS6d8Ysia/LFCTehVGwg+fhT7cH8a1CMKDv9IYR
 FPzaTwOm0tHmFfzFv4Nc/qKo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:42:00 -0700
IronPort-SDR: gh1eTpNzkWrbHDFDtSpAFZ2CQpyTelAw/5AsIYh85c0kLniKzWzXYx8uZ5sqNgt/pdVqauVr13
 mWvQ5m41/1la0UHtwoY2kh7cN9YtAZUtFFfELepivh713VPESsWyUByqF0mHuyxuxLT3JVcdKc
 I0dnlD1X9D+SRqxiEuNn2OI8UKT5uq+/UkhRn18wKJtYspNR5Js4ZddpbguDYDsn9yi0REGA/z
 i9lw8W07a/C/Thmu07o7ahqlhOOw+MVvLWdGPTNj08B6Ma/GNZLuqWzYPXfJ8Txy2rbAGXMSDQ
 IpI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2020 09:50:24 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 05/10] scsi: sd_zbc: factor out sanity checks for zoned commands
Date:   Sat, 28 Mar 2020 01:50:07 +0900
Message-Id: <20200327165012.34443-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
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

