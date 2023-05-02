Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B10C6F4158
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjEBKWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjEBKVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:21:37 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EC159D7;
        Tue,  2 May 2023 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022878; x=1714558878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z23s94WSfkNDSGnkvvUzyIU5xJO/4E/eLJVJJaqm43E=;
  b=PtAu7S2PJUB5/TvVQ1cdJrBAg9/hGwkGw5MDukREMkgcNNiiE1LH3sQG
   Wff2RhH9cJbNYe81obBC0+itVey3RoO68yOk+2Rmr/aC+VNvUnwN7AM4O
   0OiOWuVe+o5FVzjIwtaYG158oHto5wpoBK4MrXIAT6vi4hbqb7jtfvcGn
   Bt7x+NZxfylvKlog9UtgWM+ebh/yD5uZVNif1WUTz1wWoWrpebBWcg+/k
   FKsCdmr/75rRtOR8zYSGKrZKfzYXTE4NPZEeYBuiarp6hiHLNXCCvlSmk
   ajTMgO/OyVrVDx+mI/OcqUku6+rLw62uYfD5zgneGUDlsgILtWX3UFkPw
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229597899"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:18 +0800
IronPort-SDR: hHm/0VBBHMK3sQUwLuV8BgIMeqli22sIkSDVR0JwPx3YtJrL39ig4QlbFx4H1QCipn7WbaRINm
 CPQ8Pjcbb6XLc0KEFBWJ2ymGBx3ZhhAs7lkLbv9AjoapL5aGd62iZAnP+qAQbb5Eyv+WL3zPSQ
 VgbKYzN046TrILSl1XOg49XQkcYbEnz/G37GQISQ1PPUowa2l7TlBun/iUaoIP3mgtjaoAw7jv
 b4OF34tHI+6CqauoEfGW6rtshhyPmXwgD9Aa8iP8V/pIZD5HWU/3rp32REEEvR92X/Nzsz4m/7
 1YU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:03 -0700
IronPort-SDR: 4QS0kxeAR11TAsjK3q6rHbu4+NZzJ/T6AbVXb55vKDbMM+oCblWAbUFs2YUG9KGIgOHq6CvJL6
 XUwNm6KOwnm57J4RnjJo/YsJf7KQxoqDGhV11a0uPsyKLzme4AtvTwC+ST9Bmtyv86ntqEq4hc
 s99tUUKJH1Y54xjx3kIzWz1UZPM/tbIrLj/KWTho9Mx5xM2253HnCZK5jP5kww+0Kbc2uMt5Et
 jTuZjzyn9MCje8+jDXXIghxbJZq3kwbYIlwQW8gMVAhOzG05xOEF+r5ej7Dqx979eenILJzMIN
 mEY=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:13 -0700
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
Subject: [PATCH v5 09/20] gfs2: use __bio_add_page for adding single page to bio
Date:   Tue,  2 May 2023 12:19:23 +0200
Message-Id: <20230502101934.24901-10-johannes.thumshirn@wdc.com>
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

The GFS2 superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/gfs2/ops_fstype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 9af9ddb61ca0..cd962985b058 100644
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
2.40.0

