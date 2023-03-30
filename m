Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641D76D01EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjC3Kqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjC3Kpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:51 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5198886A7;
        Thu, 30 Mar 2023 03:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173114; x=1711709114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EUpgRxBtOLFJ91CyJDOvQQnrN1sWY+otarb8WY7sZkU=;
  b=f+mFjP1JB5hKN/wTckCJ1rYgOnVmAJO8pJDvRoXwtjZy8zVq/EhlNcAs
   PDU7Op1UfwaiuluqCXL7b37Q2TFkuOK0tzNzo888m7+1MA0fAEYMDo57Y
   cU7KePlIGM2bHWVyIElNNXfrbiaituo6gP+PIy7G02t8Ym5rVRsHhe5pm
   23/zzyVgwqJla2VimDc5nz/vzewbX71iUaX8PDgNx5x6WLZsQcdXJFgtM
   AfttzAQqFhRDm8nEIi8u1J/Ke5UvjB5J6dTzRmG0UfhaV6e9KWSOghXWN
   VzSvncBG2EMvknF/gNJp1R2XSPJNUnCFYvHVnoWdDg7Pqt3qfgzTnh27M
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317867"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:41 +0800
IronPort-SDR: leugHQ2MMY+lG0Uz3hUmuUcoQyvY/36fR6/IjH0wPATj9uGbIP9ralPLbOpO7yX6yHhNk0EJ4q
 LUW5RWT2wNahjmZdQw67NpGMc1G8dp43MJ5ijIJyhTNxc0BFvF52LDlmLwaEjIjhDlOpBopkYs
 rvF7bQH9reFigBqaIIMkEBe/YdKZvNgeAs4KlGeHhNOKipCX0qMTMq7963EnypC7HH2Y36hEVH
 HSkG7u7f1KNnlNue/Lzk8dFMyOeqENJB+2Q+NN3ajrt7qVZg66JG8vDkA+eW4z8sIM44StooQ9
 M5c=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:49 -0700
IronPort-SDR: VYA9BgUUDr4sRMMfeFHmoTvJAnU8njSRM2w2NjoxJH3Cs70Kv8EJ/NbwobjN2EMuJHAYNPSu+2
 Nv24R+meZtBuzWBLMI2rGIlIum+FZJ3DzLLEATptDFEbE2+Hak6NpQWmS1jl66KjmWQRpANrQO
 SJDRkUryKsiMGPqt9zUBSBJ1Bi1cbUurM7jtK569mscScXqA2oFbNgVwXqIwxlQ2MR+O4fo2VQ
 EV+jUSVXErWdsRYtr4iObYolOTAsYF/RWA3lThvvL1VeJ33ahhyJvlra7p2jf2qsTPNoO6Xbj7
 kMw=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:39 -0700
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v2 12/19] zonefs: use __bio_add_page for adding single page to bio
Date:   Thu, 30 Mar 2023 03:43:54 -0700
Message-Id: <1b1bdd842de5f699d76191565fb2b6659aa38922.1680172791.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680172791.git.johannes.thumshirn@wdc.com>
References: <cover.1680172791.git.johannes.thumshirn@wdc.com>
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

The zonefs superblock reading code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
2.39.2

