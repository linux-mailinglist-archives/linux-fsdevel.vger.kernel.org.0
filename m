Return-Path: <linux-fsdevel+bounces-26032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3026C952BD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F69A1C216BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BD01DD3B3;
	Thu, 15 Aug 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="umcQCzS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5413B1DC46D;
	Thu, 15 Aug 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712961; cv=none; b=a47ec5pUtM0B/fn7i9Fu4/Hu08T1zpBUSkQlzIJ33ySOTlcEt9oeWBKnAEic7Xt8mY2fq33bzChlzEfEHeLSFpBS0IXC8YKKXwjyxIUqstKxgkJ86TtWEI+v2ewgJVtIIgQCJjhoqJF8cbeTKu92VfBBkKdohTQRG8kPVKNOakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712961; c=relaxed/simple;
	bh=rBvfylU2Onf5FRt5ctIqlyvQcR2jYpp92TZbVdpw0J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB/PhQSwCwFw5o+vkrRFI8KQrVlaxp31cLWj63JSP7Kri4nqe9t28k/cWLMWcbwJJkVa5rZhoOxRv/6bLhobI5mKD4F4fJfctQ+qgnE75kNGgFa94FezLiNSraOtvdIhTYSCmmH0ZXR+Sz7qV3pxx/1oligALrEF2n/QhuDyeuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=umcQCzS1; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wkznt3Q2Xz9sm9;
	Thu, 15 Aug 2024 11:09:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723712946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0tiHABEgqhnV2gJwGru6HzUMC13qjezx2teK4ST2MU=;
	b=umcQCzS10ETZJ+vn2ckCDLs8A5gkT0UZedyMv0JpzUg6/E2Y2ORvjR4fM1eeOd439Haz3P
	4jtm4CfmeqiAKB1Jctal9IQPXfLXavMCijHrxHM0kwWIyUSt0GufMeM385p8mjG5lywqba
	LQwBEBdNuPPy/z+dXUowbp9q3ldoslJiihUdNjV6BXohNMYDO6O1bLubMoP9yiS0CeJ4AI
	20Ys9ujUnK+xNe11hhS4eYaT4htBiAR/Bp6cUXwQH//Rf/saS3G3FOs8fHDitFWMGGwje/
	g2fZTgLpt3d8KECr3UsZvqLV4bM1FQpiiLj0BSQqah1cLAM2/nhG5xTmwm7jWA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: brauner@kernel.org,
	akpm@linux-foundation.org
Cc: chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org,
	djwong@kernel.org,
	hare@suse.de,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	john.g.garry@oracle.com,
	cl@os.amperecomputing.com,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v12 01/10] fs: Allow fine-grained control of folio sizes
Date: Thu, 15 Aug 2024 11:08:40 +0200
Message-ID: <20240815090849.972355-2-kernel@pankajraghav.com>
In-Reply-To: <20240815090849.972355-1-kernel@pankajraghav.com>
References: <20240815090849.972355-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Wkznt3Q2Xz9sm9

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We need filesystems to be able to communicate acceptable folio sizes
to the pagecache for a variety of uses (e.g. large block sizes).
Support a range of folio sizes between order-0 and order-31.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 include/linux/pagemap.h | 89 ++++++++++++++++++++++++++++++++++-------
 mm/filemap.c            |  6 +--
 mm/readahead.c          |  4 +-
 3 files changed, 79 insertions(+), 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d9c7edb6422bd..75bbe88b89904 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -204,14 +204,20 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
-	AS_LARGE_FOLIO_SUPPORT = 6,
-	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
-	AS_STABLE_WRITES,	/* must wait for writeback before modifying
+	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
+	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
 				   folio contents */
