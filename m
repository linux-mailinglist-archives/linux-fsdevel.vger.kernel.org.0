Return-Path: <linux-fsdevel+bounces-75425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HQmCJMBd2mMaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:54:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C28843F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 069D230088A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0A423AB9D;
	Mon, 26 Jan 2026 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jICsvcH8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994632222C5;
	Mon, 26 Jan 2026 05:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406858; cv=none; b=FjZxehf55cNqT1oZV/Yp4LpFw25OLwQvyBbaaZ4XDdInKrsBQhoiLwvnnLsNpS5dwMrcnp8czDGGtXzOD2PUax56XAXjX1kDuuuSmIj60KjIxr6KW5Eo5dufwy36Q09NkJHaTgEQmoi6IYGjvEQ+DWsSLI56rBuPjOvJfUeFS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406858; c=relaxed/simple;
	bh=9Y5w0qI0cH+z03GNmCD0acLau7OKPhMLFipARVzBWYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UH2WH799S/0aNi0Wps+kv2qyqCfev9gK9bQEoFDPE2BHA8iB3lH0qlxBhUCq5CWAhpR8UFQd0ngERg2/eQFY0Z89EWeYen40GgP7mjOBx40VHUZDeqrsZ88RcfHyXLtODClLI0mP9ONUxwaZmO353/nFc/2076uJKn+jsq2EQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jICsvcH8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0hJ4tNuQMyNNeNb8EhwXyZU5SyFM5k9RHy/MXN0+4+Q=; b=jICsvcH8WlJ/KVeBep8NHjZaCO
	e2pCR4JJTaA3fN7ljLh7rmyx7oenxGxl5gohz6yuXeICsXFN/9KVFcwgLF1Dkvw1G6YAH0dYTANkv
	D4O1pl8R/6in8B/mn/Y3rE4E9j27QPK3DU0nxngyV2vXdCcaG1qqvIfrn5ZofLUBgNHooFu4L8x/I
	e/qhLSG0/UGsYjv5e2si+UeQf5ZjkjfgucTRrj3r4b3IaF5ofIQCTH5JV/bOyhbd5W+815+xik+cl
	vr6MZg7FpNekO+EayDr3WoBYcNohT/a6PB0F7X1OtGmlUbnXOy/u6qFPR1SzoPeTgO3v8YjzSrJtV
	bzRfzzRg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFYG-0000000BxEf-0c6N;
	Mon, 26 Jan 2026 05:54:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/15] block: add a BIO_MAX_SIZE constant and use it
Date: Mon, 26 Jan 2026 06:53:32 +0100
Message-ID: <20260126055406.1421026-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
References: <20260126055406.1421026-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75425-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: C5C28843F3
X-Rspamd-Action: no action

Currently the only constant for the maximum bio size is BIO_MAX_SECTORS,
which is in units of 512-byte sectors, but a lot of user need a byte
limit.

Add a BIO_MAX_SIZE constant, redefine BIO_MAX_SECTORS in terms of it, and
switch all bio-related uses of UINT_MAX for the maximum size to use the
symbolic names instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c               | 10 +++++-----
 block/blk-lib.c           |  9 ++++-----
 block/blk-merge.c         |  8 ++++----
 include/linux/blk_types.h |  3 ++-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 2359c0723b88..ac7703e149c6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -924,7 +924,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 {
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return true;
-	if (bio->bi_iter.bi_size > UINT_MAX - len)
+	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)
 		return true;
 	return false;
 }
@@ -1030,7 +1030,7 @@ int bio_add_page(struct bio *bio, struct page *page,
 {
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
-	if (bio->bi_iter.bi_size > UINT_MAX - len)
+	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
@@ -1057,7 +1057,7 @@ void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 {
 	unsigned long nr = off / PAGE_SIZE;
 
-	WARN_ON_ONCE(len > UINT_MAX);
+	WARN_ON_ONCE(len > BIO_MAX_SIZE);
 	__bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE);
 }
 EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
@@ -1081,7 +1081,7 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 {
 	unsigned long nr = off / PAGE_SIZE;
 
-	if (len > UINT_MAX)
+	if (len > BIO_MAX_SIZE)
 		return false;
 	return bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE) > 0;
 }
@@ -1238,7 +1238,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		extraction_flags |= ITER_ALLOW_P2PDMA;
 
 	size = iov_iter_extract_pages(iter, &pages,
-				      UINT_MAX - bio->bi_iter.bi_size,
+				      BIO_MAX_SIZE - bio->bi_iter.bi_size,
 				      nr_pages, extraction_flags, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9e2cc58f881f..0be3acdc3eb5 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -32,7 +32,7 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 	 * Align the bio size to the discard granularity to make splitting the bio
 	 * at discard granularity boundaries easier in the driver if needed.
 	 */
-	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
+	return round_down(BIO_MAX_SIZE, discard_granularity) >> SECTOR_SHIFT;
 }
 
 struct bio *blk_alloc_discard_bio(struct block_device *bdev,
@@ -107,8 +107,7 @@ static sector_t bio_write_zeroes_limit(struct block_device *bdev)
 {
 	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 
-	return min(bdev_write_zeroes_sectors(bdev),
-		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
+	return min(bdev_write_zeroes_sectors(bdev), BIO_MAX_SECTORS & ~bs_mask);
 }
 
 /*
@@ -337,8 +336,8 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 	int ret = 0;
 
 	/* make sure that "len << SECTOR_SHIFT" doesn't overflow */
-	if (max_sectors > UINT_MAX >> SECTOR_SHIFT)
-		max_sectors = UINT_MAX >> SECTOR_SHIFT;
+	if (max_sectors > BIO_MAX_SECTORS)
+		max_sectors = BIO_MAX_SECTORS;
 	max_sectors &= ~bs_mask;
 
 	if (max_sectors == 0)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index b82c6d304658..0eb0aef97197 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -95,13 +95,13 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
 }
 
 /*
- * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
- * is defined as 'unsigned int', meantime it has to be aligned to with the
+ * The maximum size that a bio can fit has to be aligned down to the
  * logical block size, which is the minimum accepted unit by hardware.
  */
 static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
 {
-	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
+	return round_down(BIO_MAX_SIZE, lim->logical_block_size) >>
+			SECTOR_SHIFT;
 }
 
 /*
@@ -502,7 +502,7 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 
 	rq_for_each_bvec(bv, rq, iter)
 		bvec_split_segs(&rq->q->limits, &bv, &nr_phys_segs, &bytes,
-				UINT_MAX, UINT_MAX);
+				UINT_MAX, BIO_MAX_SIZE);
 	return nr_phys_segs;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 19a888a2f104..d59553324a84 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -281,7 +281,8 @@ struct bio {
 };
 
 #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
-#define BIO_MAX_SECTORS		(UINT_MAX >> SECTOR_SHIFT)
+#define BIO_MAX_SIZE		UINT_MAX /* max value of bi_iter.bi_size */
+#define BIO_MAX_SECTORS		(BIO_MAX_SIZE >> SECTOR_SHIFT)
 
 static inline struct bio_vec *bio_inline_vecs(struct bio *bio)
 {
-- 
2.47.3


