Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B8717F22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjEaLvm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbjEaLvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:51:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB669129;
        Wed, 31 May 2023 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533879; x=1717069879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cSkd5AssBzijA2arQQJ/jDabPq82unQrdrIRPZntKD8=;
  b=WM0knnXapAC5feO/S6h81xnNNM3waEoDY9O2nv1/nCSxQfm9wl3v1hsD
   qZAclJAlfC7mNzFzQ9fYn/4UqHWL+Lt/1SdO2mj7W24O+UXmtrbkDGMwc
   yOowkR8YpDRpn++Q0KSxZNr+qAg0fjmM5aQRiFRvmGY4+8jyp8gvIUsgQ
   VIJG0mijlPYEVGcCsaRHHlh6IYlprj/wIzcOg2+xaGG0+CNareX6VfsGY
   hBJy5n/pYY+lWPWKOv3zhTAI1a/LEfBsNpnM+qHcKF/S7ZtzvtaGHOUdJ
   jm0FP+UwgKGViQqAMWgTAAP+k2eIVASjgaOZGFZSI/fvGBQRVbmAkmlnY
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547938"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:19 +0800
IronPort-SDR: 26jZ5Utg8+eyK9q/FSBdEiGNLvXcGJaLZ5EJxDkdxui//2ZW3AYgHWZblk1+orFtRo42OUCb4Y
 k8tzWGuHIGc8T5ECOVDjKxQ0Ljj0QZ2pTC0gODPc8eyVEM3kiDg48VrHT7UyN2IKjBF9uhhyBf
 WoDsfmTLGNxGCoXuwkAXSeY8b2D/NXqIp/F7TCVE0l1MhyafWbTCJbQW5HVviz3G2RrYIIHEV7
 bv07e+GtQilvjcG548A/q8xjzKqRi+k2RaxMOTQQG5mDp19v60pknaf0LxLguLZ6cfEXgJqoCX
 Vm8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:12 -0700
IronPort-SDR: JnJbKILHB8Hx67SEZIIpe1y6Cfe/bqIgfbZm4SN6soCmKZu0UJsjeqJfDfsm9CfmXDkQbCKFO8
 YsXT66muLI4R3ZWh6EvCz+i6T7UJutXo9MG/o9yRxEJcrRvYstuAWlEz2tMVsgpBX0tLGYQh7B
 kQ8Kflt+H5RbvfNj5NAtdJNflZq2RxUBDL/5aMLyld+sYxFLoDJQXfDCGd4s6JHXPT2Avp5goJ
 MkE8t0T95Q1EaWVnN8BYTTgeHfpax769+8hNJ/WqPxGkEOmGHA6NOSa2mV2CJ2fxNtJg3AkHmF
 54c=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:17 -0700
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
Subject: [PATCH v7 09/20] gfs2: use __bio_add_page for adding single page to bio
Date:   Wed, 31 May 2023 04:50:32 -0700
Message-Id: <087c67d4e4973f949d3519c1e4822784ce583c5a.1685532726.git.johannes.thumshirn@wdc.com>
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

The GFS2 superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
2.40.1

