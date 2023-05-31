Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7495717EEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjEaLvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbjEaLvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:51:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0951183;
        Wed, 31 May 2023 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533870; x=1717069870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhIiE2PZNX0ldPMtUgXTcFhOjFzcO4m6Vc6He+n9TMM=;
  b=TBBrPYzJ7ZU2d1Nq5BQoqyu7sdANp60AD6IY+UEwPeYyhtm1rBoqukhX
   8NWTK+89yMK+pxwAegFMHoGCL5OEinGhElVEu3r5pV2mvutnoCsa4Hisv
   5CNF06uqvcyInd97/uPvOEY9BNyiOVaTnyf1Qekjoj2pAkKWF++Z0sO4+
   Wj3DYSQstdbhZa3eVqGaOXDDwYLzcmTZ/6AekFG5NlAF3ofdnVnsjaztd
   xbeiWzfBuoL1+wHSiQ6MO4IqfneudxIJE76dJjj5flyajdXzM5vOwDwb8
   5QELaXqjoJT2VRX//8iPS0IeinWe7rlYUI9sYSTdi4qQlfLRcEfWGIhY0
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547921"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:10 +0800
IronPort-SDR: 2PxdtXov8oYfZVM9o12Jf6wJgWNWE309SN0n4KcVmjmuxtturomPGQQHSQ1IGRHv3goSM5iKFa
 ZX4rKDsA+9WtVB9Hy6tf+AD3m1GOrmkPt/PG5uAl71sZhFMDq5g2jptfYwKxE3/vFaU997Fa3D
 q129oNy6nwS1zpH/eUui/d8kZQF8aBw7fxQEP9y5Nsuns87Mn2pG2e+Nqn2uB97spt9Y5q3J17
 Qu0sQf9QFjoaUMikfTyeq6/+DjLrFNwXYVGC+DnFmiW41Ktj+yKxnYjuw7OSc54Kz6aC0/ngYs
 sJo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:03 -0700
IronPort-SDR: f4sky3ehrJxiT/WAHaDyDgGjgkEGaBVQ9Ynqzb+9FpjL0wrWalF1YoF39q6U55+/vA10v+md4S
 xA+EZ1AAvJbX4CPvXm2q38H3efX7qrlaeAvxzz0OHLkK/u2zsBNbVKWqTmZi71JeCHDpbVB39S
 aUtkeULE6SgapnBoQdZNAscRSiR6/B2TGee/piMikW+A9bCZVdTSYmVNk+gXPXJSo+BoUGRM1S
 G6csNNGPboiDcVMzRkpPA8s+7n4Mf/m2BO4bnujYmZkdKcmmY1nC5gkfsQ85PydSyrrQfCFnhg
 xVI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:08 -0700
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
Subject: [PATCH v7 06/20] md: raid5-log: use __bio_add_page to add single page
Date:   Wed, 31 May 2023 04:50:29 -0700
Message-Id: <832a810d6c9e71f88b0a39cb076a8c70e8bcb821.1685532726.git.johannes.thumshirn@wdc.com>
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

The raid5 log metadata submission code uses bio_add_page() to add a page
to a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

