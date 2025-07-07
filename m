Return-Path: <linux-fsdevel+bounces-54129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD89AFB60D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A8C7B1EA1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2E2E06C3;
	Mon,  7 Jul 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="iZsZqnCv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D52DFA44;
	Mon,  7 Jul 2025 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898235; cv=none; b=IBTD/R34BvbnXcKu8ZG7d2lFyF+bPhzGMOy0Ii0MH0Np1olj7eXiDPNM2sj96lDJpDC89zYhYQFQJFrvPT2ufNweD7hssRmgGNDZDFC8i73UnU1HAL5ahqbu5km5xMUNNj8cOgVlumnMzbTikVbAbqgk93pIa/e8xXxlxmjb1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898235; c=relaxed/simple;
	bh=DRCKQK856vY/XhqC271b6reyPd1XmuXWY0VkCfRxp/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmtPBsjTBJ5ZodW1/Z+wDKPClIc4WWkeFa1Rcpt63tw5CPMD3qUFURYcKjyqLNJTl46B0U9AyEpagxKyBupBm8VctvKWEK95oe+lDEEB2wC2QwSb4AqAMOZDhF8uBlK8bbaT4wzPW2o8+TtnkQHqoUb+pZGzrAczTKSN1lOpTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=iZsZqnCv; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bbRLY0CMSz9tGx;
	Mon,  7 Jul 2025 16:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1751898229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dioc976QRUw5bLt02/DkSyYspIHpJxyFl5YdOlbtU3Y=;
	b=iZsZqnCvOLftVzN22H/zGurFF1wZNHMczIdkygQCJEd73NIfq19mZQOw2buUf8ZOB+l9DD
	3+VKM3RZy1Uwkfx6NLJj4xUt+wfX8tBMN8TqVxUe/4nvqz8+nO63NDGZECYNPV0f62MM5e
	0SszRUpsSD18v6VAsrpMdeT9dpNkLXC4ZgB15DnLbcvsaJLwg3cEmKq7jkDOSaE5CUdc4b
	5mZGOPtBUjdj5kB8M7mujrQm1CC9sB/njlYbGTr0vHhNmySrw626BXHizNDjdkhrXSDJzB
	7Qvc/7rvhNyx3qyevTice33nVlvjV0NdkdvieOYiVD+dLl6G4mH6Anv0UvV/qQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	willy@infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 3/5] mm: add static PMD zero page
Date: Mon,  7 Jul 2025 16:23:17 +0200
Message-ID: <20250707142319.319642-4-kernel@pankajraghav.com>
In-Reply-To: <20250707142319.319642-1-kernel@pankajraghav.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

There are many places in the kernel where we need to zeroout larger
chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
is limited by PAGE_SIZE.

This is especially annoying in block devices and filesystems where we
attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
bvec support in block layer, it is much more efficient to send out
larger zero pages as a part of single bvec.

This concern was raised during the review of adding LBS support to
XFS[1][2].

Usually huge_zero_folio is allocated on demand, and it will be
deallocated by the shrinker if there are no users of it left. At moment,
huge_zero_folio infrastructure refcount is tied to the process lifetime
that created it. This might not work for bio layer as the completitions
can be async and the process that created the huge_zero_folio might no
longer be alive.

Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
the huge_zero_folio, and it will never be freed. This makes using the
huge_zero_folio without having to pass any mm struct and does not tie
the lifetime of the zero folio to anything.

memblock is used to allocated this PMD zero page during early boot.

If STATIC_PMD_ZERO_PAGE config option is enabled, then
mm_get_huge_zero_folio() will simply return this page instead of
dynamically allocating a new PMD page.

As STATIC_PMD_ZERO_PAGE does not depend on THP, declare huge_zero_folio
and huge_zero_pfn outside the THP config.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/mm.h | 25 ++++++++++++++++++++++++-
 mm/Kconfig         |  9 +++++++++
 mm/huge_memory.c   | 24 ++++++++++++++++++++----
 mm/memory.c        | 25 +++++++++++++++++++++++++
 mm/mm_init.c       |  1 +
 5 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c8fbeaacf896..428fe6d36b3c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4018,10 +4018,19 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
