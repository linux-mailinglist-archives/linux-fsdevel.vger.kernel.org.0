Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE736CF03E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjC2RHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjC2RGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:06:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5830114;
        Wed, 29 Mar 2023 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109592; x=1711645592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7ULCTtwVmRs76XZxrCBBgDjRvqinAOmkneoFyK+NvA=;
  b=duqTnaPtzkLL98plrZ66TzJ4SALNmFKX3I14A0s59SS47hUb7HxzLp26
   lwMNlJ8qLt1X9vM9LLoHB/BMT6G1Z284thEo8LwdAHVc9c/oqgZv7kVUw
   Jy9PCojGWKBceAZjJFwh0LIuG5hyATLnkO9GcaZpaQB6bn2Hn/TTf41xn
   KceTLeNjVDVCd/hHWw0DtZvDopdzNcg7/QerWJU7Kd2EMRVUpOq6ij4MR
   P39rrzME+W+4R6mr8A4Vio0vDGuytu9pxZLNf98V9itD305x4H5xR0e8T
   yvrqAzUFSlsnFLCWIgyqB2KXafSwsGTRGodkb56A3a3NJCJ1knrrme/VP
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092832"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:32 +0800
IronPort-SDR: vT8QtTFI2LMVKlQFw5IolkHn2sKVelV9d+BbfgPd4fX+k858dzFRfr6FWP8Pw7Ue+YbQfZFD5N
 icabWL64odKVAsX3XwCDGvaB3u0CGPLb2AqJqlSNimpRyi25oDIrcduWWe9u34AdG2uFwnzrry
 nriWUO3f0d4Gm7GCkQvJPUs4k2R6FhI6qaq2ayl6vKZpNs+rnO9QHC9U+d/YYGTXHTo1Fv6GbI
 DrZrB+s6eHv0BexbxxYF8Z8V/6+NBjRDAtRZu50ERvhwNweRM6DVcBjEw1FJMHSsXYylLRyK0C
 TLw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:22:41 -0700
IronPort-SDR: HxoeR2ZiwSifjLJAm4GM6J9SbigI8oViKXc7BCkcshpggE9TOaZcyDqhVSgcBLgj4CeCbAetZI
 +UtoI8hvcC0aeY4gXAT+WWBWHXSNAnTXctf9VPJWFomeAXHReYsBRLLfqTSsStRS6jxBLp1674
 vgvEKqUZp9f6u7w4Gk4HVPSF59cBQy2yyUeoHZgaezaaXfhXfpLpfF7TyUmHcjLZzHv3zOPW/B
 mD5ohyDY4XjUiEY10JRmTnJm3UatvjKaPFVIROi629lwjbNdQVKZlCgN+4RJr2LXT9esfOlGAy
 MBk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:31 -0700
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
Subject: [PATCH 04/19] fs: buffer: use __bio_add_page to add single page to bio
Date:   Wed, 29 Mar 2023 10:05:50 -0700
Message-Id: <56321f8ef1e70e9e541074593575b74d3e25ade2.1680108414.git.johannes.thumshirn@wdc.com>
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

The buffer_head submission code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9e1e2add541e..855dc41fe162 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2733,7 +2733,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 
-	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
+	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
 
 	bio->bi_end_io = end_bio_bh_io_sync;
-- 
2.39.2

