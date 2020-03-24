Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F4A191452
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgCXPZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39917 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgCXPZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063521; x=1616599521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N2gYUUYjJCQID91tLEA8Vb3WUsG+XrUuU0x3+mUjq+M=;
  b=lW9/ASzy1tkhEUzLOitmcxp5ZEZfhaFyz2e+0wNlIXozUPWwqWsTMCmp
   N97TA4JMhWlPxSU/n0N0KSN3vfOWPu+iNZqxYJEQpz9YozfuH0ywQiSVW
   W4HDbYgcdHOn9sbCQsdFSP0AQ/hZOD4IqtepiDXWZniKIM0CsnjpLlZ+I
   dq6h4hqsH/WFxWI/UxUwidAC1sFeXH0IAk1zIVSdiIWxu8D/R7shJq+hT
   ELeCbNRHfblrvOu2TS/nMmyL8Lum3hmG6Fq0OyZbFPvF2UiKBwUHaWA/6
   d3P8kP0gYG9VicUlBz1fHfXExZv2n2a/fWZ3F7uTh6Rd5ye0R6P4wra+Z
   Q==;
IronPort-SDR: K2asqzuMyRwF/bnJvto615kI9BySC19UN3kAcqX4rbeGTmDN7kjyJZwKWNtYBQ2OFc2DWySeBy
 BbM2masyfr9gwiOExfFv0lK9iytVBZqZ7FuSK5XBDkj616p/bZlHR+bS4+Oy76TFaaka9YpZQ0
 ZhImiee5cxxKL9MiRGuuQpP4kBpnoDbb2mjbPyY+gdivc0mTlBR+U8z6TTAe7BBOBt7nfejgPk
 gBxM+WQBzhZzAb4JmB66baXygB88g2LvG3HJWM4Gh+nzg+SToAegfIXOFpkEUE8bE+z4CkV4G/
 u1Q=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371579"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:21 +0800
IronPort-SDR: zCgR61q9asZyvsis0E5RBEom5Gxp9vZm0ZGQkUHRF9CzeSVCQfL7g68wIy8BNxhDu18wFmQXne
 kKzCZvjgMwUxv/Iamn+rBfDaBLFgkey6yVp2qw92fKQFoE0jymZ+R2QGsG9U17tpyrfP+s+oiG
 HuZqf3dmH1ebn93R7QlXinwTuNpTg8eX+EIH912/wTFJ8HJEsDJzK0I6zjoWWWtKY2bg7SG9qG
 R0K+J6TgpjW/05Ly4ATkLarfcxJk+UiaFO/zcX7ToQh2i1SxPxMmmHI7Mkr3wAujs5poUFk/ri
 5gwi6XolT5hC5TbY96pVj66z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:17:01 -0700
IronPort-SDR: H1rbVJjHkvHxCF2Mr84FMgx16WIq1BvFYsVXiGaneRhvqL0yKqsg6U35UEd/A5MkCbeWL13NnG
 J5uYA9hZHNLkYYYQAJEBlIZ4M/1SGZVTKxTe3HUcl9Abe5KxECMnvGM53fnD3IV8CEKMuqFg6T
 ER6E3LIpVz5v+h5QMY0Z40WPwDxziMlut9RnEWYt9ylU/fuxWRYaWYnXuVh9vlLq96G7TOFV/C
 Dst4YorYlmq174tM7M3U+Mzkw6Qg+QCfSmJXWel5eHRBN8dGHMyHJ5HkTpc3A+Zj/NOjRISrlB
 feY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:19 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 10/11] iomap: Add support for zone append writes
Date:   Wed, 25 Mar 2020 00:24:53 +0900
Message-Id: <20200324152454.4954-11-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use REQ_OP_ZONE_APPEND for direct I/O write BIOs, instead of REQ_OP_WRITE
if the file-system requests it. The file system can make this request
by setting the new flag IOCB_ZONE_APPEND for a direct I/O kiocb before
calling iompa_dio_rw(). Using this information, this function propagates
the zone append flag using IOMAP_ZONE_APPEND to the file system
iomap_begin() method. The BIOs submitted for the zone append DIO will be
set to use the REQ_OP_ZONE_APPEND operation.

Since zone append operations cannot be split, the iomap_apply() and
iomap_dio_rw() internal loops are executed only once, which may result
in short writes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/iomap/direct-io.c  | 80 ++++++++++++++++++++++++++++++++++++-------
 include/linux/fs.h    |  1 +
 include/linux/iomap.h | 22 ++++++------
 3 files changed, 79 insertions(+), 24 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..b3e2aadce72f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -17,6 +17,7 @@
  * Private flags for iomap_dio, must not overlap with the public ones in
  * iomap.h:
  */
+#define IOMAP_DIO_ZONE_APPEND	(1 << 27)
 #define IOMAP_DIO_WRITE_FUA	(1 << 28)
 #define IOMAP_DIO_NEED_SYNC	(1 << 29)
 #define IOMAP_DIO_WRITE		(1 << 30)
@@ -39,6 +40,7 @@ struct iomap_dio {
 			struct task_struct	*waiter;
 			struct request_queue	*last_queue;
 			blk_qc_t		cookie;
+			sector_t		sector;
 		} submit;
 
 		/* used for aio completion: */
@@ -151,6 +153,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	if (bio->bi_status)
 		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
 
