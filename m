Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA292FB04F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbhASFXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:23:30 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51811 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389834AbhASFH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032876; x=1642568876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZpEdbwVtPI0wVPLoSXxNauBL5CtIsv1pRUC3n0RI/T8=;
  b=RQ08hgtgbjsaEc/NjIqdiz+HXgZyCES5X29TOkQCoOtMdpU3OGNR+ZXq
   owpIEhX9i5TG/PujPBmIl4HioeOCUY9ZJxiIM9G4iUedYHqoRU4i8xD7r
   R47ESZvAyr/qGqW41V55myWI2oOj551s3Rvdwt8Z76+yS4mIw4d8t/bGu
   t75OGek8s90L7x9HrJmD8TPnvvZsQXTUr2+Mt/Nb85i3zrXLrQhUHrp2v
   7qjBWLKT7LrwRR6xvfxz140fQflG5Mj2ZCxa+nlI/E4WQ9bnqAscJGAnW
   l0e2nMfDvY1kIdyYV07+J1b1qNJi9ZSRf90LERkYC/mSb+dFYaafI7o86
   A==;
IronPort-SDR: 7b250JfhUMmv07RyLN/n/+VSCSNzF7O9pHe6QqDNllClPx/HsmrdWDQX826O9RlqR1t+o0FeU2
 3nNFZSceZBxc+aDMcwdP+dqFkMCj5kQPJYv1fzOumgTYkODSh19iDZlTgzXzIkIl4EXn+H85xz
 gDFMkA/Ic5uGB4YjCCWD8MdAfX+JR90Ngoxx17kM8pieDOeCh2XmQhzKTAODhzycVqg5moMAQL
 78vzF77Oy3BNccc/JvDu8CE40KVv1iE2giVQmFYdO/4t9SjS5FPbO3dI5Yaz8AkTk94l3Htsmd
 wck=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157763755"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:06:49 +0800
IronPort-SDR: PnLGHmRPjPv6mVfmbEJTDrsqOIAqCK5GE42P8oM4jZlpKaoSdYM+TtBl67mehGcYNisyA19sgS
 yLwLCTScdhlnnkHND2lvQFzDCcnbqO5oHieP/2DhU0SfGiHR2VSi5UBNo8L5qtweDt6D+VePPZ
 pPNMxR6viaOuZURe4jB076VeJLcyQpX+8pSZ9P1TaSQIc3p8YBehcDrmaTPMXbRArxJfcRdjPN
 w+ZRAQSYb5s6fq6Sn6wRcGzFeWcgq5QGP2XOGDsnAAmFRlkU6L8HW/TO5YqJ86+Jq4wC5wG0XV
 85gjqPbui5TRiNpxdNbbC8OF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:51:27 -0800
IronPort-SDR: XoCPpBnEyAS0C26NACpPNr6hc2mgCkBhR/slXc8vz6d3NBxAPkngsmR+924mOBWvaQi6WZHAP1
 e4hIrlRuqs07ngks51wLmgnhqz6gvPVZzt6c/xtYGHpktVNv4G+tlyQwdXjSld+DKB31WM3e0X
 o4xJZXi1ZVzEGxYUOHxoYuaGW27b5AhyEnbnJEWPqSGnvSmb4YAK4r55aDWz+qouFqxTNJ1Ve4
 MmaSi236cQpo5ubtxkwfTjN+hUw7qXvWgQEEinw8kPT9rlOQYeg6qJM9v7qJDF5MBv1NXcWrD2
 OOA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:06:49 -0800
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
Subject: [RFC PATCH 02/37] fs: use bio_init_fields in block_dev
Date:   Mon, 18 Jan 2021 21:05:56 -0800
Message-Id: <20210119050631.57073-3-chaitanya.kulkarni@wdc.com>
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
 fs/block_dev.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 3e5b02f6606c..44b992976ee5 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -239,12 +239,9 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	}
 
 	bio_init(&bio, vecs, nr_pages);
-	bio_set_dev(&bio, bdev);
-	bio.bi_iter.bi_sector = pos >> 9;
-	bio.bi_write_hint = iocb->ki_hint;
-	bio.bi_private = current;
-	bio.bi_end_io = blkdev_bio_end_io_simple;
-	bio.bi_ioprio = iocb->ki_ioprio;
+	bio_init_fields(&bio, bdev, pos >> 9, current, blkdev_bio_end_io_simple,
+			iocb->ki_ioprio, iocb->ki_hint);
+
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -390,12 +387,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		blk_start_plug(&plug);
 
 	for (;;) {
-		bio_set_dev(bio, bdev);
-		bio->bi_iter.bi_sector = pos >> 9;
-		bio->bi_write_hint = iocb->ki_hint;
-		bio->bi_private = dio;
-		bio->bi_end_io = blkdev_bio_end_io;
-		bio->bi_ioprio = iocb->ki_ioprio;
+		bio_init_fields(bio, bdev, pos >> 9, dio, blkdev_bio_end_io,
+				iocb->ki_ioprio, iocb->ki_hint);
 
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
-- 
2.22.1

