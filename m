Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23AF319D4C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbgDCKNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56713 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908782; x=1617444782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ktU2tWEaMJUhbWE3rZRtiiRyX7GPxPReS4h+tAAhRs=;
  b=Rjv/I1SXLJadoSHswWRKcnglDUpgEymL1gb4+Q3Cy6SvbIhdeTJWmj5i
   +ywBvrEum+9p7SUgspRdMBD4UjypQ+Ndo6WzhFGVlAhNgwzY3nNlgO5A7
   /wPSJl9wk9+FUCS8YSExBz7Y2ZVVxAoZMdZY3tduc1qX0dh+Rkw7Mi55p
   yP0o3KdhGiM1W6OqWpFlUAJQcIJ/Tft5ZAZe842r3Al2UC1vNOtI784pQ
   y65NtasQ5XFGyC9nIDgbZB2tQLfgXbxQJIJakGQxm+aJ09R9YgEh4RlYH
   62hV1Fh/rBsMg6S/NRRJ4L0SRKJ3BvY7lOx0F8K4vHWgKNegic/HNGOJg
   Q==;
IronPort-SDR: sPE1AKDhEdm3UlliMEfKQCQVeQoi/PRvgqU8dyibAuVXmtUE4u5sHQm/D79qMjHRhKT3rpiILu
 S3dB9SqUIoSTNYft6WpR9IYCo2BX5p7mfEKHyWB9YuVhQDQLF71a/jPo5tYObXXnM6rltOp3P6
 k4/eM5kBk8dJDWATqiBVjAb75Esor34GAjPV+ncIX0FY1JcR25xR1tYdTqS5IoygahCTTQs0LK
 tQ0zpw5kJmAH+G6XKWWrk838fbsZB2HT1h22SeaOLZchJe0iwuPej/MmXtD35PHzMyGsO7eDcx
 laU=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135955996"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:13:01 +0800
IronPort-SDR: I6pCXPCOFnqGD4hLrFLXOb90HFoLYy9le83lKclEA1zpUIzlkHWzubyCn1LZR4pyZNALU2uLxA
 2T77X1qblDcv/JNUkOsSGNagrW5NxyYVvivqB/QuH1BCLNzNHCtEZkG+/4uhZDj6Rzhbu+StXu
 M7RlPb9MYayr7CB5WqfeeZQpYuLY3lK3aK4EAZ9GSDqYkkiQVtm6cpB8hyKIAh465ugEAdDgVH
 sLw8D0yrOVP6RBpCCVUdS3/pXl958O8Edj3EiozoEpyleBiovVJNlz0quv0zzM26EUP2KRmyD9
 lgO2E/TUxkaFboyLhpvkrU2O
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:03:51 -0700
IronPort-SDR: /1ul2xIy+XfWZUoMpBJ2N/PDgXEXAcgjh5Boj8kmA8aNZhn4QTmeQz84c0oLlvEjggtosIQo2m
 9UEA2pFHc9tfnwNRi8nUh0b9JVpbGv3OBkZDZWq8jHBq12PwHKiF+ue450oyTkJcBbpLAXapmj
 rDvKm2t32GyIOUp4159meyk3vtdTmT3CExcYsmMNUnpy9e2kLyf79Eg7v4bItDR7rnDoeI6T4N
 DmJZTDtkbqiNyGU/hdAiE7zIdTRjgn0YiKuGtCC6Csmc2e8FEswnKWba9gfjKa3nOu/qdKy5xr
 mZE=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:12:58 -0700
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
Subject: [PATCH v4 02/10] block: Introduce REQ_OP_ZONE_APPEND
Date:   Fri,  3 Apr 2020 19:12:42 +0900
Message-Id: <20200403101250.33245-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Define REQ_OP_ZONE_APPEND to append-write sectors to a zone of a zoned
block device. This is a no-merge write operation.

A zone append write BIO must:
* Target a zoned block device
* Have a sector position indicating the start sector of the target zone
* The target zone must be a sequential write zone
* The BIO must not cross a zone boundary
* The BIO size must not be split to ensure that a single range of LBAs
  is written with a single command.

Implement these checks in generic_make_request_checks() using the
helper function blk_check_zone_append(). To avoid write append BIO
splitting, introduce the new max_zone_append_sectors queue limit
attribute and ensure that a BIO size is always lower than this limit.
Export this new limit through sysfs and check these limits in bio_full().

