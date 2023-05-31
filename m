Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1B717F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjEaLws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbjEaLwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:52:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066BA123;
        Wed, 31 May 2023 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533895; x=1717069895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KEvuqAniWi8kHi4qA/R0NoUerrluHuejNoQFU/cmxk4=;
  b=J24jctzumPMiGWgXGhq6qW91L/82wi4j6TBenPuVdo/NqsHlwpEvsp1q
   rI0g/9o5KIix3nTKi9gAD5UKp59hpJ5CPp4JhihDXCx9iroXWYYqrdNJp
   STp4FjQ5oK+9FnQLfDZEcIdBsiHmr6c132kcZxKri9OBOs67eu5C2gWKd
   o0dqmvNsVqtSfeXlIVQtIR55MFub7gxgqwNK54lkpmbbT0IvSG/W85BK/
   P1vij3b7Xk1eT003XvT1G/lpUY/GYB2wUC26hXDWqCL6TebQnWMqw0IY5
   bUlL5BKjuICnKB02DiwcrU8qfexG17L5/n1N8ZsP4rmispbmT1wP+ZU76
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547950"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:25 +0800
IronPort-SDR: AcJ/ngkHAWRsELSQuq7k8Rfxuk2f+J8s4x6gRpQLcwQm+k8gJxRdqgwY1Hspbx4slyFaNE0f66
 hb3eDfe3O3mDaxQPZ0u56O6s1AFViVWdKHZ/m8wbq9FCONf8HglLlrflgn3xjBKyTZhDgfCNB6
 7LwAxU3+UbgVjoeBBtN7sqKs+lplUkkMsm5Pa6iTtuOQ2gy1NItC0s/Kl/cPDum1asq0wcHMTJ
 lqrgG1HeIRY78AuesoZmdru4a6igANxk6bZC2BwjrqZkIrGrEUXPjEvOtDZQEy1uQ66fdCmYq9
 niU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:18 -0700
IronPort-SDR: kmu31oBFaHnnNAJGr+xhYJn5TvPy7FWZ+3bDl/POq5dEGZ6Ww4ILjSxttl5EfKXZDUQcRli+rZ
 moVYwDDX+fxlfeNlv+Wrfhx9qjjhuINsRqJ7wDqXzpUIu1qfANLUrv5fZXWn+bq6nOyCp9mL+A
 jd+tV7p/CL7GZwMnIHFGfEi2kh03FzkyIpZKhbWLGSyU/rpV7IQd8BnuVNyYVVF4Clnms4udrr
 8axxTzuHHRxPpkFC7dekm4y71BAXSfErGtkIM3AXOE0UhIxp+Ce8ckzsRvifEaDe/YrKNROIOM
 ZV0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:23 -0700
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
Subject: [PATCH v7 11/20] zram: use __bio_add_page for adding single page to bio
Date:   Wed, 31 May 2023 04:50:34 -0700
Message-Id: <cfd141dd7773315879a126f2aa81b7f698bc0e10.1685532726.git.johannes.thumshirn@wdc.com>
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

The zram writeback code uses bio_add_page() to add a page to a newly
created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

