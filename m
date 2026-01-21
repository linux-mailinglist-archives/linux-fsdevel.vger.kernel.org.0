Return-Path: <linux-fsdevel+bounces-74802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGRsB7J2cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:48:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D086B52500
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FE0742123F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E037644CAEC;
	Wed, 21 Jan 2026 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ft1ogjO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BEB44BC82;
	Wed, 21 Jan 2026 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977856; cv=none; b=lZICG4KieVPvxmpaSLHYBaPpTls6vyEG3YmqY1S7yBGjvzRHQ7l7kokRwIuX4gO3NkfpFgdaNsa7GeObjKCbIWqxPnW2ocWKyfytzxQIHsHi3UUwBje1KC8E/piJZX/W8145tGTJtROQieW4Uvx1ukMs5wFtVZ9PJwFwl2/Hcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977856; c=relaxed/simple;
	bh=JR28xsU8vf4zSXK9dmN1gJ8KCqFCl77Tih95+BHtfMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEmA1xgEbnyF/tN+PZNqA7kl2EgOXn0eCzBdOGn/5RcDAh+jCn3DCv/hIxHpsOXyhVwMGxQbpm6uBb0v4L3iz6Ca1HBmLtgPSmRS0hNZpPkp9dVcoi39fU1CqbrrT2EhL31tWpxVHsEHA/xVQDQAAp/sEfnOjH4P9fYn5/N64eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ft1ogjO8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZdF3jpDMJP4Yjtgho6/OFc4jeGPLOpm9mr+lGwpZZgM=; b=Ft1ogjO8ycRLGdPXUhph85LXCv
	dcicty+R3F27Y2puHG9DuddDzgVmjWdwsnRGppozV03gUiM86EL9hXI/J/8qBTGw3WySgqIWgZdwM
	U2LvKJ6M8weSTtQxtkrNgEhOUn7q0B3O61CM71cIW2RTxNu+z0CxS03/VKIybiakRmiVUNiI0FmvF
	BODjC/mo7BLOGCRgwxSoSfXioEyikeCRYvJVSdu4+BFQO46xQpDeGdNfK3uYhYj5fVf1AesX17Lsk
	2kvpZG3+eMoLAQiBtBkbrfRDe1P7vP0ZF0MBbGbfum3O9oWPG2O+IFp4sthS774CH5MVgtzGFmTxh
	5L+b+e9g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRwr-00000004xa0-23T4;
	Wed, 21 Jan 2026 06:44:13 +0000
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
Subject: [PATCH 06/15] block: add fs_bio_integrity helpers
Date: Wed, 21 Jan 2026 07:43:14 +0100
Message-ID: <20260121064339.206019-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121064339.206019-1-hch@lst.de>
References: <20260121064339.206019-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74802-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,lst.de:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,infradead.org:dkim]
X-Rspamd-Queue-Id: D086B52500
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a set of helpers for file system initiated integrity information.
These include mempool backed allocations and verifying based on a passed
in sector and size which is often available from file system completion
routines.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile                |  2 +-
 block/bio-integrity-fs.c      | 81 +++++++++++++++++++++++++++++++++++
 include/linux/bio-integrity.h |  6 +++
 3 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 block/bio-integrity-fs.c

diff --git a/block/Makefile b/block/Makefile
index c65f4da93702..7dce2e44276c 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -26,7 +26,7 @@ bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
 
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o \
-				   bio-integrity-auto.o
+				   bio-integrity-auto.o bio-integrity-fs.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
 obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
new file mode 100644
index 000000000000..c8b3c753965d
--- /dev/null
+++ b/block/bio-integrity-fs.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Christoph Hellwig.
+ */
+#include <linux/blk-integrity.h>
+#include <linux/bio-integrity.h>
+#include "blk.h"
+
+struct fs_bio_integrity_buf {
+	struct bio_integrity_payload	bip;
+	struct bio_vec			bvec;
+};
+
+static struct kmem_cache *fs_bio_integrity_cache;
+static mempool_t fs_bio_integrity_pool;
+
+void fs_bio_integrity_alloc(struct bio *bio)
+{
+	struct fs_bio_integrity_buf *iib;
+	unsigned int action;
+
+	action = bio_integrity_action(bio);
+	if (!action)
+		return;
+
+	iib = mempool_alloc(&fs_bio_integrity_pool, GFP_NOIO);
+	bio_integrity_init(bio, &iib->bip, &iib->bvec, 1);
+
+	bio_integrity_alloc_buf(bio, action & BI_ACT_ZERO);
+	if (action & BI_ACT_CHECK)
+		bio_integrity_setup_default(bio);
+}
+
+void fs_bio_integrity_free(struct bio *bio)
+{
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
+	bio_integrity_free_buf(bip);
+	mempool_free(container_of(bip, struct fs_bio_integrity_buf, bip),
+			&fs_bio_integrity_pool);
+
+	bio->bi_integrity = NULL;
+	bio->bi_opf &= ~REQ_INTEGRITY;
+}
+
+void fs_bio_integrity_generate(struct bio *bio)
+{
+	fs_bio_integrity_alloc(bio);
+	bio_integrity_generate(bio);
+}
+EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
+
+int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
+	/*
+	 * Reinitialize bip->bit_iter.
+	 *
+	 * This is for use in the submitter after the driver is done with the
+	 * bio. Requires the submitter to remember the sector and the size.
+	 */
+
+	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
+	bip->bip_iter.bi_sector = sector;
+	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
+	return blk_status_to_errno(bio_integrity_verify(bio, &bip->bip_iter));
+}
+
+static int __init fs_bio_integrity_init(void)
+{
+	fs_bio_integrity_cache = kmem_cache_create("fs_bio_integrity",
+			sizeof(struct fs_bio_integrity_buf), 0,
+			SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
+	if (mempool_init_slab_pool(&fs_bio_integrity_pool, BIO_POOL_SIZE,
+			fs_bio_integrity_cache))
+		panic("fs_bio_integrity: can't create pool\n");
+	return 0;
+}
+fs_initcall(fs_bio_integrity_init);
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 232b86b9bbcb..503dc9bc655d 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -145,4 +145,10 @@ void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer);
 void bio_integrity_free_buf(struct bio_integrity_payload *bip);
 void bio_integrity_setup_default(struct bio *bio);
 
+void fs_bio_integrity_alloc(struct bio *bio);
+void fs_bio_integrity_free(struct bio *bio);
+void fs_bio_integrity_generate(struct bio *bio);
+int fs_bio_integrity_verify(struct bio *bio, sector_t sector,
+		unsigned int size);
+
 #endif /* _LINUX_BIO_INTEGRITY_H */
-- 
2.47.3