+	if (dio->flags & IOMAP_DIO_ZONE_APPEND)
+		dio->submit.sector = bio->bi_iter.bi_sector;
+
 	if (atomic_dec_and_test(&dio->ref)) {
 		if (dio->wait_for_completion) {
 			struct task_struct *waiter = dio->submit.waiter;
@@ -194,6 +199,21 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	iomap_dio_submit_bio(dio, iomap, bio);
 }
 
+static sector_t
+iomap_dio_bio_sector(struct iomap_dio *dio, struct iomap *iomap, loff_t pos)
+{
+	sector_t sector = iomap_sector(iomap, pos);
+
+	/*
+	 * For zone append writes, the BIO needs to point at the start of the
+	 * zone to append to.
+	 */
+	if (dio->flags & IOMAP_DIO_ZONE_APPEND)
+		sector = ALIGN_DOWN(sector, bdev_zone_sectors(iomap->bdev));
+
+	return sector;
+}
+
 static loff_t
 iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		struct iomap_dio *dio, struct iomap *iomap)
@@ -204,6 +224,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	struct bio *bio;
 	bool need_zeroout = false;
 	bool use_fua = false;
+	bool zone_append = false;
 	int nr_pages, ret = 0;
 	size_t copied = 0;
 	size_t orig_count;
@@ -235,6 +256,9 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 			use_fua = true;
 	}
 
+	if (dio->flags & IOMAP_DIO_ZONE_APPEND)
+		zone_append = true;
+
 	/*
 	 * Save the original count and trim the iter to just the extent we
 	 * are operating on right now.  The iter will be re-expanded once
@@ -266,12 +290,28 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 		bio_set_dev(bio, iomap->bdev);
-		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
+		bio->bi_iter.bi_sector = iomap_dio_bio_sector(dio, iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
+		if (dio->flags & IOMAP_DIO_WRITE) {
+			bio->bi_opf = REQ_SYNC | REQ_IDLE;
+			if (zone_append)
+				bio->bi_opf |= REQ_OP_ZONE_APPEND;
+			else
+				bio->bi_opf |= REQ_OP_WRITE;
+			if (use_fua)
+				bio->bi_opf |= REQ_FUA;
+			else
+				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
+		} else {
+			bio->bi_opf = REQ_OP_READ;
+			if (dio->flags & IOMAP_DIO_DIRTY)
+				bio_set_pages_dirty(bio);
+		}
+
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
 		if (unlikely(ret)) {
 			/*
@@ -284,19 +324,10 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 			goto zero_tail;
 		}
 
-		n = bio->bi_iter.bi_size;
-		if (dio->flags & IOMAP_DIO_WRITE) {
-			bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
-			if (use_fua)
-				bio->bi_opf |= REQ_FUA;
-			else
-				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
+		if (dio->flags & IOMAP_DIO_WRITE)
 			task_io_account_write(n);
-		} else {
-			bio->bi_opf = REQ_OP_READ;
-			if (dio->flags & IOMAP_DIO_DIRTY)
-				bio_set_pages_dirty(bio);
-		}
+
+		n = bio->bi_iter.bi_size;
 
 		dio->size += n;
 		pos += n;
@@ -304,6 +335,15 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
 		iomap_dio_submit_bio(dio, iomap, bio);
+
+		/*
+		 * Issuing multiple BIOs for a large zone append write can
+		 * result in reordering of the write fragments and to data
+		 * corruption. So always stop after the first BIO is issued.
+		 */
+		if (zone_append)
+			break;
+
 	} while (nr_pages);
 
 	/*
@@ -446,6 +486,11 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		flags |= IOMAP_WRITE;
 		dio->flags |= IOMAP_DIO_WRITE;
 
+		if (iocb->ki_flags & IOCB_ZONE_APPEND) {
+			flags |= IOMAP_ZONE_APPEND;
+			dio->flags |= IOMAP_DIO_ZONE_APPEND;
+		}
+
 		/* for data sync or sync, we need sync completion processing */
 		if (iocb->ki_flags & IOCB_DSYNC)
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
@@ -516,6 +561,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iov_iter_revert(iter, pos - dio->i_size);
 			break;
 		}
+
+		/*
+		 * Zone append writes cannot be split and be shorted. Break
+		 * here to let the user know instead of sending more IOs which
+		 * could get reordered and corrupt the written data.
+		 */
+		if (flags & IOMAP_ZONE_APPEND)
+			break;
+
 	} while ((count = iov_iter_count(iter)) > 0);
 	blk_finish_plug(&plug);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..aa4ad705e549 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -314,6 +314,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_ZONE_APPEND	(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..16c17a79e53d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -68,7 +68,6 @@ struct vm_fault;
  */
 #define IOMAP_F_PRIVATE		0x1000
 
-
 /*
  * Magic value for addr:
  */
@@ -95,6 +94,17 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
+/*
+ * Flags for iomap_begin / iomap_end.  No flag implies a read.
+ */
+#define IOMAP_WRITE		(1 << 0) /* writing, must allocate blocks */
+#define IOMAP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
+#define IOMAP_REPORT		(1 << 2) /* report extent status, e.g. FIEMAP */
+#define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
+#define IOMAP_DIRECT		(1 << 4) /* direct I/O */
+#define IOMAP_NOWAIT		(1 << 5) /* do not block */
+#define IOMAP_ZONE_APPEND	(1 << 6) /* Use zone append for writes */
+
 /*
  * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
  * and page_done will be called for each page written to.  This only applies to
@@ -112,16 +122,6 @@ struct iomap_page_ops {
 			struct page *page, struct iomap *iomap);
 };
 
-/*
- * Flags for iomap_begin / iomap_end.  No flag implies a read.
- */
-#define IOMAP_WRITE		(1 << 0) /* writing, must allocate blocks */
-#define IOMAP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
-#define IOMAP_REPORT		(1 << 2) /* report extent status, e.g. FIEMAP */
-#define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
-#define IOMAP_DIRECT		(1 << 4) /* direct I/O */
-#define IOMAP_NOWAIT		(1 << 5) /* do not block */
-
 struct iomap_ops {
 	/*
 	 * Return the existing mapping at pos, or reserve space starting at
-- 
2.24.1

