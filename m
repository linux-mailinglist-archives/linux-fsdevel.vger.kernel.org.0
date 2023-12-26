Return-Path: <linux-fsdevel+bounces-6925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728FA81E99F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 21:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5AB4B221CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 20:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B810A06;
	Tue, 26 Dec 2023 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JGMjdJeT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CB65251
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67fa018c116so25797586d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703620929; x=1704225729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrgxBJJnUtul2cVGK+LwAz1M+T2/gmkmQ5y2nUTXV7A=;
        b=JGMjdJeTzzXrVruZJY+C5R7I6FbPqhpR+ywXpBjXianLlCryZ+NB4JknEuPzadkpwZ
         yvuq1gODzVu78Ab3ooHQCxMJi3mwwZTna31Xih/yZvs1S1KIpVrK/Q0DdjdI/7ViMABI
         w3lo7A7RRksuh3VagNde/49AzZHcWQT+VxNxs3cjtCAGGpS/DWTTFgjKpoXNqlxEWQeT
         XoT55uaP6KcpSBDUU2w8f1YH4GAL1vGA+feGNvbTFE6x+wfMVYWkG34bNRmlv0cJRyne
         IfVvfhbtpOrn5N1sMYmS9rUCTlbyAbopQPbX0M0ETGZVv7oOELeoKWZ04lT0oaxJerFa
         s3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703620929; x=1704225729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrgxBJJnUtul2cVGK+LwAz1M+T2/gmkmQ5y2nUTXV7A=;
        b=Psz4tXBUM4qIZu8YrbpiG0GtWGNpmc9WaGgKsJXjpSHE/2E/XdbyLKQ4T7o8XLHSpB
         78L1y+YLOwYSqsX5Je2fu4eRfNidL0v7bjz7P5g6n3BlTNxKJ3Nbo9oerNcvdvETmTcD
         lFEP9ylOhJn9bzb4n/brvvXc9Hb1/qBMSnfxp08zL6NajGky4ae3Uc51LPy7XUjiprnE
         785LdX90GMuFNgqISGuXuMsfxC41fvM/5WIWtM50UYIshBNI/Hx4BzXPmxMjAcGVn6DP
         hBETmdDPNa7VbPATprikvtk4sMUk5hccWx38h9ZQMUTAPtXwhqXN6ro/hoddy2LkIXQc
         t3BQ==
X-Gm-Message-State: AOJu0Yz89yR5fHej6hzpUw+eMigkoL4eg8+idfkJr5kWJrM8WtTh+uxV
	IFXD2vpjUUZ8E/iTsI2d0dKh+JrJDtaXsA==
X-Google-Smtp-Source: AGHT+IHu+hz5hjZkOjtuugcvM9g0ro43MdzPJSM3RLwP6wrMyMOdUctTt4PeczEJLjFNtTFkqbfPDg==
X-Received: by 2002:a05:6214:f62:b0:67a:db18:10e2 with SMTP id iy2-20020a0562140f6200b0067adb1810e2mr13115303qvb.37.1703620929161;
        Tue, 26 Dec 2023 12:02:09 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id t5-20020a0cf985000000b0067f696f412esm4894539qvn.112.2023.12.26.12.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:02:08 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com
Subject: [PATCH v3 01/10] iommu/vt-d: add wrapper functions for page allocations
Date: Tue, 26 Dec 2023 20:01:56 +0000
Message-ID: <20231226200205.562565-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231226200205.562565-1-pasha.tatashin@soleen.com>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to improve observability and accountability of IOMMU layer, we
must account the number of pages that are allocated by functions that
are calling directly into buddy allocator.

This is achieved by first wrapping the allocation related functions into a
separate inline functions in new file:

drivers/iommu/iommu-pages.h

Convert all page allocation calls under iommu/intel to use these new
functions.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/intel/dmar.c          |  10 +-
 drivers/iommu/intel/iommu.c         |  47 +++----
 drivers/iommu/intel/iommu.h         |   2 -
 drivers/iommu/intel/irq_remapping.c |  10 +-
 drivers/iommu/intel/pasid.c         |  12 +-
 drivers/iommu/intel/svm.c           |   7 +-
 drivers/iommu/iommu-pages.h         | 204 ++++++++++++++++++++++++++++
 7 files changed, 241 insertions(+), 51 deletions(-)
 create mode 100644 drivers/iommu/iommu-pages.h

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..f72b1e4334b1 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -32,6 +32,7 @@
 
 #include "iommu.h"
 #include "../irq_remapping.h"
