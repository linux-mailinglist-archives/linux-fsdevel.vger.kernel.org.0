Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF042717F05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjEaLvd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjEaLvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:51:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EA0189;
        Wed, 31 May 2023 04:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533873; x=1717069873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k4a5Zi2GAZJPJB4x28jGupVJUdefs0tR8+WNO4iLVd8=;
  b=qCi0eX17tc6kWaGcI/LX0JIxEhlFN0Nhx7vtULEtgbgo/hNvcM6D7dBw
   u6wuzbcFzrQSp0iFGUtPPD5K1GdZltWlrTCmkdD3doNQttwDJYgH0gYgd
   GjdDylEktkASHepks/88iJ4pOP0/5KIbz8n9D88TGwftUvXoPqfRW0Ixe
   MlkXRXMjDSizPO13yPLfpLj/7DDnklAES3nMPP5xmRgtCiZ2OVm/Pmcze
   Z5KQsT232UA/b7kYWO+wsIFgyd1XgQTsaI6SjnS64IorqD7HHk0vxna3S
   PlDd8KJ5LxB92UISJlpx+Auc0a3J41gdygcB6ps9wY2E97MRUZdXMA+G2
   g==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547926"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:13 +0800
IronPort-SDR: EBU2VvYBoKfMjXac1B+gEcOldwOi5SnXRmTVXmw+1xM1oNm19laY1wL1XnIz30jXpgp18hxM8i
 0crbtLHP+M3H89LAnjaOO4qNqsQxc7cq8roS5Epb4QZJ5L/D5v/67+YU1G+0SatyaGZIJL+5Dk
 rccsOtTm5HSS8Q7u9wATiOaQT/52v2ruDUJtTvjQDQQ0Xryq++jLrKrEHU+N4f467An4xINpnk
 ecflzWZgkCKIt7K6vFiO3K83LpyTgWGlXDvLTcHGSw1cj0GybC6KBFx9nXVSWchJD+qo0pxPar
 nnY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:06 -0700
IronPort-SDR: xjFPRUk9Ifjou1cDm0luSpwn78hU9nM+Uh6/lNHb7tmpL9BnDcAHIBz7pRZNu+Y/7vgJ/Ez6sY
 RyJ/ivLjBW17l+dotn8hVR30logKnTYtxKcJUpZjXM3pkCCTww+Wwx1Q95GuK0KwbO7NqPBTzp
 ajKcCB7MvUhxXFY/oUZ+zxu7dJ2H1FZ7EusH398EBt4EExQgIH13eoEhJohKwTP8QoP4CwoW9U
 kzYp0zCcFcq66GRNaEJVSD6lmZnBsL7SZcjVd4x99hRY1Fiv7ecOyIyY8X6ND26gRBWXJrsssH
 laE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:11 -0700
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
Subject: [PATCH v7 07/20] md: raid5: use __bio_add_page to add single page to new bio
Date:   Wed, 31 May 2023 04:50:30 -0700
Message-Id: <27e6bcd762354bff74602e89159cdd12ae3d1fa9.1685532726.git.johannes.thumshirn@wdc.com>
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

The raid5-ppl submission code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked. For adding consecutive pages, the return is actually checked and
a new bio is allocated if adding the page fails.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid5-ppl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index e495939bb3e0..eaea57aee602 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -465,7 +465,7 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 
 	bio->bi_end_io = ppl_log_endio;
 	bio->bi_iter.bi_sector = log->next_io_sector;
-	bio_add_page(bio, io->header_page, PAGE_SIZE, 0);
+	__bio_add_page(bio, io->header_page, PAGE_SIZE, 0);
 
 	pr_debug("%s: log->current_io_sector: %llu\n", __func__,
 	    (unsigned long long)log->next_io_sector);
@@ -496,7 +496,7 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 					       prev->bi_opf, GFP_NOIO,
 					       &ppl_conf->bs);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
-			bio_add_page(bio, sh->ppl_page, PAGE_SIZE, 0);
+			__bio_add_page(bio, sh->ppl_page, PAGE_SIZE, 0);
 
 			bio_chain(bio, prev);
 			ppl_submit_iounit_bio(io, prev);
-- 
2.40.1

