Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88A06D01CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjC3Kpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjC3KpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:14 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0273293FF;
        Thu, 30 Mar 2023 03:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173081; x=1711709081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mX1ugZUMlV3kS9C+vBwAioR51KxgcrVIz/0Juw9keV4=;
  b=kxgucMZFHZngJRIphtUiMZHCCF99RhALhzTv93C0IKrIboKTXjvYmyzg
   kmTmIkb+gn9BmAA9lSQ4UuOF0KHkg11nlaQ/mOTvkj03ff8/Nu9eucnZO
   shoI1kvMNBATcLVY78sb2ceQJOyeu4LWgaZZ1bXkwvdcS7IZjFotJpD4D
   dTi4ELF1VleY+HH2uttoHQAWYSOFA8dKAefrN2esk42NEpBNIlSzU7s9/
   5iWKI9wsrRCDpGdozXRqL3XTvfsU3Ik65p5ljXxjlgRWFnRWiuzRzakwC
   960ZgmOQzu9qzzOUKNbpznEsa5yvqCYHWnobUU1PdAimu4/ktFbDaiBI6
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317825"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:17 +0800
IronPort-SDR: zLBRuzayB0LmTQpVzrEaG2RJ1SO9vNVasUGitEF3Sk6JYH+SJZzcIEvoINwodC5shg+T5666ww
 WI3bCBALY8Pe1O5w4dhVJfssxYdbNljoUccd9ZtWLaVm2J8T1uGVFzbwoSU6AML0CagxnD7zmW
 aUN4qHR46mB5Ul7SjkV0SVCvhfJInCbk2YTq/gkXpf4aPmDgz8FWq3rjyLLgtumkYepvNPfBI1
 r+bnr+xLNzJendN1/BoinWuRVYWzwPh0IJTQqOzSWdgKu1tC3efAwnOAer3inB/M1bY9Ng8AvD
 yqU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:26 -0700
IronPort-SDR: tGiYEQMjhW4+FrecuKxL+pgIOJGkToeN8EqS2UrmeIc+jDKs2LGUqC5wI3lkpfIG0rY9KtD7vW
 nIXhgAj3MxSOzjMcp86VQe4PR65gCJ8t/Hr1B/e2y6ez9iviPUznUuSsFvmn3O88X1mcUdVcMt
 QW0hYZrihvAJT5JS7wACEa1P+gmczN4rkDt/LCKCq32xB6tvek7oUUECHgErjCvhLuoZBvN/xK
 9puzg1a+1RXgqpR24l5LZUwbmEKk1F58oXHxor04IMFieHnETCM2z+v6HEWQ9+B8eqMai+lo6B
 aDQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:15 -0700
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
Subject: [PATCH v2 04/19] fs: buffer: use __bio_add_page to add single page to bio
Date:   Thu, 30 Mar 2023 03:43:46 -0700
Message-Id: <1848c9a0ec37fddf7bda3f97c6363a7de97eae19.1680172791.git.johannes.thumshirn@wdc.com>
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

The buffer_head submission code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