+#include "../iommu-pages.h"
 #include "perf.h"
 #include "trace.h"
 #include "perfmon.h"
@@ -1185,7 +1186,7 @@ static void free_iommu(struct intel_iommu *iommu)
 	}
 
 	if (iommu->qi) {
-		free_page((unsigned long)iommu->qi->desc);
+		iommu_free_page(iommu->qi->desc);
 		kfree(iommu->qi->desc_status);
 		kfree(iommu->qi);
 	}
@@ -1732,6 +1733,7 @@ int dmar_enable_qi(struct intel_iommu *iommu)
 {
 	struct q_inval *qi;
 	struct page *desc_page;
+	int order;
 
 	if (!ecap_qis(iommu->ecap))
 		return -ENOENT;
@@ -1752,8 +1754,8 @@ int dmar_enable_qi(struct intel_iommu *iommu)
 	 * Need two pages to accommodate 256 descriptors of 256 bits each
 	 * if the remapping hardware supports scalable mode translation.
 	 */
-	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
-				     !!ecap_smts(iommu->ecap));
+	order = ecap_smts(iommu->ecap) ? 1 : 0;
+	desc_page = __iommu_alloc_pages_node(iommu->node, GFP_ATOMIC, order);
 	if (!desc_page) {
 		kfree(qi);
 		iommu->qi = NULL;
@@ -1764,7 +1766,7 @@ int dmar_enable_qi(struct intel_iommu *iommu)
 
 	qi->desc_status = kcalloc(QI_LENGTH, sizeof(int), GFP_ATOMIC);
 	if (!qi->desc_status) {
-		free_page((unsigned long) qi->desc);
+		iommu_free_page(qi->desc);
 		kfree(qi);
 		iommu->qi = NULL;
 		return -ENOMEM;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 897159dba47d..4ae52569ab4a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -28,6 +28,7 @@
 #include "../dma-iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-sva.h"
+#include "../iommu-pages.h"
 #include "pasid.h"
 #include "cap_audit.h"
 #include "perfmon.h"
@@ -367,22 +368,6 @@ static int __init intel_iommu_setup(char *str)
 }
 __setup("intel_iommu=", intel_iommu_setup);
 
-void *alloc_pgtable_page(int node, gfp_t gfp)
-{
-	struct page *page;
-	void *vaddr = NULL;
-
-	page = alloc_pages_node(node, gfp | __GFP_ZERO, 0);
-	if (page)
-		vaddr = page_address(page);
-	return vaddr;
-}
-
-void free_pgtable_page(void *vaddr)
-{
-	free_page((unsigned long)vaddr);
-}
-
 static inline int domain_type_is_si(struct dmar_domain *domain)
 {
 	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
@@ -617,7 +602,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 		if (!alloc)
 			return NULL;
 
-		context = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
+		context = iommu_alloc_page_node(iommu->node, GFP_ATOMIC);
 		if (!context)
 			return NULL;
 
@@ -791,17 +776,17 @@ static void free_context_table(struct intel_iommu *iommu)
 	for (i = 0; i < ROOT_ENTRY_NR; i++) {
 		context = iommu_context_addr(iommu, i, 0, 0);
 		if (context)
-			free_pgtable_page(context);
+			iommu_free_page(context);
 
 		if (!sm_supported(iommu))
 			continue;
 
 		context = iommu_context_addr(iommu, i, 0x80, 0);
 		if (context)
-			free_pgtable_page(context);
+			iommu_free_page(context);
 	}
 
-	free_pgtable_page(iommu->root_entry);
+	iommu_free_page(iommu->root_entry);
 	iommu->root_entry = NULL;
 }
 
@@ -939,7 +924,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 		if (!dma_pte_present(pte)) {
 			uint64_t pteval;
 
-			tmp_page = alloc_pgtable_page(domain->nid, gfp);
+			tmp_page = iommu_alloc_page_node(domain->nid, gfp);
 
 			if (!tmp_page)
 				return NULL;
@@ -951,7 +936,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
-				free_pgtable_page(tmp_page);
+				iommu_free_page(tmp_page);
 			else
 				domain_flush_cache(domain, pte, sizeof(*pte));
 		}
@@ -1064,7 +1049,7 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
 		      last_pfn < level_pfn + level_size(level) - 1)) {
 			dma_clear_pte(pte);
 			domain_flush_cache(domain, pte, sizeof(*pte));
-			free_pgtable_page(level_pte);
+			iommu_free_page(level_pte);
 		}
 next:
 		pfn += level_size(level);
