Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06D17167A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjE3PuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjE3Ptt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:49:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1515BF3;
        Tue, 30 May 2023 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461787; x=1716997787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mEDf+2bPYBdApkRtQGcrKQLhlyK4U4yv8ooj5C9H9Fo=;
  b=TCvFg37auzUfYJYqUR08KFP+CPl2XsN+KVNi1whiCZF0xiQLL4fyk0yz
   YuRiRjgZtDw6hpU6FDiO8X1y7f/1ZtaDkqSy1Iid9cndFlP9jtlKYatDN
   pr5YWLL1PN5+Sl9FlC5fgINNoiHGvDKR2Dpr9tFog6tlaLCHocMvHkfG5
   bj+7m6ZpSSr14fGhLgfJUdZx1+zC7YP4a57ApnkMAqAvpztI/NhJD/c25
   d4n8F9HUYYFF74jFNzX4UwneaEtb3vNoq+EpS9+RJkBqxSAKQT+cpjdqh
   ijpTFewuXt/tBiTFfzsIFOk3ZV72tg7LZrzpI7MAxTe54ClGgqhuv5Kzj
   A==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129763"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:49:47 +0800
IronPort-SDR: CyKAjtx9prE0otV5oEGwfTZ2/YWYr3f3YoVSwcQB51kwuContYTjJK1r1I74YgI/In+9G7rmem
 kDyscRgh86tLL6hQmZSNUl/OIe3A60CD5pfBBhwrLjxjfUjcJM6ja/IECavpXbC/TAjSaOrqSA
 SYf1bvWztkZe/O0zcwmQ0sPvTwB7e1SFNVJNF44WFslpZGv38bW24LoBL2Z/IWm42YVXDkCL3L
 waqMcmzswxrvaXcZ29y10izVMPZ58GjqNa2VhOEfTGPdVIOoLUJbI7kJaMKSolGRW9hxiZd9gz
 Thw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:04:41 -0700
IronPort-SDR: MKlOX/uF8wNEct5950xnnV315MLl9jdeWlyzj552Na9mJDZsmp05yot7aD76Oi4Xbupl3BrWor
 CH08la1ldQbZ9LbsD2PbKhD1eEz/Wv7IO4J88KwTSohJz4Tcq8kYJ5TJv5OIor4ThvImZ+P9EU
 dnuo5e3IdJkZtM6PymLdROP06o8OObtizuI8cob1Ebk7RJhUIOuDEY5ObLtCjGKqVpe5/yRxRA
 o0I5mrkdFpgizKWYnBAUJNxt+kr6dHKCyqjCW1az0geORLLKn3tAB7Qv9196t3xurORVn7mWMo
 rkk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:49:45 -0700
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
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v6 06/20] md: raid5-log: use __bio_add_page to add single page
Date:   Tue, 30 May 2023 08:49:09 -0700
Message-Id: <1ee0465c7b2634a4435e65a4d0b06019a73d8389.1685461490.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685461490.git.johannes.thumshirn@wdc.com>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
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

The raid5 log metadata submission code uses bio_add_page() to add a page
to a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid5-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 46182b955aef..852b265c5db4 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -792,7 +792,7 @@ static struct r5l_io_unit *r5l_new_meta(struct r5l_log *log)
 	io->current_bio = r5l_bio_alloc(log);
 	io->current_bio->bi_end_io = r5l_log_endio;
 	io->current_bio->bi_private = io;
-	bio_add_page(io->current_bio, io->meta_page, PAGE_SIZE, 0);
+	__bio_add_page(io->current_bio, io->meta_page, PAGE_SIZE, 0);
 
 	r5_reserve_log_entry(log, io);
 
-- 
2.40.1

