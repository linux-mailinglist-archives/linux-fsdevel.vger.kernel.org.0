Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D437C7167AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjE3PuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjE3Pt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:49:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3EC5;
        Tue, 30 May 2023 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461797; x=1716997797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k4Zj5ateI81PgQX8IcVmz/ho3EHE64HEcz5aupY7/XQ=;
  b=GSLuNnPmgE5JvulDOqXzWVGIzL3uHy7aWr+uwDwzPzCGHGjqLMlv0urN
   bWEZkgKNnfiT0zBW9yxIay2Am8VzRUMjO3YiaVQ+1bhR14be557sFds0b
   lDMheWFnO09ctU1rNLybG9JIRcW5X1lZtqYwrd52nbVmDm06xDmEpITE+
   IZ8P64dHuAsoR8gv8eJCmatBguB3lQeBKe0hjOdYIxEilR/yJe+NjqSs5
   jsvOdtsiEuntuRzYTfdiLHjtluvPRCIMR3fUzbiUTF38NE1B+ZjVm63pf
   9ed7qUuYWJci1yWW27j1TxQMPITtI8VT3KjGeTeCE5o+2HSapLhSECGZI
   w==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129791"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:49:56 +0800
IronPort-SDR: Lr0ZwjxeTZw34xSA0Sp45GG3tI+bHTC8LSEt938vaczGMQJfTorrBaT1Jq2FxgjWY9z2R91WKO
 nMsY97DBhGUKcBkjY6FpJg0KcD03CnoAfyyphDk+jrRkmjQ1t8/NP3D3wOnPc3GYKGTmU+5pfR
 9vktQGDQC5Qi6/dMjZXpibysfDb1IFyKjFMY4ii8BX03Ki4u9zS4jID9Kxo4UfNVryH0RdjgL/
 W04LPM73b1v+9BTxmQJ1KysCVcqIowOTOwr/0ktkvE0HO74IidRKCia8CrzAZ+mh3eWgvt66Po
 eTE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:04:50 -0700
IronPort-SDR: syhtlBwgzrZqo2FxlZ+3+3UNQOSy9KOrXWDC7tRnbhEDdQ7M+iJ8X9kfYPjunQnyzAJ/BUunY7
 TJFCtDpOg2F5DZ15LsnpaT3Bwo2hrn6uLSc+fNqG13pjWmrx9wooa6bynhnNQMlDHsy2Hk38NM
 QrDHnT8XkrjMZUyM4mGcFvGUGlEisF2RVaO8OEk9Qwnu8PpGMQpoWoaS1QquWy7J7yXqddyE5U
 EJEo3uszMCInYfCLIryejOvT01pFM14+/21EyuCsYg0N/wZvR8GfT4QE1m8ln383WoalorxH4j
 QYQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:49:54 -0700
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
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v6 09/20] gfs2: use __bio_add_page for adding single page to bio
Date:   Tue, 30 May 2023 08:49:12 -0700
Message-Id: <15cfecbbac931aa18bfd89cede85bcde1d6edd77.1685461490.git.johannes.thumshirn@wdc.com>
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

The GFS2 superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/gfs2/ops_fstype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 9af9ddb61ca0..cd962985b058 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -254,7 +254,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 
 	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_READ | REQ_META, GFP_NOFS);
 	bio->bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
-	bio_add_page(bio, page, PAGE_SIZE, 0);
+	__bio_add_page(bio, page, PAGE_SIZE, 0);
 
 	bio->bi_end_io = end_bio_io_page;
 	bio->bi_private = page;
-- 
2.40.1

