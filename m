Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C8B7167B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjE3PuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjE3PuM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:50:12 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D75113;
        Tue, 30 May 2023 08:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461806; x=1716997806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=feBhECdTKAjH9l6zrs2xmhiYw9k0zkjzEVMqz5jiOVc=;
  b=d2I3mRQIYCqRP/r+8C7Ic8ej29eYBLkFuohOOyRyoLThupKdfBm/SuhM
   gR2buiE1HpDoTQbuO/DrCmxaZGb8wIe9pXPlaX8IbIYmTn79eAjSI37jl
   K9plNwJqdJ0tmb2Z69HO9vn5rhiQDo7ddiwTPlptE3pxWi+4ACa+mU6HE
   aqVppqOE+QGMIG/orj7L6trbTRgooBUmjtXRPsh7dy7Zq/WAfeC40QO4W
   d3XA07DxD94Esj3mZTPxZMf6GjoNbkJQebgaIFs7XGKWPztlUo3iqbtzM
   bFxOdkRCtZfbz4YYT81kXTpn8G3MT6Hol/DP4BnfPJc2AFZc6nznvuarx
   w==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129822"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:50:06 +0800
IronPort-SDR: DZ+4eHi00X+yAuAgAY52mezda14hbhRF9JHMJRnCFSFrSSMEkOJ9s7i4iciKyKT3L4Pagmxwk8
 O9Hwo54B28XuKm69XPn8c2vl2yNy1sOHJ+N9f1cLfyQzxEL795oaIe+5A27GFHw6DgyWqASy32
 WjUOdH+OU/lV9AjWUF16Q9pag+HlCs5u9cmw5kL3cgxutSQRg7TYoCse6Mq/4jRQiCXjMmvm0v
 kbB6rkaDt91RvQrhu7083sH2rvFtb4nu2uU5FznsDZT8RFYff5276LpIFMoC9iCaK0xYCBdj3D
 Jmo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:04:59 -0700
IronPort-SDR: EhH4NXigyhjdlA+o9IGwq9toIdfLXKwjqpigNPLms4HX2ZY0xdq+HGjMqjM/LXPE0H0lh+M4yV
 XOUH1WqeeUTQLRM43o4YQyLZh/QIjvwzVGZbVmNMXHvT5n2wQIzYOdHngHeSW32GE9fp8AeZ38
 O7IBIim14OZkdwKoUagjTCGpbHBhvSrPULKGTbznjjKuwsGFp7K4CnPG+U/LPiXHGWkqFNNUNH
 jUB2k76eBdmfrU2hEjhb4tbcKZs+3fgO9fPe2xuInJzHIOQ0mXkmAO0bd7p4K36l0YuHQ9uRO9
 U7A=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:50:03 -0700
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
Subject: [PATCH v6 12/20] floppy: use __bio_add_page for adding single page to bio
Date:   Tue, 30 May 2023 08:49:15 -0700
Message-Id: <7e817bf13ca47fd863385997c0a9794221df7781.1685461490.git.johannes.thumshirn@wdc.com>
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

The floppy code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index cec2c20f5e59..28ec6b442e9c 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4147,7 +4147,7 @@ static int __floppy_read_block_0(struct block_device *bdev, int drive)
 	cbdata.drive = drive;
 
 	bio_init(&bio, bdev, &bio_vec, 1, REQ_OP_READ);
-	bio_add_page(&bio, page, block_size(bdev), 0);
+	__bio_add_page(&bio, page, block_size(bdev), 0);
 
 	bio.bi_iter.bi_sector = 0;
 	bio.bi_flags |= (1 << BIO_QUIET);
-- 
2.40.1

