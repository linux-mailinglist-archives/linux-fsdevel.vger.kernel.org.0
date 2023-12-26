Return-Path: <linux-fsdevel+bounces-6927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D65AE81E9A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 21:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D691F219D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494FC11C97;
	Tue, 26 Dec 2023 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Mz60WDXb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552964C90
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-680496bc3aaso2655486d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 12:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703620931; x=1704225731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypS1Neib8HIDm9UmxS/HJDs2d4K6sNmK80zg2UdXDks=;
        b=Mz60WDXbpFTLMDyHRdY9vFqb9GiRwrgMJP3uiarok5TH8mDKD7pI4jZwI6xCdo0iqA
         yPpOPI27GIyMveUhr3q73OYpp4PIm4J3IvhDEEzZ4PgRPvZ8UZQ9Xb5JQKOeINo7zTwO
         dVe5PJO8izc+1oeRL5FiQqg0vCcTn0GkIRG5iPxMmRf03OC+6A+rFj+GdGGdDsSTUKoU
         IpsQls1plJlhIMnlGyHxnGeKPDjN/TM3Gl6SzlwHH6PG2/b8t/kHs/8YJzz67c9Z3mKr
         pLBhPlHNrROtZFawm2aDNmhHx5AFAizJ+HyhuRmI/XDBNuGmTB395IYfkf6uoSV6MYZm
         2isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703620931; x=1704225731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypS1Neib8HIDm9UmxS/HJDs2d4K6sNmK80zg2UdXDks=;
        b=kcvYbv1a3aGiYMq9PY/Rf4xuYKOEmjHhsll9RpyccwyXsz7vb1hkS845dU/Zs8aiFm
         2pHce0VY3qBzZ8ie5ATtWjTRfXyPCz+Cajk4W6rRdYmN/ow3pRafYhnUFZWE/0mAMZ/p
         fSXLv4Qi9MSPlKgpKl/3xyU/W2VHcEtNdQCTjdHrYhZtN2dhW3Rz35uH1Mf2600SHe6V
         czUYHPnp4ZQXL8ML7sCvKcJJ44tSpygBso7oSVvtOyuSmP5yACGiClpcAK7ZVob22UaY
         KcG1HW30YOaL5kuiuPs5L4AS4LeYvTAizFs46JIUn21f1BSP1+Zk4lD/mykwjgYo+VWF
         L+4Q==
X-Gm-Message-State: AOJu0YzHl+h0jfRDzGuGWo2xzpncRsfW2w58V2WYNJ7WsOs31y+kFLZi
	ETvQQXZnUNzgIIujVtTndXd0Nclk8Ozk4g==
X-Google-Smtp-Source: AGHT+IHSQM+LgRuNVnF3iWBSyAs/u7g89umL2iScajvlGIrSq1uiM5Mc659FcM2VTca3M8kj7d2P0g==
X-Received: by 2002:ad4:5ae7:0:b0:67f:7c5c:3449 with SMTP id c7-20020ad45ae7000000b0067f7c5c3449mr13308631qvh.14.1703620931126;
        Tue, 26 Dec 2023 12:02:11 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id t5-20020a0cf985000000b0067f696f412esm4894539qvn.112.2023.12.26.12.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:02:10 -0800 (PST)
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
Subject: [PATCH v3 03/10] iommu/io-pgtable-arm: use page allocation function provided by iommu-pages.h
Date: Tue, 26 Dec 2023 20:01:58 +0000
Message-ID: <20231226200205.562565-4-pasha.tatashin@soleen.com>
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

Convert iommu/io-pgtable-arm.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 72dcdd468cf3..21d315151ad6 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -21,6 +21,7 @@
 #include <asm/barrier.h>
 
 #include "io-pgtable-arm.h"
+#include "iommu-pages.h"
 
 #define ARM_LPAE_MAX_ADDR_BITS		52
 #define ARM_LPAE_S2_MAX_CONCAT_PAGES	16
@@ -197,7 +198,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	void *pages;
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
-	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
+	p = __iommu_alloc_pages_node(dev_to_node(dev), gfp, order);
 	if (!p)
 		return NULL;
 
@@ -221,7 +222,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
 	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
 out_free:
-	__free_pages(p, order);
+	__iommu_free_pages(p, order);
 	return NULL;
 }
 
@@ -231,7 +232,7 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	if (!cfg->coherent_walk)
 		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
 				 size, DMA_TO_DEVICE);
-	free_pages((unsigned long)pages, get_order(size));
+	iommu_free_pages(pages, get_order(size));
 }
 
 static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
-- 
2.43.0.472.g3155946c3a-goog


