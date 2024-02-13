Return-Path: <linux-fsdevel+bounces-11342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001FC852C97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FF41C2516E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9F224FD;
	Tue, 13 Feb 2024 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="vk8rNVHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013A0524AC;
	Tue, 13 Feb 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817078; cv=none; b=ahN2zpvqVeJEi8jJjPv8IKzUVmPmEhXIVQZh7A9uyZNt2lkLTzIzrUSxXmkIvvkSP7BsaU7T7kA4nccgk6DTGZrhxQZXx0k9aUNCYklAas/vOTNOesYp8cTSkxko9mTM8hNk9tT+BwV67y1uTB4LsRAj3VPOTotmH/JakSKpXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817078; c=relaxed/simple;
	bh=t+xAGesPvg8PRQJY0BLXZ/TBi6+F/tBh4Y2eOTFzprs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+CE8qF/QSHedNjHpYh/M2jYi0XJ2HtHXc3jS9GYFWAf78dx+bv4l2VsvrPDlUVgJDNxX2LvNm1MSexgU2UBjN9Prp9Lf97ZcOQJ2q2LXfJOB0McA0PzGi+qsBFlJf4z17CgjxhXSgMOYnsSxdAb6VYd3TFg8UIwwa84PueX+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=vk8rNVHr; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TYx805XGYz9t7w;
	Tue, 13 Feb 2024 10:37:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTxYFw2wNX7P5ZclG9FyVzbP0PebvoXLD7s4qqN4OLQ=;
	b=vk8rNVHrH9GnDjyMJds3YOI6FHkGLa5jobWuxpBSfDc8eim75cFZeal2zSOqMPmtRTP7Lt
	jiU1XTqkGbKSf4FyAvu8y5Kv3XT7peTK4JTd40qH112YpZ5MhTZqagUFznvuEPJGLeRzDO
	1nvCvtEaI6Vb2cmva8byqNu3rPyCcR7y8jkug7J5YUuPwYCi6zhpTo6lN4rddW3W0Zq4xX
	9jeP4tpx214SFXzzjp5l3ltv5glok+YytXEQGtoCIdhdlUkbWSpyoosppXs3wr6iTUM87n
	zVspg8aNshEzNRnan6HsNc0cCrqVf/Ti1mskfH4RqObvWYjl2B4tNvGSyEDuuA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kbusch@kernel.org,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	p.raghav@samsung.com,
	linux-kernel@vger.kernel.org,
	hare@suse.de,
	willy@infradead.org,
	linux-mm@kvack.org,
	david@fromorbit.com
Subject: [RFC v2 09/14] mm: Support order-1 folios in the page cache
Date: Tue, 13 Feb 2024 10:37:08 +0100
Message-ID: <20240213093713.1753368-10-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Folios of order 1 have no space to store the deferred list.  This is
not a problem for the page cache as file-backed folios are never
placed on the deferred list.  All we need to do is prevent the core
MM from touching the deferred list for order 1 folios and remove the
code which prevented us from allocating order 1 folios.

Link: https://lore.kernel.org/linux-mm/90344ea7-4eec-47ee-5996-0c22f42d6a6a@google.com/
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h |  7 +++++--
 mm/filemap.c            |  2 --
 mm/huge_memory.c        | 23 ++++++++++++++++++-----
 mm/internal.h           |  4 +---
 mm/readahead.c          |  3 ---
 5 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5adb86af35fc..916a2a539517 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -263,7 +263,7 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 
-void folio_prep_large_rmappable(struct folio *folio);
+struct folio *folio_prep_large_rmappable(struct folio *folio);
 bool can_split_folio(struct folio *folio, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
 static inline int split_huge_page(struct page *page)
@@ -410,7 +410,10 @@ static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return 0;
 }
 
-static inline void folio_prep_large_rmappable(struct folio *folio) {}
+static inline struct folio *folio_prep_large_rmappable(struct folio *folio)
+{
+	return folio;
+}
 
 #define transparent_hugepage_flags 0UL
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 7a6e15c47150..c8205a534532 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1922,8 +1922,6 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
-			if (order == 1)
-				order = 0;
 			if (order < min_order)
 				order = min_order;
 			if (order > 0)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d897efc51025..6ec3417638a1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -788,11 +788,15 @@ struct deferred_split *get_deferred_split_queue(struct folio *folio)
 }
 #endif
 
-void folio_prep_large_rmappable(struct folio *folio)
+struct folio *folio_prep_large_rmappable(struct folio *folio)
 {
-	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
-	INIT_LIST_HEAD(&folio->_deferred_list);
+	if (!folio || !folio_test_large(folio))
+		return folio;
+	if (folio_order(folio) > 1)
+		INIT_LIST_HEAD(&folio->_deferred_list);
 	folio_set_large_rmappable(folio);
+
+	return folio;
 }
 
 static inline bool is_transparent_hugepage(struct folio *folio)
@@ -3095,7 +3099,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
-		if (!list_empty(&folio->_deferred_list)) {
+		if (folio_order(folio) > 1 &&
+		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
 			list_del(&folio->_deferred_list);
 		}
@@ -3146,6 +3151,9 @@ void folio_undo_large_rmappable(struct folio *folio)
 	struct deferred_split *ds_queue;
 	unsigned long flags;
 
+	if (folio_order(folio) <= 1)
+		return;
+
 	/*
 	 * At this point, there is no one trying to add the folio to
 	 * deferred_list. If folio is not in deferred_list, it's safe
@@ -3171,7 +3179,12 @@ void deferred_split_folio(struct folio *folio)
 #endif
 	unsigned long flags;
 
-	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
+	/*
+	 * Order 1 folios have no space for a deferred list, but we also
+	 * won't waste much memory by not adding them to the deferred list.
+	 */
+	if (folio_order(folio) <= 1)
+		return;
 
 	/*
 	 * The try_to_unmap() in page reclaim path might reach here too,
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..5174b5b0c344 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -419,9 +419,7 @@ static inline struct folio *page_rmappable_folio(struct page *page)
 {
 	struct folio *folio = (struct folio *)page;
 
-	if (folio && folio_order(folio) > 1)
-		folio_prep_large_rmappable(folio);
-	return folio;
+	return folio_prep_large_rmappable(folio);
 }
 
 static inline void prep_compound_head(struct page *page, unsigned int order)
diff --git a/mm/readahead.c b/mm/readahead.c
index a361fba18674..7d5f6a8792a8 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -560,9 +560,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		/* Don't allocate pages past EOF */
 		while (order > min_order && index + (1UL << order) - 1 > limit)
 			order--;
-		/* THP machinery does not support order-1 */
-		if (order == 1)
-			order = 0;
 
 		if (order < min_order)
 			order = min_order;
-- 
2.43.0


