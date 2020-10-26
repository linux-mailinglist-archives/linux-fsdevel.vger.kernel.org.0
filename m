Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42ECC29903B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782719AbgJZOzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:55:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40344 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782136AbgJZOzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:55:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id w21so6317029pfc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKqFfBrPPNmfHuJAiL+mzNtDXNprI4LFbnvEVHi51k0=;
        b=deY/yV0JSi4ghS+MYfvehuTghmP/k3wU5P7MfbaKSuvybxlaavkj7gxOy9N9od7djU
         ZDXVA/cCElyyL/7i1bVz1s8klImmDxE+YfdU/8MgNpbTcSa55QU9L/iGFQ0EgvvndVnD
         5GrN9vGE76ReMR8URaepwTgpte1Vy+rHJvh2xLeTunn21rpBVscx+0hbH7oQIksHdDRE
         bLzCTvXoR9XgVqDmYV+HzNCAgK4tFZ9s7uNuecN8KyaFzQCMmF32ZXFEFcBw16eFIvY+
         Izc44NYxBcBsP3NqBMx8l/ER+VHQg6oKGRPM5WQp0yimoiCch7CBX++iUV6fdrj2nyeE
         7Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKqFfBrPPNmfHuJAiL+mzNtDXNprI4LFbnvEVHi51k0=;
        b=K1jPtaqf+JalsG2m+b5Xy4FZHV6yT4IUgeUHm725eaZG6LLU7CWeyn/3kk82s/PmMS
         Lqa1wG2G+x9qZ3wqeAR7GqsY1Ig9nDy7FFYekborhVZYQfCleCOXoUAbI08ATHWUvhPf
         tqGFeuYsMxRQ7ZG4KHcxFnhqfsGJQHSJ1rI4Pv/VUXND3DKmUUJF+2v1FvLrUkCnsNAR
         1gQ63i9wQ6GayTzk90PXcMEmFH0IIRMbdEZuxpm6dv6z7ZortY1mZQ2bKpHmcjNndLQL
         7vFUiQkuyM8J3Z9C5i3HS882w+yxZ9B2CqMaWmgAMpQDM2zKOqB5mQ0b8QYnFNtMtK49
         57WA==
X-Gm-Message-State: AOAM53153Ixi/P7GZDch+kA444H/SKN7d5hH73UMY0cnZEw17rayyJuA
        XsVNWs/9EX8AhaiiByJyqmKtbw==
X-Google-Smtp-Source: ABdhPJwZpN31AOXioEN9JiSwqRoUmQ80iiNHv4T0NpDl7YUZ0tnKsoQQevQKz/UeP9vjrxIDoY6Skg==
X-Received: by 2002:a63:d650:: with SMTP id d16mr13453163pgj.277.1603724153485;
        Mon, 26 Oct 2020 07:55:53 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.55.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:55:52 -0700 (PDT)
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
Subject: [PATCH v2 17/19] mm/hugetlb: Merge pte to huge pmd only for gigantic page
Date:   Mon, 26 Oct 2020 22:51:12 +0800
Message-Id: <20201026145114.59424-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge pte to huge pmd if it has ever been split. Now only support
gigantic page which's vmemmap pages size is an integer multiple of
PMD_SIZE. This is the simplest case to handle.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/include/asm/hugetlb.h |   8 +++
 include/linux/hugetlb.h        |   7 +++
 mm/hugetlb.c                   | 106 ++++++++++++++++++++++++++++++++-
 3 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index 7c3eb60c2198..9f9e19dd0578 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -15,6 +15,14 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
 {
 	return pmd_large(*pmd);
 }
+
+#define vmemmap_pmd_mkhuge vmemmap_pmd_mkhuge
+static inline pmd_t vmemmap_pmd_mkhuge(struct page *page)
+{
+	pte_t entry = pfn_pte(page_to_pfn(page), PAGE_KERNEL_LARGE);
+
+	return __pmd(pte_val(entry));
+}
 #endif
 
 #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 695d3041ae7d..3a45199cc5c1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -611,6 +611,13 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
 }
 #endif
 
+#ifndef vmemmap_pmd_mkhuge
+static inline pmd_t vmemmap_pmd_mkhuge(struct page *page)
+{
+	return pmd_mkhuge(mk_pmd(page, PAGE_KERNEL));
+}
+#endif
+
 #ifndef VMEMMAP_HPAGE_SHIFT
 #define VMEMMAP_HPAGE_SHIFT		PMD_SHIFT
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 82467d573fee..a526bcdb137b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1718,6 +1718,62 @@ static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 	}
 }
 
