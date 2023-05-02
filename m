Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA2D6F4161
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjEBKWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjEBKVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:21:49 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EBC5B89;
        Tue,  2 May 2023 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022887; x=1714558887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvTmlyJDrtB3jz8iBa+x9pcB74OLTnG9vUDo5GkRHDI=;
  b=qH6Zt3CjDkhtvS8ZR9ANIjmSDl75HACGQRamghUShiGeks9cCHkG4nD+
   wOa+GXeQ9UuuZzs4OXyPv7uMtoGlQKHQTbzCReoMzklLnfF4KpF818E58
   7KF4FUxrytDoQIkDnfat1Fz+312alzaubdm4pyFG9pmWEhjKwf1cptzES
   zavqPzFNnNuT2+OlcVpK9GoTH2Y90tUBYWkqddZziln4RclydCsSPmkXS
   biM12Xy6zMip3q4B9qwI4uwEaZY7suyVXhTNy50SX1+k/PyAwEPkIFhE4
   g4qvEQEdz3dBZtFFqtZJpR7R7Qt9F6aOAsKDb01mDipljbX2eKTtUvGPn
   A==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229597924"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:27 +0800
IronPort-SDR: GP3+8ePZ5M2R2YlmrdW5lIa2ySPUA26egLDWYMLOMkuHSkt7+n3nCbC4niJUrOTygkVMuD+iTZ
 /F641Dj/pUWrD5Cu8mHq2b7r0GDwRBtJE8bo1Z5Fej9dyKl/4BH6Su0rUftEDmtbXQDm/OCHLa
 zdwjwq/rKVFfx7W8aT5IJgYXnsKuAMqDrfhNiYBkun534BJ51g5N4YHw0ZW8tOcoqWHDNglne8
 FbcMeOVw/HxM+sjeFOQrHGAI5KqWDTRRKvqbvUdtSRrS4crdP1EOXLluAmXZrMStNPzMY2SvUQ
 /4o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:14 -0700
IronPort-SDR: wp2VCzSGIEBx+d279yxevBn1+XI3VuKvqj8oLKNceK55K/eOSJmgxWhB2EK2yL9r249YKUNO4M
 bGeHb0y1gSCYoZWdb1piBrcelHDZIIRDff/B8f6uw2wt+EBKzLtgHpS/if9aysTLwKYYR4CmyK
 Ut3+BZdj8uHy5barmhyvli41TJGJFb4YMPGI659Z9H7QJ+LTZHxcRB0MAMkzGM2yCWWsIECayM
 KNaUJNela6Ul6p5EBpXHf43F6gec7o7gG4gWdqANgAE+DXYIfyjuwn3+4ZYonG6bdrIN5mcSTK
 NIA=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:23 -0700
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
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 11/20] zram: use __bio_add_page for adding single page to bio
Date:   Tue,  2 May 2023 12:19:25 +0200
Message-Id: <20230502101934.24901-12-johannes.thumshirn@wdc.com>
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

The zram writeback code uses bio_add_page() to add a page to a newly
created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a84c4268257a..4b9ca6d41b92 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -700,7 +700,7 @@ static ssize_t writeback_store(struct device *dev,
 		bio_init(&bio, zram->bdev, &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-		bio_add_page(&bio, page, PAGE_SIZE, 0);
+		__bio_add_page(&bio, page, PAGE_SIZE, 0);
 
 		/*
 		 * XXX: A single page IO would be inefficient for write
-- 
2.40.0

