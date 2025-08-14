Return-Path: <linux-fsdevel+bounces-57901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103B2B26996
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6961CE7608
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCFD19D8AC;
	Thu, 14 Aug 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="r9xClWN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C3432142A;
	Thu, 14 Aug 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181308; cv=none; b=bc2d8GHG211QDGY3wuCeq++RLGJnUrXyJcCCV2QLDF6A96IXRhxZ/nihrl/Q5pz+bizykAX/P7Ed/Z8sw6eeDaRy3gH45hW4hRuHUs4bhM/ilBIyLDmXERhiR7p3eprADLLh1RwBZcn7/EJsrCXankanVMmWGi7B0je17Yim4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181308; c=relaxed/simple;
	bh=RwyioGqHpNLArXgX5EMwEOrG2VbvcPLtrOSmzrNLb7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EC1c67vY50TMGe9U31W2FMHt1l+dOv7vJXvwyBZR1sLtsiZ9w+KhU+TMsEJsGsR3e9ZqVG3nZTkt+k+lqKIXVpOUiFU2NBXTDhze5q47YUgDhkUujFPYRv5JUvr3mKkuir1jTZpo7ifZn+mY/mGgQrM8Og1EKFYPGrdYibzEctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=r9xClWN3; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c2nVZ2T0xz9shX;
	Thu, 14 Aug 2025 16:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1755181302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TuUVUGDrxlPwL85eCorobk2whR7srtFUu6MloQXOaWE=;
	b=r9xClWN3bAYV76AT8/Dra0Dfa9BDhLnp6UW5BIR2M9wFNsyhwwWQ8jeYSj/Kv+Y/FryjEP
	WuWlv8Q1KZ99/kPXWmN9FPOAuWbP+fm6XeXJDXA8qhD7SFRuQgPhvTeGe0ACR5hHSvOKXP
	uqu42nXvQ4Jn5Z4neVeF97U+cy55EZKGWB0Rm81y44Ui45htFKGmyQS514y/eUO7e3D2hJ
	SwCVnfUHy+WIF/uzUmtpWUL+Yuj6o5qWEEZsCt/chZBVjzL08oY3yAyBGCCdrpJgphpvUF
	d5QEqqAUjl+GH6HtwX7co9D0gFmzD6iBkrzm9Tq3axMQvpuzSt95aEpru2ULcw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] iomap: use largest_zero_folio() in iomap_dio_zero()
Date: Thu, 14 Aug 2025 16:21:37 +0200
Message-ID: <20250814142137.45469-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4c2nVZ2T0xz9shX

From: Pankaj Raghav <p.raghav@samsung.com>

iomap_dio_zero() uses a custom allocated memory of zeroes for padding
zeroes. This was a temporary solution until there was a way to request a
zero folio that was greater than the PAGE_SIZE.

Use largest_zero_folio() function instead of using the custom allocated
memory of zeroes. There is no guarantee from largest_zero_folio()
function that it will always return a PMD sized folio. Adapt the code so
that it can also work if largest_zero_folio() returns a ZERO_PAGE.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/iomap/direct-io.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b84f6af2eb4c..a7a281ea3e50 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -24,13 +24,6 @@
 #define IOMAP_DIO_WRITE		(1U << 30)
 #define IOMAP_DIO_DIRTY		(1U << 31)
 
-/*
- * Used for sub block zeroing in iomap_dio_zero()
- */
-#define IOMAP_ZERO_PAGE_SIZE (SZ_64K)
-#define IOMAP_ZERO_PAGE_ORDER (get_order(IOMAP_ZERO_PAGE_SIZE))
-static struct page *zero_page;
-
 struct iomap_dio {
 	struct kiocb		*iocb;
 	const struct iomap_dio_ops *dops;
@@ -285,24 +278,35 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 {
 	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct bio *bio;
+	struct folio *zero_folio = largest_zero_folio();
+	int nr_vecs = max(1, i_blocksize(inode) / folio_size(zero_folio));
 
 	if (!len)
 		return 0;
+
 	/*
-	 * Max block size supported is 64k
+	 * This limit shall never be reached as most filesystems have a
+	 * maximum blocksize of 64k.
 	 */
-	if (WARN_ON_ONCE(len > IOMAP_ZERO_PAGE_SIZE))
+	if (WARN_ON_ONCE(nr_vecs > BIO_MAX_VECS))
 		return -EINVAL;
 
-	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
+	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs,
+				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 				  GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	__bio_add_page(bio, zero_page, len, 0);
+	while (len > 0) {
+		unsigned int io_len = min(len, folio_size(zero_folio));
+
+		bio_add_folio_nofail(bio, zero_folio, io_len, 0);
+		len -= io_len;
+	}
 	iomap_dio_submit_bio(iter, dio, bio, pos);
+
 	return 0;
 }
 
@@ -822,15 +826,3 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	return iomap_dio_complete(dio);
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
-
-static int __init iomap_dio_init(void)
-{
-	zero_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
-				IOMAP_ZERO_PAGE_ORDER);
-
-	if (!zero_page)
-		return -ENOMEM;
-
-	return 0;
-}
-fs_initcall(iomap_dio_init);

base-commit: 931e46dcbc7e6035a90e9c4a27a84b660e083f0a
-- 
2.50.1


