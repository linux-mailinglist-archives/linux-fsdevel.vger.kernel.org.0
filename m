Return-Path: <linux-fsdevel+bounces-75427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MUXM8EBd2maaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:55:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7EC84453
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64630302294B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F3223C503;
	Mon, 26 Jan 2026 05:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Wi6jggR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB3223336;
	Mon, 26 Jan 2026 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406867; cv=none; b=b/oc8Qy+yCnBePTdn0Q9FAw2rUn/FaRZU6qeJW7zZTEjRRV+JQFs2T/RRoT3n9/NlQAVjRF72TIcMMCWICebVH3QlSK6seEkfYwassgntVgNhm0TEbzQPmVtUu1RgLFSnxeWow+LZ7f7CMfmF01SQyFr6jvLpIP9T9CE/S40p9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406867; c=relaxed/simple;
	bh=HByR0s914SUB+7Rsaa0KBVeCi8Fv8nFJpiUlS5+7pYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQHYT2rJBeDthZsBhvtEjFzof+oDjHcQ7ALSHLOq+KAtAClKEiaZRgzwD3b1MjvoWp/VSCGx0nxT5gu8t0SoyU7mZWJZzlho4Ie/mx5iJTLQFJ5ejHI2yz+k14f81MHuBGuO982oYD17h3aHpvznrwfrCRPMK7hqORh6FJt/AhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1Wi6jggR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZJx5vU337yUaZZhcIr9QepFWkm0oyfnRMAEb48Qz2RY=; b=1Wi6jggRcYd+eLa0dR6EuVpE//
	UFmvntsSXkFzqVpZJhguASzCbuKpuF9N7f2yzSelW+8mlK6Li3OiHjoviuI77nPvv3E9LV2O4jFk1
	lGaBlgZWOKMkbYAB2Lfwu901SQ5E0BoKZFH+wNm9KHxDuN4i8vtpLiGNy2H2iwVm/ORSDzXYFp9Fc
	2atEjWzpYT4lXP1UTePChSPHiCggGuyly330vJTphUMmFy1xmnwePU262mEtxO2q38S8bjzIZMzrs
	WXb3yQnAojloNtwX7lxj+YQ5pKxsStWdOFIcibJnaUHdmeT43kg1+ajqWXfhzrNyYASnIBvku7hBY
	uKcCJuRg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFYO-0000000BxEu-3UzL;
	Mon, 26 Jan 2026 05:54:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/15] block: open code bio_add_page and fix handling of mismatching P2P ranges
Date: Mon, 26 Jan 2026 06:53:34 +0100
Message-ID: <20260126055406.1421026-4-hch@lst.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75427-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email,wdc.com:email,samsung.com:email]
X-Rspamd-Queue-Id: 6E7EC84453
X-Rspamd-Action: no action

bio_add_page fails to add data to the bio when mixing P2P with non-P2P
ranges, or ranges that map to different P2P providers.  In that case
it will trigger that WARN_ON and return an error up the chain instead of
simply starting a new bio as intended.  Fix this by open coding
bio_add_page and handling this case explicitly.  While doing so, stop
merging physical contiguous data that belongs to multiple folios.  While
this merge could lead to more efficient bio packing in some case,
dropping will allow to remove handling of this corner case in other
places and make the code more robust.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d633e80d821f..4591f0ba90f5 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1216,7 +1216,7 @@ static unsigned int get_contig_folio_len(struct page **pages,
  * For a multi-segment *iter, this function only adds pages from the next
  * non-empty segment of the iov iterator.
  */
-static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
+static ssize_t __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	iov_iter_extraction_t extraction_flags = 0;
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
@@ -1226,7 +1226,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	ssize_t size;
 	unsigned int i = 0;
 	size_t offset, left, len;
-	int ret = 0;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
@@ -1247,37 +1246,26 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
 	for (left = size; left > 0; left -= len) {
-		unsigned int old_vcnt = bio->bi_vcnt;
 		unsigned int nr_to_add;
 
-		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
-		if (!bio_add_page(bio, pages[i], len, offset)) {
-			WARN_ON_ONCE(1);
-			ret = -EINVAL;
-			goto out;
-		}
+		if (bio->bi_vcnt > 0) {
+			struct bio_vec *prev = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
-		if (bio_flagged(bio, BIO_PAGE_PINNED)) {
-			/*
-			 * We're adding another fragment of a page that already
-			 * was part of the last segment.  Undo our pin as the
-			 * page was pinned when an earlier fragment of it was
-			 * added to the bio and __bio_release_pages expects a
-			 * single pin per page.
-			 */
-			if (offset && bio->bi_vcnt == old_vcnt)
-				unpin_user_folio(page_folio(pages[i]), 1);
+			if (!zone_device_pages_have_same_pgmap(prev->bv_page,
+					pages[i]))
+				break;
 		}
+
+		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
+		__bio_add_page(bio, pages[i], len, offset);
 		i += nr_to_add;
 		offset = 0;
 	}
 
 	iov_iter_revert(iter, left);
-out:
 	while (i < nr_pages)
 		bio_release_page(bio, pages[i++]);
-
-	return ret;
+	return size - left;
 }
 
 /*
@@ -1337,7 +1325,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 			   unsigned len_align_mask)
 {
-	int ret = 0;
+	ssize_t ret;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
@@ -1350,9 +1338,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
+
 	do {
 		ret = __bio_iov_iter_get_pages(bio, iter);
-	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
+	} while (ret > 0 && iov_iter_count(iter) && !bio_full(bio, 0));
 
 	if (bio->bi_vcnt)
 		return bio_iov_iter_align_down(bio, iter, len_align_mask);
-- 
2.47.3


