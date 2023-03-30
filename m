Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20236D01F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjC3KrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjC3Kpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1B93D9;
        Thu, 30 Mar 2023 03:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173118; x=1711709118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oL2U/g4EaJMTT3671h8rphk5MC+hx36IPn/aySLD9mI=;
  b=M2luVLf/rze41HLKfAYETeN9TVZTJdaqNTYEYRlRGY4WmlZT1jEg04Cy
   bqgE8YkhoM1+81oqOoDp6bcFvnY7Aa9nP8dCN7eqBsrKDvQUvHPtJ7qLX
   PdkHbfTodG7MByUj3uDClW9+2XY4C5d28ywKc2oP/wEkwIAFpKQxZEpTM
   mPB5F+lY38htXY+WP1kbSVj4pDnXTJmT2F/IoddAjwSX6p6hvvmCLXrt1
   tpeBZHvGUlynrWNaddjqLnSsfTBmXqGF0ZHjc2s5XpD/1N0tNrJ1X6KuL
   tyGZK/1xCnAPT5XiZaUp4FmwJ9HtcF6MOwGA7he0E5w1tUdKB37nafDa/
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317903"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:54 +0800
IronPort-SDR: i01bbHuqGAc4yQ+1ZaAJLEpeh98e591YVfnqqrZQuh0qxRF7uvw3XU+1kI1ufCpf1PKcZcozMy
 quqWlFZyKLUqkyvbQObK/Sp72aFit0qvxxIn3zj08gf4vihzNkZeuWcOrGzCMOvtcXO2jeTg+D
 aRLIJ/htAvPR44Qnjvlg4wTN80qF0WTiuFM/xVpJJesDVuWEym5ye14E+aSANPLgNOEVdMtUq+
 kXBls+KZcALL/etuDU+EhqmxVut6P8H721yaTrO4hA5tRA1i4FgnDwkxYRaQRBVuQs75fTzGIi
 JEE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:01:01 -0700
IronPort-SDR: CoMzsHiAS2JR6nHz7NkC2bnUoQ56O2VVvllRrO/O/vDND9erWG2x+0sd/n32CtrHJXq89I7Vpx
 3yXADu4Qzn1egGoPoaR5LOqXgneY+WCGslMK0kk4RtBPu9UBwrphetuapusHacgSbZc/GjpP04
 rOM2hwuQmwq0JHF9BBbZ161hAs47W3Bw7eBGyL1xrobBRYyZFBMncwXMAQ3J+2GPapCugFKR9F
 g47K64zulVURfvgH0krXU+jb73cw0ekyXDiawSnLCfzfBr1nZC/vguolrUE0Kyqh7/cxMzE5Dn
 xv4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:51 -0700
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
Subject: [PATCH v2 16/19] md: raid1: use __bio_add_page for adding single page to bio
Date:   Thu, 30 Mar 2023 03:43:58 -0700
Message-Id: <4c9eaedd34f80d3477a5049f49610a8da8859744.1680172791.git.johannes.thumshirn@wdc.com>
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

The sync request code uses bio_add_page() to add a page to a newly created bio.
bio_add_page() can fail, but the return value is never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

