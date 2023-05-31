Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EDB717F3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjEaLyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbjEaLxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:53:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21316188;
        Wed, 31 May 2023 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533973; x=1717069973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FGWqPfSW6ep3dW0Pc7XFAqv0X/wPwwa9HWdy1+kVpjQ=;
  b=lQYBRVr4dg3BaizhsnI/fZrTBi7KoSR13Z/sijrEIqgyVqI4+1p+oFTS
   NShTDqqnhmwhxys9khYAL/ov4v1/z5J/wHY0/6GAOb9QM1yZD0XBR/AM4
   xfH6NCHa+wxTAX0X/cmnZ/tZP4gBNNdDuKk/AMMW29wLSmavRnIWtZq+z
   HOXkwfhCkdib0O73aFG2r3s1SrUl7fhuNqTgP3bXIA3WgkX3qiBhCfxj1
   Vvnoy5OH4SPKB4zEUgs75Nze3vLcbkGrQamTPenLt1evlTfPj5h5OkC19
   YJundcp82qvzdqxPwfR4YJ0/dbqxVjE1MTYLnHVdWhSIGdDT3xBi2PQaP
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="230207500"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:49 +0800
IronPort-SDR: 1DpHDAz5zcnf4nPadpcrme+dc6XxlAkCtooV8ZIOutr0TvmftOpsLZn91P4NNKl8WKwuY4cjgv
 aBaordi53/FQZ8KuCENORgjqCRj4Yu723nDQFzxzEIzAx4vvKp/7M8XlPaQV14xz9cKfqjXg1K
 mn+ku3FpyOjsKcbjVMO47k9QSPz8YNI1OO5UPoWY5nSKZWNbBPMK0/KmiQAMxPOqNQ38CeadRe
 JzLnp8PoMsVB9g2vfZO+FQv9WmYBpAkBx4DFKE5woR2+f7twY27vNNhrKKArG3ldeJYl/4epHS
 wD4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:42 -0700
IronPort-SDR: uHFIf7/iHU8Czax3/d36X72QqGjG0msVMP/RSX+n0ryZbgTC/vQVTGZ34sHyh4iM5x7IyMP7EJ
 7cQG9Yw608QeZLGyP0kQIFeSZCDD8DcLwHNsm/JxZC3UnVblDfvw8IWh3MbAtONyBZjBACr8dV
 7m9L+ffLx8wwrUzS5Nw0EQLVRsl75GdHE4S7QFxRYSIaxJJ+Q94NXHETUOLN+Q12WILx5359SO
 w7g/jlWqUSxuN3ILW6qvcbufS8ZTgefKKE0a6L1aJq6XjTvn8zzXK77PIN3epTN1HJDIFj5z9X
 G6Y=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:47 -0700
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 19/20] fs: iomap: use bio_add_folio_nofail where possible
Date:   Wed, 31 May 2023 04:50:42 -0700
Message-Id: <58fa893c24c67340a63323f09a179fefdca07f2a.1685532726.git.johannes.thumshirn@wdc.com>
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

When the iomap buffered-io code can't add a folio to a bio, it allocates a
new bio and adds the folio to that one. This is done using bio_add_folio(),
but doesn't check for errors.

As adding a folio to a newly created bio can't fail, use the newly
introduced bio_add_folio_nofail() function.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77f4..0edab9deae2a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -312,7 +312,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
 		ctx->bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio(ctx->bio, folio, plen, poff);
+		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
 	}
 
 done:
@@ -539,7 +539,7 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
 
 	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
-	bio_add_folio(&bio, folio, plen, poff);
+	bio_add_folio_nofail(&bio, folio, plen, poff);
 	return submit_bio_wait(&bio);
 }
 
@@ -1582,7 +1582,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 
 	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
 		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
-		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
+		bio_add_folio_nofail(wpc->ioend->io_bio, folio, len, poff);
 	}
 
 	if (iop)
-- 
2.40.1

