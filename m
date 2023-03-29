Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B5C6CF073
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjC2RIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjC2RHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:21 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5344B8;
        Wed, 29 Mar 2023 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109626; x=1711645626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OE8E56I6ppzvZpWL9ourgo+ma9SYticUs78Dn5RisJY=;
  b=PxX+FH6nzkHebAZdTV6YN02coE9mtYfeazPLQvat3wYcqi747+t3jOan
   nhlP/xkjYvoN6OEjN5ubbuEhsXWb7y0Q06FhIr5TTlfV66v6q/3Spe6eN
   VrypMGGlxQVwt52j3w3zghFl3tDLdYRqQekh9xajuMOMH62rcJCXqlHLb
   gqVLo8+4X4W/eL2LzbdlscB87Aww1WMIpcnYiZtzM9qlyPSipdU6ohieh
   atWRB2zZkusZEe3DlI20gWZzGr2X7gGBEgw5WeILUTSEoA8wq9pDuyaNj
   oNoBAz1yzjJJSP25ZYzOygHNa+UpohnpWs8h63mpepCCA6Aau82vBjxCW
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092888"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:57 +0800
IronPort-SDR: k3j2V7dBSP/dRV/T8p6vcX3X3QJ0yPAnqsqO6QbmQusDyH2hAZlPdcXAHdkaImrqLgSpbDVc9V
 KXuyQ7jUnPuWHO51NROOJUpAduTv5HPnbJW7gEVwHv09Q+ymoQ1Uz4MkUd5LXLZ6D8qVOBBZSc
 Gi6R0ZKt0ogvIM5zGvwY2u6qcf4rowEHicMROhfAmDXv02bbJtVliMMJ8GkiAhUpRGO8PmKKw7
 2X/90ZEjDghtTEXZBoorh3GhNpkjLDLserZDHXMArOtK9deyjzm7NQjecQL4SFkdefTrdu1GvQ
 R+U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:23:07 -0700
IronPort-SDR: ciCGYrvEid1OWmTvYsKE9LmMoYXjBdNIDVHp7EEL3ugMQVAD8oiGyKQfXP4pYoV2q7+QBMlQDo
 1RsU5Av/PLFMD/vk6LCXNuUcQdAkJoBUKZWl3B3KaNdEDeDAYfT/Xuet1ErBvWVzn4ReZCi6WZ
 2tTbl4q+GT70HS8/O6AHUfSoleBf84i/l1JKzfYad7cBsXNtl7QFlQAHRj2CC4pi7SD6n4Katp
 jEWbuwgpWbRYo0gFrtFVkgDJiiBju+mZl9IO/VVqg+QMlS6vkxNs8qZeLGPjVwt4OicZWkznI4
 o+w=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:57 -0700
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 13/19] zram: use __bio_add_page for adding single page to bio
Date:   Wed, 29 Mar 2023 10:05:59 -0700
Message-Id: <339841b3b7ce6b2faf56bcaf9d92e298d878ef64.1680108414.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680108414.git.johannes.thumshirn@wdc.com>
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
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

