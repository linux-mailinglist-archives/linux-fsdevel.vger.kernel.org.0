Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28976F4109
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjEBKUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjEBKUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:20:46 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07511527A;
        Tue,  2 May 2023 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022844; x=1714558844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DAUXXvncb57Ca5Ysqy4K5WgFviHvSEfqduS77WKLrRc=;
  b=NREj3DWnDd02UlKBTzX4AubcPoF9rJB1lcGYF6H+/1B1YqxLA0QD6GMt
   LJxWKfQJcQLPV31yG/tKJ/Xg1PqbAIaJQ3orSZSW6w1XyWfMI9VCs+x7G
   Ay7qnWEsQIq2+4uZIZ2pI9n5+hcocNbnELDzzEhRt0fJUG4voSVIGzszV
   +lhZLkWI/c3Kaiqgemq1YFHgTL2AiQMqLOPiFHG2UOUlyPEoiyyCWIcXO
   c9ez4coReE9AIOXFkIVP8kVUAvl1gSlaDjzIpQVPJZ1+FdgFJsbpTt7/X
   CCbJ2JuL2GMglZeb+u3XuR3vXzUnH4aIyvU7Wrqiry2JTPMZv6Xj825ST
   g==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="234672821"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:20:44 +0800
IronPort-SDR: 8N2Y5AWfSLhPoKIHpjDwfWU/qxaggPPJw++iiR9kYS4vf8nz6zeGBEuBw3KnVvLyyb2JSrFWLX
 WjF0ZoGrkU01NwmETEwHAcEgbKzXfUR/cn5cRxve/H40vWUSqf9HPDXJHYqeowfxFwBwiiFRjn
 tX0MWWitunIxpxA1mIQ4OyW9tv3glmwyQ/yWBhhuccLUPeC5xhoizIgh/DLj9h27OyMKoZjkad
 NUPdSkAGDeRfIeCmCVcbDSSxYDUNrHaw9cUHORp9LhWyPhktoytQdp3LZeVpmH5uno/FRr43dm
 uxs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:30:32 -0700
IronPort-SDR: 9dAoasd2kUMB9NDuUlrxf2LKGQXNbe7IcqE125G1znIBmvFKRi1+XoITUsIN9ND9OAtiPxTMbd
 hksUv+zcUrnVuAoUVGO2049xfknTS8aM5hmEWzvj8WhmmTEXP0n/lftv6HNELCgJiPz5gQczyl
 jSeLS39egvZ6QJ+taxzDgX4dDqXFI5XQUhVg1LiOWyxVbmVWvI6hTsCCj0zcHEW+RxhAj2/6P4
 4ouCUXL168ncCOMo7EVwzrHUnj7EWo9bkFcQfzMoq8SDN7OCFeSa+F3X1vyKgUhvKXTrNUP+wD
 2eM=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:20:41 -0700
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
Subject: [PATCH v5 02/20] drbd: use __bio_add_page to add page to bio
Date:   Tue,  2 May 2023 12:19:16 +0200
Message-Id: <20230502101934.24901-3-johannes.thumshirn@wdc.com>
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

The drbd code only adds a single page to a newly created bio. So use
__bio_add_page() to add the page which is guaranteed to succeed in this
case.

This brings us closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/drbd/drbd_bitmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 6ac8c54b44c7..85ca000a0564 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1043,9 +1043,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 	bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op, GFP_NOIO,
 			&drbd_md_io_bio_set);
 	bio->bi_iter.bi_sector = on_disk_sector;
-	/* bio_add_page of a single page to an empty bio will always succeed,
-	 * according to api.  Do we want to assert that? */
-	bio_add_page(bio, page, len, 0);
+	__bio_add_page(bio, page, len, 0);
 	bio->bi_private = ctx;
 	bio->bi_end_io = drbd_bm_endio;
 
-- 
2.40.0

