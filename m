Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6A6F414A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjEBKWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjEBKVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:21:31 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D2F59C5;
        Tue,  2 May 2023 03:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022874; x=1714558874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GdWYuRal4gtN4Ezno5RYxoKK4shSZO/plZI344B5fU8=;
  b=h9otU3HY2lpCXNeEM8bsMfRhSriSgUNtNtavLKW8aT5TJpB1YVWEoEWl
   pvQyb65FH9DMRb6zn2x5/oQfyMe1C3oqR09mYhvxFnwefZrx3C8vnBlZn
   lC2DHYV0BRIH57Bu1LgGhQN0HpP/re5Gf/PGRhwvvca/pQv4WNm3S1SyA
   /OMJkG+/sA4WW9CFzgCgUN9Xft5vKTiYDcrj5qygfsVvSeWq4ZgdgOeIj
   wNc4tIpYgolBwcPegAhjefmlRDGKpuoYLNF7/6xGuwWuR4hIObUgf5U3z
   28UjTkbVJx+qnEROv8iGZOG0YwSQSX0oV/qiELZk68QrT9xgQyqxMi7Ai
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229597892"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:13 +0800
IronPort-SDR: po07/0G6E4Oos0LhI95pNAwDar4fjpOIKS0EQ6IhN4kzbGXcgNtbOmhWdIgYyOcksgj0Dv+vi0
 gKHRg3dryIy4RAc/AFhQOIhGLahJDOr4RY/o2nUZsnnLughdNIFZNI/vzUSE2YwW38z5CqUTWm
 QqukjUTX5iB1KteUXul6UV9QYzdDZUtdE3LXzy/SYf3EUo78k7erRHQGYVf6nEpew5gDYwj9tE
 z7gA1sO6VsH1Kwr6o5+PtWt1KkPjkiqsD6JrgwhdW7r6V2pfhZBMELdsIclnEqmQK1qB7kbAqm
 xBY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:30:59 -0700
IronPort-SDR: /S22iEpnOiCcoykSs4awuNv6zgGhYXfplgG+S3pD2v+040jaGI8/UT37PBAwwxcjkEonrgZmkF
 MJPvEWtr1zVH0AIddfQ67gYFP3HKB7q55d5Q1Kb8u6skPN7kRW+WuGOCfae67Jkkt8+4Oaw0js
 JkBz4bNt1kGrsBmJVm+4KD8wEnX4pNgSMaG3kJRUQiB8x1MM+ujOP6oeUZFhoRrtBiBmuCy7MO
 c0PlJP0a2U0EUVTKgLVaxjO9oJKo1AU/i7anC+hCZa7jKJqlBykub1Cxy0u0yhF0QACwsoDW1Q
 DfA=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:08 -0700
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
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v5 08/20] jfs: logmgr: use __bio_add_page to add single page to bio
Date:   Tue,  2 May 2023 12:19:22 +0200
Message-Id: <20230502101934.24901-9-johannes.thumshirn@wdc.com>
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

The JFS IO code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/jfs/jfs_logmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 695415cbfe98..15c645827dec 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1974,7 +1974,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bio = bio_alloc(log->bdev, 1, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
+	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
 	bio->bi_end_io = lbmIODone;
@@ -2115,7 +2115,7 @@ static void lbmStartIO(struct lbuf * bp)
 
 	bio = bio_alloc(log->bdev, 1, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
+	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
 	bio->bi_end_io = lbmIODone;
-- 
2.40.0

