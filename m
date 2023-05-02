Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26E96F417B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjEBKYS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjEBKWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:22:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7375BAA;
        Tue,  2 May 2023 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022915; x=1714558915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6AfPyqd2+81HTNsYYrGTux663HCZhra0xBEupwD85bc=;
  b=qvvSnhLbdGD1jCjuYNuSVEj7N648aG5I8aTOFqfVkWUyF5KEqJfUQa1V
   FoFOR5prBeqISTKY+eMU2wo3IYFq7LADykb+jPkwB9hBue6T2LTFpT1WQ
   9UickO17kD6usT+05uCA/u6Gyc4dvWpXOP6OM/dU64hhjAP/qxgepodMR
   jo5cnX+2GX6YjpQ0O50szGpRjAqY+PH2w290lC+Ih+62UwLie+gNAxsyW
   4CpfOV0G+mBLgairypLhAGYnyAh9cJUFVAMFvSDujsKwrBEhpP5FEOEbP
   WxjLpu9GZX9gXlrUyuy6evZ1Hj0u8aeLgHm2PMnUR8ysYxhJWNM22zKkb
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229597977"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:54 +0800
IronPort-SDR: U+zds4bRbGT/MZ1CRlVp5uQl4oqb5AT3O7/g2KBKXWN1xXoUvbSCa3etTt3OuZ10l7bgqCB6UE
 uwobE3HH0AvEkVf+t7QtiP0j+6sC9X1U5cI+QGebGDkbikSNnQWxvK/2lWgRLoOZalGo0E76VU
 D4WdrMvwzEFrsX3TagUXgNA8VlgY9ZhZvHAv55hAp6KYLuAokz0ARRV67JUZxyS/G4HyeGYNMA
 2GQ0G5UTjCIPJeVaEg2vYtCHbYGkY3qCMQm7kOjVVgwKQOcagrYi77N5xHyT3t7FItSieYQceb
 Gao=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:41 -0700
IronPort-SDR: xRv9qUm/jkFHj47mGNA/6praQO5Yqj7qnIh22218g9Ii/1T0IZaxn5IqFfB1tzk0UZbvAYefj0
 /ajkmqJdSFIwqCAr1990sRV9STv6FmnvwMuCFh00tUkv1kcz55Tru+sZ+t3DxI2ItwUvm8O/TT
 gAhMfAT/LF6mCdTT/kjCHonXe81T0BejQwdHvS2IGUexu6EtwJUc2lkNjjtG2t8eY8jjwTl9Fp
 NYdkUfUEbsQHza/zSMGe0al18yoLgAUHBBNoGU5+ItYpshssTx8F6JYNPfvX9YwFGkWwD9ZVsN
 NOY=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:50 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     "axboe @ kernel . dk" <axboe@kernel.dk>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        damien.lemoal@wdc.com, dm-devel@redhat.com, hare@suse.de,
        hch@lst.de, jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-raid@vger.kernel.org,
        ming.lei@redhat.com, rpeterso@redhat.com, shaggy@kernel.org,
        snitzer@kernel.org, song@kernel.org, willy@infradead.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v5 17/20] block: mark bio_add_page as __must_check
Date:   Tue,  2 May 2023 12:19:31 +0200
Message-Id: <20230502101934.24901-18-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
2.40.0

