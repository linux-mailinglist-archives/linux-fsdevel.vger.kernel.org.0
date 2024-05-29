Return-Path: <linux-fsdevel+bounces-20442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3098D3843
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE2DB2683B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544A94AEE3;
	Wed, 29 May 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="lpGPvRj2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64545C16;
	Wed, 29 May 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990351; cv=none; b=putIDcFiMUMroiUX0ileKKEmcN44HwSjmxznq74W6Vp8RzLBQ5mTwuVdUJ3NHe3qgLIiAOvWV/OJogCpjH0cS84X0qJU1y/C6arDkJwB14XcFf7ltSdxS6eNZRn2lv55P0Bwd2shmAT+OPkBULlwbl3X9EykiXdYNHAXyMwjo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990351; c=relaxed/simple;
	bh=d9iFG0ipK3d+e72AE66uRgp3hbM35NdTTI6TRZD1s1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OKU9ICLBmDGv/n64H87P+QnxxFaThMWQvNFIQfASm+HsV0vPrih/c+xTcWhJ9ZEmJS3NVfeZX47I2Ir+rCtK+Dz8JVzVNb9+o0EbUaNbdDfxQIx+RPd8qcnP7bOMnyhN4OmJuPdIlzbYzbb7Jn4+gD+X2nFmfJVCbflTzjy7ryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=lpGPvRj2; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vq9d02DnJz9scZ;
	Wed, 29 May 2024 15:45:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716990340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3bvvOpkVjx29wta03S/fuMORRSyW24WVI14FdYTCO8=;
	b=lpGPvRj2tehBGHLKZ8b2ytls560fWEEb9wcfaMKxHsz7x8C+lL7v89ixRoeBklbysRPhHx
	hyCihbar79d/eNslfUcZZ2yFnKD5stVWQ9p8OXKnhHV6LZzltAocguLTAJyz5O7k4p+8lW
	+3tMoVkrudSht2hZ63gvhUzglKMgzz1/erTdfUQYBwcRm65h/WNlMmMazDoMCoLu4kOcKp
	vxT6GAP4aAy5Sq0eC4PghGeSx7p/6jX+N7wZPuVDq1vRSe7pXuLq7Lu8hfPWjrBhUjb7o6
	Q+nE5x0yH3WLxkcY/nxlcL8l1cruvHxEkhgjV8bLclRotJEe1B7BcGJTnFotCQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	gost.dev@samsung.com,
	yang@os.amperecomputing.com,
	p.raghav@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	hch@lst.de,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 05/11] mm: split a folio in minimum folio order chunks
Date: Wed, 29 May 2024 15:45:03 +0200
Message-Id: <20240529134509.120826-6-kernel@pankajraghav.com>
In-Reply-To: <20240529134509.120826-1-kernel@pankajraghav.com>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vq9d02DnJz9scZ

From: Luis Chamberlain <mcgrof@kernel.org>

split_folio() and split_folio_to_list() assume order 0, to support
minorder we must expand these to check the folio mapping order and use
that.

Set new_order to be at least minimum folio order if it is set in
split_huge_page_to_list() so that we can maintain minimum folio order
requirement in the page cache.

Update the debugfs write files used for testing to ensure the order
is respected as well. We simply enforce the min order when a file
mapping is used.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/huge_mm.h | 14 ++++++++----
 mm/huge_memory.c        | 50 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 87682498a5af..6a8e527b78a2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -88,6 +88,8 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
 
+#define split_folio(f) split_folio_to_list(f, NULL)
+
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PUD_SHIFT PUD_SHIFT
@@ -307,9 +309,10 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 bool can_split_folio(struct folio *folio, int *pextra_pins);
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
+int split_folio_to_list(struct folio *folio, struct list_head *list);
 static inline int split_huge_page(struct page *page)
 {
-	return split_huge_page_to_list_to_order(page, NULL, 0);
+	return split_folio(page_folio(page));
 }
 void deferred_split_folio(struct folio *folio);
 
@@ -474,6 +477,12 @@ static inline int split_huge_page(struct page *page)
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
@@ -578,7 +587,4 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 	return split_folio_to_list_to_order(folio, NULL, new_order);
 }
 
-#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
-#define split_folio(f) split_folio_to_order(f, 0)
-
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cf9ead052d2a..e4e0b3431dc6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3068,6 +3068,9 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
  * released, or if some unexpected race happened (e.g., anon VMA disappeared,
  * truncation).
  *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set.
+ *
  * Returns -EINVAL when trying to split to an order that is incompatible
  * with the folio. Splitting to order 0 is compatible with all folios.
  */
@@ -3143,6 +3146,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		mapping = NULL;
 		anon_vma_lock_write(anon_vma);
 	} else {
+		unsigned int min_order;
 		gfp_t gfp;
 
 		mapping = folio->mapping;
@@ -3153,6 +3157,14 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
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
 
@@ -3264,6 +3276,21 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
+int split_folio_to_list(struct folio *folio, struct list_head *list)
+{
+	unsigned int min_order = 0;
+
+	if (!folio_test_anon(folio)) {
+		if (!folio->mapping) {
+			count_vm_event(THP_SPLIT_PAGE_FAILED);
+			return -EBUSY;
+		}
+		min_order = mapping_min_folio_order(folio->mapping);
+	}
+
+	return split_huge_page_to_list_to_order(&folio->page, list, min_order);
+}
+
 void __folio_undo_large_rmappable(struct folio *folio)
 {
 	struct deferred_split *ds_queue;
@@ -3493,6 +3520,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		struct vm_area_struct *vma = vma_lookup(mm, addr);
 		struct page *page;
 		struct folio *folio;
+		unsigned int target_order = new_order;
 
 		if (!vma)
 			break;
@@ -3529,7 +3557,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!folio_trylock(folio))
 			goto next;
 
-		if (!split_folio_to_order(folio, new_order))
+		if (!split_folio_to_order(folio, target_order))
 			split++;
 
 		folio_unlock(folio);
@@ -3572,14 +3600,19 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 
 	for (index = off_start; index < off_end; index += nr_pages) {
 		struct folio *folio = filemap_get_folio(mapping, index);
+		unsigned int min_order, target_order = new_order;
 
 		nr_pages = 1;
 		if (IS_ERR(folio))
 			continue;
 
-		if (!folio_test_large(folio))
+		if (!folio->mapping || !folio_test_large(folio))
 			goto next;
 
+		min_order = mapping_min_folio_order(mapping);
+		if (new_order < min_order)
+			target_order = min_order;
+
 		total++;
 		nr_pages = folio_nr_pages(folio);
 
@@ -3589,7 +3622,18 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (!folio_trylock(folio))
 			goto next;
 
-		if (!split_folio_to_order(folio, new_order))
+		if (!folio_test_anon(folio)) {
+			unsigned int min_order;
+
+			if (!folio->mapping)
+				goto next;
+
+			min_order = mapping_min_folio_order(folio->mapping);
+			if (new_order < target_order)
+				target_order = min_order;
+		}
+
+		if (!split_folio_to_order(folio, target_order))
 			split++;
 
 		folio_unlock(folio);
-- 
2.34.1


