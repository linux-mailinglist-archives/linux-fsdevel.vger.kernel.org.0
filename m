Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B868717F00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjEaLv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbjEaLvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:51:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4962138;
        Wed, 31 May 2023 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533867; x=1717069867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6fCkYLHLU2sdscgq61bKtq6BxI8MUyl+IQuxHUEXz0I=;
  b=fs86VGy9KboqeQ32EmkGWhft4YnnGZOheQ5ZQpxWzPw68B2sz8x+Wp62
   3q6l8Wt0NkUgs693IdODWD71T4lQVs1lgdfdZz1n4XO4jg1RUTha8Zwns
   QcPEGozlh73wm+1Wrjji2PyQ1wN+v7YFGgtPNpE0Zz5/8bNQys1SvxSS1
   KMDW52XCG7GKtQ76yttVe9A6jJhwjK8ib8mjwBbZPW39DJk+kdIYXcNCT
   Rf+9Uzgo8/imCH6RWR9CJsQiZjqDEoCD1u22UetJz/SoFZ7JtVB0aDf8a
   8zdaBlT7c1hZopcYqx5zmlWlNF/XDypsOy6O9dI43GqdLnT7fYLNNhDsw
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547920"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:07 +0800
IronPort-SDR: mAGz2Zb9dgx7kbhFHzKH/59eNIrpkq7XAfSAoi6TSR/rghm+rVry+Do4ycarD/GyOB1EzxLHIR
 RygkBxTzGf2jJXIKxqRQHMRvaCMVsEaHNgF7UxE7xcbUwcj2vF9oa8EUI8gquhmJHDqmFMd0Sr
 If/Oegsr4BuA68JCar7d2dL4Dz7W87OdCavV2iPb5mox+CD4Gjo57sh8tn3eBdjtBgK6pwI2BQ
 kldA3H1wxNE81AcJ4Qpu3rKg6BxJlup6Y7AIxkfvrwpQF7fxj09fXMIr2fK/LKTlea0Ph4n/G/
 K/Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:00 -0700
IronPort-SDR: Gn53kE5C3awoJBs1z8/fu9zSK3J2c16Qw5Ap/LwMuYuq1ak1onfG41AzuFrfFpDgw093xXiL8G
 5IDcs8WVq7GROIbadARWQhW/82INlpRG5KezVbrpCpjOVN1FS7s+chB6/dVDBhvHoAzlmzvsFt
 +UZ3q3RZ0XLcO9O7h/52/VdpNEexXInUlEcbNXk1U6y9Wg5zi88lpDr34tQ0Wi9aG36WAafIri
 cEDqzhOb2lXEhROumtjAKvyFK4NA5YKzTDsiWVMUWQxoi2jyv0y9vscB6TDzCHDh05FrNT2GE7
 w8Q=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:05 -0700
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
Subject: [PATCH v7 05/20] md: use __bio_add_page to add single page
Date:   Wed, 31 May 2023 04:50:28 -0700
Message-Id: <ca196f5e650e318106dbb4496eb6cbac4bc800bd.1685532726.git.johannes.thumshirn@wdc.com>
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

The md-raid superblock writing code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-of_-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8e344b4b3444..6a559a7e89c0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -938,7 +938,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	atomic_inc(&rdev->nr_pending);
 
 	bio->bi_iter.bi_sector = sector;
-	bio_add_page(bio, page, size, 0);
+	__bio_add_page(bio, page, size, 0);
 	bio->bi_private = rdev;
 	bio->bi_end_io = super_written;
 
@@ -979,7 +979,7 @@ int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
 		bio.bi_iter.bi_sector = sector + rdev->new_data_offset;
 	else
 		bio.bi_iter.bi_sector = sector + rdev->data_offset;
-	bio_add_page(&bio, page, size, 0);
+	__bio_add_page(&bio, page, size, 0);
 
 	submit_bio_wait(&bio);
 
-- 
2.40.1

