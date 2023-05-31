Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5F717F20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjEaLwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbjEaLwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:52:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D899E58;
        Wed, 31 May 2023 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533893; x=1717069893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TtMwPwqoJmAQPgnjq7wocIny6svRrZPugVBgK7WOt6M=;
  b=dAagb1oJrMUjlLwI5o5PLywf1PDvQLESOeiLgKqLiPVyLN+MhCJHkDF4
   Aw6lQAzT8Zl2Xhjeve4aYbeWcyZqUhuvSpOgLuFH7qaxyQ5dRkHfwJa8k
   AwMtGPSAcZ18jNGmMektvkGqAAE3wNVo8gg1tplyc++c853oparET7sGP
   YH5lykACilfJLr6SU22nYXMGDM5YVzlQSNrBKTdE7sBKyAQK/t7DfMnd4
   7778ZN9SjlYlmR2N9WF9u+SnBuXE4AGnmuztaEMKQ1FBvETV/mrTXNk2R
   ie/hAY+TPFlNU0FJ7ID7oe3SMzLnXjYrjFxK5kbtQxof92vr0kiKyGWOK
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="336547943"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:22 +0800
IronPort-SDR: g3GFSsy8lsCWuvsOXkeeKJ/nb4Io+oo+VwywW8yDXxGFnS89qPJcqGdnsdGmHFvjXnO+VLHzss
 x0ATX1+q9f4HuuOo3r4CSxUJ1yqpzkLCvckEXyMqWY8AhGlV/ZTb1L4Q/7+YC4kAxgZ9Vu8lU4
 y9E93yhuwIXlm2oIt2XX6qp2f0S0C7yybQXHc7Lb5iPsJxoSz/Q/sGifViaIjB3UdVgShB6bLr
 38tV1C/rpvE/jL4LmRhM3gkR0XjR7R3UCTyrmPWOhAsZKT1ENJosk63Bbzyk1ZLdnb4hTLcO8q
 gA0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:15 -0700
IronPort-SDR: lSLmR/VBj2pjG1BOKyzbzpWOt10LQ2v+W9nQSkfzvPSPIPVecgzRxwE+mTlymgLSKsZZ7JJYhd
 saR/IYHvebRwJso+xoYWje6G9oEb7N4eM1apcr9zWPZykON9DnRU0Pvqa3YoovOG9mo8KMnQix
 +59L8VmldaWJ3bDq+eFFGdKuoZg0eQew9RjzgnlQ9qsTIpDlvXIvDrTtcd9QfWAIOE87SHwlM8
 bKsDPUc4+smximEMS+6wPCkGqM5hMJAvOL+JxbNTObAa1Db26lV7WOnHYrJwT8baEncOGR6XK/
 IhQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:20 -0700
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
Subject: [PATCH v7 10/20] zonefs: use __bio_add_page for adding single page to bio
Date:   Wed, 31 May 2023 04:50:33 -0700
Message-Id: <04c9978ccaa0fc9871cd4248356638d98daccf0c.1685532726.git.johannes.thumshirn@wdc.com>
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

The zonefs superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 23b8b299c64e..9350221abfc5 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1128,7 +1128,7 @@ static int zonefs_read_super(struct super_block *sb)
 
 	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = 0;
-	bio_add_page(&bio, page, PAGE_SIZE, 0);
+	__bio_add_page(&bio, page, PAGE_SIZE, 0);
 
 	ret = submit_bio_wait(&bio);
 	if (ret)
-- 
2.40.1

