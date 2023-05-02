Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D706F4120
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjEBKVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjEBKVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:21:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A6B526B;
        Tue,  2 May 2023 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022853; x=1714558853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Es62g6k1ZlWhgSA6WjwLlc4pXpvWcgAwLvB3w8C65Gk=;
  b=At4GCKdq0HmD1eb+PNmr4QdtTnCctMUxgafK3TqGCoP/VFOt0beZTPv2
   I2nY097ArABB2aHOgniMxO1tfyLUP1r6FyZonkNkC54j2yS/apVilU/t3
   v/2DSup+xfZ8ohqQbk1TwXKgkdGWjPfZukNq3EGkxnyYfO4++S3XP9J6f
   mEGO3EhEMKT16K2GDzUGIkWLIr9ctFMOkKXcYIvb62kZuVXsX7L9NLEVl
   yVLZo//+W9j/HGQWe25WuiIHPea+eRY96GRIpXvrn8/gvL2vhDLHJgdNp
   2P8fnCbWukOmXylRdPC4x/TK6ytEWCPFLBhybvN+SNVRURW4p4c9lMrgY
   g==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="234672841"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:20:53 +0800
IronPort-SDR: HCS6qOvxJGpgzsSYFzYOhvwstQ+WEaEpCa7/MSboMXj2ViIE4IOOqAgC8YQGuMvGjKx83G++3y
 OWQJlhB+LDxGL7WxJAmNGx0+RHILlO1qA3FkHJwMYf1IuZrF5K777knfsGFsOGGNLd6JvDfRrF
 nstiZv2Iq78qBGLoYBqEeaavedEOiDv39fwu5wPhgBd9ScUVb/Mr5vLElvcSV85q+eGfVZZvtv
 pQSFFluxPRraE5zp/lp+PnKRsSLMa8xR46w/apksQWjUZlo5KNgsKxtm1jqkv1QjMGzhe9Vw9x
 ijc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:30:41 -0700
IronPort-SDR: lZvLJJNtit6YaDaRBpAoPeA+okMXi1NgBhcPxuv1Yj1Ti6ZR/qtMcFmyzA1CfeQK9Pm52oQ4UX
 KijqLwLr15wFCQ51AUQnZWWjgtCohUdv1nJi/CHpIu+F1EOxkUvPsh0Om8NjYgSZly+8KyWjI/
 xdAuOSlf0xZugpuHVN61JlWiVSWBV5uiFwn5N8ol3vENfCoFPsM6Ej5IFQDNt6Mdr8+XUfaqOo
 w1LhiCL74i+xYwatkvZWipXL1PHg3LZseF9wsfZrOCmoMv39jP9sPSI7W2Kyr6m8JvTNnzZ1Kh
 VWM=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:20:50 -0700
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
Subject: [PATCH v5 04/20] fs: buffer: use __bio_add_page to add single page to bio
Date:   Tue,  2 May 2023 12:19:18 +0200
Message-Id: <20230502101934.24901-5-johannes.thumshirn@wdc.com>
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

The buffer_head submission code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a7fc561758b1..5abc26d8399d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2760,7 +2760,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 
-	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
+	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
 
 	bio->bi_end_io = end_bio_bh_io_sync;
-- 
2.40.0

