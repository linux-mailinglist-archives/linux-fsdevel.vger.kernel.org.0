Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA7A1A3852
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgDIQyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:54:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24703 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgDIQyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586451240; x=1617987240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vAO2UxWgIo/N3O/CCwYSSyzR+tIlfSM1uEVc2K+9RKg=;
  b=nKF6bzmeNfKP7ev7Aky/bhBQNSkzqeImQK2GpQHMD9pQOz5OZ962czWj
   zFlht0U2csdP1F/xllFu1kfVzsMLTyOUWh0ZJFXz9hG25cL8mckI4ZAwu
   icgyeAe/4Wa17C1dEw2HspKdButAo/Ud88erlR8NpV4HwVIpc4FXUrdd8
   zM4EJgJFJCO7k00tkn4ojJJ1s6gFZX0Bjtp202v15tj5RzrOBRwNzFOfH
   cUlwLycTODscsqFW0XaSwMz9PJKdXP3Uc/WYhRdzCT0TgJQsEgJuct0v5
   Ei8xNZf9BBwYLRtYzNIo2sY6qm6Hl+QjIV8h+IVDRpfw3lVQy/U0fP16n
   g==;
IronPort-SDR: 7Q5VSZndslkkLIMx+HGSPYvyIVhifKL+yfo9Np7VK9BykEAASpIDkhPOvRCDk37aWkha0yOV13
 XePnvRBa/jEDRpqr0W07hJTOhz/n9wQ9nunlp0uYnCPwFadc0CopBjS5NmyCeLVpkwZqgJerwl
 8P8rgayRT46+S/zODsgrXHW15UYIr2WpVj+BOs1K01hogRBP7w2JDXrgXmuvO4OQju40ExQnHY
 xhVEsk/xdEFrqfGRCRa9bMkZvANt6iSOy2gPzhUNBrW3dimUhVbL9LEx+scDRQMkrM6QJkiHI4
 I3Y=
X-IronPort-AV: E=Sophos;i="5.72,363,1580745600"; 
   d="scan'208";a="136423682"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 00:54:00 +0800
IronPort-SDR: V1GaOGT8D4GFbfnUVpnxp0Mi8UCHM/a5qdwRQUTv3TMhncvVUBUZjlRuoXKl1hCrLZSnmx05nD
 TerQ+liF8VgE1k6NVjyofZhZ8fNFP7OgmSrD97K4ebFzRuPANtuGb+rF/sTnk5LEk77B/sV25o
 +u47hcFMHOBhUYySZLGpuhOPfb+xljyCayOFNRPr/ZdCUrL2Sj53qPnqc9Of/2bj+s+zZenkKB
 or+k6VixRw+Zm7lqsYCoCGdTbZnRwVO6+1Sib2h3bSD+YdLZWhPG1rNKQtqd1OPo+hvsBklF8d
 eHuSxtlpnP7WV0CUmcwEuceF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 09:44:39 -0700
IronPort-SDR: 2wE+jqrME+00wdphR5HXRA4dDAhJcTh4SzNnaifBOIHSljndofEQTtE5O1Ysw7iFfxeB+pqvPj
 vOWAJwdNSjHlvSJ5ZbgmLe6k6NH4e/6gJyXhA2LVePY2OsbMQkWtpWAjE5SuQX4VkIAysnR4UH
 UguOkB8RjkSVoSsRRyzwQfPoaglCdlTxPWjJ8Dxs8pEBLmlpQyXfWUhSB3127zFmJNOfWa0Tm5
 j6gh/I8W8EWCdqHK+P7oZ3+Rprg87Y8f5BLYON10kA6a0cLAdIZL0KVy3Z7FljOXCbU7ajX6xl
 /2o=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2020 09:53:59 -0700
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
Subject: [PATCH v5 02/10] block: Introduce REQ_OP_ZONE_APPEND
Date:   Fri, 10 Apr 2020 01:53:44 +0900
Message-Id: <20200409165352.2126-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
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
[ jth: added zone-append specific add_page and merge_page helpers ]
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v4:
- fix page merging for zone-append bios
- remove unneeded variable
---
 block/bio.c               | 70 +++++++++++++++++++++++++++++++++++++--
 block/blk-core.c          | 52 +++++++++++++++++++++++++++++
 block/blk-mq.c            | 27 +++++++++++++++
 block/blk-settings.c      | 23 +++++++++++++
 block/blk-sysfs.c         | 13 ++++++++
 drivers/scsi/scsi_lib.c   |  1 +
 include/linux/blk_types.h | 14 ++++++++
 include/linux/blkdev.h    | 11 ++++++
 8 files changed, 209 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 94d697217887..689f31357d30 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -679,6 +679,54 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
+static bool bio_try_merge_zone_append_page(struct bio *bio, struct page *page,
+					   unsigned int len, unsigned int off,
+					   bool *same_page)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	struct bio_vec *bv;
+	unsigned long mask = queue_segment_boundary(q);
+	phys_addr_t addr1, addr2;
+
+	if (bio->bi_vcnt < 1)
+		return false;
+
+	bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+	addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
+	addr2 = page_to_phys(page) + off + len - 1;
+
+	if ((addr1 | mask) != (addr2 | mask))
+		return false;
+	if (bv->bv_len + len > queue_max_segment_size(q))
+		return false;
+	return __bio_try_merge_page(bio, page, len, off, same_page);
+}
+
+static int bio_add_append_page(struct bio *bio, struct page *page, unsigned len,
+			       size_t offset)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
+	bool same_page = false;
+
+	if (WARN_ON_ONCE(!max_append_sectors))
+		return 0;
+
+	if (((bio->bi_iter.bi_size + len) >> 9) > max_append_sectors)
+		return 0;
+
+	if (bio_try_merge_zone_append_page(bio, page, len, offset, &same_page))
+		return len;
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
@@ -944,8 +992,22 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		struct page *page = pages[i];
 
 		len = min_t(size_t, PAGE_SIZE - offset, left);
-
-		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			int ret;
+
+			if (bio_try_merge_zone_append_page(bio, page, len,
+							   offset,
+							   &same_page)) {
+				if (same_page)
+					put_page(page);
+			} else {
+				ret = bio_add_append_page(bio, page, len,
+							  offset);
+				if (ret != len)
+					return -EINVAL;
+			}
+		} else if (__bio_try_merge_page(bio, page, len, offset,
+						&same_page)) {
 			if (same_page)
 				put_page(page);
 		} else {
@@ -1895,6 +1957,10 @@ struct bio *bio_split(struct bio *bio, int sectors,
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

