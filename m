Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82C195B94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgC0Quh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 12:50:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2612 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgC0Quf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585327835; x=1616863835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kLz9W2yxC9sEv7xBmU0z7qzPmrIvu5rxo6K0NTo1D9s=;
  b=OGO8glJW9+JJB/P8BRjmDI6iiGbuwuJiXBUVL4+e1K+k7FSSPSXtyMc4
   ZpslqYh2jo3g/XMN3aq0Aqgci7vNH0nO9fIA51joab9R9iOqNtVsqA0V3
   8yKdU9q+AdYG9OXXk/bGyupRIoOaP95w4gIgRakL+Lej32tT8nVfrlmy+
   cxvk7DZhEqk92NehDXnT5NVigHA81mDzV96WjEY6acCFhAVAbeeLLJZDf
   6h7xHTAoL9Yov+THofuX0u14/DbRZtFBIPINLSe8U9xuhmBTY9+5gXXu6
   NesDZaKIdZImOvi6pl9ZEVGLjcefkQyTAvNdESNjFp/SUqP3FbMEITYu/
   w==;
IronPort-SDR: GF1L5EmPqGHR1AEmqtWVvqyhXDE7cBp2vJuGxyT38I5+pL6ADZpWYZ2BM7GnBed9tvuyu4GW9a
 3DbnvDuJJhsLIi8k5Dp1dyG9WGWvH0NLv+U0pe99lnTf72WaIRZdIja10acSZFfx0LElGpNzHT
 uvJuuL6W1fiTTpu3OvnJwdwiXTKMqSZCbGUtpho2XEA7/mXLmM+AJ7WAhKGLSqygNtFZG1tm1p
 eLEuQq5h/jZi8M8wtQ85wkjyMsRyKyeWJH9MAy3UyE4uPh+23STX5qxrfJr+mLvL/uP/WyGExL
 CoI=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242210473"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 00:50:34 +0800
IronPort-SDR: 9NtglhQzS8gDEJTSKZlIop1m6T9WGe2sprqR2x9G7AZQEgj12yEpPwa1pG4FeBhpdjiKVnd9mA
 kURuKdzauhC/F3VgApjjgJmgblw2Ek3vWJe0LVjMezCaLK/Rj3kJGB6f8V4Aq/VAUPUzlZkgGu
 /wbihKREARgR8hgJdYhHhdo5D++S31i/yBRO2X9fpXpvJ+TC5+m4lN9UETwuvH/lEoj5KdQ6FX
 rXvKchylPKpF3eHkWUnLpO1H1Jok15RMq3Fsd/qNz3EOilve6dTUGC8Zuisp0AGitGLwUzJS4Z
 2OheP3cmg0bpB1kH2zCX6d7o
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:42:09 -0700
IronPort-SDR: XNNOh8DsM4jnUZAsOUigEwHLWFZVgBnFTrTEh3NvmJF181kMsfLAVAdOwjS1nV2nnuxck7SD+0
 9aVWMPWWboVJgXZ3KNQpsO9s0DRrpmxvtxu6OAlLWP6hSpOAbzGm3GsHvm+/0EjOvuV5PKohmw
 yi0tnn4KvHJXh1YJh85QswrS+bYAyCY/T2mT/kV3D6Pf7MMnsncKQbOVzWdj6+YR00FG5HXZBJ
 KsTUQRLkFP+FOU7Q9eTBYNKYrwENJAC4TZe4ijKGAVhzCyEnZxytem6lFT8aA0RxXTyG+DX7fD
 xSo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2020 09:50:33 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 10/10] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
Date:   Sat, 28 Mar 2020 01:50:12 +0900
Message-Id: <20200327165012.34443-11-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Synchronous direct I/O to a sequential write only zone can be issued using
the new REQ_OP_ZONE_APPEND request operation. As dispatching multiple
BIOs can potentially result in reordering, we cannot support asynchronous
IO via this interface.

