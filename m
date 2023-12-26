Return-Path: <linux-fsdevel+bounces-6926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D781E9A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 21:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85ED2826E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6809711CBC;
	Tue, 26 Dec 2023 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aWfMZSDZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889E2F3F
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67fb9df3699so27108996d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703620930; x=1704225730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fw1r14mYd/eh7ZKj+/jN30p/HYowmCojeYXfDLguFk8=;
        b=aWfMZSDZc1wMraICFvm3k6pD3D/eVfCBtaY93jSHGbwpsCo7+lkZ/E0lS/2Gvf6wCN
         Ij5OYV1CZ4X6NnKNRuHkgCyVJGHYnSyV0dVIKxwq4Sc3NhpJZd4xZ93H5wDsipekWu5G
         FGXwIhOGk3AypqK/jVQOXJsSENfugYUfxXsCYMtfVK662Q//ShiQNPKNtbg2lHD8zy8A
         Z9LjpEXCFDnP2nFr3T4PWcgM9A30nW9mTykBuoZigkGFL1g+zv7CWdWCmnGk4bzo2h5w
         o0S3xrRYvpHqIOm/Y28xCGmoPxRWexpaFaSoncxFM1V90TcyRZ7GWzk8tjlNnJONKHh2
         sXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703620930; x=1704225730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fw1r14mYd/eh7ZKj+/jN30p/HYowmCojeYXfDLguFk8=;
        b=AdLDHGb5UYHt1hE7dSN2wyI4Vet3tYu0irs2O1zuIXuGI59vIRrqHDmHT5ARxP2Cu7
         22diJMAUdYJQmRgnk7C6EnmP7Cc5BS+1vVDgFwimoqJzLLPElM8MjDYb43BwnvTHqDpq
         pyw3VBaeEWeM5Sx2fq0MaQ9UIaocTBVgrO6imYF7uV9Q1dCW19Eot5Q0V+m2yBxZJt5j
         LFp3N+0CT6kcTqa7dOqHyUiBIndq/SCFS8XbLpEMiPcSrNnpA/Bj5LJaJCkGlWvcFOeY
         bDWH/opPzJjztxUSe+BgRUxDlRQwJSScSwsnaRtWXBFhb2o+dYJurY+eiW2MtFNRJG8X
         OEVw==
X-Gm-Message-State: AOJu0Yz7wPDDWAe5bGrd1cSAoGHCjVO948CAkx85NPU8dwBoh+1ud+1K
	OltacYeQ6XutJE9CIl5P22S15OQJXdt/Uw==
X-Google-Smtp-Source: AGHT+IGJeiDIJ6fnNS4YMbib8jx0koBbx8pwPib/wY3O12z4NHSpxaNNOfqEN0BRD/BFxXkXFxJLJg==
X-Received: by 2002:a05:6214:4c01:b0:67f:bd1a:a11f with SMTP id qh1-20020a0562144c0100b0067fbd1aa11fmr6157088qvb.117.1703620930216;
        Tue, 26 Dec 2023 12:02:10 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id t5-20020a0cf985000000b0067f696f412esm4894539qvn.112.2023.12.26.12.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:02:09 -0800 (PST)
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
Subject: [PATCH v3 02/10] iommu/amd: use page allocation function provided by iommu-pages.h
Date: Tue, 26 Dec 2023 20:01:57 +0000
Message-ID: <20231226200205.562565-3-pasha.tatashin@soleen.com>
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

Convert iommu/amd/* files to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 drivers/iommu/amd/amd_iommu.h     |  8 ---
 drivers/iommu/amd/init.c          | 91 ++++++++++++++-----------------
 drivers/iommu/amd/io_pgtable.c    | 13 +++--
 drivers/iommu/amd/io_pgtable_v2.c | 20 +++----
 drivers/iommu/amd/iommu.c         | 13 +++--
 5 files changed, 64 insertions(+), 81 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 86be1edd50ee..bf697d566e0b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -136,14 +136,6 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
 	return PCI_SEG_DEVID_TO_SBDF(seg, devid);
 }
 
-static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
-{
-	struct page *page;
-
-	page = alloc_pages_node(nid, gfp | __GFP_ZERO, 0);
-	return page ? page_address(page) : NULL;
-}
-
 bool translation_pre_enabled(struct amd_iommu *iommu);
 bool amd_iommu_is_attach_deferred(struct device *dev);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 64bcf3df37ee..5b8a80fc7e50 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -35,6 +35,7 @@
 
 #include "amd_iommu.h"
 #include "../irq_remapping.h"
+#include "../iommu-pages.h"
 
 /*
  * definitions for the ACPI scanning code
@@ -648,8 +649,8 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_
 /* Allocate per PCI segment device table */
 static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	pci_seg->dev_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
