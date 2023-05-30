Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE29716796
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjE3PuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjE3Ptn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:49:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2A3E8;
        Tue, 30 May 2023 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461779; x=1716997779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUIQkUbEvB2cbvY4f/6uCB2pRFVtewbvTxuQqfjccj0=;
  b=SfoPf5otv26oVOwnNPa60YerJICm11qq0xfGRZ+IfSYL+QwGHPjS6Iw/
   ibhW/d8aApmaAAybHLogeMrgyAOjTsgjPksHkwl41PGeZkNqN9md2c0G9
   NwLWa6T1MDLmZ2b+/xVgjbensq/Nl3ScLv7ycFxIsxDirf4CHnmbPppmk
   z0ShuvLvZXweG60OIQGliHDIRCPWSI0heDhoXX0wVX9469eNd7QF5xJJG
   7CSkJIiKfv8ZDdGAUb8e8IdjuoniQP0YKbn1p/O0+c7mBNEPndurbkuKE
   qhAJkytYFrv0i2A1/UfMh5LfpunezyYK46hzRNJafT0/9sRtZLytKozmf
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129744"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:49:38 +0800
IronPort-SDR: ZmvKuexgVBbuxJRt0SLuyepXOzHPZ+6OtlcXDkgIveTGJBN4Jxa5NJQWj//lD2aNgfDZujH01t
 hpajlyjLGCVorzMBsOI/7RXZWehiLUOoF+SDYEoZizgSDTN0w11HcxLrvFDo1djNtc8ePKw6p1
 Uns1yjWl51iqOMMsKBfXdzDqMyyZAp6w/3E/IxjVeGQNGZz70LsmQ2dEntM2Km1FYX7aFC5k3t
 rL9WUBhA6kMz1lMxji8T6Og2+oEmNucl3tA1xeFF3V4vs633NkQO1RTf65QtihS+6SGba6ABfo
 ZoE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:04:31 -0700
IronPort-SDR: yyyyMz2TAyAtxiGu5+SWb7d/x9PogCVD4itlH+FOZL5M/obbujzn0nPyfJX5f76wmH56HSlR9F
 zkurIL57b/oE5ItIAM3mh+0TCxwpK0Osc0l70ZtbuGZDq2Rs1n51DtbbNViftHEWLZ73mey9zy
 2cUmbpQh/Z5J5zOcjj/YTd3YK2PiCTKftG8A1EENSystxnnFIuMK7Oe+UZdJx94whGX4awAqm2
 /U8JBrcdaMvSOP4HNMkLK5PxyRVKrvl3XxjQW8zcaD6MbGJ9RpKug8LVrI9FIoeuVVWNz6eSxF
 8ic=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:49:32 -0700
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
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v6 02/20] drbd: use __bio_add_page to add page to bio
Date:   Tue, 30 May 2023 08:49:05 -0700
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

