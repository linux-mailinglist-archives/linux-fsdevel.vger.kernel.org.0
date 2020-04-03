Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8CA19D4D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390651AbgDCKNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56752 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390633AbgDCKNP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908795; x=1617444795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DntH3FOL+F2qJ4JB8bNfeHvJeRnIrbJq4X8RpN63JaA=;
  b=GErCpaeNP5ToG5PipM0I25323UAz4kYbZ2cFenjZp6viuNtQY/d2ZOHn
   DjEW/Dly4/PyF5RMxxx8A5+u7ynzitYdDPW99Es2ujwAUqKxugwmWMgkY
   Rw8JnUOPU2IMKDM9SrKl2iBi9nrVIV1RCQSvppdZFOYhU0c0zSGhjHvjQ
   KXUEKSLz16T9iZntk7bl4S8S16Jqe3rGcUmeup6ARXSOlwavUa/lY5OFH
   OLB0nF6WXSQIv+Klgc9IokLtySy7DA81J7kqeVPSRbMYSl+QXbH+fkXH6
   M2cL3vkGJP2qP+UhbAkh62Bi82JfgFY/VNRQP/5CpSGLfXwFbSg1eqaXN
   A==;
IronPort-SDR: ge2drv3IAlwPOj6qIlYPp/t3OqdS3OoqKIndlWR5ZzBapR9sZ3F2Pi/lvKSWWHIyxJEsNtdHlT
 OCqw3Fh/Q44zPQLS6eThXe3YBLG7PhgTwkRMB4P90K2/+tup8i1AilBLx9njlcwaxPLJoh4NRP
 G1PzRzheuzWbHi05V5ffRiPzWlCuz8w1/4ksr6rA0MA5omJNrYTU1dBjDOvQW449mZMF5cef0S
 N5HQjkQKgWAa3w/WkQ8oowyrM07LUGRw/TCx4iDSdWIO/FtpMMCjxCPWieTqZvIReT6cVVs0ds
 4Vc=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135956057"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:13:15 +0800
IronPort-SDR: 9GGFY5qNc8Q3jtHjZu838vi+eKJ9Eh004g/yPnqsrJXt5g3i+Gnj05IFlss5qAZ6zvyXxbBbCd
 27yK1EiYHJ0rbKkVVA4v28RNwqxu+W5GE7RgWZHdaZtCxypuehzc6DcAKYAIDDAhnnbD97lkL9
 x4OvBRIX2mHnnpK1kn3YNV19iCepLrgIsN5LGaZjwoaHTCVTsXrzPhTXen7n14Ojo2Eai+h1UY
 4evk54c2zKCG/N6QWvXOuL2YkEVxr9ZHZ9M9z96OlOwoqBsAibDwr2+tcKpb8iA3e0EsAMtQBY
 W0AsKD6WCNQMqXBSkqU5+bzB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:04:04 -0700
IronPort-SDR: nV9xeSC198WDQDPHiej2oAz+ea5egwfJmMSL3FUrsJsDBqhCg1ysRo+BxrcCkKj45k6YVzU4xb
 DZqUfXLnrMe+zdL/pKVdiXE6EkwvqkBC3NKyjod/E8IAH5v++gpadmiB5kg+tgtG02GQuQwQMK
 r5Lkiiixyvz83+VusZ+uca/vvGb520q6V68TaFeRlACAG3vimPaxuyK+HrI508xOSHbJdXEbP9
 AjbibnZyomsxUji2EIzyIIFLEOGEzZeHyNzsKjY4xw4KkWoU/nNnEefSPBGaIRJTYnlGfQb874
 eSk=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:13:12 -0700
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
Subject: [PATCH v4 10/10] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
Date:   Fri,  3 Apr 2020 19:12:50 +0900
Message-Id: <20200403101250.33245-11-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
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
 fs/zonefs/super.c | 80 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 3ce9829a6936..0bf7009f50a2 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -20,6 +20,7 @@
 #include <linux/mman.h>
 #include <linux/sched/mm.h>
 #include <linux/crc32.h>
+#include <linux/task_io_accounting_ops.h>
 
 #include "zonefs.h"
 
@@ -596,6 +597,61 @@ static const struct iomap_dio_ops zonefs_write_dio_ops = {
 	.end_io			= zonefs_file_write_dio_end_io,
 };
 
+static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	struct block_device *bdev = inode->i_sb->s_bdev;
+	unsigned int max;
+	struct bio *bio;
+	ssize_t size;
+	int nr_pages;
+	ssize_t ret;
+
+	nr_pages = iov_iter_npages(from, BIO_MAX_PAGES);
+	if (!nr_pages)
+		return 0;
+
+	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
+	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
+	iov_iter_truncate(from, max);
+
+	bio = bio_alloc_bioset(GFP_NOFS, nr_pages, &fs_bio_set);
+	if (!bio)
+		return -ENOMEM;
+
+	bio_set_dev(bio, bdev);
+	bio->bi_iter.bi_sector = zi->i_zsector;
+	bio->bi_write_hint = iocb->ki_hint;
+	bio->bi_ioprio = iocb->ki_ioprio;
+	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	if (iocb->ki_flags & IOCB_DSYNC)
+		bio->bi_opf |= REQ_FUA;
+
+	ret = bio_iov_iter_get_pages(bio, from);
+	if (unlikely(ret)) {
+		bio_io_error(bio);
+		return ret;
+	}
+	size = bio->bi_iter.bi_size;
+	task_io_account_write(ret);
+
+	if (iocb->ki_flags & IOCB_HIPRI)
+		bio_set_polled(bio, iocb);
+
+	ret = submit_bio_wait(bio);
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
@@ -611,6 +667,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
+	bool sync = is_sync_kiocb(iocb);
+	bool append = false;
 	size_t count;
 	ssize_t ret;
 
@@ -619,7 +677,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
 	 * on the inode lock but the second goes through but is now unaligned).
 	 */
-	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && !is_sync_kiocb(iocb) &&
+	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && !sync &&
 	    (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
@@ -643,16 +701,22 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	/* Enforce sequential writes (append only) in sequential zones */
-	mutex_lock(&zi->i_truncate_mutex);
-	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && iocb->ki_pos != zi->i_wpoffset) {
+	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
+		mutex_lock(&zi->i_truncate_mutex);
+		if (iocb->ki_pos != zi->i_wpoffset) {
+			mutex_unlock(&zi->i_truncate_mutex);
+			ret = -EINVAL;
+			goto inode_unlock;
+		}
 		mutex_unlock(&zi->i_truncate_mutex);
-		ret = -EINVAL;
-		goto inode_unlock;
+		append = sync;
 	}
-	mutex_unlock(&zi->i_truncate_mutex);
 
-	ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
-			   &zonefs_write_dio_ops, is_sync_kiocb(iocb));
+	if (append)
+		ret = zonefs_file_dio_append(iocb, from);
+	else
+		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
+				   &zonefs_write_dio_ops, sync);
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
 		if (ret > 0)
-- 
2.24.1