Also when a LLDD can't dispatch a request to a specific zone, it
will return BLK_STS_ZONE_RESOURCE indicating this request needs to
be delayed, e.g.  because the zone it will be dispatched to is still
write-locked. If this happens set the request aside in a local list
to continue trying dispatching requests such as READ requests or a
WRITE/ZONE_APPEND requests targetting other zones. This way we can
still keep a high queue depth without starving other requests even if
one request can't be served due to zone write-locking.

Finally, make sure that the bio sector position indicates the actual
write position as indicated by the device on completion.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c               | 57 ++++++++++++++++++++++++++++++++++++++-
 block/blk-core.c          | 52 +++++++++++++++++++++++++++++++++++
 block/blk-mq.c            | 27 +++++++++++++++++++
 block/blk-settings.c      | 23 ++++++++++++++++
 block/blk-sysfs.c         | 13 +++++++++
 drivers/scsi/scsi_lib.c   |  1 +
 include/linux/blk_types.h | 14 ++++++++++
 include/linux/blkdev.h    | 11 ++++++++
 8 files changed, 197 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 94d697217887..e8c9273884a6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -679,6 +679,48 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
+static bool bio_try_merge_zone_append_page(struct bio *bio, struct page *page,
+					   unsigned int len, unsigned int off)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+	unsigned long mask = queue_segment_boundary(q);
+	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
+	phys_addr_t addr2 = page_to_phys(page) + off + len - 1;
+	bool same_page = false;
+
+	if ((addr1 | mask) != (addr2 | mask))
+		return false;
+	if (bv->bv_len + len > queue_max_segment_size(q))
+		return false;
+	return __bio_try_merge_page(bio, page, len, off, &same_page);
+}
+
+static int bio_add_append_page(struct bio *bio, struct page *page, unsigned len,
+			       size_t offset)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
+
+	if (WARN_ON_ONCE(!max_append_sectors))
+		return 0;
+
+	if (((bio->bi_iter.bi_size + len) >> 9) > max_append_sectors)
+		return 0;
+
+	if (bio->bi_vcnt > 0) {
+		if (bio_try_merge_zone_append_page(bio, page, len, offset))
+			return len;
+	}
+
+	if (bio->bi_vcnt >= queue_max_segments(q))
+		return 0;
+
+	__bio_add_page(bio, page, len, offset);
+
+	return len;
+}
+
 static inline bool page_is_mergeable(const struct bio_vec *bv,
 		struct page *page, unsigned int len, unsigned int off,
 		bool *same_page)
@@ -866,6 +908,7 @@ int bio_add_page(struct bio *bio, struct page *page,
 	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
 		if (bio_full(bio, len))
 			return 0;
+
 		__bio_add_page(bio, page, len, offset);
 	}
 	return len;
@@ -927,6 +970,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
+	unsigned op = bio_op(bio);
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -944,13 +988,20 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		struct page *page = pages[i];
 
 		len = min_t(size_t, PAGE_SIZE - offset, left);
+		if (op == REQ_OP_ZONE_APPEND) {
+			int ret;
 
-		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
+			ret = bio_add_append_page(bio, page, len, offset);
+			if (ret != len)
+				return -EINVAL;
+		} else if (__bio_try_merge_page(bio, page, len, offset,
+						&same_page)) {
 			if (same_page)
 				put_page(page);
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len)))
                                 return -EINVAL;
+
 			__bio_add_page(bio, page, len, offset);
 		}
 		offset = 0;
@@ -1895,6 +1946,10 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
 
+	/* Zone append commands cannot be split */
+	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
+		return NULL;
+
 	split = bio_clone_fast(bio, gfp, bs);
 	if (!split)
 		return NULL;
diff --git a/block/blk-core.c b/block/blk-core.c
index 60dc9552ef8d..57127092d816 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -135,6 +135,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(ZONE_OPEN),
 	REQ_OP_NAME(ZONE_CLOSE),
 	REQ_OP_NAME(ZONE_FINISH),
+	REQ_OP_NAME(ZONE_APPEND),
 	REQ_OP_NAME(WRITE_SAME),
 	REQ_OP_NAME(WRITE_ZEROES),
 	REQ_OP_NAME(SCSI_IN),
@@ -240,6 +241,17 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 
 	bio_advance(bio, nbytes);
 
+	if (req_op(rq) == REQ_OP_ZONE_APPEND && error == BLK_STS_OK) {
+		/*
+		 * Partial zone append completions cannot be supported as the
+		 * BIO fragments may end up not being written sequentially.
+		 */
+		if (bio->bi_iter.bi_size)
+			bio->bi_status = BLK_STS_IOERR;
+		else
+			bio->bi_iter.bi_sector = rq->__sector;
+	}
+
 	/* don't actually finish bio if it's part of flush sequence */
 	if (bio->bi_iter.bi_size == 0 && !(rq->rq_flags & RQF_FLUSH_SEQ))
 		bio_endio(bio);
