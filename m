Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B15306FFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhA1Hpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:45:55 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20080 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhA1HOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818089; x=1643354089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A6gWT2+anXyYq2Hv6qVI+iojoFiSM9Vb51ZpjBpkhPc=;
  b=HOzN5pKdkumT2FJo2J/tig39sJx6w7CEMbe6pziWQOUboFnvP/SJebzX
   jhzxOmw53h4Ad1fNvVQ1fiDxNnKl5De/ETs4cdIjSW7xXJmJy5omEjQyS
   4X43q2kFfHdbUuoBOQ9+XrAkBH4BYSg8EuPbMjh4W38kWlZKP+1r2o9PN
   PzG7M8STSUYY6gTrHbacWNCO404ea3OulaITdIn47WUnkXdjxH7lDDU7y
   E1xipVtBrS9N57ArwqTwOaGnIlQt+W/BqvdhH1JY3rU7FP0R1N5pxR4v+
   24UkFH21SOV82ApUjSIsyOcCaX5PXBqvx4yfVockXLaKJcSkqKqjYK1yi
   g==;
IronPort-SDR: qJO5EXhgIfOp+XHylgjWMMWVbVbOPFTnD2f0wIWZU9tjYCfiINvV/PqHPurs1lQXPzIhd6jMKr
 GD0yjtYRRt8GXxYjheBtysNIRMojdX3vCWFVx8AZbt//bzakwrCtMM0OVuF9cisK/ezM37UFBm
 3MLkM/mJxa4UbxIUUnin/PQvJUYry0kaYTk6ZjGM/3gMsMswH9tCvmZKsvzEBjr0dZlVWK1h3a
 Y9Vd328j6SfbdMgPjsScY9ohWJVCcfTQFL+rnxkD4WB0dEF5Q3fx9jhexpk4uSFsca1m7+1nma
 2Vw=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="159693785"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:12:45 +0800
IronPort-SDR: +mQ1b8XZKjieu9xk4bfPfW8WnepPtUTGi2ybxfYFxPgAtMWuqK7bHGy7RDFTvJ3Vdl1D2cbwxW
 yqC5yigDXPCpLRrkGG75ZymXL4EgyPkpRsT6f1yrzHXLTqqxrlLQPc55hh3ncImiiszFP7laiQ
 c7czZjFiwf0pY6eiXsJEHbbTyRAdYPWT0hdveBSLSrK7B0JOQkvZjZfPG9KrE/f3HzGUIG1DPS
 wwo6O08F2gkIeisD9Mtc6Q8SINhsSEhqGg2oPnAT6xWgUvDZri1alnCEe59rKQ5CEN4ovrq02G
 E5oUK0nX8oA+LlYCNe9jelkd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:55:03 -0800
IronPort-SDR: iX0HhBu+61xFa7EtRWB17G0RFoDdFxtABLHP5yHe733z1qMOeQszsqPYXIq64MFQkReY48/RWk
 FOClHc2dhNxuRM1QyLpF0KtQrhnCpVvcpPgq0B9OecXrJpCL8UYdCuDWFTL9LdxFS6qWHXh51B
 DNrP6xQEwjJPm/GL/W/Mv5XtvThzXYCRCRRzvICfBStun4/LN576oOtiFYHwzWMShhTX3BjqKf
 c8icNJold/1bdh3xf4xqkQcFwP0TJ4M2AqZVo41MRst8Lsv9bfR6qeue7iMnlhLF3vJJuSRBwu
 WXg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:12:45 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, agk@redhat.com,
        snitzer@redhat.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        ebiggers@kernel.org, djwong@kernel.org, shaggy@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        hare@suse.de, gustavoars@kernel.org, tiwai@suse.de,
        alex.shi@linux.alibaba.com, asml.silence@gmail.com,
        ming.lei@redhat.com, tj@kernel.org, osandov@fb.com,
        bvanassche@acm.org, jefflexu@linux.alibaba.com
