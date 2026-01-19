Return-Path: <linux-fsdevel+bounces-74428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA61D3A3A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CEC73008177
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C103064A2;
	Mon, 19 Jan 2026 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGlQkyn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBB25F96D;
	Mon, 19 Jan 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816071; cv=none; b=m9m1mWEpF0LMm/cd/tji9i+CV15fRYQgxUQwkgjXs23+PZxuanZ2+V6VoS8w4M3I5HPkDAOyUE+pad52Z0q5NPGic3HrjFDp1FVyk068K6rfAYxc+K5JJNGjXJ4mS+SMEQJV66yAoBwCQpPy5q6tp9jvL/PLB/rdHyfq+rQgzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816071; c=relaxed/simple;
	bh=a0Al5CERHesex5OnDU/mFgjB0imIpfWAbjXXoirBqMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcr7jUqR0q9JBvQrStyGMJ3kJaMNppp/0PzYWUgEP4Geac2/slk0vpsc/Sbtcws86AsV/yl2hgRohSE15TzoIJ3TBHxE3gs5GLLzkm7zXGiAb+JuZJSfJQaP986/SymXmw9KBfopeJDsHorDOD//OnLEgFWCveYrxJSZh4JINeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGlQkyn/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768816069; x=1800352069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0Al5CERHesex5OnDU/mFgjB0imIpfWAbjXXoirBqMA=;
  b=XGlQkyn/kZa+7X0/QfBP7fmyQmgdZN68NiMtVOCKIjhX1YIS1oEcXrV6
   ex6pOWl970mYOPsXqeHwsB8DocQsjHGb/6HH8bGa6KybxUg/EvE1hQWsP
   Ej38HM5ufiqvLlKDTTtcUt1/dB1au0536Pr3d3Li6CYn1mHO+wvJcLVEz
   RRJfQSCjkQJbvzPlMil/+Dlz0D5Muw+SKEuCq9FXbnS+m86/5CC0RTHR1
   +ZUuvQwyfzjvPejkiTfKHaGygRXEKkiqHv1wWp1FDwP0SRQZtPrMjG1em
   DrJcUwcXWUfrZm2zwuZ0qqYX8PzoDNZHlWcieNbGSql61Byx6Cf5j8/ZS
   A==;
X-CSE-ConnectionGUID: t8XS4jeqSAiu28IQFjYiNg==
X-CSE-MsgGUID: FL7ixdWcTr6UVIOT/AigNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="70072777"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="70072777"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 01:47:46 -0800
X-CSE-ConnectionGUID: 6aXQEcGhRmy+JbFXrx8nhw==
X-CSE-MsgGUID: nymuz5LfRnqIFB/O46hTdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="204971983"
Received: from linux-pnp-server-15.sh.intel.com ([10.239.177.153])
  by orviesa006.jf.intel.com with ESMTP; 19 Jan 2026 01:47:42 -0800
From: Zhiguo Zhou <zhiguo.zhou@intel.com>
To: zhiguo.zhou@intel.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	gang.deng@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	tianyou.li@intel.com,
	tim.c.chen@linux.intel.com,
	vbabka@suse.cz,
	willy@infradead.org
Subject: [PATCH v2 1/2] mm/filemap: refactor __filemap_add_folio to separate critical section
Date: Mon, 19 Jan 2026 18:02:58 +0800
Message-ID: <20260119100301.922922-2-zhiguo.zhou@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119100301.922922-1-zhiguo.zhou@intel.com>
References: <20260119065027.918085-1-zhiguo.zhou@intel.com>
 <20260119100301.922922-1-zhiguo.zhou@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch refactors __filemap_add_folio() to extract its core
critical section logic into a new helper function,
__filemap_add_folio_xa_locked(). The refactoring maintains the
existing functionality while enabling finer control over locking
granularity for callers.

Key changes:
- Move the xarray insertion logic from __filemap_add_folio() into
  __filemap_add_folio_xa_locked()
- Modify __filemap_add_folio() to accept a pre-initialized xa_state
  and a 'xa_locked' parameter
- Update the function signature in the header file accordingly
- Adjust existing callers (filemap_add_folio() and
  hugetlb_add_to_page_cache()) to use the new interface

