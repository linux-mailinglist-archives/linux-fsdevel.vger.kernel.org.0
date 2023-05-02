Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839436F4133
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjEBKVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjEBKVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:21:16 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0055A5;
        Tue,  2 May 2023 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022861; x=1714558861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nHbKpL7Y+zm1E2hxTUANJxFynmRK+rVRHRUzVuIzNMk=;
  b=K6Rgo1iGeB3ThFI1wA8m71EYGJoADnBffn1yYcGrj4GbUQkOJQ2IoB+O
   Ee3WtEzeb8lABug9ERu/X8e7frzdahBfEr+fnIXhkX4oTzSZGclWiSaMC
   8F7R6XdY3Zshvmre/IaGUWf07NA28ohUmqWzNzApKu8EXIAmCv9URsRZw
   X3Drpbwm6ArZnZWrmQJnkf5mu/CteAnxTsrfNCGyryUnF7FYlomnSpMXU
   NSouGp6GQ1OwOkiFw564VWtZ4t86eTizG1/LS4o7D21EeDkjTp21zp/fe
   4VJEchoeU+9Fz1YObBwUmMUFsmClGp1JNzsbgtdCUQF1q2dosJPqoa1PK
   g==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="341747141"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:00 +0800
IronPort-SDR: NKBaYFCMO1DMg+2qAQmCP4/UGw+nODyg+zs3z3/MIZFaCrz/Lj79BWILXAJ5z9J+xSlWSxJhel
 wnWNg1Wv33r86qIAJcNoAMnHcKw0tRYFTjvwmuyEX7jT9pW08ui0uKjSc4ZUJzcE+ZbC1z5KT5
 +lSiOrJSIRSw5QVsT6X12Z+6F5AzGSHX7NjHZZgqXlgepYxXrQapQjfnvmnW7M/ROfh2bk+WAQ
 CvpTPqtd30JNcrwA9fS+PwtYBcyDKUSSZoCrBr1v9OupUUqZuZIKco78tDbrKXTJk6SLx9wUpr
 OKA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:30:45 -0700
IronPort-SDR: hu84V3jZx46hwEraig0LXQQ9C8XpSBIO6XTGB9pDNLp7rKKsf6bia2072PkFMByCh+d0rCq+sR
 KzWze2bOJZtPKB78C8HCOcv8XZsO5wHBA97OXB8L0KqMYxhbKFaaAMyShVW48UEROyK3Qwdzly
 HE4mL8tAp1LxkPWrPNJ2lvmb2X2qj83N7UtkLiwo1J1LF/i9TU1XlJazkjqqJ7qmqzKklcUW39
 z8BXZsyHk9r5ZiJReqNNG21+Q9+Vy+cFmuYsdmbMFTgnoYiX0FYOqz6+7Jxq8JAtFbCLRV59wL
 rfM=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:20:54 -0700
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
Subject: [PATCH v5 05/20] md: use __bio_add_page to add single page
Date:   Tue,  2 May 2023 12:19:19 +0200
Message-Id: <20230502101934.24901-6-johannes.thumshirn@wdc.com>
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
2.40.0

