Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F7717F16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjEaLvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjEaLvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:51:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501D10F;
        Wed, 31 May 2023 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533876; x=1717069876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5nFlnEeWG8zlFVtdyG/d358hq+5vZL8/oxRNlpo0zRQ=;
  b=jIwcxjoCB3EyF4qU1A/a5ADC/qc1Anzi5akZRp6O4MszPw7M7ZaxVZjr
   yqvHNjKP3pEeFf1XIbLhaAgc8CgZ5oNZq0wc3L3SOercOPeBYEu5LB98+
   pH+HixlpGYKL6moRNZ/8VlZRT/Uu8selM4ZEGAx/W4SyTEg8U/EYCF8L6
   Txx2GWSqCLY8CB5reqBmOcp3bQvjeCt2Zn6MN1fXA6I4t/gOnbNeUMldG
   3Ho0+JFl1bML6HPxoc9+12mwCBDm7UU+YY6ffOQC5pBuRrcoxoMZakSS5
   B098hiMlm0T5sUURJryfFp0mp3LdnVEuqVdUL/QJeKWr8POobpSNXShz+
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547931"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:16 +0800
IronPort-SDR: kiB5pz9LoUu4T7aaqBeztdAZBoubNNCZzHsR1+PtstiOMKncA36OrKH6gMIrHQn4L7g+Q61iZ8
 T6uq3VWrBv3HtQh+q20LoF5tMwuEkIyz+YUwPmC3gbTRQt27Cj2E14ZUXpwmDyZWjPtv8FiPwW
 A0tjjlah8iRXtDui+5YOsLNIglcp09PxuEN9aK/HuEWLaF4G5R63grFRxSFbybL8szmsv+XoJV
 skoT/+e2cN7AgnCedtiZTho5N+GvG49C+02j++SMBqScpOBuxAHoZ8IzAX4sATw/scD2bR8h3M
 /aY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:09 -0700
IronPort-SDR: N0Mp4y8z2roxzuFvPYeS73dMUyskg4SUdEFYqtiWL7UyYH8QyLK2HbkzyMpGYTT+EF0PQ5R5Nm
 mbPRnmO0CtIMwMBVMTx15s9v5a5Oh2WyHga/ttkbUx7Jl4Bta6scFUZ2meTIIX541t59maxWrh
 lWBndZcPbu30Jx/mVNKgDiRjvYH1saj/OjkpXgu9CIhpiu3Rt/dyHI1Jxml0CwwJUNnrSWSZ1k
 uBy7/6x2V7pUSi3wBQs8HX8G/rHyPZfLVSVpt3mmdn2FdzPjXwB7XpwzdquL7kP57mT3B4RFOz
 TRE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:14 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, gouha7@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v7 08/20] jfs: logmgr: use __bio_add_page to add single page to bio
Date:   Wed, 31 May 2023 04:50:31 -0700
Message-Id: <9fb5ed86d19f6e0b6f64dfc4109a48ff8ff24497.1685532726.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685532726.git.johannes.thumshirn@wdc.com>
References: <cover.1685532726.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The JFS IO code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/jfs/jfs_logmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 695415cbfe98..15c645827dec 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1974,7 +1974,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bio = bio_alloc(log->bdev, 1, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
+	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
 	bio->bi_end_io = lbmIODone;
@@ -2115,7 +2115,7 @@ static void lbmStartIO(struct lbuf * bp)
 
 	bio = bio_alloc(log->bdev, 1, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
+	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
 	bio->bi_end_io = lbmIODone;
-- 
2.40.1