The refactoring is functionally equivalent to the previous code:
- When 'xa_locked' is false, __filemap_add_folio() acquires the xarray
  lock internally (existing behavior)
- When 'xa_locked' is true, the caller is responsible for holding the
  xarray lock, and __filemap_add_folio() only executes the critical
  section

This separation prepares for the subsequent patch that introduces
batch folio insertion, where multiple folios can be added to the
page cache within a single lock hold.

No performance changes are expected from this patch alone, as it
only reorganizes code without altering the execution flow.

Reported-by: Gang Deng <gang.deng@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
---
 include/linux/pagemap.h |   2 +-
 mm/filemap.c            | 173 +++++++++++++++++++++++-----------------
 mm/hugetlb.c            |   3 +-
 3 files changed, 103 insertions(+), 75 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..59cbf57fb55b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1297,7 +1297,7 @@ loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
 
 /* Must be non-static for BPF error injection */
 int __filemap_add_folio(struct address_space *mapping, struct folio *folio,
-		pgoff_t index, gfp_t gfp, void **shadowp);
+		struct xa_state *xas, gfp_t gfp, void **shadowp, bool xa_locked);
 
 bool filemap_range_has_writeback(struct address_space *mapping,
 				 loff_t start_byte, loff_t end_byte);
diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a..c4c6cd428b8d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -845,95 +845,114 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 
-noinline int __filemap_add_folio(struct address_space *mapping,
-		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
+/*
+ * The critical section for storing a folio in an XArray.
+ * Context: Expects xas->xa->xa_lock to be held.
+ */
+static void __filemap_add_folio_xa_locked(struct xa_state *xas,
+		struct address_space *mapping, struct folio *folio, void **shadowp)
 {
-	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	bool huge;
 	long nr;
 	unsigned int forder = folio_order(folio);
+	int order = -1;
+	void *entry, *old = NULL;
 
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
-	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
-			folio);
-	mapping_set_update(&xas, mapping);
+	lockdep_assert_held(&xas->xa->xa_lock);
 
-	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 	huge = folio_test_hugetlb(folio);
 	nr = folio_nr_pages(folio);
 
-	gfp &= GFP_RECLAIM_MASK;
-	folio_ref_add(folio, nr);
-	folio->mapping = mapping;
-	folio->index = xas.xa_index;
-
-	for (;;) {
-		int order = -1;
-		void *entry, *old = NULL;
-
-		xas_lock_irq(&xas);
-		xas_for_each_conflict(&xas, entry) {
-			old = entry;
-			if (!xa_is_value(entry)) {
-				xas_set_err(&xas, -EEXIST);
-				goto unlock;
-			}
-			/*
-			 * If a larger entry exists,
-			 * it will be the first and only entry iterated.
-			 */
-			if (order == -1)
-				order = xas_get_order(&xas);
+	xas_for_each_conflict(xas, entry) {
+		old = entry;
+		if (!xa_is_value(entry)) {
+			xas_set_err(xas, -EEXIST);
+			return;
 		}
+		/*
+		 * If a larger entry exists,
+		 * it will be the first and only entry iterated.
+		 */
+		if (order == -1)
+			order = xas_get_order(xas);
+	}
 
-		if (old) {
-			if (order > 0 && order > forder) {
-				unsigned int split_order = max(forder,
-						xas_try_split_min_order(order));
-
-				/* How to handle large swap entries? */
-				BUG_ON(shmem_mapping(mapping));
-
-				while (order > forder) {
-					xas_set_order(&xas, index, split_order);
-					xas_try_split(&xas, old, order);
-					if (xas_error(&xas))
-						goto unlock;
-					order = split_order;
-					split_order =
-						max(xas_try_split_min_order(
-							    split_order),
-						    forder);
-				}
-				xas_reset(&xas);
+	if (old) {
+		if (order > 0 && order > forder) {
+			unsigned int split_order = max(forder,
+					xas_try_split_min_order(order));
+
+			/* How to handle large swap entries? */
+			BUG_ON(shmem_mapping(mapping));
+
+			while (order > forder) {
+				xas_set_order(xas, xas->xa_index, split_order);
+				xas_try_split(xas, old, order);
+				if (xas_error(xas))
+					return;
+				order = split_order;
+				split_order =
+					max(xas_try_split_min_order(
+						    split_order),
+					    forder);
 			}
-			if (shadowp)
-				*shadowp = old;
+			xas_reset(xas);
 		}
+		if (shadowp)
+			*shadowp = old;
+	}
 
-		xas_store(&xas, folio);
-		if (xas_error(&xas))
-			goto unlock;
+	xas_store(xas, folio);
+	if (xas_error(xas))
+		return;
 
-		mapping->nrpages += nr;
+	mapping->nrpages += nr;
 
-		/* hugetlb pages do not participate in page cache accounting */
-		if (!huge) {
-			lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
-			if (folio_test_pmd_mappable(folio))
-				lruvec_stat_mod_folio(folio,
-						NR_FILE_THPS, nr);
-		}
+	/* hugetlb pages do not participate in page cache accounting */
+	if (!huge) {
+		lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
+		if (folio_test_pmd_mappable(folio))
+			lruvec_stat_mod_folio(folio,
+					NR_FILE_THPS, nr);
+	}
+}
 
-unlock:
-		xas_unlock_irq(&xas);
+noinline int __filemap_add_folio(struct address_space *mapping,
+				 struct folio *folio, struct xa_state *xas,
+				 gfp_t gfp, void **shadowp, bool xa_locked)
+{
+	long nr;
 
-		if (!xas_nomem(&xas, gfp))
-			break;
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
+			folio);
+	mapping_set_update(xas, mapping);
+
+	VM_BUG_ON_FOLIO(xas->xa_index & (folio_nr_pages(folio) - 1), folio);
+	nr = folio_nr_pages(folio);
+
+	gfp &= GFP_RECLAIM_MASK;
+	folio_ref_add(folio, nr);
+	folio->mapping = mapping;
+	folio->index = xas->xa_index;
+
+	if (xa_locked) {
+		lockdep_assert_held(&xas->xa->xa_lock);
+		__filemap_add_folio_xa_locked(xas, mapping, folio, shadowp);
+	} else {
+		lockdep_assert_not_held(&xas->xa->xa_lock);
+		for (;;) {
+			xas_lock_irq(xas);
+			__filemap_add_folio_xa_locked(xas, mapping, folio, shadowp);
+			xas_unlock_irq(xas);
+
+			if (!xas_nomem(xas, gfp))
+				break;
+		}
 	}
 
-	if (xas_error(&xas))
+	if (xas_error(xas))
 		goto error;
 
 	trace_mm_filemap_add_to_page_cache(folio);
@@ -942,12 +961,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->mapping = NULL;
 	/* Leave folio->index set: truncation relies upon it */
 	folio_put_refs(folio, nr);
-	return xas_error(&xas);
+	return xas_error(xas);
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
-int filemap_add_folio(struct address_space *mapping, struct folio *folio,
-				pgoff_t index, gfp_t gfp)
+static int _filemap_add_folio(struct address_space *mapping, struct folio *folio,
+				struct xa_state *xas, gfp_t gfp, bool xa_locked)
 {
 	void *shadow = NULL;
 	int ret;
@@ -963,7 +982,7 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		return ret;
 
 	__folio_set_locked(folio);
-	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
+	ret = __filemap_add_folio(mapping, folio, xas, gfp, &shadow, xa_locked);
 	if (unlikely(ret)) {
 		mem_cgroup_uncharge(folio);
 		__folio_clear_locked(folio);
@@ -987,6 +1006,14 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 	}
 	return ret;
 }
+
+int filemap_add_folio(struct address_space *mapping, struct folio *folio,
+				pgoff_t index, gfp_t gfp)
+{
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
+
+	return _filemap_add_folio(mapping, folio, &xas, gfp, false);
+}
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 51273baec9e5..5c6c6b9e463f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5657,10 +5657,11 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	struct inode *inode = mapping->host;
 	struct hstate *h = hstate_inode(inode);
 	int err;
+	XA_STATE_ORDER(xas, &mapping->i_pages, idx, folio_order(folio));
 
 	idx <<= huge_page_order(h);
 	__folio_set_locked(folio);
-	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
+	err = __filemap_add_folio(mapping, folio, &xas, GFP_KERNEL, NULL, false);
 
 	if (unlikely(err)) {
 		__folio_clear_locked(folio);
-- 
2.43.0


