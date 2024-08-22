Return-Path: <linux-fsdevel+bounces-26731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D830095B78A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638661F21D6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550D1CDA10;
	Thu, 22 Aug 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="TI3XkqrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E71CCEEA;
	Thu, 22 Aug 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334656; cv=none; b=BfQDv7FArk09PHZLr+vKPVgFRFhNqZU1+PtnlvkA1Bkes0OgnTKiR+tZwH+TKFkYHCefMXgv2UqI1IHoos7RCAsKsvC8R4eMD+weN9f5iw2VBn7W7cOoOzxnu+DGS+9gcWdkSuVRtNR4G7XksOSCNQnC5ifQ35TppA+HGQUnTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334656; c=relaxed/simple;
	bh=uDkhoe0brZm/0tAA4KagBA/lQAFsvzFiEt2ySKVkKEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBKuJFRsqwZEDK/ei0xRtx5Sqtv4obr/7jyLLmr5E1HUqbLVYg2dOCHHu6CjnT4dagZ1Yu2C9CAgc6X4Bx1UZP+0cA94wF5pmWC7WAB7MAfCvvenrikUK5Q5JMnG3vtnmCxUiHT/92Di2Rh3H/1dzwuRkbhsn0kNfYrDGwDH/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=TI3XkqrO; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WqPjk6K4bz9shX;
	Thu, 22 Aug 2024 15:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724334650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4+UJEIcZLaw+P6a+NKFEvwnnHiOsE5MmywSgHb9XjU=;
	b=TI3XkqrOA1G5xwXEyCR1F9QdslfABIfK9sZB8HKy2iWovXDXulySJg3g87dZTPCkTT5C44
	k4f8YSeu80Sbez6lb6ok73vzCwncZBmUYVJKzxwOG+Aw8p9A2YCq4Cd5reW0vK5LF/gYuY
	23Q+7tPshAIXPIhqVbNRdyVEWa4tU9loSCNPaXo5yLr42au/8Kawto53+jwyjVFfKurQMD
	EsqyNjAiWtoV50XL7TfQealdHd01Q7HN/iIc1Mn7e3+saSIzpB4u2YHJLSTluwfivIXipl
	yYrPITnpRSP0mSTCPpx6KDZZ5K0836MrDORPqIy1r3Z+e42nnlmT57QA40k0pg==
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
	ryan.roberts@arm.com,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Date: Thu, 22 Aug 2024 15:50:12 +0200
Message-ID: <20240822135018.1931258-5-kernel@pankajraghav.com>
In-Reply-To: <20240822135018.1931258-1-kernel@pankajraghav.com>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WqPjk6K4bz9shX

From: Luis Chamberlain <mcgrof@kernel.org>

split_folio() and split_folio_to_list() assume order 0, to support
minorder for non-anonymous folios, we must expand these to check the
folio mapping order and use that.

Set new_order to be at least minimum folio order if it is set in
split_huge_page_to_list() so that we can maintain minimum folio order
requirement in the page cache.

Update the debugfs write files used for testing to ensure the order
is respected as well. We simply enforce the min order when a file
mapping is used.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: David Howells <dhowells@redhat.com>
---
 include/linux/huge_mm.h | 14 +++++++---
 mm/huge_memory.c        | 60 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4c32058cacfec..70424d55da088 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -96,6 +96,8 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
 
+#define split_folio(f) split_folio_to_list(f, NULL)
+
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PUD_SHIFT PUD_SHIFT
@@ -317,9 +319,10 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
+int split_folio_to_list(struct folio *folio, struct list_head *list);
 static inline int split_huge_page(struct page *page)
 {
-	return split_huge_page_to_list_to_order(page, NULL, 0);
+	return split_folio(page_folio(page));
 }
 void deferred_split_folio(struct folio *folio);
 
@@ -495,6 +498,12 @@ static inline int split_huge_page(struct page *page)
 {
 	return 0;
 }
+
+static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
+{
+	return 0;
+}
+
 static inline void deferred_split_folio(struct folio *folio) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
@@ -622,7 +631,4 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 	return split_folio_to_list_to_order(folio, NULL, new_order);
 }
 
