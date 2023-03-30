Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C087E6D01C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjC3Kpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjC3KpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF879760;
        Thu, 30 Mar 2023 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173074; x=1711709074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BUmURHFdu9KejVTyXSm50CHGFvGjlqfpSblNCpyXxd0=;
  b=Fx+u75zK3MpiEm8i67+PCrCW4tRMLIoia7s8mMq7HlC9B/otm7k7f43R
   SYBWRb5HcYv2YlRuHUM0fmyRRfuPv7GgVTe+QIAk1isS70jIWsvGxDhNc
   KCtEnyUjZ9P3ul+lKBELbLcTPmdMgJu3P6PRGKAC15yQXGsSVwvbsFuHU
   l2Y9GXm768/WPQsZrz3lNwAAG11Tlfi2OfaI9i2MH1r+WctGtA0y29Bov
   glzzrXe20uk5bGx7jFRbPgk/hTQb72z9xlWT+4M4kVpqpBTAdK5VqnNk1
   yHHB6O2RNWiv63FH/dYrGr+J9dYQvRQYzq3SkJnjTxjATz2o08lHQ8ylp
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317823"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:15 +0800
IronPort-SDR: IHAm92Wxhv+3KwieB4WAOtJd01Qev/gW2mlPlWquqgb/ikryZ6IwiBYInhk25bHnlSGPn3d5Ch
 IiUrxE6eFWxpkyvyCjFbAMzhAvxa4fgHBzo4t3z3cF3RxDps0zrx9mcIc4GuUWK0pS1mYXLbze
 1rEeCi4rSrFC0BU5X7LQPgG3WBcDHDzSALoq7D6sRWzOmGVPDhQLUHLxu4kpxUKlLAwanxJ9nQ
 2gXHbRuhT8agbOf43gzZSSl1dpF5reIKXBvImEUqi382JP/vLSwwCdmWinitE7CFspbn3RUftQ
 P6o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:23 -0700
IronPort-SDR: zqJUuuEWGvtk5ynuIvdoGSTcK/Y7DxRZqa2AqDl93PHBq8zvX3+RgmnnfgDIeH88tY2GRigaWC
 ksCV/5j5AZp1gugBzl1vz+fSlxsewSxY1IwvAF8Z1UQmeURLZPv6rUrbXBVcc6ZKqszwyeJr9U
 LQsK3/q3aYuyJzksTzLRhNklEISxCuzFF/G4VTc5KVfAu43VSgYzFZoy1iZQGI8hm4vbdG/U+b
 a9LQ6+vlvJUUlbReY3s1WU5G9fOKBxzpyEUyM461G23b/3bmRf1IU3OFcf2/9bo9XK1+73YPu+
 eEA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:12 -0700
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
Subject: [PATCH v2 03/19] dm: dm-zoned: use __bio_add_page for adding single metadata page
Date:   Thu, 30 Mar 2023 03:43:45 -0700
Message-Id: <0b8d78cb8d38e4d4e3c5b1c187c81194b6403251.1680172791.git.johannes.thumshirn@wdc.com>
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

dm-zoned uses bio_add_page() for adding a single page to a freshly created
metadata bio.

Use __bio_add_page() instead as adding a single page to a new bio is
always guaranteed to succeed.

This brings us a step closer to marking bio_add_page() __must_check

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/md/dm-zoned-metadata.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index cf9402064aba..8dbe102ab271 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -577,7 +577,7 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
-	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
+	__bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
 
 	return mblk;
@@ -728,7 +728,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
-	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
+	__bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
 
 	return 0;
@@ -752,7 +752,7 @@ static int dmz_rdwr_block(struct dmz_dev *dev, enum req_op op,
 	bio = bio_alloc(dev->bdev, 1, op | REQ_SYNC | REQ_META | REQ_PRIO,
 			GFP_NOIO);
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
+	__bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
 
-- 
2.39.2

