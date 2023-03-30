Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842776D01F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjC3Kqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjC3Kpw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:52 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625F67682;
        Thu, 30 Mar 2023 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173116; x=1711709116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RHMrIgXLZtjmRd+5c9MBnc3q/BEGhtEER4XpeifNGfw=;
  b=ThHCu9v9GepSTURv/6BPujDIrCStI1CZcjpCYREkGgpfJT6C57a9dWZw
   hQewALsDJTOw8YdEowhVsEKKHUVN5TIt42lbirNzyCgToY3CQ6LauszLU
   XPUPSPq97+K87nsI/e6Os7AWcufCRkMv52vHOhdD5IUxhJYCfBButHxkk
   PGX/c0p8cymGjWVKwRSTWklRCNJzFAzmvI5P0VGHiopOTHILJFlKGJcJU
   6I8SqOlfL9RLzc530mEZZUtIb+OuJ/j5khuLonScbBy7a66thBKOwwCdg
   brAN5+tjMn/eiJBFciFkMiyXw+j0SYLuGSLWK700hFEVVXYjMr/lZqhnQ
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317870"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:44 +0800
IronPort-SDR: EMs+hjXjayv+kc2CNC5zlzMJpMnl8Dncg7ntZS9J/68lAD3ocXKcoLS5LNopfHu0OjwL2bFYLm
 aNIHxOt7X2eheO8yN7CmnAqc3YIrn9YuR+Nfg4E2gybw/gZWV/lM0AIyXSisQSweTdM2DCPsnu
 ATL13Ivo5VKTiEpebripwOkAn6C/aWajr+fEO98Aes4yyQQ+PxtyBnvWqjbYCIp05ZgzgZglmx
 1ulO8ByTx1dy1W/mICxWJitTYFBhBvddV/o3erCYshro54A0b4toHWZR76Ek602uccGUXLkDC0
 qSY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:52 -0700
IronPort-SDR: skMtz4+keJr/cRyrN9pwkgS0ewLiSNPb2M9dHYXrhuJ4g5fW5pyblL2I46HGHIXXc8RzTaSiVQ
 vh/QodlyDksqLq7Dbn7EODH7rPaYpLyeTet6XndzDCHJq/UDe4ACMF5fuQcuF8b6PngN7P5WFm
 6bbx8cI+1QGvEI3G+Itr17jIH6UA32wollKGVJ8Lv5OT101pzER2Ix5fj4DLVdWgljSJSJ+fAE
 pfT9r3OX9yQGbEd5JejAszDBVE5RDoC09pcH9t7rXTz2l8qBWAe6vvY/LavdGZzoCYiQnqJYAA
 1/k=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:42 -0700
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
Subject: [PATCH v2 13/19] zram: use __bio_add_page for adding single page to bio
Date:   Thu, 30 Mar 2023 03:43:55 -0700
Message-Id: <da8fd892c938a58a3b201706590bb67e82b56929.1680172791.git.johannes.thumshirn@wdc.com>
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

The zram writeback code uses bio_add_page() to add a page to a newly
created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aa490da3cef2..9179bd0f248c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -760,7 +760,7 @@ static ssize_t writeback_store(struct device *dev,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
 
-		bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
+		__bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
 				bvec.bv_offset);
 		/*
 		 * XXX: A single page IO would be inefficient for write
-- 
2.39.2