+extern void __init static_pmd_zero_init(void);
+#else
+static inline void __init static_pmd_zero_init(void)
+{
+	return;
+}
+#endif
+
 extern struct folio *huge_zero_folio;
 extern unsigned long huge_zero_pfn;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
 	return READ_ONCE(huge_zero_folio) == folio;
@@ -4032,9 +4041,23 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
 }
 
+#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
+static inline struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
+{
+	return READ_ONCE(huge_zero_folio);
+}
+
+static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
+{
+	return;
+}
+
+#else
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
 void mm_put_huge_zero_folio(struct mm_struct *mm);
 
+#endif /* CONFIG_STATIC_PMD_ZERO_PAGE */
+
 #else
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index 781be3240e21..89d5971cf180 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -826,6 +826,15 @@ config ARCH_WANTS_THP_SWAP
 config MM_ID
 	def_bool n
 
+config STATIC_PMD_ZERO_PAGE
+	bool "Allocate a PMD page for zeroing"
+	help
+	  Typically huge_zero_folio, which is a PMD page of zeroes, is allocated
+	  on demand and deallocated when not in use. This option will
+	  allocate a PMD sized zero page during early boot and huge_zero_folio will
+	  use it instead allocating dynamically.
+	  Not suitable for memory constrained systems.
+
 menuconfig TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
 	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 101b67ab2eb6..c12ca7134e88 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -75,9 +75,6 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 					 struct shrink_control *sc);
 static bool split_underused_thp = true;
 
-static atomic_t huge_zero_refcount;
-struct folio *huge_zero_folio __read_mostly;
-unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
@@ -208,6 +205,23 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
+#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
+static int huge_zero_page_shrinker_init(void)
+{
+	return 0;
+}
+
+static void huge_zero_page_shrinker_exit(void)
+{
+	return;
+}
+#else
+
+static struct shrinker *huge_zero_page_shrinker;
+static atomic_t huge_zero_refcount;
+struct folio *huge_zero_folio __read_mostly;
+unsigned long huge_zero_pfn __read_mostly = ~0UL;
+
 static bool get_huge_zero_page(void)
 {
 	struct folio *zero_folio;
@@ -288,7 +302,6 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 	return 0;
 }
 
-static struct shrinker *huge_zero_page_shrinker;
 static int huge_zero_page_shrinker_init(void)
 {
 	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
@@ -307,6 +320,7 @@ static void huge_zero_page_shrinker_exit(void)
 	return;
 }
 
+#endif
 
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
@@ -2843,6 +2857,8 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	pte_t *pte;
 	int i;
 
+	// FIXME: can this be called with static zero page?
+	VM_BUG_ON(IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE));
 	/*
 	 * Leave pmd empty until pte is filled note that it is fine to delay
 	 * notification until mmu_notifier_invalidate_range_end() as we are
diff --git a/mm/memory.c b/mm/memory.c
index b0cda5aab398..42c4c31ad14c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -42,6 +42,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/memblock.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/task.h>
@@ -159,6 +160,30 @@ static int __init init_zero_pfn(void)
 }
 early_initcall(init_zero_pfn);
 
+#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
+struct folio *huge_zero_folio __read_mostly = NULL;
+unsigned long huge_zero_pfn __read_mostly = ~0UL;
+
+void __init static_pmd_zero_init(void)
+{
+	void *alloc = memblock_alloc(PMD_SIZE, PAGE_SIZE);
+
+	if (!alloc)
+		return;
+
+	huge_zero_folio = virt_to_folio(alloc);
+	huge_zero_pfn = page_to_pfn(virt_to_page(alloc));
+
+	__folio_set_head(huge_zero_folio);
+	prep_compound_head((struct page *)huge_zero_folio, PMD_ORDER);
+	/* Ensure zero folio won't have large_rmappable flag set. */
+	folio_clear_large_rmappable(huge_zero_folio);
+	folio_zero_range(huge_zero_folio, 0, PMD_SIZE);
+
+	return;
+}
+#endif
+
 void mm_trace_rss_stat(struct mm_struct *mm, int member)
 {
 	trace_rss_stat(mm, member);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f2944748f526..56d7ec372af1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2765,6 +2765,7 @@ void __init mm_core_init(void)
 	 */
 	kho_memory_init();
 
+	static_pmd_zero_init();
 	memblock_free_all();
 	mem_init();
 	kmem_cache_init();
-- 
2.49.0


