Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE436F4162
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjEBKXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjEBKWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:22:07 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328705273;
        Tue,  2 May 2023 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022893; x=1714558893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lM+HCnb2fRYqmeoa2+i+xDIe68f4nLZ6E3joh0Z1hsQ=;
  b=Io3WyacJhZ9mIryW+WdWq1nDKXWyK4V7bH0cNwu4leqcK1smtjOJ4WTP
   fFz62xG/Ccqy0gZn5T8DkqUpReLzlgqm0uZo4RxEoiepAC/vWylqj2DgD
   dw8mJqf0Sdy1nOGLpiy2wHVrI4GCgcJf2op0DscD/+iBF0shiKJD8SZyD
   tHi6msOLqgTT7tj2F9OBxdGrnFyLznJaj1bBT25neiEDNsnSCKl93a8Qf
   PZxkiL5RLqWiIY0XkavCiX1b4HiV4TZ0A1CDjwBiGyOVzZgpTkZp+VJ5B
   inYwc+LklTxyFnn1iJP37HTVlEJeLqDWF2yulfCv+GjphnftGLWGIM1y4
   g==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229597934"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:33 +0800
IronPort-SDR: k+yV9PKNBDlL5ygw4ANVGDC1OtcE77nERFyGC1kfoAt8l9eHDXHbnLBRHYeLCiV8TWoRUKELV1
 iDk3JyeQ7mtr3cfMrvM1qzPAUYoqPTyYRU13w1KGlmuzULkOBp9je3QyBRfQ7oUYt3L5j01NB9
 3o56mW15b4hVE6UKsgbBgnHcMTRn0WKfb0KgIG766oUKO2J8bDJmph+JmankTHgK9jJ/XxjgNO
 GKG9e971/kUHzfqPvNvorVN8LuE4xvYzlgdXpmtVvN1T2MMPBhbMhuMNbKrNbXKNccwZkHOPy9
 YQw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:20 -0700
IronPort-SDR: TkiaafEvpeoB5UVbk6lYF+MYIKTW0x1TS2RRFIsFup5dg77OzPOoA5o4aAAos3PeRXd1TAf24l
 JlqeganwqRXCePrMzLLQEwqwOlT9adKZ9UM/6C0SJSTqBI7//XMecxlqe0zSjF0DpZR+H3rbbZ
 XfOqZl2WmlO21QDDTnBVjbgyy0RtJrgM6I1boLg5EX+OGdLvmaW0Ll6RgEcSoJodKWqqflGCKs
 Tu8A1VT6jrxtAAfmzI+1Km/Qb4+fbicaPop5zyn8h+LvanboVG81oLtfNfwngSXAbDiAnyp6YK
 ZDE=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:28 -0700
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
Subject: [PATCH v5 12/20] floppy: use __bio_add_page for adding single page to bio
Date:   Tue,  2 May 2023 12:19:26 +0200
Message-Id: <20230502101934.24901-13-johannes.thumshirn@wdc.com>
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
2.40.0

