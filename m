Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07A6CF053
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjC2RHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjC2RHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8773E4C30;
        Wed, 29 Mar 2023 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109601; x=1711645601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q/MP05JbL9vu4bkJls/w75JhMUACKtyWcGW84ceCR9w=;
  b=VXfIha9g01T508W8Yz0QixXmDqP/5MjDLtF0U1yi+QKYtftkpf2E/SPC
   /mUD8jjWLkSC63MPSUoHzITQDVStylx870mtx7dKowxZbOQH5ycWUSyNi
   O+NIP8VXhuftUShr/P1PknMi07Da46qQoMx8jIieKwzkYi0WAQEigNjBT
   uHRDD6UF3ABzqax4p99yrk8qojh7pkojZ7JiADEooKIOm4tpegmbZ1sFn
   PqWDznOeYHCntQJxilvRWUaX10FebmTh2USv8t/wY4xaVuBIahZZE6sD6
   9MewX0edjrcYTGWuyWwDEg95a7M4Ljhg9CIcm59Ik+ck4GT/h9B7+Dq2M
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092858"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:40 +0800
IronPort-SDR: CHKqw08wY7SsdDSRa40e1qQViSUnffljgNN08MylE1vIl7nBuApcgt4kWkShIw1hbjNWucSzrl
 ySLEFtDVOQPF1b1T7Phs99Ycuc+IytCFtiwOTLqBuQPLckLtki3268M3e4unEde5tW99tk9Kma
 6eYG37uiLjgofakU/UbDacCIuHxQAgu167LT67t44UgEbRqdo/Oka+Sw+YxG6xLxUeK8pI5ch6
 u5GFXgC6D420NIFbjDKRwwgpB/Z6SGLnKBD1eH17jmrUfrrNPkaiXUtUartff6zStaYFbyYMTU
 NoA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:22:50 -0700
IronPort-SDR: 0NfE3MwgkRGnbsEfrD3apWVDkRRWW7BpA7q/3BVNoCtKDaOSbe5GU28nZB2Z0Nd+ot/O74I4+M
 JfSMorqce3BJ99gveZBSA3tXb3rtCze2wGqglc96V0F4bjY5VAmksMNFrMU4tQ8Fio4zpCh3pF
 xACTb67zGAy8FiCgshGR/AfPrmuBbIYsQe+Z+dl2z3ZWIDuzh9xoVO70zJS6Sz3VA9bGxsm9+b
 US/RqUK/CXiZRj0Wy3gVSwcyo5L73qLzC9KscH/xn/Y+hWXc2XyYuRcML08nlwTplE7o58ytpj
 uSI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:40 -0700
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
Subject: [PATCH 07/19] md: raid5: use __bio_add_page to add single page to new bio
Date:   Wed, 29 Mar 2023 10:05:53 -0700
Message-Id: <7ba6247aa9f7a7d6f73361386cc7df5395436c33.1680108414.git.johannes.thumshirn@wdc.com>
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

The raid5-ppl submission code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked. For adding consecutive pages, the return is actually checked and
a new bio is allocated if adding the page fails.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

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
2.39.2

