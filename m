Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA3717E8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjEaLjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjEaLis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:48 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9480B10F;
        Wed, 31 May 2023 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533127; x=1717069127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VBiHAYrZ5iVLErIRk58IVnEcVkubX6MqVTAomfOuNwY=;
  b=oIiZG+bP4Bl2IS0sAj5mM+7viMAAjXNK1t+WnIdScgQ2lb5VH/LvVtj0
   q4Bt7krqTHgNV04oUBZC/njCHbsXfPGmxXo6WarXcfMekoOLdymZb6MN0
   h248gGbep2mj1e7eZPgt7D4ACOlL21yBPXlRdbVeEogssdetjNledtDGH
   uO3P9e8XhtgmvWevl86G0yqN+ylnIwvSvQh05ldrq6GSiVOHdVzXdZT+F
   Dn5hGXAmEzGuBQv741AiekM80Fzuhx5ucG6cgYbsWP6/fQZkGWpVA6w6x
   AUFE+5lCKy92uj6YUoRQ0BlLL8aVV2lKtFwHOfMcnsf7L6C+YmV0lDL75
   g==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179102"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:47 +0800
IronPort-SDR: VMvzHBzgq152D0QK0yq4S+wmnUgzTzgpJqxWJmztr0BQerxxWI8HXsKHaDH4d/PTQMZok77xRU
 q8ZA3AxUPZCizE8XEa25jTAWFEIcTM3CAy81cB2M3409O8BkgpWp+KJJJZHOjjkY6XO5QZSuFi
 IM7zwPLundc+puOXEPGkl74mDPnCuOb7FA8zgbvl44UgmInCnjweUZ/neEQCuHL9jsvTseqn+6
 GRPepUCAOGKjvdVzRND8FpkjuNhhYQk1FCYuCPhGgmW4bD7pOz2EGx3qVgnEYxpZiiXhRWeA5Q
 hEc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:47:59 -0700
IronPort-SDR: wdGMh6RNwdOX9z4wdyOHz0JvcWnTxFxGSKK/Ksg1OEFa4Jnxlt7c8CxWzsVNAu2ywef95mpqNU
 ++V+oN65aC0F0CO/k7+uxwXrD2xBIlIAW/4YajUF+5M5LBD17djJUfzwWjiukxq53hNVFSJ6CI
 yu4F60MLSwbe59TOiyeVfu8WZa1gI81OkAT9SVASu8e5yW94xRpcY7/vQk1Oa/QapeNZY6vge2
 gwnPQvZctrblCXkEJ9Cv8zda976C695H1+iX0Z83/DZFwmmRmaJzmH7HMD20s+gJ3CO71NCI2W
 lZ8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:43 -0700
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
Subject: [PATCH v6 13/20] md: check for failure when adding pages in alloc_behind_master_bio
Date:   Wed, 31 May 2023 04:37:55 -0700
Message-Id: <d7cfd04d410accee4148d8c0e51230bcb8b4bb8f.1685461490.git.johannes.thumshirn@wdc.com>
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

alloc_behind_master_bio() can possibly add multiple pages to a bio, but it
is not checking for the return value of bio_add_page() if adding really
succeeded.

Check if the page adding succeeded and if not bail out.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d9985b..8283ef177f6c 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1147,7 +1147,10 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 		if (unlikely(!page))
 			goto free_pages;
 
-		bio_add_page(behind_bio, page, len, 0);
+		if (!bio_add_page(behind_bio, page, len, 0)) {
+			free_page(page);
+			goto free_pages;
+		}
 
 		size -= len;
 		i++;
-- 
2.40.1

