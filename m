Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2311E2FB079
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390163AbhASF2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:28:04 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40885 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731302AbhASFLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033065; x=1642569065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fhRK4lG765wlnY3VYWw46zVxpefVZCaV0gGjGdWEZQs=;
  b=R7+No9tp1XyE6QwPxFK3MylI1TBNFoHofHr8qpcAznGu+MniWOra0AGp
   rkyIjlceZL8XB3XzN1DG2hxgFIQ6D0ryjCriDP1oUWkIWXwiVjoGfczo+
   IU2PRCaT4wVq8HJWvbg6vP4qEPZ//U47QQN6t7zJ86tPUQftlBdECyBRC
   aFE0+AuKoU1VbcihAx+ngbjC1W5jDLKniOyhKQATfWPCZG99rxuQjEKGW
   I8g8dHkjefn/Sa46yqkYSbKMuXDGn52mwmeoUfGSzvAHwpOT4xmqoxXci
   9OQG84oqF+5+okUMUT6fTFrKwTLP507LJSuRSLV3b6vyQ+nmqVPJm4l3C
   g==;
IronPort-SDR: XCoOb8cAHWFBO8fTHWUT62IqlKO4mf5GxWjf+I9xwWngc0y9tc+xlUa9h8/9R7tlAHt8C4ayRP
 vGNkzi+5OfWa3GP9nQsl+R1H19QyjU7/OrbYzX+HND8hxFasSL8QEgX8N5mGg1pgEsGoYKqDml
 8ZUourU72cWSpYQui9SO0U93uw3IQHc53v63hAd/lexogRtnJMITIAvnOpGPT8Kmf1yTlebTqX
 C0NVJpho4C5g9uaZh+VZ4B4aqIMdl0MvR21YO2D3sOc/90h0Ed8wqQCMbOTjtYQ9DUCzmBz0DI
 rcU=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157758770"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:09:50 +0800
IronPort-SDR: /RxdgqlEktpFbTiaifQfI83jrfjGTwMp3JKsR5JM0iPexwja6MvIOL1Je1ACuC9nFFFMhWRZ9b
 2nMSVG1hXMC+bNvMZ+AdUmD92Rn+5K1hRkiSNe3jd7ape+eHNmi2coNSmKJKcwrBbksv+YzOW9
 jbF1ae5FXLrjhm1HTs+/U+o+2z2C8x16bpQeGzypzQhP1e1nhs2/SlyNsrRUEfJvtYKFlZM2ZO
 e3hAsOi8xhTXbxUa/fywQ/v6f173zOdonOXEPdJW6APshL7QDtdWzAM54pzLPhP85Hd1V8KmgU
 APnfLn9EmzFHNq7RhSNsR27C
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:52:25 -0800
IronPort-SDR: JLU8nMTD+NZGhpcLc6bx6NezWoOxG1kLxe+XONRlNiEvcpn5x3JxGCWrI6N+TlSlWzGV1Q0IZH
 sVnYt6tKGijbl+nT2mxOo5/rgMe/5l4KRxVV0eiBp02GobWze2qiJQgHs9JNJvbu9kV03QI256
 THC/6jLcI9qR4UKAPS2gqtOtR4DwAg8fBaFWS2YCr+JhQOYLTSPNhMAbcyMh5IWuS0/MKfxvtN
 xPuF9hOwrup1UYc8D7gXKUTo1HoUHkPFFr+UvCvYhNW2SXbqPm5T4xFixZZesNSvVigWeniTT3
 7fA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:09:50 -0800
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
Subject: [RFC PATCH 27/37] nvmet: use bio_init_fields in bdev-ns
Date:   Mon, 18 Jan 2021 21:06:21 -0800
Message-Id: <20210119050631.57073-28-chaitanya.kulkarni@wdc.com>
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
 drivers/nvme/target/io-cmd-bdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..302ec6bc2a55 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -323,9 +323,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 		return;
 
 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
-	bio_set_dev(bio, req->ns->bdev);
-	bio->bi_private = req;
-	bio->bi_end_io = nvmet_bio_done;
+	bio_init_fields(bio, req->ns->bdev, 0, req, nvmet_bio_done, 0, 0);
 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	submit_bio(bio);
-- 
2.22.1