-						      get_order(pci_seg->dev_table_size));
+	pci_seg->dev_table = iommu_alloc_pages(GFP_KERNEL | GFP_DMA32,
+					       get_order(pci_seg->dev_table_size));
 	if (!pci_seg->dev_table)
 		return -ENOMEM;
 
@@ -658,17 +659,16 @@ static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 
 static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	free_pages((unsigned long)pci_seg->dev_table,
-		    get_order(pci_seg->dev_table_size));
+	iommu_free_pages(pci_seg->dev_table,
+			 get_order(pci_seg->dev_table_size));
 	pci_seg->dev_table = NULL;
 }
 
 /* Allocate per PCI segment IOMMU rlookup table. */
 static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	pci_seg->rlookup_table = (void *)__get_free_pages(
-						GFP_KERNEL | __GFP_ZERO,
-						get_order(pci_seg->rlookup_table_size));
+	pci_seg->rlookup_table = iommu_alloc_pages(GFP_KERNEL,
+						   get_order(pci_seg->rlookup_table_size));
 	if (pci_seg->rlookup_table == NULL)
 		return -ENOMEM;
 
@@ -677,16 +677,15 @@ static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 
 static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	free_pages((unsigned long)pci_seg->rlookup_table,
-		   get_order(pci_seg->rlookup_table_size));
+	iommu_free_pages(pci_seg->rlookup_table,
+			 get_order(pci_seg->rlookup_table_size));
 	pci_seg->rlookup_table = NULL;
 }
 
 static inline int __init alloc_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	pci_seg->irq_lookup_table = (void *)__get_free_pages(
-					     GFP_KERNEL | __GFP_ZERO,
-					     get_order(pci_seg->rlookup_table_size));
+	pci_seg->irq_lookup_table = iommu_alloc_pages(GFP_KERNEL,
+						      get_order(pci_seg->rlookup_table_size));
 	kmemleak_alloc(pci_seg->irq_lookup_table,
 		       pci_seg->rlookup_table_size, 1, GFP_KERNEL);
 	if (pci_seg->irq_lookup_table == NULL)
@@ -698,8 +697,8 @@ static inline int __init alloc_irq_lookup_table(struct amd_iommu_pci_seg *pci_se
 static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	kmemleak_free(pci_seg->irq_lookup_table);
-	free_pages((unsigned long)pci_seg->irq_lookup_table,
-		   get_order(pci_seg->rlookup_table_size));
+	iommu_free_pages(pci_seg->irq_lookup_table,
+			 get_order(pci_seg->rlookup_table_size));
 	pci_seg->irq_lookup_table = NULL;
 }
 
@@ -707,8 +706,8 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	int i;
 
-	pci_seg->alias_table = (void *)__get_free_pages(GFP_KERNEL,
-					get_order(pci_seg->alias_table_size));
+	pci_seg->alias_table = iommu_alloc_pages(GFP_KERNEL,
+						 get_order(pci_seg->alias_table_size));
 	if (!pci_seg->alias_table)
 		return -ENOMEM;
 
@@ -723,8 +722,8 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 
 static void __init free_alias_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	free_pages((unsigned long)pci_seg->alias_table,
-		   get_order(pci_seg->alias_table_size));
+	iommu_free_pages(pci_seg->alias_table,
+			 get_order(pci_seg->alias_table_size));
 	pci_seg->alias_table = NULL;
 }
 
@@ -735,8 +734,8 @@ static void __init free_alias_table(struct amd_iommu_pci_seg *pci_seg)
  */
 static int __init alloc_command_buffer(struct amd_iommu *iommu)
 {
-	iommu->cmd_buf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						  get_order(CMD_BUFFER_SIZE));
+	iommu->cmd_buf = iommu_alloc_pages(GFP_KERNEL,
+					   get_order(CMD_BUFFER_SIZE));
 
 	return iommu->cmd_buf ? 0 : -ENOMEM;
 }