+static void __replace_huge_page_pte_vmemmap(pte_t *ptep, unsigned long start,
+					    unsigned int nr, struct page *huge,
+					    struct list_head *free_pages)
+{
+	unsigned long addr;
+	unsigned long end = start + (nr << PAGE_SHIFT);
+
+	for (addr = start; addr < end; addr += PAGE_SIZE, ptep++) {
+		struct page *page;
+		pte_t old = *ptep;
+		pte_t entry;
+
+		prepare_vmemmap_page(huge);
+
+		entry = mk_pte(huge++, PAGE_KERNEL);
+		VM_WARN_ON(!pte_present(old));
+		page = pte_page(old);
+		list_add(&page->lru, free_pages);
+
+		set_pte_at(&init_mm, addr, ptep, entry);
+	}
+}
+
+static void replace_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
+					  struct page *huge,
+					  struct list_head *free_pages)
+{
+	unsigned long end = start + VMEMMAP_HPAGE_SIZE;
+
+	flush_cache_vunmap(start, end);
+	__replace_huge_page_pte_vmemmap(pte_offset_kernel(pmd, start), start,
+					VMEMMAP_HPAGE_NR, huge, free_pages);
+	flush_tlb_kernel_range(start, end);
+}
+
+static pte_t *merge_vmemmap_pte(pmd_t *pmdp, unsigned long addr)
+{
+	pte_t *pte;
+	struct page *page;
+
+	pte = pte_offset_kernel(pmdp, addr);
+	page = pte_page(*pte);
+	set_pmd(pmdp, vmemmap_pmd_mkhuge(page));
+
+	return pte;
+}
+
+static void merge_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
+					struct page *huge,
+					struct list_head *free_pages)
+{
+	replace_huge_page_pmd_vmemmap(pmd, start, huge, free_pages);
+	pte_free_kernel(&init_mm, merge_vmemmap_pte(pmd, start));
+	flush_tlb_kernel_range(start, start + VMEMMAP_HPAGE_SIZE);
+}
+
 static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
 {
 	int i;
@@ -1731,6 +1787,15 @@ static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
 	}
 }
 
+static inline void dissolve_compound_page(struct page *page, unsigned int order)
+{
+	int i;
+	unsigned int nr_pages = 1 << order;
+
+	for (i = 1; i < nr_pages; i++)
+		set_page_refcounted(page + i);
+}
+
 static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 	pmd_t *pmd;
@@ -1750,10 +1815,47 @@ static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 				    __remap_huge_page_pte_vmemmap);
 	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd)) && pmd_split(pmd)) {
 		/*
-		 * Todo:
-		 * Merge pte to huge pmd if it has ever been split.
+		 * Merge pte to huge pmd if it has ever been split. Now only
+		 * support gigantic page which's vmemmap pages size is an
+		 * integer multiple of PMD_SIZE. This is the simplest case
+		 * to handle.
 		 */
 		clear_pmd_split(pmd);
+
+		if (IS_ALIGNED(nr_vmemmap(h), VMEMMAP_HPAGE_NR)) {
+			unsigned long addr = (unsigned long)head;
+			unsigned long end = addr + nr_vmemmap_size(h);
+
+			spin_unlock(ptl);
+
+			for (; addr < end; addr += VMEMMAP_HPAGE_SIZE) {
+				void *to;
+				struct page *page;
+
+				page = alloc_pages(GFP_VMEMMAP_PAGE & ~__GFP_NOFAIL,
+						   VMEMMAP_HPAGE_ORDER);
+				dissolve_compound_page(page,
+						       VMEMMAP_HPAGE_ORDER);
+				if (!page)
+					goto out;
+
+				to = page_to_virt(page);
+				memcpy(to, (void *)addr, VMEMMAP_HPAGE_SIZE);
+
+				/*
+				 * Make sure that any data that writes to the
+				 * @to is made visible to the physical page.
+				 */
+				flush_kernel_vmap_range(to, VMEMMAP_HPAGE_SIZE);
+
+				merge_huge_page_pmd_vmemmap(pmd++, addr, page,
+							    &remap_pages);
+			}
+
+out:
+			free_vmemmap_page_list(&remap_pages);
+			return;
+		}
 	}
 	spin_unlock(ptl);
 }
-- 
2.20.1

