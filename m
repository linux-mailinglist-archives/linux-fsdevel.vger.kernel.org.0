Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7C6D0204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjC3Kq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjC3Kp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10589ECE;
        Thu, 30 Mar 2023 03:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173119; x=1711709119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x03Tj5t21oFBp5hacmwnIhr612M3UR5L9WbzmUXqvTI=;
  b=pn5rPW1skTrOnPTfQLMSopMVEt+UoGgEN6d55WvYLvfToFcwxNCgXtRI
   3XjY9M5rNlpXtNiVE6HkzciLYkPCuya/HjguAh/Mu6FZuI4yCYvd7N2aJ
   Q6LGbeu/1DnxRVhKB1darIQbeqRMdQ4nVc9JFvWEsduNMki1+Fr5VCe9/
   BaMSG6ZK3eKzyB3zRUtUeTkbP5d5HAXaQ6TSgBTdsoSWyaK+Cmx1zjZC6
   cK+a3dYi4e+1VfKJ29W4Jhn9u5009VVY4PZ1b5AjTlHrOC1wtLdwAPHR+
   aTqjk8+f5t35NwFYOCMFR32unLo5RzuDMpk56Flr49oXplYUxEj6GTKM8
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317919"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:56 +0800
IronPort-SDR: esjwb1AF1lGJtq2Jpo1vK3ciIT2sdFcljrK8Mi1pV3lmka4o97Pi0SI6mMY2XqkhjLjk0nzsfj
 9A//Nl7OnhKdVaRnFfJkXDc5+Y3VUos9wmo5uxCzP5SBCQHSrF9nqXfrVA+f+54lNRc1TywnH6
 xirxY4vSiuZVSqgwIO3w5rctoYSbaHJZ5ZHjrgvomxuHL56qn/zYqYt+yScfiTH+7NLGnhCRaB
 mQOwrjymLuVfQeykwQSOFjIPbzpHQmfci+8eBKAF3C93GDVYskUnnX3If90r6NIonXBu+3UzHE
 JZg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:01:04 -0700
IronPort-SDR: 8tspoTXpxzHmClJsQZ5bC1hIVYMWR7fxHmL7Ag12bGN2b1vX5dZznqIk1xwQtM6kCQBYt4ri9+
 uDLHirIHJ+4DA1NFYYbUnI8BA/QPlErIYOwpzv98UE2BAm7hitWSquPo0TfsDDIyCATLOL07Nu
 HLS4fBI0QUHTKCNPkR12ymqUtn6Ain+2OW6y6kseY1SYoKAuFCRZt7zXjgTS1iH20DB1vpnG2p
 B++q/+YMWpsASXZesODVp5hf2KtcEe8sIoFQNuEb+V8X1xKBHnSJ33ZRqIMSCLLhRGlFncgf4R
 lH8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:54 -0700
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
Subject: [PATCH v2 17/19] md: raid1: check if adding pages to resync bio fails
Date:   Thu, 30 Mar 2023 03:43:59 -0700
Message-Id: <8b8a3bb2db8c5183ef36c1810f2ac776ac526327.1680172791.git.johannes.thumshirn@wdc.com>
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

Check if adding pages to resync bio fails and if bail out.

As the comment above suggests this cannot happen, WARN if it actually
happens.

This way we can mark bio_add_pages as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

