Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD423717E45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjEaLi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjEaLiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:22 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84461101;
        Wed, 31 May 2023 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533097; x=1717069097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yht1tkgwasi8HpY3YFcrQQ6s5n80qKmfhqnvFToXZgs=;
  b=YgFEWBW2r9hDk/cAmvwQA8MzdtLdbJY3reyDZZuWyQ/K1PsMnV243mDb
   7V3+wuoRYC0M/lJ9VpjS26N/szsf3kj/p3M3i2OiiazcovPGUTo6igASQ
   Tdf/wD8dRwbjqJpEgNvouuXnC44m8vL3X3s5z6qAaXWN0xgxKuqvcQ7LZ
   A5jDu2hVGAT+6mOZSXwhd3SKjdxB4CYN2oK42Hz3KPhHjrszkMHHbEeR4
   XhU5Jog9gAgYgJZxIZtGQrqQWgfCovwLWQ+NSx8095hnwsG/TSNGem/Hf
   Ywfj+qn7GNW3P8pEejCB5NRzkbEwjHqmTQ69A2ohnIs10fhJjH19BMMUb
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179037"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:16 +0800
IronPort-SDR: RwejYagGYDVA9Zd13DN9UMWct0wx0vta5G2PAC3fHh74zhYG7KcExFbkDuzJoRGJ6rY/GPtmXw
 uBMK6Go7nobooZ6nsNQ8Y5NsztXJKWzGYeVG0zM/uCKP83iwRerkUFvssoqdKPDF1ZsvN0kg49
 T5oJY+8fjOAxK+3luI3Hr4KAjxXv37mR9Ez/xE4pEPEQOanWfxXYVX/xjX+azBcBXlxu9tUNU5
 w3ZfbOeF+UEhOIou12cZEku2EmJp5lX7YWf0LmQOFtIL6F93SPszUbSP6U5I8fLRZ6c7BYNWoI
 aQo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:47:28 -0700
IronPort-SDR: aPjI4Aowf3BAw4HyPTHwe586tS+GhsbH6LbxtjNDEqp0WGGu4eJEZvlZ7KNrJhVT33tgqetzhW
 XwkSqfLCsZHb5IvstRiMMooBg4SBVgsjuLYTv2WHeC7DLowO2VHZhvA4+/Et/McTMVeQtX3tvR
 kAa6spcBbK7TX+E4ySSzSpwMjmeg8U3fDI+kQwVaoDkG7vZP4wzM1IDokEWawa/OmRDTKynAjN
 ksx5PLnbxRQMV4keDvMfYjZoXhFeuXHboW5imfh8TswE6u7p+vNyhzLgbTv2BUkK5JIObfEPjC
 gx0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:13 -0700
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
Subject: [PATCH v6 03/20] dm: dm-zoned: use __bio_add_page for adding single metadata page
Date:   Wed, 31 May 2023 04:37:45 -0700
Message-Id: <442aec07a192f0b2fe918b66357bdf7d7c25ffdd.1685461490.git.johannes.thumshirn@wdc.com>
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
2.40.1

