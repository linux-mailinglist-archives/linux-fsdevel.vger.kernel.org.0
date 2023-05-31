Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C92C717E74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbjEaLjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjEaLjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:39:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B2219F;
        Wed, 31 May 2023 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533145; x=1717069145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8KwDx4F6OBY0YkNe6TbB7WM/40haMFuwXNEas5IG6CQ=;
  b=e+JCeqhcRDaoq63EtrJAG278g7rTsnI9Al91ArgAORvWNZOM6nHpowE7
   6tEG52n3d5TgRAWWtE7e2pZ/nbhYwzVWdiI3O44hGhSHLmSqm8AHh0Pp+
   /BsdGIDG8EH9EDg1rz4IhYoUQZ1GpyT4XLH3OXtBNlKn4/VWSTD6l7l3L
   oIcLbHvY2EcSpYa5d1faB1Mlw+4ZeYpWEWZk7gHXiiauczOqo/oxkTIcb
   6X8L8LxXtbvcKTe2USpQhxTS+O0voiAVE5HvUpHgnrg6A1tuqtcN4aHuq
   ey//cpctTeYCPy3CRZ1siD6ifJ8R6nNo/PblCeJqLDWMseAoCs6xtFJnS
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="232064330"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:39:03 +0800
IronPort-SDR: Z+r26HyNhlXR0DRV7pVTfDSW4OTm/uTL7Al0PowhNPY3EdfKyNV3C0hNvVuRCn1dPZdKrwyvlk
 7sovlp/vO468fEvh8trM3WJYXCafNG1p8zjoeOwwnM5F7TjVr7o72mBFrM/6IDnQm6/ati+kXY
 sQBkZzA8FncAXdcnl13hOfHUsdxjGLgaoS1uDC2DBsP5jguFZibHTZAKqSwm4a6qt4Lkx9cAEK
 MrUjS9MU5AxYhq3mvKCsdTuamwiVJCzLCAztzDPM1wQhGl5yBjsmif/trCi9AJ52NXC5OHet73
 rVE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:48:15 -0700
IronPort-SDR: kXD2zE1oDj1STXgFj12eWJqC+g53lVF/sDVYCzKNzqsX3B8MHuNYHjvbNqBg/IWngVga43fuJW
 UB2prKHfRH14hXjERXQk9GHFguINGWkaKV8x7I2wEqlscgdwRiIRceKStpgVUCt5SslqwZJyQl
 7tsCQvOTuzz70FFBFLcEUHEj3i+Q/yBI2ynrXP8D76ej5ylc2y0xECp8Ke3FRSAHvC6VZIqjIw
 vtubOzX2q0tueOmnGOoVTrnkvAtlKCCU616fgM7DlDVdkzps1br+Nj94Plbioxi1DpRrUD6RuH
 OS8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:56 -0700
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
Subject: [PATCH v6 17/20] block: mark bio_add_page as __must_check
Date:   Wed, 31 May 2023 04:37:59 -0700
Message-Id: <7b1df30b0db4cd34a3c9d66c9c126dccaf2eb52f.1685461490.git.johannes.thumshirn@wdc.com>
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

Now that all users of bio_add_page check for the return value, mark
bio_add_page as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index b3e7529ff55e..5d5b081ee062 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -465,7 +465,7 @@ extern void bio_uninit(struct bio *);
 void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
 void bio_chain(struct bio *, struct bio *);
 
-int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
+int __must_check bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
 bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
-- 
2.40.1

