Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7239F7167EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjE3Pvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjE3PvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:51:02 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F619D;
        Tue, 30 May 2023 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461827; x=1716997827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mcd/H07yjDNLd/X+ei4F/kInbJgAqWy0dojDfw1QWYw=;
  b=PTZkcIk0KtnwDwSQzUA7nqgARKxDH+YKYBnkqf/ALRMRXVT07PPikqN4
   KQ8IpwicrfANfCP+b8hpkuFVi3xYOdWxdx96rlvdo52GjR6Sb6E+ms7X/
   +dCch7tY8qR9g1vdsz6MMmESBoOw+V6ozahzCBYAHyL1gQD4n1yMwzLYs
   Xo5LHtuPaM1fATdmtWFp2CrXVTBlN4dWrdry4o4hEoQjd3lpejFKU67H6
   VUZD0ogC0fxxirPiGlMSEzuUF26Ayt30/PTdGEmUSfcilyW5+ckcfE/Zb
   UMDeFUyvv/ZnCROHy9wxbC26ty0bB6SIsHZ9B+zRYGpr3gHqkeid+t8jI
   A==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129895"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:50:27 +0800
IronPort-SDR: /b1ykAAFVhH83wFNIunNxpUBq+dA9OkFYUQi5w2ENBtvQ2b3t2Aqk71Zmhgw0mFwpMNU3AL9zQ
 NM+UW4CEXp8mhzA+72KM1GTZuovCTSsN7vr3Zk6vGRlmfejDGLTe7PpscqMz0duqvGqiGX/mlc
 /Gw1/02jOSJ5fOFhA1ev0VQB1ufq86isKfJCvcfNAYcEKQQebOPPGtUqCQf4lz0Z9Z2khMrN+k
 gQca11x9JayU8NzJDjP0K5Is1EHrhQ0/jI3LD6skSKpUEKj71vg0GhsX9rrXk3L2JMl32J08Hy
 K2w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:05:20 -0700
IronPort-SDR: vm077LYPjNAgf5XlpecJ/3icJc5CMvd0lv/Avf1qt9Q/GL6TJkcMXRi6IgIjrnSc7COF5QrvoM
 rybn4aIsk3ovkS/odxyg0sJi8dTutwPKjZDfzTgOQd2shRAOUl0eyZW+AxMzq0gSSpTLt0zblr
 UlT5/9heJdPYSEr71OD35L2+mnxp5yfUxAvMikvD+47W4RcDny9nyhyoPmkkZUZCDcFsZlAdtd
 Z+zkSGqfSgcxDW2nlTOB+X8K7FgyMtw8b3N4WfdZtYRGEapJ7oDAz61v2TGB77bpv7441w8fn/
 igk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:50:24 -0700
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
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 19/20] fs: iomap: use __bio_add_folio where possible
Date:   Tue, 30 May 2023 08:49:22 -0700
Message-Id: <e809b83d60d9fb0f65a8116b3e50f1432f594725.1685461490.git.johannes.thumshirn@wdc.com>
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
2.40.1