-#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
-#define split_folio(f) split_folio_to_order(f, 0)
-
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cf8e34f62976f..06384b85a3a20 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3303,6 +3303,9 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
  * released, or if some unexpected race happened (e.g., anon VMA disappeared,
  * truncation).
  *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set for non-anonymous folios.
+ *
  * Returns -EINVAL when trying to split to an order that is incompatible
  * with the folio. Splitting to order 0 is compatible with all folios.
  */
@@ -3384,6 +3387,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		mapping = NULL;
 		anon_vma_lock_write(anon_vma);
 	} else {
+		unsigned int min_order;
 		gfp_t gfp;
 
 		mapping = folio->mapping;
@@ -3394,6 +3398,14 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			goto out;
 		}
 
+		min_order = mapping_min_folio_order(folio->mapping);
+		if (new_order < min_order) {
+			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
+				     min_order);
+			ret = -EINVAL;
+			goto out;
+		}
+
 		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
 							GFP_RECLAIM_MASK);
 
@@ -3506,6 +3518,25 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
+int split_folio_to_list(struct folio *folio, struct list_head *list)
+{
+	unsigned int min_order = 0;
+
+	if (folio_test_anon(folio))
+		goto out;
+
+	if (!folio->mapping) {
+		if (folio_test_pmd_mappable(folio))
+			count_vm_event(THP_SPLIT_PAGE_FAILED);
+		return -EBUSY;
+	}
+
+	min_order = mapping_min_folio_order(folio->mapping);
+out:
+	return split_huge_page_to_list_to_order(&folio->page, list,
+							min_order);
+}
+
 void __folio_undo_large_rmappable(struct folio *folio)
 {
 	struct deferred_split *ds_queue;
@@ -3736,6 +3767,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		struct vm_area_struct *vma = vma_lookup(mm, addr);
 		struct folio_walk fw;
 		struct folio *folio;
+		struct address_space *mapping;
+		unsigned int target_order = new_order;
 
 		if (!vma)
 			break;
@@ -3753,7 +3786,13 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!is_transparent_hugepage(folio))
 			goto next;
 
-		if (new_order >= folio_order(folio))
+		if (!folio_test_anon(folio)) {
+			mapping = folio->mapping;
+			target_order = max(new_order,
+					   mapping_min_folio_order(mapping));
+		}
+
+		if (target_order >= folio_order(folio))
 			goto next;
 
 		total++;
@@ -3771,9 +3810,14 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		folio_get(folio);
 		folio_walk_end(&fw, vma);
 
-		if (!split_folio_to_order(folio, new_order))
+		if (!folio_test_anon(folio) && folio->mapping != mapping)
+			goto unlock;
+
+		if (!split_folio_to_order(folio, target_order))
 			split++;
 
+unlock:
+
 		folio_unlock(folio);
 		folio_put(folio);
 
@@ -3802,6 +3846,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	pgoff_t index;
 	int nr_pages = 1;
 	unsigned long total = 0, split = 0;
+	unsigned int min_order;
+	unsigned int target_order;
 
 	file = getname_kernel(file_path);
 	if (IS_ERR(file))
@@ -3815,6 +3861,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		 file_path, off_start, off_end);
 
 	mapping = candidate->f_mapping;
+	min_order = mapping_min_folio_order(mapping);
+	target_order = max(new_order, min_order);
 
 	for (index = off_start; index < off_end; index += nr_pages) {
 		struct folio *folio = filemap_get_folio(mapping, index);
@@ -3829,15 +3877,19 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		total++;
 		nr_pages = folio_nr_pages(folio);
 
-		if (new_order >= folio_order(folio))
+		if (target_order >= folio_order(folio))
 			goto next;
 
 		if (!folio_trylock(folio))
 			goto next;
 
-		if (!split_folio_to_order(folio, new_order))
+		if (folio->mapping != mapping)
+			goto unlock;
+
+		if (!split_folio_to_order(folio, target_order))
 			split++;
 
+unlock:
 		folio_unlock(folio);
 next:
 		folio_put(folio);
-- 
2.44.1


