Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3D29900C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782240AbgJZOyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:54:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41103 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782236AbgJZOyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:54:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so4840918pll.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKnqB2H4A9GfL129LyuW/aKQzjXxtcujGjamVVTZt+o=;
        b=IXkxUGg2Agm1PK38QD2SNw/68rctaJpPIznRseP3npaQajtiMXDCt8jOzBSoDL9hbw
         2JG7iTMh6wRzgSCb1XxgWMnJRprM1/woCbCCblyEwHYxwTo+xdMuxW9HfdgohKDfQSGK
         aHwc+1jOMZuWxJ1bP1fGbnQSpzDzvCdVl0S2AmTYJYpjia6IAEOLK71PlDBfxri0pQ0f
         hotdFh4af4I754SBFNinBVkHPkWECHHI36/gBps/kjMUTMOXkDz174YNGOvJcPVy9kvd
         2EgZi/ej1JQeKlD9Teit1kkYYWGa/UV6YXdEaZDikGS6MAWhmXnc1Kfx/gYp/xqcKcQG
         Tnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKnqB2H4A9GfL129LyuW/aKQzjXxtcujGjamVVTZt+o=;
        b=dqAsMj3jBOAvPUXZYmAM9ujQK2MRaN6NHq25xKxExTaXO6e5rodPgwNhl6lVnY8QfG
         C3A5pNUwd2EXz+8GLFHRla73qQG+UJMAbuSMDwlI8nIqVnnUBYIrJJJVJd/Rwg0hZ1Zr
         hKQdPOsyJ+yjLgNO5cNMHl4sWdPBgvv22NE23Rop27vvCvOZjT+rnuJofNJ1DTLROoDG
         jbTRO6GxawoZnawY/8KdZxlyU5ij9YxfcT5fRuW43eLVOdZRRCQBL3dafLFzF4GXlCFJ
         1i1PtZD9edEu6aS0udZO/U/2EioOTske+psFEgaf1DAu7Xx0iA31eNrPf0GBWPPTKq6X
         483A==
X-Gm-Message-State: AOAM530O14EJvLX0+IP4jofy7GST9bmgKdx1G+cceh2x3IiCFjUxhH3K
        d8oWmGEalcPqvYHRi20Dgm5b1g==
X-Google-Smtp-Source: ABdhPJzcCWQyRV2cLPt2WZWLE1vOjxPG/tlYXb0D8MZ8Bmyv8p03mIypI33vMhOkGMCpzltSgagfSA==
X-Received: by 2002:a17:90a:62c1:: with SMTP id k1mr17165182pjs.135.1603724039650;
        Mon, 26 Oct 2020 07:53:59 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.53.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:53:59 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 05/19] mm/hugetlb: Introduce pgtable allocation/freeing helpers
Date:   Mon, 26 Oct 2020 22:51:00 +0800
Message-Id: <20201026145114.59424-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On some architectures, the vmemmap areas use huge page mapping.
If we want to free the unused vmemmap pages, we have to split
the huge pmd firstly. So we should pre-allocate pgtable to split
huge pmd.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/include/asm/hugetlb.h |   5 ++
 include/linux/hugetlb.h        |  17 +++++
 mm/hugetlb.c                   | 117 +++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index 1721b1aadeb1..f5e882f999cd 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -5,6 +5,11 @@
 #include <asm/page.h>
 #include <asm-generic/hugetlb.h>
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#define VMEMMAP_HPAGE_SHIFT			PMD_SHIFT
+#define arch_vmemmap_support_huge_mapping()	boot_cpu_has(X86_FEATURE_PSE)
+#endif
+
 #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
 
 #endif /* _ASM_X86_HUGETLB_H */
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index eed3dd3bd626..ace304a6196c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -593,6 +593,23 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 
 #include <asm/hugetlb.h>
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#ifndef arch_vmemmap_support_huge_mapping
+static inline bool arch_vmemmap_support_huge_mapping(void)
+{
+	return false;
+}
+#endif
+
+#ifndef VMEMMAP_HPAGE_SHIFT
+#define VMEMMAP_HPAGE_SHIFT		PMD_SHIFT
+#endif
+#define VMEMMAP_HPAGE_ORDER		(VMEMMAP_HPAGE_SHIFT - PAGE_SHIFT)
+#define VMEMMAP_HPAGE_NR		(1 << VMEMMAP_HPAGE_ORDER)
+#define VMEMMAP_HPAGE_SIZE		((1UL) << VMEMMAP_HPAGE_SHIFT)
+#define VMEMMAP_HPAGE_MASK		(~(VMEMMAP_HPAGE_SIZE - 1))
+#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
+
 #ifndef is_hugepage_only_range
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					unsigned long addr, unsigned long len)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f1b2b733b49b..d6ae9b6876be 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1295,11 +1295,108 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 #define RESERVE_VMEMMAP_NR	2U
 
