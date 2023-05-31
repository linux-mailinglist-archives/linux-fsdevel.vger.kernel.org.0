Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A1717E85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjEaLjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjEaLiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:46 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167CD10E;
        Wed, 31 May 2023 04:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533123; x=1717069123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=feBhECdTKAjH9l6zrs2xmhiYw9k0zkjzEVMqz5jiOVc=;
  b=CwLI8UW566776foCjLsV7tlr7EMNREVleiXljRnTk551zJ3iRgrj9n3L
   w323AUOllhzcTVkarut9OVRs0aXpLUGl3qj5WuqFS3tKVVlNYIqq4CczF
   3N2p2GBjT4MJ1BgJEuOlcgFT08uFwOaN3TuCkuLqxzRbJegaWUdqWl02c
   7zT6RRQCnMPBqY9hjfTcZsePWdMVvn2GEa+R5TMufBpzAmrlMK9J4AUrk
   ve2swIwt1XaOKy+PKonFUu3y0UjETHt6TcMIUaTEcTRZUwwe0PtpUWjJD
   jyRrE1f/etyAB0BgJUkZ0xVv+j/vV6jOCyZK9B4cZpjswOjVnxqYpAE07
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179095"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:43 +0800
IronPort-SDR: wzBY89IIIOTmAQ6x2CMPfmEnNPOtr76d1Tyj1IdQWbWtJy8113MWu1lT3iZ8qnBgkZDj5Ax8RO
 93nJubcaO3MU2PQtNR/UCn8rCXAJRndi0iTtjUA+qmefV7zbu3Xo0olq/rMIRK5wdCiNEoFIHE
 lnnf95C7UP9D0ZWz4GhYtDsC6NlzQCMI0acu0lv1YC4jn/w3rPLmV1JPgsGBxyBHPGAoZbTLo/
 lk3NhWQJwPccCDG46LZR4lESCmpkwcCnJtCPziJE6XXD+AGnLLAs+VNH0eOo7yi4fT/15cEfJw
 VlE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:47:55 -0700
IronPort-SDR: zYArTEPbqkWBtrkzGzRnMoIeR6kiJOkbvPbC+wGWwjDAMGDQ/cy/2MI78K7BOgCC2XJ6gqSpdf
 A7o6UmKIuMnpXcmVh+C9TxLx90rYzweZjQ1tgUKsWmKXL/PC9lM1LNqbbWUYDpmLIhPTLj42RT
 zswpIBd2f1HASE4CIrKh7YhmZRaI1PyBkYmhDhIEz2sXZcZXn6VO49DRc7ZJrHVczIbHQYhju1
 wqAT+uxNfk0B15/0iZirmFqbap44kWPKR26CUcQC7iK+CJF8mbcx+qIQh6K8rCeJcGhKuNUxwk
 VLI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:40 -0700
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
Subject: [PATCH v6 12/20] floppy: use __bio_add_page for adding single page to bio
Date:   Wed, 31 May 2023 04:37:54 -0700
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

