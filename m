Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1473F6F415D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjEBKWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjEBKVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:21:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F36527A;
        Tue,  2 May 2023 03:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022882; x=1714558882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RNSKAHMvkQdyo+4c/AL7LVpo7PNOthlJkp/YVH+vRC0=;
  b=UTTxMOR5QUcM9F9bjk3RXLIMyxLRpGLjnO0oIcf7TvoCy2waVhAsIRCT
   48dFpVCFPFwgK0rpQ8iAmJYu+BI7DGReTtJzC33Uv/vg8x/j8jhdn3pQD
   +QSl7efTx1QOZpcSJZ5A551s1XRki7O9pewJKPKX5jNheBGHu89P5eZZ2
   fKUD4d5cMX31dWREzrzKLbRPpGfIt36+PwAxNxE1dolBifrv2hTbvKaKf
   yNUaFvhjQKF7utK44GPypPBMZ3Gt3ZrYJmwcFpYLEBVNbZoBOzg/v0Zhs
   i5bfwOrKmN9PAYXFpjsievljNhNRe62Ew0mcfw70iWQQjCgG5nd76ddF4
   A==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229597904"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:22 +0800
IronPort-SDR: 7ZQeRtyFes6PhA2iWxhI8U6WJo9tJyzaFNICTPzKigOi8iWnT42GaMQWVTEULb6OLWw+kWvsUb
 bX8f3/vcggyDA826maWriLYnaqTWQD6FevB7YAVVHD7XNkiNdEu0TpD9draKgC/0LYS+G1d2li
 F88OQndLibJLcsf96NomckIZzW+D8SG/MVYr+3DFS1xlwE4oEySDLsQUS6lbyNFqdmxZ7aTbsU
 o/wX1aUvRRDIjKFW8VyvXe/oE3F4ihYU6A09PT4d0ZEcfE+BA/UqVEDeSjxOJDwOtgnawDJVKQ
 ajU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:09 -0700
IronPort-SDR: OXftfXuzS/ylyqnOnxToR0e4rnrEE+M2SfxYzfUhqTVRY+geH2QOyPfDvF1cGkLL9mbJeyp2hq
 mdIqLtoGwBXeS5BfK4Z8vSFMEtEpYjMxerMUsh3kSYcWBq9PuNhF4VGLXxRmBwCd6wr8/QNqqs
 4tRqp2Zxk4Qwc4ad1T4W2sP+crvnVDa5K20G/IUHvqVpxEL7P4R/ByV2un4SIHzKx29Qilb89F
 qgu3l1IZBOG+QkdA+5gbyGPQWJMgjJxs0Ml9+xbzyuALTexLar2VhaNNoCD6dUf87J0wANr7pu
 JyY=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:17 -0700
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
Subject: [PATCH v5 10/20] zonefs: use __bio_add_page for adding single page to bio
Date:   Tue,  2 May 2023 12:19:24 +0200
Message-Id: <20230502101934.24901-11-johannes.thumshirn@wdc.com>
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

The zonefs superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 23b8b299c64e..9350221abfc5 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1128,7 +1128,7 @@ static int zonefs_read_super(struct super_block *sb)
 
 	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = 0;
-	bio_add_page(&bio, page, PAGE_SIZE, 0);
+	__bio_add_page(&bio, page, PAGE_SIZE, 0);
 
 	ret = submit_bio_wait(&bio);
 	if (ret)
-- 
2.40.0

