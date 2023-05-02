Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE50C6F4176
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjEBKX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjEBKWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:22:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0246B5FD2;
        Tue,  2 May 2023 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022910; x=1714558910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5SKzmXLiqYlN1FT56vogdtjTkaUplMsRNtsQa39yz4=;
  b=W2tkr9WjwXy9eup0x3c2YcYTEG7d0PdxkKtdV45CAr2c1wHho3r0d0mb
   xhvxNrzJUDSRw9vOTTgM1EGOfs5kZbVxgiShWpp7dFGHAz222lGFLyztp
   U3wWVpIhAuryf+yVdk4JkLch5rggeXl9iE+H993XaUM7dxNQKnDKN6qnI
   CVTzcsvBc12h2zGw1PJNz8eZL1NX5e4XMaryDip0+Jhb5p6gP9g+TjXfY
   R2Omw4FQUdNRf4E1Z+n+jWbbyD66CX9HBXdu/xwdupL6Ghd+89BMi9oRa
   Bgb+VuKNzs24bz4Mgzs/LE1Y45WBy/Io+FSBtBapWVhuNwJpRimJxd0sW
   g==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229597971"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:50 +0800
IronPort-SDR: jH7GvXGXSxFCma6hTGDhUnlcNFvUvGvSyUjaJCEwundTgEyCH10uqYVkyKLR+4nyg9/PuFoo3G
 iDB/OVp7zCdO1jVQxb90JoBihOz9hy8hOw0Bz4MfSRTOstY6Uz7KG6c8bt70ShU14QdVdVzq+I
 hAYPROIk+RhvE0c8JNhSiDPpkkgzppgJdA04RJJeoCTcKbVl8H0nK3Bl5ZF4iO12UfGUvLfcGs
 0LjhgCCvK0NCwdPM4KqWJ7bCrRqJEWoPIoBiy5zXwxBt7inhv3FTmgWWFh4Y0EeBjWFarEjg15
 7p0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:37 -0700
IronPort-SDR: h/+Uzz4d3DSZxkslqyyemyuLPtMI7jhBm8cQQC8WAsiGwmug14lleOQVx+xkHcNGsmIX7lpU55
 87VMP+4tfW26aWu+a5oN3DVTq3PFVs2iF9WR+8oTmTwDIaFXmRGIznTUpQ4aZU0a4rymtj3WZj
 kk/AGz0dRlK1ZycoHqrgPH8iVANoXrBCJuUG9lP22ljDr/8WOx6RnsE9CFJXzzQSnh3bYujqEQ
 6hczuVykrgqMnIl3wnx+DJrdhTydW+7Qj1cYcXsZMgrNIFeXRvMoDlU7CYgbRhYHjf2G0hJiZj
 X44=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:46 -0700
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
Subject: [PATCH v5 16/20] dm-crypt: check if adding pages to clone bio fails
Date:   Tue,  2 May 2023 12:19:30 +0200
Message-Id: <20230502101934.24901-17-johannes.thumshirn@wdc.com>
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

Check if adding pages to clone bio fails and if it does retry with
reclaim. This mirrors the behaviour of page allocation in
crypt_alloc_buffer().

This way we can mark bio_add_pages as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-crypt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 8b47b913ee83..b234dc089cee 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1693,7 +1693,14 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 
 		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
 
-		bio_add_page(clone, page, len, 0);
+		if (!bio_add_page(clone, page, len, 0)) {
+			mempool_free(page, &cc->page_pool);
+			crypt_free_buffer_pages(cc, clone);
+			bio_put(clone);
+			gfp_mask |= __GFP_DIRECT_RECLAIM;
+			goto retry;
+
+		}
 
 		remaining_size -= len;
 	}
-- 
2.40.0