Subject: [RFC PATCH 07/34] dm: use bio_new in dm-log-writes
Date:   Wed, 27 Jan 2021 23:11:06 -0800
Message-Id: <20210128071133.60335-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/md/dm-log-writes.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index e3d35c6c9f71..7ca9af407647 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -217,18 +217,15 @@ static int write_metadata(struct log_writes_c *lc, void *entry,
 	void *ptr;
 	size_t ret;
 
-	bio = bio_alloc(GFP_KERNEL, 1);
+	bio = bio_new(lc->logdev->bdev, sector, REQ_OP_WRITE, 0, 1, GFP_KERNEL);
 	if (!bio) {
 		DMERR("Couldn't alloc log bio");
 		goto error;
 	}
 	bio->bi_iter.bi_size = 0;
-	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, lc->logdev->bdev);
 	bio->bi_end_io = (sector == WRITE_LOG_SUPER_SECTOR) ?
 			  log_end_super : log_end_io;
 	bio->bi_private = lc;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
@@ -264,7 +261,7 @@ static int write_inline_data(struct log_writes_c *lc, void *entry,
 			     size_t entrylen, void *data, size_t datalen,
 			     sector_t sector)
 {
-	int num_pages, bio_pages, pg_datalen, pg_sectorlen, i;
+	int num_pages, pg_datalen, pg_sectorlen, i;
 	struct page *page;
 	struct bio *bio;
 	size_t ret;
@@ -272,24 +269,21 @@ static int write_inline_data(struct log_writes_c *lc, void *entry,
 
 	while (datalen) {
 		num_pages = ALIGN(datalen, PAGE_SIZE) >> PAGE_SHIFT;
-		bio_pages = min(num_pages, BIO_MAX_PAGES);
 
 		atomic_inc(&lc->io_blocks);
 
-		bio = bio_alloc(GFP_KERNEL, bio_pages);
+		bio = bio_new(lc->logdev->bdev, sector, REQ_OP_WRITE, 0,
+			      num_pages, GFP_KERNEL);
 		if (!bio) {
 			DMERR("Couldn't alloc inline data bio");
 			goto error;
 		}
 
 		bio->bi_iter.bi_size = 0;
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, lc->logdev->bdev);
 		bio->bi_end_io = log_end_io;
 		bio->bi_private = lc;
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
-		for (i = 0; i < bio_pages; i++) {
+		for (i = 0; i < bio->bi_max_vecs; i++) {
 			pg_datalen = min_t(int, datalen, PAGE_SIZE);
 			pg_sectorlen = ALIGN(pg_datalen, lc->sectorsize);
 
@@ -317,7 +311,7 @@ static int write_inline_data(struct log_writes_c *lc, void *entry,
 		}
 		submit_bio(bio);
 
-		sector += bio_pages * PAGE_SECTORS;
+		sector += bio->bi_max_vecs * PAGE_SECTORS;
 	}
 	return 0;
 error_bio:
@@ -364,17 +358,15 @@ static int log_one_block(struct log_writes_c *lc,
 		goto out;
 
 	atomic_inc(&lc->io_blocks);
-	bio = bio_alloc(GFP_KERNEL, min(block->vec_cnt, BIO_MAX_PAGES));
+	bio = bio_new(lc->logdev->bdev, sector, REQ_OP_WRITE, 0,
+			block->vec_cnt, GFP_KERNEL);
 	if (!bio) {
 		DMERR("Couldn't alloc log bio");
 		goto error;
 	}
 	bio->bi_iter.bi_size = 0;
-	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, lc->logdev->bdev);
 	bio->bi_end_io = log_end_io;
 	bio->bi_private = lc;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 	for (i = 0; i < block->vec_cnt; i++) {
 		/*
@@ -386,17 +378,15 @@ static int log_one_block(struct log_writes_c *lc,
 		if (ret != block->vecs[i].bv_len) {
 			atomic_inc(&lc->io_blocks);
 			submit_bio(bio);
-			bio = bio_alloc(GFP_KERNEL, min(block->vec_cnt - i, BIO_MAX_PAGES));
+			bio = bio_new(lc->logdev->bdev, sector, REQ_OP_WRITE,
+					0, block->vec_cnt - i, GFP_KERNEL);
 			if (!bio) {
 				DMERR("Couldn't alloc log bio");
 				goto error;
 			}
 			bio->bi_iter.bi_size = 0;
-			bio->bi_iter.bi_sector = sector;
-			bio_set_dev(bio, lc->logdev->bdev);
 			bio->bi_end_io = log_end_io;
 			bio->bi_private = lc;
-			bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 			ret = bio_add_page(bio, block->vecs[i].bv_page,
 					   block->vecs[i].bv_len, 0);
-- 
2.22.1