@@ -1088,7 +1073,7 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
-		free_pgtable_page(domain->pgd);
+		iommu_free_page(domain->pgd);
 		domain->pgd = NULL;
 	}
 }
@@ -1190,7 +1175,7 @@ static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 {
 	struct root_entry *root;
 
-	root = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
+	root = iommu_alloc_page_node(iommu->node, GFP_ATOMIC);
 	if (!root) {
 		pr_err("Allocating root entry for %s failed\n",
 			iommu->name);
@@ -1863,7 +1848,7 @@ static void domain_exit(struct dmar_domain *domain)
 		LIST_HEAD(freelist);
 
 		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
-		put_pages_list(&freelist);
+		iommu_free_pages_list(&freelist);
 	}
 
 	if (WARN_ON(!list_empty(&domain->devices)))
@@ -2640,7 +2625,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			if (!old_ce)
 				goto out;
 
-			new_ce = alloc_pgtable_page(iommu->node, GFP_KERNEL);
+			new_ce = iommu_alloc_page_node(iommu->node, GFP_KERNEL);
 			if (!new_ce)
 				goto out_unmap;
 
@@ -3573,7 +3558,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 					start_vpfn, mhp->nr_pages,
 					list_empty(&freelist), 0);
 			rcu_read_unlock();
-			put_pages_list(&freelist);
+			iommu_free_pages_list(&freelist);
 		}
 		break;
 	}
@@ -4004,7 +3989,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	domain->max_addr = 0;
 
 	/* always allocate the top pgd */
-	domain->pgd = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
+	domain->pgd = iommu_alloc_page_node(domain->nid, GFP_ATOMIC);
 	if (!domain->pgd)
 		return -ENOMEM;
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
@@ -4151,7 +4136,7 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 		pte = dmar_domain->pgd;
 		if (dma_pte_present(pte)) {
 			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
-			free_pgtable_page(pte);
+			iommu_free_page(pte);
 		}
 		dmar_domain->agaw--;
 	}
@@ -4298,7 +4283,7 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 				      start_pfn, nrpages,
 				      list_empty(&gather->freelist), 0);
 
-	put_pages_list(&gather->freelist);
+	iommu_free_pages_list(&gather->freelist);
 }
 
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ce030c5b5772..453e5d84f6a6 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -897,8 +897,6 @@ void domain_update_iommu_cap(struct dmar_domain *domain);
 
 int dmar_ir_support(void);
 
-void *alloc_pgtable_page(int node, gfp_t gfp);
-void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 29b9e55dcf26..72e1c1342c13 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -22,6 +22,7 @@
 
 #include "iommu.h"
 #include "../irq_remapping.h"
