Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4377A717F2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjEaLxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjEaLwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:52:47 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25B10DB;
        Wed, 31 May 2023 04:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533917; x=1717069917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bohfoz0yKcyrTKAmwYJ5eEtuSyoqE/wma/5DAX2SoB4=;
  b=HIB5YSBZLh+tdPtL86+PuB8xQ5nW3+02k/5fd9hMfDH5hxHJjs3nlUEj
   RCBLkNF5K6Hm+QKf99Qb/9toLX5QwEw8oMio4MrNk84XSEt/lA3HbUiA7
   2RK4CTxV/AuX105ZSLxUDSsmpBTYr70WWjaUWYy2D68GFI+yzSZe6/32C
   RIZSYE8Pwd9Y6OthfaqbpsUQ1yUVjFLiNovfzhlt45mOzHlrKxapDQ+en
   N8Xa3llJ2H1R8V3pyJNE50EBtSUFOTrCtGan6UvJlqtI7Zwj/IrFX33qe
   V7IzYZJZehz7wYoMOTVoaerAD7NyEjYtQrmroEd61K0BI743ncUKobupz
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547975"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:35 +0800
IronPort-SDR: GHNEw2s/CLCL6pboj4BirbjXbh7PUoubgX9ZD1m7/uXAfIfyy/I7DlwCIxKzXic3BavvOwa0n0
 UlxmDcbJFERzYat6xFBh3LUsozpCVJchxOl+klI1Gyak5tJVBZokMDYXiGAPPCxnBmb6jb7Htj
 bc+RY/KGbjhSw1DMAwtZKoXxsjExCfD6yIQ59VpGSosuxpqN/p8ZlgtD50rC415s9HgvfaY/KG
 G3tFbv2wo+xC3rMzIT+XLvaCDJS5OgxGuqmSu1RyuIyBkObdHmbtdQbeQsXSu/6QAtrRTPBPDu
 dYs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:27 -0700
IronPort-SDR: RyI1mO/6ZDV1E3DLyp6Uz4OkisAp3fmmDbkdi3t8dad2mENNTujbJYnovxO5rrnbcFvj44/+jo
 9geIEpgzs7b1YFKTE0G1l0Lp3+lEzNTl9X1NIJsU40I2Prt8PsF3yR1dayx8fCgdFyyn8gKXEz
 IXyrLtro5IVNZQZrV6QYzNOWEEJMlX3Q7lqTPiOFr1n/0rkij17qLKpIKNy8BFHJEhMnhLSV+o
 YRHeP/3vtyn1/eOy69ZH3PZyRUMWrOMLRpBiN4E9fFtSLU6ZiZvnsiJCzeS0GaTmXOpjuO4FSL
 0ms=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:32 -0700
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
Subject: [PATCH v7 14/20] md: raid1: use __bio_add_page for adding single page to bio
Date:   Wed, 31 May 2023 04:50:37 -0700
Message-Id: <6cf7f66c6e646231200d025dfd5f2d3ae75c8fe5.1685532726.git.johannes.thumshirn@wdc.com>
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

The sync request code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

