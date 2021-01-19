Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17CC2FB432
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 09:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbhASFX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:23:26 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47326 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389743AbhASFHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032869; x=1642568869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDvxltQy2dTITc0BsqVzj/cnHCYvpegwiBh4lFEjP/k=;
  b=Wir5F5YopwXlsvgDcLDoZ3FKAlZ+VLjP1B1A9A8OrTqJLbXIRlORGMMp
   UVg1WXqvIQT4xVQ3p2kg9Lu3gaDv+gwJeKT0n30io6fo91Ny11jY3TmuI
   hSg5+Xva3mkzhQhkX2o/csLA0hn7A+hblPbHDmtx66Q7A7xHknzq2QNGJ
   PPbatY2dsk68/UIIy95IZymooNSEl2UOjtxUz3XAGy02oNTML/bsBJ90I
   R09Qing8/xZOcnXSTztVWHgEFLa/B7X6dIFECxaJVSc83egNvgwjfB2G2
   4Q6Lgsa2hbki1xu0dtJ410x8fgOdVoHt66TqlZH0N5DaNy939yh/KISBp
   w==;
IronPort-SDR: Nd3u0eOpJnMy1aeTSCWniaL1n3jNvOybHVlQ9X0lZVbXiYns0fw9Seh4n8aJFNGN8pxvmJs9rj
 aCecUHgq1UsGmTDdA4GhXkaoCsLeKzvXn3qdYG5xgZn+mnmWl+d8XK+kmDGYLoILWcvLKIrNfN
 /jidUSGjRic0KVmryU9fzoi8KTt5Tpi0eJoDZuiKxSEW1T1JTWkFIpkak46Z1MhkgBv2g7ylDL
 R/XmhzCEW0evABpwrGcBTnXHNtYcD5NhGrsmgRoNtvRRkP/8PLbTroXAtHq6bXUwp0ltSMMzOU
 Rvk=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="158940407"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:06:43 +0800
IronPort-SDR: bHl2h3ZxK7UAozU1UsVLBuh9gd823Lvj1Udw5BZky1lXAsx5WTijRR/JWVnWfL7NS8Q7SSBfT4
 RkYee7caNWQzO4fVyRQD4FtrSAGvTOqBq5+pe0vaOWN1rntux8iVEwg700nkPqIcsxwRJGsQhw
 ti2MNTZDVWZElTssfabASie/wTn0I1uKcB7+iLItMBzwiQXVFBHG+xQAY0Y1UFkBk2QBkquELf
 FJldlkWJuDyOlMXlkvp4WfcKA4sVGwnmMykqAQ2gxWxg2rY5DZ5VJc/DgPUpUoRCtRTHdIdGTK
 0KGgiGtKDnmaKrUQYFnS4aZG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:49:17 -0800
IronPort-SDR: +NpnU1qF6QR8N8XBneIu3ZiZvasLVseQjYJJ1MMaKJ+OglnqkmtIQug/+7v1w/r2fkDf84edQB
 DjafWMcc4nOfiH+Mk03qupgTmYSJWzjHG319wMnHdznvAZeqQCPvdsGd5DhsBkszoippTGcVSA
 HK0sa0ldtVZMuvow8gFchGX7RsHVWH4qFN2Kntl3WSC7I2G5w7F3PvWz0KvKk1ACpfqrdG9xEj
 nchAe07v2IYGlvMXlxEBOdpBs6EbbN/Fyy3RtZL7kH3VABJ8RZFvQM1pZVPOuoiP0DweMhWYKY
 mtU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:06:42 -0800
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
Subject: [RFC PATCH 01/37] block: introduce bio_init_fields() helper
Date:   Mon, 18 Jan 2021 21:05:55 -0800
Message-Id: <20210119050631.57073-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are several places in the file-system, block layer, device drivers
where struct bio members such as bdev, sector, private, end io callback,
io priority, write hints are initialized where we can use a helper
function.

This pach introduces a helper function which we use in the block lyaer
code. Subsequent patches use this function to reduce repeated code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c     | 13 +++++--------
 include/linux/bio.h | 13 +++++++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 752f9c722062..5ee488c1bcc6 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -95,8 +95,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
 
 		bio = blk_next_bio(bio, 0, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
+		bio_init_fields(bio, bdev, sector, NULL, NULL, 0, 0);
 		bio_set_op_attrs(bio, op, 0);
 
 		bio->bi_iter.bi_size = req_sects << 9;
@@ -189,8 +188,7 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 
 	while (nr_sects) {
 		bio = blk_next_bio(bio, 1, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
+		bio_init_fields(bio, bdev, sector, NULL, NULL, 0, 0);
 		bio->bi_vcnt = 1;
 		bio->bi_io_vec->bv_page = page;
 		bio->bi_io_vec->bv_offset = 0;
@@ -265,8 +263,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 
 	while (nr_sects) {
 		bio = blk_next_bio(bio, 0, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
+		bio_init_fields(bio, bdev, sector, NULL, NULL, 0, 0);
 		bio->bi_opf = REQ_OP_WRITE_ZEROES;
 		if (flags & BLKDEV_ZERO_NOUNMAP)
 			bio->bi_opf |= REQ_NOUNMAP;
@@ -317,8 +314,8 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 	while (nr_sects != 0) {
 		bio = blk_next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
 				   gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
+		bio_init_fields(bio, bdev, sector, NULL, NULL, 0, 0);
+
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		while (nr_sects != 0) {
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..fbeaa5e42a5d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -820,4 +820,17 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+static inline void bio_init_fields(struct bio *bio, struct block_device *bdev,
+				   sector_t sect, void *priv,
+				   bio_end_io_t *end_io,
+				   unsigned short prio, unsigned short whint)
+{
+	bio_set_dev(bio, bdev);
+	bio->bi_iter.bi_sector = sect;
+	bio->bi_private = priv;
+	bio->bi_end_io = end_io;
+	bio->bi_ioprio = prio;
+	bio->bi_write_hint = whint;
+}
+
 #endif /* __LINUX_BIO_H */
-- 
2.22.1