We also can only dispatch up to queue_max_zone_append_sectors() via the
new zone-append method and have to return a short write back to user-space
in case an IO larger than queue_max_zone_append_sectors() has been issued.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 92 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 69aee3dfb660..b5432861d62e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -20,6 +20,7 @@
 #include <linux/mman.h>
 #include <linux/sched/mm.h>
 #include <linux/crc32.h>
+#include <linux/task_io_accounting_ops.h>
 
 #include "zonefs.h"
 
@@ -582,6 +583,89 @@ static const struct iomap_dio_ops zonefs_write_dio_ops = {
 	.end_io			= zonefs_file_write_dio_end_io,
 };
 
+static void zonefs_zone_append_bio_endio(struct bio *bio)
+{
+	struct task_struct *waiter = bio->bi_private;
+
+	WRITE_ONCE(bio->bi_private, NULL);
+	blk_wake_io_task(waiter);
+
+	bio_release_pages(bio, false);
+	bio_put(bio);
+}
+
+static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	struct block_device *bdev = inode->i_sb->s_bdev;
+	ssize_t ret = 0;
+	ssize_t size;
+	struct bio *bio;
+	unsigned max;
+	int nr_pages;
+	blk_qc_t qc;
+
+	nr_pages = iov_iter_npages(from, BIO_MAX_PAGES);
+	if (!nr_pages)
+		return 0;
+
+	max = queue_max_zone_append_sectors(bdev_get_queue(bdev)) << 9;
+	max = ALIGN_DOWN(max, inode->i_sb->s_blocksize);
+	iov_iter_truncate(from, max);
+
+	bio = bio_alloc_bioset(GFP_NOFS, nr_pages, &fs_bio_set);
+	if (!bio)
+		return -ENOMEM;
+
+	bio_set_dev(bio, bdev);
+	bio->bi_iter.bi_sector = zi->i_zsector;
+	bio->bi_write_hint = iocb->ki_hint;
+	bio->bi_private = current;
+	bio->bi_end_io = zonefs_zone_append_bio_endio;
+	bio->bi_ioprio = iocb->ki_ioprio;
+	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	if (iocb->ki_flags & IOCB_DSYNC)
+		bio->bi_opf |= REQ_FUA;
+
+	ret = bio_iov_iter_get_pages(bio, from);
+	if (unlikely(ret)) {
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+		return ret;
+	}
+	size = bio->bi_iter.bi_size;
+	task_io_account_write(ret);
+
+	if (iocb->ki_flags & IOCB_HIPRI)
+		bio_set_polled(bio, iocb);
+
+	bio_get(bio);
+	qc = submit_bio(bio);
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!READ_ONCE(bio->bi_private))
+			break;
+		if (!(iocb->ki_flags & IOCB_HIPRI) ||
+		    !blk_poll(bdev_get_queue(bdev), qc, true))
+			io_schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+
+	if (unlikely(bio->bi_status))
+		ret = blk_status_to_errno(bio->bi_status);
+
+	bio_put(bio);
+
+	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
+	if (ret >= 0) {
+		iocb->ki_pos += size;
+		return size;
+	}
+
+	return ret;
+}
+
 /*
  * Handle direct writes. For sequential zone files, this is the only possible
  * write path. For these files, check that the user is issuing writes
@@ -599,6 +683,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	struct super_block *sb = inode->i_sb;
 	size_t count;
 	ssize_t ret;
+	bool sync = is_sync_kiocb(iocb);
 
 	/*
 	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT
@@ -637,8 +722,11 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 	mutex_unlock(&zi->i_truncate_mutex);
 
-	ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
-			   &zonefs_write_dio_ops, is_sync_kiocb(iocb));
+	if (sync && zi->i_ztype == ZONEFS_ZTYPE_SEQ)
+		ret = zonefs_file_dio_append(iocb, from);
+	else
+		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
+				   &zonefs_write_dio_ops, sync);
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
 		if (ret > 0)
-- 
2.24.1

