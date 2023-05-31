Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56770717E50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjEaLii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjEaLi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:29 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C755418F;
        Wed, 31 May 2023 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533105; x=1717069105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mEDf+2bPYBdApkRtQGcrKQLhlyK4U4yv8ooj5C9H9Fo=;
  b=DYzFY3poJU/neZZFQ2+rSVxDjdSkgTWMjTmmgNWzZYLdNwdLP6+EIORn
   s5Qx5ktORioZsMNQz+RCiIX1olOJpQG61zzqwGzIsrVswxI0S19tLJZwm
   fG8Vo3DgRnEp54m8Ath+l5gU8j/k+Datvmkdx4bDbZSUTpJUp1hGxUW7+
   m11MJwYvrcoytxUkmTyrNokLx9RKQsOgPo6FeOb86UcpHioH3MTdkWpfI
   IrBfDwWuLesCiQPUZyYPw7/Qezy5nns9nlnuTSD5PnvM0DtV6VBAHwnQI
   ZT4uOFMKC/5Slu4KEIzv0FS6EnJqp7Mg5g0CPthYM7qPotBtpfrTxFbU5
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179057"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:25 +0800
IronPort-SDR: lj6nRjy/jBWxu0IHPOJvkrfx/LA+9PuA4L9ghTxhpl7yl+Z2Qw5oOJ7L4t3yhMnEi9t0Jeet9z
 ATp1r8iXcRKxguKRsq2Mr55BM1IwI77bTxFily4Nzlq2WyOkAInLbWQPZZgK3YuCDIuIzLkReX
 WT0/e4WY+nNq4sJqR/EJexhwjHL8M5e/S3IkGLHb6a38RS0Y2OKGEYbdRnihgqsNDiLnvqK4HD
 K9afk4KIqfQq32Ff7ewxl2intQImHpq6U40vrij4df94fcz6Kp2OpFKTs001bRosqISKXzRWvy
 K0g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:47:37 -0700
IronPort-SDR: aNTVBj/pNYOm8LQW/Ysyt++eETiXP7If4qejTn0fgwq+ZBvvjbFqnWjX4cdzAcsB81x+GtufD5
 4CHrk3zAtKxRtt5SrrV2bu+MNhH63gMrYcc4D4gKpDa93KWb6m58gjDK9xoBngjeugS4uWE7z9
 NwbSUCGGc2OIi/GQCF/6Y8t55/FhJdhT39gpNtonggVW3HmW/CajaG1O4A2XU5aP3EL6Og0AOz
 J6wM93B7s7mTIZOtB8dnVwSE7Xkm+VtttBGZJwZi8mxnvp3q64E/M567+71xJT/zY9kw6Ysvqx
 QD8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:22 -0700
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
Subject: [PATCH v6 06/20] md: raid5-log: use __bio_add_page to add single page
Date:   Wed, 31 May 2023 04:37:48 -0700
Message-Id: <1ee0465c7b2634a4435e65a4d0b06019a73d8389.1685461490.git.johannes.thumshirn@wdc.com>
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

The raid5 log metadata submission code uses bio_add_page() to add a page
to a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
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
2.40.1

