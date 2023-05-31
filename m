Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4D5717F2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbjEaLxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjEaLws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:52:48 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E7129;
        Wed, 31 May 2023 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533918; x=1717069918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6E0YSkUBZHvEVigQ1cP3fDbvdT5Seq5Rp2IoJ9HugPk=;
  b=f017nVspfECzspd3Erc3JT/t1KOMem960Vfc4ZNtSgrwLOUwo2SkChZX
   AG/5ec3S/azq7eWi3r7qDBlITELPZwNB61OxzuqGAUPN2fYHZsLVysNcY
   BfKd3KMawLIOjnUeOCIpSV2aYRaBmJBZ8C/PO1XY0dI+S0iazjppp6ae9
   JRDDjZPtIyyHdjv/82ni099WZ3Nkq5CxIec7gw6co5NMXXcYAjbKYB4pf
   gXl9pkypbUM8CPvcAONnPeldHCxx2+TIn4I66+cJt5kdKud5/swmaVgi4
   gkV8jEMaULugE+r65YGXWCRkZY6HVkCUnGfw4WBB0UXKH7sp0HKDKo5aT
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547979"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:37 +0800
IronPort-SDR: igoNcNhcpj6zJ2uTUtRBX7FZ7phySWwUmHOeh03/VzIi0bS0ijf5Yc1UXftBpdbpPttHmpr/2J
 bYTeZI84Iv6bugxyDplW300zS+3+K7XG3EBbDPPjQDRr5G3b5EdkxztOo5OgC65Al1P85VrWBP
 q9oEdiO3yxDAwSS3nDibxfdKdtycqQPkEG0tKUJn+8+yS8B0EBpoqkIK5Y9QZclrmr6rxUp08W
 x452JSkuobWfGo5oSjYo2RQLaI92VDtQP5a9SQ6g8UGWh5fj80UZJJlSFkwkJikOZaBpenEpIN
 Ydg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:30 -0700
IronPort-SDR: dj9wdSmathvJ1jOI9aJAqtcU+ByV1jbR7k6k/UPOi9YViazTXsL8jm7ytyX8fRKf6g8on0Tw5c
 l8RC/N/qurdeB7sQNWHsX61rXiF6IyZIV6RgzzkT88Nv8OOVuY+L5Aad77sOASOny1yPabjYNl
 gfA4qWBFySa/pn1UC+0Ui4ujsIjkOFt5upt4p23k3JYTaHIYineLkqgSOpgReCb8j2J9o19Hi2
 IsqVmYyiFwI3cXTnXxXq2BtR4lvT+jp7R2bqCuuxAAIFYdFWMXE7jRgd22L3cDz6QsfNcuAWwk
 Up8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:35 -0700
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
Subject: [PATCH v7 15/20] md: raid1: check if adding pages to resync bio fails
Date:   Wed, 31 May 2023 04:50:38 -0700
Message-Id: <33aea4c271220dc9bcab58c4b7bec478c1511142.1685532726.git.johannes.thumshirn@wdc.com>
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

Check if adding pages to resync bio fails and if bail out.

As the comment above suggests this cannot happen, WARN if it actually
happens. Technically __bio_add_pages() would be sufficient here, but
asserting the pages actually get added to the bio is preferred.

This way we can mark bio_add_pages as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid1-10.c | 11 ++++++-----
 drivers/md/raid10.c   | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index e61f6cad4e08..cd349e69ed77 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -101,11 +101,12 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
 		struct page *page = resync_fetch_page(rp, idx);
 		int len = min_t(int, size, PAGE_SIZE);
 
-		/*
-		 * won't fail because the vec table is big
-		 * enough to hold all these pages
-		 */
-		bio_add_page(bio, page, len, 0);
+		if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
+			bio->bi_status = BLK_STS_RESOURCE;
+			bio_endio(bio);
+			return;
+		}
+
 		size -= len;
 	} while (idx++ < RESYNC_PAGES && size > 0);
 }
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 4fcfcb350d2b..381c21f7fb06 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3819,11 +3819,11 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		for (bio= biolist ; bio ; bio=bio->bi_next) {
 			struct resync_pages *rp = get_resync_pages(bio);
 			page = resync_fetch_page(rp, page_idx);
-			/*
-			 * won't fail because the vec table is big enough
-			 * to hold all these pages
-			 */
-			bio_add_page(bio, page, len, 0);
+			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
+				bio->bi_status = BLK_STS_RESOURCE;
+				bio_endio(bio);
+				goto giveup;
+			}
 		}
 		nr_sectors += len>>9;
 		sector_nr += len>>9;
@@ -4997,11 +4997,11 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 		if (len > PAGE_SIZE)
 			len = PAGE_SIZE;
 		for (bio = blist; bio ; bio = bio->bi_next) {
-			/*
-			 * won't fail because the vec table is big enough
-			 * to hold all these pages
-			 */
-			bio_add_page(bio, page, len, 0);
+			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
+				bio->bi_status = BLK_STS_RESOURCE;
+				bio_endio(bio);
+				return sectors_done;
+			}
 		}
 		sector_nr += len >> 9;
 		nr_sectors += len >> 9;
-- 
2.40.1

