Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B131A97ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393892AbgDOJG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:06:56 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19515 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393857AbgDOJF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586941529; x=1618477529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mbrcp3ypiorlyjCGTv6YLqgtm02r3Gc8tme5xzZKrHA=;
  b=Hlt8zOFTKECAXP+pTq5rs7Qsx20qHGysccv0vKpC6SMybLu3iOKOlwqP
   GOOBdxvlsgejeEpvT8nKjfKGuLes/1mOWN0YaSP3be3X2Nk/51ktzBClU
   JYbgY1Mht+Z92zMae21x7WiPZuVGkoJfwQ0vqTQH+mxMEs3/bi25gcx63
   j19OuD2XWoexu6MDBQpsODy3rQXzetHiWsW8Lp/u3FpuyQxoDQUNC88od
   XnXz/iavxR6uTJISGyd9ROCIE8ol1in6Tsi0gAvLUbUJDx+NxOjokBx2e
   7//r0WBLB6mCz1X+QOmNbqUGCPXzDUb5EuNzhAcdXJnlb9oU3QQkBaXDW
   g==;
IronPort-SDR: E9WNweG6Ez8pX76lV9DDNCMF8Py418pYm3MGGNyJ9jMBXHR1Yc4QCCxKDHrPzaJXHtJI8cYXQ1
 Wjv/yz7VOr7NiA5rQxCz/3JQsHzUOnTOYlxFfG2x5HLnPyr9HRA8xj8+R73WaVocc3GGpCMQje
 hPURLG1K52RVL4PaHDyREUPLd4zEiMz1fkZPiMbjKnreXn0xsjJvduiv7ihepjoc3YiyLIMhDx
 FLM76UeB3Ger58jmFLC3TpfRfrOyXgI+kcSFGta7UeDsLudlFSQqFFACluY9QjBrW50sN+aO5I
 Do0=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="136802978"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:05:28 +0800
IronPort-SDR: qHMoKFGiOwTaHdIWlC6DzyyN6mryQ9srUt4qWUTGWtGJdCgF75VfiTyVzBbcyubcNJvqrPDvY0
 CYevue9OTLVJdVKostY7TXrkargyjjrCAgEThor0SIXOS1rFUSJks79Hb492z2VYolO3Za1FiD
 W7IDowOu/A225Tr7MulWmtRSuVArmlCoVroLVRliTGsfscX1dPSXP0D05Ck8PycLuX2uqPkdoh
 iUz5RjgpKahqbUOH5tdOoN2jdnmefE83/mPRa/PbYA1VIi3At0zmtUoyYV7K50aTZ9cXFRZM3S
 AIPLQH31MKug004W5ccTFoze
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:56:30 -0700
IronPort-SDR: ZoFjElupDOGkSKXbyWTOSQa3q808I+jY4LULt5ezK58+5mY7bDBe8lKPuvf3R2vayQcZrGHOL7
 Ve3pVA0yHTFILWAVtqKmWhuwJoXpevC+/qYq56NO0LoOGQ7oslQEBil3OUHcLuteqVIHiOq9+/
 LPy+UOdPadliLku1JkLZKtN+Rr42v6zNsFeN7tl4uXidxyGFjvnswq6JPLb+I3w1yXN17nAN/N
 GLbNWryOjNbC4WNfuHoqL3ZUmOlw9MRjBeiKmVpq8LifPVD2LRulCJiWxBNy4fHNkddla3us2J
 xcY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Apr 2020 02:05:27 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 03/11] block: rename __bio_add_pc_page to bio_add_hw_page
Date:   Wed, 15 Apr 2020 18:05:05 +0900
Message-Id: <20200415090513.5133-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Rename __bio_add_pc_page() to bio_add_hw_page() and explicitly pass in a
max_sectors argument.

This max_sectors argument can be used to specify constraints from the
hardware.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[ jth: rebased and made public for blk-map.c ]
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c     | 60 +++++++++++++++++++++++++++----------------------
 block/blk-map.c |  5 +++--
 block/blk.h     |  4 ++--
 3 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 21cbaa6a1c20..0f0e337e46b4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -748,9 +748,14 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return true;
 }
 
