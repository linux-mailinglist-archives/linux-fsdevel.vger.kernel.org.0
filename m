Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEA9717F2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjEaLxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjEaLwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:52:47 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A0010D4;
        Wed, 31 May 2023 04:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533914; x=1717069914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ea2jSAo1rrcM5ItwZsgG7lxFamxzjCiiRPLmWH2vTf4=;
  b=kvmhirUDCobzUGxCD9GHj8MIWcN0/DNdUESuTEJeLbDlDhyRVpWvsWmm
   MAGc5anzjDbYsumCiAnQWG62cstdZGP/kXCXCBXyM85ieQMXc1Exh3YlK
   QqP0U+m0zGGSh4EUBRvfhynRGEC+gHIFLR30Yy4QhaxMl18OMtGJCsfa1
   KM5FOVt664zcPDHl0vRfYDrxlNuHhutIwVIJRCPxPTFz7Ie16RVCMPOTI
   /spd/WWFcI1rizu/5W/FmOQen4HS2mFsNs/wOkLcLp/ixg896wh9n4Sw5
   jE6eo0RJAX0xZOEZJFEq7s3SWU58b9cXKr31surioAxxcy+8NLtZPk9Fy
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547968"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:31 +0800
IronPort-SDR: w7fzUrV8/V1Ko91HFa+e/tMvVscWrtnKk93QWneSEUs/1rE+1rKCX7GvppTiwr4vnTceDxjllE
 skyXYSiIdxg9fnbUZ7LDYn3opyGw31weKxYpu+8FgrMK/tDx+WI5rvW4Nv6jkA763mHcUgQNNX
 SNFEqp2QQ2VCy+YwANP3KBrSfXZbHrgwYvWoEfXwQIhdtB61gp0fKFolKoTP4ub90yE+qc9IIU
 2bDl+vA6+j40dwYdpsD4VxN10kE5iGCEkbLfJl18y5EqZHPGXLAJkKpDm4hT9SqSDNztYLXIpi
 41M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:24 -0700
IronPort-SDR: Z6zZ5moCZAo8HyghcdM8Wh0qvfaCT2LiPQW+ewVuXAv+zyl3VKWafiSq2yJXvM/A54CkcTJN+V
 kRVbq0irr40y+MWSjgjPIzREhnBw/QeLa6OkO6LV2aSFbCYOSOdgOKC/mj9w510XzxJvNJ+Ppc
 bKsq1lcjXCfe5M8sYfeB+boMuGe7XuwZ5WTGw2/M7CwC8jX4gUJEv1IB/iHxsG6xSoVSNEIkFI
 s8y0GfyXNSKO/vqm5AA9muwlpfgMinBcH8LoI7yFQZewBeLk1GwYOBtK16jZm+Elw8Aj2MWMYn
 WJY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:29 -0700
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
Subject: [PATCH v7 13/20] md: check for failure when adding pages in alloc_behind_master_bio
Date:   Wed, 31 May 2023 04:50:36 -0700
Message-Id: <827aa12d44ebf3f50b41b47f5cedc0f80179f2c1.1685532726.git.johannes.thumshirn@wdc.com>
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

alloc_behind_master_bio() can possibly add multiple pages to a bio, but it
is not checking for the return value of bio_add_page() if adding really
succeeded.

Check if the page adding succeeded and if not bail out.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
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