+#define page_huge_pte(page)	((page)->pmd_huge_pte)
+
 static inline unsigned int nr_free_vmemmap(struct hstate *h)
 {
 	return h->nr_free_vmemmap_pages;
 }
 
+static inline unsigned int nr_vmemmap(struct hstate *h)
+{
+	return nr_free_vmemmap(h) + RESERVE_VMEMMAP_NR;
+}
+
+static inline unsigned long nr_vmemmap_size(struct hstate *h)
+{
+	return (unsigned long)nr_vmemmap(h) << PAGE_SHIFT;
+}
+
+static inline unsigned int nr_pgtable(struct hstate *h)
+{
+	unsigned long vmemmap_size = nr_vmemmap_size(h);
+
+	if (!arch_vmemmap_support_huge_mapping())
+		return 0;
+
+	/*
+	 * No need pre-allocate page tabels when there is no vmemmap pages
+	 * to free.
+	 */
+	if (!nr_free_vmemmap(h))
+		return 0;
+
+	return ALIGN(vmemmap_size, VMEMMAP_HPAGE_SIZE) >> VMEMMAP_HPAGE_SHIFT;
+}
+
+static inline void vmemmap_pgtable_init(struct page *page)
+{
+	page_huge_pte(page) = NULL;
+}
+
+static void vmemmap_pgtable_deposit(struct page *page, pte_t *pte_p)
+{
+	pgtable_t pgtable = virt_to_page(pte_p);
+
+	/* FIFO */
+	if (!page_huge_pte(page))
+		INIT_LIST_HEAD(&pgtable->lru);
+	else
+		list_add(&pgtable->lru, &page_huge_pte(page)->lru);
+	page_huge_pte(page) = pgtable;
+}
+
+static pte_t *vmemmap_pgtable_withdraw(struct page *page)
+{
+	pgtable_t pgtable;
+
+	/* FIFO */
+	pgtable = page_huge_pte(page);
+	if (unlikely(!pgtable))
+		return NULL;
+	page_huge_pte(page) = list_first_entry_or_null(&pgtable->lru,
+						       struct page, lru);
+	if (page_huge_pte(page))
+		list_del(&pgtable->lru);
+	return page_to_virt(pgtable);
+}
+
+static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
+{
+	int i;
+	pte_t *pte_p;
+	unsigned int nr = nr_pgtable(h);
+
+	if (!nr)
+		return 0;
+
+	vmemmap_pgtable_init(page);
+
+	for (i = 0; i < nr; i++) {
+		pte_p = pte_alloc_one_kernel(&init_mm);
+		if (!pte_p)
+			goto out;
+		vmemmap_pgtable_deposit(page, pte_p);
+	}
+
+	return 0;
+out:
+	while (i-- && (pte_p = vmemmap_pgtable_withdraw(page)))
+		pte_free_kernel(&init_mm, pte_p);
+	return -ENOMEM;
+}
+
+static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
+{
+	pte_t *pte_p;
+
+	if (!nr_pgtable(h))
+		return;
+
+	while ((pte_p = vmemmap_pgtable_withdraw(page)))
+		pte_free_kernel(&init_mm, pte_p);
+}
+
 static void __init hugetlb_vmemmap_init(struct hstate *h)
 {
 	unsigned int order = huge_page_order(h);
@@ -1323,6 +1420,15 @@ static void __init hugetlb_vmemmap_init(struct hstate *h)
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
 }
+
+static inline int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
+{
+	return 0;
+}
+
+static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
+{
+}
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
@@ -1531,6 +1637,9 @@ void free_huge_page(struct page *page)
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
+	/* Must be called before the initialization of @page->lru */
+	vmemmap_pgtable_free(h, page);
+
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	set_hugetlb_cgroup(page, NULL);
@@ -1783,6 +1892,14 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 	if (!page)
 		return NULL;
 
+	if (vmemmap_pgtable_prealloc(h, page)) {
+		if (hstate_is_gigantic(h))
+			free_gigantic_page(page, huge_page_order(h));
+		else
+			put_page(page);
+		return NULL;
+	}
+
 	if (hstate_is_gigantic(h))
 		prep_compound_gigantic_page(page, huge_page_order(h));
 	prep_new_huge_page(h, page, page_to_nid(page));
-- 
2.20.1

