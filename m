Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1084A717E4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjEaLia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjEaLi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0F5E5;
        Wed, 31 May 2023 04:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533099; x=1717069099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=asDmkxFBDABNDNnwDePSoyQARa0UoC2pBVbkyHt1eyc=;
  b=BnitghgoInjgbfXIcpUGadQW2kNZdNs1qWL0k+EIyDd0P0+h4Pvh2lq1
   s8IktGWfmsMsg66tSLjEI1/VsJOg+wDOPnSWz86KxNtdj2gZTzT3dY0kN
   6xUA9Li6DTn+JrJOpLc5/ezqR2fRQ/Gai5NSoD8KuxXp2Q1b5i/nJPE4u
   3luXp2S77HrPggGjEbma/mIbBeYbbV33l3iXY5TBcr3II0WaGVbAoFg/r
   fJboey2abXCDP873DKvN1FrFt5Lr8LvDBttwLzkqS8F+qedbWjHG83fMZ
   8ZX2tIEA0tMnmeZz201FGPpuOfPSL/UzQdHsnT5xAxOW9fOwf1hggxf/L
   g==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179042"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:19 +0800
IronPort-SDR: AYBKSt9jYDj709chqZch5CaVjJAvDytckS7ROgeNWcZL5Kx+h06iD/GhsqMH88WfklhzilAlqe
 LHYpC4950DdRfHUQ0hnwRCZJr7tgcb4zAq9hBp9Ya/64tSMkIADsQFWcVBC1xEG6sQidqSKhQu
 NNKKBFEHjqIR53PsC+Bqp6hMxCToN4E10fCQNcBZemqn3EvVwiHipoxEwzqq1YfrHkYcc5MBnX
 7AtUpfhw/XqGN4GeahucLLaWSoclYFuubC0001C5095utX4ihLxHFkrk7nl9rCcotAoQW5wmpq
 53o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:47:31 -0700
IronPort-SDR: XC7JyXZtD1AEkO0rA/hRbgeGcSTw+VmUUN99NBXvCxdDrY+InQanrPuCKDB7CLC8eMRPlGmNC3
 QiP8gcRERHHEIG2OEk87W6d/a8pDEb9iSfZ5KR8Ewslc87cWwPB67fwIXQHbcXxPIwG7ZTiBzn
 UT3zWjl5Bm65XKzrDX228nUzYwsiSEBs51Wqjf1alb4Y4TWnkLeV2j77LU2xqX04I1XVfiBigu
 157hk7ifukR1InqLyOYwym+YXVQDfpTSDWIoWJGKIyijkdJoXxA7tfXc+of8uv3Y1diMJUHEdy
 z60=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:16 -0700
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
Subject: [PATCH v6 04/20] fs: buffer: use __bio_add_page to add single page to bio
Date:   Wed, 31 May 2023 04:37:46 -0700
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