@@ -844,19 +843,19 @@ static void iommu_disable_command_buffer(struct amd_iommu *iommu)
 
 static void __init free_command_buffer(struct amd_iommu *iommu)
 {
-	free_pages((unsigned long)iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
+	iommu_free_pages(iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
 }
 
 static void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 					 gfp_t gfp, size_t size)
 {
 	int order = get_order(size);
-	void *buf = (void *)__get_free_pages(gfp, order);
+	void *buf = iommu_alloc_pages(gfp, order);
 
 	if (buf &&
 	    check_feature(FEATURE_SNP) &&
 	    set_memory_4k((unsigned long)buf, (1 << order))) {
-		free_pages((unsigned long)buf, order);
+		iommu_free_pages(buf, order);
 		buf = NULL;
 	}
 
@@ -866,7 +865,7 @@ static void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 /* allocates the memory where the IOMMU will log its events to */
 static int __init alloc_event_buffer(struct amd_iommu *iommu)
 {
-	iommu->evt_buf = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO,
+	iommu->evt_buf = iommu_alloc_4k_pages(iommu, GFP_KERNEL,
 					      EVT_BUFFER_SIZE);
 
 	return iommu->evt_buf ? 0 : -ENOMEM;
@@ -900,14 +899,13 @@ static void iommu_disable_event_buffer(struct amd_iommu *iommu)
 
 static void __init free_event_buffer(struct amd_iommu *iommu)
 {
-	free_pages((unsigned long)iommu->evt_buf, get_order(EVT_BUFFER_SIZE));
+	iommu_free_pages(iommu->evt_buf, get_order(EVT_BUFFER_SIZE));
 }
 
 /* allocates the memory where the IOMMU will log its events to */
 static int __init alloc_ppr_log(struct amd_iommu *iommu)
 {
-	iommu->ppr_log = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO,
-					      PPR_LOG_SIZE);
+	iommu->ppr_log = iommu_alloc_4k_pages(iommu, GFP_KERNEL, PPR_LOG_SIZE);
 
 	return iommu->ppr_log ? 0 : -ENOMEM;
 }
@@ -936,14 +934,14 @@ static void iommu_enable_ppr_log(struct amd_iommu *iommu)
 
 static void __init free_ppr_log(struct amd_iommu *iommu)
 {
-	free_pages((unsigned long)iommu->ppr_log, get_order(PPR_LOG_SIZE));
+	iommu_free_pages(iommu->ppr_log, get_order(PPR_LOG_SIZE));
 }
 
 static void free_ga_log(struct amd_iommu *iommu)
 {
 #ifdef CONFIG_IRQ_REMAP
-	free_pages((unsigned long)iommu->ga_log, get_order(GA_LOG_SIZE));
-	free_pages((unsigned long)iommu->ga_log_tail, get_order(8));
+	iommu_free_pages(iommu->ga_log, get_order(GA_LOG_SIZE));
+	iommu_free_pages(iommu->ga_log_tail, get_order(8));
 #endif
 }
 
@@ -988,13 +986,11 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 		return 0;
 
-	iommu->ga_log = (u8 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					get_order(GA_LOG_SIZE));
+	iommu->ga_log = iommu_alloc_pages(GFP_KERNEL, get_order(GA_LOG_SIZE));
 	if (!iommu->ga_log)
 		goto err_out;
 
-	iommu->ga_log_tail = (u8 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					get_order(8));
+	iommu->ga_log_tail = iommu_alloc_pages(GFP_KERNEL, get_order(8));
 	if (!iommu->ga_log_tail)
 		goto err_out;
 
@@ -1007,7 +1003,7 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 
 static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
 {
-	iommu->cmd_sem = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO, 1);
+	iommu->cmd_sem = iommu_alloc_4k_pages(iommu, GFP_KERNEL, 1);
 
 	return iommu->cmd_sem ? 0 : -ENOMEM;
 }
@@ -1015,7 +1011,7 @@ static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
 static void __init free_cwwb_sem(struct amd_iommu *iommu)
 {
 	if (iommu->cmd_sem)
-		free_page((unsigned long)iommu->cmd_sem);
+		iommu_free_page((void *)iommu->cmd_sem);
 }
 
 static void iommu_enable_xt(struct amd_iommu *iommu)
@@ -1080,7 +1076,6 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 	u32 lo, hi, devid, old_devtb_size;
 	phys_addr_t old_devtb_phys;
 	u16 dom_id, dte_v, irq_v;
-	gfp_t gfp_flag;
 	u64 tmp;
 
 	/* Each IOMMU use separate device table with the same size */
@@ -1114,9 +1109,8 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 	if (!old_devtb)
 		return false;
 
-	gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;
-	pci_seg->old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
-						    get_order(pci_seg->dev_table_size));
+	pci_seg->old_dev_tbl_cpy = iommu_alloc_pages(GFP_KERNEL | GFP_DMA32,
+						     get_order(pci_seg->dev_table_size));
 	if (pci_seg->old_dev_tbl_cpy == NULL) {
 		pr_err("Failed to allocate memory for copying old device table!\n");
 		memunmap(old_devtb);
@@ -2800,8 +2794,8 @@ static void early_enable_iommus(void)
 
 		for_each_pci_segment(pci_seg) {
 			if (pci_seg->old_dev_tbl_cpy != NULL) {
-				free_pages((unsigned long)pci_seg->old_dev_tbl_cpy,
-						get_order(pci_seg->dev_table_size));
+				iommu_free_pages(pci_seg->old_dev_tbl_cpy,
+						 get_order(pci_seg->dev_table_size));
 				pci_seg->old_dev_tbl_cpy = NULL;
 			}
 		}
@@ -2814,8 +2808,8 @@ static void early_enable_iommus(void)
 		pr_info("Copied DEV table from previous kernel.\n");
 
 		for_each_pci_segment(pci_seg) {
-			free_pages((unsigned long)pci_seg->dev_table,
-				   get_order(pci_seg->dev_table_size));
+			iommu_free_pages(pci_seg->dev_table,
+					 get_order(pci_seg->dev_table_size));
 			pci_seg->dev_table = pci_seg->old_dev_tbl_cpy;
 		}
 
@@ -3018,8 +3012,8 @@ static bool __init check_ioapic_information(void)
 
 static void __init free_dma_resources(void)
 {
-	free_pages((unsigned long)amd_iommu_pd_alloc_bitmap,
-		   get_order(MAX_DOMAIN_ID/8));
+	iommu_free_pages(amd_iommu_pd_alloc_bitmap,
+			 get_order(MAX_DOMAIN_ID / 8));
 	amd_iommu_pd_alloc_bitmap = NULL;
 
 	free_unity_maps();
@@ -3091,9 +3085,8 @@ static int __init early_amd_iommu_init(void)
 	/* Device table - directly used by all IOMMUs */
 	ret = -ENOMEM;
 
-	amd_iommu_pd_alloc_bitmap = (void *)__get_free_pages(
-					    GFP_KERNEL | __GFP_ZERO,
-					    get_order(MAX_DOMAIN_ID/8));
+	amd_iommu_pd_alloc_bitmap = iommu_alloc_pages(GFP_KERNEL,
+						      get_order(MAX_DOMAIN_ID / 8));
 	if (amd_iommu_pd_alloc_bitmap == NULL)
 		goto out;
 
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 6c0621f6f572..f8b7d4c39a9f 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -22,6 +22,7 @@
 
 #include "amd_iommu_types.h"
 #include "amd_iommu.h"
+#include "../iommu-pages.h"
 
 static void v1_tlb_flush_all(void *cookie)
 {
@@ -156,7 +157,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	bool ret = true;
 	u64 *pte;
 
-	pte = alloc_pgtable_page(domain->nid, gfp);
+	pte = iommu_alloc_page_node(domain->nid, gfp);
 	if (!pte)
 		return false;
 
@@ -187,7 +188,7 @@ static bool increase_address_space(struct protection_domain *domain,
 
 out:
 	spin_unlock_irqrestore(&domain->lock, flags);
-	free_page((unsigned long)pte);
+	iommu_free_page(pte);
 
 	return ret;
 }
@@ -250,7 +251,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 
 		if (!IOMMU_PTE_PRESENT(__pte) ||
 		    pte_level == PAGE_MODE_NONE) {
-			page = alloc_pgtable_page(domain->nid, gfp);
+			page = iommu_alloc_page_node(domain->nid, gfp);
 
 			if (!page)
 				return NULL;
@@ -259,7 +260,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 
 			/* pte could have been changed somewhere. */
 			if (!try_cmpxchg64(pte, &__pte, __npte))
-				free_page((unsigned long)page);
+				iommu_free_page(page);
 			else if (IOMMU_PTE_PRESENT(__pte))
 				*updated = true;
 
@@ -430,7 +431,7 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	}
 
 	/* Everything flushed out, free pages now */
-	put_pages_list(&freelist);
+	iommu_free_pages_list(&freelist);
 
 	return ret;
 }
@@ -579,7 +580,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 	/* Make changes visible to IOMMUs */
 	amd_iommu_domain_update(dom);
 
-	put_pages_list(&freelist);
+	iommu_free_pages_list(&freelist);
 }
 
 static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index f818a7e254d4..1e08dab93686 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -18,6 +18,7 @@
 
 #include "amd_iommu_types.h"
 #include "amd_iommu.h"
+#include "../iommu-pages.h"
 
 #define IOMMU_PAGE_PRESENT	BIT_ULL(0)	/* Is present */
 #define IOMMU_PAGE_RW		BIT_ULL(1)	/* Writeable */
@@ -99,11 +100,6 @@ static inline int page_size_to_level(u64 pg_size)
 	return PAGE_MODE_1_LEVEL;
 }
 
