Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0201A3851
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgDIQyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:54:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24703 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgDIQx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586451239; x=1617987239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iOKpbr1Ka1cFGP35Fa6ZTxHG0mbfjgFm55pfw0HfVbo=;
  b=P2/zFD0XRhKEHw2DhdA1ySHhuykUn/Ggwr7k/gXPT3C9zK7BNjgmk+MY
   YgHqTTiuwvsXdEeeGhOvNiqf3esqBmNtCyk5yyThZaFGMYMfUAmsi+wYY
   PGl/SnCCum3z3aPrrbPonh/RtzU0Ifg6BvBqFn1KSwOtEw3uJ4uEwhBsk
   d94JRjOx0cVM94/R2fNCeQ26kuhdnCW4915IBaeGaY9h3Pa7fUYjSuDmX
   MrYgwBFXJ6Clawq4X+9aiDtFHmXhsZJYK7BpA5qq2kWBabdkSuEy7vSsO
   QIFheExhU/GS7lVHMVSzUfN5j8AeGsK4kTJkdpCgtg/LRoh+lbRUJ8DEZ
   w==;
IronPort-SDR: iJkOb4ytwAaMAZ7e8LPuQg+2ksngj1pprsZkRGC6S2CMCOU5R9WevybjgIpyrKWOqOXRDOaCPk
 760bhhXq4CQZ+CAi8QJJYOCxvy8hBaP9wZEFpGubu8XcvY3EZM0DmH/d9b4o5hSdw9WJpvsj33
 a15laxfKXc64jKFU+EMaY8QbkR95ICh4u8J8BMhyw6Ts/t0FvN7juPJ/zb8o8qi1Y9MrleEme0
 vHv/PoxBzl9k32X3i+CD89sRjVOyNpC3Puus6zP/wM/pyuTtmcxrMoFfgX9Aw/vZjN4pB/ACzj
 33U=
X-IronPort-AV: E=Sophos;i="5.72,363,1580745600"; 
   d="scan'208";a="136423680"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 00:53:58 +0800
IronPort-SDR: r/oUsgegiTSuR34SZs+7bM010dbkAG1hey2nAz2UbCcykImeY4d3jAOYu4UWz8P1grJ4BTs4J3
 9rAo0rZSm3vg7YoGbDVob9bormSWiN/49shStiQh8SPiZ2W6bLHAvw+/mWBmQzLq6g9E4Bl794
 cT8p+PWP+8ojOkkqnvEKt1FUdukQy3uu0qO/UP0UneQIrlzMLYhDfWOZdqou6dNSciRtMxodRP
 xewG07cfyvdLuwthxn6I5f3klezl4zwNDPlVPbshqOUdTsrTjuDA3J4vIUlTaOFFVE/SR5iwZn
 EsO2jXTHHhmGqCou5rhNlT1Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 09:44:37 -0700
IronPort-SDR: dUIaPq6/IiqFECkhaVWoIem7bAFfhsBVnKQAfuAtSF6kAmP1YC8fedu+jHy1xukLrxEPWityHU
 zBQfcsOH/v0M/oEEG38W9ooHZrGt7ACmY7EAoBjlJyJHZOAZw9p/eLMaNo5uWn5DTQEBYcqD1T
 C24+hm1PrlRtPkIjBMc1W+Af2U3DyRIjORRt670Li5zzZtQboCr0Rp6z0qec8YMxfIFtdvLAFG
 zGYGmSlfvtsCTevfIP7FhYf3cBdsW8CHDy2r6qAaSNXNXFBldYDjBmR+96RlVDDFzu4ZlXDcuk
 PS8=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2020 09:53:57 -0700
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
Subject: [PATCH v5 01/10] block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
Date:   Fri, 10 Apr 2020 01:53:43 +0900
Message-Id: <20200409165352.2126-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

blk_queue_zone_is_seq() and blk_queue_zone_no() have not been called with
CONFIG_BLK_DEV_ZONED disabled until now.

The introduction of REQ_OP_ZONE_APPEND will change this, so we need to
provide noop fallbacks for the !CONFIG_BLK_DEV_ZONED case.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f629d40c645c..25b63f714619 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -729,6 +729,16 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 {
 	return 0;
 }
+static inline bool blk_queue_zone_is_seq(struct request_queue *q,
+					 sector_t sector)
+{
+	return false;
+}
+static inline unsigned int blk_queue_zone_no(struct request_queue *q,
+					     sector_t sector)
+{
+	return 0;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 static inline bool rq_is_sync(struct request *rq)
-- 
2.24.1

