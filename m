Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847BF6CF092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjC2RIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjC2RHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE7D6A6D;
        Wed, 29 Mar 2023 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109637; x=1711645637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I1IOtKJu7Qm2q7N0lw4Ylfd8zAyg7sJl8PUDn+a8a0Q=;
  b=BxcEsiafbTJ78qOtUsxgE6FbboxIwBJYRjCVv3K6nRhAhdq5MocKyLG6
   YRwVVmsQh524CUUm309/aIVJs8uE0TkYkYI/w0LUx+ryleV80Vedz7zWf
   NfqfeLUWU9xZ5g7TNn01KUpYGXSJBPQJDlTXO72e8/ZmVNrNYjh6R97nL
   rZ/sv900YBjdopXQI5+NB4AIBTvy7EQCEQyb7P0GQ7TKix1X42KthPNc3
   RPEuoCvJDAoF0/pF+99nt66iVmAbUg8H0vY6KBlh9fxuqwAsggLr3OhSc
   uoi0RDLBM9xHBhGhAgSu8MpG1nSBo3djmAmBmOMj951bfIzh4u9m4BFQo
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092900"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:07:09 +0800
IronPort-SDR: lWhZL1gPcoc0XpXcwNT1Dj3xK3ZEwij+jJPLIStpIjclKtK4+iAdVxuEBRKCzyQhkEdqpF/t1p
 Cl89VXRbdtDosWnr9I9vcbT63gkSL8vsFBuscAgoYFEUyI7+640bf1CtfD9aeqHHelu4sZUpx5
 UUKMuqkejrDsrXun5cUkq39gHkb7CQUQDP/AdCT/Us27i9LOP1vn8aYE98PsuaoaJm4/9jfTK8
 sfId/zV3yeRymDt/TPqkErN5x2xN10ZfMgS8pPHHpl1BorHkL7HDx97MjKBtFWEeEuq2fny4ml
 7SU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:23:18 -0700
IronPort-SDR: viCEK69jTCbLVPYfSPHd/6CBJALlqph49HjUR1colbGaK0Lgbfrebvo8dwmNEmOHMHTZRkfRQB
 vvHWoJpYznlCku1pvW+JJdGG7HzrUkK08/8VC9+32lQr+nLMcEMoNPch20WVqgI3us1Vxa+4Ca
 C6Ko1isbeJ080GTeYV4qNaRBsBV8XLQ6lMr+xyFq9eqWcHMYCbmZbt6NVCkNrT5F3zDoUBT4ZW
 fFd3cyh6qwWEcmkuDYxsFiuAvwvdEKoHMo6Gz1nS4Cl/UXPxkpMxZvew6C33popOLndwg3upAA
 xww=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:07:08 -0700
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
Subject: [PATCH 17/19] md: raid1: check if adding pages to resync bio fails
Date:   Wed, 29 Mar 2023 10:06:03 -0700
Message-Id: <e2f96e539befa4f9d57f19ff1fc26cfc0d109435.1680108414.git.johannes.thumshirn@wdc.com>
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

Check if adding pages to resync bio fails and if bail out.

As the comment above suggests this cannot happen, WARN if it actually
happens.

This way we can mark bio_add_pages as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid1-10.c |  7 ++++++-
 drivers/md/raid10.c   | 12 ++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index e61f6cad4e08..c21b6c168751 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -105,7 +105,12 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
 		 * won't fail because the vec table is big
 		 * enough to hold all these pages
 		 */
-		bio_add_page(bio, page, len, 0);
+		if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
+			bio->bi_status = BLK_STS_RESOURCE;
+			bio_endio(bio);
+			return;
+		}
+
 		size -= len;
 	} while (idx++ < RESYNC_PAGES && size > 0);
 }
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6c66357f92f5..5682dba52fd3 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3808,7 +3808,11 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			 * won't fail because the vec table is big enough
 			 * to hold all these pages
 			 */
-			bio_add_page(bio, page, len, 0);
+			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
+				bio->bi_status = BLK_STS_RESOURCE;
+				bio_endio(bio);
+				goto giveup;
+			}
 		}
 		nr_sectors += len>>9;
 		sector_nr += len>>9;
@@ -4989,7 +4993,11 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 			 * won't fail because the vec table is big enough
 			 * to hold all these pages
 			 */
-			bio_add_page(bio, page, len, 0);
+			if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
+				bio->bi_status = BLK_STS_RESOURCE;
+				bio_endio(bio);
+				return sectors_done; /* XXX: is this correct? */
+			}
 		}
 		sector_nr += len >> 9;
 		nr_sectors += len >> 9;
-- 
2.39.2

