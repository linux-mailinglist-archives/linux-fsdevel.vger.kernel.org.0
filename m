Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE271678C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjE3Ptp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjE3Ptl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:49:41 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0F4E5;
        Tue, 30 May 2023 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461779; x=1716997779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yht1tkgwasi8HpY3YFcrQQ6s5n80qKmfhqnvFToXZgs=;
  b=ClXXu22KciYPpjXpjwnQ5tOJGWs7UCl5IZknco8ProL/EJNptGrwqYyw
   LO0SRPNnTwzXYPQ8jadg1x6SqoJV9oJ/qxybyLJHgSyYQQPGpDzoiNn2n
   hyEPqBtD7g0FMf+u78rtRCK08lHh16r3mYrf+24Y7XHcydxUfIlyZMayw
   /D5//DHufRVdpnhDjlES642AA/ili0l0Jf42go1oObkRKjZlXT9RehsN7
   j8wlOPnkc1CR0ImuADTSEb7cZWRocaJ8X285ixoJN3QYJTTU+R0K4cFYT
   ejgbuFD/sHi1pjzxtN+eRFelS9nT1TT5k5e/qlxujvNDc/pIMc3khSUox
   g==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="231985969"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:49:38 +0800
IronPort-SDR: 8DDK4iQYd6VVB7IxnNpUFzDPQToIaisTt12qGZKOp8UklTJUjrSzn+5SPrzv8RJ6JCNrrXw3P2
 J0flHXDmCFaNqHKKimc4KO60KI81hGIMmun8Ews1DkmeQzbtx/uX+86ZeYoXy104e3nsJYXdxM
 7kjL7rYbktf2CFR3H/XwWJZZJWblOIpHnmWhjaRHbjgV4wIwmuKDo2GM1FLh/E+I+dJUU5t6W1
 ampixYdjCV2G/CRHqHNcPfjtOEFlVRv+T/VKJS7r9oTD+4mymaumTt1qDQuQrO361/g8MjnAYq
 Kdw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 07:58:50 -0700
IronPort-SDR: rDb04cLPnHkw83pxdqtCHKsua7HM5tgjjmF6YXHJIVLNeG4c320WrXtss9t9FpJkHk8dSG8jrZ
 U37pjVXEoaNU8XYLzdmKXeGmEFd+1dDT4nL97b8EqiMmuRm14WWVuMYkCCNNBQqq0YdinOO5yq
 Lxf5U0o9U/edHt5LmR3MVSlhItwiTl+U8LIJ90qQ/E0eH322rprOjcHnRMPPJHrvTPHPHmMyw2
 XmVBT7OeOZhz0Z77oO06/HoQL/Numzb2HGonQSheeFZI4laqGj05EvNx/k0pFoJFGK5U9EVg6i
 1Sg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:49:35 -0700
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
Subject: [PATCH v6 03/20] dm: dm-zoned: use __bio_add_page for adding single metadata page
Date:   Tue, 30 May 2023 08:49:06 -0700
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