-static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned len, unsigned offset,
-		bool *same_page)
+/*
+ * Try to merge a page into a segment, while obeying the hardware segment
+ * size limit.  This is not for normal read/write bios, but for passthrough
+ * or Zone Append operations that we can't split.
+ */
+static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
+				 struct page *page, unsigned len,
+				 unsigned offset, bool *same_page)
 {
 	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 	unsigned long mask = queue_segment_boundary(q);
@@ -764,39 +769,24 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
 	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
 
-/**
- *	__bio_add_pc_page	- attempt to add page to passthrough bio
- *	@q: the target queue
- *	@bio: destination bio
- *	@page: page to add
- *	@len: vec entry length
- *	@offset: vec entry offset
- *	@same_page: return if the merge happen inside the same page
- *
- *	Attempt to add a page to the bio_vec maplist. This can fail for a
- *	number of reasons, such as the bio being full or target block device
- *	limitations. The target block device must allow bio's up to PAGE_SIZE,
- *	so it is always possible to add a single page to an empty bio.
- *
- *	This should only be used by passthrough bios.
+/*
+ * Add a page to a bio while respecting the hardware max_sectors, max_segment
+ * and gap limitations.
  */
-int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
-		bool *same_page)
+		unsigned int max_sectors, bool *same_page)
 {
 	struct bio_vec *bvec;
 
-	/*
-	 * cloned bio must not modify vec list
-	 */
-	if (unlikely(bio_flagged(bio, BIO_CLONED)))
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
-	if (((bio->bi_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
+	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		if (bio_try_merge_pc_page(q, bio, page, len, offset, same_page))
+		if (bio_try_merge_hw_seg(q, bio, page, len, offset, same_page))
 			return len;
 
 		/*
@@ -823,11 +813,27 @@ int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	return len;
 }
 
+/**
+ * bio_add_pc_page	- attempt to add page to passthrough bio
+ * @q: the target queue
+ * @bio: destination bio
+ * @page: page to add
+ * @len: vec entry length
+ * @offset: vec entry offset
+ *
+ * Attempt to add a page to the bio_vec maplist. This can fail for a
+ * number of reasons, such as the bio being full or target block device
+ * limitations. The target block device must allow bio's up to PAGE_SIZE,
+ * so it is always possible to add a single page to an empty bio.
+ *
+ * This should only be used by passthrough bios.
+ */
 int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset)
 {
 	bool same_page = false;
-	return __bio_add_pc_page(q, bio, page, len, offset, &same_page);
+	return bio_add_hw_page(q, bio, page, len, offset,
+			queue_max_hw_sectors(q), &same_page);
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
diff --git a/block/blk-map.c b/block/blk-map.c
index b72c361911a4..f36ff496a761 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -257,6 +257,7 @@ static struct bio *bio_copy_user_iov(struct request_queue *q,
 static struct bio *bio_map_user_iov(struct request_queue *q,
 		struct iov_iter *iter, gfp_t gfp_mask)
 {
+	unsigned int max_sectors = queue_max_hw_sectors(q);
 	int j;
 	struct bio *bio;
 	int ret;
@@ -294,8 +295,8 @@ static struct bio *bio_map_user_iov(struct request_queue *q,
 				if (n > bytes)
 					n = bytes;
 
-				if (!__bio_add_pc_page(q, bio, page, n, offs,
-						&same_page)) {
+				if (!bio_add_hw_page(q, bio, page, n, offs,
+						     max_sectors, &same_page)) {
 					if (same_page)
 						put_page(page);
 					break;
diff --git a/block/blk.h b/block/blk.h
index 0a94ec68af32..ba31511c5243 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -484,8 +484,8 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 
 struct request_queue *__blk_alloc_queue(int node_id);
 
-int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
-		bool *same_page);
+		unsigned int max_sectors, bool *same_page);
 
 #endif /* BLK_INTERNAL_H */
-- 
2.24.1

