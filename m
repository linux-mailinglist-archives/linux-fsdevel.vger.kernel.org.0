Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0E0717EE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjEaLvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjEaLvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:51:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D6812E;
        Wed, 31 May 2023 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533858; x=1717069858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUIQkUbEvB2cbvY4f/6uCB2pRFVtewbvTxuQqfjccj0=;
  b=eXNYbGpIVbl795yF1fLDrjoAAZfCSxK+HVTORjsLNSPBAEhh8shLIxIJ
   dTTbAGNHAkrRmZubzGEhqXXD23tTKK17+SluyhwRsvdJpH1IAQHtaEJ1b
   lrnlJI8d3Mw355xPTMzdHWQwlTrbh6snfBAmmsg+9SH+88sbGqE1EqJPz
   OvFmBPCM7+VtjpNn79hX6wWJnPu5zZiHGoLxX9dqIhETi/aawkTe9aQ6S
   toPCb5JOdDqauzpn8HKmSbbqDblvF/ALUL3emR7rEkH/jX5TTe+NIVANI
   uw/NUYYSMIRpdvQIqNUSAQ+84KNbu8CY7/Dv8+1uQhyb7ziMjRwGTIypW
   g==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547907"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:50:58 +0800
IronPort-SDR: KCvTsrBVTJ6uQDDXru1uLuaBY0YFIal6S4iS48rknpsgu5WKPkWldYwYb3oNaGk5bll2GiQwvA
 pz/evyH6T1Uw9I/Bcr8dCwe9a/B+wdvWZPAS/NsEvKJV3MqebamfeC7kTaoFxCFIj9qCjTa3nx
 EU3ctODyx9HtNZwv24YxXdO2pssoTAnO3m5qBAe8KJiRafEtqZoaAjGzrw0ynxIr+R7BlDMxC/
 QWMfec++x/E9kFuy6dam++r8BUTECxDGk2Sb/rDJVKI2CenD6D3j1F9I0c91zXjMXXwfoH/X/Q
 kmg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:05:51 -0700
IronPort-SDR: 5fbhaGDbiXGkg8+3UI34SjKA36qN8yxQFYrOzNfKBiGqGFKkpSit1Ju10bDfGDplQIS0ftPTpQ
 fD8oNw24RMWU4g7VvkH7fNvddvkm6er01jVyMTVNOtHvSwsR9XJm3ab5VfUwyO9fCxhY/DdOpJ
 rVRoCbjgJZYRe1k4mgWw9zPuHFpUZXB47XYvnY9pZ9QXi/jP1EZfI0KyE55eH/ZOvARZ0NI1B/
 I6tNjRTts0ONBuOq3LjKScjHSb4drUc9pfSOAP0cGx9F/5nOD0Px7pW/36RnXKCA79Pi9R6JLP
 x9c=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:50:56 -0700
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
Subject: [PATCH v7 02/20] drbd: use __bio_add_page to add page to bio
Date:   Wed, 31 May 2023 04:50:25 -0700
Message-Id: <435007afac14f3766455559059d21843771fae53.1685532726.git.johannes.thumshirn@wdc.com>
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

