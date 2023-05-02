Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C16F4184
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjEBKY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjEBKXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:23:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B165FF4;
        Tue,  2 May 2023 03:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022926; x=1714558926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6dks1limiAqVSjbOuL3QnwGTUxz1Vyw7q9Fmd54YaII=;
  b=rFmz4DSvx3+57OgXnKBhzNYUexIpBdd1QLCz+2hBfqY7k0SDFALhxeIW
   sxODHNCEzknV2K2kQeFRUxQgaVqdgzwLKHsGed1ABWdSvAsSCu3xGzz57
   ugApZBwCp/LP1WHZx1Gyjjjdwj5niDvhwKcY7cyt5Uy8y48jJzTCNFpNq
   qkb/D9WywPhoQO5rrkyiLdy5EholkhfLR0oJ3OCV3laI1AGPws0K58umf
   c+m6XbGKbZnV2NZHsMk4eGHk/FBc7T7BIpHlU4zEPMy0SPnIc4vjyAQVR
   rVpYqEaXHJ/Vo6CEIv/ZRCsWNRFXVGc44wPa7kCgYz0qUp7zLb/KZanmq
   g==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="227916345"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:22:04 +0800
IronPort-SDR: m8gUzhj5KHBPwAypCzJvWCuJ2XP1g3YvSJDxZ42EdszMNXUSrEvPuxW1VYMoAzXJOuU3eQACyh
 rV/pAzEIs5jq/T2AD2vtYsKwjo36ZSy9G61ADJosFmLsPuCNV7Fra4rd9aHNaD4Bt43mcSanQc
 r1BBro7ivCFBxT6vkR++ZR1Z6SdMQLWjPoZ3MANjGguAOxpiip7fzwXJH0LFUhE/FsImkLVrZ5
 M2DQzv2QPLsZqtxwqZeHqdDCjvVMtYCpk8/FZVO5i8f1rZ7BZYAX9jQyzfDVMwuCRawu2KroP1
 5sQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:52 -0700
IronPort-SDR: TXRvj4xGS7bs358T8JG44prCEdQDntGn6p0l+szUnQQoKJ/zDUjD7hIPnB3WnqR6eTNxy9YLTk
 XRVgfqPge2tLXX9S3JBmh6cFtTa0a693VSeDeLsqNSigQnxtFdohY1ax9DQgKdHPBtM4lfEiTv
 Zjg5Y/0Mwg7HWndmnbK/j/QEahj/maRXY3CFUHrYGs0T63rGwDf3VFa2xZKPr+8lNUgMWnCebU
 hTXKsOGNGJGduWGl5A13GiLONk3DA+8Ged0SvyX7QurqVHjtBsMs2BE1hlpq5qA4aMSbZ6U+Xr
 NI8=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:21:59 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     "axboe @ kernel . dk" <axboe@kernel.dk>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        damien.lemoal@wdc.com, dm-devel@redhat.com, hare@suse.de,
        hch@lst.de, jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-raid@vger.kernel.org,
        ming.lei@redhat.com, rpeterso@redhat.com, shaggy@kernel.org,
        snitzer@kernel.org, song@kernel.org, willy@infradead.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 19/20] fs: iomap: use __bio_add_folio where possible
Date:   Tue,  2 May 2023 12:19:33 +0200
Message-Id: <20230502101934.24901-20-johannes.thumshirn@wdc.com>
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

When the iomap buffered-io code can't add a folio to a bio, it allocates a
new bio and adds the folio to that one. This is done using bio_add_folio(),
but doesn't check for errors.

As adding a folio to a newly created bio can't fail, use the newly
introduced __bio_add_folio() function.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77f4..42c5fc0ad329 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -312,7 +312,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
 		ctx->bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio(ctx->bio, folio, plen, poff);
+		__bio_add_folio(ctx->bio, folio, plen, poff);
 	}
 
 done:
@@ -539,7 +539,7 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
 
 	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
-	bio_add_folio(&bio, folio, plen, poff);
+	__bio_add_folio(&bio, folio, plen, poff);
 	return submit_bio_wait(&bio);
 }
 
@@ -1582,7 +1582,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 
 	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
 		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
-		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
+		__bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
 	}
 
 	if (iop)
-- 
2.40.0

