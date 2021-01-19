Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C757F2FB26B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbhASF2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:28:18 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51850 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388688AbhASFLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033069; x=1642569069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SmRmSEecsPl0dNDxe5lwcfSlZzCbmw+NJIUAkJff7lg=;
  b=TTvy6az7YfZu3I6RHd9uyLCVnwXWebTAMf6S3xktUuhs2h78+C557uVM
   OXZgNjJv/UDCvBCzFeQfbVEXTWjwsOvM+wlLiXN8UA9BjePci4j0t4P41
   phrft7eVbfhtyXDCj8lo7A8of6OfMNgxv2DFo7mf9/Hcz1ROOc/dWQ7aJ
   sjlri9n9IXMxZCXufh9lcUrMV/GrBq9rB+RBN/dh2BXwLgojReARvZtdh
   qoDyg8ZTm1hovQHzy3pIMGTJL5bbZ+BsLhyh8yrsjvi2VmHkE7RpD2XL1
   ZVxncMm2bbNwqwib8zyO5q19tpa36deIcvYCjXIHeeTHQWVL3s59PjfBp
   Q==;
IronPort-SDR: kdIIt2x5PMEjTb4EGFggpfl2dYfQSP2xDtYm8mdeYH9f7qSSxJPAzzb88WjlqscRztf9vZyP+b
 vhQOor71N7fuZ/YmXovuKjf11uBcQFvNusA2qzMpBdFq+cf7QDww22iX65ytM5RuX4K7cbXjvK
 Npe4W67SABEJgoC8q6QzihocwyA2irnL2mDeWA5NH0apI8P5RftybOIQpALQclkBz0qdcMkLWn
 QHlxUgOOs3s7xwVoq8aFuBuyQPYX4HYZrBd451ytL2c0kFFHZzRQGh2SvdzQIK090J1FNiMJmF
 DL4=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157763889"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:08:14 +0800
IronPort-SDR: LRuwxLsfABgj/FCitJ0WnK7Gjvqvg6JtsxJOwfFIj2l4BDUeLDVqxwb8vvGjnII3F0zTIsz7Hg
 rNlUiU8qFPgYVZGXHuLfVWEAHJO+lSgJKLtPPd9OLxtfSHEkOJpPWoWQ77jERR+EHu+2SEdrDR
 2gck+Umd+1Ctbn6H/dAAkP5xYvUnceNTw8BphGocZ4LPmS8SKHdNy7IALc/BjWXNTwK4VP+G5Q
 Rz8YIopnF85w26xAJHC88oJJ2QoWS2RMnI7cw41qWtr1PAnqyv+ix63ozfXpfgTrp48v0vSPbG
 efVVa6oioVUBcBumGIvxib5f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:52:52 -0800
IronPort-SDR: p1tcnYwAx/l/NVCOSE++cI0sO4XNQ+lbfc67fxaPGZ0Kwcqxhdz9+u3CPNrCwOw83oDaMA1Qjm
 ESU3xmsUtmMt60eRcgdVRVFxzLHWW7CqjKNcfNh1+RIHGbsJ3Ai97YW6MaxhVDB0yLEg9IysxE
 83VZ2vSeY/l/vgDGSUb38hhYRsZT54dyq7c3WndcswTCZVlwVMvWGE4bWezbXz6r57OZtdR1bX
 3lpkUR2AIs9h1PW1353M+8ODhhBWH9ueZ25tUnouwQQq8n8IP+3JRSYVgmwudbuVJ26I/RNNul
 ogs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:08:14 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, tj@kernel.org,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 14/37] drdb: use bio_init_fields in bitmap
Date:   Mon, 18 Jan 2021 21:06:08 -0800
Message-Id: <20210119050631.57073-15-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/drbd/drbd_bitmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index df53dca5d02c..4fd9746af469 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1006,13 +1006,10 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 		bm_store_page_idx(page, page_nr);
 	} else
 		page = b->bm_pages[page_nr];
-	bio_set_dev(bio, device->ldev->md_bdev);
-	bio->bi_iter.bi_sector = on_disk_sector;
+	bio_init_fields(bio, device->ldev->md_bdev, on_disk_sector, ctx, drbd_bm_endio, 0, 0);
 	/* bio_add_page of a single page to an empty bio will always succeed,
 	 * according to api.  Do we want to assert that? */
 	bio_add_page(bio, page, len, 0);
-	bio->bi_private = ctx;
-	bio->bi_end_io = drbd_bm_endio;
 	bio_set_op_attrs(bio, op, 0);
 
 	if (drbd_insert_fault(device, (op == REQ_OP_WRITE) ? DRBD_FAULT_MD_WR : DRBD_FAULT_MD_RD)) {
-- 
2.22.1

