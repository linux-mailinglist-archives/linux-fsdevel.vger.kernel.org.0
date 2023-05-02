Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3FC6F4118
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjEBKVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjEBKVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:21:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0A59C0;
        Tue,  2 May 2023 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022849; x=1714558849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6dUSVfajEldYN5Oupo7JKyZWBoRWVt/rgYFEzhpo0c4=;
  b=lpshQwIF+txQ0r7x+OOnWsDfLeHF+Pssy52/bPAtjpIxajXqU5wQ8+01
   pOdx7DNHqbVZ1uBRuvyRwNxmCCvHMLOBWt3GUsQndkpGtTBN63BhGgFpT
   07zCji/wAm0790HFSjbpYeZVeVfMCp4GM6SQp+HMknezVyccNZZo3n08y
   cE0UxqPejBCKrVp3sLCV2rgTFuTvuo2NRU6aEaGNJp6aLnwhd5uWII1cG
   QtCwodCYKqSjpwOHKd32GQUg1eCmX3HmMXlgJf8+CF2IGUpd+ilb4KX9G
   mBzNVwUvJYCJSvZ8xgaWK3ArHtkIW+12tcjMfQv5rdTScMEwKrYLRAt0m
   A==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="234672834"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:20:49 +0800
IronPort-SDR: OOIPJXT3u0EkHcmEWTwkVky8rkXkRpD+S0W+3/PEMQyGsMXWd75S+5zl+XF55qAnTDkgjDL1be
 XvBktL2hmlCnoSCSaOShtgSOSmX+El919ebFGK01/SGuUZYHegGxtCY8i9YSpVbT79sdYzKQ6n
 2tgZU0E4EGdb5xQ2A82lHvykFZhOSfQpSy+E93U+PT2+vHtkBx/IKyRwAhpR5GkdrtHF3Dtp+i
 lq39BfcSDcs1OFLOWMlC+Sl/fQFH/0QRpBpzlWETNwdLmGuGYZZuKys4hEsfywwAt17mFV4AXE
 2Vc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:30:36 -0700
IronPort-SDR: izj1TLhxnELM0NHoBU04SGWT3AVjAUqJVEZ7r3PJykX/ZdoUGxAr5EDixoNXp4/1ubYh6EB4GU
 VgNk6nLvH0j+QUUugolt2ulmPIOfrX4gESgZjdrdfbINt/HygPVllIP4O/fbcchFgi9WiSvH9x
 H5LeMGLC2jUBUTkFWd2BcC05Jqfr/W3l4NjYsyVenLNxN2zWI1M7l2Gm9QIeCoI7VIuq9XXK5R
 QOBUOFUcBEFOcIGquakdmPM9MsnLTxE6T/58wESvv3DoqJ049BaL+cUOm2GMivDIRVkL2tDJyJ
 AjA=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:20:45 -0700
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
Subject: [PATCH v5 03/20] dm: dm-zoned: use __bio_add_page for adding single metadata page
Date:   Tue,  2 May 2023 12:19:17 +0200
Message-Id: <20230502101934.24901-4-johannes.thumshirn@wdc.com>
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

dm-zoned uses bio_add_page() for adding a single page to a freshly created
metadata bio.

Use __bio_add_page() instead as adding a single page to a new bio is
always guaranteed to succeed.

This brings us a step closer to marking bio_add_page() __must_check

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-zoned-metadata.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 8f0896a6990b..9d3cca8e3dc9 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -577,7 +577,7 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
-	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
+	__bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
 
 	return mblk;
@@ -728,7 +728,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
-	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
+	__bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
 
 	return 0;
@@ -752,7 +752,7 @@ static int dmz_rdwr_block(struct dmz_dev *dev, enum req_op op,
 	bio = bio_alloc(dev->bdev, 1, op | REQ_SYNC | REQ_META | REQ_PRIO,
 			GFP_NOIO);
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
+	__bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
 
-- 
2.40.0

