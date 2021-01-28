Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909E4307054
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhA1HNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:13:04 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56944 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhA1HMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611817972; x=1643353972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eWet3+GOqUNRw+dCyihtl3LTOeV3gTTJDd7Ea4w+clg=;
  b=Z/Q/cUp0WjHW0/lDDrnZrBSMEvXgwTaDGuz0J9tHZJUsGZFzV7s1108c
   S+9Ktd9IqfC4q8MEMKcUwP8pIiborwfE9f55DmOJzEoA2z+9z2UbHCBHW
   lkGBCiCFTlmGDqwnfnUjHFnUhYv9oBsGNXlag10HfGuWulMoq7Ph842RM
   zVDc6WugewgZuzmJUqmzZJb1uYjnG19Go7dyNwG9aSVkpSkuHtgoe/ZLn
   PgI3M2TkDt+BpysBa6La2LsyzVaiMP1Uw1BiqcVYOR91qAL88gzALLVhH
   lklyx3edGIKGPCXfi4RNYbtS7zpRL4xO8FVcPmX2fOmlQIcWx+cUyvVg6
   Q==;
IronPort-SDR: ikNxmrVd4pwwh9DAjzr/LPzb+8iZpOWSAf7j1UmN+9YPo/Q9Hgwj9iv8q63yUqErhhbmn3Ohb1
 BIe+r6fj+Q0NyBetUFvZ+s1CHpwD1hX0j3aMVTHtWxtetANKcESVkceh9Zscoqq3M0xJsz8gPc
 BbnHAeVrltkIOPxDicfZXoHByODQzD3BzQ/I33bhmbWGOBipy6qy6LeIR4yvKMX+4UMDIcWOY1
 DzgKH9EXYhfAldCiM3Schs9DOEW8pLjJG2lETbz3kEikUjv49plpcm9cRt1ekRoYYQmvhjfAsg
 0Ww=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="162963087"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:11:47 +0800
IronPort-SDR: CXLJyjvTh2ozBl0J0n3M4HTJHZaOclzT/km/bBWAGtt9xOPAeCc3hLIeKdi+Dc/On1SogoRxoU
 EMMcGWgpUm5mk+9NMMMxvPjZxf7VfSUqVBGSfi5qQjym9Vz0j3F5DspBQQpxCLeJ+5+Uf9ywWc
 wb+xVHjIHBeHee4O0H7pPo8wUu19sXKcfCThMlKQx0s2unmCSBIKccvZzm9Gc9C/j10PEMJSjP
 SUINTY43+C6IN75F5uccJvtsTWMn9BklriausM1MKzr8/ixMeOJxaforDPXXe56NSl346LNYnX
 QBGAd3szpraHEF9bnD1PB8uA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:54:05 -0800
IronPort-SDR: UO027L+w2LmrSv+r4jHc7V6MfhclxochZ4q/gKoOnHb/alTZT7F9/4KjZrNCZAKJPJHjEl8zjQ
 btfDHq8ntGB6arYkxikoGObA79gqCi3nJZAFBbpTjKtHzOWqNheZit1SHeKrnOkOlZqda10wHA
 lKzVa+peWlZiSXNoZnitf2s3YH424/Lf6Od0Q5TvGZLxtIxoLSsxIGie29rcLN/atLab1ULG9S
 UmjXPLLRWItiporouoLkwAzUh8fELyClcBeyT3S1PWdOuFAmZ6ShYxhRystXSbBeBsPW0LixEL
 geY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:11:46 -0800
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
Subject: [RFC PATCH 01/34] block: move common code into blk_next_bio()
Date:   Wed, 27 Jan 2021 23:11:00 -0800
Message-Id: <20210128071133.60335-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

blk_next_bio() is the central function which allocates the bios for
discard, write-same, write-zeroes and zone-mgmt. The initialization of
various bio members is duplicated in disacrd, write-same, write-zeores.
In this preparation patch we add bdev, sector, op, and opf arguments to
the blk_next_bio() to reduce the duplication. 

In the next patch we introduce bio_new(), this prepration patch allows
us to call it inside blk_next_bio().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c   | 36 +++++++++++++++---------------------
 block/blk-zoned.c |  4 +---
 block/blk.h       |  5 +++--
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 752f9c722062..fb486a0bdb58 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -10,7 +10,9 @@
 
 #include "blk.h"
 
-struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
+struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
+			sector_t sect, unsigned op, unsigned opf,
+			unsigned int nr_pages, gfp_t gfp)
 {
 	struct bio *new = bio_alloc(gfp, nr_pages);
 
@@ -19,6 +21,10 @@ struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
 		submit_bio(bio);
 	}
 
+	new->bi_iter.bi_sector = sect;
+	bio_set_dev(new, bdev);
+	bio_set_op_attrs(new, op, opf);
+
 	return new;
 }
 
@@ -94,11 +100,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
 
-		bio = blk_next_bio(bio, 0, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
-		bio_set_op_attrs(bio, op, 0);
-
+		bio = blk_next_bio(bio, bdev, sector, op, 0, 0, gfp_mask);
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
 		nr_sects -= req_sects;
@@ -168,6 +170,7 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	unsigned int max_write_same_sectors;
+	unsigned int op = REQ_OP_WRITE_SAME;
 	struct bio *bio = *biop;
 	sector_t bs_mask;
 
@@ -188,14 +191,11 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	max_write_same_sectors = bio_allowed_max_sectors(q);
 
 	while (nr_sects) {
-		bio = blk_next_bio(bio, 1, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
+		bio = blk_next_bio(bio, bdev, sector, op, 0, 1, gfp_mask);
 		bio->bi_vcnt = 1;
 		bio->bi_io_vec->bv_page = page;
 		bio->bi_io_vec->bv_offset = 0;
 		bio->bi_io_vec->bv_len = bdev_logical_block_size(bdev);
-		bio_set_op_attrs(bio, REQ_OP_WRITE_SAME, 0);
 
 		if (nr_sects > max_write_same_sectors) {
 			bio->bi_iter.bi_size = max_write_same_sectors << 9;
@@ -249,7 +249,9 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 {
 	struct bio *bio = *biop;
 	unsigned int max_write_zeroes_sectors;
+	unsigned int op = REQ_OP_WRITE_ZEROES;
 	struct request_queue *q = bdev_get_queue(bdev);
+	unsigned int opf = flags & BLKDEV_ZERO_NOUNMAP ? REQ_NOUNMAP : 0;
 
 	if (!q)
 		return -ENXIO;
@@ -264,13 +266,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		return -EOPNOTSUPP;
 
 	while (nr_sects) {
-		bio = blk_next_bio(bio, 0, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
-		bio->bi_opf = REQ_OP_WRITE_ZEROES;
-		if (flags & BLKDEV_ZERO_NOUNMAP)
-			bio->bi_opf |= REQ_NOUNMAP;
-
+		bio = blk_next_bio(bio, bdev, sector, op, opf, 0, gfp_mask);
 		if (nr_sects > max_write_zeroes_sectors) {
 			bio->bi_iter.bi_size = max_write_zeroes_sectors << 9;
 			nr_sects -= max_write_zeroes_sectors;
@@ -303,6 +299,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop)
 {
+	unsigned int nr_pages = __blkdev_sectors_to_bio_pages(nr_sects);
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
 	int bi_size = 0;
@@ -315,11 +312,8 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		return -EPERM;
 
 	while (nr_sects != 0) {
-		bio = blk_next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
+		bio = blk_next_bio(bio, bdev, sector, REQ_OP_WRITE, 0, nr_pages,
 				   gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		while (nr_sects != 0) {
 			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7a68b6e4300c..68e77628348d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -231,8 +231,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 		return -EINVAL;
 
 	while (sector < end_sector) {
-		bio = blk_next_bio(bio, 0, gfp_mask);
-		bio_set_dev(bio, bdev);
+		bio = blk_next_bio(bio, bdev, 0 , op, REQ_SYNC, 0, gfp_mask);
 
 		/*
 		 * Special case for the zone reset operation that reset all
@@ -244,7 +243,6 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 			break;
 		}
 
-		bio->bi_opf = op | REQ_SYNC;
 		bio->bi_iter.bi_sector = sector;
 		sector += zone_sectors;
 
diff --git a/block/blk.h b/block/blk.h
index 0198335c5838..0a278bae5478 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -329,8 +329,9 @@ extern int blk_iolatency_init(struct request_queue *q);
 static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
 #endif
 
-struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
-
+struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
+			sector_t sect, unsigned op, unsigned opf,
+			unsigned int nr_pages, gfp_t gfp);
 #ifdef CONFIG_BLK_DEV_ZONED
 void blk_queue_free_zone_bitmaps(struct request_queue *q);
 #else
-- 
2.22.1

