Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB966D01F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjC3Kqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjC3Kpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:53 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28F76A5;
        Thu, 30 Mar 2023 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173116; x=1711709116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b77AEY+fFVaCfrBI9YuTDKawey5CeI/SslH0xXZFoZw=;
  b=eu7FIYQccOat29wxehOG+evu6b0f0Fo24y4QdUlOo8w+RuQ3PgFyST+J
   zTKhQDy/UWiCWbZRlfW7dbGIlIrZA8v60/vX12H/qmaFqUpk7YjIGNgBa
   3NR46CMmHHZ1z+v3grPQdzbKSSODujJYUeY+Uc5ODY+kAm3nn2H0mP3A2
   seEf1kXvkloKZM/DYbVUFE5/mZv1W9ijXzjcopZVDE1vPYtazWLmoD8uS
   5hudLcDo3WxL6PoMTQm4RdPKEZ4pXKVUAGBLM6nad0EoE+8F8IYq3CoEv
   o3WYOs/mMjxMGEKrcrUgCymv+e/k+ASeioQG7+/p7mf/UAta2CR6TV7Ss
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317886"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:47 +0800
IronPort-SDR: Bvufo1FPVNnraUt8RoyfEUJB/cn3DcR9sYpSQ8i7nw/YuC/NS/HsyUnqj8L9nrk55iTG/fenas
 OWYBQEGcBryRNJMywW+Y6uLuWpmfdHrYCzJTOdRLu6Wu3W6Vgz2lf9DEDpABHiDMpEzowWdIwr
 u9WVizk4dAvt9XHsWN4KRMymK4G5ujD66WL33kpG9h1auN5jy3QA5qUb8BIxEeliWCCK7pqgfq
 gCGpEhqlkyndtKEUI3qads9GC/+n2mGJuTsPPCwkbMig58aPki5Tds3jUdaqFKUWdN6BZs5KJy
 MV4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:55 -0700
IronPort-SDR: bPTbKVKtlEcHRrx/gshidhFG8cTmJ7BMiKZMBOrx7BvqKjv6JDBLA7DtLgnQ8cD5tBy5QB4Li8
 EChWA24CGnvJ2Bor2+MClUrPy+r+I5aXuZR5uVZa+29PcBU56ON0tvsmmOLEdtLGgyfwshq8on
 uLUa5y4KbY1OsCGTLPOq9tHpy9dt3I1YsfvmNS3+L0GgTwHGeuOWfftTPpLJxuguO4KUD7Csdp
 y4baPtiMCCJStynBrqY2vXX+RwLmiiCo6Jnox1p4aCnNgMOXQOiTLaht7Zdw65/ETNfesjB+DJ
 BFM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:45 -0700
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
Subject: [PATCH v2 14/19] floppy: use __bio_add_page for adding single page to bio
Date:   Thu, 30 Mar 2023 03:43:56 -0700
Message-Id: <35c82b6fbc054342cce6a2084707bf3866813f33.1680172791.git.johannes.thumshirn@wdc.com>
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

The floppy code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

