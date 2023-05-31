Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0657717E7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjEaLje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjEaLiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:52 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6803189;
        Wed, 31 May 2023 04:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533130; x=1717069130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gLNFQ6oFKOXzjx1/s8qharxbtLHt5SQOkfsl+Pqo6CU=;
  b=CMz9/k6dvFPQdlVZZxXRjdYwT8eMJl8cOD7xKj7HWSgzr7jkIqD6i9iy
   z6SB3FbylIxN6JmAnGEYX6tAJr4ZA/ssU39qq8sIWDz28hjkKqTmGIktc
   R7n1B2B5jrGRdpjzq4cT6tovBV8scWOnm83qqcTG51rJCqeE3TS1uEkej
   LYSY59Q2z2dE0jMoy71dqyIApiMCogdaBadkQU6fmsmzJqthPKBGYVBNr
   2+/XKO0Fd5lrzgmbxCXJbmOlDcyx11qEtT6VvlhgsdLWbSpfGvzWT70W4
   jIly8LMWUxhdTeRYWY6PxzAwUEdwGGnMbCUShpkh+MlzzEhG5NFCYWQFI
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179109"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:50 +0800
IronPort-SDR: oN2b5xA+Js8cLgRXT645zki1QcfMVPAVdrA0/2StwuOfrMpG27yEw3bxFDEHjZI/n+LmcAn8gY
 JdabUjTP2uuArbm+gS7Wv/W3x7tz5MzYHzYrLCmTt56G0qNjyx5MObyZ2Vu/A74jXAtPJCbR/C
 QfuRf6F05ymg0bGXkq5269YTNfKS4tLhocsMdEUvTA1x9W5xDlk30w0mCwc0tzKuLEvGMTD2Ec
 vnRkVmo7KzHGJGBs5z8hLILVhni+vykcH6Lw1vI1u1PC/Cq4yO6suUGgyYuWadw7UTNXa2n5oF
 FjI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:48:02 -0700
IronPort-SDR: AYqivzP+zZBr7YXk9dG8Jb8zBbjPBW/KSPUnaKqwxnOgRpMHJQY/5pAu5OZbZHqAmB/gPLDcZN
 MvRoax4upNaHhDpQjCOuDZYZBc5P3AI7kmx9HzZph/faczGWX9l2u30PItVdfrBi4SmXmwqO4v
 adAhYxT+hQbjt3XzjoeKlMlN6vKBbho22xcievn7V3yzXTKPnAxwlMRsSHS4haca85vjP3X3sX
 hY5OnMM4jPGIz1ehr4KHfQXrL6o4rX1Mmw/kqbdLZC64FV0/mXL5aSvmkLl4HBPXymYqbCH6x1
 VeA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:47 -0700
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
Subject: [PATCH v6 14/20] md: raid1: use __bio_add_page for adding single page to bio
Date:   Wed, 31 May 2023 04:37:56 -0700
Message-Id: <05f4a70914885813a2ccdbb8aa7eb7d75f79329a.1685461490.git.johannes.thumshirn@wdc.com>
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
2.40.1

