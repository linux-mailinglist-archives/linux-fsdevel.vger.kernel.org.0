Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00661195B79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 17:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgC0QuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 12:50:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2564 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgC0QuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585327821; x=1616863821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hUdfEc7Ft7iTxSMiRM9lyScyXTJz4Yw7cmn3+XUcwNs=;
  b=Oot+0ucvDofoyGEXsWwWSwAYEdMhmvXhTZWV4JetjNg55wzu/IM93ngh
   lTPtz4PfnuvR4J2zZRM528ErFVYH1icRl991+IT/PkMho2ApD3BIRTeOE
   CUlzvYF8TkaVoKVM2c8FN68zj780C86fHX8gBqREZNE4nUSUz/uDRGJnj
   WBgFERsqWFjxAifo4nYgkTM3SpV1XSuCevBNB2uQpdwVN6dX5fn++ZFTQ
   0quoeoeSHk1QvvV7ltyJn3/RCN4E1Ztx+i6cqa1XS2siOr54r33Vf0+Ja
   VYcrj1m0kFqVQC+WvDs1KBEhNMK9HQNevDG13IdEp6qdcD0yUY2bjHXRg
   g==;
IronPort-SDR: 7ZzwvHTstwGatMcK5p+1+P6T37bjUZCKFFDWUMA6ie2tElXh4JQ4U2yBFBh1wD2/zJaGFzjPny
 xXVhDoMyhtjcQubfyUS5s37EYU66SnidPvIYAeOq78JByjK6VAIbKmx/44smYu9hjoPwa0A1NY
 v8+KCYGN5tJsfJIKjw1dV7k8d+sOpcQgu2jjSsfpLJH2IrMrsw/QTUmEojXKS8WgenMsnkpOW+
 IeS4dCa93Jr+AugqwnXXxs7LqHMaSRV4Zb1ZBjj7DL4e4mJ318mXn+tQpJSaotn4yfzS8sDinv
 4/o=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242210440"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 00:50:20 +0800
IronPort-SDR: jEO7n0268IG0toWsD+hiSeBcCfZG9YVff76F7GAMPucUPHSZZL7vKBQyaIjdWTrc3otnp4l8Am
 TL7xqnPv/D4soZcMCKpENLwy13TwO2VQbLxAEXlC2Eu7c3dmlaQ5/cfx3sQ//UGeL9Q0wsB/yS
 aFhF1Dt2FDPQAsDPtEtDJs4f3PIB8RDDmRV2z5foSE+R9J1tkHnU0A9CRIt3+a7mHFgrVyr1tG
 7ohmtF9gA2BOXTSKdOQp4BiekPdg6lsAP4bsY8nVuZ09acQyxv0CDTRW/3JuAfoeE5jDK67K8g
 6sKagaQwHZw+u/lP54Ablaa5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:41:55 -0700
IronPort-SDR: QH+6TBv3kfVFLi0tUM3GsmUYuMPMZeJIk3yS8xIqDMoioZjkgDeCfovAqwF/N2raeiHRv1Q25O
 U6GGDf7LkmUcN9LJ+aRwKZiUbtmWiM24FvKS60HEcVYUAGEE4nkdgL0bka+CUxjzGY5kJIi7sP
 INW3RuoI+KmaoiAMbvZIt3uFb9Nv8xQGWL2+Spvmtp18h4kxuCRVzWt6rQ/D75ltBltIwFnwHC
 yEnyp4QI+BUtsuhsS2HeA6Zkqztd8oIh2yBXR2Dkd5xBnPmUxlPzxq6zE+gpMwn57rq4Hgedl6
 BCI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2020 09:50:19 -0700
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
Subject: [PATCH v3 02/10] block: Introduce REQ_OP_ZONE_APPEND
Date:   Sat, 28 Mar 2020 01:50:04 +0900
Message-Id: <20200327165012.34443-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
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
Changes since v2:
- Fixed commit message regarding bio_full()
- Fixed return values of bio_can_zone_append()
---
 block/bio.c               | 72 +++++++++++++++++++++++++++++++++++++--
 block/blk-core.c          | 52 ++++++++++++++++++++++++++++
 block/blk-map.c           |  2 +-
 block/blk-mq.c            | 27 +++++++++++++++
 block/blk-settings.c      | 19 +++++++++++
 block/blk-sysfs.c         | 13 +++++++
 block/blk-zoned.c         | 10 ++++++
 drivers/scsi/scsi_lib.c   |  1 +
 include/linux/bio.h       | 22 ++----------
 include/linux/blk_types.h | 14 ++++++++
 include/linux/blkdev.h    | 11 ++++++
 11 files changed, 220 insertions(+), 23 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 11e6aac35092..aee214db92d3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -729,6 +729,45 @@ const char *bio_devname(struct bio *bio, char *buf)
 }
 EXPORT_SYMBOL(bio_devname);
 
