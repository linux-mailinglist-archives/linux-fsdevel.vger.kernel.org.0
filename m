Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37950716799
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjE3PuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjE3Pto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:49:44 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525F3F1;
        Tue, 30 May 2023 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461782; x=1716997782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=asDmkxFBDABNDNnwDePSoyQARa0UoC2pBVbkyHt1eyc=;
  b=S9udaRYncrp56ozvBX/C6nYCqgh/jxrIsukVkVOlfEFOY0eGfUwQwG3N
   2jbsrK8ZjArpyF9oz6krmxeHEjWHB/5XATKvM8Z3gmNX/qG5zAA0bpZHl
   lowffwyF/V1pG08obImxobY4K7k8n+t4txtxCumsj5IcGXz1+Azxi6SCM
   j45r8GVqGAPLiCory9y/xKNwVDCkqlK4oi/6Qo7dJ/baV2LkxZIASADHE
   UySLItJFvsxXpqrDQxt4KvhTTIa5vOAQvagFQtZZFlynMKezwrXxbx8c7
   hpcNF61V0ymP74BaV8k4VHbgnryhuYI9Y6mpXg0H3ENFzfDx4o0APVe7/
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129750"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:49:41 +0800
IronPort-SDR: VRr3yQD3a3m9yEDRqdZ9CsEJT7PrpNl+UJQGzNKqoYlJYt2vMfr6ajUWCG5Tc1GaZCB+/g3Egn
 8gQdHUjw6I9Pb3MMzWpyU4k2Emyys7RqmGXpkYY81JGKHdThupDgxF2W2rSg0w5tCJX7gGSuh4
 MVa08/klxsJm9aitPIDjxNsiZ3beWRovaMz+IEqk5Z0t6zEYxf/+T0+gTDGq1VrxzA1Eqjsat2
 al3xQPapCAPPKTuNFTsEUpyGkxKBCNDT4ihda1vP135j+vYYWJb3DrJCZenh2v679CfU7qX9M7
 dZY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:04:35 -0700
IronPort-SDR: flqRBN6t8oeSRa1BabMxnUCvrp7PztzsM6fP6YmtGqWahobry6jFcPjHqu76BmTmRg0k7xB+eW
 Xd41xDIbR1903c6oA+KNiyFakHUZmxnJUerK8kgF9kwCVwoChx0oBjxovMtZJ/BUIUTKUH9A2r
 71Gjv2BTIfgq1jrGmK0RWrNe0WL9Ca0Hz/IorQC319U3yD+iig7YZY1mUOiG90XjQrt9L7sEd2
 guJGoE6VxoZaYn17klSHxaUFROzgECTIVBStNd3SnsVgan18w3VkwfB17pJewsQNiwzdzvk0B0
 ZGE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:49:38 -0700
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
Subject: [PATCH v6 04/20] fs: buffer: use __bio_add_page to add single page to bio
Date:   Tue, 30 May 2023 08:49:07 -0700
Message-Id: <f67cc9c310bed1e3c3302ea1c206da7d5ebc14cb.1685461490.git.johannes.thumshirn@wdc.com>
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

The buffer_head submission code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a7fc561758b1..63da30ce946a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2760,8 +2760,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 
-	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
-	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
+	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 
 	bio->bi_end_io = end_bio_bh_io_sync;
 	bio->bi_private = bh;
-- 
2.40.1

