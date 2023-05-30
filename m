Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9667167AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjE3PuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjE3PuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:50:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E3F7;
        Tue, 30 May 2023 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461803; x=1716997803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eFPese9aJpJiKXeG5e/nRQTUpeUtTBckLQcuuv9Sgrs=;
  b=mytSUTeundh2aclqqbJb2FhrNw6BixEWBl89fId8dlerSCJOFeo17geh
   mFiLVF1Xhb4sKHgNakOj83IgrgPdvLS5R57YBNQW538jOe1t03q/Fd4XX
   eQCBzX5fLHrl14L+vmVZ2mho2ykrE47yTbF7o8dlscssCMZg69QMcUGFh
   oUoXM4B8uTY4SbHOMk92NZ4u5r6bZCZBSJoWs18eUWnPWYZ3086BfwbwN
   gPCRFw1La2J8iRUw4O2CoHUE1wasMeBXKBLb5EvgTZJiyF6l11qUFwznv
   3Jak+HlCMsqZXhm0gxqg1Cti6j9vTmiQaQseOCw1IXOOXcOuI1cKNegnc
   w==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129806"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:50:03 +0800
IronPort-SDR: bZsAyf8r3bheTAtMLzPriZMSFGcUKZrsg+3YUaPryhJ2ZEsmW8mJ0f7r8fEoBgQCwK/f5/0uFx
 LWgE1kiF1RHJiADEI6VcL0AvAUkhbHGNS0Xjbi/5wN2+k+JocNuxEitCJpt+38qUlEShEWSgau
 OGa3OIBY3MPMSOITPDvYND0dPALEgURTx2qzhocqjzysP1qI5pII1FZ3qBdllXJbF8MB1n4E8u
 cTEb/jflCC4gUZTJcdZVBqGMpGRA9NlRlYGkwXiZIE+H3lcpNAOr7UMgoaRBlIvrI96L9uL3sc
 ytA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:04:56 -0700
IronPort-SDR: uoO7OAb8Rbai8cKgJymQK7W4XKI+NlAnG6HDCi8QqM7mtI6E9SBztbMSPVAHHXkyD5wS0TiagB
 zwsZz4Lc/J2aZzF+Mlm2SSoQODj2TQmcJ97GwYMdyo0esUPwJRVyQz9paaoxA4nohmqRdWmmxO
 S250ZL7bmPo0YQ7S943KQRNaXs/Lw2JPLCCx68yUQpjAN3ERvara5+yzICrxbaCvHvUKuOeFn5
 WQ2BgTAjgwj+oUkxmFhmgnUej8e/Wo6551HAGEv9hdjrJsbcc4zdEck0heYyMZJ0oinBH2yZjQ
 tl0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:50:00 -0700
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
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 11/20] zram: use __bio_add_page for adding single page to bio
Date:   Tue, 30 May 2023 08:49:14 -0700
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

