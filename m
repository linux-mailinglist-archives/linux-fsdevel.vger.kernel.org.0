Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB3E191441
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgCXPZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39883 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgCXPZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063509; x=1616599509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXx7aE2+4Bn3riV/NFnik+y58Uc3+FrRK845R1l9N8E=;
  b=XLcO1LIJRPLlTuI9/mNVFZg6bzzDmXduRABih/4mOW3J23c0FDgx4eIB
   vHA+b+tRvLn6czjvbEEpnHzWXEKDsf9TLUJhB/0r/cn+d0O3arGu36RQn
   YatpmglgNKaMYxBgt7DetbE9kD6vup9fEpk0zXHWQOfx0qSPch0rUtW53
   haPohsfe1zTlw2DnyOxpZk64ihkygf2UUjwQwMRBrem5evqHb8w6mmk2d
   CGft+vrWC9MJYtS5rGV33FoAGudGzjAviSFfSdebrloeO05lDwl/aTDc2
   ugOdaI16WB/53aW4I8dFoWcXH0gVyHC7d8C+f5h0ydqtaA7eVNTAn+Yyk
   Q==;
IronPort-SDR: /AO4/0L7XVAXr+A1GE8/qBevpDQhn1B7ctyKamrkHbrhPo7tQng4wgjvbez4EZK77xLMN3mIrv
 dEMVAtU6eBsg5Vb1RE+QQXpctBZyVcuo7hPTA9L/hcnEJ9OtoEyyS8tJ/AjhwKVHp1egrWAR/T
 5lDeCkgGbst5YO8uOyxvKlBn+G7asetcaVZ9rS5H4MxyjclTg519k42Dg/9mr1Zjp91syq/qfq
 ixkl2aofUshH1aTIfVJIV9RU+DmAH3TWVTEh+3Ahs/BgZtr2H7yDINFpYzT34oEAHVGmnegKDj
 WE0=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371560"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:09 +0800
IronPort-SDR: A+Vj6F+ACzKP4AC3y1dHRn/CFdMp9dykpfMHDYJWqJNhLHOKlUOvJsJYCsVeM8omyQyW29FP3n
 2Sm32MEJzaWL8S+aKVDXTuAz5+jrgCuaVAwJRqH/lsmOM9r3uGSVEpFtix+SsrekIHGn2+QNAx
 9Oq6i7beSraOfI6F7rOrCFgVS90FBkdAnr+MsteNGremoOqSKf+i1cdi1ZXMq4Bs7nfTr4zC/n
 jauQYGBexHH+n0R6H1aRcTglpMYudIukUrfEdyOc8YTlUfqBFZLfzniaZSAI/3M24Zl3ggFXve
 byGSKdQ/sNporCiM7yFk1loT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:16:49 -0700
IronPort-SDR: ZDT7+mqdgs7FxwwbH3o339Rj0fGDD17uA2X1cgQAvhdLAs/RXcQSfEMISOia7tB8zHvXTOxgpU
 8R4ZJ0PbPSZRWoa8yGUbQwOIWeHZI2ZSOQUEEvtKfarBBgoPqTWU4XKMwa1AtD8xg19LPhnS4S
 UN7hCqfec5S9CK/uiPOfJQTygXcxpbaFGSOIZKxjAa72rGyiskGK0YJsRKzDn1xvCNbeclku8f
 n26bjqVDh+8f99jgCUc87BKaen/LOuff4iKi/Bb2ucgi0BwG3ONLffsBo5gXnA59lkO6uUrBhc
 6qU=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:07 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 04/11] block: introduce blk_req_zone_write_trylock
Date:   Wed, 25 Mar 2020 00:24:47 +0900
Message-Id: <20200324152454.4954-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
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
index 6b442ae96499..aefd21a5e6ff 100644
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

