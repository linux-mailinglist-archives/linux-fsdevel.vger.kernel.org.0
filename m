Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E00717E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjEaLix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjEaLim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BF5129;
        Wed, 31 May 2023 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533121; x=1717069121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eFPese9aJpJiKXeG5e/nRQTUpeUtTBckLQcuuv9Sgrs=;
  b=XGqIAMyHGfwcryeAM99HMHZZZInZ3mPYl/YYl5StjYPfH7eAQJSkQeBF
   A2YweVxWHMqosxXpbOQHo5o3nk6MXOM2kX/+U4ht6DHR52BCwycDBw3/5
   i5DEa4FDc5gYoM6X0Su2/7yrXChXchfFapGORVfhKLFWLQEAoTtoj9wGY
   +dIy1LC25NJv03cz2RIL+B9CxMqWCrwiFuiv1A1BM3otpIKhHfDn39su1
   EbNp0yqtShiYmCQHwKUQnDoddBEDz4Gwfyh3AqQXSQKR+kX8FTA3Me+9q
   OeI51chsU+tO095aYxrnMz7x328x3MYX6pPsBAkon6PogVgAuuA1NyhM9
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179091"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:40 +0800
IronPort-SDR: H4bgsTYW1JV8OYcCIAhMw18+4Mqa9wdOvRNkn1XO8JshU0pD+tgosFxlKpZ++oMWIIMGMxQ2An
 kY/ANiVAAbwzt1OIvTOY0ss+6t8q7AZOWOfrQYktCVKWjQJ2lxsYAqA6YKg3MRXKTEDKBXxI0r
 v9FSd/SZTCeoWiN41pswuFHYphFdfyu2vZl39tCSB5Q83tNPrlMcXEI0rA3geXMv3N6VdxTtj3
 ukN6ELkOlA3mPpR4w9AsA3rdEzDO65G2ZcVhEWQt4BU1QuoaBJnF6WDXL0NK1r0mDhOiLglJzX
 D8E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:47:52 -0700
IronPort-SDR: ujmc5KoLs2DdynhiOjmCBXuRbkAVlZaPLEkofuqzDp+6R/G/lfzWOIkJ4otd+Y/NwVPeJknlMa
 nqO0wauwh/h/LndRpEByTM63QCqInOoAtv9SPXGQUfOBk/R7A2Upc+PH8FkpQ3kOkBxabSx01n
 FxU/FSeRFYb5OQUIG1immw+PrJLj/4ofWGsdxlWSNgU6KcM+Jy0YyrdLhWY33+3QGX9WvZMDg2
 wGMO5YfHoS1LKUknGpUHGRw0ZtsrLt3flydd2oM7EKdd/f4za5a7A4H2ygIdgtB9hbWYzpsUVk
 0Fo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:37 -0700
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
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 11/20] zram: use __bio_add_page for adding single page to bio
Date:   Wed, 31 May 2023 04:37:53 -0700
Message-Id: <b7dc01dc0523e3af5a3c50d0ac1f98cead699305.1685461490.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685461490.git.johannes.thumshirn@wdc.com>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
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

The zram writeback code uses bio_add_page() to add a page to a newly
created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f6d90f1ba5cf..b86691d2133e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -700,7 +700,7 @@ static ssize_t writeback_store(struct device *dev,
 		bio_init(&bio, zram->bdev, &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-		bio_add_page(&bio, page, PAGE_SIZE, 0);
+		__bio_add_page(&bio, page, PAGE_SIZE, 0);
 
 		/*
 		 * XXX: A single page IO would be inefficient for write
-- 
2.40.1

