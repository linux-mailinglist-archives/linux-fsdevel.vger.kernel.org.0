Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06719D4C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390315AbgDCKNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56729 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390105AbgDCKNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908784; x=1617444784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kvkqhedaxckecfp14XwRLXhYwHCzNuCrujz+QWt/cdU=;
  b=E5AmxqKQVhdI74T97u0p0/OgEd3Dj12nZTcIlFkvPxPvfN58TFh1cIhX
   hhiourYGU84GRQlZOyZHvRDMwImEQkOBlrQa207N8uW4TPTZWZGq4TbnC
   DhGddZfltMSAyoeTOijzcEicoMoNLvCKh34BkifLQfkr7HeeBTtfHU91Y
   DzlBTor79IDomXB0g0VRjkeVekiqTNqPed3Kz9JNH2ZyaJnmoWM4lUeT+
   E13Mzu6qzwQtsDfmfWo2YfWZU+ZeDIaVp/TK5A+MpQ+RSVs+nVr88sapz
   Gq//6vFt5LYpMF6cF6y70+y8cyr7rsP7NuvE2o9AHfzjhS2EFA9eSUHaF
   Q==;
IronPort-SDR: awRpl5ZIkBvEQ0Ym7XDgT9NhCWKmB1MKFcTq4hBfz10dvgCDDUaJSQ0v3nMB5Vez+1SPswtP4R
 GrjW9v2U3RS7S7/wf8gbbLPScg6TwZTyccSnRs8FnSCasPpqI5M/BwjwZOOedcnO8m4HZkidd+
 sz9UDDQrXVbTea5Yh8O9siuNSCdZAcnnUnlc7eeZ8dArxT1g4bzSmETuJP4V9vU72YyiHTOEV7
 VmvzPMO+lralxlQnF9/6W99i7mgc/ax30U3OJwP3ah2Dkccdbe+VJlKxfjOT67A1cPaBDXCvh9
 eyA=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135956006"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:13:03 +0800
IronPort-SDR: 6BSG/poTewsrgJSV73RE7T5xP7+IrhdrylWCH2o16EGSSnUdMm7ztjT8GJhscaN6WkfFj/ue2z
 +cN6Ay85pdIrB/RM0CNSm0icSvXWGaYapAxNMmOgkgiDBEDWsxCQdi0ImNS1D6Q0Rlhaiz1kWC
 00z72EJgn21mVme2k7UwB0OrM3G6ar2CdW48j0uRsFAjxvY+BHmExKRv2pxjHMGqb486cZMywi
 5JZNc8MkmpGDj7nYwIUlqpxeUzbXQV410/ahA4eiwwGFLpqxwX5UeS/s8da5Sg8BnwwYi+4qpQ
 2W4GM16DlcQKkfiNfEqI6slJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:03:52 -0700
IronPort-SDR: BsUA2+SnRFFmQaC7Gk61IDnL+d3AbppkquPX57VZp7SlIcsvPzegt8rsas0E0rK5Nj/9GyavwB
 l4XzZgqU50FqBDo7AMod6hiXbgv/G7w0vz75v6O+FA37D3p/V86JHusbcuP2XWqxfxIOzOUY+E
 Vjc3sv2AeyePQootN0xDtyA6uDqHz9f7x/rHkbq33H3WqWRG1m5wm1XRtJubqf+XUxhTBTP5BV
 Oz7iE4w8VO2lrtW/9NUTiDTmZ2bUe18KaUo6puOIUqhVusqE4P3+OnwObjMY74SDsVWp+H6nHz
 4h0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:13:00 -0700
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
Subject: [PATCH v4 03/10] block: introduce blk_req_zone_write_trylock
Date:   Fri,  3 Apr 2020 19:12:43 +0900
Message-Id: <20200403101250.33245-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce blk_req_zone_write_trylock(), which either grabs the write-lock
for a sequential zone or returns false, if the zone is already locked.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c      | 14 ++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 05741c6f618b..00b025b8b7c0 100644
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
index 36111b10d514..e591b22ace03 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1746,6 +1746,7 @@ extern int bdev_write_page(struct block_device *, sector_t, struct page *,
 
 #ifdef CONFIG_BLK_DEV_ZONED
 bool blk_req_needs_zone_write_lock(struct request *rq);
+bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
 void __blk_req_zone_write_unlock(struct request *rq);
 
-- 
2.24.1

