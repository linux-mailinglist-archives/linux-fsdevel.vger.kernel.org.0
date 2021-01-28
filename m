Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B703307059
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhA1Hzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:55:40 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16178 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhA1HNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818017; x=1643354017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yNs/pnE8yDpXGswjvz9qkLYz+CA1dL9+4aNznurTKfw=;
  b=NK252EKCjEmavMNqysHryDFFX9Ab2YadUu2cK3MPGJgHY1zYv1P7lkT1
   MgQnCO3qI2yWNAupMIjndiO965MWaUwC9NmgqEesWbqB96uVrmJAa+E4o
   1WIgOPWNqMnAizyMFG7cXz4Iy9hAJW9jjkGpPnucecfkNmsbOp1WLjpcz
   fZEEiNHAfS2k7HnPRCP0JxwHXiEpqDBxyZfYow2BsMn6FWaE0E4U+2CgI
   GRzhOc30AVt/t8lAGl1beEQdUF7fCNt6tObyYMUz8lYp/ZOJz38gXAe6T
   bAk7MZT0rFmw91JA2bPq7EaszndTbbrpw2kfeZGzYD/77mNXbgwk5Hyrn
   A==;
IronPort-SDR: Ex5/iAGHHr/D70S/ddSRyQZ8XO1wNJPg357Nse7n1UfrF09MRUQUagKwvOgEw9+8zi/z83DjBo
 1/lWlkQ6WrUTgGKLOnCE1gv5LWIWQLpRaJdyFl3KFvumhjlynBtRZtg0BXyHbj5IdriugPqkbW
 4TGoy/bnLzrBYbJRYcy4VTyKy3qCHFBkuGSVeKHZZ1x9TKDQvGPAtS8/QxGIUfv+JdRQNSanCA
 LX52aGomGjR7EF0yWfWiT7V2GXyaS7DM9pHUqtks+HhXn15r0GPZdlkYdmJHzHheBWOOR/nLrm
 C9Q=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158518069"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:12:26 +0800
IronPort-SDR: 5hsv9wnCP5D94GKGuwBELxnohAflNYwRHdrWm3fTf1ZJLs7K386iSwLh9HIXrSUQbmc790psCo
 gDFjHP7cqpdgLSoAhOSaUe/TCYkttE4m3zfjQlnwyfNDzA2vE0wKiQQ3PSpOi+P6EUdw9ZMkLP
 mAEjxegfsi20N9fLF+HMe2LOT4/mN6eQ7Fo+82i4FJ8ogLP7jyQAjO552e1ldRnqe/vPX/WFzA
 KelbYkoOh8/uEPeS3UMO/70/JMqqQOKDRfmbImkor7n7Mra+tVIqqFp9lNAOWA69T2QW25jjUu
 NxV8aivDCRKKy9R+rr1A5rwo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:54:44 -0800
IronPort-SDR: AXyfJ+0DzRblLd1C2a8i26F/p5ozSimYWSlSS31hVM9ZD6XicSUM+PrSEKfC1Dird0dpCST4jr
 RH8MY1sbvDVq5P84PowPihV3IFXmyzQNH7jhgBGPCvDUQHmJMRxTWJczw7haMsXH6G94Is8ChW
 3Thpc5BIBnKiKhlT74BApZ+91+Tr+DAOOck7bXVmzNs8yvwHiSmvLe1vToPqpHXLGvuEQ8CHDc
 wMtFD3vO2n6mQgoI8Yf56mEPo6oNIWF003bHhQMN3DD+ikOw4kJGblAZl7I7M30srcHVxOHbPk
 wqE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:12:26 -0800
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
Subject: [RFC PATCH 05/34] xen-blkback: use bio_new
Date:   Wed, 27 Jan 2021 23:11:04 -0800
Message-Id: <20210128071133.60335-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create a wrapper on the tio of the bio_new() named get_new_bio() & use
it in the dispatch_rw_block_io().
p
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/xen-blkback/blkback.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 9ebf53903d7b..3760278f0ee6 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1174,6 +1174,15 @@ do_block_io_op(struct xen_blkif_ring *ring, unsigned int *eoi_flags)
 
 	return more_to_do;
 }
+
+static struct bio *
+get_new_bio(struct phys_req *preq, unsigned int op, unsigned int op_flags,
+	    gfp_t gfp_mask, unsigned int nr_bvec)
+{
+	return bio_new(preq->bdev, preq->sector_number, op, op_flags, nr_bvec,
+		       gfp_mask);
+
+}
 /*
  * Transmutation of the 'struct blkif_request' to a proper 'struct bio'
  * and call the 'submit_bio' to pass it to the underlying storage.
@@ -1324,16 +1333,14 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 				     seg[i].offset) == 0)) {
 
 			int nr_iovecs = min_t(int, (nseg-i), BIO_MAX_PAGES);
-			bio = bio_alloc(GFP_KERNEL, nr_iovecs);
+			bio = get_new_bio(&preq, operation, operation_flags,
+					  GFP_KERNEL, nr_iovecs);
 			if (unlikely(bio == NULL))
 				goto fail_put_bio;
 
 			biolist[nbio++] = bio;
-			bio_set_dev(bio, preq.bdev);
 			bio->bi_private = pending_req;
 			bio->bi_end_io  = end_block_io_op;
-			bio->bi_iter.bi_sector  = preq.sector_number;
-			bio_set_op_attrs(bio, operation, operation_flags);
 		}
 
 		preq.sector_number += seg[i].nsec;
@@ -1343,15 +1350,14 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	if (!bio) {
 		BUG_ON(operation_flags != REQ_PREFLUSH);
 
-		bio = bio_alloc(GFP_KERNEL, 0);
+		bio = get_new_bio(&preq, operation, operation_flags,
+				  GFP_KERNEL, 0);
 		if (unlikely(bio == NULL))
 			goto fail_put_bio;
 
 		biolist[nbio++] = bio;
-		bio_set_dev(bio, preq.bdev);
 		bio->bi_private = pending_req;
 		bio->bi_end_io  = end_block_io_op;
-		bio_set_op_attrs(bio, operation, operation_flags);
 	}
 
 	atomic_set(&pending_req->pendcnt, nbio);
-- 
2.22.1

