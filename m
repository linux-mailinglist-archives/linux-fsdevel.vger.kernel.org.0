Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DDD717E7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjEaLjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjEaLjT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:39:19 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3F91B1;
        Wed, 31 May 2023 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533148; x=1717069148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eyPQiHOzD3W2DQRKwVAI2Cbe6Umke2Yu0VLdprV7VgA=;
  b=mxQ1utU17q33UNcqPrZEC6tZG0ReaTsN/oWJGsWVyAtyLFogdv2uUoee
   gUB4/oh5u7xwIoePmyav0ZHXI4zMjlnI0Qk2Blq/LmiN+fK+ZYoSVkyv8
   l2otdF8zEEFzjSB2oW6eYcn9SImm0SL6oAgm+H7MA4Wjm5YEjcTx5p1Jn
   uq3TxVrpV/SBra+W24YpYuQVY3XPICn8O+kxyOYpVik1R1GNPQkbrywti
   w129VWiHaEAvCsOsTUNYP4ziyETDkWJtghGof8T6d3nxedGuPV8/o5G1w
   YegsmbLXiT5a1LkNLIpSODhyUMRGu+9mHhzlbAaY0SfSuyxJ78B3JQSLo
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="232064340"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:39:07 +0800
IronPort-SDR: a44gF74rY84tLsSNpP4G1OQxIesBpYA1tjTX/aV09UnNrMSc9qdsC/FMu3ane7jBllA2zR0YM2
 VqhufapvfVQfJqTWlTs/j4dh6bgESXndQlwI4rrMq63tmnHI6+D53BuEAPzvy0GQEHaAykuFUm
 2N2Tw6hNPncvsrhk/oJctB7AXfchrkBfuPnzQbZ7bSXkO1Bxl1J/eqw5ukEdmtcAERE2GFAVN9
 c9MdfyTMW9dQccOykaMYLvqehRe8SHQkDqKdgvq40AZXgpqmgt6uOA4FMZQQfqJ3ssR9y/0Nla
 wBU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:48:20 -0700
IronPort-SDR: 8+Hdbq9JLo3j5INsLQlm6RtixEL95tqPyWSgg+3x81yQ5YpWjxlpDvvFf8C2gDpDL46OYeHMF7
 m502e3zSOaUbGvCXIe7yKR9yL0BHb3HBowtYM+/iT7iBMmtUUi7PSQ4hTrJAnGBjLnu1CVA5te
 bypZvx72taZMiH6TrSz8fb5NFkjFwSjOlPGNDGHmkMdbexVoR2mJv4XBGnJ7ALe50hf08OiFnB
 2J/tij7jzk4b7zRp70+No61r07ArBbAE7p376Qn5n8sBRZOrXcPJAPnX0eqzkQx6QywpRwQ1xb
 Wag=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:39:05 -0700
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 20/20] block: mark bio_add_folio as __must_check
Date:   Wed, 31 May 2023 04:38:02 -0700
Message-Id: <3d45098a7640897cbace54713efe10d88b74c160.1685461490.git.johannes.thumshirn@wdc.com>
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

Now that all callers of bio_add_folio() check the return value, mark it as
__must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4232a17e6b10..fef9f3085a02 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -466,7 +466,7 @@ void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
 void bio_chain(struct bio *, struct bio *);
 
 int __must_check bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
-bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
+bool __must_check bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
-- 
2.40.1

