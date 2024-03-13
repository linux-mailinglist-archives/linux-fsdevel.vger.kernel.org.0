Return-Path: <linux-fsdevel+bounces-14314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F887AFA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F081F2C052
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639B78B62;
	Wed, 13 Mar 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="FKXPUs2f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5278272;
	Wed, 13 Mar 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349832; cv=none; b=Ev4EwX4IvdNW8gy4CO2P6J4wVbZcO9mWB9u5R1uMInf+1DElyJZYBAvl/2DfpHD62ffEQtllcViDmK+g4T1reDM6F8eiA4b+ttyIjQ+k3SK8ufq6nqEM+r04AWlOLwihxWSseGZk3uJPkWYX3xllLrB9ClvDLfsV/olJg2VmoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349832; c=relaxed/simple;
	bh=uEN3+Pd+RH/FPBp58dP39IOAx4Z8ypnrnt80ldJB+Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iI+Pj7VxPqxaXIOeOaqbGK7tvmHeYONUgKm2CNigFniFqQz6etVU2namqMTNdO7TUmentODvW+gVQsZgbzy2ZPpb/g/DmfQ2rK/dZpRbOe8j56VJSyK5rFySfiiH35xv+ysQXm07HSX2wqCWyM8BK+I9HxxMrSvipU/Bjj6MJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=FKXPUs2f; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TvxfK4Tbyz9t6h;
	Wed, 13 Mar 2024 18:03:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710349385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wozYDNbmy2bEoKve6FiU3MASCD8dtvfm2o2W8jk+gfE=;
	b=FKXPUs2fuDsWqd/RzRu5+rfCFIpIrPx1U/+fFFTvFbtEhJZ8SHhGthBo8ybr9J0e992Svz
	pL6C17UJGmdo7r76XOQiQIkixF8r94mI5JB/lkuBCCigSVIkSmN7jHfl3raHipIQ5KAZWb
	c5Y2eUfhVSB3Z4l6Hj9Vk+Xpk0nZNezMEiaGU+agMZsFVIThR/QPChspgVvoelbmtIKFoo
	N+9tXSlYmyp77ZLvY7jjB5YwrSO64t+YMYuCAqqIr9//yrcOHRBt1b+m0sOkNlhKL0iDNJ
	pMAvyd+M8Lb7xTSjI+NfUl+xzmnpF751DjHQbTqryYQnvF9J4GcPLuwO63LOnw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: gost.dev@samsung.com,
	chandan.babu@oracle.com,
	hare@suse.de,
	mcgrof@kernel.org,
	djwong@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 02/11] fs: Allow fine-grained control of folio sizes
Date: Wed, 13 Mar 2024 18:02:44 +0100
Message-ID: <20240313170253.2324812-3-kernel@pankajraghav.com>
In-Reply-To: <20240313170253.2324812-1-kernel@pankajraghav.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TvxfK4Tbyz9t6h

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Some filesystems want to be able to ensure that folios that are added to
the page cache are at least a certain size.
Add mapping_set_folio_min_order() to allow this level of control.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/pagemap.h | 100 ++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..fc8eb9c94e9c 100644
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
@@ -344,9 +349,47 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
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
+ * mapping_set_folio_min_order() - Set the minimum folio order
+ * @mapping: The address_space.
+ * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
+ *
+ * The filesystem should call this function in its inode constructor to
+ * indicate which base size of folio the VFS can use to cache the contents
+ * of the file.  This should only be used if the filesystem needs special
+ * handling of folio sizes (ie there is something the core cannot know).
+ * Do not tune it based on, eg, i_size.
+ *
+ * Context: This should not be called while the inode is active as it
+ * is non-atomic.
+ */
+static inline void mapping_set_folio_min_order(struct address_space *mapping,
+					       unsigned int min)
+{
+	if (min > MAX_PAGECACHE_ORDER)
+		min = MAX_PAGECACHE_ORDER;
+
+	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
+			 (min << AS_FOLIO_ORDER_MIN) |
+			 (MAX_PAGECACHE_ORDER << AS_FOLIO_ORDER_MAX);
+}
+
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
- * @mapping: The file.
+ * @mapping: The address_space.
  *
  * The filesystem should call this function in its inode constructor to
  * indicate that the VFS can use large folios to cache the contents of
@@ -357,7 +400,37 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
-	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	mapping_set_folio_min_order(mapping, 0);
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
@@ -367,7 +440,7 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
 	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	       (mapping_max_folio_order(mapping) > 0);
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
@@ -528,19 +601,6 @@ static inline void *detach_page_private(struct page *page)
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
2.43.0


