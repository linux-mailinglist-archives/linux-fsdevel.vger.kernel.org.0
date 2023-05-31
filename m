Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1C7717E86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjEaLjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjEaLi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:57 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D39191;
        Wed, 31 May 2023 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533136; x=1717069136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C+NYxtWZcIKLiQW8aZvWShDgl/gtDFIUIUOTPRiObYM=;
  b=qZb9aDbtjwV2cRnuCD735jsONPVaf404Svgp8zEyKy/kEsqFhzyy3N6n
   MethnOULEaTBxGcZ4iRYD4iDtNpJ6JS6fOKZFqfrERjaQZw1+uKxKKv2C
   X/chzz3tT2ipY8+dsnOHg+WTB1unRgVZyPjs32Rll8pHe0vqpXShgThQ1
   OGymdOgEYWbcsQcxDP8zjkoDHgnYITRLStJA6EZEimwn56FqVdulT4R54
   0jMeK0oZEnTXAuaMwtati41uWWO81nVQ0dUf/z8oBhz/B3TscjxxlxQsj
   1RS5kezEIiMznJh4T1qq2eb1wkfu1Py0A1NGMk6RVB627Y4L4211/kYt3
   g==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179124"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:56 +0800
IronPort-SDR: 3s9pvOcFcUE87NbGbt8fKnlQxTNOA6Uoagmkr48g+rXIdQYQrTjlc5MpMN7/VKyhLg1w+l/VlC
 IY6TEm006oWkf2iYerHl3QFyPT9FKj14nC6fIxnFMSMFHsfH8jctCDCGpsn622WRAqcAJy56SW
 PUUl1agleAggokQn+gA/dfycDtYVwC5mb0YRXkRRaoFOoeJC7NSbUXcucaFbdAVQAv74z10Rdz
 tJjk6+TYyKkElnY67ksuXI0U4/EikhOdvlqK00jXwcR5rVAJJBNBbUUcVlVB9BJxxIN0tFjmZG
 74U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:48:08 -0700
IronPort-SDR: PKSrcm3NLNbiBK+MDQubevMRCFG4qYLLpgaKSxArlKlOXwW0E2BOzt5f10GZ8a1A+2vN6P0M26
 WxUV3N8icLO2ZI2b6wUvGTR/5lBbq92cfmOjXbzq+xJLRd95oOr+yPHrEb9f4OyqGbaMvtJDpN
 u/ss2e1pjPU9QWjjEw6cCVIwv43Blx8EnaXRymC0CiQS/6JKngFCZrNfKU9sh23zLkSiQp8wJg
 /p5T3+o8yTKVEDHWcCFvmVOZj2XoVpeJcgdYtjcA8cYxZJnOw3mdTok85yL8g8qD+jojKuWwK2
 3wA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:53 -0700
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
Subject: [PATCH v6 16/20] dm-crypt: check if adding pages to clone bio fails
Date:   Wed, 31 May 2023 04:37:58 -0700
Message-Id: <e1c7ed59e2d2b69567ef2d9925fa997ecb7b4822.1685461490.git.johannes.thumshirn@wdc.com>
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

Check if adding pages to clone bio fails and if it does retry with
reclaim. This mirrors the behaviour of page allocation in
crypt_alloc_buffer().

This way we can mark bio_add_pages as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-crypt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 8b47b913ee83..0dd231e61757 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1693,7 +1693,10 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 
 		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
 
-		bio_add_page(clone, page, len, 0);
+		if (!bio_add_page(clone, page, len, 0)) {
+			WARN_ONCE(1, "Adding page to bio failed\n");
+			return NULL;
+		}
 
 		remaining_size -= len;
 	}
-- 
2.40.1

