Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B536D01C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjC3Kp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjC3Ko4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:44:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151CB9774;
        Thu, 30 Mar 2023 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173068; x=1711709068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3cfRA2wikfkIsf3C8GxTLr6ByhKgTx7ps7OwYMzkj4=;
  b=POEKyhA5Vk6lmOfMkoU+DV9SU4PDKYlj4WaIbCESewaBxJVZAFyWuHtq
   SoBryOr8hqkjXCwO+0g6bCRfpYyR9xNijs/TnxNRyjxzDwjZSvgffvBzL
   SptEixs3EBW1m1H+vJmQsH5ukIJR9o9ogPhS4m23d1W193r2Lvpig36eo
   a57xmD3QvqTsQ36tCRtynV3GSXDWgWJQplcABfb4MzxJapAyZ1gV0NEpQ
   7tFRgbnw0Fed/svKh0a+ilDsy0CI3gR3Qj7HxnoZmY8ayoAn/nX4GFVUZ
   Aj82EO3TOXtc4u/jZkbmiNOt99PasZqFlK8s5xPLZ8svTmYfOZLThTynd
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317818"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:12 +0800
IronPort-SDR: /jLUXoPmBUMaBeihSuIwE/EGwONQSD6pRBO17B5ukOMtrKUiI+G6Ooi4UwdOPIU5aiRiVekypH
 sBcbXMblBRx+d9qqN9B+xqDtcaxBFFHdg26vQH1Vu5rIV0pEiymWSlb/mjwA6e5NV4h0iDwmk7
 9GJWgKdkFR6LbMkk1rnZ2R927b6p96A7YQeylkS1ri0E1sT/TXQ4S2dXQ/MCYgOwhX/TMApx90
 Dl99KRqUaNGunL8JcvBomxHdasUZquzCwAF738BfKJUDXrdfra5Kntvj4TN3UnPeUp+0o4rs2Z
 F84=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:20 -0700
IronPort-SDR: RehRzaThR0hc37wNjqkltJ+dfO/hlRGJetFrnAX1UOANVz9k5ZIJ+kSDt8opKJGJOwIrFyEeZk
 TwtDv9Huypg0wYz4dm/8NDnvwLaqh3eVfRvAkWkT6VvIVHouxmJ9cojW5aiBrZ2cuUyar8GmxH
 pM7pZBufBx/ouszcaAOPMBaDxfOwlbo6DAOIZUQEsZdRgiXOJyXcbpTXXM52G8GbwuePmG9tD7
 6CT3hnKgyfR15tAPquXFKRiXeuWuTEb6OxiN0Sdo2XMa4aDdkQ/G6vt9d7MC/I6z4RZ/z+UW9i
 T4A=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:09 -0700
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
Subject: [PATCH v2 02/19] drbd: use __bio_add_page to add page to bio
Date:   Thu, 30 Mar 2023 03:43:44 -0700
Message-Id: <01716d15d92c2dc01607b0491199d7a4ad3fced9.1680172791.git.johannes.thumshirn@wdc.com>
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

The drbd code only adds a single page to a newly created bio. So use
__bio_add_page() to add the page which is guaranteed to succeed in this
case.

This brings us closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/drbd/drbd_bitmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 289876ffbc31..050154eb963d 100644
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
2.39.2

