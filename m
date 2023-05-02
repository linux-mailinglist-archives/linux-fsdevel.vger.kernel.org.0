Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00D86F416A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjEBKXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjEBKWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:22:10 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89675B9D;
        Tue,  2 May 2023 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022901; x=1714558901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Izz1m415iRpIH2KEmuCSasFE37owqNrtjCwL859ZmdU=;
  b=LdsRmNR1IC2Q89iuivhGfyk907dU89Z18vFzBYZE09YfHg6+LUj7cX5E
   WPMdSXLCegkuVNohBsijYMgpvFZ6Tv3bYt2Oc4BmWmObCwbyoBfseYG5c
   cm7Vk9NKSMS75cUk4UDp4/QpEjBPEOJfXXHekM0B8378IMQ1IFbSALhrJ
   lZ5+dEA3zCSY5xgC1fMzSY0DLtt1YnzMMpL5injsFOojASzBUrKD82nLP
   A8mZ6UIDem9uCkDg9C9jFa6nO2MGJmARwcMx0g/GXoVbDGZSbpuN2eC6i
   MN9KjvNYm4WHWeSaTW0EvY4CIzjWIfKxHrx3ZrjMGqvb75hcrXoC5LpOC
   w==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229597951"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:41 +0800
IronPort-SDR: kYhDrT9Rht639ejdBqfDRWY51dwV+6R80V+028lXKwnTIFIqGGgNUY0FNPd7bkSMe/1IedS/yE
 cQZtXVTKZLo6vJdj+JQpsdBTjp9hglQfWPt7a66GT/bEsLpUy+AHcJnQhWxHyxVE69RZB4S3TL
 f5NWzu1aLU+GMHI6bVgZ1JrFWxkmyVsgHCempxuVBUb9bDF3v1MXUdlhl6o3gARTfHlWn4Xssi
 fgEYdLIuxyMkLCn/h2wm6lyPuhGEZtdLBazt6hRI7Bi2kbAArOYNkVwNtiWTlCj5zLsBVBF17k
 QQc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:27 -0700
IronPort-SDR: 8hfezwIRYSWrrJUCjb8qjdEWmvQTAb8oREcSmYVL+8wk37Pg8Tp8roG1ZW+mjz9+6QAe4BsYpR
 EmWDRLcNeuJA92n5AIBbxiEh8eaf7kNTQoJEaoTjt7fYdn6r17LR46CVYDGJSihbaVMPma1L+u
 Irr0Z59+CdymlR+nAOTRZX3GKZJBGdjXU2UbPpLAYvOc4YKURimKOUi/xKoEJ7xmEC5Nk9TAiH
 owgOpkXcZgnwpHauY5btjBdZk+mI0uRcc4XS7SdsdzmLtvgoeCacNXPcdywNwlmur79/2ZnvYn
 +MY=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:37 -0700
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
Subject: [PATCH v5 14/20] md: raid1: use __bio_add_page for adding single page to bio
Date:   Tue,  2 May 2023 12:19:28 +0200
Message-Id: <20230502101934.24901-15-johannes.thumshirn@wdc.com>
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

The sync request code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 8283ef177f6c..ff89839455ec 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2917,7 +2917,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 				 * won't fail because the vec table is big
 				 * enough to hold all these pages
 				 */
-				bio_add_page(bio, page, len, 0);
+				__bio_add_page(bio, page, len, 0);
 			}
 		}
 		nr_sectors += len>>9;
-- 
2.40.0

