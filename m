Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA921A97D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408235AbgDOJFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:05:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19517 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393856AbgDOJF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586941526; x=1618477526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rp/9OsypQVA9Jov9x+82RNHkk+PbM/KfEuomMQ2uw8w=;
  b=A0sAm42lq0gRASBUZB+ykduHMQQBgD2IV9y6glZ2BrH9qvvQgmBoNqNr
   3iNfHyx6MGv+3+cHPmjbl+E3km9Bi/T++FerSWrzXMXgWMO/HLzf1LlZl
   mDfUwCbgM0xF9cLHgMLndpPv0t+m9fu23b0rCw8GD8U5j67F920IlK7H2
   4PZuF4vwWPJ7BTxtzrM3joXGiouJMEFMORbSHfgRCEHSR7vGX+H0Krq41
   EqTBtwjJUEVDmVmiyCg74WltJmUYwGGAu7pR9JXO+4ckHhyZsfS7eevHL
   HsYgOU3ssFdeZfKwnbdlG9kgPw3uYa7KojGqpSw1Jk+8X+rGAzxW+uE1X
   g==;
IronPort-SDR: 6U4e3Vn63ymwZGEaIf/guLMST5YhsL0FcgjxG4njL7hP18gw5CIHIMZl3MNtYTazjphOt6oM3M
 0qDGT4Opay+3JUDrJBjPb/BuOAqdSay4XfUZDzEh+f5Fz6fcO3y98YQXE47PchKHhLYNSJHBqS
 tyzVa6BQTQ3jwCUNMMLPa7QQ7hVfVIbjGs+uFdDdaKRGKBYhERr+fpJ00EqMhKvOiK/SSYRTJX
 BMvYTCXHcbcCTAyRiVmuTYrUTu9wtIo/PGNzdAW/fhFK/Y7mq447Y9J5Kp3HSKa2bAcBx5SiRV
 8LQ=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="136802970"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:05:26 +0800
IronPort-SDR: Hbe9sqm6137kgcXdKENp81+0422rfOoid94+3d7ovTIom+0s6iF59wuz2eRHko/pw6XLge4z26
 Gss4U1DKKdVGaB6kCljqvL+538t147uWulvA/hNoJj9kFrCbTxOuj9aNZtpf+TBaCjqQau7WLu
 i6TKKwYo2Eo2g1vDetea33ckx6e7WjkUcLOJ1eFv+R5w4UQLm4tHDEHOjtRKNtUJCQiiKOPiLc
 6pYJRsKrziJcwTQOSG2IgqsjwZFWgYOYFUpVn6twBHfEEfgbyfzgYEu6tz5Jnni9LolJiXZjJb
 EsaMttPnSCOw3b4p9lJPIWm6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:56:28 -0700
IronPort-SDR: kuQf5tUEWAIbNPwKQS52xE2aOUQ3DY7v6ecMACcizaAMYMYBixSjwwFBibdCCPBsV8WEPUB5Rf
 C3xTCGPxQQVVIUQU+t5vPzUQwSodnubFSJYtiDezk/zXodz8Onr79FbnLzos0Hw17FIx5qNgxu
 hZ9Ob82r0+ZTOby6Iy6KNNz6t0qhfeVA26RQ4RQbUdhEOmK9YTRnxHdtOqQFkGZekXh6FtPlpF
 TT2F78UOoJmbhTwxjDyJJax+oSDPV6eQxNx6Y8KGoTMfsh2lVtGjx4ZIPKc0SOdIuNFMIQUg17
 nn0=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Apr 2020 02:05:25 -0700
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
Subject: [PATCH v6 02/11] block: provide fallbacks for blk_queue_zone_is_seq and blk_queue_zone_no
Date:   Wed, 15 Apr 2020 18:05:04 +0900
Message-Id: <20200415090513.5133-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
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
index 32868fbedc9e..e47888a7d80b 100644
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

