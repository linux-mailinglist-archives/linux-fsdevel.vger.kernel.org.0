Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D356D01E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjC3Kqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjC3Kpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:43 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3B9755;
        Thu, 30 Mar 2023 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173112; x=1711709112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+EV0JXQ4xe5HTVfKptkUC3VI1nVjFYuHFxhKcqwjlik=;
  b=BiZAlvEPl3M9tE7U421INIRKlD/Yk27O62by2tJUDqzbOFok2RyLTnEQ
   nFL5TVtL6oHkZryrzTXkXFhxYFdvhjVWzifvIEg0ifkFfRqDXbZxKxRql
   9VZOJAGrwix8ABdKosX3SyyYj0CFBUhzFTAO3JjGUOrSW/mVA6VYWEXLC
   Ef9aJjUG3Rntg0gzstxEJCmtjq7ag3ck3cUaiXw5WOsL/eIm29xR9I75y
   1efrHELHQGTbXb9c6xTAgwG5aQ7OArWII2a55zhvHwl1iE1TYClzBXsw8
   J7ih21imrp73OQy3wwQB/gswt8dcjyETtN2Be0aCf2OnhS58Q9b7ytNtd
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317862"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:38 +0800
IronPort-SDR: 0winjPGGK+OUaLgvj+p12dxE4N6LTrOJ3JaHKzbcaFhnTy2FxRsDms4PdW2FTdMCsP85ajN5/s
 082H6J9iRnBtNDqLWh5VpeGwpeRkMrL9IaPK5GytcgP5z1F/VFzuVTSXnUsTVtVNayY/ryAxNt
 BZFBUS0Xlar93v0a61Pe2C8Y0oBAZZOFG7onSQAZPnT2xCZ1h6l/1uesiOAoqMMsqQNql+NB02
 WX6z2SL7w/XT6FnspKYysTEbOh9yrjxkODNaVHMaAPDdJROvB32qsUlTZxXqjHgGN0bAw2rwuz
 q3E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:46 -0700
IronPort-SDR: 0juN/UCrJrwrTW9FmNQ8IreQ3Z/kXco76QckMcW+qQoSIff9Nyhb6/OfK/wD1wpfYAg5ZX87cC
 hHTNwhN6I4j0PtZkl5gWf547ViC6MsjnMiBEri75CfYRnl72fKv/Ii3ZodjlNoW9efkmVbaTT1
 Dz+z9w4GmptBfajSperiop6zUnGQTatXM6ubDhqu32VMSVzozkhANFY1FLEu8lZ5j3+I02RtEr
 AfbmNUU2OTcGt219K9VJZ5i/36ngrCQVIiGqlblt18Dsz9wpIPU3/3tF9Rx1KRr3aX1G/Fwzqk
 qgA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:36 -0700
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
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v2 11/19] gfs: use __bio_add_page for adding single page to bio
Date:   Thu, 30 Mar 2023 03:43:53 -0700
Message-Id: <2ede486fde05be1b97328579c5f84da48efe9156.1680172791.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680172791.git.johannes.thumshirn@wdc.com>
References: <cover.1680172791.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The GFS superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/gfs2/ops_fstype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6de901c3b89b..e0cd0d43b12f 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -254,7 +254,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 
 	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_READ | REQ_META, GFP_NOFS);
 	bio->bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
-	bio_add_page(bio, page, PAGE_SIZE, 0);
+	__bio_add_page(bio, page, PAGE_SIZE, 0);
 
 	bio->bi_end_io = end_bio_io_page;
 	bio->bi_private = page;
-- 
2.39.2

