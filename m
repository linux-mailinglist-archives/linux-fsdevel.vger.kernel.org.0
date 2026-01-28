Return-Path: <linux-fsdevel+bounces-75758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBEqHFQ9emlB4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:46:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD4EA6146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACCE532BE4FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979A30FC16;
	Wed, 28 Jan 2026 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sK4ZLftj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810972417C6;
	Wed, 28 Jan 2026 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616969; cv=none; b=oy7vxP8D1NR9M6udwlLqYI/arNvGMOn55Zl4RYZLETPBHdI5C7qjCTglqf5ZIpXSIWCpPcGpQ9ciN32q6pf5r/WvJCJ3wyKWDkYJ3waHCBpNerJjT2CczQ05diUgTNNyNEcN7GqVIToPgGmphK5O/3I5lxlMLwzLnn6zI7QQAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616969; c=relaxed/simple;
	bh=qnB/GGJvy1ZdSQ5Uwv9vm1K2/xChzCo7uhkZp5J7Eac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itVsBpTvH/tipEazeke9x6yllkZgEZwE/Axxawwu3S2kgJLPmGvfJlDn+O0wPgJYTAnZwjQ4T9V1yTC332Jx4LLJapr1jFC86obXY0MENxhu2aEZVoWgq7MmM3DP74SQQ9+V4FR+4pxYrRCfUtYgVbXchQgYWc2XTbrx7mlbTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sK4ZLftj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FGWxq6GOgdNG9LB80h5Lsank5Dr7Bs+9g9TDZSCymnY=; b=sK4ZLftjffel1qoG4Z1g7b9FVe
	ycsKl+bPHfoN3xrySpBUuQLS/RujW29+483J8t5xbVLFV8yWfpzfEamY0dHO5yvQLLy++7YOYdV4L
	1oW2en5JNqDfqw3J1nF0sOBuuGhpo+tl0sPhcN1zoLtQf1WcDfJX6mnu1o5AeDJ8e/8mr8ghOdwUN
	+URyC1YSsbY8rj1e3Pd4p3BxUrVeSAMPTXo2D7PaXe2Qsk6KntACiCDVzNF4rVKfriTuaRcsv5rrF
	gdIFiITaU/eWtBnp1rD/SBshKOaAYFKrYfZjJh+ZDDb19vl3lPJZwaMxKT1JQPyo/wgUy09TnFgIM
	fhPs2v1Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8D9-0000000GN0p-06rA;
	Wed, 28 Jan 2026 16:16:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 07/15] block: pass a maxlen argument to bio_iov_iter_bounce
Date: Wed, 28 Jan 2026 17:15:02 +0100
Message-ID: <20260128161517.666412-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128161517.666412-1-hch@lst.de>
References: <20260128161517.666412-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75758-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,samsung.com:email,infradead.org:dkim,lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BD4EA6146
X-Rspamd-Action: no action

Allow the file system to limit the size processed in a single
bounce operation.  This is needed when generating integrity data
so that the size of a single integrity segment can't overflow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio.c          | 17 ++++++++++-------
 fs/iomap/direct-io.c |  2 +-
 include/linux/bio.h  |  2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 49f7548a31d6..44bfd1b435a2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1293,9 +1293,10 @@ static void bio_free_folios(struct bio *bio)
 	}
 }
 
-static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter)
+static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
+		size_t maxlen)
 {
-	size_t total_len = iov_iter_count(iter);
+	size_t total_len = min(maxlen, iov_iter_count(iter));
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EINVAL;
@@ -1333,9 +1334,10 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter)
 	return 0;
 }
 
-static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
+static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
+		size_t maxlen)
 {
-	size_t len = min(iov_iter_count(iter), SZ_1M);
+	size_t len = min3(iov_iter_count(iter), maxlen, SZ_1M);
 	struct folio *folio;
 
 	folio = folio_alloc_greedy(GFP_KERNEL, &len);
@@ -1372,6 +1374,7 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
  * bio_iov_iter_bounce - bounce buffer data from an iter into a bio
  * @bio:	bio to send
  * @iter:	iter to read from / write into
+ * @maxlen:	maximum size to bounce
  *
  * Helper for direct I/O implementations that need to bounce buffer because
  * we need to checksum the data or perform other operations that require
@@ -1379,11 +1382,11 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
  * copies the data into it.  Needs to be paired with bio_iov_iter_unbounce()
  * called on completion.
  */
-int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter)
+int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen)
 {
 	if (op_is_write(bio_op(bio)))
-		return bio_iov_iter_bounce_write(bio, iter);
-	return bio_iov_iter_bounce_read(bio, iter);
+		return bio_iov_iter_bounce_write(bio, iter, maxlen);
+	return bio_iov_iter_bounce_read(bio, iter, maxlen);
 }
 
 static void bvec_unpin(struct bio_vec *bv, bool mark_dirty)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9c572de0d596..952815eb5992 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -326,7 +326,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
 	if (dio->flags & IOMAP_DIO_BOUNCE)
-		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
+		ret = bio_iov_iter_bounce(bio, dio->submit.iter, BIO_MAX_SIZE);
 	else
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
 					     alignment - 1);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 69d56b1d1bd2..7955916cc69f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -473,7 +473,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
 
-int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter);
+int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter, size_t maxlen);
 void bio_iov_iter_unbounce(struct bio *bio, bool is_error, bool mark_dirty);
 
 extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
-- 
2.47.3


