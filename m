Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF66CF086
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjC2RIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjC2RHg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:36 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7904D30C2;
        Wed, 29 Mar 2023 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109635; x=1711645635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tkkYPg8owa+F6WBdgLFEdkckQq2ouOP6tkr56Y/Y4Vc=;
  b=BNuOlcrz9Kf8VBjAqPMC8+DQDPB88opMCwOCoI0IfKZ7F11U+Fbc34iv
   nSssIdoBubjPJIqfPb40HGWat2Pe85q/oieQr+XoOm+0qpvfe0Q1Jfbch
   6QdircK9EVEF8H8O1R2XAjybaYpqoub3CumLUA+dhCvD3uaFQRzpHIkXu
   3pIiyCzeXkPpF4a2cWcDohOMGxzfok6eOYiw8TZ0eajEt4Jw1VkVhC7He
   qKwT6hsvjiNXMqEAXXbw/Wf/MT8AaJHZe7/b+ZNG5XE1BVhgPYKIFjzTv
   SSExXq86ByJCF902t57k+v1nw4z8RdcMStcO6PK57TRNmOpwW90rvsMHN
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092896"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:07:06 +0800
IronPort-SDR: kzhmgV/gteykBR4KCyOu29vFlCI1zwFmfOmFaR6LHMAlHrSDzsxQeLj+kqnBWd3syKfclI6xpG
 3RL9frQNeaG09kV2z9sHK8nAK2jXNNmHLBl6GvbxCymGTE3Zr8i6dH51FfWC5vZveHj+i9NP+y
 eCXdUuc5qul/cUeQ1IkyNzCF0VcECGRZ2qmQ5pg/11xlSadGX98CYbfiKzw/iSJihr3gN/pGh0
 5GcACdZSFz+WXJSZkxBfYtPBkQOrg/2+VkZz/Sy2pHOjbkS6Z6f/L2f3wb9IPlCcXZgbCb40k2
 zEE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:23:16 -0700
IronPort-SDR: BtjkC8ComN1O7uUI2Q3Yo6aG1eA7nqScdNM5LexHUYipB8t3szY5zi2i62F3kkpHkyVnHuIOGM
 Ek1ZitEwQvILodyDt/DD/P+4JSQ4FfZCzk5nYQwqhwhLdGUxHoidj3oHzHVwykM3dzMqWELiYj
 t3kpcItSpp4K3NBCUe8+FOUVxWGvOPb+JBxKANt7O1k/TIuS3Ep1qDEGkSLpmmBcrzqjxJn4El
 2r0OJA5Y8NchSO4KSKjNHUAPoqdlwW5gG7Yff3aztbuLDzUEUgexB49y05wzoFymc9aBcG688l
 mnM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:07:05 -0700
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
Subject: [PATCH 16/19] md: raid1: use __bio_add_page for adding single page to bio
Date:   Wed, 29 Mar 2023 10:06:02 -0700
Message-Id: <8758569c543389604d8a6a9460de086246fabe89.1680108414.git.johannes.thumshirn@wdc.com>
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

The sync request code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index bd7c339a84a1..c226d293992f 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2915,7 +2915,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 				 * won't fail because the vec table is big
 				 * enough to hold all these pages
 				 */
-				bio_add_page(bio, page, len, 0);
+				__bio_add_page(bio, page, len, 0);
 			}
 		}
 		nr_sectors += len>>9;
-- 
2.39.2

