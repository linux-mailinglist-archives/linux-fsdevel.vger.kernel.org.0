Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA57717E47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjEaLiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjEaLij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:38:39 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEB818B;
        Wed, 31 May 2023 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533117; x=1717069117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3onFYf+ZZCsjR7ISuwDOJFQGwH0Ly8JQt0dIZLYRR0=;
  b=KRzne7xDmzXTjEp3HIbMrMGBeU+2eYZ1kB0rVeh3yHOqisUjnJiNh/ol
   W1FfoOtNX3DCPKEfjQFbauPpGYU2fXORrLAu43l+C0YtCiDwN61vJ6+yH
   d4Ygfg7SdMnEKCMbU6yoNbkzklU/4q1E8RKCfVSZpMRuem+njaxFjtUgi
   9vJj3OUB8+4iuX5L1xeuw2UhY42YSOWLEWbxEkTeM+dp7hAH1uIwvxvKB
   oLt+ziwsntY+5pVq1ZJUQpveYNRZMqvJr0wpbt7mzmY/0ATJd7j/gH674
   FmDUkzZ2wVHVFvN44X7rBgeXFdzW+2ZVjBMIsHlFxTurG4voSCJ2iWNPv
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344179084"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:38:37 +0800
IronPort-SDR: c+5JWOHOrmxuoORmBa7vCvQXclWdtHF3Y2QLb+qP8DyCpTxsDfUP1OO2WccgxquzHOpaEOcdks
 co3RqCzHKpEOPYb0bA9d3UF1elKVRvnwqCkV50UcaQDfk9OLtzGKhO4ky1JTMFQpuyfbsjUtLL
 aywZ1btWCX3tCwHfUA8nR5qedOSV/FFKxKAK+KY35M7k4EhsC6TDMjj31aOdUci1843ZmGJWje
 1D3vybIZF41gZeW5xJDyhv0bjspkCQk1niwnPCXctDB/EmxsJhMF6gGoVwtopBK+PK4d1dkPeH
 wGw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:47:49 -0700
IronPort-SDR: PvLiMFMrjPn38X8LB9ZGsZBO3/tqYDJaG3pniIaNYat6/lxe1f7kHf8DiqwXeKwppRmi9ZRGDx
 8S9b9hlB12DQNIpsIIMRgHvk5QMkFOd+qw7k1/VRYZhaL95XYJRY5hEOmiTHcwzNJplush40g2
 DSCxuqW0Vs4L4hlmoXnbi4NsavII69FPyTU73lwkf1UDBtgWIFJrEdBeuJDRrHvdLhEQfKcn3/
 NBJMXnXHTKRIgKnhOWgNUM2eSMZeShoP0sN6Q18EP0Lc1qDSzdGax3Z143F9n7Y7Uh9ryF8RCE
 Bzo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:34 -0700
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
Subject: [PATCH v6 10/20] zonefs: use __bio_add_page for adding single page to bio
Date:   Wed, 31 May 2023 04:37:52 -0700
Message-Id: <b1b488224117ed5e230478fee2d4c5536ee1fa45.1685461490.git.johannes.thumshirn@wdc.com>
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

The zonefs superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