+#include "../iommu-pages.h"
 #include "cap_audit.h"
 
 enum irq_mode {
@@ -536,8 +537,8 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	if (!ir_table)
 		return -ENOMEM;
 
-	pages = alloc_pages_node(iommu->node, GFP_KERNEL | __GFP_ZERO,
-				 INTR_REMAP_PAGE_ORDER);
+	pages = __iommu_alloc_pages_node(iommu->node, GFP_KERNEL,
+					 INTR_REMAP_PAGE_ORDER);
 	if (!pages) {
 		pr_err("IR%d: failed to allocate pages of order %d\n",
 		       iommu->seq_id, INTR_REMAP_PAGE_ORDER);
@@ -622,7 +623,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 out_free_bitmap:
 	bitmap_free(bitmap);
 out_free_pages:
-	__free_pages(pages, INTR_REMAP_PAGE_ORDER);
+	__iommu_free_pages(pages, INTR_REMAP_PAGE_ORDER);
 out_free_table:
 	kfree(ir_table);
 
@@ -643,8 +644,7 @@ static void intel_teardown_irq_remapping(struct intel_iommu *iommu)
 			irq_domain_free_fwnode(fn);
 			iommu->ir_domain = NULL;
 		}
-		free_pages((unsigned long)iommu->ir_table->base,
-			   INTR_REMAP_PAGE_ORDER);
+		iommu_free_pages(iommu->ir_table->base, INTR_REMAP_PAGE_ORDER);
 		bitmap_free(iommu->ir_table->bitmap);
 		kfree(iommu->ir_table);
 		iommu->ir_table = NULL;
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 74e8e4c17e81..1856e74bba78 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -20,6 +20,7 @@
 
 #include "iommu.h"
 #include "pasid.h"
+#include "../iommu-pages.h"
 
 /*
  * Intel IOMMU system wide PASID name space:
@@ -116,8 +117,7 @@ int intel_pasid_alloc_table(struct device *dev)
 
 	size = max_pasid >> (PASID_PDE_SHIFT - 3);
 	order = size ? get_order(size) : 0;
-	pages = alloc_pages_node(info->iommu->node,
-				 GFP_KERNEL | __GFP_ZERO, order);
+	pages = __iommu_alloc_pages_node(info->iommu->node, GFP_KERNEL, order);
 	if (!pages) {
 		kfree(pasid_table);
 		return -ENOMEM;
@@ -154,10 +154,10 @@ void intel_pasid_free_table(struct device *dev)
 	max_pde = pasid_table->max_pasid >> PASID_PDE_SHIFT;
 	for (i = 0; i < max_pde; i++) {
 		table = get_pasid_table_from_pde(&dir[i]);
-		free_pgtable_page(table);
+		iommu_free_page(table);
 	}
 
-	free_pages((unsigned long)pasid_table->table, pasid_table->order);
+	iommu_free_pages(pasid_table->table, pasid_table->order);
 	kfree(pasid_table);
 }
 
@@ -203,7 +203,7 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 retry:
 	entries = get_pasid_table_from_pde(&dir[dir_index]);
 	if (!entries) {
-		entries = alloc_pgtable_page(info->iommu->node, GFP_ATOMIC);
+		entries = iommu_alloc_page_node(info->iommu->node, GFP_ATOMIC);
 		if (!entries)
 			return NULL;
 
@@ -215,7 +215,7 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 		 */
 		if (cmpxchg64(&dir[dir_index].val, 0ULL,
 			      (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
-			free_pgtable_page(entries);
+			iommu_free_page(entries);
 			goto retry;
 		}
 		if (!ecap_coherent(info->iommu->ecap)) {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ac12f76c1212..e97f68427b54 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -23,6 +23,7 @@
 #include "pasid.h"
 #include "perf.h"
 #include "../iommu-sva.h"
+#include "../iommu-pages.h"
 #include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
@@ -67,7 +68,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	struct page *pages;
 	int irq, ret;
 
-	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
+	pages = __iommu_alloc_pages(GFP_KERNEL, PRQ_ORDER);
 	if (!pages) {
 		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
 			iommu->name);
@@ -118,7 +119,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	dmar_free_hwirq(irq);
 	iommu->pr_irq = 0;
 free_prq:
-	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
+	iommu_free_pages(iommu->prq, PRQ_ORDER);
 	iommu->prq = NULL;
 
 	return ret;
@@ -141,7 +142,7 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
 		iommu->iopf_queue = NULL;
 	}
 
-	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
+	iommu_free_pages(iommu->prq, PRQ_ORDER);
 	iommu->prq = NULL;
 
 	return 0;
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
new file mode 100644
index 000000000000..99105503b771
--- /dev/null
+++ b/drivers/iommu/iommu-pages.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef __IOMMU_PAGES_H
+#define __IOMMU_PAGES_H
+
+#include <linux/vmstat.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+
+/*
+ * All page allocation that are performed in the IOMMU subsystem must use one of
+ * the functions below.  This is necessary for the proper accounting as IOMMU
+ * state can be rather large, i.e. multiple gigabytes in size.
+ */
+
+/**
+ * __iommu_alloc_pages_node - allocate a zeroed page of a given order from
+ * specific NUMA node.
+ * @nid: memory NUMA node id
+ * @gfp: buddy allocator flags
+ * @order: page order
+ *
+ * returns the head struct page of the allocated page.
+ */
+static inline struct page *__iommu_alloc_pages_node(int nid, gfp_t gfp,
+						    int order)
+{
+	struct page *page;
+
+	page = alloc_pages_node(nid, gfp | __GFP_ZERO, order);
+	if (unlikely(!page))
+		return NULL;
+
+	return page;
+}
+
+/**
+ * __iommu_alloc_pages - allocate a zeroed page of a given order.
+ * @gfp: buddy allocator flags
+ * @order: page order
+ *
+ * returns the head struct page of the allocated page.
+ */
+static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
+{
+	struct page *page;
+
+	page = alloc_pages(gfp | __GFP_ZERO, order);
+	if (unlikely(!page))
+		return NULL;
+
+	return page;
+}
+
+/**
+ * __iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
+ * @nid: memory NUMA node id
+ * @gfp: buddy allocator flags
+ *
+ * returns the struct page of the allocated page.
+ */
+static inline struct page *__iommu_alloc_page_node(int nid, gfp_t gfp)
+{
+	return __iommu_alloc_pages_node(nid, gfp, 0);
+}
+
+/**
+ * __iommu_alloc_page - allocate a zeroed page
+ * @gfp: buddy allocator flags
+ *
+ * returns the struct page of the allocated page.
+ */
+static inline struct page *__iommu_alloc_page(gfp_t gfp)
+{
+	return __iommu_alloc_pages(gfp, 0);
+}
+
+/**
+ * __iommu_free_pages - free page of a given order
+ * @page: head struct page of the page
+ * @order: page order
+ */
+static inline void __iommu_free_pages(struct page *page, int order)
+{
+	if (!page)
+		return;
+
+	__free_pages(page, order);
+}
+
+/**
+ * __iommu_free_page - free page
+ * @page: struct page of the page
+ */
+static inline void __iommu_free_page(struct page *page)
+{
+	__iommu_free_pages(page, 0);
+}
+
+/**
+ * iommu_alloc_pages_node - allocate a zeroed page of a given order from
+ * specific NUMA node.
+ * @nid: memory NUMA node id
+ * @gfp: buddy allocator flags
+ * @order: page order
+ *
+ * returns the virtual address of the allocated page
+ */
+static inline void *iommu_alloc_pages_node(int nid, gfp_t gfp, int order)
+{
+	struct page *page = __iommu_alloc_pages_node(nid, gfp, order);
+
+	if (unlikely(!page))
+		return NULL;
+
+	return page_address(page);
+}
+
+/**
+ * iommu_alloc_pages - allocate a zeroed page of a given order
+ * @gfp: buddy allocator flags
+ * @order: page order
+ *
+ * returns the virtual address of the allocated page
+ */
+static inline void *iommu_alloc_pages(gfp_t gfp, int order)
+{
+	struct page *page = __iommu_alloc_pages(gfp, order);
+
+	if (unlikely(!page))
+		return NULL;
+
+	return page_address(page);
+}
+
+/**
+ * iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
+ * @nid: memory NUMA node id
+ * @gfp: buddy allocator flags
+ *
+ * returns the virtual address of the allocated page
+ */
+static inline void *iommu_alloc_page_node(int nid, gfp_t gfp)
+{
+	return iommu_alloc_pages_node(nid, gfp, 0);
+}
+
+/**
+ * iommu_alloc_page - allocate a zeroed page
+ * @gfp: buddy allocator flags
+ *
+ * returns the virtual address of the allocated page
+ */
+static inline void *iommu_alloc_page(gfp_t gfp)
+{
+	return iommu_alloc_pages(gfp, 0);
+}
+
+/**
+ * iommu_free_pages - free page of a given order
+ * @virt: virtual address of the page to be freed.
+ * @order: page order
+ */
+static inline void iommu_free_pages(void *virt, int order)
+{
+	if (!virt)
+		return;
+
+	__iommu_free_pages(virt_to_page(virt), order);
+}
+
+/**
+ * iommu_free_page - free page
+ * @virt: virtual address of the page to be freed.
+ */
+static inline void iommu_free_page(void *virt)
+{
+	iommu_free_pages(virt, 0);
+}
+
+/**
+ * iommu_free_pages_list - free a list of pages.
+ * @page: the head of the lru list to be freed.
+ *
+ * There are no locking requirement for these pages, as they are going to be
+ * put on a free list as soon as refcount reaches 0. Pages are put on this LRU
+ * list once they are removed from the IOMMU page tables. However, they can
+ * still be access through debugfs.
+ */
+static inline void iommu_free_pages_list(struct list_head *page)
+{
+	while (!list_empty(page)) {
+		struct page *p = list_entry(page->prev, struct page, lru);
+
+		list_del(&p->lru);
+		put_page(p);
+	}
+}
+
+#endif	/* __IOMMU_PAGES_H */
-- 
2.43.0.472.g3155946c3a-goog


