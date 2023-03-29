Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E310C6CF078
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjC2RIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjC2RHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:33 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D450729D;
        Wed, 29 Mar 2023 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109627; x=1711645627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aE/Ow89gy2yLxstCkn4viK+sWgyzq7OT7iYTFC2IcIM=;
  b=Ngri4BRWEzxSrD7ArdLtiJzCT04+HxdAbrRp9bsrMzFgalZypP7r8YY7
   Ib39tZtJwg3OcOPjtn6tgc4CRd/Gt7p9NYvFqsVT8uOAOXwS+1VDmvhbN
   KSB8S97rsxlTSpZa3pYSdL9lT25XnegM2B2trnOjG0HAU3W/+KkHl79xk
   ncG0iHiqeYwhyzj+EDl2/nQhcE7ry3Cv1KNU/iGywqQShX2H2fFt2bEht
   eIlqdqDXZNt7RGCniaONc2s3lkU5rNGbXHIImp2GNNtik71ZuFGGVGtdK
   Vzxi1LfoydObInuMBmVjOJpFmJTwfEm1H+IJuvjHElOoHr/s0p9c788Vy
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092893"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:07:00 +0800
IronPort-SDR: SmOfLdxTg7tXkxrPJNzuwTBgbHJ4pDRGj3pwT6mLCjOutdeFDv/Xuz1FrcmPSypahfybVnNV3c
 MNd7JBOnuDsR2gpWw+lI9HyPtoBDlkVicNiSXolJRqx32STiNsok76bzJUj8xtM7k32+cQjxdu
 D+67ULKenlp3VDbXVwBwiSAkCWVMBAgn3yvHeNLJZrUCP8KwXe1OuAkHH9ZnLBCQQktI0i5oJm
 wubdtTPDt6DNkWB18NHSAUzBLHaOXsOpiza3V9sBLvNIdgkJIaprG2ivs+XGu8eIqG8ofjn9w3
 oAY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:23:10 -0700
IronPort-SDR: U5CGYwW7Mew4WMH5XhHkS/wuvmKwsV1daJfGn7mZ+KLy/D/2KzvAdqeW79QUzxkDDWCslNWS+3
 hfvcVA5xa6rhSLDzb3KfH/lUhdr07i4tMiJaXo9yDb7M099aYD7m8SSm1/TGzyiWeuthdMo6G4
 1dqWHhFwukM6o56/rWlCzBDM8Yn4tgV0RKs3pHn6poLpoeq6m4TkzOJgNZqdXwKHDt6xdkbOI+
 GotM7nHfSGcs2b2MrRQzeYXxRBWgESDZAFW7lZj9grqtdnnN4x1FPIawAtJPMCytnEQx+jwiWl
 t5c=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:07:00 -0700
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
Subject: [PATCH 14/19] floppy: use __bio_add_page for adding single page to bio
Date:   Wed, 29 Mar 2023 10:06:00 -0700
Message-Id: <aeff063d2f56092df8cae0a6e9c1a8e771994407.1680108414.git.johannes.thumshirn@wdc.com>
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

The floppy code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 487840e3564d..6f46a30f7c36 100644
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
2.39.2

