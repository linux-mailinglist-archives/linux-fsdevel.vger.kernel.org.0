Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6BE717F17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjEaLwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbjEaLwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:52:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3491134;
        Wed, 31 May 2023 04:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533896; x=1717069896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hm9sz+6gQ1vQAlShNXkzg+WL0o4VgpWyUzccJnRSUVY=;
  b=GFokHzMKgm3Vh7sYtI3teB65DlORnUCAoar1NcuI+PbRNnnNM5x8n/VD
   YSuQ5QisAsrbVp+JpAIF7gEOhiJvEDb1eJElHvREWa7uwfGq/X2UiQZgI
   2tAVHMZsHZ0rtlVeP2YargXH3VLalESNH6Dwqhy10HcaeYukVNq461Xve
   GcPmWDWplfztwYnuDbFD0Wt+q77Urc4kLAxVfeTJR/DDErApctj6BLUCL
   f0iAB9PTOMUSSyAlUeO8vkbdYIZAqRQBuK+NqDgNOzmrY3hgAHk1yhMGm
   QlolzyVwX9vWiMtGxMaVScFp2vEPgEyeXyZGsbS6vHQLwRUP8xxul3Rms
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547957"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:28 +0800
IronPort-SDR: lQzsj7eKwHxVICNRjsFZNOYW67x3gxW0W6eBJA1M2XYOKSDy78j9i2PZeHk/YjqPJqnXMzPrbM
 0Glfbv37F6bO2rjNedBt3vpUJC+r3oiXBrix8AbppwKy5gNcghWtVY/Uuaj06aMbZAirsAVzw8
 36ZvxarIMovM5qgsv22fXTFVqRaJqXHadDcgU8eQ1kl1Ejp3ab6tL1kh8JA0TUf4joweWw0Z3o
 FZKugxJd5NyMSfrRqpehksglRHuvktssa43D5ef1ipm8rkNf+OG98zC6F/n4YPsxHHtpFKfSB/
 WMM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:21 -0700
IronPort-SDR: ZZvgdXqWvf2bLPrnAzdu5RRz15ga0Chi9bLZvedEHwiFH+B9pi1FcckdZ9/wvgZDFhJZaVL+Gb
 BhT3tjRKwgxHLeMEuSyllM/qJbuncE8qbGgRTt2n/CBlkxPhKUal5Omdh78LULTg56zSv1r4Xu
 EaLt4CaJU4Rb1gJ2dDbb7DbwFFDTwtL1QrA2IPFcyQpyOtCc2SCv82C+Ozex//EzTenqavOpi1
 mtt/lwX3ifWVjnHHZE9zO0efKjQ4U5fS3Sv/0Tpv49OzM2Qr9C8+dRTcsbUdyAftaM3SElFTbV
 W6o=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:26 -0700
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
Subject: [PATCH v7 12/20] floppy: use __bio_add_page for adding single page to bio
Date:   Wed, 31 May 2023 04:50:35 -0700
Message-Id: <33c445a3b431270c72d9be03d5da1b08ae983920.1685532726.git.johannes.thumshirn@wdc.com>
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

The floppy code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

