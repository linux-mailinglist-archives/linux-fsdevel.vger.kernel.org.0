Return-Path: <linux-fsdevel+bounces-17746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C1F8B209A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B531C2368B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E40212AAE0;
	Thu, 25 Apr 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="pWAvZZwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413DE2AEF1;
	Thu, 25 Apr 2024 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045619; cv=none; b=ZyF3OFa36mPyAHsSr3rM0OjGS7ScVdD7HIOd/Gg7VAqkKiGe/oefuldk8X4uFQ4oQ0nbNsjhN24VpTtwmu3To9+L9JbgAVD2v0eweb/Kdz310u9dkI5NpKhZDADE62VtdbwXE8NV1xRgH8zkB6RgeS8CtjpMqeqvNMIgRec0UoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045619; c=relaxed/simple;
	bh=FjN1EFdP4B2GhhMcTneVme9zFeaY2F4Xx/iXsYn/4X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KTeT4qDsRXvbXlLoOifurM2t/uWVqPKtFOpMr54ZqofJAEzAnM666atA//KtN7EDlv3u461O8NEN4xEx2EGzAKEzWPJ/UkBW8GzxnNNIcslEctCU6HTfHYvV5zmydOhUSh8Q0Hk11NFmvWjMQplxtspxgI3xVCwOHMQ5Hua94uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=pWAvZZwL; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VQDPM5z88z9sqH;
	Thu, 25 Apr 2024 13:37:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714045079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwJiip//T+O8iHQnA8gIdy4HYh6WY6jnyehEbs5RfBY=;
	b=pWAvZZwLeRk248TadAtN1GDZWGqpWPg8DxfyFHbfGEdom2wHzQIoOrmK+RQpww2eBjxVN/
	NlABjkXV9Gjpd+TpwlZSMoEAu05F6/Mw4VOD8OXl16gp7AVgZDmbn+3JirgO4gTNK7Qe97
	at1vhk5t49j7z4wFdFwJ/Dldj6xrKudEaXOAuO4oLHfIb9yVzFAL0V+XZQJgUZJ9H6r0qy
	FxHC6gBCJyRluZh7j4XHD5DtA2ibCeDlVPUZUmymb4Uc4Trh/a0cO91qysuPW5S6GYYYdF
	XWAd/YEqQ4QNgruuoeC/0NDR0mnB2XMeaVxFPNnWkok5yOpWkSpxnlMjW1Xs5A==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: [PATCH v4 02/11] fs: Allow fine-grained control of folio sizes
Date: Thu, 25 Apr 2024 13:37:37 +0200
Message-Id: <20240425113746.335530-3-kernel@pankajraghav.com>
In-Reply-To: <20240425113746.335530-1-kernel@pankajraghav.com>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Some filesystems want to be able to ensure that folios that are added to
the page cache are at least a certain size.
Add mapping_set_folio_min_order() to allow this level of control.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/pagemap.h | 116 +++++++++++++++++++++++++++++++++-------
 1 file changed, 96 insertions(+), 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..2e5612de1749 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -202,13 +202,18 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
-	AS_LARGE_FOLIO_SUPPORT = 6,
-	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
-	AS_STABLE_WRITES,	/* must wait for writeback before modifying
+	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
+	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
 				   folio contents */
-	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
+	AS_FOLIO_ORDER_MIN = 8,
+	AS_FOLIO_ORDER_MAX = 13, /* Bit 8-17 are used for FOLIO_ORDER */
+	AS_UNMOVABLE = 18,		/* The mapping cannot be moved, ever */
 };
 
+#define AS_FOLIO_ORDER_MIN_MASK 0x00001f00
+#define AS_FOLIO_ORDER_MAX_MASK 0x0003e000
+#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
+
 /**
  * mapping_set_error - record a writeback error in the address_space
  * @mapping: the mapping in which an error should be set
@@ -344,9 +349,63 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+/*
+ * There are some parts of the kernel which assume that PMD entries
+ * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
+ * limit the maximum allocation order to PMD size.  I'm not aware of any
+ * assumptions about maximum order if THP are disabled, but 8 seems like
+ * a good order (that's 1MB if you're using 4kB pages)
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
+#else
+#define MAX_PAGECACHE_ORDER	8
+#endif
+
+/*
+ * mapping_set_folio_order_range() - Set the folio order range
+ * @mapping: The address_space.
+ * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
+ * @max: Maximum folio order (between @min-MAX_PAGECACHE_ORDER inclusive).
+ *
+ * The filesystem should call this function in its inode constructor to
+ * indicate which base size (min) and maximum size (max) of folio the VFS
+ * can use to cache the contents of the file.  This should only be used
+ * if the filesystem needs special handling of folio sizes (ie there is
+ * something the core cannot know).
+ * Do not tune it based on, eg, i_size.
+ *
+ * Context: This should not be called while the inode is active as it
+ * is non-atomic.
+ */
+static inline void mapping_set_folio_order_range(struct address_space *mapping,
+						 unsigned int min_order,
+						 unsigned int max_order)
+{
+	if (min_order > MAX_PAGECACHE_ORDER)
+		min_order = MAX_PAGECACHE_ORDER;
+
+	if (max_order > MAX_PAGECACHE_ORDER)
+		max_order = MAX_PAGECACHE_ORDER;
+
+	max_order = max(max_order, min_order);
+	/*
+	 * TODO: max_order is not yet supported in filemap.
+	 */
+	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
+			 (min_order << AS_FOLIO_ORDER_MIN) |
+			 (max_order << AS_FOLIO_ORDER_MAX);
+}
+
+static inline void mapping_set_folio_min_order(struct address_space *mapping,
+					       unsigned int min)
+{
+	mapping_set_folio_order_range(mapping, min, MAX_PAGECACHE_ORDER);
+}
+
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
- * @mapping: The file.
+ * @mapping: The address_space.
  *
  * The filesystem should call this function in its inode constructor to
  * indicate that the VFS can use large folios to cache the contents of
@@ -357,7 +416,37 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
-	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	mapping_set_folio_order_range(mapping, 0, MAX_PAGECACHE_ORDER);
+}
+
+static inline unsigned int mapping_max_folio_order(struct address_space *mapping)
+{
+	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
+}
+
+static inline unsigned int mapping_min_folio_order(struct address_space *mapping)
+{
+	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
+}
+
+static inline unsigned long mapping_min_folio_nrpages(struct address_space *mapping)
+{
+	return 1UL << mapping_min_folio_order(mapping);
+}
+
+/**
+ * mapping_align_start_index() - Align starting index based on the min
+ * folio order of the page cache.
+ * @mapping: The address_space.
+ *
+ * Ensure the index used is aligned to the minimum folio order when adding
+ * new folios to the page cache by rounding down to the nearest minimum
+ * folio number of pages.
+ */
+static inline pgoff_t mapping_align_start_index(struct address_space *mapping,
+						pgoff_t index)
+{
+	return round_down(index, mapping_min_folio_nrpages(mapping));
 }
 
 /*
@@ -367,7 +456,7 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
 	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	       (mapping_max_folio_order(mapping) > 0);
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
@@ -528,19 +617,6 @@ static inline void *detach_page_private(struct page *page)
 	return folio_detach_private(page_folio(page));
 }
 
-/*
- * There are some parts of the kernel which assume that PMD entries
- * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
- * limit the maximum allocation order to PMD size.  I'm not aware of any
- * assumptions about maximum order if THP are disabled, but 8 seems like
- * a good order (that's 1MB if you're using 4kB pages)
- */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
-#else
-#define MAX_PAGECACHE_ORDER	8
-#endif
-
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
 #else
-- 
2.34.1


