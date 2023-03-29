Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173166CF04F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjC2RHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjC2RGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:06:55 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A386A6A;
        Wed, 29 Mar 2023 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109598; x=1711645598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tehGgAgqd6Ug1q0ulEduzG6BKUhY0WsPTR6+2QwYTdw=;
  b=GEYxYKyvrWiwTG/EQHkW409uZx5P1VP8TnxJRwRD0DOXr3ES9Qnwu2WD
   W4WYCrKVoSMyArm+SN8gSeKWTvre43iNR7vLX/JoP0jbI5rbXHE0z70gR
   qz6e4Hgg34iFpqlt0Cst7M1mm20+TqDmDKi64ziLyiUUAb6v9UUxWEgBO
   X129GPRGlOFuiKoEYBzgD0xktRoFT0a5ez5uQI0HMagbb949Z8+f1kepA
   EK9qXwW/cWeaNhuSNmQgPrSKkU4/Ata+OVtfrVG662d4XmBFgRpGMcptB
   Purb8Qt8X8r3JTGSX6XdL7emAeev1YLG6pBlScL4WdENno8pEClE2Hs/5
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092852"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:37 +0800
IronPort-SDR: SA1ZCXa+urb0uQ+rNveiwGF+DYMw3fbWMbHW1uhd+nfkn0ZXvG7TEY3QjdcGFDKNE1UixH0Tj8
 YZw4g8Cislj/7BvFBU36SjjwYDyEgj1et2Trhhuc5Q2zlhU5piHTtIta4mixsnfBn9lFDbppO9
 D/bE8NCbQHbZXcrsXGtvYKse2XIH0MkpPfJa0oZT5FKIu2JHqS7JQsiLnpbqDQSJkvtyLgbwW4
 lgshy9ERDrzGkOamwPVVMVe8qFM/kPLU13cVwNKr5r+25Pe6ZCed1CJKHuuOEEmDwgmdvbMf1B
 qbg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:22:47 -0700
IronPort-SDR: 6+prpYoraSp9aFA1hXlXHyHu40E7L/eCAIlzO1/as7m+QuTtwlfLU6oRqm+u0ktT4yW4nPXxtO
 EVWWCSi0KFouza9iXBVKHiWfRjRCi3K8NXAjcFmNFaydHoskQ0l37e1TsmHPRtc6H6IjsIJnWc
 qpv27cTnKw5/oXlPKjLCcoz7fE/btbZpL05CDoXEXYjFbavUThVFCHI6KRsWesZV0+mBsx4ofC
 KwsVDJikGzCScu3CFwSWTYXEDPvbMWFR+EaLM1F8AZskQ1sONkyddBy6iSLZ2oemLVljH3RxOv
 qao=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:37 -0700
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
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/19] md: raid5-log: use __bio_add_page to add single page
Date:   Wed, 29 Mar 2023 10:05:52 -0700
Message-Id: <492cbaf4225065838d25e04f8488528e50a52e3e.1680108414.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680108414.git.johannes.thumshirn@wdc.com>
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The raid5 log metadata submission code uses bio_add_page() to add a page
to a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid5-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 46182b955aef..852b265c5db4 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -792,7 +792,7 @@ static struct r5l_io_unit *r5l_new_meta(struct r5l_log *log)
 	io->current_bio = r5l_bio_alloc(log);
 	io->current_bio->bi_end_io = r5l_log_endio;
 	io->current_bio->bi_private = io;
-	bio_add_page(io->current_bio, io->meta_page, PAGE_SIZE, 0);
+	__bio_add_page(io->current_bio, io->meta_page, PAGE_SIZE, 0);
 
 	r5_reserve_log_entry(log, io);
 
-- 
2.39.2

