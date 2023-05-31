Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15BB717F02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjEaLvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjEaLvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:51:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D6B135;
        Wed, 31 May 2023 04:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533866; x=1717069866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9z6+zwuzCmTIb11KkYmr2yz2BxhQ+erlThVzksd2pAs=;
  b=fzi2jXDR94otJDUaPZWpl7TNvp0G8Y//w0ZjkEbS2EwfPKIgawXDfPRD
   6YFYIqhucfK+bwaM1F9LiItpI4KQ9325/53E2BHot8jQsR/71pUNC1dYy
   NQy+RN4qwDjp6HUAyNeZRBys21UrkcdUQeg9e54zR/fY5xkcADJ89yn51
   tTk03KdzIwEc4+NN59uxAQOwycYl8aaYGwcoF+syDXXEs4sWo3dqLY5XZ
   W3bxRnpF9lSPWjKYdFTzOWMI8CVfKmJK3tGi/bhXarZjaquWWjuoL7s6r
   UBXKBM87+fE0pvQbHB9yng+ykbNx2M/JOolMQBtmVvB1GUkaGQnQ6t+wm
   g==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547918"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:06 +0800
IronPort-SDR: rIqvbJTT5MHyH2NAJDBYfjOXaHJR3XE3Jv1KcCtNaNAVtdd/e1fKcAfOC/4ATWtMsEHJqyJqRk
 5rlTNhyVBoDqS4wNHaYoi3dP8KRVr60MdKB1kUxrCmnKNgLR4KHknByPdtmdVhQrX0Rgzrn/vv
 TY+qKBkVgj/3EiRvc46hE0v8BM+/bOH+/Sz0hIIsqp+mKLrCScLSkrR8kzfV7uQRarNrdGC84j
 D9lIUyCA+yL3M8GnoB75wAFLcTavYhpBnv+wSzNGUnp/JO3zy4A3W8VA1brif4I2j4WT600Dks
 GtQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:05:58 -0700
IronPort-SDR: DCUoJnFdqTpXehtn1JwgjSv3UPX1uRxp333BvBFifFTfBv7OlO2CSbLrKRyVZ1ZVcgiosXtY0T
 tVsCFtk92PhOFdpXCSWvnqSTCBvF5UVLxocOGAcoZEQFEIu1gOajsi/mvqMWu8cMF5J6hkw4hM
 5eCUuV+nUJWEQNxIZoJ/kpCJ15t9r2ZraltnxO2/iRT8ytXvXYLujM0u5SnxD1uxOurCUrxHMR
 wO24NKfN/B2SA63R841MABC0LQn3WFoG2ot/EyIEOWiHlgSgUeAes2WB25guvYTGVgT3jm/xuQ
 aSE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:02 -0700
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
        Gou Hao <gouhao@uniontech.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v7 04/20] fs: buffer: use __bio_add_page to add single page to bio
Date:   Wed, 31 May 2023 04:50:27 -0700
Message-Id: <84ff2dcbe81b258a73ad900adb5266e208b61a4d.1685532726.git.johannes.thumshirn@wdc.com>
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

The buffer_head submission code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a7fc561758b1..63da30ce946a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2760,8 +2760,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 
-	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
-	BUG_ON(bio->bi_iter.bi_size != bh->b_size);
+	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 
 	bio->bi_end_io = end_bio_bh_io_sync;
 	bio->bi_private = bh;
-- 
2.40.1

