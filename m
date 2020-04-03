Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA719D4BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbgDCKNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56713 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908780; x=1617444780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iOKpbr1Ka1cFGP35Fa6ZTxHG0mbfjgFm55pfw0HfVbo=;
  b=i39FQf0o/Sne8oUB6uVXsvUffFc3Zs+m2B/qf6tpBo/h7wPk1J6cQZz6
   6E3YWHyHJ+nkZ25Zhi5LvYyfoYKjBfNbZz9t9DeegLXoqp2QZ1OXNLCdB
   vREL56LNKvlZC/sQoQVfy4Qq16w5knxhGNqZmHffY1GMOUBybrN2Uko7p
   UOn4iq4Q4FpKRKEPbK5i0NGW9ppcjqF6UPi9a2Ocm9p300A6d7LB8gRjO
   94YhQ9bfW08K59gV1zm81xsJqx7W4xFnWVkXuHM4zcNbxlI5oDhoM7524
   63j5YKk3zZqOZn4mMV+o3XCzmsED/VHnO8rZ0xZWxubew1C7Px9jeQury
   g==;
IronPort-SDR: jCxQFdG0FIKkD2b8TM+0kw4bp+az5868RNQH/it6BUdGNO+1DPKf5yR1Gp9j7tfnCxAIBZ/Fr3
 AtAQ5ztCaSd8UkCKc4dTaqSwyKlkg7lwgeNjTTIJry4joS8Bpb0UC8rdvYrKq8obGn7Ll7yvFP
 6fPes/DXCuAN0R0oQdLhjYV4nW/XxrGU0wflwhDdVCRlw14qdbQMywDAlcsekxname6GF+Xo8b
 1MBmQPY4MQif4syCLQ8kKE1rz6ae4DBlcy9w8hoWbBF8+r0J2v5GXLd4nTqZWQFmfQXhkc3irN
 23U=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135955985"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:13:00 +0800
IronPort-SDR: sBnqjut9ETJ8anmBBcqKpFxINTxAFMXl16c6SA0LBN+1O0UyZ9m+W+quxkDPfzn+iZv+ZlkF4q
 xReqwUIpdgjVFZ814OwxOFEqeUG5YzKqiOIquQtkgb0o1vUVrzOLQLAM8ZLHPaXgMbe6dOcgBA
 CDTC9BnNvx25rvu1JWACYe4NodNDO+PWAs7/Rr8GhR6bC191Yb5nTgDhJI/aiTGRqxlTtFQfvh
 G9A2KgLclbWDv/YGuitV9r1FqyB8X7Bbs4ho0ulTps5qXHa7QbudIB+y4Pvcpq4hwhyLXssOM8
 /57hE6etWf4P/5AmxP4hF6Au
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:03:49 -0700
IronPort-SDR: C8QlHCSAhkkzsOxz/XBOnpQEUi67ssjLzwPUl+qtyHlzKJ1Yx5FyDwo/RVSmqTXf9dCLc7nFAR
 fMnDcZoXA1JNU6MZpyzAT5fEQTAWCURq14TCSaSY9Hpi4586x3qUTUSTTNVD2r1xH9pyKvlY0a
 kc4uh9ygDtwBDcFuX5MyMB1Wh8iO+o+qt5ALv7gY6RR2+6r3uUqTmRe3J75KXIgp3yfgI0MRhM
 cTNSCrFMCjZ7kc+MHeLqqgXcNt8yvrj2vAXnRdm3lz/5uOb4HHAOun8WHUiBxDu/EzluUsZScF
 DNE=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:12:56 -0700
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
Subject: [PATCH v4 01/10] block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
Date:   Fri,  3 Apr 2020 19:12:41 +0900
Message-Id: <20200403101250.33245-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
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

