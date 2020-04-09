Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2478F1A3856
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgDIQyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:54:03 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24715 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgDIQyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586451242; x=1617987242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kvkqhedaxckecfp14XwRLXhYwHCzNuCrujz+QWt/cdU=;
  b=OO4BZROVvRNcUnABBTd1IjXOs7Q6IaH7MJoUx6NIXUTJdcBN1CK2RZd7
   Sru2EUneMZ5GaiiEYhKerwUN3U7/AVAMiM+MQXLFX7C+hr7rMKJbZaNDw
   iBf72ghselhK5Lp+4R7TEdqonQOQu6eXunKAjescBmYVVC9g4y/8Mn8ql
   z3EB+mD2nWivbRoAJUBL84LF7xJ2k8yNQudT12WCXlLP3Ezr8evKwl+SV
   CFzBVHVNBC8yaQxwtJC1PzWlRja11+3vWUtvclaikxDDQL1W5rmuYwtYI
   iBKAefgpzoSHTKjFJGPs4kDOw5Dw3Hfk20DLkjcMJH/TTTsgMWxaKBusE
   Q==;
IronPort-SDR: LHWTyCrSGUM+RV/6Vm6YQeV4fxxzoIoEWZ8DI3UG2VFLNnGowWlU/tAp1BTh/qAwRT9OVBib5T
 h6QSLuYY3lCDiRzpB3I/MM4KVdP6QPQ2eynocUCH9vGV1Ya+GG6c6OXxGfdHUvvO8H7wjqrsla
 02VfONDMxPzA3r1ZqbODW+UqnntmsPtHdh+ipm53ss41RaUGj/12lO2TFYY4HLDhXLjSePgFSV
 6rCFqKiCTS5agqmXDwuCRrszkOQOSoCIHJCcjcFuqPogMEJoRJCH0MxGpiPbvp+xPOBwV0iILN
 9Sc=
X-IronPort-AV: E=Sophos;i="5.72,363,1580745600"; 
   d="scan'208";a="136423686"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 00:54:02 +0800
IronPort-SDR: aTHeFwOAkuBh8w/ohZstRT3VKliw8CPlZbw26ErdGxI0TB9bUAK6O31Y9cHPfQ6sDqOtCoASjC
 N4r4bjGK1s+r7W01IPY1rfLFuGH4wKNUpUatLTzqb2UsTsVTS9fWGLbw7v5LF8hmf1X1I4WpsK
 GcEdPVbqEscIP/8e6uRIh4HkJ6u27nmr8JrOIuHz6g7YHL1e6l9P0n/lReyRXkUjQu24WH6Rmv
 Tgs3GVtai9MbFg+i1F0o4ODb6JosOLhHA7R9GqY+1QnMrjybsr0Fp/8c41IqVAeacZe792N92o
 oo1/F01Ow7hJXX1sG1ENeFwG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 09:44:40 -0700
IronPort-SDR: w/CnDXvbqBJ6S6wBeXOgCIFQDvwqB6LtLe6hFAbeZ/GPS3VFMkpirXCqkqq5bYxe8+KCa7y6f8
 SMjANsO5TV4H5txf3HxEGgpaqBwmR0GvZTsPHBFpXNuAmp8J9lcF9355CZCovNmreUgHyxl46H
 dJhboJqu2YSQgnsmUwHbNrmt72FzPbNaSRhDdngfaC5izfthJW8qFrhwVd4JOZJrbTGZSffwJt
 Mu+iV+jVpaBUEFq/XryXH/sXz4ez8VJOWhmRBWgDO7SKIkU9/RNRIOH1ZiodgWFIZeCRT0aRJl
 8a0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2020 09:54:01 -0700
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
Subject: [PATCH v5 03/10] block: introduce blk_req_zone_write_trylock
Date:   Fri, 10 Apr 2020 01:53:45 +0900
Message-Id: <20200409165352.2126-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
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

