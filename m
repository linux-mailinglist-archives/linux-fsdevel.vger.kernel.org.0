Return-Path: <linux-fsdevel+bounces-18909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB948BE6C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3451C238F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1511161911;
	Tue,  7 May 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="iIOQShVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9716132B;
	Tue,  7 May 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093932; cv=none; b=p+0aoq0GipcW/FzEjHLXaBPpU+VaxN5dlVQhDr1FreBmktxEXcwxD5wrYFKTxB4tNJKyfiaeQnKNv2fyjJSJYd47F2tcQ1LibSa9BfaeJLSFht7RoXBmtppd61anZr0b42t5wU9vwqic9F/7mCltZ+G0dMaAK3dhz3FEYEkL3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093932; c=relaxed/simple;
	bh=4MpifA+N47dI2Zo3BlsZjWbAJOG/C+o+WSbE9zSoglA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PEUBQRSD9U7ffmmvXmA+w1SJOmlf9ARQZ6IYDRDGgg0i2ePGNf9KhMoOavHt4P8Z55Y3bzeEyg8k1MCveLC73jhLw3UeKlYyYbreCLapiaitU2RkJLU5ITzXPV+x+rCRLxcmInwCKDt4KIRZ1LvgPFyDfjBkl8oRnxJqEXu6XmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=iIOQShVl; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VYhHT4qmNz9sd6;
	Tue,  7 May 2024 16:58:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715093925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4BxBuTRaRH2Icv5CxaP0p6s54rUUSgkZ15W6zrfzYQ=;
	b=iIOQShVl6oyIultqxr0Zh0jmWet+S/bPIQv8kiORbz4m3wvOnGDEc6ZSEdiPiIwJBxkdax
	gue+lspS1QNXVxkBcVmCx5y83WhPe5Ios/fLrQSv2aBKeLuObTyg5V5YSP7ovzWBRvUJf8
	rDNu7yl9cmBDhy/rBfbclICwyIMTVdeVnMBQTLZt3DNQwMMA4mnIfj/zZQXoBsTubvdHB9
	mplnIDFmivgPZH81/IBYfaFYKll+02u6H6Sphe55j0wHE2JaCQ1wAH5ovWWis3FltlvEMr
	RAZp+Ic8jQpeZiMHaRpkqe/dmrlsrf1kB+6ztKqL5N3Vs1nV18K5F1SUs/5KJA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: hch@lst.de,
	willy@infradead.org
Cc: mcgrof@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	chandan.babu@oracle.com,
	david@fromorbit.com,
	djwong@kernel.org,
	gost.dev@samsung.com,
	hare@suse.de,
	john.g.garry@oracle.com,
	kernel@pankajraghav.com,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	p.raghav@samsung.com,
	ritesh.list@gmail.com,
	ziy@nvidia.com
Subject: [RFC] iomap: use huge zero folio in iomap_dio_zero
Date: Tue,  7 May 2024 16:58:12 +0200
Message-Id: <20240507145811.52987-1-kernel@pankajraghav.com>
In-Reply-To: <20240503095353.3798063-8-mcgrof@kernel.org>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Instead of looping with ZERO_PAGE, use a huge zero folio to zero pad the
block. Fallback to ZERO_PAGE if mm_get_huge_zero_folio() fails.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
I rebased on top of mm-unstable to get mm_get_huge_zero_folio().

@Christoph is this inline with what you had in mind?

 fs/iomap/direct-io.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5f481068de5b..7f584f9ff2c5 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -236,11 +236,18 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 		loff_t pos, unsigned len)
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
-	struct page *page = ZERO_PAGE(0);
+	struct folio *zero_page_folio = page_folio(ZERO_PAGE(0));
+	struct folio *folio = zero_page_folio;
 	struct bio *bio;
 
 	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
 
+	if (len > PAGE_SIZE) {
+		folio = mm_get_huge_zero_folio(current->mm);
+		if (!folio)
+			folio = zero_page_folio;
+	}
+
 	bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
 				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
@@ -251,10 +258,10 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
 	while (len) {
-		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
+		unsigned int size = min(len, folio_size(folio));
 
-		__bio_add_page(bio, page, io_len, 0);
-		len -= io_len;
+		bio_add_folio_nofail(bio, folio, size, 0);
+		len -= size;
 	}
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
-- 
2.34.1