-	AS_INACCESSIBLE,	/* Do not attempt direct R/W access to the mapping,
-				   including to move the mapping */
+	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
+	/* Bits 16-25 are used for FOLIO_ORDER */
+	AS_FOLIO_ORDER_BITS = 5,
+	AS_FOLIO_ORDER_MIN = 16,
+	AS_FOLIO_ORDER_MAX = AS_FOLIO_ORDER_MIN + AS_FOLIO_ORDER_BITS,
 };
 
+#define AS_FOLIO_ORDER_MASK     ((1u << AS_FOLIO_ORDER_BITS) - 1)
+#define AS_FOLIO_ORDER_MIN_MASK (AS_FOLIO_ORDER_MASK << AS_FOLIO_ORDER_MIN)
+#define AS_FOLIO_ORDER_MAX_MASK (AS_FOLIO_ORDER_MASK << AS_FOLIO_ORDER_MAX)
+
 /**
  * mapping_set_error - record a writeback error in the address_space
  * @mapping: the mapping in which an error should be set
@@ -367,9 +373,51 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 #define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
 #define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
 
+/*
+ * mapping_set_folio_order_range() - Set the orders supported by a file.
+ * @mapping: The address space of the file.
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
+						 unsigned int min,
+						 unsigned int max)
+{
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return;
+
+	if (min > MAX_PAGECACHE_ORDER)
+		min = MAX_PAGECACHE_ORDER;
+
+	if (max > MAX_PAGECACHE_ORDER)
+		max = MAX_PAGECACHE_ORDER;
+
+	if (max < min)
+		max = min;
+
+	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
+		(min << AS_FOLIO_ORDER_MIN) | (max << AS_FOLIO_ORDER_MAX);
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
+ * @mapping: The address space of the file.
  *
  * The filesystem should call this function in its inode constructor to
  * indicate that the VFS can use large folios to cache the contents of
@@ -380,7 +428,23 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
-	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	mapping_set_folio_order_range(mapping, 0, MAX_PAGECACHE_ORDER);
+}
+
+static inline unsigned int
+mapping_max_folio_order(const struct address_space *mapping)
+{
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return 0;
+	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
+}
+
+static inline unsigned int
+mapping_min_folio_order(const struct address_space *mapping)
+{
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return 0;
+	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
 }
 
 /*
@@ -389,20 +453,17 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
  */
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
-	/* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache folios */
+	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
 	VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
 			"Anonymous mapping always supports large folio");
 
-	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	return mapping_max_folio_order(mapping) > 0;
 }
 
 /* Return the maximum folio size for this pagecache mapping, in bytes. */
-static inline size_t mapping_max_folio_size(struct address_space *mapping)
+static inline size_t mapping_max_folio_size(const struct address_space *mapping)
 {
-	if (mapping_large_folio_support(mapping))
-		return PAGE_SIZE << MAX_PAGECACHE_ORDER;
-	return PAGE_SIZE;
+	return PAGE_SIZE << mapping_max_folio_order(mapping);
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
diff --git a/mm/filemap.c b/mm/filemap.c
index 29fec1fccd0a6..6c4489ada3ecc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1933,10 +1933,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
 			fgp_flags |= FGP_LOCK;
 
-		if (!mapping_large_folio_support(mapping))
-			order = 0;
-		if (order > MAX_PAGECACHE_ORDER)
-			order = MAX_PAGECACHE_ORDER;
+		if (order > mapping_max_folio_order(mapping))
+			order = mapping_max_folio_order(mapping);
 		/* If we're not aligned, allocate a smaller folio */
 		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
diff --git a/mm/readahead.c b/mm/readahead.c
index 517c0be7ce665..3e5239e9e1777 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -449,10 +449,10 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	limit = min(limit, index + ra->size - 1);
 
-	if (new_order < MAX_PAGECACHE_ORDER)
+	if (new_order < mapping_max_folio_order(mapping))
 		new_order += 2;
 
-	new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
+	new_order = min(mapping_max_folio_order(mapping), new_order);
 	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 
 	/* See comment in page_cache_ra_unbounded() */
-- 
2.44.1


