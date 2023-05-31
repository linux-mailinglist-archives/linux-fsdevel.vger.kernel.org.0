Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A74717E34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjEaLiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjEaLiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:14 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21EA101;
        Wed, 31 May 2023 04:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533093; x=1717069093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUIQkUbEvB2cbvY4f/6uCB2pRFVtewbvTxuQqfjccj0=;
  b=nRDfjFD61OIwOGqx/MwISySY8L9aHnLjFLvZz0HJAW7oVYxtDapkEtF7
   aCcl14HkUwUMNmurBB+jGDD3uj1zV7YtKCCuiHmnEiUezEte20nXGS+1n
   YAHQ1yAs7QGTw6BjQtROdg4OTe+d2EvUVmMKXGS6pgmj0st5pbiyYJ610
   /c2KbXMfb/4JE2pEmHVxRs/xWu57dVjRg8XgDKY65e+/4/ohPuPlEQoKa
   d97iOQG1UmnokXOM6Nfl73fCkcwhtXME+D5+vQ/v6XjFQoKcfZnegu8lG
   +G7YMynlVs08/Jds8iva3LSju0mVTavpEF3FjCRNzL1UoQ8JU0CRKk7ya
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179033"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:13 +0800
IronPort-SDR: 4XrrfbQ1pXtGzLuUDPMjdq2y0jPeOLxlfrcdVoJPOy9LA3UpQRMA5dpctcokSuh71EqCMnV2vM
 tnSZqZ4ki+Cz7ELI32zq1hK5U+gV8hu9OimeTNLBoD3TiCKBvjsVMn5n8o/r7uB/nQYe5/VQhV
 qlmq0IoJzqi0igvj5ZB7wJwdnRP9m+gEcg3Dsz+xa+JlTBcfkJ7o3CXqn53CHldBuXxOe/wAgf
 btwFH53R4hmqMLDzczWeJpkDbzQA1qMhj6EJWB04KRouZkvVIgyPepfzhtNEbsFvh6PnSYdt0H
 kYE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:47:25 -0700
IronPort-SDR: R8Q9KolEh3PImyox87/7W5F4WfnjKn9AokTtEG8JHzcsv6doX1KaIZM3MvIfOj5RAKpYBrxCMr
 /3fXjE5iW/DBc3qqp6nWL11B/5QhR/rEzPCHCbWlJZOgGhD9QusBWHdV8vh8PYGCqAHe2eVlhh
 K3RuCuXGH7IcHS+jxNQ6z9oZKGDOM7QHSOgu89qPorP6Aw1/lDasp+n6LyAittcPC0Cdllo+zW
 38OU3IwhO7t8p9sPCOPt4NncqdZlitcCJIn/E9sMJU/CeaMbpF780n7UTUV5wBNgBH65mUwqlk
 69M=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:10 -0700
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
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v6 02/20] drbd: use __bio_add_page to add page to bio
Date:   Wed, 31 May 2023 04:37:44 -0700
Message-Id: <fb78f4208bb5d1f4032be20d9ee1210468ba3f40.1685461490.git.johannes.thumshirn@wdc.com>
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

The drbd code only adds a single page to a newly created bio. So use
__bio_add_page() to add the page which is guaranteed to succeed in this
case.

This brings us closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/drbd/drbd_bitmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 6ac8c54b44c7..85ca000a0564 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1043,9 +1043,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 	bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op, GFP_NOIO,
 			&drbd_md_io_bio_set);
 	bio->bi_iter.bi_sector = on_disk_sector;
-	/* bio_add_page of a single page to an empty bio will always succeed,
-	 * according to api.  Do we want to assert that? */
-	bio_add_page(bio, page, len, 0);
+	__bio_add_page(bio, page, len, 0);
 	bio->bi_private = ctx;
 	bio->bi_end_io = drbd_bm_endio;
 
-- 
2.40.1