@@ -865,6 +877,41 @@ static inline int blk_partition_remap(struct bio *bio)
 	return ret;
 }
 
+/*
+ * Check write append to a zoned block device.
+ */
+static inline blk_status_t blk_check_zone_append(struct request_queue *q,
+						 struct bio *bio)
+{
+	sector_t pos = bio->bi_iter.bi_sector;
+	int nr_sectors = bio_sectors(bio);
+
+	/* Only applicable to zoned block devices */
+	if (!blk_queue_is_zoned(q))
+		return BLK_STS_NOTSUPP;
+
+	/* The bio sector must point to the start of a sequential zone */
+	if (pos & (blk_queue_zone_sectors(q) - 1) ||
+	    !blk_queue_zone_is_seq(q, pos))
+		return BLK_STS_IOERR;
+
+	/*
+	 * Not allowed to cross zone boundaries. Otherwise, the BIO will be
+	 * split and could result in non-contiguous sectors being written in
+	 * different zones.
+	 */
+	if (blk_queue_zone_no(q, pos) != blk_queue_zone_no(q, pos + nr_sectors))
+		return BLK_STS_IOERR;
+
+	/* Make sure the BIO is small enough and will not get split */
+	if (nr_sectors > q->limits.max_zone_append_sectors)
+		return BLK_STS_IOERR;
+
+	bio->bi_opf |= REQ_NOMERGE;
+
+	return BLK_STS_OK;
+}
+
 static noinline_for_stack bool
 generic_make_request_checks(struct bio *bio)
 {
@@ -937,6 +984,11 @@ generic_make_request_checks(struct bio *bio)
 		if (!q->limits.max_write_same_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_ZONE_APPEND:
+		status = blk_check_zone_append(q, bio);
+		if (status != BLK_STS_OK)
+			goto end_io;
+		break;
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d92088dec6c3..ce60a071660f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1178,6 +1178,19 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
 
 #define BLK_MQ_RESOURCE_DELAY	3		/* ms units */
 
+static void blk_mq_handle_zone_resource(struct request *rq,
+					struct list_head *zone_list)
+{
+	/*
+	 * If we end up here it is because we cannot dispatch a request to a
+	 * specific zone due to LLD level zone-write locking or other zone
+	 * related resource not being available. In this case, set the request
+	 * aside in zone_list for retrying it later.
+	 */
+	list_add(&rq->queuelist, zone_list);
+	__blk_mq_requeue_request(rq);
+}
+
 /*
  * Returns true if we did some work AND can potentially do more.
  */
@@ -1189,6 +1202,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
+	LIST_HEAD(zone_list);
 
 	if (list_empty(list))
 		return false;
@@ -1257,6 +1271,16 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			list_add(&rq->queuelist, list);
 			__blk_mq_requeue_request(rq);
 			break;
+		} else if (ret == BLK_STS_ZONE_RESOURCE) {
+			/*
+			 * Move the request to zone_list and keep going through
+			 * the dispatch list to find more requests the drive can
+			 * accept.
+			 */
+			blk_mq_handle_zone_resource(rq, &zone_list);
+			if (list_empty(list))
+				break;
+			continue;
 		}
 
 		if (unlikely(ret != BLK_STS_OK)) {
@@ -1268,6 +1292,9 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		queued++;
 	} while (!list_empty(list));
 
+	if (!list_empty(&zone_list))
+		list_splice_tail_init(&zone_list, list);
+
 	hctx->dispatched[queued_to_index(queued)]++;
 
 	/*
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c8eda2e7b91e..5388965841df 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -48,6 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->chunk_sectors = 0;
 	lim->max_write_same_sectors = 0;
 	lim->max_write_zeroes_sectors = 0;
+	lim->max_zone_append_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
 	lim->discard_granularity = 0;
@@ -83,6 +84,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_same_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
+	lim->max_zone_append_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -257,6 +259,25 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
 
+/**
+ * blk_queue_max_zone_append_sectors - set max sectors for a single zone append
+ * @q:  the request queue for the device
+ * @max_zone_append_sectors: maximum number of sectors to write per command
+ **/
+void blk_queue_max_zone_append_sectors(struct request_queue *q,
+		unsigned int max_zone_append_sectors)
+{
+	unsigned int max_sectors;
+
+	max_sectors = min(q->limits.max_hw_sectors, max_zone_append_sectors);
+	if (max_sectors)
+		max_sectors = min_not_zero(q->limits.chunk_sectors,
+					   max_sectors);
+
+	q->limits.max_zone_append_sectors = max_sectors;
+}
+EXPORT_SYMBOL_GPL(blk_queue_max_zone_append_sectors);
+
 /**
  * blk_queue_max_segments - set max hw segments for a request for this queue
  * @q:  the request queue for the device
@@ -506,6 +527,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 					b->max_write_same_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
+	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
+					b->max_zone_append_sectors);
 	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..02643e149d5e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -218,6 +218,13 @@ static ssize_t queue_write_zeroes_max_show(struct request_queue *q, char *page)
 		(unsigned long long)q->limits.max_write_zeroes_sectors << 9);
 }
 
+static ssize_t queue_zone_append_max_show(struct request_queue *q, char *page)
+{
+	unsigned long long max_sectors = q->limits.max_zone_append_sectors;
+
+	return sprintf(page, "%llu\n", max_sectors << SECTOR_SHIFT);
+}
+
 static ssize_t
 queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
 {
@@ -639,6 +646,11 @@ static struct queue_sysfs_entry queue_write_zeroes_max_entry = {
 	.show = queue_write_zeroes_max_show,
 };
 
+static struct queue_sysfs_entry queue_zone_append_max_entry = {
+	.attr = {.name = "zone_append_max_bytes", .mode = 0444 },
+	.show = queue_zone_append_max_show,
+};
+
 static struct queue_sysfs_entry queue_nonrot_entry = {
 	.attr = {.name = "rotational", .mode = 0644 },
 	.show = queue_show_nonrot,
@@ -749,6 +761,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_zeroes_data_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
+	&queue_zone_append_max_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 610ee41fa54c..ea327f320b7f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1706,6 +1706,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case BLK_STS_OK:
 		break;
 	case BLK_STS_RESOURCE:
+	case BLK_STS_ZONE_RESOURCE:
 		if (atomic_read(&sdev->device_busy) ||
 		    scsi_device_blocked(sdev))
 			ret = BLK_STS_DEV_RESOURCE;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..824ec2d89954 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -63,6 +63,18 @@ typedef u8 __bitwise blk_status_t;
  */
 #define BLK_STS_DEV_RESOURCE	((__force blk_status_t)13)
 
+/*
+ * BLK_STS_ZONE_RESOURCE is returned from the driver to the block layer if zone
+ * related resources are unavailable, but the driver can guarantee the queue
+ * will be rerun in the future once the resources become available again.
+ *
+ * This is different from BLK_STS_DEV_RESOURCE in that it explicitly references
+ * a zone specific resource and IO to a different zone on the same device could
+ * still be served. Examples of that are zones that are write-locked, but a read
+ * to the same zone could be served.
+ */
+#define BLK_STS_ZONE_RESOURCE	((__force blk_status_t)14)
+
 /**
  * blk_path_error - returns true if error may be path related
  * @error: status the request was completed with
@@ -296,6 +308,8 @@ enum req_opf {
 	REQ_OP_ZONE_CLOSE	= 11,
 	/* Transition a zone to full */
 	REQ_OP_ZONE_FINISH	= 12,
+	/* write data at the current zone write pointer */
+	REQ_OP_ZONE_APPEND	= 13,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 25b63f714619..36111b10d514 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -336,6 +336,7 @@ struct queue_limits {
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_write_same_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 
@@ -757,6 +758,9 @@ static inline bool rq_mergeable(struct request *rq)
 	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
 		return false;
 
+	if (req_op(rq) == REQ_OP_ZONE_APPEND)
+		return false;
+
 	if (rq->cmd_flags & REQ_NOMERGE_FLAGS)
 		return false;
 	if (rq->rq_flags & RQF_NOMERGE_FLAGS)
@@ -1088,6 +1092,8 @@ extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
+extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
+		unsigned int max_zone_append_sectors);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
@@ -1301,6 +1307,11 @@ static inline unsigned int queue_max_segment_size(const struct request_queue *q)
 	return q->limits.max_segment_size;
 }
 
+static inline unsigned int queue_max_zone_append_sectors(const struct request_queue *q)
+{
+	return q->limits.max_zone_append_sectors;
+}
+
 static inline unsigned queue_logical_block_size(const struct request_queue *q)
 {
 	int retval = 512;
-- 
2.24.1