+static inline bool bio_can_zone_append(struct bio *bio, unsigned len)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
+
+	if (WARN_ON_ONCE(!max_append_sectors))
+		return true;
+
+	if (((bio->bi_iter.bi_size + len) >> 9) > max_append_sectors)
+		return true;
+
+	if (bio->bi_vcnt >= queue_max_segments(q))
+		return true;
+
+	return false;
+}
+
+/**
+ * bio_full - check if the bio is full
+ * @bio:	bio to check
+ * @len:	length of one segment to be added
+ *
+ * Return true if @bio is full and one segment with @len bytes can't be
+ * added to the bio, otherwise return false
+ */
+bool bio_full(struct bio *bio, unsigned len)
+{
+	if (bio->bi_vcnt >= bio->bi_max_vecs)
+		return true;
+
+	if (bio->bi_iter.bi_size > UINT_MAX - len)
+		return true;
+
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+		return bio_can_zone_append(bio, len);
+
+	return false;
+}
+
 static inline bool page_is_mergeable(const struct bio_vec *bv,
 		struct page *page, unsigned int len, unsigned int off,
 		bool *same_page)
@@ -831,6 +870,22 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
+static bool bio_try_merge_zone_append_page(struct bio *bio, struct page *page,
+					   unsigned int len, unsigned int off)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+	unsigned long mask = queue_segment_boundary(q);
+	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
+	phys_addr_t addr2 = page_to_phys(page) + off + len - 1;
+
+	if ((addr1 | mask) != (addr2 | mask))
+		return false;
+	if (bv->bv_len + len > queue_max_segment_size(q))
+		return false;
+	return true;
+}
+
 /**
  * __bio_try_merge_page - try appending data to an existing bvec.
  * @bio: destination bio
@@ -856,6 +911,12 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			if (!bio_try_merge_zone_append_page(bio, page, len,
+							    off))
+				return false;
+		}
+
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
 			if (bio->bi_iter.bi_size > UINT_MAX - len)
 				return false;
@@ -916,6 +977,7 @@ int bio_add_page(struct bio *bio, struct page *page,
 	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
 		if (bio_full(bio, len))
 			return 0;
+
 		__bio_add_page(bio, page, len, offset);
 	}
 	return len;
@@ -948,7 +1010,7 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 
 	len = min_t(size_t, bv->bv_len - iter->iov_offset, iter->count);
 	size = bio_add_page(bio, bv->bv_page, len,
-				bv->bv_offset + iter->iov_offset);
+			    bv->bv_offset + iter->iov_offset);
 	if (unlikely(size != len))
 		return -EINVAL;
 	iov_iter_advance(iter, size);
@@ -1448,7 +1510,7 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
  */
 struct bio *bio_map_user_iov(struct request_queue *q,
 			     struct iov_iter *iter,
-			     gfp_t gfp_mask)
+			     gfp_t gfp_mask, unsigned int op)
 {
 	int j;
 	struct bio *bio;
@@ -1488,7 +1550,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 					n = bytes;
 
 				if (!__bio_add_pc_page(q, bio, page, n, offs,
-						&same_page)) {
+						       &same_page)) {
 					if (same_page)
 						put_page(page);
 					break;
@@ -1953,6 +2015,10 @@ struct bio *bio_split(struct bio *bio, int sectors,
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
index eaf6cb3887e6..b602daa79a6d 100644
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
@@ -864,6 +876,41 @@ static inline int blk_partition_remap(struct bio *bio)
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
@@ -936,6 +983,11 @@ generic_make_request_checks(struct bio *bio)
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
diff --git a/block/blk-map.c b/block/blk-map.c
index b0790268ed9d..a83ba39251a9 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -72,7 +72,7 @@ static int __blk_rq_map_user_iov(struct request *rq,
 	if (copy)
 		bio = bio_copy_user_iov(q, map_data, iter, gfp_mask);
 	else
-		bio = bio_map_user_iov(q, iter, gfp_mask);
+		bio = bio_map_user_iov(q, iter, gfp_mask, req_op(rq));
 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 745ec592a513..c06c796742ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1195,6 +1195,19 @@ static void blk_mq_handle_dev_resource(struct request *rq,
 	__blk_mq_requeue_request(rq);
 }
 
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
@@ -1206,6 +1219,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
+	LIST_HEAD(zone_list);
 
 	if (list_empty(list))
 		return false;
@@ -1264,6 +1278,16 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
 			blk_mq_handle_dev_resource(rq, list);
 			break;
+		} else if (ret == BLK_STS_ZONE_RESOURCE) {
+			/*
+			 * Move the request to zone_list and keep going through
+			 * the dipatch list to find more requests the drive
+			 * accepts.
+			 */
+			blk_mq_handle_zone_resource(rq, &zone_list);
+			if (list_empty(list))
+				break;
+			continue;
 		}
 
 		if (unlikely(ret != BLK_STS_OK)) {
@@ -1275,6 +1299,9 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		queued++;
 	} while (!list_empty(list));
 
+	if (!list_empty(&zone_list))
+		list_splice_tail_init(&zone_list, list);
+
 	hctx->dispatched[queued_to_index(queued)]++;
 
 	/*
diff --git a/block/blk-settings.c b/block/blk-settings.c
index be1dca0103a4..ac0711803ee7 100644
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
 
@@ -257,6 +259,21 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
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
+	q->limits.max_zone_append_sectors = max_sectors;
+}
+EXPORT_SYMBOL_GPL(blk_queue_max_zone_append_sectors);
+
 /**
  * blk_queue_max_segments - set max hw segments for a request for this queue
  * @q:  the request queue for the device
@@ -506,6 +523,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
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
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6b442ae96499..9d30a4115dbc 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -455,6 +455,15 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 				       blk_revalidate_zone_cb, &args);
 	memalloc_noio_restore(noio_flag);
 
+	if (ret == 0 &&
+	    (queue_max_zone_append_sectors(q) > queue_max_hw_sectors(q) ||
+	     queue_max_zone_append_sectors(q) > q->limits.chunk_sectors)) {
+		pr_warn("%s: invalid max_zone_append_bytes value: %u\n",
+			disk->disk_name, queue_max_zone_append_sectors(q) << 9);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Install the new bitmaps and update nr_zones only once the queue is
 	 * stopped and all I/Os are completed (i.e. a scheduler is not
@@ -473,6 +482,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	}
 	blk_mq_unfreeze_queue(q);
 
+out:
 	kfree(args.seq_zones_wlock);
 	kfree(args.conv_zones_bitmap);
 	return ret;
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
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a430e9c1c2d2..59d840706027 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -102,24 +102,7 @@ static inline void *bio_data(struct bio *bio)
 	return NULL;
 }
 
-/**
- * bio_full - check if the bio is full
- * @bio:	bio to check
- * @len:	length of one segment to be added
- *
- * Return true if @bio is full and one segment with @len bytes can't be
- * added to the bio, otherwise return false
- */
-static inline bool bio_full(struct bio *bio, unsigned len)
-{
-	if (bio->bi_vcnt >= bio->bi_max_vecs)
-		return true;
-
-	if (bio->bi_iter.bi_size > UINT_MAX - len)
-		return true;
-
-	return false;
-}
+bool bio_full(struct bio *bio, unsigned len);
 
 static inline bool bio_next_segment(const struct bio *bio,
 				    struct bvec_iter_all *iter)
@@ -435,6 +418,7 @@ void bio_chain(struct bio *, struct bio *);
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
+
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
@@ -443,7 +427,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_release_pages(struct bio *bio, bool mark_dirty);
 struct rq_map_data;
 extern struct bio *bio_map_user_iov(struct request_queue *,
-				    struct iov_iter *, gfp_t);
+				    struct iov_iter *, gfp_t, unsigned int);
 extern void bio_unmap_user(struct bio *);
 extern struct bio *bio_map_kern(struct request_queue *, void *, unsigned int,
 				gfp_t);
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
index cda34e0f94d3..50e9b140cad7 100644
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

