Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FF5717E56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjEaLic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjEaLi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707B0184;
        Wed, 31 May 2023 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533103; x=1717069103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I1+TGenMrGdtSWKYS446AepXRO4LZgePrjmNY71VmmU=;
  b=NOKEOh77zsMIuGfsvJ6/ZPwlFF5lLe/WoURM39gEnbKGgeQp1bBYpafl
   fNTzBubinLIqMuBgRS2byRg/K46NWodXlMdA5DlNlqXznBBVWTQMbnuE0
   S1tVUUV6gHJsMMtdabILVELt9cqEv60AMWOY0HA05LdGzzgTNN2GU7oc9
   GnYHfM6g/hSB6dWiiTCj+v0Zw82u3nyXVSxa5NSZ+6tHY1d03rG48rKoJ
   KUtDp9O/+AUiCar6qgL60yRuPQub59qzMXIrQPfxOmNzfwkpK0Y4JH4vX
   1Q0qN6Z8J1nzfeBP8tdR1NjxSSifL/wCBccZqrSX4kmyQnzZvmNnBjK5h
   g==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179053"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:23 +0800
IronPort-SDR: luKTfi+MFQ8xs2UQh60vobPyhExzjYnMRzvNoV/FJmQ5FQs5VrzI/qgttFZYtE76ocLwB2H0jq
 uGdGNJeQ976NiJ/6u66bt9l7RSE3ERPXXWtIw+1JwAfLbDFhbqhq27EQHfXzxrkQ1TyWGrppvD
 FYaEYoCVNul9UnqzzK1YBS/DAF1R+fhhddEF+ChRqpwv0V4KINuKgQODM3ZUVJbv91a833RUTV
 6U19VcHU5ik8Scn8Hh/zyn50WX6BFHWVsTBhtUzlYK+GzjK/k3UWOWhIskc39BHbqX41zRVyam
 jGQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:47:35 -0700
IronPort-SDR: lAQlFwod1LolanzvJjaARoBCaCoqlzlJvddh/3MsACWNQGgD14eFzSLN0liv2+mcfhIC77P3CS
 1i7vOm3aUOsXwXutLoeFQKJtrw73hgHopJDe51ArWDkDFNwHKprY9j/qv61HzysMLWNq25shOE
 ylF5Nu9ABGp3+xkDejsFGtJBav5gx4Hsxuy03mMTMqo0HfVvI8JihYKEedehepQ4Il5YXjmQCs
 OYEX1WwJukJjMHdMpbV6GqyvWS73AlArLwN2qD/OIOwugmkreMfF4mPgARhXOeBr+pacamAGi3
 hsY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:19 -0700
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
Subject: [PATCH v6 05/20] md: use __bio_add_page to add single page
Date:   Wed, 31 May 2023 04:37:47 -0700
Message-Id: <8b046033b3b073d1ea91c45cd278b7aadd0b7e1e.1685461490.git.johannes.thumshirn@wdc.com>
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

The md-raid superblock writing code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-of_-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8e344b4b3444..6a559a7e89c0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -938,7 +938,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	atomic_inc(&rdev->nr_pending);
 
 	bio->bi_iter.bi_sector = sector;
-	bio_add_page(bio, page, size, 0);
+	__bio_add_page(bio, page, size, 0);
 	bio->bi_private = rdev;
 	bio->bi_end_io = super_written;
 
@@ -979,7 +979,7 @@ int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
 		bio.bi_iter.bi_sector = sector + rdev->new_data_offset;
 	else
 		bio.bi_iter.bi_sector = sector + rdev->data_offset;
-	bio_add_page(&bio, page, size, 0);
+	__bio_add_page(&bio, page, size, 0);
 
 	submit_bio_wait(&bio);
 
-- 
2.40.1