-static inline void free_pgtable_page(u64 *pt)
-{
-	free_page((unsigned long)pt);
-}
-
 static void free_pgtable(u64 *pt, int level)
 {
 	u64 *p;
@@ -125,10 +121,10 @@ static void free_pgtable(u64 *pt, int level)
 		if (level > 2)
 			free_pgtable(p, level - 1);
 		else
-			free_pgtable_page(p);
+			iommu_free_page(p);
 	}
 
-	free_pgtable_page(pt);
+	iommu_free_page(pt);
 }
 
 /* Allocate page table */
@@ -156,14 +152,14 @@ static u64 *v2_alloc_pte(int nid, u64 *pgd, unsigned long iova,
 		}
 
 		if (!IOMMU_PTE_PRESENT(__pte)) {
-			page = alloc_pgtable_page(nid, gfp);
+			page = iommu_alloc_page_node(nid, gfp);
 			if (!page)
 				return NULL;
 
 			__npte = set_pgtable_attr(page);
 			/* pte could have been changed somewhere. */
 			if (cmpxchg64(pte, __pte, __npte) != __pte)
-				free_pgtable_page(page);
+				iommu_free_page(page);
 			else if (IOMMU_PTE_PRESENT(__pte))
 				*updated = true;
 
@@ -185,7 +181,7 @@ static u64 *v2_alloc_pte(int nid, u64 *pgd, unsigned long iova,
 		if (pg_size == IOMMU_PAGE_SIZE_1G)
 			free_pgtable(__pte, end_level - 1);
 		else if (pg_size == IOMMU_PAGE_SIZE_2M)
-			free_pgtable_page(__pte);
+			iommu_free_page(__pte);
 	}
 
 	return pte;
@@ -380,7 +376,7 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	int ret;
 	int ias = IOMMU_IN_ADDR_BIT_SIZE;
 
-	pgtable->pgd = alloc_pgtable_page(pdom->nid, GFP_ATOMIC);
+	pgtable->pgd = iommu_alloc_page_node(pdom->nid, GFP_ATOMIC);
 	if (!pgtable->pgd)
 		return NULL;
 
@@ -403,7 +399,7 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	return &pgtable->iop;
 
 err_free_pgd:
-	free_pgtable_page(pgtable->pgd);
+	iommu_free_page(pgtable->pgd);
 
 	return NULL;
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fcc987f5d4ed..9a228a95da0e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -42,6 +42,7 @@
 #include "amd_iommu.h"
 #include "../dma-iommu.h"
 #include "../irq_remapping.h"
+#include "../iommu-pages.h"
 
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
@@ -1642,7 +1643,7 @@ static void free_gcr3_tbl_level1(u64 *tbl)
 
 		ptr = iommu_phys_to_virt(tbl[i] & PAGE_MASK);
 
-		free_page((unsigned long)ptr);
+		iommu_free_page(ptr);
 	}
 }
 
