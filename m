Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3622FB218
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 07:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbhASFaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:30:14 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51835 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387393AbhASFMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033165; x=1642569165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pIz0KlDrHBvNvxslhciWsU5/CC3PXDNM4q2bLrt7qLQ=;
  b=EK6Om07mtsPsX5lcGjjothSUAtW7M1IKUxaC07Bz8iGxo7c9j4siQExB
   hOgY7usCANju4PRxuNGQHIVcpxOLnnbj0qKLC+awpQSYfnmj1z1yY2KCw
   37WVY2I3oAoo2vAt93/sIm/OESoIuDkrXTuQIflPK9lDnafwpIgb9fTZQ
   YPn3jFJILLLhp5WXySfg7mMmfF6KxQZpEmt0VZHer/2cD5uuwEmD31NN2
   1Izox9LfN/0I0owB7OFnQGgcf34xT8ZNvUrmfJ2dCAuEGMR168z74bcAx
   Onlmi0TsP+dO3QRhqMbPLjlt+bsFp0DYh3CG9/MjUket/t+Jv1mlhL+gJ
   Q==;
IronPort-SDR: pxW3/uINqV6zHU2F/pvax/fw568+w6NHiAX5ZCNNwW16pgt12k0eer3SR9tn+CnlqBzxY2Q+l4
 a+T0u9jioMryr0etFtm8kdRjKLPcqmumM1DBHwNMdVogvbDrC1btxdaZENJCEZsPbwBL/K+HpG
 0wezSdhDwUPjns5Qv4PZ0jczB8aHmkjomNUabu4rXKSqLzxGU8a+rcfBoJRhZnBrwv0V6WrbJC
 0GUzQ8ej6rivjAInDmLw5oF/E0yY0treRFlu0RfIbdvLH5PFh5X9HvgI5PkX0OgQt0SBxS8gFP
 Yf0=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157764024"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:09:43 +0800
IronPort-SDR: Cn/mDfYF+3nD6g5TQgarLL6ndjKo12Xmzj6gfbmrpQpyHD2L8FIryhuvLUi6jkW8u8emJA+uFv
 SZayuZFl2JsOmttpbqiD4qflg97PiKjyQbm3WIk5a4Q+h839LsixD931y1Nm9AZXY1Cncm6Uau
 UHrvZoCWb4Ak6Lvdn9Fxrczj66tC/bj9x+EIRBmuohoo3COS877xljgFkzj1TQic52cUreZwjD
 +5Fz7UvIKGtd6zU9iFEHpsGFXD0wLiQCQdWl7Fptr7LrYiUxyp/01CWL5P45AKC0XytTKVEQwt
 llmHkKnwga9VeK81uAWdqyZ6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:52:18 -0800
IronPort-SDR: LsIx6xfp3MuCvVUBKYFUM/JkQXB8Xd6FGJiWWFhsO5FF8FnRTeuKG7U5dD7Rejep3b07GmAUmb
 ESoAg9lczoALSnARXtAcLYU7nWTaUgdnl4QXBjjX2qbcRpBVzJgVyC4kwkSnttKMzqx1NypHun
 wXbjpdfkPHnx0tGuE/6+V9ou48OKFTaS8Hgad4KU+rvcDNespMF4OxFR14ESWKX7jCsiRaANAt
 Bb3pRfhPY9tW+eTbrNJrKLsm+FoQOnSPpDH4sOQAdptthLApRwVVLlrj3oL4F2Q0S3i/yr38QG
 rvI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:09:43 -0800
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
Subject: [RFC PATCH 26/37] dm log writes: use bio_init_fields
Date:   Mon, 18 Jan 2021 21:06:20 -0800
Message-Id: <20210119050631.57073-27-chaitanya.kulkarni@wdc.com>
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
 drivers/md/dm-log-writes.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index e3d35c6c9f71..35c2e0418561 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -223,11 +223,9 @@ static int write_metadata(struct log_writes_c *lc, void *entry,
 		goto error;
 	}
 	bio->bi_iter.bi_size = 0;
-	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, lc->logdev->bdev);
 	bio->bi_end_io = (sector == WRITE_LOG_SUPER_SECTOR) ?
 			  log_end_super : log_end_io;
-	bio->bi_private = lc;
+	bio_init_fields(bio, lc->logdev->bdev, sector, lc, NULL, 0, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 	page = alloc_page(GFP_KERNEL);
@@ -283,10 +281,8 @@ static int write_inline_data(struct log_writes_c *lc, void *entry,
 		}
 
 		bio->bi_iter.bi_size = 0;
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, lc->logdev->bdev);
-		bio->bi_end_io = log_end_io;
-		bio->bi_private = lc;
+		bio_init_fields(bio, lc->logdev->bdev, sector, lc, log_end_io,
+				0, 0);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		for (i = 0; i < bio_pages; i++) {
@@ -370,10 +366,8 @@ static int log_one_block(struct log_writes_c *lc,
 		goto error;
 	}
 	bio->bi_iter.bi_size = 0;
-	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, lc->logdev->bdev);
-	bio->bi_end_io = log_end_io;
-	bio->bi_private = lc;
+	bio_init_fields(bio, lc->logdev->bdev, sector, lc, log_end_io,
+			0, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 	for (i = 0; i < block->vec_cnt; i++) {
@@ -392,10 +386,7 @@ static int log_one_block(struct log_writes_c *lc,
 				goto error;
 			}
 			bio->bi_iter.bi_size = 0;
-			bio->bi_iter.bi_sector = sector;
-			bio_set_dev(bio, lc->logdev->bdev);
-			bio->bi_end_io = log_end_io;
-			bio->bi_private = lc;
+			bio_init_fields(bio, lc->logdev->bdev, sector, lc, log_end_io, 0, 0);
 			bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 			ret = bio_add_page(bio, block->vecs[i].bv_page,
-- 
2.22.1

