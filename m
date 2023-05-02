Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760E96F4104
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjEBKUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjEBKUl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:20:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806F430F9;
        Tue,  2 May 2023 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022840; x=1714558840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9iZj44wPsEck0/AFW/flWeeHkPYU6GMDPlSCG+jgWZM=;
  b=fUVItRkvhu/C4usbLuPLa4nqMFxOR65x6hqKGPlUukCfIr7Dm0fcsHhm
   jT4y5zEie/v6I+HMYKqhr6CbUeH3WKZ6sFvpmevqN5n2876s9bLZfr3X1
   1b8B9XE54Wcaq8Qktvizx1eRvo80nmfE+oB8mmGltS7R3MSqsSG2GiBti
   ox7W8/Yp7YrZLqBKMOHdHK07s4Nxt94rLqm2ZOyEHWyC4BYAx7zUrN+Yo
   yCbTqq6kQFtwh3V9C17rJE9C8+voSTNfiA6WJlUNrOFreHnCR44fG8JCy
   sCDwQ1v64cP8oOlXAWPKbOdYwEfzJK9prfdigxP6wlnySNNd/Td1VDL5C
   A==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="234672819"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:20:40 +0800
IronPort-SDR: 0AlLw+wR4eFB5CCSsblTIPQsBMzIIAt0Lrn9OLPp5/r6BvnCG5dz3ztghkQ6FEklOEV/mqX5tu
 DmcKFIjoJB4LZ9CaqaV2QFuY2D05OFXQrgvD8t43QDjSMirOW2IbMRWijw469Qj8VhwZpUKoDF
 f/HtFc/944rPkyaPVdw2cCshcqqgquBuBKzaKpZouqSQ+l7U5AkdCFI6+STgvi77qo29BXofAQ
 x06hcCyyPjXSiD8VnTtKcyLEw/PpG4lM2DXa6VWLrZ1dZNyV1zEC5MBCWeT8jZH4ObYQC7KhKP
 RHA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:30:27 -0700
IronPort-SDR: 02ts8M2ULEXIIQnCeKUUXKET2iYQVZOPeI1lsh12iKPVk+qnVNbuJKmlBBWt8kg6vDqANkUPjP
 S88ZBNuvUPdOJIVrPg/7LZtYELJoOWVn7WGdO66mTrgszCRUCBkByH5V0TlXgfYP8a477LSy47
 8PsG57T0aCd8AhDDweyJ+TxqQuuSlzTrnnljw73aoxjoLO24lM+jJrGrwmoTvR0RGn4d8si2DH
 oPX5IDnKX5tdhmZVSe+A4YScdD2m+NHjpjZHCz65IpUJaZ8b+bdBmJW9nFreuq8/HgVWuI80RN
 TgM=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:20:36 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     "axboe @ kernel . dk" <axboe@kernel.dk>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        damien.lemoal@wdc.com, dm-devel@redhat.com, hare@suse.de,
        hch@lst.de, jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-raid@vger.kernel.org,
        ming.lei@redhat.com, rpeterso@redhat.com, shaggy@kernel.org,
        snitzer@kernel.org, song@kernel.org, willy@infradead.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v5 01/20] swap: use __bio_add_page to add page to bio
Date:   Tue,  2 May 2023 12:19:15 +0200
Message-Id: <20230502101934.24901-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The swap code only adds a single page to a newly created bio. So use
__bio_add_page() to add the page which is guaranteed to succeed in this
case.

This brings us closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 mm/page_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 87b682d18850..684cd3c7b59b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -338,7 +338,7 @@ static void swap_writepage_bdev_sync(struct page *page,
 	bio_init(&bio, sis->bdev, &bv, 1,
 		 REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc));
 	bio.bi_iter.bi_sector = swap_page_sector(page);
-	bio_add_page(&bio, page, thp_size(page), 0);
+	__bio_add_page(&bio, page, thp_size(page), 0);
 
 	bio_associate_blkg_from_page(&bio, page);
 	count_swpout_vm_event(page);
@@ -360,7 +360,7 @@ static void swap_writepage_bdev_async(struct page *page,
 			GFP_NOIO);
 	bio->bi_iter.bi_sector = swap_page_sector(page);
 	bio->bi_end_io = end_swap_bio_write;
-	bio_add_page(bio, page, thp_size(page), 0);
+	__bio_add_page(bio, page, thp_size(page), 0);
 
 	bio_associate_blkg_from_page(bio, page);
 	count_swpout_vm_event(page);
@@ -468,7 +468,7 @@ static void swap_readpage_bdev_sync(struct page *page,
 
 	bio_init(&bio, sis->bdev, &bv, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = swap_page_sector(page);
-	bio_add_page(&bio, page, thp_size(page), 0);
+	__bio_add_page(&bio, page, thp_size(page), 0);
 	/*
 	 * Keep this task valid during swap readpage because the oom killer may
 	 * attempt to access it in the page fault retry time check.
@@ -488,7 +488,7 @@ static void swap_readpage_bdev_async(struct page *page,
 	bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
 	bio->bi_iter.bi_sector = swap_page_sector(page);
 	bio->bi_end_io = end_swap_bio_read;
-	bio_add_page(bio, page, thp_size(page), 0);
+	__bio_add_page(bio, page, thp_size(page), 0);
 	count_vm_event(PSWPIN);
 	submit_bio(bio);
 }
-- 
2.40.0