@@ -1670,7 +1671,7 @@ static void free_gcr3_table(struct protection_domain *domain)
 	else
 		BUG_ON(domain->glx != 0);
 
-	free_page((unsigned long)domain->gcr3_tbl);
+	iommu_free_page(domain->gcr3_tbl);
 }
 
 /*
@@ -1697,7 +1698,7 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
+	domain->gcr3_tbl = iommu_alloc_page_node(domain->nid, GFP_ATOMIC);
 	if (domain->gcr3_tbl == NULL)
 		return -ENOMEM;
 
@@ -2092,7 +2093,7 @@ static void protection_domain_free(struct protection_domain *domain)
 		free_gcr3_table(domain);
 
 	if (domain->iop.root)
-		free_page((unsigned long)domain->iop.root);
+		iommu_free_page(domain->iop.root);
 
 	if (domain->id)
 		domain_id_free(domain->id);
@@ -2107,7 +2108,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	BUG_ON(mode < PAGE_MODE_NONE || mode > PAGE_MODE_6_LEVEL);
 
 	if (mode != PAGE_MODE_NONE) {
-		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
+		pt_root = iommu_alloc_page(GFP_KERNEL);
 		if (!pt_root)
 			return -ENOMEM;
 	}
@@ -2783,7 +2784,7 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 			if (!alloc)
 				return NULL;
 
-			root = (void *)get_zeroed_page(GFP_ATOMIC);
+			root = iommu_alloc_page(GFP_ATOMIC);
 			if (root == NULL)
 				return NULL;
 
-- 
2.43.0.472.g3155946c3a-goog


