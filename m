Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67866CF08D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjC2RIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjC2RHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159AB65B3;
        Wed, 29 Mar 2023 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109638; x=1711645638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=813zYQzJ3ygRpxAxwRlfdubSOcWGUy1xvUxQHtIWz2U=;
  b=fE975ZFR/F65ORP3VK65C4IpimnfQq20lkwum/MaV5oY4uDOh2ko2HyL
   3tdFV55opmHko1XoDgIbJXoqOu+bWjlClA6TlFLLgZ71qpMjfxxhkxeT+
   fpP/KdksUpctcUkHeUzqE1PXlVv1kJyTp4n8kE1UPm0+2mp0HskncAmCx
   yKEb9GjjXbstVLhToA1OUZAIj5EVfTHGdwQSiHRiAGLeRnNE4dVD5Xkcn
   HOnTJPBSxevoVVrEe02P80okg5aSQ+ps99VX+bIDIIgFUz/T5YqRt3cAD
   wehWdITYve8fvFb46pIbPTIQ0ekAf5iENat5EDASehkPGRXCsL3iLTtpK
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092904"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:07:12 +0800
IronPort-SDR: 3BRWLB/ngjlgbGlghhUv2B88oRumIdq/HRK3rm1oI51hULpiccHglpXalHxb0PLT7mUhivyNZL
 0IpEM9xeftmoq+ru3b6z7afxxWTYROOelYJyb9NrDoJx6Z4k5RNn+AJGTvZUwatWaCEdcxH4gu
 VPLO35JvxG97TljMWm8WrPu+SL1971V2FL94HCBVX4vqt1hPW8UNV74Hf2pP1QpMaczg6fz76W
 EFf4JYuWxGpywwC1LqVMh18Oh+WkZEjZDnFkOKzlNHxqwdaAj7cJzsH4zs6ug44uLxtCSPU3W+
 Ex4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:23:21 -0700
IronPort-SDR: 5x6F8sxMltI4WaB27lEorTzv/W+x0JlN7rg04JjPfd38UU2ZZm/8DVpEHZF7Dz1SymcLD61OdU
 pMAulltziCw14vrFFK29xsFqr89kB9UbrC7cwH7R1RI8Lt7mmLGDYyj8PgO4p5chUbgRB50fDX
 pEWQG9uo914V+cwk1EfVh6hsltWKfNnh9Gqxgm0AGxlxSe7pa8UIAv+zE9lP4gByUZGpAjJ+IZ
 Lyi/Xsr9WvBwip9Y4KMe0trG46KV0zl+LFfsw1hbin01REWR95Nk66NcjalZz84eqJSVFLmHCh
 l0Q=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:07:11 -0700
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
Subject: [PATCH 18/19] dm-crypt: check if adding pages to clone bio fails
Date:   Wed, 29 Mar 2023 10:06:04 -0700
Message-Id: <beea645603eccbb045ad9bb777e05a085b91808a.1680108414.git.johannes.thumshirn@wdc.com>
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

Check if adding pages to clone bio fails and if bail out.

This way we can mark bio_add_pages as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-crypt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 3ba53dc3cc3f..19f7e087c6df 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1693,7 +1693,14 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 
 		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
 
-		bio_add_page(clone, page, len, 0);
+		if (!bio_add_page(clone, page, len, 0)) {
+			mempool_free(page, &cc->page_pool);
+			crypt_free_buffer_pages(cc, clone);
+			bio_put(clone);
+			gfp_mask |= __GFP_DIRECT_RECLAIM;
+			goto retry;
+
+		}
 
 		remaining_size -= len;
 	}
-- 
2.39.2

