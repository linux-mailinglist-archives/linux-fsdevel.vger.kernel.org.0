Return-Path: <linux-fsdevel+bounces-75434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABGxJCQCd2maaQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:56:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED29844F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE0C303C62B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E659D2367B5;
	Mon, 26 Jan 2026 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AXhQlF/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7D2222C5;
	Mon, 26 Jan 2026 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406901; cv=none; b=bpgwrDN5aHUSDDqBC2pRwaX1ICtxVFzIFU6RSdiFhTywjQOgqGe2HmbKgBHUs+tuJ+8lyyFfRrvA/wLWuT9OdVPIEsRLXbsfh0QYJiBCzJdGhPoKbaE838sQeBo3DaGZyteZKeD+QBj6FBkW4xDoIuQhxub+hQW5G2TfOKz4rw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406901; c=relaxed/simple;
	bh=RiP1hfEb1l+xd6feqKZR6yUmuPXHZ1gK4Ikd1dBHLBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZczgaP7WkP1HFpJ4LR5Kz3hFq5n6sDx78+mN29le5o4FnGGmeJXZuSeQ2Yi3OaDuBkxgZaCRjZqKWIR+3PUbgyBRF1mk0cWZGYxNbBKQ2HrbVfGVDxJ3mIY2r0pxfpUjzncYopWV3IIkAAnZFz8kStbkG3jKYICIfmrrwYomk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AXhQlF/L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gVAtpG3lRVkj5AfZnPSvxeWXWtkXyE7XeV0y+ppFJo0=; b=AXhQlF/L+nuyTc/RcAI3UtvOJG
	7CRJ2ummEdR/3+4rKaHwdmiFA3xC8vkK8BvBBZEngu1HGA6uz3NGKWdvN7ryfKuPgmE4nCGViTWmJ
	SeMGhpv527B7QTuY7C4+5WB+bWWFdWF+mz1kf/qjkhBDu2tkAUCh8MYSuhGfS63N6v+X9+DWhsRZD
	mLdZJh6jJIh0ght2uncNXqLPC2qZsjV2KLYwbXYhBxTKXVvD6yqaBDvmiPX0YmNKhveCfBRIh9ihX
	gIctQRL27pV/Wkcd6RUKDQqJ06Q7cxiCMYf54wgc5IRDRgzcPM0eQzsD0BiMEqJV6Ml+oC2n60Rh3
	Lt5zSyCw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkFYx-0000000BxI2-06zC;
	Mon, 26 Jan 2026 05:54:59 +0000
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
Subject: [PATCH 10/15] iomap: share code between iomap_dio_bio_end_io and iomap_finish_ioend_direct
Date: Mon, 26 Jan 2026 06:53:41 +0100
Message-ID: <20260126055406.1421026-11-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75434-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 3ED29844F1
X-Rspamd-Action: no action

Refactor the two per-bio completion handlers to share common code using
a new helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/direct-io.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bb79519dec65..c1d5db85c8c7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -211,16 +211,20 @@ static void iomap_dio_done(struct iomap_dio *dio)
 	iomap_dio_complete_work(&dio->aio.work);
 }
 
-void iomap_dio_bio_end_io(struct bio *bio)
+static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
 	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
 
-	if (bio->bi_status)
-		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
-
-	if (atomic_dec_and_test(&dio->ref))
+	if (atomic_dec_and_test(&dio->ref)) {
+		/*
+		 * Avoid another context switch for the completion when already
+		 * called from the ioend completion workqueue.
+		 */
+		if (inline_completion)
+			dio->flags &= ~IOMAP_DIO_COMP_WORK;
 		iomap_dio_done(dio);
+	}
 
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
@@ -229,33 +233,25 @@ void iomap_dio_bio_end_io(struct bio *bio)
 		bio_put(bio);
 	}
 }
+
+void iomap_dio_bio_end_io(struct bio *bio)
+{
+	struct iomap_dio *dio = bio->bi_private;
+
+	if (bio->bi_status)
+		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
+	__iomap_dio_bio_end_io(bio, false);
+}
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
 {
 	struct iomap_dio *dio = ioend->io_bio.bi_private;
-	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
 	u32 vec_count = ioend->io_bio.bi_vcnt;
 
 	if (ioend->io_error)
 		iomap_dio_set_error(dio, ioend->io_error);
-
-	if (atomic_dec_and_test(&dio->ref)) {
-		/*
-		 * Try to avoid another context switch for the completion given
-		 * that we are already called from the ioend completion
-		 * workqueue.
-		 */
-		dio->flags &= ~IOMAP_DIO_COMP_WORK;
-		iomap_dio_done(dio);
-	}
-
-	if (should_dirty) {
-		bio_check_pages_dirty(&ioend->io_bio);
-	} else {
-		bio_release_pages(&ioend->io_bio, false);
-		bio_put(&ioend->io_bio);
-	}
+	__iomap_dio_bio_end_io(&ioend->io_bio, true);
 
 	/*
 	 * Return the number of bvecs completed as even direct I/O completions
-- 
2.47.3


