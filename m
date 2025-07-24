Return-Path: <linux-fsdevel+bounces-55951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD48B10E0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB78AC1BFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF2E2E9ED5;
	Thu, 24 Jul 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="aGH8S43j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D628D849;
	Thu, 24 Jul 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368635; cv=none; b=G5O0N/p+bLLs989SzC7GiClSAh4d2l02NU1ndA9Y+2nM06Iw7nyftPp4Dyn1sA8nqe1xRz5Gx9UpzvyRTCMCTySNhBQE8WDvzyM8vwMSLhKey9vrpuR+Nvvo/r+zj1vPMOonnq25q/NPFKV7Omep5bECgjxYgTx/SiufqXAz1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368635; c=relaxed/simple;
	bh=U+XrJ7qPmXckpgma7xjywbKnSlZ/lISxgwb9DgiEZdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+AEskJtFHNy1LGBTSU5l2LjN3zQ0YbMaHyqGsxK1iroSIwyOf7DpOEBM2MXilIM3NtBhaRpDGCHkMp5IFlMDCqNbVEt+pUckKJChEUFbJMEjmQPYBlq/rIr76MB0J+j5i7v+LHdzWxBCK1s1KksqPo0bZ43PKITsTOISyUFxIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=aGH8S43j; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bnv7T6G6Zz9sts;
	Thu, 24 Jul 2025 16:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1753368629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5l/HIngC1kXD7T+ooDKjA2O1qsfDTkVYtcVPghF1zI=;
	b=aGH8S43jvliLtI9JLC7gBR7ZmPCNPo5wcNcyvxKVz0IM0/XqSy8QwkIqO6a50QlUPIXpkr
	w807Dk+viwStdR/npoCHpSA5zfnhHIb72oHI6PiRwfqtHM9JVF99mj/eki1GoaOkXlvT9o
	D/mfyjTLI45zpliMVMCu9O3aRhI2lNHTSO+sZGy/f3id+zsC2gxfO8Oq9iaKwxQkFR4epW
	pogJ1GjOn9d3SoCIvD/5AnfVGNMTsjs5A0bZizbJh8lXtWL6uWQpQfl6RQz4sjUWlNoihE
	EVopdEgme7f1JUspdKXZ2HVL2NJMnx28FlHHsQG3oTbmsDBzuY5cdKA4o3Q/qw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
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
Subject: [RFC v2 2/4] mm: add static huge zero folio
Date: Thu, 24 Jul 2025 16:49:59 +0200
Message-ID: <20250724145001.487878-3-kernel@pankajraghav.com>
In-Reply-To: <20250724145001.487878-1-kernel@pankajraghav.com>
References: <20250724145001.487878-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bnv7T6G6Zz9sts

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
that created it. This might not work for bio layer as the completions
can be async and the process that created the huge_zero_folio might no
longer be alive. And, one of the main point that came during discussion
is to have something bigger than zero page as a drop-in replacement.

Add a config option STATIC_HUGE_ZERO_FOLIO that will always allocate
the huge_zero_folio, and it will never drop the reference. This makes
using the huge_zero_folio without having to pass any mm struct and does
not tie the lifetime of the zero folio to anything, making it a drop-in
replacement for ZERO_PAGE.

If STATIC_HUGE_ZERO_FOLIO config option is enabled, then
mm_get_huge_zero_folio() will simply return this page instead of
dynamically allocating a new PMD page.

This option can waste memory in small systems or systems with 64k base
page size. So make it an opt-in and also add an option from individual
architecture so that we don't enable this feature for larger base page
size systems.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 arch/x86/Kconfig        |  1 +
 include/linux/huge_mm.h | 18 ++++++++++++++++++
 mm/Kconfig              | 21 +++++++++++++++++++++
 mm/huge_memory.c        | 42 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0ce86e14ab5e..8e2aa1887309 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -153,6 +153,7 @@ config X86
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
 	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select BUILDTIME_TABLE_SORT
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b..78ebceb61d0e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -476,6 +476,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
 extern struct folio *huge_zero_folio;
 extern unsigned long huge_zero_pfn;
