Return-Path: <linux-fsdevel+bounces-22326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D0F916672
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6961F21BB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A0155342;
	Tue, 25 Jun 2024 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="SoczZoJA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3314D43D;
	Tue, 25 Jun 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315880; cv=none; b=RNoQIjWw9f+NTR2EHhb0xwlCyxo0fRbNtK8tuvLBibvY3FO9hYAPXTTCGqf6u+wsMNKOc+7fNjNpvR+s9rTnboDWMpz1zQuyu9r1DDxOqIy51S8jeVmtgYQVFuzK8gvHNA/ijhCPge9fUN/mzJ9GSmLk+Fw1oviOnQmwJBG36+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315880; c=relaxed/simple;
	bh=4QfRsYE3bXt2u/47rD8wxtQdlmc3bnc+qoBsYoSgetM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYfRMuQtu37BvVrphFkQ0bw+MBD1ZZjrlvPMLfSTQcA2CVkIQUAmuzmX43xE11mmXA6+PljXiuZJ9VAXfYj8bz0DFHehuYDwj3FJzj0YotWeib7Fb3TvE3+Z19XxWdVcOy/nTr80lSa+of2ogIFY244RS7/Vkf5axKfI9J/HnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=SoczZoJA; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W7jfj1jJyz9sWy;
	Tue, 25 Jun 2024 13:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719315869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfN9Et075BXtO0w+rFRIJHZouvd8/PL1Nw0p2P4Vhow=;
	b=SoczZoJACn34827uX93daQ8lJf6ybr2/Kjwys5/562jiLW33olc3/Nk0DvBhTfmsSiU+Fz
	EfrD0iUTuiXsnFbcycOTuDR+KZ2TbvDr5Knj7DSpZ/SKWpnUrnvxGowAv0Sw0NVRNgY2hg
	W+lmRCRB0W2dZevkmrrUeu6TUK5TWjKruyxd64SBSS/ooiBiKJ6LFXJIgZry8FINwgrWdz
	2PC0PF3Cw6YvOXvxZnDnXZCGWoT2VMlW0HPLsCRUUPZS6MmhawlRsXc+2+m+1a+Wne/NZm
	zN71v04qXXtjBlogHNvBoYa9LPpkYTwtPglaXl/1lE99RZ2JgaURCBvb0/BK0w==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	Zi Yan <zi.yan@sent.com>
Subject: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Date: Tue, 25 Jun 2024 11:44:11 +0000
Message-ID: <20240625114420.719014-2-kernel@pankajraghav.com>
In-Reply-To: <20240625114420.719014-1-kernel@pankajraghav.com>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W7jfj1jJyz9sWy

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
 include/linux/pagemap.h | 86 ++++++++++++++++++++++++++++++++++-------
 mm/filemap.c            |  6 +--
 mm/readahead.c          |  4 +-
 3 files changed, 77 insertions(+), 19 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 4b71d581091f..0c51154cdb57 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -204,14 +204,21 @@ enum mapping_flags {
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
-	AS_INACCESSIBLE,	/* Do not attempt direct R/W access to the mapping */
+	AS_UNMOVABLE = 8,	/* The mapping cannot be moved, ever */
+	AS_INACCESSIBLE = 9,	/* Do not attempt direct R/W access to the mapping */
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
@@ -360,9 +367,49 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 #define MAX_PAGECACHE_ORDER	8
 #endif
 
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
+	if (max > MAX_PAGECACHE_ORDER)
+		max = MAX_PAGECACHE_ORDER;
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
@@ -373,7 +420,23 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
-	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	mapping_set_folio_order_range(mapping, 0, MAX_PAGECACHE_ORDER);
+}
+
+static inline
+unsigned int mapping_max_folio_order(const struct address_space *mapping)
+{
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return 0;
+	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
+}
+
+static inline
+unsigned int mapping_min_folio_order(const struct address_space *mapping)
+{
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return 0;
+	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
 }
 
 /*
@@ -386,16 +449,13 @@ static inline bool mapping_large_folio_support(struct address_space *mapping)
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
index 0b8c732bb643..d617c9afca51 100644
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
index c1b23989d9ca..66058ae02f2e 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -503,9 +503,9 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	limit = min(limit, index + ra->size - 1);
 
-	if (new_order < MAX_PAGECACHE_ORDER) {
+	if (new_order < mapping_max_folio_order(mapping)) {
 		new_order += 2;
-		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
+		new_order = min(mapping_max_folio_order(mapping), new_order);
 		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 	}
 
-- 
2.44.1


