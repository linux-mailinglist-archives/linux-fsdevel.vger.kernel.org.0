Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3DEC195B8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 17:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgC0QuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 12:50:25 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2564 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0QuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585327822; x=1616863822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EPr2SzSUKNC8Hgcg5K/bHK+2y5HKhjTakUPPF8D8d4g=;
  b=axQxFPWRpcGnP6CawVqbvB8utDuUu0r2VO1e4UU+JEJpDs/GVko574PE
   MJnKzzJc0SfgcEqAeog0wCFuFu7jlb8kvC9HwwYZ2A3KjH6VVIwaxkv0f
   JzflpbeX8H87//WKMU5Uazx5tyITHuGBcthD4SX0maOCBPo/gq9cy+fQT
   /LGG2QtKL/L7HCKViLMiRV+hVulwQjCV61qcWtdA9WBv3pGnTyBF+I1TT
   xZ+Eup9aOrJ07/gEB5XBzyJeFIkkRorPAAupxGQ4iknlnK8QUyOfgCGLf
   KEoEl4yHFghaUhnTmDmwyFHCiMb2syU4ewelmSmfpIVmJokOh4WZzpwIR
   A==;
IronPort-SDR: jLxhnTGlebUN89e+7ad6pNC0YG6PBeuYhzmDDFGB36uo7NO7D+RG+c6EMizFLE9a4DtfCuh5E/
 +kNYqY35zLzr5AUvGqlLf7hDsP9Ugt8X2ereeQOhEfEc7vX/oWvh/2CRWhEu7U85MWVp0qP0aG
 FMQdnry/F07ASfnrAL42Uy6XWpLizGNYWasC3S38cYmV+c9jv902V86zNF7pt28o2USwDNuMHy
 E/eP7NhsSpPFvO3SydHcSbhfyC0bXmzs7pEXE5pODyn+kayFFe6xoiMDKmvewuXkjK5pmWJDRY
 F8o=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242210442"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 00:50:22 +0800
IronPort-SDR: KYl1HfwKShOB6oduRhRnMv7QYZoTI5MY98XV7jqJbOsNJSHP/iAnGQOmWLLQk1FpEjsNDFDbv4
 QZ6CcQwKe5mI63wySsiPjtIbmHyvpAgWWyBehu/u05X+UDxxfQMCfR7p0D+nuMwLc5uj8Q89lF
 7q6QqHQuSG21TJKKvZXiLgmXDetneUo0tFEaeroIhFJTuLQ9QEloh5p+tLXHb/Y0/s1h5WdYiG
 5yNBomE0ybgjwKH0W+KKgYNYZVD//XDzOFVBbhSntsUTE7Q5EOspHqVfNsrojFqTaIUYJvYxOw
 2KwdSgb1tGdNdM4quOnEz3My
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:41:57 -0700
IronPort-SDR: AnBM3QJBFDNMLPGhRMtQbQ1CUjtHaYIex9GJfxM9C7xAUafNNJPtMDslcoPS11Xo91VLuy4q51
 9OPM+iaGDC1tPZU+I2W8vdRTzPpmc8UQNKTo1HhLt7ZJAfxl5JDrT3zW7l3LW3JIzbLaa08itX
 TcPMwD7bSiXdnFs3HqJKcXraEA5qHfZgZ6MqxJgvC79TmX1cAyA2VEo5STVpPVyv/MqRFghfDO
 ZaEQAmdfkrTQe9F+ya3F6JzaDXgYTIBPPjhkWUoB4w8o7MAQw2wnsJRJZCldE6ifMvzTR1B6so
 G2k=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2020 09:50:21 -0700
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
Subject: [PATCH v3 03/10] block: introduce blk_req_zone_write_trylock
Date:   Sat, 28 Mar 2020 01:50:05 +0900
Message-Id: <20200327165012.34443-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c      | 14 ++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9d30a4115dbc..3de463a15901 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -50,6 +50,20 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
 
+bool blk_req_zone_write_trylock(struct request *rq)
+{
+	unsigned int zno = blk_rq_zone_no(rq);
+
+	if (test_and_set_bit(zno, rq->q->seq_zones_wlock))
+		return false;
+
+	WARN_ON_ONCE(rq->rq_flags & RQF_ZONE_WRITE_LOCKED);
+	rq->rq_flags |= RQF_ZONE_WRITE_LOCKED;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_req_zone_write_trylock);
+
 void __blk_req_zone_write_lock(struct request *rq)
 {
 	if (WARN_ON_ONCE(test_and_set_bit(blk_rq_zone_no(rq),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e9b140cad7..2187d3778eba 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1737,6 +1737,7 @@ extern int bdev_write_page(struct block_device *, sector_t, struct page *,
 
 #ifdef CONFIG_BLK_DEV_ZONED
 bool blk_req_needs_zone_write_lock(struct request *rq);
+bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
 void __blk_req_zone_write_unlock(struct request *rq);
 
-- 
2.24.1