+extern atomic_t huge_zero_folio_is_static;
 
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
@@ -494,6 +495,18 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
 void mm_put_huge_zero_folio(struct mm_struct *mm);
+struct folio *__get_static_huge_zero_folio(void);
+
+static inline struct folio *get_static_huge_zero_folio(void)
+{
+	if (!IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
+		return NULL;
+
+	if (likely(atomic_read(&huge_zero_folio_is_static)))
+		return huge_zero_folio;
+
+	return __get_static_huge_zero_folio();
+}
 
 static inline bool thp_migration_supported(void)
 {
@@ -685,6 +698,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
 {
 	return 0;
 }
+
+static inline struct folio *get_static_huge_zero_folio(void)
+{
+	return NULL;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int split_folio_to_list_to_order(struct folio *folio,
diff --git a/mm/Kconfig b/mm/Kconfig
index 0287e8d94aea..e2132fcf2ccb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -835,6 +835,27 @@ config ARCH_WANT_GENERAL_HUGETLB
 config ARCH_WANTS_THP_SWAP
 	def_bool n
 
+config ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
+	def_bool n
+
+config STATIC_HUGE_ZERO_FOLIO
+	bool "Allocate a PMD sized folio for zeroing"
+	depends on ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO && TRANSPARENT_HUGEPAGE
+	help
+	  Without this config enabled, the huge zero folio is allocated on
+	  demand and freed under memory pressure once no longer in use.
+	  To detect remaining users reliably, references to the huge zero folio
+	  must be tracked precisely, so it is commonly only available for mapping
+	  it into user page tables.
+
+	  With this config enabled, the huge zero folio can also be used
+	  for other purposes that do not implement precise reference counting:
+	  it is still allocated on demand, but never freed, allowing for more
+	  wide-spread use, for example, when performing I/O similar to the
+	  traditional shared zeropage.
+
+	  Not suitable for memory constrained systems.
+
 config MM_ID
 	def_bool n
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5d8365d1d3e9..c160c37f4d31 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -75,6 +75,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 static bool split_underused_thp = true;
 
 static atomic_t huge_zero_refcount;
+atomic_t huge_zero_folio_is_static __read_mostly;
 struct folio *huge_zero_folio __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
@@ -266,6 +267,47 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
 		put_huge_zero_page();
 }
 
+#ifdef CONFIG_STATIC_HUGE_ZERO_FOLIO
+#define FAIL_COUNT_LIMIT 2
+
+struct folio *__get_static_huge_zero_folio(void)
+{
+	static unsigned long fail_count_clear_timer;
+	static atomic_t huge_zero_static_fail_count __read_mostly;
+
+	if (unlikely(!slab_is_available()))
+		return NULL;
+
+	/*
+	 * If we failed to allocate a huge zero folio multiple times,
+	 * just refrain from trying for one minute before retrying to get
+	 * a reference again.
+	 */
+	if (atomic_read(&huge_zero_static_fail_count) > FAIL_COUNT_LIMIT) {
+		if (time_before(jiffies, fail_count_clear_timer))
+			return NULL;
+		atomic_set(&huge_zero_static_fail_count, 0);
+	}
+	/*
+	 * Our raised reference will prevent the shrinker from ever having
+	 * success.
+	 */
+	if (!get_huge_zero_page()) {
+		int count = atomic_inc_return(&huge_zero_static_fail_count);
+
+		if (count > FAIL_COUNT_LIMIT)
+			fail_count_clear_timer = get_jiffies_64() + 60 * HZ;
+
+		return NULL;
+	}
+
+	if (atomic_cmpxchg(&huge_zero_folio_is_static, 0, 1) != 0)
+		put_huge_zero_page();
+
+	return huge_zero_folio;
+}
+#endif /* CONFIG_STATIC_HUGE_ZERO_FOLIO */
+
 static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
 						  struct shrink_control *sc)
 {
-- 
2.49.0


