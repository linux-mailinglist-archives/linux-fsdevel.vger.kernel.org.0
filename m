Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F1B307063
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhA1H5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:57:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22258 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhA1HND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611817983; x=1643353983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Q7huJyMDOVynURh2o3jolV4xRilOq3cl8xkF29/liU=;
  b=BF656N9Md7amskVa9OhnRt/3h1JnVMpu86eJqYskPF+LqKax7r6fVHzP
   19/IA4ZNrNUnwZCe9bqDsHTiLLnCCNy4xhPY5KO98fsmEeVZJ3QeJGo/0
   YQjafx7kHo2MMEEvSGDcjawUjt6GU4i+gYGpuQB6zq/DOLgexYx141tbw
   6ozPlkWuGM44zvfRqIbGPPzwkZipdhfaVuZMnK7ni60sUXAwPkcx5bzC9
   qKXUkxhsZTZAGpy9P1boa2vXaJMWFLW/Mgf3XlBUj5uc1UCoINxsHCPqr
   8CdejfBECfeJDkX16FQPpuxfLOpsyhsHpy56oT6sbi/DgOKiGMvfHtE1m
   A==;
IronPort-SDR: vIZnkF2Czkmm3+nF5M88vV6vEUmFH522u3yLtlyjYiCT+NamsDP17XNTBpQzFGmeK8g6YBfNWS
 lh/GaT2O5YMWRSMWVVz9esscsPjiZ3H1Ngab/0oRFWYpciQX9meaNknw3eMEDQqzsTyQyKegg8
 bEVeuNjra5+epTKh4tkkWTkTX+yUWoRtDofjMYy11VFKyn6DVnqo2E4ANqwGD8fY0HHkoY4Tdi
 rbI4THhx1yPQ52r4iHACoeUSOWEOssoLNeZu301qgZXTaKppcNso9dmSv/TWOp0MrK1CTDfws3
 4ik=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158517214"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:11:57 +0800
IronPort-SDR: xYgbyLAQ5HcCHqYFed1v2HqdFeAtuF8ugd9ioDRWNeAXATeaQ56qJsRgg0dYMy8R9EzHkYHCxw
 YxXGrxu8y8M98gONOgYP2L/1S3B+xeKwhKTWed/7mcR1BYud6C3z+4XL6SQVoOAFFMmHjk8+yl
 AcOge4vA1UukuwkonUt2Xh+9FwxCU5TX2qPmaqHgAW6sYM1K93z0XE8H7nu3c/++BX+aw+Y4If
 wLYWCWSefZ7b90CPVo+SNPlufolSEqBrVnih/6bIIgcZqGTlAew0INs9NtYPAE0C/eQFvtH276
 eEqeaEW1P0WmxTowkAf9s6J8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:56:17 -0800
IronPort-SDR: HYKG8+pmcZ9KZ4KZ0ijEvKFdi7W0dgGDXHFsWIaWNxW3zaOZulAuYVmKBU97gor6eDg6ylP5Ni
 6/ahnxe6yM79ewZwsqKvrfMjvqQiAhLVOYCtlxS8Bh1Gz/vhwXPlVRnl4SwtLQD680yYKL86EL
 o3y724i0cbqHM9ChTIb0swq0MYuYoJx+iwqVjQ/XkVzNSKEtJ8uwRbdybmRUPVMHWHGtPAl98+
 IjNd0sVxBZiY+I2eDgAQpiJ9r1dqmBNoZAqnfBCkqleNy/DSVZGKQaXDO89s0wR1FlZS/ZCSSd
 5w0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:11:57 -0800
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
Subject: [RFC PATCH 02/34] block: introduce and use bio_new
Date:   Wed, 27 Jan 2021 23:11:01 -0800
Message-Id: <20210128071133.60335-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce bio_new() helper and use it in blk-lib.c to allocate and
initialize various non-optional or semi-optional members of the bio
along with bio allocation done with bio_alloc(). Here we also calmp the
max_bvecs for bio with BIO_MAX_PAGES before we pass to bio_alloc().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c     |  6 +-----
 include/linux/bio.h | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index fb486a0bdb58..ec29415f00dd 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -14,17 +14,13 @@ struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 			sector_t sect, unsigned op, unsigned opf,
 			unsigned int nr_pages, gfp_t gfp)
 {
-	struct bio *new = bio_alloc(gfp, nr_pages);
+	struct bio *new = bio_new(bdev, sect, op, opf, gfp, nr_pages);
 
 	if (bio) {
 		bio_chain(bio, new);
 		submit_bio(bio);
 	}
 
-	new->bi_iter.bi_sector = sect;
-	bio_set_dev(new, bdev);
-	bio_set_op_attrs(new, op, opf);
-
 	return new;
 }
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c74857cf1252..2a09ba100546 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -826,5 +826,30 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 	if (!is_sync_kiocb(kiocb))
 		bio->bi_opf |= REQ_NOWAIT;
 }
+/**
+ * bio_new -	allcate and initialize new bio
+ * @bdev:	blockdev to issue discard for
+ * @sector:	start sector
+ * @op:		REQ_OP_XXX from enum req_opf
+ * @op_flags:	REQ_XXX from enum req_flag_bits
+ * @max_bvecs:	maximum bvec to be allocated for this bio
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ *
+ * Description:
+ *    Allocates, initializes common members, and returns a new bio.
+ */
+static inline struct bio *bio_new(struct block_device *bdev, sector_t sector,
+				  unsigned int op, unsigned int op_flags,
+				  unsigned int max_bvecs, gfp_t gfp_mask)
+{
+	unsigned nr_bvec = clamp_t(unsigned int, max_bvecs, 0, BIO_MAX_PAGES);
+	struct bio *bio = bio_alloc(gfp_mask, nr_bvec);
+
+	bio_set_dev(bio, bdev);
+	bio->bi_iter.bi_sector = sector;
+	bio_set_op_attrs(bio, op, op_flags);
+
+	return bio;
+}
 
 #endif /* __LINUX_BIO_H */
-- 
2.22.1

