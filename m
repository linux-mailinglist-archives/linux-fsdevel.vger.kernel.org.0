Return-Path: <linux-fsdevel+bounces-54127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1974DAFB5FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9EE4A5ED4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643552D979A;
	Mon,  7 Jul 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="wp3KZfoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100FE2D94AC;
	Mon,  7 Jul 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898227; cv=none; b=q0gvn/+qY3AfhVpSQbL46+m+fcXPoymH0fHR8K8mtFChZhaTuUBZu11gWAWGgpBOVzbv5nWcGr5nQ1pJvD8HdhDG70F+4t8nRDc78f8OSh5FM8rG8/SC0an7D62rE1RSrtdsbsitfOWJlHVU1YKQQh2kgXYGWCMxwTHyMOcEDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898227; c=relaxed/simple;
	bh=Yit2Oo5Uv3NUZPX8v4yxQ8Kkxzn/eltUeObd9Yys35U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2zE9Xll2K6/s6vxsvmCtznPDllnlUXsx7gUpDcwHUCxmBB9icNZpqGb/4XP44P86iaL6qvD3N9jYdpBua7bzbhg3fEH5EJsfS7bFv2wJrhXATQHS4YssKS4aGTti8AIQbF7hb651s8hmaWmv4j9bucutfl4iYc8paxdC5c2nJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=wp3KZfoK; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bbRLJ1x3pz9tyQ;
	Mon,  7 Jul 2025 16:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1751898216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d91pgcDgrRL2JpOOqB781Bo9qwyVwFxGfEFfjYlReNI=;
	b=wp3KZfoKnF6ITu982GQemk4XaqE9lTE0V+hBMyjHhaiQUaHbr+ZgnuudICs62/+f+pNYJt
	rpsnAm8HGEE66RB+ZOKlhdeRFUec9kMz7r/+Oa9UmEPuSo8M1tXS0+THT7yYM37KUFc47X
	hlPW0H9WjuHh5J/5IMS7z5fAuO8uwF+XeFCOrxVhPeZfajkWEdUWFAu5fxbsolNDBA5F0j
	JJku7U0793nWBiTafdK414V6ecgO5BX20ur8VcX0h8YfsjCYvOWRpC6COpuU4SMQp+PSX4
	jHT/6YATywrR4R+vs4iV2Kn8shiXQu5VmX8LUBU1OiMcUfN0hAOjO+a6bbOv7w==
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
Subject: [PATCH v2 1/5] mm: move huge_zero_page declaration from huge_mm.h to mm.h
Date: Mon,  7 Jul 2025 16:23:15 +0200
Message-ID: <20250707142319.319642-2-kernel@pankajraghav.com>
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

Move the declaration associated with huge_zero_page from huge_mm.h to
mm.h. This patch is in preparation for adding static PMD zero page as we
will be reusing some of the huge_zero_page infrastructure.

No functional changes.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/huge_mm.h | 31 -------------------------------
 include/linux/mm.h      | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2f190c90192d..3e887374892c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -478,22 +478,6 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
-extern struct folio *huge_zero_folio;
-extern unsigned long huge_zero_pfn;
-
-static inline bool is_huge_zero_folio(const struct folio *folio)
-{
-	return READ_ONCE(huge_zero_folio) == folio;
-}
-
-static inline bool is_huge_zero_pmd(pmd_t pmd)
-{
-	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
-}
-
-struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
-void mm_put_huge_zero_folio(struct mm_struct *mm);
-
 static inline bool thp_migration_supported(void)
 {
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
@@ -631,21 +615,6 @@ static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	return 0;
 }
 
-static inline bool is_huge_zero_folio(const struct folio *folio)
-{
-	return false;
-}
-
-static inline bool is_huge_zero_pmd(pmd_t pmd)
-{
-	return false;
-}
-
-static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
-{
-	return;
-}
-
 static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
 	unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667a..c8fbeaacf896 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4018,6 +4018,40 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+extern struct folio *huge_zero_folio;
+extern unsigned long huge_zero_pfn;
+
+static inline bool is_huge_zero_folio(const struct folio *folio)
+{
+	return READ_ONCE(huge_zero_folio) == folio;
+}
+
+static inline bool is_huge_zero_pmd(pmd_t pmd)
+{
+	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
+}
+
+struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
+void mm_put_huge_zero_folio(struct mm_struct *mm);
+
+#else
+static inline bool is_huge_zero_folio(const struct folio *folio)
+{
+	return false;
+}
+
+static inline bool is_huge_zero_pmd(pmd_t pmd)
+{
+	return false;
+}
+
+static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
+{
+	return;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 #if MAX_NUMNODES > 1
 void __init setup_nr_node_ids(void);
 #else
-- 
2.49.0


