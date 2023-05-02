Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FF36F4165
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjEBKXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjEBKWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:22:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30683559B;
        Tue,  2 May 2023 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022896; x=1714558896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DzvJ6wZ3Sui4RZ9TAlD4OlMyP4gDTchzDlmODiRTaA8=;
  b=kiE0VOEiZCMvpmsGqwZ1SOiWQ7eGRNkc4Hfc+rFAns65/r/EGEWPQCns
   fKMEDu1gVsij48tUzQL1MaFyjh+ArIwjfOwKb7dg+3fIzJBP4q+Eni9Bh
   qnBOXkqC446eEtaNK+wW4ZSWIu2/QAaWzqYpGtZPZTWanUFKrurTx3lsY
   sHa82uwA8jjFnVcOpXXznwNUwNo+8YK+M8AYvPg2HHAB9bbZQDzxrqTZO
   A5+IG4FAMdN+OqibZ0Sd5uAdwekWHzZP50nJtS6ZOjYo58HYsU8pE77Pr
   zLQ/mjMLk5v2yxFq/WJvv2mq8as0X573bILuO27iOPFyGK29uGylGgFjB
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229597941"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:36 +0800
IronPort-SDR: gBHQ6IaE0gdLFCEddNDbFZVOwnZB0OZh5d8/GQOoeaVp4NJbEPs9ArfCzb6BOxvTtIrSgZCbll
 8bFc3eRA0VMLUHw0+2ac/ummwGRbtIQnOxjtWStuhv5toyvVch6nK9ewA1r5y2JUFV6D4meNH2
 J+PkrXykXk4fLwfH71+YnMCLLTKtjX/+U7DM8dHFVeVGc9sU4o+O3LxhANFAPEsEJFd6Ndy2hS
 Q3rnrXOLWQRibwIhK+MZDX4ItqRmA4jDnkSW+tueaFh/DNNifHkH9KSYbe5l5aiaf2pFVX83n4
 qww=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:23 -0700
IronPort-SDR: uGIw254wyz5xW63y6mKPruYBxsDCJBiWJn5HyxXEKlHH3a6WQB95MJD2gL1U37MsE73pDlkDfH
 XrAQKE0o1trWaMuwmkCjZxReOE6bQKTuwcjttjZub9Fo2NWOrlg+l+x9Li4fpCvU8smOVgdBJe
 iX9LTVSMXZH6O+ImhKiOGTSlNSVog/dyr5RquJMBmwgwChPCFkHcE06ByPGE2sBKs5rW/DQtzK
 T5Xxpb54D4Yuz40YIDXaPoJ+wQXNcche+tu3/6iWe/RHtJ7xSAUbzgyNSPsRVFjywOIFjhKDZt
 2iU=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:32 -0700
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
Subject: [PATCH v5 13/20] md: check for failure when adding pages in alloc_behind_master_bio
Date:   Tue,  2 May 2023 12:19:27 +0200
Message-Id: <20230502101934.24901-14-johannes.thumshirn@wdc.com>
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
2.40.0

