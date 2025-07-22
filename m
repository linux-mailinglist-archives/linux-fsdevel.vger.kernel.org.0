Return-Path: <linux-fsdevel+bounces-55659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A62B0D631
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 11:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804F56C6BD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 09:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE1A2DECCC;
	Tue, 22 Jul 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="2Cp3Cg6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1E15530C;
	Tue, 22 Jul 2025 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177382; cv=none; b=mY2iXItfnvZshStH8dCUr5VMVD1qK8r5bHMN49JKpGorK1/pI0vPjXNl7njbggHBksSkW8bGwZeyDHvlkKisUYk+sBmCpC/hDbE6Di2FRv93e3eX9JVpMf6PLkJfApsLyFnztnSRkM8ch/gn4Ary2xvi8aoRxfo0OSuq2kzLrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177382; c=relaxed/simple;
	bh=E1TdzIKNhUbobXdzgYUV5KmD6h06YZlTJ+tkpz588R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9MH0phQzd+BMHVdXu/tr6lz5trEPrrvbQ2/SgH88dk+4nKGGe0QudGsQg+aIxm5JJHT8Pikam9rIuOseGRIiwLa5ibKktCxQNvddldJhw5+NDP3sOelbQ4sUGQAGd/HMs0vlBbuaZuDQMvqycWgS+j/C/DdA/39qE+eNtXQrhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=2Cp3Cg6e; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bmXPQ4RMpz9t8x;
	Tue, 22 Jul 2025 11:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1753177370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGsooM1ApyIs81SWSpZ620H0z3hTQFaebPIcfnU58Eg=;
	b=2Cp3Cg6eyslS2Hx05RQHV0KDG6jw2NCBt5lsymHhDDjSR2IXuUQA35n1ypOjb/p+xxKPrs
	Lf9h2NNMyxlprJbzzPcb+He9Ksb1GWalvJt1tzLBBSSS8NueHWyQ57a7C0+XQWn161xdp/
	95Rm9YMENqlR4Hv96BolnDqK2U/u5kSpMkYtJ9E+hfZ3mVSIUSmpziZ/TPnuTyghcFSRAG
	93FoO3kzsgk4xj6Vtr53oemKKcc1NBXUKl780lwjkc+a7Bv3gWrdYZxe9I5qV4bIhBAE+y
	HsbjyYUXlEX3hAQSJ9cgHQEkNgIUMfbG4UP5RMkZGyaytJNOz9QkOvzGZ0apsQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 2/4] mm: add static huge zero folio
Date: Tue, 22 Jul 2025 11:42:13 +0200
Message-ID: <20250722094215.448132-3-kernel@pankajraghav.com>
In-Reply-To: <20250722094215.448132-1-kernel@pankajraghav.com>
References: <20250722094215.448132-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bmXPQ4RMpz9t8x

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

If STATIC_PMD_ZERO_PAGE config option is enabled, then
mm_get_huge_zero_folio() will simply return this page instead of
dynamically allocating a new PMD page.

This option can waste memory in small systems or systems with 64k base
page size. So make it an opt-in and also add an option from individual
architecture so that we don't enable this feature for larger base page
size systems.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Co-Developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 arch/x86/Kconfig        |  1 +
 include/linux/huge_mm.h | 16 ++++++++++++++++
 mm/Kconfig              | 12 ++++++++++++
 mm/huge_memory.c        | 28 ++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

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
index 7748489fde1b..0ddd9c78f9f4 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -476,6 +476,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
 extern struct folio *huge_zero_folio;
 extern unsigned long huge_zero_pfn;
+extern atomic_t huge_zero_folio_is_static;
 
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
@@ -494,6 +495,16 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
 void mm_put_huge_zero_folio(struct mm_struct *mm);
+struct folio *__get_static_huge_zero_folio(void);
+
+static inline struct folio *get_static_huge_zero_folio(void)
+{
+       if (!IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
+               return NULL;
+       if (likely(atomic_read(&huge_zero_folio_is_static)))
+               return huge_zero_folio;
+       return __get_static_huge_zero_folio();
+}
 
 static inline bool thp_migration_supported(void)
 {
@@ -685,6 +696,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
 {
 	return 0;
 }
+
+static inline struct folio *get_static_huge_zero_folio(void)
+{
+       return NULL;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int split_folio_to_list_to_order(struct folio *folio,
diff --git a/mm/Kconfig b/mm/Kconfig
index 0287e8d94aea..14721171846f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -835,6 +835,18 @@ config ARCH_WANT_GENERAL_HUGETLB
 config ARCH_WANTS_THP_SWAP
 	def_bool n
 
+config ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
+	def_bool n
+
+config STATIC_HUGE_ZERO_FOLIO
+	bool "Allocate a PMD sized folio for zeroing"
+	depends on ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
+	help
+	  Typically huge_zero_folio, which is a PMD page of zeroes, is allocated
+	  on demand and deallocated when not in use. This option will
+	  allocate huge_zero_folio but it will never free it.
+	  Not suitable for memory constrained systems.
+
 config MM_ID
 	def_bool n
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5d8365d1d3e9..6c890a1482f3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -75,6 +75,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 static bool split_underused_thp = true;
 
 static atomic_t huge_zero_refcount;
+static atomic_t huge_zero_static_fail_count __read_mostly;
+atomic_t huge_zero_folio_is_static __read_mostly;
 struct folio *huge_zero_folio __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
@@ -266,6 +268,32 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
 		put_huge_zero_page();
 }
 
+#ifdef CONFIG_STATIC_HUGE_ZERO_FOLIO
+struct folio *__get_static_huge_zero_folio(void)
+{
+       /*
+        * If we failed to allocate a huge zero folio multiple times,
+        * just refrain from trying.
+        */
+       if (atomic_read(&huge_zero_static_fail_count) > 2)
+               return NULL;
+
+       /*
+        * Our raised reference will prevent the shrinker from ever having
+        * success.
+        */
+       if (!get_huge_zero_page()) {
+              atomic_inc(&huge_zero_static_fail_count);
+               return NULL;
+       }
+
+       if (atomic_cmpxchg(&huge_zero_folio_is_static, 0, 1) != 0)
+               put_huge_zero_page();
+
+       return huge_zero_folio;
+}
+#endif /* CONFIG_STATIC_HUGE_ZERO_FOLIO */
+
 static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
 						  struct shrink_control *sc)
 {
-- 
2.49.0


