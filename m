Return-Path: <linux-fsdevel+bounces-75438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMPDI1kCd2maaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:57:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A784535
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C410304500F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD22367B5;
	Mon, 26 Jan 2026 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uVfOq6DS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3521B191;
	Mon, 26 Jan 2026 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406930; cv=none; b=pAYo8lN2xkcxQK+Ot0k6o4zzM9mB8M5KnulBOIRFMBuMZLwGH13Ta2yGy8h5Ew6EpxP4DFHx18xWa8dsDt7ToHLRDWxjqEs1vjF7zLgBbeF256/s5Nzr+Wpx9q7gciItSkTAlFpC57DB1hMzV2VKs8nVdMZdxHSb1EgvuBWK8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406930; c=relaxed/simple;
	bh=eYKbJcLIKoEkxLkzBvWImVN/VIxeUXq1HHEE0i7dS+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b67r0pxY/BI+6ZjhCHKPc/q/UZts8gWXjam8k7N+qNoF6eRnRYrmQ9EmCNMk2tVTcJIiDjrSw7xrgS2mAlI2CyVEUlXwdzBYuZt8jci6Ba5q35TTc99hVOjT+1clkC6vHoTZl51H8Pbx73jC+ugQDLmnnE8UkKmZB6t017/Ma3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uVfOq6DS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WRgJod/PP0aXaEDwSfTEvS48Fw8419qw0B3MSReS9jc=; b=uVfOq6DSgQYdmjcWxSrZKlCPEr
	0TPWitFjHExljbP51KGxxU8x4Ws/N984lyHDRdTkk5RWRhNnwp/q94HlXPwMTgxLlDnxByzmm8zHn
	4qfKAxoqYySWIKlJejep2t/o+Sf+JHBGNxXOdfV811CNTTU4IqzuCs+mko6cfdNatf8WxboHMsTIj
	eq888NbCY8NVooHyW05nsal8hTxdj7TSdv2HCGnncQFJlyEnVPESKozXU7JNptPwd5UfF6Uf2KzUV
	wOs4UnIJF0GrUSVgExoXtiLRNKCM2Inv/h0kcoXvTgPZ6NZGV2NzhmoY3v4BScbB7N9WHSTLkkVgw
	NLfADjgw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFZP-0000000BxLP-3zKR;
	Mon, 26 Jan 2026 05:55:28 +0000
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
	Damien Le Moal <dlemoal@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 14/15] iomap: add a flag to bounce buffer direct I/O
Date: Mon, 26 Jan 2026 06:53:45 +0100
Message-ID: <20260126055406.1421026-15-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75438-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email,samsung.com:email]
X-Rspamd-Queue-Id: 163A784535
X-Rspamd-Action: no action

Add a new flag that request bounce buffering for direct I/O.  This is
needed to provide the stable pages requirement requested by devices
that need to calculate checksums or parity over the data and allows
file systems to properly work with things like T10 protection
information.  The implementation just calls out to the new bio bounce
buffering helpers to allocate a bounce buffer, which is used for
I/O and to copy to/from it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/direct-io.c  | 30 ++++++++++++++++++++----------
 include/linux/iomap.h |  9 +++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index eca7adda595a..9c572de0d596 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -215,7 +215,11 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
 
-	if (dio->flags & IOMAP_DIO_USER_BACKED) {
+	if (dio->flags & IOMAP_DIO_BOUNCE) {
+		bio_iov_iter_unbounce(bio, !!dio->error,
+				dio->flags & IOMAP_DIO_USER_BACKED);
+		bio_put(bio);
+	} else if (dio->flags & IOMAP_DIO_USER_BACKED) {
 		bio_check_pages_dirty(bio);
 	} else {
 		bio_release_pages(bio, false);
@@ -303,12 +307,16 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 		struct iomap_dio *dio, loff_t pos, unsigned int alignment,
 		blk_opf_t op)
 {
+	unsigned int nr_vecs;
 	struct bio *bio;
 	ssize_t ret;
 
-	bio = iomap_dio_alloc_bio(iter, dio,
-			bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS),
-			op);
+	if (dio->flags & IOMAP_DIO_BOUNCE)
+		nr_vecs = bio_iov_bounce_nr_vecs(dio->submit.iter, op);
+	else
+		nr_vecs = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
+
+	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs, op);
 	fscrypt_set_bio_crypt_ctx(bio, iter->inode,
 			pos >> iter->inode->i_blkbits, GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
@@ -317,7 +325,11 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	ret = bio_iov_iter_get_pages(bio, dio->submit.iter, alignment - 1);
+	if (dio->flags & IOMAP_DIO_BOUNCE)
+		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
+	else
+		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
+					     alignment - 1);
 	if (unlikely(ret))
 		goto out_put_bio;
 	ret = bio->bi_iter.bi_size;
@@ -333,7 +345,8 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 
 	if (dio->flags & IOMAP_DIO_WRITE)
 		task_io_account_write(ret);
-	else if (dio->flags & IOMAP_DIO_USER_BACKED)
+	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
+		 !(dio->flags & IOMAP_DIO_BOUNCE))
 		bio_set_pages_dirty(bio);
 
 	/*
@@ -662,7 +675,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->i_size = i_size_read(inode);
 	dio->dops = dops;
 	dio->error = 0;
-	dio->flags = 0;
+	dio->flags = dio_flags & (IOMAP_DIO_FSBLOCK_ALIGNED | IOMAP_DIO_BOUNCE);
 	dio->done_before = done_before;
 
 	dio->submit.iter = iter;
@@ -671,9 +684,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
-		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
-
 	if (iov_iter_rw(iter) == READ) {
 		if (iomi.pos >= dio->i_size)
 			goto out_free_dio;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 520e967cb501..cf152f638665 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -562,6 +562,15 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_FSBLOCK_ALIGNED	(1 << 3)
 
+/*
+ * Bounce buffer instead of using zero copy access.
+ *
+ * This is needed if the device needs stable data to checksum or generate
+ * parity.  The file system must hook into the I/O submission and offload
+ * completions to user context for reads when this is set.
+ */
+#define IOMAP_DIO_BOUNCE		(1 << 4)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.47.3


