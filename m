Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220BF1A97E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408236AbgDOJGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:06:52 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19511 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393860AbgDOJFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586941532; x=1618477532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=idI1WH8nxkPnh+O/RqijVff+VKCcvan/3RihAz7vyTw=;
  b=a0XyQ9N/k/lG1Fd8q6KoPB4n12VcDANkHGa/zFP95PMRh4fSzOyJ7t/k
   44E154T8CeaciFrih9jQsEyNo0tjekPHk/xMKgS/MOTKGjvv+9xM28ADz
   hzzs9ZiaJx2Duvh5MYf0MTuh9RYPNVNYZ/jKzACqHbuIcF/izaVLpWKnZ
   vKf8KzmPJon4ILUyhSMrFtv6Gbf0QSII9i5kPMtL9/F15rMA0+zvKoKZs
   wNoQePClwFTbpwsoMT7DkvIUf8e+6Dtl7sVlMYP/RPFYJfUYDj2kYTPS7
   m6tUB01893lXIISZ3/becRObLKfJIOGjSOlmaWMA3yo1qUDJDiPMK4AGe
   w==;
IronPort-SDR: 9wrwBFjRsUc9S1qHHiLblQNKC3SD6nqvuaq64fUmjYy4rFv8TiwNn/Qd3jnoGVnrgTrr3tvMrI
 yBG8C2G71T/shB1Xn5HATxEVQt6HJbL3H3UeHFTP9ePpd4vQ4JBPXOMmf5fVKhIgBWiXbT6tTB
 bV2mUpCTxybJvSbeywp2A8LVsmlXHMWrz3a9jXwfd5bevjbn31nLTR3btO7SpTF80wSTZcgoSf
 NL33lM8t7kVgG3Eh6ttexYeU6htfUDUh4hDHEGezrrF5pjBlIM9aQX1yt7lgdBIikwRh1zdxAt
 nGM=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="136802984"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:05:32 +0800
IronPort-SDR: LZIR/hTgf9K5yjr4UpOlj2+U1N0nNbSC8KziFhzJ55xJ3zCqYyZ2Wr6uG+QECB++vep9DlAdrE
 bx7O0SveGZ/RqkyZjY+RpCThUCyAyuh7EN5Rq6qStm1jBTHQMsms/uBm1Kw/2wTSxcrHoCSkKR
 tbP4PlJoPT0l0j6R+VB18yLWTsmFTIswAaycES4QCPAzfkbf5UCOKNx1XkNkY1MIm82MJ7lBLu
 ztdc+V90qaheLHpHBaAFvbQl7q7Tf3721tDRfnURixuiQjfQhDclxiY82Ltqy4uUGc2sfcfKUu
 sga765D8yLEq3xyNmsaq+VzH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:56:33 -0700
IronPort-SDR: HkG8rv9h3gsOoqwpUjPARDHl84hAQkYxswWrcoSyJpMtpqKtMizwBLoyue+NEdDqfaBOR2k1ik
 kepzVsNApdvR0DWGZimcM/gvEL10iCiqj/Ys/8CUhSK3dLfgJdeOWagZERhNJ+C/PQvHgg2PuB
 8UQOfMMTfSZW9JW/gUMqm06tFv+5+AEdfUGv9Wqb1Gh8f5U+fS2AZw0iWm6DZLa+UA7YmvCcT5
 idaS21mcOp17PoboDz7R7Qjw8EN1pxLzCB3hoG0yc+DR86UZG5mN1YeSepOpdU9ESAdi343Vjb
 MNM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Apr 2020 02:05:30 -0700
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
Subject: [PATCH v6 05/11] block: introduce blk_req_zone_write_trylock
Date:   Wed, 15 Apr 2020 18:05:07 +0900
Message-Id: <20200415090513.5133-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
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
index f87956e0dcaf..c822cfa7a102 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -82,6 +82,20 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
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
index 774947365341..0797d1e81802 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1740,6 +1740,7 @@ extern int bdev_write_page(struct block_device *, sector_t, struct page *,
 
 #ifdef CONFIG_BLK_DEV_ZONED
 bool blk_req_needs_zone_write_lock(struct request *rq);
+bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
 void __blk_req_zone_write_unlock(struct request *rq);
 
-- 
2.24.1

